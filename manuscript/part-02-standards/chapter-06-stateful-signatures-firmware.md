# Chapter 6
# Stateful Signatures, Firmware, and Special Cases

---

Northfield Energy Systems' OT Security Director, James Whitfield, discovered the problem during a routine vendor maintenance window in November 2024. A firmware update for a gas compressor control unit — deployed across fourteen sites — was signed with a ten-year-validity ECDSA certificate chained to an internal root CA. The certificate was compliant. The signing algorithm was quantum-vulnerable. The device firmware store could accommodate the current certificate chain. It could not accommodate an ML-DSA-65 chain without hardware redesign.

James's team had three vendors in the OT firmware supply chain: the compressor manufacturer, a remote terminal unit supplier, and an engineering workstation software provider. Each used different signing architectures. Each assumed certificate profiles would remain ECDSA-sized for the device's operational lifetime — twenty to thirty years for field assets.

Northfield did not have a "firmware PQC problem" in the abstract. It had a **special-case signature strategy problem** requiring choices FIPS 204 and 205 do not resolve with default parameter sets alone. This chapter teaches those choices.

---

## 6.1 Why Firmware and Embedded Systems Are Special Cases

Part I established that PQC migration differs from prior transitions in parameter size, ecosystem scope, and hybrid complexity. Firmware and long-lived embedded systems amplify every difference:

| Factor | Enterprise IT (TLS, PKI) | Firmware / embedded / OT |
|--------|--------------------------|--------------------------|
| Replacement cycle | 3–7 years | 15–30+ years |
| Certificate store | Expandable (software) | Fixed hardware buffer |
| Signing frequency | High (continuous TLS) | Low (release events) |
| Stateful signature risk | Manageable with HSM | Catastrophic if index reused |
| Validation environment | FIPS 140-3 data centre HSM | Constrained MCU, air-gapped |
| Downtime tolerance | Maintenance windows | Operational continuity critical |

Firmware signing is a **blocking dependency** for OT estates (Chapter 1, Northfield). A compressor controller cannot accept new firmware until the signing chain migrates. The signing chain cannot migrate until the device accepts larger certificates or adopts a different signature scheme. The circular dependency resolves only through explicit signature strategy — not through default ML-DSA deployment assumptions.

Chapter 2 assigned firmware signing TES 5 for critical infrastructure. Chapter 4 noted ML-DSA size constraints. This chapter completes the analysis: **when to use ML-DSA, when to use SLH-DSA, and when to use stateful hash-based signatures under SP 800-208.**

---

## 6.2 NIST SP 800-208: Stateful Hash-Based Signatures

NIST Special Publication 800-208 specifies stateful hash-based signature schemes: **LMS** (Leighton-Micali Signature) and **XMSS** (eXtended Merkle Signature Scheme). Unlike ML-DSA and SLH-DSA, stateful schemes require the signer to maintain state — typically a one-time signature index that must never repeat.

### Stateful vs stateless

| Property | Stateless (ML-DSA, SLH-DSA) | Stateful (LMS, XMSS) |
|----------|----------------------------|----------------------|
| Signer state | None required | Index/nonce must be tracked |
| Key reuse safety | Designed for many signatures | **Index reuse breaks security** |
| Signature size | ML-DSA moderate; SLH-DSA large | LMS/XMSS compact relative to SLH-DSA |
| Operational burden | Standard HSM key ceremony | **Mandatory state synchronisation** |
| CNSA 2.0 status | ML-DSA, SLH-DSA approved | LMS for firmware signing (NSS context) |

Stateful schemes trade operational complexity for size efficiency — valuable when firmware stores cannot accommodate ML-DSA certificates and SLH-DSA signatures are too large for device verification budgets.

### The state management problem

A stateful signer maintains a counter of the next available one-time signature index. Signing increments the counter. **Signing twice with the same index destroys the security guarantee** for that key — and potentially compromises the entire key hierarchy depending on scheme parameters.

Operational requirements for stateful signing:

- **Authoritative state store** — hardware security module or dedicated signing appliance maintaining monotonic index
- **Backup and recovery** — state must survive disaster recovery without index regression
- **Dual-site synchronisation** — active-active signing sites must coordinate index allocation
- **Audit logging** — every signature event records index used
- **Air-gapped ceremony** — OT environments may require offline signing with physical state transfer

Northfield's engineering workstation vendor operated an air-gapped signing facility for OT releases. Introducing XMSS would require physical state media transfer between the air gap and production — a workflow redesign, not a library upgrade.

