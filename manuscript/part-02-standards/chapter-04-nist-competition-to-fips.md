# Chapter 4
# From NIST Competition to FIPS 203–205

---

Apex Defense Technologies' Chief Cryptographic Architect, Dr. Priya Nair, received a procurement questionnaire in February 2025 that her team had answered dozens of times before — with incrementally different answers each quarter. The customer, a federal systems integrator, required evidence that Apex's platform software would support the Commercial National Security Algorithm Suite 2.0 by 2027 for new National Security System acquisitions. The questionnaire listed ML-KEM-1024, ML-DSA-87, and SLH-DSA as required algorithms. It also asked whether Apex supported FN-DSA and HQC.

Priya's engineering lead responded that FN-DSA and HQC were "under evaluation." Priya sent the response back. The correct enterprise answer, she explained, was structural: **Apex standardises on the NIST-finalised suite for programme planning; contingency algorithms are monitored, not deployed, until standardised and required by contract.** The integrator accepted the distinction. A competitor who claimed "full PQC algorithm support" including pre-standard candidates later failed technical evaluation when their implementation could not demonstrate FIPS-validated modules for any signature scheme.

Apex's lesson generalises beyond defence contracting. Enterprise architects need sufficient standards literacy to answer procurement questions, write cryptography policies, and evaluate vendor claims — without becoming lattice cryptographers. This chapter provides that literacy.

---

## 4.1 The Standards-as-Inputs Principle

Part I argued that post-quantum migration is a synchronization problem, not an algorithm selection exercise. Part II begins from that premise and adds a constraint: **the algorithm suite is largely decided.**

NIST's Post-Quantum Cryptography Standardization Project, launched in 2016, completed its primary selection phase in August 2024 with the publication of FIPS 203, 204, and 205. Enterprises planning migration in 2026 should treat these three standards as the deployment baseline. International standards bodies — ISO/IEC JTC 1 SC 27, ETSI, IETF — are aligning normative references with NIST's selections. Regulatory guidance referencing "state of the art" increasingly points at ML-KEM, ML-DSA, and SLH-DSA as the algorithms that demonstrate serious migration planning.

The standards-as-inputs principle defines how this book uses FIPS documents:

| Role | What standards provide | What standards do not provide |
|------|------------------------|------------------------------|
| **Algorithm identity** | Approved scheme names, parameter sets, security categories | Enterprise migration sequencing |
| **Validation** | FIPS 140-3 module requirements for implementations | CBOM methodology |
| **Interoperability** | Common reference for vendor and protocol designers | Partner negotiation strategy |
| **Policy reference** | Authoritative names for enterprise cryptography standards | Hybrid sunset criteria (enterprise-defined) |

Enterprise cryptography policies should **reference** FIPS 203–205. They should **implement** the Hybrid Lifecycle Model (Chapter 5), Cryptographic Dependency Graph (Chapter 8), and governance artefacts from Part I. Confusing these layers produces either analysis paralysis ("we cannot choose until FN-DSA is final") or false confidence ("we deployed ML-KEM in a pilot, therefore we are compliant").

> **Migration Moment**
>
> *"We should wait for NIST to finish everything before standardising our algorithm policy."*
>
> FIPS 203–205 are final. NIST IR 8547 provides transition timelines. Remaining candidates (FN-DSA, HQC) address specific use cases and contingency planning — not whether your programme begins. Delaying policy definition until every NIST track completes guarantees that inventory, vendor engagement, and regulatory evidence all start late.

---

## 4.2 The NIST PQC Project: From Competition to Standard

Understanding how NIST reached its selections helps architects explain *why* the enterprise suite looks the way it does — and why certain algorithms remain in development rather than production planning.

### Timeline and process

NIST announced the PQC standardization project in December 2016, soliciting submissions across public-key encryption/key establishment and digital signature categories. The process was deliberately public: multiple analysis rounds, cryptanalytic feedback, and adjusted candidate pools when weaknesses emerged.

| Phase | Period | Outcome |
|-------|--------|---------|
| Round 1 | 2017–2018 | 69 submissions accepted; 26 advanced |
| Round 2 | 2019–2020 | 15 finalists and alternates |
| Round 3 | 2020–2022 | Primary selections announced: CRYSTALS-Kyber, CRYSTALS-Dilithium, SPHINCS+ |
| Standardization | 2022–2024 | FIPS 203 (ML-KEM), FIPS 204 (ML-DSA), FIPS 205 (SLH-DSA) published |
| Ongoing | 2024+ | FN-DSA (formerly Falcon) and HQC standardization; additional signatures |

