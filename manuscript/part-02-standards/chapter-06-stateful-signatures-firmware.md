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

> **Architect's Decision**
>
> For OT firmware signing where ML-DSA chains exceed device constraints and SLH-DSA verification exceeds device CPU budgets, **evaluate LMS under SP 800-208** with a dedicated state management architecture — do not default to ECDSA extension without documented risk acceptance and hardware refresh linkage. For new NSS-adjacent programmes, align with CNSA 2.0 firmware signing requirements from programme inception.

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
| OT device with moderate store | ML-DSA-65 after profile redesign* | LMS/XMSS | SLH-DSA (verification cost) |

*Profile compression — single intermediate CA, shortened validity — sometimes enables ML-DSA on 8 KB stores. Benchmark on target hardware before assuming fit.
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

When LMS or XMSS is selected, operational design precedes deployment. Stateful signing is where **cryptographic engineering meets operations engineering** — failures are operational, not mathematical.

### Catastrophic failure scenarios

| Failure | Cause | Impact | Prevention |
|---------|-------|--------|------------|
| Index reuse | DR restore to stale backup | Forgery or repudiation break | Monotonic index verification on every sign |
| Split-brain signing | Dual appliances without coordination | Duplicate index use | Leader election or partitioned index ranges |
| Index exhaustion | Undersized tree height | Emergency key rotation | Capacity planning (§6.15) |
| Lost state media | Air-gap transfer error | Cannot sign next release | Redundant state backup; ceremony checklist |
| Unsigned emergency patch | Bypass state store under pressure | Policy violation + potential index gap | Pre-approved break-glass with post-incident audit |

Northfield's programme treated index reuse as **Severity 1** — equivalent to private key compromise in incident classification. Playbooks required immediate suspension of signing operations, stakeholder notification, and key hierarchy review before resumption.

### Disaster recovery and state continuity

DR testing for stateful signing must verify **index monotonicity**, not only key material availability:

1. Simulate primary signing appliance failure during active release cycle
2. Fail over to secondary appliance with replicated state
3. Attempt signature on secondary — verify index matches expected sequence
4. Restore primary from backup taken before failover — verify restored index is **behind** active secondary (never promote stale primary without state reconciliation)
5. Document results in Assurance layer evidence package

Quarterly DR tests were contractual for Northfield's compressor vendor LMS deployment. Apex required similar tests for NSS firmware signing — classified environments added physical escort requirements for state media.

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

### Vendor negotiation patterns

Northfield's three vendors responded differently to PQC signing requirements — a pattern repeated across critical infrastructure programmes:

**Compressor manufacturer (LMS path).** Initial response: hardware refresh required, **$4.2 million** (*illustrative*), 48-month lead time. Counter-proposal: LMS with firmware verification update only — **$1.1 million**, 18-month delivery. Vendor had parallel NSS programme funding LMS tooling; marginal cost to Northfield was engineering integration, not greenfield cryptography development. Contract amendment included LMS state audit rights and Northfield observer access during DR tests.

**RTU supplier (dual-sign path).** Proposed ECDSA-only extension through 2032. Northfield rejected without risk acceptance documentation. Agreed dual-sign H1 with ML-DSA-only new units from 2028 production lot. Vendor required six-month test window — staged rollout pattern in §6.16 applied.

**Engineering workstation vendor (ML-DSA path).** Fastest path — workstation-class HSM already in air-gapped facility. Migration cost was ceremony redesign and staff training, not cryptography development. Bottleneck was air-gap state transfer policy, not algorithm choice.

The negotiation lesson: **vendor responses are not technical facts.** They reflect vendor roadmap priorities, NSS contract pressure, and customer negotiation posture. Programmes that accept first vendor "impossible" assessments without benchmarking alternatives overpay for hardware refresh.

### IEC 62443 and OT security lifecycle

IEC 62443 defines security lifecycles for industrial automation and control systems. PQC firmware signing intersects:

- **Security patch management (62443-2-3)** — signed firmware delivery processes
- **Component security (62443-4-2)** — embedded device secure boot and certificate stores
- **System integration (62443-3-3)** — verification of signed updates in operational context