> **Dependency Alert**
>
> Stateful signatures are not "smaller ML-DSA." They are a **different operational class** requiring state management infrastructure. Deploying LMS/XMSS without state governance produces security failures worse than remaining on ECDSA until hardware refresh — because index reuse is silent until exploited.

---

## 6.3 CNSA 2.0 and Firmware Signing Requirements

CNSA 2.0 specifies post-quantum requirements for National Security Systems including firmware signing. For NSS contexts, ML-DSA-87, SLH-DSA, and LMS (per SP 800-208) appear in the approved suite. Firmware signing timelines align with CNSA milestones — PQC firmware signing required by 2030 for NSS platforms.

Commercial critical infrastructure operators like Northfield are not NSS — but **vendor supply chains** increasingly intersect NSS requirements. A compressor manufacturer serving both utility and defence customers may prioritise CNSA-aligned signing infrastructure. Northfield benefits indirectly from NSS-driven vendor investment while retaining flexibility in commercial algorithm choice.

**Architect's Decision:** For OT firmware signing where ML-DSA chains exceed device constraints and SLH-DSA verification exceeds device CPU budgets, **evaluate LMS under SP 800-208** with a dedicated state management architecture — do not default to ECDSA extension without documented risk acceptance and hardware refresh linkage. For new NSS-adjacent programmes, align with CNSA 2.0 firmware signing requirements from programme inception.

---

## 6.4 Signature Scheme Selection Matrix

Enterprises need a decision matrix — not per-device ad hoc choices. The following matrix guides firmware, embedded, and special-case signing.

**Table 6.1 — Signature Scheme Selection Matrix**

| Scenario | Preferred | Alternative | Avoid |
|----------|-----------|-------------|-------|
| General enterprise code signing (servers) | ML-DSA-65 | SLH-DSA (diversity policy) | ECDSA post-deprecation without exception |
| Root CA / long-trust anchor | ML-DSA-87 | SLH-DSA | ML-DSA-44 (insufficient margin) |
| NSS firmware signing | ML-DSA-87, LMS per CNSA | SLH-DSA | Classical beyond policy sunset |
| OT device with fixed cert store (<8 KB) | LMS/XMSS (SP 800-208) | Hardware refresh + ML-DSA | ML-DSA forcing into undersized store |
| OT device with moderate store | ML-DSA-65 after profile redesign | LMS/XMSS | SLH-DSA (verification cost) |
| High-volume API signing | ML-DSA-65 | — | SLH-DSA (latency) |
| Air-gapped release signing | LMS with offline state ceremony | ML-DSA if HSM supports | Stateful scheme without state audit trail |
| Immutable infrastructure (containers) | ML-DSA-65 dual signature (H1) | — | Classical-only post-deprecation |

The matrix feeds CBOM `signature_scheme` attributes and procurement specifications. Vendors receive scheme requirements per device class — not generic "PQC support" language.

**Figure 6.1 — Firmware Signing Architecture with PQC Insertion Points**

```
[Enterprise CA] ----signs----> [Firmware signing cert]
                                      |
                                      v
[Signing HSM / LMS state store] ----signs----> [Firmware image]
         |                                           |
         | (state index for LMS/XMSS)                v
         v                                    [Device verification]
[Audit log / state backup]                          |
                                                    v
                                              [Flash / eMMC store]
                                              (fixed size constraint)
```

Insertion points for PQC migration:

1. **Enterprise CA** — migrate issuing CA to ML-DSA-87 or maintain classical intermediate with PQC leaf (transitional)
2. **Signing service** — deploy HSM with ML-DSA support OR LMS state management
3. **Firmware packaging** — dual-signature H1 during transition
4. **Device verification** — root trust store update; verification code update
5. **Storage** — certificate chain accommodation or LMS compact chain

---

## 6.5 ML-DSA for Code and Firmware Signing

ML-DSA is the default enterprise signature scheme (Chapter 4). For firmware, ML-DSA applies when:

- Device certificate store accommodates ML-DSA public keys and signatures (profile assessment required)
- Verification CPU meets ML-DSA verification budget (benchmark on target hardware)
- Signing HSM or service supports FIPS-validated ML-DSA with appropriate key ceremony
- Certificate validity periods align with ML-DSA trust horizon analysis (Chapter 2)

### Dual-signature transition (H1)