The process filtered for security, performance, implementation characteristics, and intellectual property considerations. Schemes that showed structural weaknesses in public analysis were eliminated. Schemes with unfavourable key or signature sizes remained viable but influenced use-case fit — a factor enterprises experience directly in protocol and storage design.

### From candidate names to FIPS names

NIST renamed algorithms upon standardization to reflect their mathematical structure and disambiguate from pre-standard implementations:

| Pre-standard name | FIPS name | FIPS document | Primary use |
|-------------------|-----------|---------------|-------------|
| CRYSTALS-Kyber | **ML-KEM** | FIPS 203 | Key encapsulation (KEM) |
| CRYSTALS-Dilithium | **ML-DSA** | FIPS 204 | Digital signatures |
| SPHINCS+ | **SLH-DSA** | FIPS 205 | Stateless hash-based signatures |
| Falcon | **FN-DSA** (in development) | Pending | Compact signatures |
| HQC | **HQC-KEM** (in development) | Pending | Alternative KEM (code-based) |

Enterprise documentation, procurement specifications, and CBOM entries should use **FIPS names** for anything intended for production deployment. Pre-standard names appear in legacy pilot code, research literature, and vendor marketing from 2020–2023 — CBOM normalisation must map them to FIPS equivalents.

**Figure 4.1 — NIST PQC Standards Family Tree**

```
                    NIST PQC Standardization (2016–)
                              |
            +-----------------+-----------------+
            |                                   |
     KEY ESTABLISHMENT                    SIGNATURES
            |                                   |
    +-------+-------+               +-----------+-----------+
    |               |               |           |           |
 FIPS 203         HQC-KEM        FIPS 204    FIPS 205    FN-DSA
  ML-KEM         (pending)       ML-DSA      SLH-DSA     (pending)
    |                               |           |
 Lattice-based                 Lattice-based  Hash-based
 (Kyber family)                 (Dilithium)   (SPHINCS+)
```

---

## 4.3 FIPS 203: ML-KEM (Module-Lattice-Based Key Encapsulation)

ML-KEM is the enterprise's replacement for quantum-vulnerable key establishment — the operations performed by RSA key transport, finite-field Diffie-Hellman, and elliptic-curve Diffie-Hellman in protocols such as TLS, VPN, and encrypted messaging.

### What a KEM does

A key encapsulation mechanism allows two parties to establish a shared secret key. Unlike Diffie-Hellman, which produces a shared secret through interactive exchange, a KEM typically works as follows:

1. The recipient publishes a public key.
2. The sender uses the public key to encapsulate a random shared secret, producing a ciphertext.
3. The recipient decapsulates the ciphertext to recover the shared secret.

Architects do not need the lattice mathematics. They need to know that ML-KEM replaces **key establishment** operations in protocol redesign — TLS key shares, VPN IKE exchanges, HPKE modes, and key-wrapping constructions that currently use RSA or ECDH.

### Parameter sets and security categories

FIPS 203 defines three parameter sets, historically corresponding to Kyber-512, Kyber-768, and Kyber-1024:

**Table 4.1 — ML-KEM Parameter Sets**

| Parameter set | NIST security category | Classical equivalent (informal) | Typical enterprise use |
|---------------|------------------------|--------------------------------|------------------------|
| ML-KEM-512 | Category 1 | ~AES-128 | Constrained IoT; generally avoid for new enterprise deployments |
| ML-KEM-768 | Category 3 | ~AES-192 | **Default enterprise choice** for general-purpose key establishment |
| ML-KEM-1024 | Category 5 | ~AES-256 | Regulated long-life data; NSS; defence; high-value key wrapping |

**Architect's Decision:** For new enterprise deployments absent specific NSS or contractual requirements mandating ML-KEM-1024, **standardise on ML-KEM-768** as the default key establishment algorithm. Reserve ML-KEM-1024 for NSS-aligned systems, long-confidentiality key wrapping, and contracts explicitly requiring Category 5. Do not deploy ML-KEM-512 for new enterprise systems — the performance benefit rarely justifies reduced margin against future cryptanalytic advances.

CNSA 2.0 mandates ML-KEM-1024 for National Security Systems. Apex Defence maps NSS workloads to ML-KEM-1024 and corporate IT to ML-KEM-768 unless contract flow-down elevates the requirement — a dual-track pattern common in defence industrial base enterprises (Chapter 3).

