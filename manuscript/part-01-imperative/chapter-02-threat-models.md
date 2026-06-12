# Chapter 2
# Threat Models That Drive Priorities

---

The security operations centre at Northfield Energy Systems recorded the anomaly at 02:14 on a Tuesday in October: a scheduled backup of SCADA historian archives — ten years of operational telemetry from three gas transmission compressor stations — transited a WAN link to a geographically separated disaster recovery site. The traffic was encrypted with IPsec using IKEv2 and ECDH-P256 key exchange. The encryption was correctly implemented. The certificates were valid. The cipher suite met Northfield's written policy.

It also represented approximately 4.2 terabytes of operational data whose confidentiality horizon extended well beyond any reasonable estimate for quantum-safe protection on that link. Northfield's threat model, like most utilities, prioritised availability and integrity of real-time control systems. Confidentiality of historical archives ranked lower. The quantum threat reframed that ranking entirely.

The adversary capable of exploiting a future cryptographically relevant quantum computer does not need to compromise Northfield's control network today. Recording encrypted historian traffic requires passive collection — a capability well within the means of sophisticated threat actors operating against critical infrastructure. The decryption can wait. The collection cannot.

Dr. Sarah Okonkwo, Northfield's Director of Security Architecture, had argued for eighteen months that the historian replication link warranted upgraded encryption and key management independent of any quantum threat — simply on the basis of data sensitivity classification. The quantum framing gave her argument the executive urgency that data classification alone had not. It did not change the underlying analysis. The data was sensitive. The encryption protecting it in transit was adequate against classical adversaries. It was not adequate against an adversary who could wait.

This chapter replaces quantum threat hype with the decision-grade threat analysis that determines migration sequence. Not all quantum risk is equal. The enterprises that migrate effectively are those that distinguish between threats that demand action now and threats that remain bounded by shorter time horizons.

---

## 2.1 Separating Threat Categories

Enterprise security teams encounter three distinct quantum-related threat narratives. Conflating them produces either panic or paralysis. Treating them as a single undifferentiated "quantum threat" produces misprioritised migration plans that either over-invest in low-urgency systems or under-invest in systems protecting decades-long confidentiality requirements.

### Category 1: Cryptographically relevant quantum computers (CRQCs)

A CRQC is a quantum computer capable of executing Shor's algorithm at sufficient scale to break widely deployed public-key cryptography — RSA-2048, RSA-3072, ECC P-256, ECC P-384, and finite-field Diffie-Hellman at comparable security levels. Shor's algorithm solves the integer factorization and discrete logarithm problems in polynomial time on a sufficiently large quantum computer. RSA and ECC security depends on these problems being computationally infeasible for classical computers. A CRQC removes that assumption.

No such machine exists today. Expert projections for CRQC arrival span a wide range, from the late 2020s to beyond 2040, depending on assumptions about error correction, qubit scaling, and architectural breakthroughs. Honest analysis acknowledges genuine uncertainty. Security programmes that depend on a specific CRQC arrival date are building on sand.

CRQC threat analysis matters for **long-term programme planning** and **regulatory horizon-setting**. It establishes the outer boundary of the migration window. It does not, by itself, tell you which system to migrate this quarter.

### Category 2: Harvest now, decrypt later (HNDL)

HNDL — also called store-now-decrypt-later — describes an attack in which an adversary records encrypted data today and retains it until quantum decryption becomes feasible. The attack requires no quantum capability at collection time. It requires only access to ciphertext and patience.

The attack model is not theoretical. CISA's Post-Quantum Cryptography Initiative, ENISA threat landscape reporting, and sector ISAC advisories document passive collection as a credible risk against government, defence, financial, energy, and telecommunications targets. The collection infrastructure exists. The quantum computer does not. The adversary's investment thesis is that the data will remain valuable longer than the quantum computer will take to arrive.

HNDL threat analysis matters for **prioritisation**. It converts a future quantum threat into a present-tense collection incentive. The urgency of HNDL is determined not by quantum computer timelines but by **data confidentiality lifetime** — how long the protected data must remain secret.

### Category 3: Pre-quantum cryptanalytic advances

Classical cryptanalysis of post-quantum algorithm candidates continues. NIST's selection process explicitly accounts for this risk by standardizing multiple algorithm families and maintaining evaluation of backup candidates (FN-DSA, HQC). Implementation vulnerabilities — side channels, fault injection, misuse — affect PQC algorithms as they affect classical algorithms.

This category matters for **algorithm agility** and **validation discipline**. It supports the case for crypto-agile architectures that can substitute algorithms if a specific PQC scheme is weakened. It does not justify delaying migration away from quantum-vulnerable classical algorithms. The classical algorithms are already broken in principle; the quantum computer is the implementation mechanism, not the discovery.

**Table 2.1 — Threat Category Decision Relevance**

| Category | Drives programme charter? | Drives migration priority? | Drives algorithm selection? |
|----------|--------------------------|---------------------------|----------------------------|
| CRQC arrival | Yes — establishes horizon | Indirectly — via HNDL | No — NIST has selected |
| HNDL | Yes — establishes urgency | **Yes — primary driver** | Indirectly — via data class |
| Classical PQC breaks | Yes — establishes agility need | No — affects agility design | Yes — contingency planning |

**Figure 2.2 — Threat-to-Control Mapping**

```
THREAT CATEGORY          PRIMARY CONTROL RESPONSE              PART I/BOOK REF
─────────────────────────────────────────────────────────────────────────────
CRQC arrival             Programme charter; ERM registration  Ch. 1, Ch. 15
                         Multi-year budget; timeline anchors

HNDL (confidentiality)   Confidentiality horizon assignment   §2.3
                         TES scoring; Wave 1 migration        Ch. 9
                         HNDL pathway encryption upgrade

HNDL (integrity/forgery) Integrity horizon analysis           §2.4
                         Firmware/code-signing priority       Ch. 6

Classical PQC breaks     Crypto-agility architecture          Ch. 10
                         Algorithm contingency planning       Ch. 4, Ch. 22
                         Validation discipline                Ch. 18

All categories           CBOM maintenance; threat re-score    Ch. 7
                         Documented risk acceptance           Ch. 3, Ch. 5
```