Firmware H1 migration may carry **dual signatures**: classical ECDSA plus ML-DSA over the same image. Devices with updated verification code validate ML-DSA; legacy devices validate ECDSA during transition. Dual signing increases image size — another fixed-buffer constraint to assess.

Northfield's remote terminal unit supplier proposed dual signing as a bridge through 2028 device refresh. Units refreshed after 2028 would ship with ML-DSA-only verification. Units in field until 2032 would accept dual-signed images. The programme documented H2 trigger: no new dual-signed releases after 2030; ECDSA verification removed from refreshed hardware profiles.

### When ML-DSA fails feasibility

ML-DSA fails feasibility when certificate chain size exceeds device storage **and** hardware refresh is more than five years away **and** SLH-DSA verification exceeds CPU budget. This trifecta — common in OT — routes to LMS/XMSS evaluation or compensating controls (network segmentation, accelerated refresh funding).

---

## 6.6 SLH-DSA in Constrained Environments

SLH-DSA offers conservative security assumptions but large signatures and slow verification. In firmware contexts, SLH-DSA suits:

- **Signing side only** — server-side firmware signing where verification happens on capable engineering workstations, not on constrained devices
- **Archive signing** — long-term firmware image archives where signature size is secondary to diversity requirements
- **NSS diversity** — alongside ML-DSA where CNSA requires algorithmic diversity

SLH-DSA is a poor fit for **on-device verification** in MCU-class OT controllers. Northfield benchmarked SLH-DSA verification on a representative RTU: verification time exceeded the vendor's maintenance window budget by a factor of twelve.

---

## 6.7 LMS and XMSS Operational Design

When LMS or XMSS is selected, operational design precedes deployment.

### Key hierarchy

LMS supports multi-level Merkle trees — signing keys derived from hierarchy levels. XMSS provides single-tree constructions with parameter choices affecting signature count and size. Parameter selection is **finite**: an LMS key signs a maximum number of times. Exceeding the budget requires key rotation — planned in advance, not reactive.

### State store architecture

| Architecture | Use case | Risk |
|--------------|----------|------|
| HSM-monotonic counter | Data centre signing | HSM failure without state backup |
| Dedicated signing appliance | OT vendor release signing | Appliance availability |
| Air-gapped offline state | High-assurance OT | Physical media transfer errors |
| Distributed with leader election | Active-active signing | Split-brain index allocation |

Northfield selected a dedicated signing appliance for its engineering workstation vendor's releases — with geographic redundancy and automated state replication. Air-gapped backup used quarterly physical state export to tamper-evident storage.

### Disaster recovery

State backup must guarantee **monotonic index** after recovery. Restoring yesterday's backup and signing today may reuse indices. DR testing for stateful signing includes index continuity validation — not only key material recovery.

### Personnel and process

Stateful signing requires operators who understand index semantics. Training programmes cover: never clone signing appliances without state sync; never restore state without index verification; never bypass HSM for "emergency" signing without programme office approval.

---

## 6.8 Northfield Energy: Three-Vendor Firmware Chain

Northfield's programme addressed each vendor independently — unified strategy, vendor-specific execution.

**Table 6.2 — Northfield OT Firmware Signing Programme**

| Vendor | Device class | Constraint | Selected scheme | Timeline |
|--------|-------------|------------|---------------|----------|
| Compressor manufacturer | Field controller | 4 KB cert store | LMS (SP 800-208) | HSM state store 2026; pilot 2027 |
| RTU supplier | Remote terminal | 8 KB store; CPU limit | ML-DSA-65 dual-sign H1 | Dual 2026–2028; ML-DSA-only new units 2028+ |
| Engineering workstation | Release signing tool | Workstation-class | ML-DSA-65 | 2026 signing service upgrade |

### Compressor manufacturer: LMS path

The 4 KB certificate store could not accommodate ML-DSA-65 leaf certificates with required intermediate chain. Hardware refresh for fourteen sites was budgeted at **$4.2 million** (*illustrative*) over 2029–2033 — unacceptable as the sole path. LMS provided compact signatures fitting existing stores with firmware verification updates.

Programme risk: state management for vendor-controlled signing. Northfield required contractual access to LMS state audit logs and DR test participation — supply chain governance (Chapter 17) applied to signing infrastructure.

### RTU supplier: dual-signature bridge

The RTU's 8 KB store accommodated ML-DSA-65 chains with profile compression (single intermediate, shortened validity). Dual signing bridged field units until refresh. Northfield's TRADE analysis elevated RTU firmware to Wave 1 — nation-state firmware forgery threat (Chapter 2).