### Size and performance implications

ML-KEM public keys, ciphertexts, and shared secrets are larger than elliptic-curve equivalents. These sizes affect:

- TLS handshake message sizes (ClientHello/ServerHello extensions)
- VPN IKE message fragmentation
- DNS packet sizes when keys appear in DNSSEC or related contexts
- Embedded devices with fixed buffer allocations
- API gateways and load balancers with header or body size limits

These are not theoretical concerns. GlobalSync Logistics discovered that three API gateway configurations enforced maximum TLS handshake sizes below what hybrid ML-KEM constructions required — a discovery made during architecture assessment, not during the successful pilot on a single unconstrained endpoint (Chapter 1).

### Validation path

Production deployments require FIPS 140-3 validated modules implementing ML-KEM for regulated environments. Software-only implementations may suffice for development and interoperability testing but not for payment HSM, federal, or FIPS-mandated contexts. Enterprise procurement should require **FIPS 140-3 validation certificates** listing ML-KEM implementations — not vendor assertions of "FIPS-aligned" code.

---

## 4.4 FIPS 204: ML-DSA (Module-Lattice-Based Digital Signatures)

ML-DSA replaces quantum-vulnerable digital signature algorithms — RSA, DSA, ECDSA, EdDSA — in code signing, document signing, certificate signatures, email S/MIME, and general-purpose authentication.

### Parameter sets

**Table 4.2 — ML-DSA Parameter Sets**

| Parameter set | Security category | Signature size (approx.) | Enterprise fit |
|---------------|-------------------|--------------------------|----------------|
| ML-DSA-44 | Category 2 | ~2.4 KB | Legacy-constrained systems; limited use |
| ML-DSA-65 | Category 3 | ~3.3 KB | **Default enterprise choice** |
| ML-DSA-87 | Category 5 | ~4.6 KB | NSS; long-trust-chain roots; defence |

ML-DSA signatures and public keys are substantially larger than ECDSA. A certificate chain that previously fit within smart card storage may not accommodate ML-DSA without hardware redesign. PDF signing containers, log aggregation systems, and blockchain anchoring constructions sized for ECDSA may require schema updates.

**Architect's Decision:** Standardise on **ML-DSA-65** for general enterprise signing — certificates, code signing where size permits, document signing. Use **ML-DSA-87** where CNSA 2.0, contractual flow-down, or root CA long-trust requirements mandate Category 5. Evaluate size constraints in firmware, smart cards, and OT devices before committing — Chapter 6 addresses cases where ML-DSA does not fit.

### Where ML-DSA applies in the enterprise

| Use case | Current typical algorithm | ML-DSA role |
|----------|---------------------------|-------------|
| TLS server certificates | ECDSA/RSA | CA and end-entity certificate signatures |
| Code signing | RSA/ECDSA | Binary and package signatures |
| Document signing | RSA/ECDSA | PDF, Office, legal document signatures |
| Email signing (S/MIME) | RSA/ECDSA | Message and certificate signatures |
| Firmware signing | RSA/ECDSA | Often constrained — see Chapter 6 |
| Blockchain / ledger anchoring | ECDSA/EdDSA | Size and performance sensitive |

Meridian Mutual Bank's payment HSM firmware signing chain — the blocking dependency from Chapter 1 — requires ML-DSA support in FIPS-validated HSM firmware. The algorithm choice is determined; the ecosystem readiness score is not.

---

## 4.5 FIPS 205: SLH-DSA (Stateless Hash-Based Signatures)

SLH-DSA (derived from SPHINCS+) provides digital signatures based on hash functions rather than lattice problems. Its security assumptions differ from ML-DSA — conservative from a mathematical perspective, expensive from a performance perspective.

### When enterprises choose SLH-DSA

SLH-DSA serves as:

- **Algorithmic diversity** alongside ML-DSA in high-assurance environments that require multiple signature families
- **Conservative alternative** where lattice-based assumptions are considered unacceptable for specific classified or long-trust applications
- **Fallback path** if ML-DSA implementations prove problematic in specific constrained environments — though size and performance trade-offs often favour SP 800-208 stateful schemes for firmware (Chapter 6)

CNSA 2.0 includes SLH-DSA in the approved suite alongside ML-DSA. NSS planning should account for both. Commercial enterprises without NSS obligations may standardise on ML-DSA alone for most use cases, documenting SLH-DSA as an approved alternative where policy requires algorithmic diversity.