The remainder of this chapter focuses on HNDL and confidentiality horizon analysis, because these are the threat dimensions most frequently mishandled in enterprise prioritisation.

---

## 2.2 The Mathematics Enterprise Leaders Need — and Nothing More

Enterprise leaders do not need to understand lattice reduction or hash-based signature constructions. They need four mathematical facts:

**Fact 1:** Shor's algorithm breaks RSA, DH, and ECC at scale. This is proven mathematics, not speculation.

**Fact 2:** Grover's algorithm provides a quadratic speedup against symmetric keys. AES-256 remains secure with margin. AES-128 may require re-evaluation for long-term use. Symmetric algorithm replacement is not the primary migration challenge.

**Fact 3:** Post-quantum algorithms are designed around mathematical problems that are not known to be solvable efficiently by quantum computers. Their security is subject to classical cryptanalysis, as all cryptographic algorithms are. NIST selected algorithms with conservative parameter sets.

**Fact 4:** The time to migrate an enterprise estate exceeds the uncertainty range of CRQC arrival projections for large organisations. This is the operational consequence of Facts 1–3 combined with estate complexity.

These four facts justify programme investment. They do not determine migration sequence. Sequence is determined by confidentiality horizons, dependency topology, and ecosystem readiness — the subjects of this chapter and those that follow.

---

## 2.3 The Confidentiality Horizon

Every encrypted asset has a confidentiality horizon: the period during which unauthorized disclosure would cause material harm. This horizon is independent of certificate validity, key rotation frequency, or quantum computer forecasts.

Consider four assets in the same enterprise:

1. **A TLS session** protecting a customer account balance inquiry. Confidentiality horizon: seconds to minutes. The session key is ephemeral. Even if recorded, the balance changes before any adversary could act on the information.

2. **An encrypted email** containing a merger negotiation. Confidentiality horizon: months to years. Disclosure before announcement would enable insider trading or competitive harm.

3. **A SCADA historian archive** containing thirty years of pipeline operational data. Confidentiality horizon: decades. Disclosure reveals infrastructure topology, maintenance patterns, capacity constraints, and vulnerability windows exploitable for physical disruption.

4. **A backup tape** containing ten years of customer financial records subject to regulatory retention. Confidentiality horizon: seven to ten years minimum, potentially indefinite under legal hold. Disclosure enables fraud, identity theft, and regulatory sanction.

All four may use ECDH-P256 or RSA-2048. All four are quantum-vulnerable. They do not share the same migration priority.

The confidentiality horizon is determined by business impact analysis, not by cryptographic properties. Legal holds, regulatory retention requirements, trade secret classifications, national security designations, and operational sensitivity all extend horizons beyond what technical teams typically model.

### Establishing confidentiality horizons: a practical method

Security teams should not guess confidentiality horizons. They should derive them from existing data governance artefacts:

1. **Data classification policy** — established sensitivity tiers (public, internal, confidential, restricted)
2. **Records retention schedule** — legal and regulatory retention periods by data category
3. **Records of Processing Activities (GDPR Article 30)** — processing purposes and storage durations
4. **Contractual confidentiality obligations** — customer agreements specifying data protection periods
5. **Trade secret registry** — intellectual property with indefinite protection requirements

Where these artefacts conflict, the **longest applicable horizon** governs for HNDL threat assessment. A dataset classified "internal" with a seven-year retention requirement and a contractual obligation to protect for ten years has a ten-year confidentiality horizon.

> **Migration Moment**
>
> *"Quantum computers don't exist yet, so we have time."*
>
> This statement confuses CRQC arrival with HNDL urgency. An adversary harvesting encrypted pipeline schematics today does not need a quantum computer today. They need one before the schematics become irrelevant — which may be never. For data with indefinite confidentiality requirements, HNDL threat is present-tense.

**Figure 2.1 — HNDL Exposure Timeline**

```
Data created ──────[ confidentiality horizon ]──────────► Harm if disclosed
     │                                                          │
     │    ◄──── ciphertext may be collected at any point ────►│
     │                                                          │
     │         CRQC arrives somewhere in this range             │
     │              │                                           │
     │              ▼                                           │
     │         Decryption becomes feasible                      │
     │              │                                           │
     │              └── If before horizon ends: HNDL succeeds   │
```

The diagram's implication is direct: **systems protecting long-horizon data require earlier migration than systems protecting ephemeral data**, regardless of external exposure. An internal archive encrypted with quantum-vulnerable algorithms may outrank a public-facing web server in priority.

### Ephemeral data trap

A common error treats "session keys are ephemeral" as proof that TLS-protected traffic requires no PQC urgency. Session keys are ephemeral. The data they protect may be archived. Email clients cache messages. API responses are logged. Backup systems capture network traffic for debugging. A TLS session protecting a document download creates ciphertext that may persist in logs, caches, and backups long after the session key is destroyed.

Ephemeral key exchange does not eliminate HNDL risk. It limits HNDL risk to the lifetime of the ciphertext copy. Discovery must identify where ciphertext persists, not only where keys are generated.

---

## 2.4 Authentication and Integrity Horizons

Confidentiality dominates PQC threat discourse because Shor's algorithm breaks the key establishment and encryption functions of public-key cryptography. Migration prioritisation that considers only confidentiality is incomplete.

### Digital signatures and authentication