Northfield mapped LMS and ML-DSA migration evidence to existing 62443 documentation slots — avoiding parallel OT security frameworks. OT security assessors received algorithm migration as **integrity control evolution**, not a new security programme.

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

### Worked example: air-gap manifest (Northfield)

Northfield's engineering workstation vendor adopted a tamper-evident manifest accompanying each signed firmware image crossing the air gap:

| Manifest field | Example value | Purpose |
|----------------|---------------|---------|
| Image hash | SHA-256 of firmware binary | Integrity verification |
| Signature scheme | LMS (SP 800-208) set identifier | Algorithm traceability |
| LMS index | 0x00001A2F | State monotonicity verification |
| Signing timestamp | ISO 8601 UTC | Audit trail |
| Signer identity | HSM certificate DN | Non-repudiation |
| Previous index | 0x00001A2E | Continuity check on receipt |

Operations staff verify index continuity before loading media to the operations network. A gap in index sequence triggers incident response — treated as seriously as a failed signature verification, because index gaps may indicate state desynchronisation or signing appliance compromise.

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

## 6.13 Meridian Mutual Bank: Payment HSM Firmware Signing

Meridian's Chapter 1 blocking dependency — payment HSM firmware signing — belongs in the firmware special-case analysis even though the device is a financial-grade HSM, not an OT field controller. The constraints differ; the signature strategy question is the same: **can the device accept the enterprise's chosen PQC scheme?**

Meridian's assessment:

| Factor | Meridian payment HSM | Programme response |
|--------|---------------------|-------------------|
| Cert/signature store | HSM firmware-limited | Vendor-dependent ML-DSA support |
| Validation | FIPS 140-3 Level 3 payment | Procurement mandate; no software bypass |
| Signing frequency | Low (firmware releases) | Aligned with vendor release cadence |
| Blocking impact | Twelve downstream databases | CDG blocking node; MPI 4.39 |
| Timeline | Vendor GA estimated 18+ months | Parallel key ceremony redesign |

Meridian did not route payment HSM to LMS — the HSM vendor committed to ML-DSA-87 in FIPS-validated firmware, satisfying PCI and DORA evidence requirements without stateful signature operational complexity. The programme lesson: **special-case analysis is per device class**, not per sector label. Financial HSMs may follow standard ML-DSA paths while adjacent OT devices on the same estate require LMS.

Elena Vasquez's team linked the HSM firmware row in the algorithm standards matrix (Chapter 4, Table 4.7) directly to the firmware signing row in Chapter 6's selection matrix — one asset, two chapter perspectives, single CBOM entry.

> **Regulatory Lens**
>
> **DORA and PCI expect firmware integrity for payment systems** — not merely TLS on channels. Supervisory reviewers examining Meridian's encryption policy asked for firmware signing migration evidence alongside certificate register entries. Payment HSM firmware is a regulatory surface, not only a vendor dependency.

---

## 6.14 Apex Defense: Classified and Unclassified Boundaries

Apex Defense Technologies encounters firmware signing across classified and unclassified boundaries — the most stringent special-case environment in the teaching organisations. NSS programmes follow CNSA 2.0 without scheme flexibility. Unclassified OT-adjacent systems may use commercial patterns from this chapter.

Apex's boundary policy:

- **Classified NSS firmware** — CNSA 2.0 suite; LMS per SP 800-208 where mandated; no commercial algorithm downgrade
- **Unclassified manufacturing OT** — enterprise matrix (Chapter 4) with LMS or ML-DSA per device assessment
- **Cross-domain transfer** — firmware images crossing classification boundaries require separate signing chains; PQC migration planned per domain, not assumed portable

Priya Nair's architecture board reviews firmware signing proposals against both CNSA and enterprise matrices — preventing commercial subsidiaries from accidentally adopting schemes that fail NSS audit.

### Personnel and clearance considerations

Classified firmware signing ceremonies may restrict which staff witness LMS state transfers or ML-DSA key generation. Apex's programme HR plan identified **certified ceremony roles** 18 months ahead of CNSA 2030 firmware milestones — clearance processing could not be accelerated after vendor delivery. Programmes treating personnel as unlimited resource fail on classified boundaries.

Unclassified subsidiaries without clearance constraints still inherited **export control** review for cryptographic implementations sourced from NSS programmes — legal review of LMS tooling transfer between divisions added three months to one subsidiary's OT pilot.