### Performance and size characteristics

SLH-DSA signatures are significantly larger than ML-DSA and substantially larger than ECDSA. Signing and verification operations are slower. These characteristics limit SLH-DSA's fit for high-throughput protocols — TLS handshakes, high-volume API authentication, real-time OT messaging — without careful engineering.

SLH-DSA's value proposition is **conservative security assumptions** and **hash-function-based construction** — not operational efficiency. Enterprise policies should specify SLH-DSA for use cases where diversity or conservative assumptions justify performance cost, not as a default replacement for ECDSA in performance-sensitive paths.

---

## 4.6 Security Categories and Enterprise Mapping

NIST organises post-quantum algorithms into security categories linked to the hardness of underlying problems against classical and quantum attacks. Enterprise architects map categories to data classification and regulatory requirements — not to conduct independent cryptanalysis.

**Table 4.3 — Security Category × Enterprise Data Mapping**

| NIST category | Informal strength | Typical mapping |
|---------------|-------------------|-----------------|
| Category 1 | Lower PQC margin | Avoid for new enterprise deployments |
| Category 2 | Moderate | Legacy transition only with documented rationale |
| Category 3 | **Enterprise default** | Standard business data; general TLS and signing |
| Category 5 | High | NSS; classified; long-life national security data; contractual mandate |

The mapping connects to Part I's threat analysis: systems with TES 4–5 and long confidentiality horizons justify Category 5 parameters for key establishment and signing. Systems with shorter horizons still benefit from Category 3 as the enterprise default — over-provisioning Category 5 everywhere increases bandwidth, storage, and validation cost without proportional risk reduction.

> **Regulatory Lens**
>
> DORA RTS Article 6 requires encryption policies based on ICT risk assessment. Supervisory reviewers will ask whether parameter set selection is **risk-based** — not whether every system uses the largest available parameters. Document the mapping from data classification to security category in the Policy layer of the PQC Governance Stack (Chapter 3).

---

## 4.7 Contingency Algorithms: FN-DSA and HQC

NIST continues standardization work on FN-DSA (compact lattice signatures) and HQC-KEM (code-based key establishment). Enterprise architects must understand their status: **contingency and diversification, not blocking dependencies.**

### FN-DSA

FN-DSA (formerly Falcon) offers smaller signatures than ML-DSA — attractive for bandwidth-constrained protocols and size-limited embedded systems. It remains in the NIST standardization process at time of writing. Implementation complexity, constant-time execution requirements, and validation availability are more immature than ML-DSA.

**Enterprise posture:** Monitor FN-DSA progress. Do not build production migration plans assuming FN-DSA availability on a specific date. Do not reject ML-DSA deployments pending FN-DSA. Include FN-DSA in cryptography policy as a **future approved algorithm** subject to FIPS publication and validation availability.

### HQC-KEM

HQC provides an alternative code-based KEM — algorithmically distinct from ML-KEM's lattice construction. NIST selected ML-KEM as the primary KEM and continues HQC standardization for diversification.

**Enterprise posture:** Treat HQC as contingency against future cryptanalytic developments affecting lattice schemes — a scenario requiring governance review, not automatic migration. Commercial enterprises should not delay ML-KEM deployment for HQC availability.

### Why contingency planning matters

Cryptographic history includes algorithm families weakened by unexpected analysis. Responsible programmes plan for algorithm agility (Chapter 10) and monitor NIST's ongoing work. Irresponsible programmes use "FN-DSA isn't final yet" as justification for programme paralysis. The distinction is operational: contingency algorithms inform **policy future-proofing** and **agility requirements**; finalized algorithms inform **deployment planning**.

---

## 4.8 Algorithm Selection Decision Logic

Enterprises do not need bespoke algorithm selection committees for each system. They need a **decision tree** applied consistently across the estate, with documented exceptions.

**Figure 4.2 — Enterprise Algorithm Selection Decision Tree**