Quantum computers break the discrete logarithm and factoring problems that underpin RSA and ECDSA signatures. When a CRQC arrives, a quantum-capable adversary could forge signatures that verifiers would accept as legitimate — enabling impersonation, fraudulent code execution, and document forgery.

The HNDL framing applies differently here. Signatures are not "stored for later decryption." The threat is **future forgery**, not retroactive disclosure. The urgency driver is the **validity period of trust** placed in current signatures:

- A code signing certificate used to validate firmware updates creates a trust chain whose integrity must hold for the firmware's operational lifetime — potentially decades for embedded systems.
- A document signed for legal purposes may require non-repudiation for the document's legal enforceability period.
- A TLS certificate's signature vouches for identity for the certificate's validity period.
- A timestamp authority's signature on an audit log may need to remain verifiable for the log's retention period.

For authentication and integrity, the relevant question is: **how long must signatures made today remain trustworthy?** If the answer exceeds the CRQC arrival window, migration is urgent.

**Table 2.2 — Confidentiality vs. Integrity Horizon Examples**

| Artefact | Confidentiality concern | Integrity concern | Dominant horizon |
|----------|------------------------|-------------------|------------------|
| TLS session (balance inquiry) | Low — ephemeral | Low — session-bound | Neither drives urgency |
| Signed firmware image | Low — public binary | **High** — trust for device lifetime | Integrity |
| Encrypted backup archive | **High** — long retention | Moderate — tamper detection | Confidentiality |
| Qualified electronic signature | Moderate — document content | **High** — legal non-repudiation | Integrity |
| Mutual TLS client certificate | Moderate — identity | **High** — authentication trust | Integrity |

### Integrity of long-validity artefacts

Northfield Energy's OT environment illustrates this distinction. Compressor station firmware images are signed at manufacture and validated at installation. The signing certificate may have a ten-year validity. The firmware may operate for twenty years. The trust placed in the manufacturer's signature must survive both periods.

If quantum forgery becomes feasible within that window, an adversary could produce counterfeit firmware updates that pass signature validation — a threat to integrity and availability more severe than passive confidentiality breach. The attack does not require retroactive cryptanalysis. It requires the ability to forge valid signatures before the trust chain is migrated.

NIST IR 8547's treatment of authentication systems acknowledges nuance: some authentication contexts may warrant different transition timelines than key-establishment systems. Enterprises should not interpret this as permission to defer all authentication migration. They should interpret it as requiring **context-specific horizon analysis** rather than uniform urgency.

---

## 2.5 The TRADE Threat Dimension

Chapter 1 introduced the TRADE Decision Engine — a prioritisation framework scoring systems across five dimensions: **T**hreat exposure, **R**egulatory obligation, **A**rchitectural dependency, **D**ata longevity, and **E**cosystem readiness. This section develops the Threat dimension in detail. Subsequent chapters develop the remaining dimensions.

### Threat exposure scoring

Each system receives a Threat Exposure Score (TES) from 1 (minimal) to 5 (critical), based on the following criteria:

**TES 5 — Critical exposure**
- Protects data with confidentiality horizon exceeding fifteen years
- Subject to active HNDL collection (known or reasonably suspected)
- Authentication artefacts with trust validity exceeding CRQC consensus horizon
- National security, critical infrastructure, or regulated personal data at scale

**TES 4 — High exposure**
- Protects data with confidentiality horizon of five to fifteen years
- Processes regulated personal data (GDPR special categories, financial records, health records)
- Code signing or firmware validation chains for production systems
- Cross-organisational trust anchors (federated identity, partner PKI)

**TES 3 — Moderate exposure**
- Protects data with confidentiality horizon of one to five years
- Internal business communications and operational data
- Standard application authentication tokens with medium session lifetimes

**TES 2 — Low exposure**
- Protects data with confidentiality horizon under one year
- Ephemeral session keys with no long-term archival
- Development and test environments (with production data excluded)

**TES 1 — Minimal exposure**
- No confidential data protected by asymmetric cryptography
- Symmetric-only cryptographic operations
- Systems scheduled for decommission within twelve months

### Worked example: Meridian Mutual Bank

Meridian applied TES scoring to four systems during Phase 1 prioritisation:

| System | Data/asset | Horizon | Adversary model | TES |
|--------|-----------|---------|-----------------|-----|
| Card transaction archive | 7-year retention, PCI | 7–10 years | Criminal + HNDL | 4 |
| Customer PII database encryption (key wrap) | GDPR, indefinite legal hold possible | 10+ years | Criminal + HNDL | 5 |
| Public website TLS | Session data, minimal logging | Minutes | Opportunistic | 2 |
| Payment HSM firmware signing | Code integrity | 15+ year device life | Supply chain | 5 |

The public website TLS — the system Meridian's predecessor had scoped for "the PQC project" — scored TES 2. The customer PII key wrapping system scored TES 5. Threat analysis alone would prioritise the database encryption key management infrastructure and the HSM firmware chain over external TLS.

### Threat actor capability alignment

Threat exposure is not assessed in a vacuum. The enterprise's threat model — derived from its sector, geography, and asset value — determines which adversary capabilities are relevant.

**Table 2.3 — Threat Actor Models by Sector**

| Sector | Primary adversary | HNDL collection capability | Forgery urgency |
|--------|------------------|---------------------------|-----------------|
| Critical infrastructure | Nation-state, sabotage | **Assumed baseline** | High — firmware, OT |
| Financial services | Criminal, nation-state (targeted) | High for payment data | High — transaction auth |
| Defense industrial base | Nation-state | **Assumed baseline** | **Critical** — all signatures |
| Healthcare | Criminal, insider | Moderate — PHI archives | Moderate — records integrity |
| Multinational SaaS | Criminal, nation-state (tenant-dependent) | Tenant-dependent | High — platform signing |
| Retail / e-commerce | Criminal | Low–moderate | Low–moderate |