---

## 6.15 LMS and XMSS Parameter Selection

Selecting LMS or XMSS parameters is a capacity planning exercise — not a security dial turned to maximum.

### LMS parameters

LMS uses hierarchical trees. Key parameters include:

- Tree height — determines maximum signature count (2^h)
- Winternitz parameter — trades signature size against hash operations
- Number of levels — multi-level trees extend signature capacity

> **Architect's Decision**
>
> Size LMS parameters to **planned firmware release count over key lifetime plus margin** — typically 30–50% headroom. Oversized trees waste storage; undersized trees force emergency key rotation mid-programme.

### XMSS parameters

XMSS parameter sets define hash function, tree height, and Winternitz parameter. NIST SP 800-208 specifies approved combinations. Selection mirrors LMS logic: signature count budget, signature size, verification cost on target hardware.

### Benchmarking requirement

Before committing to LMS/XMSS for OT devices, benchmark **on representative hardware**:

- Signature verification time (worst-case cold start)
- Certificate chain storage bytes
- Firmware image size increase for dual-signature H1

Northfield's compressor vendor benchmarked three XMSS parameter sets on field hardware. The selected set verified in 340 ms — within the 500 ms maintenance window budget. A more conservative parameter set required 1.2 seconds — rejected despite larger security margin.

---

## 6.16 Testing and Validation for Firmware Signing

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

### Rollback architecture

Firmware PQC migration must assume **failed upgrades**. Rollback design precedes rollout:

| Scenario | Rollback strategy | Preconditions |
|----------|-------------------|---------------|
| Dual-sign H1 | Device accepts classical signature; revert to classical-only image | Classical trust anchor retained during H1 |
| ML-DSA-only new units | Factory reflash with classical image (if stock available) | Stock management for pre-migration images |
| LMS migration | Revert to last classical-signed image | Classical signing key retained until H3 |
| Payment HSM | Vendor-defined downgrade path; may be **unavailable** | Contractual downgrade requirement before migration |

Northfield's RTU programme retained classical root trust anchor for **24 months** after dual-sign H1 began — enabling rollback without emergency key ceremony. Compressor LMS path had **no cryptographic rollback** after classical key destruction — making staged rollout and canary period non-negotiable.

Meridian's payment HSM vendor contract required documented downgrade procedure before production ML-DSA firmware — vendor initially claimed downgrade was "not applicable." Legal review made it a contract condition; vendor delivered procedure in month four of negotiation.

### Field technician playbook

OT migration fails when field staff receive cryptographic theory instead of procedures. Northfield's playbook pages covered:

- Visual verification of manifest fields (§6.9)
- When to abort installation (index gap, signature verify fail)
- Escalation contact and SLA
- Explicit **do not bypass** signature verification steps under maintenance pressure

Playbooks were validated in staging with actual maintenance crews — not security analysts. Three playbook revisions followed staging feedback before canary approval.

### Validation evidence for regulators

NERC CIP and TSA reporting expect evidence that firmware integrity controls maintain effectiveness after cryptographic changes. Test reports, signed approval records, and rollback procedures form the Assurance layer evidence package (Chapter 3) for OT firmware migration.

> **Regulatory Lens**
>
> **NERC CIP-010 and TSA Security Directives** do not name ML-DSA or LMS. They require demonstrable firmware integrity and change control. Northfield's evidence package maps PQC migration test results to existing CIP documentation structures — substituting algorithm names in test reports while preserving control objective language. Regulators and auditors review **control effectiveness**, not lattice parameters.

**Production brief — Figure 6.1:** Layered diagram from Enterprise CA through signing HSM/LMS state store to device flash. Highlight five insertion points with numbered callouts matching §6.4 text. Include optional dual-signature H1 branch.

### LMS parameter worked example (Northfield compressor)

Northfield and the compressor vendor sized LMS parameters for:

- Planned firmware releases: 2 per year × 15 years = 30 releases
- Headroom: 50% → 45 signature capacity minimum
- Selected tree height: h = 6 (64 leaves); Winternitz parameter w = 8 per SP 800-208 approved set
- Verification benchmark: 340 ms on field hardware (budget 500 ms)
- State store: dedicated appliance with geographic replication; quarterly DR test including index monotonicity check

