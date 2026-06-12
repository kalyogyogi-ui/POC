# Chapter 2
# Threat Models That Drive Priorities

---

The security operations centre at Northfield Energy Systems recorded the anomaly at 02:14 on a Tuesday in October: a scheduled backup of SCADA historian archives — ten years of operational telemetry from three gas transmission compressor stations — transited a WAN link to a geographically separated disaster recovery site. The traffic was encrypted with IPsec using IKEv2 and ECDH-P256 key exchange. The encryption was correctly implemented. The certificates were valid. The cipher suite met Northfield's written policy.

It also represented approximately 4.2 terabytes of operational data whose confidentiality horizon extended well beyond any reasonable estimate for quantum-safe protection on that link. Northfield's threat model, like most utilities, prioritized availability and integrity of real-time control systems. Confidentiality of historical archives ranked lower. The quantum threat reframed that ranking entirely.

The adversary capable of exploiting a future cryptographically relevant quantum computer does not need to compromise Northfield's control network today. Recording encrypted historian traffic requires passive collection — a capability well within the means of sophisticated threat actors operating against critical infrastructure. The decryption can wait. The collection cannot.

This chapter replaces quantum threat hype with the decision-grade threat analysis that determines migration sequence. Not all quantum risk is equal. The enterprises that migrate effectively are those that distinguish between threats that demand action now and threats that remain bounded by shorter time horizons.

---

## 2.1 Separating Threat Categories

Enterprise security teams encounter three distinct quantum-related threat narratives. Conflating them produces either panic or paralysis.

### Category 1: Cryptographically relevant quantum computers (CRQCs)

A CRQC is a quantum computer capable of executing Shor's algorithm at sufficient scale to break widely deployed public-key cryptography — RSA-2048, RSA-3072, ECC P-256, ECC P-384, and finite-field Diffie-Hellman at comparable security levels. No such machine exists today. Expert projections for CRQC arrival span a wide range, and honest analysis acknowledges genuine uncertainty.

CRQC threat analysis matters for **long-term programme planning** and **regulatory horizon-setting**. It does not, by itself, tell you which system to migrate this quarter.

### Category 2: Harvest now, decrypt later (HNDL)

HNDL — also called store-now-decrypt-later — describes an attack in which an adversary records encrypted data today and retains it until quantum decryption becomes feasible. The attack requires no quantum capability at collection time. It requires only access to ciphertext and patience.

HNDL threat analysis matters for **prioritization**. It converts a future quantum threat into a present-tense collection incentive. The urgency of HNDL is determined not by quantum computer timelines but by **data confidentiality lifetime** — how long the protected data must remain secret.

### Category 3: Pre-quantum cryptanalytic advances

Classical cryptanalysis of post-quantum algorithm candidates continues. NIST's selection process explicitly accounts for this risk by standardizing multiple algorithm families. Implementation vulnerabilities — side channels, fault injection, misuse — affect PQC algorithms as they affect classical algorithms.

This category matters for **algorithm agility** and **validation discipline**. It does not justify delaying migration to quantum-vulnerable classical algorithms.

**Table 2.1 — Threat Category Decision Relevance**

| Category | Drives programme charter? | Drives migration priority? | Drives algorithm selection? |
|----------|--------------------------|---------------------------|----------------------------|
| CRQC arrival | Yes — establishes horizon | Indirectly — via HNDL | No — NIST has selected |
| HNDL | Yes — establishes urgency | **Yes — primary driver** | Indirectly — via data class |
| Classical PQC breaks | Yes — establishes agility need | No — affects agility design | Yes — contingency planning |

The remainder of this chapter focuses on HNDL and confidentiality horizon analysis, because these are the threat dimensions most frequently mishandled in enterprise prioritization.

---

## 2.2 The Confidentiality Horizon

Every encrypted asset has a confidentiality horizon: the period during which unauthorized disclosure would cause material harm. This horizon is independent of certificate validity, key rotation frequency, or quantum computer forecasts.