Northfield Energy, operating gas transmission infrastructure, models nation-state collection of WAN traffic as a credible scenario — not because Northfield has detected such collection, but because CISA advisories and sector threat intelligence establish it as the baseline planning assumption for critical infrastructure.

The TRADE framework does not replace threat modelling. It **consumes** threat model outputs and converts them into migration-relevant scores. Security teams should document the threat actor assumptions underlying each TES assignment. Auditors and regulators will ask.

**Table 2.4 — Data Classification × Algorithm Vulnerability Matrix**

| Data classification | Confidentiality horizon | Quantum-vulnerable PKC in use | Priority tier |
|--------------------|------------------------|------------------------------|---------------|
| National security / classified | Indefinite | Any | **Immediate** |
| Critical infrastructure operational data | 20–50 years | Any | **Immediate** |
| Regulated financial records (retention-bound) | 7–10 years | Any | **High** |
| Trade secrets / M&A | 3–7 years | Any | **High** |
| Personal data (GDPR Art. 9 categories) | Variable; legal hold possible | Any | **High** |
| Standard business records | 1–3 years | Any | **Moderate** |
| Ephemeral transaction data | Seconds–hours | Any | **Low** (unless archived) |
| Public information | N/A | Any | **Minimal** |

The matrix produces priority tiers. It does not produce migration sequence. Sequence requires the Architectural dependency and Ecosystem readiness dimensions developed in Chapters 8 and 9. A system classified **Immediate** priority that sits behind a blocking dependency node may migrate later than a **High** priority system whose dependencies are resolved.

This is the synchronization problem applied to threat analysis: **the most threatened asset is not always the first asset you can migrate.**

---

## 2.6 Sector-Specific Threat Calibration

Threat models are not universal. The Sector Overlay Matrix (SOM), developed in Part VI, modifies TRADE weights by industry. Part I establishes the calibration principles.

### Financial services

Threat drivers: HNDL against transaction records and customer data with regulatory retention requirements; authentication forgery enabling fraudulent transactions; supply-chain compromise of payment hardware. Regulatory frameworks (DORA, PCI DSS, PSD2) create evidence obligations that amplify threat consequences even when direct HNDL collection is not the primary adversary model.

TRADE modification: increase Regulatory obligation weight (Chapter 3); treat payment HSM and card scheme trust chains as TES 4 minimum regardless of data horizon.

Meridian's payment HSM firmware signing chain scored TES 5 on integrity grounds even though the firmware binary itself is not confidential. A forged firmware update is more damaging than a decrypted archive.

### Critical infrastructure and energy

Threat drivers: HNDL against operational technology data revealing physical system topology; long-lived firmware trust chains; nation-state collection against WAN and radio links; safety system integrity. Availability and integrity often dominate confidentiality in traditional OT threat models — PQC migration must not compromise either.

TRADE modification: increase Data longevity weight for OT archives; treat firmware signing as TES 5; require OT security sign-off before any migration action affecting control system availability.

Northfield's historian archive case exemplifies the OT confidentiality reclassification that quantum threat forces. Data that was "operational, not sensitive" under classical threat models becomes sensitive under HNDL analysis because its confidentiality horizon extends beyond CRQC arrival.

### Defence and government

Threat drivers: classified and controlled unclassified information with indefinite confidentiality requirements; CNSA 2.0 compliance as binding mandate; adversary collection assumed as baseline capability. Threat analysis is less speculative and more policy-driven.

TRADE modification: Regulatory obligation weight effectively overrides other dimensions for NSS-aligned systems; consult CNSA 2.0 timelines as floor, not ceiling.

Apex Defense Technologies treats CNSA 2.0 milestones as non-negotiable programme gates. Threat analysis confirms what policy already requires. The analytical value is prioritisation within the mandated timeline, not debate about whether migration is necessary.

### Multinational SaaS and technology

Threat drivers: tenant data isolation breaches amplified by quantum decryption; cross-border data residency implications; API authentication forgery at scale; intellectual property in encrypted backups. Threat model varies by tenant data classification.

TRADE modification: increase Ecosystem readiness weight (tenant and partner dependencies); treat platform-level cryptographic services as Architectural dependency blocking nodes.

GlobalSync Logistics segments its tenant base by data classification for TES purposes. Healthcare tenants processing GDPR Article 9 data receive platform isolation requirements that standard logistics tenants do not. One-size-fits-all TES assignment fails for platform providers.

### Healthcare

Threat drivers: PHI with decades-long retention in research contexts; medical device firmware with long operational life; ransomware actors who exfiltrate before encrypting (combining HNDL with immediate criminal use). HIPAA does not explicitly reference quantum threat, but the Security Rule's addressable implementation specifications for encryption create the same state-of-the-art logic as GDPR Article 32.

TRADE modification: treat research data archives and medical device firmware as TES 4–5; coordinate with FDA device cybersecurity guidance for firmware signing migration.

---

## 2.7 Integrating Threat Intelligence and Red Team Findings

Threat exposure scoring should not be a paper exercise conducted once during programme initiation. It must integrate with existing security operations:

**Threat intelligence feeds** — Sector ISACs, government advisories, and commercial intelligence increasingly reference quantum-related collection activity. Intelligence reporting that documents adversary interest in encrypted data exfiltration should elevate TES for affected data classes.

**Red team and penetration test findings** — Assessments that demonstrate ciphertext interception capability — man-in-the-middle positions on WAN links, compromised backup systems, passive collection on internal networks — provide empirical evidence for HNDL collection feasibility. Northfield's SOC anomaly was not a penetration test, but it performed the same function: demonstrating that ciphertext transits observable network paths.