```
START: New cryptographic deployment or migration
  |
  v
Is this an NSS or CNSA 2.0-mandated system?
  |-- YES --> ML-KEM-1024 + ML-DSA-87 + SLH-DSA (per CNSA 2.0 profile)
  |-- NO  --> Continue
              |
              v
Operation type?
  |-- Key establishment --> ML-KEM-768 (default)
  |                         ML-KEM-1024 if Category 5 required by risk assessment
  |-- Digital signature  --> ML-DSA-65 (default)
  |                         ML-DSA-87 if Category 5 required
  |                         SLH-DSA if diversity policy or NSS requires
  |-- Firmware / embedded --> Chapter 6 decision matrix (may be LMS/XMSS)
              |
              v
Size or performance constraints prevent ML-DSA?
  |-- YES --> Evaluate SLH-DSA fit OR SP 800-208 stateful scheme (Ch. 6)
  |           Document exception with sunset criteria
  |-- NO  --> Continue with ML-DSA selection
              |
              v
FIPS 140-3 validated module available for target platform?
  |-- NO  --> Ecosystem readiness gates deployment (TRADE E dimension)
  |           Begin vendor escalation; plan hybrid interim (Ch. 5)
  |-- YES --> Proceed to HLM phase planning (Ch. 5)
```

The decision tree produces **policy defaults**, not per-engineer discretion. Individual systems deviate only through the exception process defined in enterprise cryptography policy (Chapter 5).

---

## 4.9 Performance, Size, and Protocol Interdependencies

Algorithm selection cannot be separated from protocol and infrastructure design. The following interdependencies appear repeatedly in enterprise assessments:

### TLS and hybrid constructions

IETF standards-track hybrid TLS combines classical key exchange (typically X25519) with ML-KEM. Handshake sizes increase. Middleboxes, intrusion prevention systems, and load balancers that inspect or buffer handshakes may require reconfiguration. Enterprises should assess **TLS termination infrastructure** before committing to production hybrid rollout — not after pilot success on unconstrained endpoints.

### PKI and certificate chains

ML-DSA certificate signatures increase certificate size. Root and intermediate CA certificates with long validity periods signed with ML-DSA-87 produce chains that may exceed constraints in:

- Smart cards and hardware tokens
- IoT devices with fixed certificate stores
- OT devices with decade-long certificate lifetimes
- Partner trust stores with size limits

Northfield Energy's OT certificate validity — often ten to twenty years — amplifies this constraint. Certificate profile updates must precede end-entity migration (Chapter 12).

### Code and document signing

ML-DSA signatures increase signed artefact size. Package repositories, content delivery networks, and document management systems may enforce size limits designed for RSA-2048 or ECDSA signatures. GlobalSync's container registry required configuration changes to accept post-quantum signed images — a dependency not visible in TLS-only pilots.

### Database and application-layer cryptography

Applications using RSA for key wrapping or encrypted field storage must accommodate ML-KEM ciphertext sizes and ML-DSA signature sizes in schema design. Fixed-width database columns, message queue payloads, and API response buffers sized for classical cryptography require assessment.

> **Dependency Alert**
>
> Algorithm parameter selection gates **infrastructure capacity planning**, not only cryptographic library choice. A programme that selects ML-DSA-87 without assessing certificate chain storage in OT devices will discover blocking constraints during production deployment — not during a web server pilot.

---

## 4.10 International Alignment: ISO, ETSI, and IETF

NIST FIPS 203–205 are the practical deployment baseline. International bodies provide normative references and protocol specifications that enterprises need for multi-jurisdiction operations.

### ISO/IEC JTC 1 SC 27

ISO/IEC working groups incorporate ML-KEM and ML-DSA into international standards including ISO/IEC 18033 (encryption) and ISO/IEC 14888 (signatures). ISO 27001 Annex A control 8.24 references organisational cryptography policies — which, post-2024, should name FIPS-aligned algorithm suites. Appendix A provides regulatory supplement depth.

### ETSI

ETSI develops quantum-safe profiles for telecommunications and PKI infrastructure. EU financial entities operating private MPLS or dedicated WAN infrastructure should monitor ETSI TR 103 619 and related work items for protocol-level requirements that may precede enterprise internal timelines.

### IETF

The IETF specifies deployable protocol formats. Hybrid TLS, HPKE with ML-KEM, and CMS/PKCS#7 updates for post-quantum algorithms flow through IETF working groups. Enterprise policies should reference **standards-track IETF specifications** for protocol deployment — not proprietary hybrid implementations.

GlobalSync Logistics maintains a protocol standards watchlist across IETF, ETSI, and NIST — feeding quarterly updates to its cryptography policy owner. The watchlist prevents tenant-facing API changes from referencing expired Internet-Drafts.

---

## 4.11 Apex Defense: CNSA 2.0 vs. Commercial Availability