### Engineering workstation: ML-DSA signing service

Workstation-class hardware supported ML-DSA without special-case schemes. Migration focused on signing service upgrade and air-gapped workflow update — replacing ECDSA ceremony with ML-DSA key generation in the existing FIPS HSM.

### Programme integration

All three vendors fed Northfield's **single CBOM** with `firmware_signing_scheme` attributes. James Whitfield's OT security team met monthly with enterprise PKI (Chapter 12 coordination) and procurement (Chapter 17) — firmware signing is not an OT-only workstream.

> **Migration Moment**
>
> *"We'll upgrade OT hardware when PQC is ready."*
>
> OT hardware refresh cycles exceed 2035 disallowance anchors. Programmes that defer firmware signature strategy until hardware refresh will operate quantum-vulnerable signing chains on field devices through the entire deprecation period — acceptable only with documented risk acceptance, compensating controls, and supervisory alignment. Special-case signature strategy cannot be deferred to the refresh cycle without explicit governance.

---

## 6.9 Air-Gapped and Offline Signing Workflows

Critical infrastructure and defence environments frequently require air-gapped signing — firmware images transferred physically between isolated networks. PQC migration complicates air-gapped workflows beyond algorithm substitution.

### Classical air-gap pattern

Engineering workstation on isolated network signs firmware with HSM attached locally. Signed image transferred via removable media to operations network. Certificate chain validated against pre-distributed trust anchor.

### PQC air-gap complications

- **ML-DSA key ceremony** may require larger HSM form factors or updated firmware on offline HSMs
- **LMS state** must transfer with signed image metadata — index recorded on physical manifest accompanying media
- **Dual-signature H1** doubles media transfer size — may exceed removable media policies sized for classical images
- **Trust anchor updates** for ML-DSA roots require separate secure distribution before signed images verify

Northfield's engineering workstation vendor redesigned the air-gap manifest to include LMS index, parameter set identifier, and signing timestamp in human-readable and machine-readable formats — reducing index transcription errors during physical transfer.

### Process controls

Air-gapped PQC signing requires updated standard operating procedures:

1. Pre-signing state verification (LMS index matches authoritative log)
2. Post-signing state reconciliation (index incremented exactly once)
3. Media integrity verification before operations network insertion
4. Independent witness for state-changing ceremonies (two-person rule)

Treat air-gap workflow redesign as a **programme workstream** with OT operations ownership — not a cryptographic engineering side task.

---

## 6.10 Sector Overlay: OT Firmware (SOM Preview)

The Sector Overlay Matrix (Part VI) modifies TRADE weights and HLM timelines for energy and critical infrastructure. OT firmware preview:

| SOM parameter | OT / energy modification |
|---------------|--------------------------|
| TRADE Threat weight | Firmware signing TES 5 floor |
| TRADE Regulatory weight | NERC CIP, TSA evidence tags |
| HLM H1 duration | Extended — dual signing through refresh cycles |
| Exception maximum | Shorter renewal — 6 months for TES 5 firmware |
| Validation requirement | OT operational test bed mandatory before field push |

Chapter 19 develops the energy sector playbook in full. Firmware signing strategy is the OT programme's critical path — not external TLS.

---

## 6.11 Supply Chain and Vendor Contracting

Firmware signing migration requires vendor cooperation. Contract clauses should specify:

- Algorithm migration obligation by date or device generation
- Acceptance of Northfield/enterprise signing certificate profiles (ML-DSA or LMS)
- State audit access for stateful schemes
- Test hardware for verification benchmarking
- Liability for index management failures (stateful schemes)

Northfield's compressor vendor contract amendment included LMS state audit rights — a clause the vendor had never seen from a utility customer. James's team shared the programme's LMS operational design document to accelerate vendor legal review.

---

## 6.12 Relationship to Part IV Architecture Chapters

This chapter establishes **what** signature schemes apply in special cases. Part IV develops **how** to implement them:

- **Chapter 12 (PKI)** — certificate profile design for ML-DSA chains; root migration sequencing
- **Chapter 13 (Key Management)** — HSM partitioning for ML-KEM and ML-DSA; LMS state stores
- **Chapter 14 (Agility)** — algorithm substitution without firmware redeployment where agility was designed in
- **Chapter 18 (Validation)** — OT test bed methodology; firmware signing verification test cases