**Data loss prevention and exfiltration monitoring** — Existing DLP alerts on encrypted archive exfiltration indicate that ciphertext is already mobile within or beyond the enterprise boundary. Mobile ciphertext with long confidentiality horizons is HNDL-vulnerable by definition.

**Table 2.5 — Threat Intelligence Integration Points**

| Source | PQC-relevant signal | Programme action |
|--------|--------------------|--------------------|
| Sector ISAC advisory | Nation-state collection against sector | Elevate TES for sector-relevant data |
| Red team report | Ciphertext intercept demonstrated | Elevate TES for affected pathways |
| DLP alert | Encrypted archive exfiltration | Review confidentiality horizon |
| Vendor threat bulletin | Partner compromise with data access | Assess partner-encrypted data |
| Government advisory | Quantum computing milestone | Review programme timeline assumptions |

---

## 2.8 What the Threat Model Does Not Justify

Rigorous threat analysis includes discipline about what it does **not** support.

### It does not justify algorithm shopping

Threat analysis determines **when** and **what priority** to migrate. NIST FIPS 203, 204, and 205 determine **to which algorithms**. Enterprises that use threat uncertainty to defer standard algorithm adoption — waiting for "better" candidates — confuse contingency planning with migration execution. FN-DSA and HQC remain in NIST evaluation for diversification. ML-KEM, ML-DSA, and SLH-DSA are the deployment standards.

### It does not justify symmetric algorithm replacement

AES-256 and SHA-256/SHA-3 families are considered quantum-resistant at current security levels. Grover's algorithm provides a quadratic speedup against symmetric keys, manageable by doubling key length. Enterprise threat models should not allocate migration resources to replacing symmetric cryptography unless a specific vulnerability exists.

### It does not justify quantum key distribution (QKD) as primary strategy

QKD addresses key distribution through quantum physical properties. It does not replace the need for post-quantum public-key cryptography in TLS, PKI, code signing, or the vast majority of enterprise use cases. QKD may have niche applicability in specific government and telecommunications contexts. It is not an enterprise migration strategy. This book does not develop QKD architecture.

### It does not justify permanent risk acceptance without documentation

Some systems will not migrate before CRQC arrival. Legacy OT devices, unsupported vendor appliances, and contractual dead-ends exist in every large estate. Threat analysis must identify them explicitly. NIST IR 8547 contemplates documented risk acceptance for systems that cannot transition by disallowance dates. Undocumented risk acceptance is not a strategy. It is an audit finding waiting to happen.

### It does not justify deferring inventory

"We will assess threat exposure after we select algorithms" inverts the correct sequence. Threat exposure determines priority. Priority determines sequence. Sequence informs which algorithms matter where. Inventory enables all three.

---

## 2.9 Northfield Energy: Threat Analysis in Practice

Return to the SCADA historian archive. Northfield's security team, after the SOC anomaly review, conducted a structured threat assessment applying the framework in this chapter.

**Asset:** IPsec-encrypted historian replication traffic and stored archives at DR site.

**Confidentiality horizon:** Thirty years minimum. Pipeline topology, capacity data, maintenance schedules, and safety system configurations have operational and national security sensitivity exceeding any CRQC arrival projection.

**TES assignment:** 5 (Critical). Nation-state HNDL collection against energy infrastructure is an explicit scenario in CISA and sector ISAC threat advisories.

**Authentication horizon:** Firmware signing certificates on compressor station controllers: ten-year validity, twenty-year operational life. TES 5 for integrity.

**What did not rank as high:** Real-time Modbus/TCP control traffic within the station LAN, protected by network segmentation rather than encryption. Confidentiality horizon near-zero for ephemeral control commands. TES 2. Migration deferred — but network segmentation evidence documented for auditors.

**Surprise finding:** The DR site's backup encryption used a VPN concentrator whose firmware could not support ML-KEM without a hardware refresh not scheduled until 2029. Threat urgency met ecosystem immobility. Northfield escalated the concentrator to the Architectural dependency register (Chapter 8) and initiated procurement action — the first instance where threat analysis directly drove a capital expenditure decision in the PQC programme.

### Extended Northfield assessment: three migration waves by threat

Northfield's TRADE analysis produced three threat-prioritised waves independent of dependency resolution (dependency sequencing came later):

**Wave 1 (Threat-immediate):** Historian archives, pipeline SCADA configuration backups, safety system documentation stores, WAN links carrying operational data between compressor stations and regional control centres.

**Wave 2 (Threat-high):** Corporate email encryption, engineering document repositories, vendor remote access VPNs, smart meter aggregation data with ten-year retention.

**Wave 3 (Threat-moderate):** Internal web applications, HR systems, facilities management. Standard business records with one-to-three-year horizons.

Wave 1 assets were not the most visible in Northfield's estate. They were the most threatened. The WAN link that triggered the SOC review was one of fourteen Wave 1 assets that shared the same confidentiality horizon profile.

Northfield's experience illustrates the chapter's central lesson: **threat analysis produces a priority map, not a project list.** The map must be reconciled with dependency topology and ecosystem readiness before it becomes a migration plan.

---

## 2.10 Apex Defense and GlobalSync: Contrasting Threat Profiles

### Apex Defense Technologies

Apex processes controlled unclassified information (CUI) and classified data under contract to defence agencies. Its threat model does not debate HNDL probability. Collection by foreign intelligence services is the baseline planning assumption for CUI. Classified data handling follows mandatory controls that presuppose adversary collection capability.

Apex's threat analysis value is **prioritisation within mandatory timelines**, not justification for migration. CNSA 2.0 establishes the floor. TRADE analysis sequences work within that floor: firmware signing before external TLS, key management infrastructure before application-layer migration, classified enclave boundaries before unclassified corporate systems. For NSS-aligned workloads, Regulatory dimension weight increases to 2.0 in the MPI formula — policy mandates override ecosystem readiness arguments.