Consider three assets in the same enterprise:

1. **A TLS session** protecting a customer account balance inquiry. Confidentiality horizon: seconds to minutes. The session key is ephemeral. Even if recorded, the balance changes before any adversary could act on the information.

2. **An encrypted email** containing a merger negotiation. Confidentiality horizon: months to years. Disclosure before announcement would enable insider trading or competitive harm.

3. **A SCADA historian archive** containing thirty years of pipeline operational data. Confidentiality horizon: decades. Disclosure reveals infrastructure topology, maintenance patterns, capacity constraints, and vulnerability windows exploitable for physical disruption.

All three may use ECDH-P256 or RSA-2048. All three are quantum-vulnerable. They do not share the same migration priority.

The confidentiality horizon is determined by business impact analysis, not by cryptographic properties. Legal holds, regulatory retention requirements, trade secret classifications, national security designations, and operational sensitivity all extend horizons beyond what technical teams typically model.

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

---

## 2.3 Authentication and Integrity Horizons

Confidentiality dominates PQC threat discourse because Shor's algorithm breaks the key establishment and encryption functions of public-key cryptography. Migration prioritization that considers only confidentiality is incomplete.

### Digital signatures and authentication

Quantum computers break the discrete logarithm and factoring problems that underpin RSA and ECDSA signatures. When a CRQC arrives, a quantum-capable adversary could forge signatures that verifiers would accept as legitimate — enabling impersonation, fraudulent code execution, and document forgery.

The HNDL framing applies differently here. Signatures are not "stored for later decryption." The threat is **future forgery**, not retroactive disclosure. The urgency driver is the **validity period of trust** placed in current signatures:

- A code signing certificate used to validate firmware updates creates a trust chain whose integrity must hold for the firmware's operational lifetime — potentially decades for embedded systems.
- A document signed for legal purposes may require non-repudiation for the document's legal enforceability period.
- A TLS certificate's signature vouches for identity for the certificate's validity period.

For authentication and integrity, the relevant question is: **how long must signatures made today remain trustworthy?** If the answer exceeds the CRQC arrival window, migration is urgent.

### Integrity of long-validity artefacts

Northfield Energy's OT environment illustrates this distinction. Compressor station firmware images are signed at manufacture and validated at installation. The signing certificate may have a ten-year validity. The firmware may operate for twenty years. The trust placed in the manufacturer's signature must survive both periods.

If quantum forgery becomes feasible within that window, an adversary could produce counterfeit firmware updates that pass signature validation — a threat to integrity and availability more severe than passive confidentiality breach.

NIST IR 8547's treatment of authentication systems acknowledges nuance: some authentication contexts may warrant different transition timelines than key-establishment systems. Enterprises should not interpret this as permission to defer all authentication migration. They should interpret it as requiring **context-specific horizon analysis** rather than uniform urgency.

---

## 2.4 The TRADE Threat Dimension

Chapter 1 introduced the TRADE Decision Engine — a prioritization framework scoring systems across five dimensions: **T**hreat exposure, **R**egulatory obligation, **A**rchitectural dependency, **D**ata longevity, and **E**cosystem readiness. This section develops the Threat dimension in detail. Subsequent chapters develop the remaining dimensions.

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
- Cross-organizational trust anchors (federated identity, partner PKI)

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

### Threat actor capability alignment

Threat exposure is not assessed in a vacuum. The enterprise's threat model — derived from its sector, geography, and asset value — determines which adversary capabilities are relevant.

A regional retail bank and a defense prime contractor may score identical TES on paper but face different adversary collection capabilities. Northfield Energy, operating gas transmission infrastructure, models nation-state collection of WAN traffic as a credible scenario. A mid-market logistics SaaS provider may model criminal data exfiltration as the primary threat, with HNDL as a secondary concern.

The TRADE framework does not replace threat modelling. It **consumes** threat model outputs and converts them into migration-relevant scores. Security teams should document the threat actor assumptions underlying each TES assignment. Auditors and regulators will ask.