Apex Defense Technologies operates dual cryptographic tracks: NSS workloads under CNSA 2.0 mandates and commercial IT under NIST IR 8547 guidance. Priya Nair's architecture team documented the mapping in a single **algorithm standards matrix** — the Policy layer artefact regulators and customers expect.

**Table 4.4 — Apex Algorithm Standards Matrix (Excerpt)**

| Workload class | Key establishment | Signatures | Authority |
|----------------|-------------------|------------|-----------|
| NSS / classified-adjacent | ML-KEM-1024 | ML-DSA-87, SLH-DSA | CNSA 2.0 |
| FedRAMP workloads | ML-KEM-768 minimum | ML-DSA-65 minimum | NIST IR 8547 + agency overlay |
| Corporate IT | ML-KEM-768 | ML-DSA-65 | Enterprise policy |
| R&D / non-production | Approved candidates in test labs only | Same | Lab isolation policy |

The matrix resolved three recurring programme conflicts:

1. **Procurement ambiguity.** Suppliers received unambiguous algorithm names and parameter sets per workload class — not "PQC-ready" language.

2. **Engineering scope creep.** Teams could not add FN-DSA to production roadmaps without policy committee approval and FIPS publication.

3. **Customer questionnaire consistency.** Federal integrators received identical answers across product lines because the matrix was the single source of truth.

Apex's commercial subsidiaries without NSS obligations followed the corporate IT row — but federal flow-down clauses frequently elevated specific contracts to ML-KEM-1024 and ML-DSA-87. Contract review became a standard step in the algorithm applicability workflow.

---

## 4.12 Meridian and GlobalSync: Standards in Policy Documents

Meridian Mutual Bank translated FIPS references into its **Cryptographic Control Policy** — the DORA-linked document Thomas Bergström's regulatory team defended in supervisory dialogue. The policy did not reproduce FIPS content. It stated:

- Approved key establishment algorithms: ML-KEM-768 (enterprise default), ML-KEM-1024 (high-assurance systems per risk assessment)
- Approved signature algorithms: ML-DSA-65 (enterprise default), ML-DSA-87 (root CA and long-trust components)
- Transition status: hybrid classical/PQC permitted per Hybrid Lifecycle Model; quantum-vulnerable PKC sunset dates aligned to NIST IR 8547 anchors
- Exception process: risk acceptance with CISO approval, maximum twelve-month renewal, CBOM annotation

GlobalSync Logistics faced a different challenge: **tenant-visible cryptography policy.** Enterprise SaaS customers requested algorithm details in security questionnaires. GlobalSync published a **customer-facing cryptography statement** referencing FIPS 203–205 by name, with hybrid TLS deployment status per region. Transparency reduced sales-cycle friction — customers did not need to extract algorithm details from penetration test reports.

---

## 4.13 FIPS 140-3 Validation and the Implementation Gap

Algorithm standards mean little without validated implementations. FIPS 140-3 defines security requirements for cryptographic modules — hardware and software — that process sensitive data in regulated environments.

### What validation provides

A FIPS 140-3 validation certificate confirms that a specific module implementation, at a specific version, running on specific platforms, passed defined cryptographic security tests. It does not validate:

- The enterprise's configuration of the module
- Algorithms the module supports but the enterprise has not enabled
- Application-layer protocol usage above the module
- Partner systems in a trust chain

Enterprise procurement language should require **validation certificate number, module version, and listed algorithms** — not marketing terms such as "quantum-ready" or "PQC-enabled."

### The 2026 validation landscape

At time of writing, ML-KEM and ML-DSA validated modules are entering the market from major HSM vendors, cloud key management services, and selected software libraries. Coverage is uneven:

| Platform class | ML-KEM readiness (typical) | ML-DSA readiness (typical) |
|----------------|---------------------------|---------------------------|
| Cloud KMS (tier-1) | Beta to GA | Beta to GA |
| Payment HSM | Roadmap 2026–2027 | Roadmap 2026–2028 |
| General-purpose HSM | GA emerging | GA emerging |
| Smart card / token | Limited | Limited |
| Embedded MCU | Rare | Rare |
| OpenSSL 3.x / BoringSSL | Software validation path | Software validation path |

The uneven landscape explains TRADE's Ecosystem readiness dimension (Chapter 2). Meridian's PII KMS scored Ecosystem readiness 2 because payment-grade HSM validation for ML-KEM was not production-available — not because ML-KEM was undefined.

### Software vs hardware validation