Apex also illustrates **dual-track threat management**: systems processing classified data follow NSS timelines; corporate IT systems follow NIST IR 8547 commercial guidance; international subsidiaries follow host-nation requirements. One threat model does not govern the entire enterprise.

### GlobalSync Logistics

GlobalSync's threat model is **tenant-variable**. The platform processes logistics data ranging from public shipment tracking to pharmaceutical cold-chain records subject to GDP (Good Distribution Practice) retention requirements.

GlobalSync assigns TES based on the highest-classification tenant data processed on each platform component. A database shard serving pharmaceutical tenants receives TES 5. The same database technology serving retail logistics tenants receives TES 3. Platform-level migration must satisfy the highest TES in the shared component — or architectural isolation must separate tenant classes.

GlobalSync's threat analysis also identified **cross-tenant authentication** as a TES 4 integrity concern: platform API signing keys whose compromise would enable impersonation across tenant boundaries. Integrity horizon for platform signing keys is indefinite — the keys secure the platform for its operational lifetime.

---

## 2.11 From Threat Analysis to Programme Justification

Threat models serve two audiences: the security team, which needs prioritisation logic, and the board, which needs a credible case for multi-year investment.

Board-level threat narrative should emphasize three points:

1. **The HNDL threat is current.** Adversaries do not need quantum computers to begin compromising the enterprise's long-term confidentiality. Collection is happening now against high-value targets globally. This is documented in intelligence community and sector ISAC reporting, not in vendor marketing.

2. **The cost of early action is lower than the cost of late discovery.** Cryptographic inventory, agility requirements in new systems, and hybrid deployment pilots are modest investments relative to the cost of emergency migration under regulatory deadline pressure — or the cost of explaining to regulators why long-lived customer data was protected by algorithms NIST will disallow.

3. **The cost of inaction is asymmetric.** Quantum-vulnerable cryptography fails catastrophically when CRQCs arrive — not gradually, not with warning signs in the ciphertext. The enterprise either migrates on its timeline or on the adversary's.

The board does not need to understand lattice cryptography. It needs to understand that confidentiality horizons, not quantum computer press releases, determine whether the organisation is already late.

### Connecting threat analysis to regulatory evidence

Chapter 3 develops the regulatory landscape. The connection to threat analysis is direct: regulations require risk-based cryptographic governance. Threat analysis — documented, scored, and maintained — is the **risk assessment input** that regulators expect to inform encryption policy. An encryption policy that does not reference threat analysis is disconnected from the regulatory instruments that require it.

Meridian's DORA compliance workstream used Northfield-style TES scoring as the risk assessment methodology underlying its encryption policy update. The methodology was not invented for compliance. It was the analytical framework the security team already used — made auditable.

---

## 2.12 Conducting a Threat Assessment Workshop

Threat exposure scoring should be produced through a structured workshop, not assigned by a single analyst. The workshop methodology below has been designed for the TRADE framework for the estate complexity represented by the four teaching organisations in this book.

### Participants

Minimum attendance: CISO or delegate, enterprise architect, data protection officer or privacy counsel, threat intelligence lead, OT/ICS representative (if applicable), and business unit representatives for the systems under assessment. For financial services, compliance officer attendance is mandatory.

### Preparation

Before the workshop, distribute:

1. CBOM extract for systems in scope (or preliminary inventory if CBOM is not yet complete)
2. Data classification policy and retention schedule
3. Current enterprise threat model document
4. Sector ISAC threat advisories from the preceding twelve months
5. Blank TRADE scoring worksheets

### Workshop sequence (four hours)

**Hour 1 — Data classification and horizon assignment.** For each system in scope, assign confidentiality horizon using the method in Section 2.3. Document the governing artefact (retention schedule, contract clause, classification policy) for each assignment. Disputes between legal and security on horizon length are resolved by applying the longest applicable horizon.

**Hour 2 — Threat actor alignment.** Map each system to relevant threat actors from the enterprise threat model. Document whether HNDL collection is a credible scenario for each system given its data class and sector threat intelligence. Systems where collection is credible receive a minimum TES of 4 regardless of other factors.

**Hour 3 — TES scoring.** Assign TES 1–5 for each system using the criteria in Section 2.5. Document the rationale for each score. Flag systems where confidentiality and integrity horizons diverge — these require separate analysis per Section 2.4.

**Hour 4 — Priority tier assignment and challenge.** Apply the Data Classification × Algorithm Vulnerability Matrix (Table 2.4). Challenge any system scoring TES 1–2 that uses quantum-vulnerable PKC for any purpose — confirm that no archival, logging, or backup path extends the effective confidentiality horizon. Document dissenting views and their resolution.

### Workshop outputs

- TRADE Threat dimension scores for all systems in scope
- Priority tier assignments (Immediate, High, Moderate, Low, Minimal)
- Documented threat actor assumptions
- List of systems requiring integrity horizon analysis
- Identified gaps in data classification or retention documentation

Northfield conducted its first threat assessment workshop two weeks after the SOC anomaly. The workshop identified fourteen TES 5 systems — only three of which had appeared on the IT security team's initial PQC priority list. The historian replication link was one of the eleven the IT team had missed.

### Maintaining threat scores over time

Threat exposure is not static. Re-score when:

- Data classification changes
- Retention requirements change
- Threat intelligence identifies new collection activity against the sector
- Systems are added, decommissioned, or materially reconfigured
- Regulatory instruments create new evidence obligations

Annual re-scoring is the minimum cadence. Quarterly re-scoring is appropriate for TES 5 systems and for enterprises in sectors with active threat intelligence reporting.

---

## 2.13 Composite TRADE Scoring: A Worked Example