**Table 2.2 — Data Classification × Algorithm Vulnerability Matrix**

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

## 2.5 Sector-Specific Threat Calibration

Threat models are not universal. The Sector Overlay Matrix (SOM), developed in Part VI, modifies TRADE weights by industry. Part I establishes the calibration principles.

### Financial services

Threat drivers: HNDL against transaction records and customer data with regulatory retention requirements; authentication forgery enabling fraudulent transactions; supply-chain compromise of payment hardware. Regulatory frameworks (DORA, PCI DSS, PSD2) create evidence obligations that amplify threat consequences even when direct HNDL collection is not the primary adversary model.

TRADE modification: increase Regulatory obligation weight (Chapter 3); treat payment HSM and card scheme trust chains as TES 4 minimum regardless of data horizon.

### Critical infrastructure and energy

Threat drivers: HNDL against operational technology data revealing physical system topology; long-lived firmware trust chains; nation-state collection against WAN and radio links; safety system integrity. Availability and integrity often dominate confidentiality in traditional OT threat models — PQC migration must not compromise either.

TRADE modification: increase Data longevity weight for OT archives; treat firmware signing as TES 5; require OT security sign-off before any migration action affecting control system availability.

### Defense and government

Threat drivers: classified and controlled unclassified information with indefinite confidentiality requirements; CNSA 2.0 compliance as binding mandate; adversary collection assumed as baseline capability. Threat analysis is less speculative and more policy-driven.

TRADE modification: Regulatory obligation weight effectively overrides other dimensions for NSS-aligned systems; consult CNSA 2.0 timelines as floor, not ceiling.

### Multinational SaaS and technology

Threat drivers: tenant data isolation breaches amplified by quantum decryption; cross-border data residency implications; API authentication forgery at scale; intellectual property in encrypted backups. Threat model varies by tenant data classification.

TRADE modification: increase Ecosystem readiness weight (tenant and partner dependencies); treat platform-level cryptographic services as Architectural dependency blocking nodes.

---

## 2.6 What the Threat Model Does Not Justify

Rigorous threat analysis includes discipline about what it does **not** support.

### It does not justify algorithm shopping

Threat analysis determines **when** and **what priority** to migrate. NIST FIPS 203, 204, and 205 determine **to which algorithms**. Enterprises that use threat uncertainty to defer standard algorithm adoption — waiting for "better" candidates — confuse contingency planning with migration execution. FN-DSA and HQC remain in NIST evaluation for diversification. ML-KEM, ML-DSA, and SLH-DSA are the deployment standards.

### It does not justify symmetric algorithm replacement

AES-256 and SHA-256/SHA-3 families are considered quantum-resistant at current security levels. Grover's algorithm provides a quadratic speedup against symmetric keys, manageable by doubling key length. Enterprise threat models should not allocate migration resources to replacing symmetric cryptography unless a specific vulnerability exists.

### It does not justify quantum key distribution (QKD) as primary strategy

QKD addresses key distribution through quantum physical properties. It does not replace the need for post-quantum public-key cryptography in TLS, PKI, code signing, or the vast majority of enterprise use cases. QKD may have niche applicability in specific government and telecommunications contexts. It is not an enterprise migration strategy. This book does not develop QKD architecture.

### It does not justify permanent risk acceptance without documentation

Some systems will not migrate before CRQC arrival. Legacy OT devices, unsupported vendor appliances, and contractual dead-ends exist in every large estate. Threat analysis must identify them explicitly. NIST IR 8547 contemplates documented risk acceptance for systems that cannot transition by disallowance dates. Undocumented risk acceptance is not a strategy. It is an audit finding waiting to happen.

---

## 2.7 Northfield Energy: Threat Analysis in Practice

Return to the SCADA historian archive. Northfield's security team, after the SOC anomaly review, conducted a structured threat assessment applying the framework in this chapter.