Document parameter rationale in the cryptography policy annex — auditors asking "why this LMS configuration?" receive capacity planning evidence, not ad hoc vendor defaults.

---

## 6.17 GlobalSync: Container Image Signing

Not all firmware is OT. GlobalSync Logistics signs container images for its SaaS platform — a software supply chain context with different constraints than Northfield's field controllers.

GlobalSync's container signing programme:

- **Scheme:** ML-DSA-65 via cloud HSM — workstation-class infrastructure; no LMS requirement
- **H1:** Dual signature (ECDSA + ML-DSA) during 2026–2027 registry client transition
- **H2 trigger:** 90% of internal deployment pipelines verify ML-DSA — measured from CI/CD logs
- **Constraint:** Container registry size limits — marginal increase accommodated without redesign
- **Tenant visibility:** Security whitepaper updated with ML-DSA container signing statement

GlobalSync's OT lesson equivalent: **registry clients** were the ecosystem gate — not the signing service. Three legacy deployment agents required updates before ML-DSA verification propagated. CDG analysis (preview, Chapter 8) identified registry clients as blocking nodes for 200+ microservices — the same synchronisation pattern as Northfield's vendors in a cloud-native guise.

### Container signing HLM assignment

GlobalSync assigned container image signing to HLM phases per deployment tier:

| Tier | HLM phase (2026) | H2 trigger | Notes |
|------|------------------|------------|-------|
| Internal CI/CD images | H1 dual-sign | 90% pipeline agents verify ML-DSA | Measured from build logs |
| Customer-facing SaaS releases | H1 dual-sign | Same + tenant notification complete | Contractual notice period |
| Legacy on-prem agent bundles | H1 classical + risk acceptance | Agent EOL 2028 | Exception register |

Marcus Chen's team rejected a programme proposal to declare container signing "PQC complete" after the cloud HSM supported ML-DSA — ecosystem readiness (deployment agents) gated H1 exit, matching the synchronisation thesis from Part I.

---

## 6.18 Smart Cards, Tokens, and Physical Form Factors

Physical authentication tokens and smart cards amplify ML-DSA size constraints:

- Fixed secure element storage for certificates and keys
- Limited CPU for verification during authentication ceremonies
- Long token deployment lifetimes (3–5 years) delaying refresh opportunities

Enterprises with smart card authentication programmes should inventory token models and secure element capacity **before** PKI root migration to ML-DSA. Tokens unable to store ML-DSA certificate chains may require phased token refresh — a capital expenditure line item often absent from PQC software budgets.

Meridian's physical token programme added **€1.4 million** (*illustrative*) token refresh to the PQC programme budget when ML-DSA chain sizing exceeded current secure element capacity — discovered during algorithm standards workshop certificate profile exercise (Chapter 4), not during TLS pilot.

### Token refresh sequencing

Physical token migration cannot occur atomically across thousands of employees. Meridian sequenced:

1. **Pilot** — 200 users; ML-DSA-capable token model; helpdesk playbook
2. **High-privilege cohort** — administrators and payment operations; Q2 2027
3. **General rollout** — branch staff; aligned with natural token renewal cycles
4. **Decommission** — classical-only tokens prohibited after cohort migration

PKI certificate profiles for ML-DSA were published **before** token hardware procurement — avoiding the reverse sequencing that produced Northfield's early certificate-store surprises in OT.

Apex Defense Technologies faced a parallel challenge with CAC/PIV-adjacent form factors for NSS personnel — CNSA 2.0 parameter requirements elevated to ML-DSA-87, tightening size constraints further. Apex's matrix row for physical tokens explicitly referenced secure element capacity tests as a procurement gate.

---

## 6.19 Compensating Controls When Migration Is Gated

When firmware or embedded migration cannot complete before deprecation anchors, compensating controls reduce risk without pretending migration is complete:

| Control | Risk reduced | Limitation |
|---------|--------------|------------|
| Network segmentation | HNDL collection paths | Does not prevent forgery |
| Firmware integrity monitoring | Unauthorised image detection | Requires baseline after legitimate signing |
| Accelerated hardware refresh | Shortens classical exposure window | Capital cost |
| Air-gapped signing ceremony | Supply chain compromise | Operational burden |
| Reduced firmware release frequency | Fewer signing events | Security patch velocity |