Readers should not implement firmware signing changes without cross-referencing Part IV validation requirements. A correct scheme choice with inadequate operational testing produces field failures — operational continuity risk for critical infrastructure.

---

## 6.13 Apex Defense: Classified and Unclassified Boundaries

Apex Defense Technologies encounters firmware signing across classified and unclassified boundaries. NSS programmes follow CNSA 2.0 without scheme flexibility. Unclassified OT-adjacent systems may use commercial patterns from this chapter.

Apex's boundary policy:

- **Classified NSS firmware** — CNSA 2.0 suite; LMS per SP 800-208 where mandated; no commercial algorithm downgrade
- **Unclassified manufacturing OT** — enterprise matrix (Chapter 4) with LMS or ML-DSA per device assessment
- **Cross-domain transfer** — firmware images crossing classification boundaries require separate signing chains; PQC migration planned per domain, not assumed portable

Priya Nair's architecture board reviews firmware signing proposals against both CNSA and enterprise matrices — preventing commercial subsidiaries from accidentally adopting schemes that fail NSS audit.

---

## 6.14 LMS and XMSS Parameter Selection

Selecting LMS or XMSS parameters is a capacity planning exercise — not a security dial turned to maximum.

### LMS parameters

LMS uses hierarchical trees. Key parameters include:

- Tree height — determines maximum signature count (2^h)
- Winternitz parameter — trades signature size against hash operations
- Number of levels — multi-level trees extend signature capacity

**Architect's Decision:** Size LMS parameters to **planned firmware release count over key lifetime plus margin** — typically 30–50% headroom. Oversized trees waste storage; undersized trees force emergency key rotation mid-programme.

### XMSS parameters

XMSS parameter sets define hash function, tree height, and Winternitz parameter. NIST SP 800-208 specifies approved combinations. Selection mirrors LMS logic: signature count budget, signature size, verification cost on target hardware.

### Benchmarking requirement

Before committing to LMS/XMSS for OT devices, benchmark **on representative hardware**:

- Signature verification time (worst-case cold start)
- Certificate chain storage bytes
- Firmware image size increase for dual-signature H1

Northfield's compressor vendor benchmarked three XMSS parameter sets on field hardware. The selected set verified in 340 ms — within the 500 ms maintenance window budget. A more conservative parameter set required 1.2 seconds — rejected despite larger security margin.

---

## 6.15 Testing and Validation for Firmware Signing

Firmware signing migration fails catastrophically when validation is inadequate. OT programmes require test regimes beyond cryptographic unit tests.

### Test categories

| Category | Purpose | Environment |
|----------|---------|-------------|
| Cryptographic correctness | Signature verifies on device | Lab hardware |
| Chain validation | Full cert chain accepted | Lab + staging |
| Rollback safety | Previous firmware still boots if needed | Staging |
| Operational continuity | Signing does not exceed maintenance window | Production-like timing |
| DR state continuity | LMS index monotonic after state restore | Signing facility |
| Negative testing | Rejected signature on tampered image | Lab |

### Staged rollout pattern

1. **Lab** — vendor development hardware; full test suite
2. **Staging site** — single non-production field site; operational staff observe
3. **Canary site** — one production site with enhanced monitoring
4. **Regional rollout** — phased by geography or asset class
5. **Full deployment** — with rollback procedure validated at each prior stage

Northfield required compressor vendor to complete stages 1–3 before Northfield security approved stage 4. Canary deployment ran thirty days with enhanced firmware integrity monitoring — detecting a certificate chain ordering bug that lab tests missed because lab devices used shorter chains.

### Validation evidence for regulators

NERC CIP and TSA reporting expect evidence that firmware integrity controls maintain effectiveness after cryptographic changes. Test reports, signed approval records, and rollback procedures form the Assurance layer evidence package (Chapter 3) for OT firmware migration.

---

## 6.16 GlobalSync: Container Image Signing

Not all firmware is OT. GlobalSync Logistics signs container images for its SaaS platform — a software supply chain context with different constraints than Northfield's field controllers.

GlobalSync's container signing programme:

- **Scheme:** ML-DSA-65 via cloud HSM — workstation-class infrastructure; no LMS requirement
- **H1:** Dual signature (ECDSA + ML-DSA) during 2026–2027 registry client transition
- **H2 trigger:** 90% of internal deployment pipelines verify ML-DSA — measured from CI/CD logs
- **Constraint:** Container registry size limits — marginal increase accommodated without redesign
- **Tenant visibility:** Security whitepaper updated with ML-DSA container signing statement