Software libraries may implement FIPS-approved algorithms without full FIPS 140-3 validation. For development, interoperability testing, and non-regulated workloads, software implementations accelerate programme progress. For regulated production — payment, federal, FIPS-mandated — validated modules are required.

**Architect's Decision:** Maintain a **validation coverage matrix** in the Operational layer of the Governance Stack: system class × required validation level × available modules × gap status. Update quarterly from vendor correspondence and CMVP certificate lists. Do not schedule production migration for regulated workloads until the matrix shows validated coverage — plan H1 hybrids in software labs meanwhile.

---

## 4.14 Protocol and Library Readiness

Algorithms deploy through protocols and libraries. Architects track three readiness layers:

### Layer 1: Cryptographic library

OpenSSL 3.5+, BoringSSL, wolfSSL, and vendor SDKs incorporate ML-KEM and ML-DSA. Library availability enables development and testing. It does not guarantee enterprise protocol support or validated module integration.

### Layer 2: Protocol specification

IETF standards-track specifications define on-the-wire formats for hybrid TLS, CMS signed-data structures, and related constructions. Enterprise policy should mandate standards-track references — Internet-Drafts are for testing, not production policy.

### Layer 3: Application and middleware

Load balancers, API gateways, service meshes, VPN concentrators, and email servers must support protocol extensions and certificate sizes. This layer most often blocks production deployment after successful library pilots.

GlobalSync maintained a **protocol readiness register** listing each production tier-1 service, its TLS termination component, maximum handshake size, ML-KEM support status, and owner. The register identified three blocking middleware products before GlobalSync committed to H1 hybrid production dates — avoiding a pilot-to-production collision (Chapter 1 failure pattern).

### Classical-to-PQC mapping for architects

Architects familiar with classical algorithms need a translation table for design discussions — not implementation.

**Table 4.5 — Classical Algorithm × PQC Replacement Mapping**

| Classical operation | Example algorithms | PQC replacement | Notes |
|--------------------|-------------------|-----------------|-------|
| Key transport | RSA-OAEP | ML-KEM | Different API — KEM not encrypt |
| Key agreement | ECDH, DH | ML-KEM (KEM mode) or hybrid | Protocol redesign |
| Digital signature | RSA-PSS, ECDSA | ML-DSA or SLH-DSA | Size increase |
| Code signing | RSA/ECDSA CMS | ML-DSA CMS profile | Dual-sign during H1 |
| Certificate signatures | CA RSA/ECDSA | ML-DSA | Chain size impact |
| Email encryption key wrap | RSA | ML-KEM | S/MIME profile updates |

The mapping clarifies that PQC migration is not one algorithm substitution — it is **per-operation replacement** across heterogeneous systems, each with different ecosystem readiness timelines.

### Transitive dependency risk

Applications inherit cryptography from container base images, language runtimes, and linked libraries. A Java application using the platform's default TLS provider may not support ML-KEM until the JVM version and security provider update — independent of application team awareness. CBOM discovery must include transitive dependencies (Part III).

---

## 4.15 Conducting an Algorithm Standards Workshop

Algorithm policy should not be written by a single architect in isolation. A half-day standards workshop produces defensible policy inputs:

**Participants:** Cryptographic engineering, enterprise architecture, PKI operations, OT representative (if applicable), compliance, procurement liaison.

**Pre-work:** Distribute FIPS 203–205 executive summaries (NIST one-pagers, not full standards); current CBOM algorithm summary if available; CNSA 2.0 excerpt for defence-adjacent organisations.

**Agenda (four hours):**

1. **Standards-as-inputs framing** (30 min) — what FIPS provides vs what enterprise policy must define
2. **Use-case mapping** (60 min) — key establishment vs signing vs firmware; map to enterprise system classes
3. **Parameter set defaults** (45 min) — agree ML-KEM-768 / ML-DSA-65 defaults; define Category 5 elevation criteria
4. **Contingency algorithms** (30 min) — FN-DSA/HQC monitoring posture; agility requirements
5. **Validation reality check** (45 min) — review validation coverage matrix; identify ecosystem gates
6. **Policy outputs** (30 min) — assign owners for algorithm standards matrix draft

**Outputs:** Draft algorithm standards matrix; validation coverage matrix; list of systems requiring Chapter 6 special-case assessment; procurement language update requirements.