Compensating controls require **risk acceptance documentation** with supervisory-appropriate justification — not informal operational workarounds. Northfield's TSA reporting included compensating control descriptions for compressor controllers pending LMS deployment — honest gap documentation (Chapter 1) applied to OT.

---

## 6.20 Cloud-Native vs OT: Comparative Programme Patterns

Firmware signing challenges appear in both OT and cloud — with different constraints and faster iteration in cloud.

**Table 6.3 — Northfield OT vs GlobalSync Cloud Signing**

| Dimension | Northfield (OT firmware) | GlobalSync (container images) |
|-----------|--------------------------|-------------------------------|
| Device lifetime | 15–30 years | Minutes to hours (ephemeral) |
| Size constraint | Fixed flash (4–8 KB certs) | Registry/config limits |
| Signature scheme | LMS + ML-DSA dual-sign | ML-DSA dual-sign H1 |
| Stateful signing | Yes (LMS) | No |
| Rollback | Field technician; days | Automated; seconds |
| Ecosystem gate | Vendor engineering cycles | Deployment agent versions |
| Regulatory surface | NERC CIP, TSA | SOC 2, customer contracts |
| Programme owner | OT security + PKI | Platform engineering |

The comparison teaches **pattern transfer, not solution copy**. GlobalSync cannot use Northfield's LMS path — no state constraint benefit. Northfield cannot match GlobalSync's deployment velocity — staged field rollout is mandatory. Both require signature strategy decisions before production claims.

---

## 6.21 Firmware Signing Programme Charter Elements

Enterprises consolidating firmware signing under the PQC programme should charter explicitly — not assume OT will "handle devices." Minimum charter elements:

1. **Scope boundary** — OT, embedded, payment HSM firmware, container images, engineering workstations
2. **Signature scheme authority** — who approves LMS vs ML-DSA per device class (architecture board)
3. **Vendor engagement model** — contractual algorithm obligations, audit rights, test hardware
4. **State management owner** (if LMS/XMSS) — named team, DR responsibility, training plan
5. **Validation test bed** — representative hardware; staged rollout gates (§6.16)
6. **Regulatory evidence map** — NERC CIP, TSA, PCI, DORA artefacts per asset class
7. **Integration with enterprise PKI** — certificate profile dependencies (Chapter 12)
8. **Budget line** — hardware refresh, vendor engineering, signing appliance, token refresh

Northfield's charter named James Whitfield as accountable owner with dotted-line authority to enterprise PKI — resolving six months of prior confusion about whether firmware signing was "OT" or "security."

---

## 6.22 Apply in Your Organisation

1. **Classify firmware assets in CBOM** with cert store size, verification CPU, and signing vendor — flag special-case candidates before defaulting to ML-DSA.
2. **Apply Table 6.1** consistently — document scheme per device class in cryptography policy.
3. **If selecting LMS/XMSS**, complete state management design before any pilot — state store, DR, audit, training.
4. **Contract vendor signing obligations** — algorithm timeline, audit rights, test hardware.
5. **Integrate OT firmware signing with enterprise PKI programme** — not a parallel OT science project.
6. **Model root CA trust horizons** for OT device validity — elevate to ML-DSA-87 where validity exceeds ten years.
7. **Exercise signing failure playbooks** in tabletop before canary deployment — include operations staff, not only security.
8. **Publish multi-year firmware roadmap** with vendor dependencies explicit — avoid calendar-only commitments.
9. **Define evidence retention** for signing logs, manifests, and test reports — aligned to sector regulatory horizons.

---

## 6.23 Programme Anti-Patterns in Firmware Migration

**Anti-pattern 1: OT silo.** Firmware signing owned exclusively by plant engineering without PKI or security programme integration. Produces incompatible certificate profiles and duplicate vendor negotiations.

**Anti-pattern 2: Hardware refresh as only strategy.** Defaulting to full device replacement when LMS or profile compression could bridge refresh cycles — capital waste and timeline extension.