Threat exposure is one dimension of TRADE. This section provides a preview of composite scoring using a single system — Meridian's customer PII database encryption key management (no payment card data co-located; PCI scope excluded) — to illustrate how Threat interacts with other dimensions developed in later chapters.

### Default enterprise weights

The Migration Priority Index (MPI) is a weighted mean of five dimension scores (each 1–5):

**MPI = (wT×T + wR×R + wA×A + wD×D + wE×E) / (wT + wR + wA + wD + wE)**

| Dimension | Symbol | Default weight | Rationale |
|-----------|--------|---------------|-----------|
| Threat | wT | 1.5 | Primary driver for long-horizon data |
| Regulatory | wR | 1.25 | Compliance forcing function |
| Architectural dependency | wA | 1.25 | Blocking nodes amplify priority |
| Data longevity | wD | 1.0 | Reinforces HNDL analysis |
| Ecosystem readiness | wE | 0.75 | Gates execution timing, not urgency |

Sector overlays (Part VI) modify weights — e.g. defence increases wR; SaaS increases wE. Weights must be documented in the threat assessment methodology section.

### Meridian PII KMS scoring

| Dimension | Score | Rationale |
|-----------|-------|-----------|
| **T**hreat | 5 | 10+ year confidentiality horizon; GDPR Art. 9 categories; HNDL credible |
| **R**egulatory | 5 | DORA RTS Art. 6; GDPR Art. 32 |
| **A**rchitectural dependency | 4 | Blocking node — twelve application databases depend on this KMS |
| **D**ata longevity | 5 | Legal hold possible; retention indefinite for litigation |
| **E**cosystem readiness | 2 | HSM vendor PQC module fourteen months away |

**MPI calculation:**

MPI = (1.5×5 + 1.25×5 + 1.25×4 + 1.0×5 + 0.75×2) / (1.5 + 1.25 + 1.25 + 1.0 + 0.75)

MPI = (7.5 + 6.25 + 5.0 + 5.0 + 1.5) / 5.75 = **25.25 / 5.75 = 4.39**

Interpretation: **High–Immediate boundary** (MPI ≥ 4.0 = immediate planning priority; production gating assessed separately via Ecosystem readiness).

The high Threat, Regulatory, and Data longevity scores argue for immediate priority. The low Ecosystem readiness score gates production deployment, not planning. The high Architectural dependency score argues that this system's migration enables twelve downstream systems — making it a blocking node whose resolution accelerates the broader programme.

**Decision:** Prioritise for migration planning and vendor escalation immediately. Production migration gated on HSM vendor delivery. Use waiting period to resolve downstream application dependencies and define key ceremony adaptations for ML-KEM key sizes (Chapter 14).

This is the TRADE engine's value: it prevents binary thinking that produces either "migrate now" or "wait for vendor" without analysing the interaction of dimensions.

---

## 2.14 Communicating Threat to Non-Technical Stakeholders

Security leaders frequently fail to translate threat analysis into language that business unit leaders, board members, and legal counsel can act on. The following framing templates avoid cryptography jargon while preserving analytical precision.

**For the board:** "We have data that must remain confidential for [X] years. Adversaries can record encrypted copies today and decrypt them when quantum computers mature. Our migration programme determines whether that decryption happens before or after the data ceases to matter."

**For business unit leaders:** "Your system's data retention is [X] years. The encryption protecting it will not survive quantum computing for that duration. Migration priority for your system is [tier] because of [horizon/adversary/dependency]. Here is what we need from your team to maintain continuity during transition."

**For legal counsel:** "Our threat assessment identifies [N] systems where confidentiality horizons exceed quantum threat timelines. Our encryption policy addresses this through [programme reference]. Documented gaps are [list]. Remediation timeline is [dates]. This supports our [DORA/GDPR/NIS2] compliance position."

**For regulators:** "Our ICT risk assessment, conducted [date] using [methodology], identified quantum threat as material for [N] critical systems. Our encryption policy, updated [date], references NIST FIPS 203–205. Our certificate register contains [N] entries. Our migration plan addresses gaps over [timeline]."

Each template connects threat analysis to governance artefacts regulators and executives recognize — without requiring the audience to evaluate TES scores directly.

---

## 2.15 M&A and Estate Changes

Cryptographic estates change through mergers, acquisitions, and divestitures. TES scoring and CBOM scope must be updated when estate boundaries change. Acquisition due diligence should assess CBOM completeness, TES 5 exposure, blocking dependencies, and regulatory obligations — before integration, not after. Divestiture requires separating shared PKI, KMS, and federated identity dependencies. Full M&A cryptographic due diligence methodology is developed in Chapters 9 and 16.

> **Migration Moment**
>
> *"We'll add the acquired company to our PQC plan later."*
>
> Meridian's acquisition of a regional payment processor added 3,200 cryptographic assets — 94% quantum-vulnerable, with no PQC programme — and an estimated **€2.1 million** (*illustrative*) in additional integration spend because due diligence omitted cryptographic posture.

---

## 2.16 Symmetric Cryptography and Hash Functions: Scope Boundaries

Enterprise threat discussions sometimes expand to include symmetric algorithm replacement or hash function migration. Clear scope boundaries prevent resource misallocation.

**AES-128:** Grover's algorithm reduces effective security to 64-bit equivalent. For new deployments, AES-256 is preferred. Existing AES-128 deployments protecting long-horizon data should be evaluated for upgrade, but this is a lower priority than public-key migration because AES-128 with Grover's speedup still requires substantial quantum resources.

**SHA-256 and SHA-3:** Considered quantum-resistant at current output sizes. SHA-256 is not the PQC migration priority. SHA-1 (already deprecated) and MD5 (already broken) should have been removed regardless of quantum threat.

**HMAC and KDF constructions:** Generally unaffected by quantum threat if the underlying hash function and key length are adequate. Review for SHA-1 or MD5 dependencies only.