Apex ran this workshop twice — once for NSS programmes, once for commercial IT — producing separate matrix rows under a single policy document. Meridian ran a single workshop with EBA supervisory expectations as context, producing DORA-defensible parameter elevation criteria tied to data classification.

---

## 4.16 Meridian Deep Dive: Payment HSM as Ecosystem Gate

Meridian's Chapter 1 blocking dependency — payment HSM firmware signing — illustrates standards-to-operations gap. The algorithm standard (ML-DSA-65 or ML-DSA-87) was clear by August 2024. The validated module was not.

Meridian's programme response:

1. **Algorithm policy** referenced ML-DSA for firmware signing — immediate
2. **Procurement** invoked contract clause requiring FIPS-validated PQC module on vendor roadmap — month 1
3. **TRADE scoring** elevated HSM chain to MPI 4.39 with Ecosystem readiness 2 — month 2
4. **Parallel workstreams** during vendor wait: downstream application key ceremony redesign for ML-KEM key sizes; PKI profile draft for ML-DSA certificates; partner notification to acquiring bank — months 2–12
5. **Production migration** gated on vendor validation certificate — estimated month 18+

The sequence demonstrates standards literacy enabling **parallel programme progress** while ecosystem readiness gates production. Teams that conflate "algorithm selected" with "migration complete" skip steps 4–5 and arrive at production collision.

---

## 4.17 What This Chapter Deliberately Omits

This chapter does not teach:

- Lattice reduction, module learning with errors, or hash-based signature internals
- Implementation guidance for constant-time ML-DSA on specific hardware
- Complete FIPS 203–205 test vector reproduction
- FN-DSA or HQC mathematical specifications

Readers needing that depth should consult FIPS documents, NIST submission packages, and academic references including Stinson's forthcoming primer. This book's role begins where standards documents end: **enterprise deployment under real constraints.**

---

## 4.18 Apply in Your Organisation

1. **Publish an algorithm standards matrix** with default parameter sets (ML-KEM-768, ML-DSA-65) and Category 5 elevation criteria — do not leave selection to individual project teams.
2. **Normalise CBOM algorithm names** to FIPS terminology — map Kyber/Dilithium/SPHINCS+ legacy labels in discovery output.
3. **Require FIPS 140-3 validation certificates** in procurement — reject "algorithm implemented" without module validation for regulated workloads.
4. **Assess size constraints** for ML-DSA in PKI, firmware, and OT before committing to migration sequence — flag Chapter 6 candidates early.
5. **Monitor FN-DSA and HQC** in policy future-proofing sections — do not block current planning on their publication.

---

## 4.19 Chapter Summary

- FIPS 203 (ML-KEM), 204 (ML-DSA), and 205 (SLH-DSA) are final standards — the enterprise deployment baseline as of August 2024.
- The standards-as-inputs principle: reference FIPS in policy; implement migration through programme frameworks — not by reproducing standards in internal documents.
- Default enterprise parameter sets: ML-KEM-768 and ML-DSA-65; elevate to Category 5 (ML-KEM-1024, ML-DSA-87) for NSS, high-assurance, and long-trust components.
- FN-DSA and HQC are contingency algorithms — monitor, do not block current deployment planning.
- Algorithm selection interacts with protocol sizes, PKI chains, infrastructure capacity, and validation availability — selection is not purely cryptographic.
- CNSA 2.0 creates dual-track requirements for defence industrial base enterprises; commercial and NSS workloads need separate matrix rows.
- International alignment (ISO, ETSI, IETF) references NIST selections for normative deployment formats.

**Next:** Chapter 5 translates NIST IR 8547, CNSA 2.0, and allied national timelines into enterprise hybrid policy and the Hybrid Lifecycle Model.

---

*Chapter 4 — References*

- National Institute of Standards and Technology. (2024). FIPS 203: Module-lattice-based key-encapsulation mechanism standard. https://doi.org/10.6028/NIST.FIPS.203
- National Institute of Standards and Technology. (2024). FIPS 204: Module-lattice-based digital signature standard. https://doi.org/10.6028/NIST.FIPS.204
- National Institute of Standards and Technology. (2024). FIPS 205: Stateless hash-based digital signature standard. https://doi.org/10.6028/NIST.FIPS.205
- National Institute of Standards and Technology. (2024). *Post-quantum cryptography: NIST standards and ongoing projects*. https://csrc.nist.gov/projects/post-quantum-cryptography
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- Internet Engineering Task Force. CFRG and TLS working group post-quantum specifications (standards-track documents at time of deployment).