**Anti-pattern 3: Stateful signing without state owner.** LMS deployed because signatures fit; no team owns index DR. Inevitable index incident.

**Anti-pattern 4: Dual-sign without H2 trigger.** ECDSA + ML-DSA on firmware indefinitely — permanent hybrid on longest-lived assets.

**Anti-pattern 5: Test lab only validation.** Cryptographic correctness in vendor lab without operational timing test on field hardware — Northfield's canary caught chain ordering bug labs missed.

**Anti-pattern 6: Payment HSM as general case.** Applying OT LMS analysis to FIPS HSM firmware where vendor provides ML-DSA path — over-engineering.

Meridian explicitly reviewed Anti-pattern 6 before chartering payment HSM work — confirming ML-DSA via validated module rather than LMS by default.

---

## 6.24 Cross-Functional Stakeholder Map for Firmware Signing

Firmware PQC migration requires a broader coalition than IT TLS projects:

| Stakeholder | Role in firmware signing programme |
|-------------|-----------------------------------|
| OT / plant engineering | Operational acceptance; maintenance windows; field rollout |
| Enterprise PKI | Certificate profiles; root migration; CRL/OCSP capacity |
| Vendor management | Contract clauses; roadmap enforcement; audit rights |
| Procurement | Capital for refresh; vendor engineering fees |
| Legal / regulatory | Risk acceptance; NERC/TSA/PCI evidence |
| Incident response | Index reuse and signing failure playbooks |
| Physical security | Air-gap ceremony; tamper-evident media |

Northfield's monthly firmware programme meeting required attendees from all seven rows — with decision authority documented. Meetings without OT operations representation were cancelled — preventing security-only decisions that operations could not execute.

James Whitfield's rule: **no field push without operations sign-off on maintenance window and rollback procedure** — regardless of cryptographic test success.

---

## 6.25 Long-Term Trust Horizons for Firmware Certificates

Chapter 2 introduced integrity horizons — how long signatures must remain verifiable. Firmware and OT amplify the question: devices deployed in 2026 may verify certificates signed in 2026 against roots valid until 2046 or beyond.

| Factor | Enterprise IT PKI | OT / firmware |
|--------|-------------------|---------------|
| Typical cert validity | 1–2 years (TLS) | 10–20 years (device roots) |
| Root rotation frequency | Annual operational task | Once per device lifetime |
| ML-DSA size impact | Manageable with renewal | Baked into device trust store |
| Wrong root choice cost | Reissue certificates | Field hardware replacement |

Northfield's OT PKI team modelled **root CA migration as a 15-year programme** — not a project. ML-DSA-87 roots issued in 2027 would validate firmware signed through 2042 under current validity policy. Changing roots required device trust store updates — the same synchronization problem as firmware images.

> **Architect's Decision**
>
> For OT device roots with validity exceeding ten years, **issue ML-DSA-87 (Category 5) at migration** even when enterprise default is ML-DSA-65 — long trust horizon justifies parameter elevation. Document in algorithm matrix elevation criteria linked to certificate validity years, not only data classification.

Meridian's payment HSM chain used ML-DSA-87 for firmware signing roots for the same reason — fourteen-month vendor delivery did not reduce trust horizon requirements.

---

## 6.26 Incident Response for Firmware Signing Failures

Firmware signing incidents differ from key compromise. Playbooks should cover:

**Scenario A — LMS index reuse suspected.** Suspend signing; freeze releases; compare appliance logs; notify CISO and vendor; assess whether published firmware signatures require revocation notification to field sites.

**Scenario B — Signature verification fails in field.** Halt rollout; preserve failed image; compare manifest; determine whether tampering, chain error, or device clock issue; rollback per §6.16.

**Scenario C — Signing appliance compromise.** Treat as key compromise; rotate LMS hierarchy or ML-DSA key; full forensic imaging; regulatory notification per sector requirements.

**Scenario D — Emergency unsigned patch request.** Deny by default; break-glass requires programme director + OT director written authorisation; post-incident review within 72 hours.

Northfield exercised Scenario B in canary deployment — playbook functioned; rollout paused 72 hours; root cause was intermediate certificate ordering. Without playbook, operations might have bypassed verification to meet maintenance schedule — the failure mode James Whitfield feared most.