**Post-quantum symmetric research:** NIST's lightweight cryptography project and ongoing symmetric cipher research are separate from the PQC public-key migration programme. Monitor but do not defer public-key migration pending symmetric research outcomes.

The enterprise threat model should allocate primary migration resources to **quantum-vulnerable public-key cryptography** — RSA, DH, ECC, ECDSA, EdDSA — and treat symmetric review as a secondary hygiene activity.

---

## 2.17 Threat-Informed Control Selection

Threat analysis does not end at prioritisation. It informs **which controls** to implement during each migration phase. The following mapping connects threat tiers to control investments, helping security leaders allocate limited budgets across the programme horizon.

**Table 2.6 — Threat Tier × Control Investment Matrix**

| Priority tier | Immediate controls (Year 1) | Medium-term controls (Years 2–4) | Long-term controls (Years 5+) |
|--------------|----------------------------|-----------------------------------|------------------------------|
| **Immediate** | CBOM discovery; HNDL pathway encryption upgrade; vendor escalation | Production PQC or hybrid deployment; key ceremony adaptation | Full PQC-native transition |
| **High** | CBOM discovery; data classification validation; agility requirements in new builds | Hybrid deployment; PKI profile updates | PQC-native transition |
| **Moderate** | CBOM inclusion; agility requirements for new systems | Hybrid when ecosystem ready | Scheduled migration in refresh cycle |
| **Low** | CBOM inclusion | Migrate during natural refresh | Defer unless classification changes |
| **Minimal** | CBOM documentation | No action unless decommission delayed | Decommission |

For Immediate-tier systems, the Year 1 control investment may be substantial — Northfield's VPN concentrator hardware refresh is an example of threat urgency converting directly to capital expenditure. For Minimal-tier systems, the primary Year 1 investment is CBOM documentation to confirm that decommission schedules are credible.

### Red team exercises focused on HNDL

Traditional red team exercises test detection and response to active intrusion. HNDL-focused exercises test a different question: **can an adversary collect ciphertext from high-value systems without detection?**

Exercise design:

1. Identify three to five TES 5 systems from the CBOM
2. Red team attempts passive collection of encrypted traffic or archives from each
3. Document collection points: network taps, compromised backup systems, misconfigured logging, partner integration endpoints
4. Map collection success to migration priority elevation

Northfield conducted an HNDL-focused exercise six months after the historian SOC anomaly. The red team successfully collected ciphertext from four of five target systems. Two collection paths had not appeared in the original threat assessment. Both were added to Wave 1 with elevated TES scores.

The exercise cost less than a standard penetration test. It produced more actionable PQC prioritisation data than any algorithm benchmark.

---

## 2.18 Documentation, ERM, and Cloud (Cross-References)

Threat analysis must be documented to exist for regulatory and audit purposes. Required document structure, ERM integration, and board reporting cadence are specified in Chapter 3 (§3.7–3.8) and Chapter 15 (§15.3). Cloud shared responsibility and tenant-variable TES assignment for SaaS providers are developed in Chapter 14.

---

## 2.19 Apply in Your Organisation

1. **Separate threat categories.** Ensure programme materials distinguish CRQC horizon, HNDL urgency, and agility requirements — not a single "quantum threat" score.
2. **Assign confidentiality horizons from governance artefacts.** Cite retention schedules, contracts, or classification policy for every TES 4–5 system.
3. **Run a four-hour threat workshop** using §2.12 methodology before finalising migration wave sequence.
4. **Calculate MPI with documented weights.** Use default weights in §2.13 unless sector overlay modifies them.
5. **Schedule annual re-scoring** (quarterly for TES 5 systems in regulated or critical infrastructure sectors).

---

## 2.20 Chapter Summary

- Three threat categories — CRQC arrival, HNDL, and classical PQC cryptanalysis — serve different decision functions. Conflating them produces misprioritisation.
- HNDL is the primary driver of migration priority. It is determined by data confidentiality horizon, not by quantum computer timelines.
- Confidentiality horizons derive from data governance artefacts: classification, retention, contractual obligations, and legal holds.
- Authentication and integrity require separate horizon analysis: how long must signatures made today remain trustworthy?
- The TRADE Threat dimension converts threat model outputs into scored, auditable prioritisation inputs.
- Sector context modifies threat weights: financial services, critical infrastructure, defence, SaaS, and healthcare each carry distinct threat profiles.
- Threat intelligence, red team findings, and DLP monitoring provide empirical inputs to TES scoring.
- Threat analysis identifies what to protect. Dependency analysis (Chapter 8) identifies what to migrate first. Both are necessary.

**Next:** Chapter 3 maps the regulatory and policy landscape — the forcing functions that convert threat analysis into compliance obligations and evidence requirements.

---

*Chapter 2 — References*

- Basescu, C., Hemsley, G., Khosla, N., Machado, L., Quach, W., Ravichandran, R., Tromer, E., & Wong, D. (2024). Deployment considerations for secure post-quantum cryptography in practice. *Proceedings of the USENIX Security Symposium*. https://www.usenix.org/conference/usenixsecurity24/presentation/basescu
- Campbell, R. (2025). Enterprise migration to post-quantum cryptography: Timeline analysis and strategic frameworks. *Computers*, 15(1), 9. https://doi.org/10.3390/computers15010009
- Cybersecurity and Infrastructure Security Agency. (2024). Post-quantum cryptography initiative. https://www.cisa.gov/quantum
- European Union Agency for Cybersecurity. (2025). *NIS2 implementation guidance* (cryptographic recommendations). https://www.enisa.europa.eu/
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- National Security Memorandum 10 (2022). The White House.
- World Economic Forum. (2024). *Quantum security: Preparing for the post-quantum era*. https://www.weforum.org/publications/quantum-security/