**Asset:** IPsec-encrypted historian replication traffic and stored archives at DR site.

**Confidentiality horizon:** Thirty years minimum. Pipeline topology, capacity data, maintenance schedules, and safety system configurations have operational and national security sensitivity exceeding any CRQC arrival projection.

**TES assignment:** 5 (Critical). Nation-state HNDL collection against energy infrastructure is an explicit scenario in CISA and sector ISAC threat advisories.

**Authentication horizon:** Firmware signing certificates on compressor station controllers: ten-year validity, twenty-year operational life. TES 5 for integrity.

**What did not rank as high:** Real-time Modbus/TCP control traffic within the station LAN, protected by network segmentation rather than encryption. Confidentiality horizon near-zero for ephemeral control commands. TES 2. Migration deferred — but network segmentation evidence documented for auditors.

**Surprise finding:** The DR site's backup encryption used a VPN concentrator whose firmware could not support ML-KEM without a hardware refresh not scheduled until 2029. Threat urgency met ecosystem immobility. Northfield escalated the concentrator to the Architectural dependency register (Chapter 8) and initiated procurement action — the first instance where threat analysis directly drove a capital expenditure decision in the PQC programme.

Northfield's experience illustrates the chapter's central lesson: **threat analysis produces a priority map, not a project list.** The map must be reconciled with dependency topology and ecosystem readiness before it becomes a migration plan.

---

## 2.8 From Threat Analysis to Programme Justification

Threat models serve two audiences: the security team, which needs prioritization logic, and the board, which needs a credible case for multi-year investment.

Board-level threat narrative should emphasize three points:

1. **The HNDL threat is current.** Adversaries do not need quantum computers to begin compromising the enterprise's long-term confidentiality. Collection is happening now against high-value targets globally. This is documented in intelligence community and sector ISAC reporting, not in vendor marketing.

2. **The cost of early action is lower than the cost of late discovery.** Cryptographic inventory, agility requirements in new systems, and hybrid deployment pilots are modest investments relative to the cost of emergency migration under regulatory deadline pressure — or the cost of explaining to regulators why long-lived customer data was protected by algorithms NIST will disallow.

3. **The cost of inaction is asymmetric.** Quantum-vulnerable cryptography fails catastrophically when CRQCs arrive — not gradually, not with warning signs in the ciphertext. The enterprise either migrates on its timeline or on the adversary's.

The board does not need to understand lattice cryptography. It needs to understand that confidentiality horizons, not quantum computer press releases, determine whether the organization is already late.

---

## 2.9 Chapter Summary

- Three threat categories — CRQC arrival, HNDL, and classical PQC cryptanalysis — serve different decision functions. Conflating them produces misprioritization.
- HNDL is the primary driver of migration priority. It is determined by data confidentiality horizon, not by quantum computer timelines.
- Authentication and integrity require separate horizon analysis: how long must signatures made today remain trustworthy?
- The TRADE Threat dimension converts threat model outputs into scored, auditable prioritization inputs.
- Sector context modifies threat weights: financial services, critical infrastructure, defense, and SaaS each carry distinct threat profiles.
- Threat analysis identifies what to protect. Dependency analysis (Chapter 8) identifies what to migrate first. Both are necessary.

**Next:** Chapter 3 maps the regulatory and policy landscape — the forcing functions that convert threat analysis into compliance obligations and evidence requirements.

---

*Chapter 2 — References*

- Campbell, R. (2025). Enterprise Migration to Post-Quantum Cryptography: Timeline Analysis and Strategic Frameworks. *Computers*, 15(1), 9.
- Cybersecurity and Infrastructure Security Agency. (2024). Post-Quantum Cryptography Initiative.
- European Union Agency for Cybersecurity. (2025). NIS2 Implementation Guidance (cryptographic recommendations).
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to Post-Quantum Cryptography Standards.
- National Security Memorandum 10 (2022).
- World Economic Forum. (2024). Quantum Security: Preparing for the Post-Quantum Era.