Apex classified Scenario C as **reportable** for NSS environments — incident response integrated with classified security incident management, not standard IT IR tooling alone.

---

## 6.27 Five-Year Firmware Programme Roadmap (Northfield)

Illustrative roadmap — planning tool, not commitment:

| Year | Compressor (LMS) | RTU (dual-sign) | Eng. workstation (ML-DSA) | VPN / WAN |
|------|------------------|-----------------|---------------------------|-----------|
| 2026 | LMS design; appliance install | Vendor dual-sign dev | HSM upgrade | Assessment |
| 2027 | Pilot site; canary | Staging tests | Air-gap SOP update | Model A hybrid |
| 2028 | Regional rollout 1 | New units ML-DSA-only | Production ML-DSA | Model B refresh |
| 2029 | Regional rollout 2 | Field dual-sign complete | — | Full WAN H1 |
| 2030 | H2 classical sunset plan | H2 trigger | H3 target | Deprecation alignment |

### Budget and business case framing

Firmware PQC programmes compete for capital with safety, reliability, and modernisation projects. Effective business cases link:

- **Threat** — TES 5, nation-state firmware forgery, HNDL on operational archives (Chapter 2)
- **Regulatory** — NERC CIP, TSA, PCI evidence continuity (Chapter 3)
- **Operational risk** — Unplanned downtime cost per day vs staged rollout cost
- **Synchronization** — Vendor NSS investment reducing marginal engineering cost

Northfield's compressor LMS business case cited **$4.2 million** avoided full refresh (*illustrative*) against **$1.1 million** LMS programme — threat and capital avoidance, not compliance checkbox. Board approval followed in one session. James noted the same board had deferred a prior "PQC TLS" request lacking OT specificity — firmware specificity converted sceptics.

James presented the roadmap with **explicit dependency arrows** to vendor deliverables — steering committee could see that 2028 compressor rollout depended on 2027 vendor acceptance test, not internal ambition alone.

---

## 6.28 Training and Workforce Development

Firmware signing programmes fail when only two specialists understand LMS index management. Workforce planning:

| Role | Training requirement |
|------|---------------------|
| OT operations | Manifest verification; rollback procedures; escalation |
| Signing ceremony staff | LMS index semantics; DR failover; two-person rule |
| PKI engineers | ML-DSA profile design; root migration for device classes |
| Vendor liaisons | Contract milestone language; acceptance test criteria |
| Incident response | Scenarios A–D (§6.26); regulatory notification paths |

Northfield trained **forty-two** field technicians on manifest verification before first regional LMS rollout — course duration four hours; practical assessment required pass. Training cost **$180,000** (*illustrative*) — less than one day of unplanned compressor downtime from failed verification.

Apex required NSS signing staff to complete **stateful signature operations certification** before accessing production LMS appliances — certification renewed annually with DR exercise participation.

Meridian's payment HSM path required fewer OT-style field skills — vendor-managed ceremony with bank staff oversight. Training focused on **evidence review** and escalation, not index management — illustrating device-class-appropriate workforce models.

---

## 6.29 Integrating Firmware Programme with TRADE Rescoring

Firmware signing migration changes TRADE scores. When Northfield's compressor LMS path reached staging:

- **Ecosystem readiness (E)** rose from 2 to 4 — vendor delivered signing appliance
- **Architectural dependency (A)** remained 5 — still blocking twelve downstream systems until production
- **Threat (T)** unchanged — TES 5 throughout

Rescoring triggered **wave sequence confirmation** — staging success did not automatically promote production date; CDG downstream readiness still gated field rollout.

Programme offices should **rescore quarterly** for all TES 5 firmware assets — vendor slips and acceptance test failures propagate to timeline overlay without manual executive escalation.

---

## 6.30 Warranty, Liability, and Vendor Indemnification

Firmware signing contracts should address **liability allocation** for algorithm migration failures:

- Vendor warrants signing tooling produces verifiable signatures per agreed scheme
- Customer warrants field procedures follow manifest and rollback SOPs
- Mutual indemnification caps negotiated for index reuse attributable to vendor appliance defect
- Export control and classified handling responsibilities explicit in NSS contexts