GlobalSync's OT lesson equivalent: **registry clients** were the ecosystem gate — not the signing service. Three legacy deployment agents required updates before ML-DSA verification propagated. CDG analysis (preview, Chapter 8) identified registry clients as blocking nodes for 200+ microservices — the same synchronization pattern as Northfield's vendors in a cloud-native guise.

---

## 6.17 Smart Cards, Tokens, and Physical Form Factors

Physical authentication tokens and smart cards amplify ML-DSA size constraints:

- Fixed secure element storage for certificates and keys
- Limited CPU for verification during authentication ceremonies
- Long token deployment lifetimes (3–5 years) delaying refresh opportunities

Enterprises with smart card authentication programmes should inventory token models and secure element capacity **before** PKI root migration to ML-DSA. Tokens unable to store ML-DSA certificate chains may require phased token refresh — a capital expenditure line item often absent from PQC software budgets.

Meridian's physical token programme added **€1.4 million** (*illustrative*) token refresh to the PQC programme budget when ML-DSA chain sizing exceeded current secure element capacity — discovered during algorithm standards workshop certificate profile exercise (Chapter 4), not during TLS pilot.

---

## 6.18 Compensating Controls When Migration Is Gated

When firmware or embedded migration cannot complete before deprecation anchors, compensating controls reduce risk without pretending migration is complete:

| Control | Risk reduced | Limitation |
|---------|--------------|------------|
| Network segmentation | HNDL collection paths | Does not prevent forgery |
| Firmware integrity monitoring | Unauthorized image detection | Requires baseline after legitimate signing |
| Accelerated hardware refresh | Shortens classical exposure window | Capital cost |
| Air-gapped signing ceremony | Supply chain compromise | Operational burden |
| Reduced firmware release frequency | Fewer signing events | Security patch velocity |

Compensating controls require **risk acceptance documentation** with supervisory-appropriate justification — not informal operational workarounds. Northfield's TSA reporting included compensating control descriptions for compressor controllers pending LMS deployment — honest gap documentation (Chapter 1) applied to OT.

---

## 6.19 Apply in Your Organisation

1. **Classify firmware assets in CBOM** with cert store size, verification CPU, and signing vendor — flag special-case candidates before defaulting to ML-DSA.
2. **Apply Table 6.1** consistently — document scheme per device class in cryptography policy.
3. **If selecting LMS/XMSS**, complete state management design before any pilot — state store, DR, audit, training.
4. **Contract vendor signing obligations** — algorithm timeline, audit rights, test hardware.
5. **Integrate OT firmware signing with enterprise PKI programme** — not a parallel OT science project.

---

## 6.20 Chapter Summary

- Firmware and embedded systems require special-case signature strategy — ML-DSA defaults do not always fit fixed stores and CPU budgets.
- SP 800-208 stateful schemes (LMS, XMSS) offer compact signatures with mandatory state management — index reuse is catastrophic.
- CNSA 2.0 drives NSS firmware signing timelines; commercial OT may leverage vendor NSS investment.
- Signature selection matrix: ML-DSA for general and feasible firmware; LMS/XMSS for constrained stores; SLH-DSA for diversity and archive contexts — rarely on-device OT verification.
- H1 dual-signature bridges field devices through refresh cycles; H2 triggers mandatory.
- Northfield's three-vendor case demonstrates unified strategy with vendor-specific execution.
- Firmware signing is a supply chain, PKI, and validation programme — not an OT-only upgrade.

**Next:** Part III shifts from standards literacy to estate knowledge — cryptographic discovery, the Cryptographic Bill of Materials, and the Cryptographic Dependency Graph.

---

*Chapter 6 — References*

- National Institute of Standards and Technology. (2020). NIST SP 800-208: Recommendation for stateful hash-based signature schemes. https://doi.org/10.6028/NIST.SP.800-208
- National Institute of Standards and Technology. (2024). FIPS 204: Module-lattice-based digital signature standard. https://doi.org/10.6028/NIST.FIPS.204
- National Institute of Standards and Technology. (2024). FIPS 205: Stateless hash-based digital signature standard. https://doi.org/10.6028/NIST.FIPS.205
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- IEC 62443 (all parts). Security for industrial automation and control systems. International Electrotechnical Commission.
- Cybersecurity and Infrastructure Security Agency. (2024). Post-quantum cryptography initiative. https://www.cisa.gov/quantum