Northfield's LMS contract allocated index reuse liability to vendor if appliance failed monotonicity guarantee — legal novelty requiring external counsel specialised in OT vendor agreements. The clause accelerated vendor investment in state replication testing.

Meridian's payment HSM contract used standard financial-services technology liability framework — ML-DSA module delivery linked to service credits, not novel LMS language.

---

## 6.31 Warranty and Evidence Retention

Retain firmware signing evidence for regulatory and forensic horizons:

| Artefact | Minimum retention (illustrative) |
|----------|----------------------------------|
| Signed image hash and manifest | Life of device + 7 years |
| LMS index log | Life of key hierarchy + 7 years |
| Acceptance test reports | 10 years (NERC CIP-aligned) |
| Rollback execution records | 7 years |
| Training completion records | 7 years |

Apex classified retention requirements for NSS separately — classified environments followed records schedules exceeding commercial tables.

---

## 6.32 Chapter Summary

- Firmware and embedded systems require special-case signature strategy — ML-DSA defaults do not always fit fixed stores and CPU budgets.
- SP 800-208 stateful schemes (LMS, XMSS) offer compact signatures with mandatory state management — index reuse is catastrophic.
- CNSA 2.0 drives NSS firmware signing timelines; commercial OT may leverage vendor NSS investment.
- Signature selection matrix: ML-DSA for general and feasible firmware; LMS/XMSS for constrained stores; SLH-DSA for diversity and archive contexts — rarely on-device OT verification.
- H1 dual-signature bridges field devices through refresh cycles; H2 triggers mandatory.
- Northfield's three-vendor case demonstrates unified strategy with vendor-specific execution.
- Firmware signing is a supply chain, PKI, and validation programme — not an OT-only upgrade.
- Meridian payment HSM firmware demonstrates financial-sector special-case analysis — ML-DSA via validated module, not LMS by default.
- LMS parameter selection requires capacity planning evidence — releases × lifetime × headroom.
- Long OT certificate validity drives ML-DSA-87 elevation independent of enterprise defaults.
- Training and tabletop exercises precede field rollout — operations staff, not only cryptographers.
- TRADE rescoring after firmware milestones prevents false production readiness claims.

**Closing note:** The firmware chapter is where Part II's algorithm defaults meet physical reality — fixed buffers, decade lifetimes, air gaps, and stateful ceremonies. Enterprises that master TLS but neglect firmware signing discover their longest-lived vulnerabilities remain in the plant floor, the payment HSM, or the container registry — depending on sector.

**Next:** Part III shifts from standards literacy to estate knowledge — cryptographic discovery, the Cryptographic Bill of Materials, and the Cryptographic Dependency Graph.

---

*Chapter 6 — References*

- Basescu, C., Hemsley, G., Khosla, N., Machado, L., Quach, W., Ravichandran, R., Tromer, E., & Wong, D. (2024). Deployment considerations for secure post-quantum cryptography in practice. *Proceedings of the USENIX Security Symposium*. https://www.usenix.org/conference/usenixsecurity24/presentation/basescu
- Cybersecurity and Infrastructure Security Agency. (2024). Post-quantum cryptography initiative. https://www.cisa.gov/quantum
- IEC 62443 (all parts). Security for industrial automation and control systems. International Electrotechnical Commission.
- National Institute of Standards and Technology. (2020). NIST SP 800-208: Recommendation for stateful hash-based signature schemes. https://doi.org/10.6028/NIST.SP.800-208
- National Institute of Standards and Technology. (2024). FIPS 204: Module-lattice-based digital signature standard. https://doi.org/10.6028/NIST.FIPS.204
- National Institute of Standards and Technology. (2024). FIPS 205: Stateless hash-based digital signature standard. https://doi.org/10.6028/NIST.FIPS.205
- North American Electric Reliability Corporation. (2024). *Critical Infrastructure Protection (CIP) standards*. https://www.nerc.com/pa/Stand/
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- PCI Security Standards Council. (2022). *Payment Card Industry Data Security Standard v4.0*. https://www.pcisecuritystandards.org/
- Transportation Security Administration. (2021–2024). Security directives for pipeline cybersecurity (series). U.S. Department of Homeland Security.

---

*End of Part II. Proceed to Part III: Knowing Your Cryptographic Estate.*
