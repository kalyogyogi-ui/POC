# Chapter 3
# The Regulatory and Policy Landscape

---

Meridian Mutual Bank's General Counsel received the DORA compliance briefing in January 2025, six weeks after the regulation's entry into force. The briefing, prepared by external counsel, was thorough on ICT risk management frameworks, incident reporting timelines, and third-party oversight obligations. It devoted four paragraphs to encryption policy.

Paragraph three contained the sentence that redirected Meridian's PQC programme: *"Financial entities shall design cryptographic control policies on the basis of ICT risk assessment, taking into account developments in cryptanalysis, including threats from quantum advancements."*

The sentence did not mention post-quantum cryptography. It did not reference ML-KEM, FIPS 203, or migration timelines. It did not require migration by a specific date. It required something more demanding: a **documented, risk-based cryptographic governance programme** that could withstand supervisory scrutiny when quantum threats materialized — and that demonstrably accounted for them before they did.

Meridian's legal team asked the question that compliance officers across Europe were asking in the same quarter: *What evidence satisfies this obligation?*

This chapter answers that question for Meridian and for every reader responsible for regulatory defensibility. The regulatory landscape does not treat PQC as a standalone mandate in most jurisdictions. It treats state-of-the-art cryptographic practice as a continuing obligation — one that, after August 2024, cannot be met without a credible post-quantum trajectory.

---

## 3.1 The Regulatory Logic

Regulators rarely prescribe specific algorithms in primary legislation. They prescribe outcomes: data protected, risks assessed, controls maintained at the state of the art. Cryptographic requirements emerge through layered instruments — regulations, technical standards, supervisory guidance, and audit practice — that converge on a common expectation.

For post-quantum cryptography, the convergence pattern is:

1. **A regulation** requires risk-based security measures and encryption policies.
2. **A technical standard or regulatory technical standard** specifies what those policies must address.
3. **A standards body** (NIST, ETSI, ISO) publishes the algorithms and transition timelines defining state of the art.
4. **Supervisory guidance** interprets the gap between current practice and state of the art as a compliance deficiency.
5. **Audit practice** requests evidence.

PQC compliance is therefore demonstrated not by citing a regulation that says "use ML-KEM" but by presenting a **documented programme** that supervisory reviewers recognize as state-of-the-art cryptographic governance in a post-2024 environment.

This logic applies across jurisdictions. The specific instruments differ. The evidentiary standard does not.

---

## 3.2 United States Federal Framework

### National Security Memorandum 10

NSM-10, issued in May 2022, established U.S. policy for quantum computing and cryptographic transition. Its core requirement: migrate vulnerable cryptographic systems to quantum-resistant alternatives with the goal of mitigating quantum risk **as far as is feasible by 2035**.

NSM-10 is policy, not regulation. Its binding force for federal agencies derives from implementation through OMB guidance, NIST standards, and agency-specific requirements. Its influence on commercial enterprises is indirect but substantial: federal procurement requirements, supply chain standards, and the de facto authority of NIST FIPS create market pressure that commercial CISOs cannot ignore.

### NIST IR 8547 transition timelines

NIST's Initial Public Draft of IR 8547 (November 2024) articulates the expected transition:

- **After 2030:** Deprecation of quantum-vulnerable public-key algorithms at the 112-bit security level. Continued use requires documented risk acceptance.
- **After 2035:** Disallowance of quantum-vulnerable public-key algorithms in federal systems and standards.

These dates are policy anchors, not suggestions. NIST has stated they will inform revisions to SP 800-131A and other algorithm transition documents. Federal contractors, cloud providers serving federal customers, and enterprises whose auditors reference NIST guidance will encounter these dates as de facto compliance milestones.

> **Regulatory Lens**
>
> NIST IR 8547 was in initial public draft status at the time of this writing, with final publication expected following comment resolution. Enterprises should monitor the final publication and treat draft timelines as planning anchors subject to revision. Programme structure should accommodate timeline adjustment without restructuring the programme itself.

### NSA CNSA 2.0

The Commercial National Security Algorithm Suite 2.0, published by NSA in 2022 and updated through 2023, defines the algorithm policy for National Security Systems. CNSA 2.0 mandates:

| Milestone | Requirement |
|-----------|-------------|
| 2025 | Existing NSS must meet CNSA 1.0 or obtain waiver |
| 2027 | New NSS acquisitions must be CNSA 2.0 compliant |
| 2030 | Software and firmware signing uses PQC; networking equipment exclusively CNSA 2.0 |
| 2033 | Most NSS platforms migrated |
| 2035 | All NSS, including custom and legacy, fully migrated |

CNSA 2.0 specifies ML-KEM-1024, ML-DSA-87, and SLH-DSA as the approved suite, with hybrid key establishment required during transition. Defense contractors, FedRAMP-authorized cloud providers, and enterprises serving the defense industrial base encounter CNSA 2.0 as a **contractual and certification requirement**, not advisory guidance.

### CISA and sector agency initiatives

The Cybersecurity and Infrastructure Security Agency's Post-Quantum Cryptography Initiative coordinates federal outreach to critical infrastructure sectors. Sector Risk Management Agencies have issued sector-specific guidance aligning with NIST transition timelines. For critical infrastructure operators, these instruments create supervisory expectations even where no statute explicitly names PQC.

---

## 3.3 European Union Framework

### Digital Operational Resilience Act (DORA)

DORA (Regulation (EU) 2022/2554) entered into force on 16 January 2023 and became applicable on 17 January 2025. It applies to more than twenty categories of financial entity: credit institutions, payment institutions, investment firms, insurance undertakings, crypto-asset service providers, and critical ICT third-party providers among them.

Article 9 requires financial entities to establish ICT security policies including encryption and cryptographic controls. The binding detail arrives in **Commission Delegated Regulation (EU) 2024/1532** — the Regulatory Technical Standards on ICT risk management — which specifies:

**On encryption policy design (RTS Article 6):**

Financial entities shall develop, document, and implement a policy on encryption and cryptographic controls, designed on the basis of data classification and ICT risk assessment. The policy shall address:

- Encryption of data at rest, in transit, and where necessary in use
- Criteria for selecting cryptographic techniques, taking into account **leading practices and standards**
- Lifecycle key management including generation, distribution, renewal, and destruction
- A register of certificates for ICT assets supporting critical or important functions

**On cryptanalytic developments (RTS Recital 9):**

> *"Given the complexity of encryption and the dynamic landscape of cryptographic threats, including threats from quantum advancements, financial entities should follow a flexible approach, based on risk mitigation and monitoring, to deal with developments in cryptanalysis and consider leading practices and standards."*

This recital is the source of the sentence that redirected Meridian's legal team. Its implications:

1. **Static encryption policies are non-compliant.** A policy written before 2024 that does not address quantum threat is deficient on its face.
2. **"Leading practices and standards"** imports NIST FIPS 203–205 and NIST IR 8547 into EU supervisory expectations for financial entities, even where EU-specific PQC standards remain under development.
3. **The certificate register** requirement creates an auditable artefact directly aligned with CBOM and Cryptographic Dependency Graph methodology (Chapters 7–8).
4. **Flexibility** means documented risk-based phasing, not indefinite deferral.

DORA's third-party ICT risk management provisions (Articles 28–30) extend these expectations to critical suppliers. A financial entity's PQC programme that does not assess vendor cryptographic posture is incomplete under DORA's supply chain obligations.

### NIS2 Directive

Directive (EU) 2022/2555 (NIS2) requires essential and important entities across energy, transport, health, digital infrastructure, financial market infrastructure, and other sectors to implement appropriate and proportionate technical and organizational measures — including encryption — based on an all-hazards risk assessment.

NIS2 does not explicitly reference quantum computing. It requires measures **consistent with the state of the art**. ENISA's implementation guidance, published in 2025, recommends that entities adopt quantum-resistant algorithms to protect sensitive data against harvest-now-decrypt-later attacks.

For financial entities, DORA is **lex specialis** — it prevails over NIS2 where both apply to the same obligation. For energy companies like Northfield Energy, NIS2 (as transposed into national law) is the primary cryptographic compliance vehicle. Northfield's PQC programme must satisfy NIS2 Article 21 risk management measures and produce evidence that encryption controls reflect state-of-the-art practice.

**Table 3.1 — Regulatory Mapping Matrix (Selected Frameworks)**

| Framework | Jurisdiction | Explicit PQC reference? | Effective obligation | Primary evidence artefact |
|-----------|-------------|------------------------|---------------------|--------------------------|
| NSM-10 | US (policy) | Yes — 2035 target | Federal; supply chain influence | Migration programme plan |
| NIST IR 8547 | US (guidance) | Yes — 2030/2035 | Federal; industry de facto | Risk acceptance documentation |
| CNSA 2.0 | US (NSS) | Yes — algorithm suite | NSS; defense contractors | CNSA compliance certification |
| DORA RTS 2024/1532 | EU (financial) | Implicit — quantum in recital | Financial entities (Jan 2025) | Encryption policy; certificate register |
| NIS2 | EU (multi-sector) | Implicit — state of the art | Essential/important entities | Risk assessment; encryption controls |
| GDPR Art. 32 | EU (data protection) | No — state of the art | All personal data controllers | TOMs documentation |
| PCI DSS 4.0 | Global (payments) | Emerging — crypto inventory | Card data environments | Cryptographic architecture documentation |
| UK NCSC guidance | UK | Yes — planning by 2028 | Government; industry guidance | Migration roadmap |
| ASD guidance | Australia | Yes — cease traditional PKC by 2030 | Australian government | Crypto transition plan |

---

## 3.4 GDPR and Data Protection Law

The General Data Protection Regulation does not mention quantum computing. Article 32 requires controllers and processors to implement **appropriate technical and organizational measures** ensuring a level of security appropriate to the risk, taking into account the state of the art.

Data protection authorities have not, as of this writing, issued binding enforcement decisions specifically requiring PQC migration. The compliance logic is anticipatory:

- If NIST and ENISA define post-quantum algorithms as state of the art for long-term data protection
- And if a controller processes personal data with confidentiality requirements extending beyond CRQC arrival timelines
- Then continued reliance on quantum-vulnerable encryption for that data is difficult to defend as "appropriate" under Article 32

This is particularly acute for **special categories of personal data** under Article 9 (health, biometric, genetic, racial, political) and for data subject to **legal retention requirements** that extend confidentiality horizons beyond quantum threat timelines.

GDPR compliance officers should coordinate with security teams to ensure that Records of Processing Activities (Article 30) and Data Protection Impact Assessments (Article 35) reference cryptographic controls and their PQC migration status. A DPIA that identifies long-term confidentiality risks without addressing PQC migration is incomplete.

Cross-border data transfer mechanisms — Standard Contractual Clauses, Binding Corporate Rules — increasingly reference encryption as a supplementary measure. Transfer impact assessments should address whether encryption protecting transferred data will remain adequate for the transfer's duration.

---

## 3.5 PCI DSS and Payment Industry Standards

PCI DSS version 4.0, with phased requirements taking effect through March 2025, introduces enhanced cryptographic documentation obligations. While PCI SSC has not mandated specific PQC algorithms, the standard's architecture documentation requirements (Requirements 2, 4, and 12) create audit surfaces where quantum-vulnerable cryptography will be questioned.

Payment networks and card schemes are developing PQC migration guidance independently. Merchants and acquirers should monitor scheme publications and treat payment HSM certification cycles as binding constraints on migration timelines — as Meridian discovered in Chapter 1.

---

## 3.6 United Kingdom, Australia, and Other National Frameworks

### United Kingdom

NCSC guidance establishes that UK government organizations should complete PQC discovery and planning by 2028, with migration execution through 2035. The guidance applies to government directly and serves as supervisory reference for critical national infrastructure operators in the private sector.

### Australia

The Australian Signals Directorate's Information Security Manual directs Australian government systems to cease traditional asymmetric cryptography by 2030. The timeline is more aggressive than NIST IR 8547's deprecation anchor. Multinational enterprises with Australian government contracts should treat this as a binding contractual requirement.

### Other jurisdictions

Canada (Canadian Centre for Cyber Security), Japan (METI/ISC), and Singapore (CSA) have published PQC awareness and planning guidance aligned with NIST standards. Enterprises operating across multiple jurisdictions should maintain a **regulatory overlay** in their programme — a single migration plan with jurisdiction-specific milestone annotations, not separate programmes per country.

---

## 3.7 What Evidence Satisfies the Obligation

Regulators and auditors do not accept awareness as compliance. The following artefacts, mapped to the PQC Governance Stack introduced in this chapter, constitute the evidence package a supervisory review should find.

### Strategic layer (board and executive)

- Quantum risk documented in enterprise risk management register
- Board-approved PQC migration programme charter with scope, authority, and funding
- Annual board reporting on migration progress against milestones

### Programme layer

- Cross-functional steering committee with defined membership and meeting cadence
- Migration wave plan with TRADE-scored priorities (Chapter 9)
- Budget allocation and resource plan covering multi-year horizon

### Policy layer

- Cryptographic standards policy referencing NIST FIPS 203–205 as approved algorithms
- Hybrid deployment policy with defined lifecycle phases (Chapter 11)
- Exception and risk acceptance process aligned with NIST IR 8547 documentation requirements
- Procurement policy clauses requiring supplier PQC readiness (Chapter 16)

### Operational layer

- Cryptographic Bill of Materials maintained and current (Chapter 7)
- Cryptographic Dependency Graph with identified blocking nodes (Chapter 8)
- Certificate register for critical and important functions (DORA RTS Article 6)
- Change management records for cryptographic transitions

### Assurance layer

- Internal audit plan covering cryptographic controls
- Penetration testing scope including cryptographic configuration review
- Third-party assessments of critical cryptographic systems
- Regulatory examination readiness package

No single artefact satisfies the obligation. Compliance is demonstrated by the **coherence of the package** — policies that reference inventories, inventories that inform migration plans, migration plans that produce change records, and change records that auditors can verify.

> **Regulatory Lens — Meridian Mutual Bank**
>
> Meridian's DORA compliance workstream mapped each RTS Article 6 requirement to a PQC programme deliverable. The encryption policy update (policy layer) referenced NIST FIPS 203–205 and established ML-KEM and ML-DSA as approved algorithms for new deployments. The certificate register (operational layer) was populated from the CBOM discovery in Phase 1. The gap between policy and current state — 14,200 assets, 89% quantum-vulnerable — was documented as the migration programme scope, not concealed. Supervisory reviewers respond better to documented gaps with credible remediation plans than to policies that overstate current compliance.

---

## 3.8 The PQC Governance Stack

The regulatory evidence requirements converge on a governance architecture this book calls the **PQC Governance Stack** — five layers from board strategy to operational assurance.

**Figure 3.1 — PQC Governance Stack**

```
┌─────────────────────────────────────────────────────────┐
│  STRATEGIC     Board risk appetite · ERM integration    │
│                Quantum risk · Programme charter         │
├─────────────────────────────────────────────────────────┤
│  PROGRAMME     Migration authority · Steering committee │
│                Wave plan · Budget · KPIs                │
├─────────────────────────────────────────────────────────┤
│  POLICY        Algorithm standards · Hybrid policy      │
│                Exception process · Procurement clauses  │
├─────────────────────────────────────────────────────────┤
│  OPERATIONAL   CBOM · CDG · Certificate register        │
│                Change management · Validation gates     │
├─────────────────────────────────────────────────────────┤
│  ASSURANCE     Internal audit · Penetration testing     │
│                Third-party assessment · Exam readiness  │
└─────────────────────────────────────────────────────────┘
         Evidence flows upward. Authority flows downward.
```

Each layer produces artefacts. Each layer is accountable to the layer above. Programme layer decisions cannot override Strategic layer risk appetite. Operational layer activities must implement Policy layer standards. Assurance layer findings feed back to Programme and Strategic layers.

Chapter 15 develops the Governance Stack into an operating model. Part I establishes it as the structural response to the regulatory logic in this chapter: **compliance is a governance property, not a cryptographic one.**

---

## 3.9 Regulatory Convergence and Programme Design

A practical implication of the landscape above: **enterprises should not design separate compliance programmes for each regulation.** The CBOM satisfies DORA's certificate register requirement and NIS2's risk assessment evidence. The migration wave plan satisfies NSM-10's 2035 objective and NIST IR 8547's transition expectations. The encryption policy satisfies DORA RTS Article 6 and GDPR Article 32's state-of-the-art requirement.

Divergent compliance programmes — one for DORA, one for NIST, one for PCI — produce inconsistent priorities, duplicated discovery effort, and audit findings when artefacts contradict each other.

The recommended approach is a **single PQC migration programme** with a regulatory overlay matrix (Appendix C) annotating which artefacts satisfy which obligations in which jurisdictions. Northfield Energy, subject primarily to NIS2 and NERC CIP, uses the same programme structure as Meridian Mutual Bank, subject primarily to DORA — with sector and jurisdiction annotations, not separate architectures.

---

## 3.10 Chapter Summary

- Most regulations do not name PQC algorithms. They require state-of-the-art cryptographic governance that, after August 2024, necessarily includes a documented PQC trajectory.
- U.S. federal framework: NSM-10 (2035 target), NIST IR 8547 (2030/2035 deprecation/disallowance), CNSA 2.0 (binding for NSS and defense industrial base).
- EU framework: DORA RTS 2024/1532 (encryption policy, certificate register, quantum in recital 9), NIS2 (state of the art), GDPR Article 32 (appropriate measures).
- Compliance evidence is a coherent package of governance artefacts — not a single certificate or algorithm deployment.
- The PQC Governance Stack (Strategic, Programme, Policy, Operational, Assurance) structures the evidence package.
- One programme, multiple regulatory overlays — not parallel compliance silos.

**Next:** Part II begins the standards literacy that architects and engineers require — treating FIPS 203, 204, and 205 as inputs to programme decisions, not as the programme itself.

---

*Chapter 3 — References*

- Commission Delegated Regulation (EU) 2024/1532 (DORA RTS on ICT risk management).
- European Union Agency for Cybersecurity. (2025). NIS2 Implementation Guidance.
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to Post-Quantum Cryptography Standards.
- National Security Agency. (2022–2023). Commercial National Security Algorithm Suite 2.0.
- National Security Memorandum 10 (2022).
- Regulation (EU) 2022/2554 (DORA).
- Directive (EU) 2022/2555 (NIS2).
- Regulation (EU) 2016/679 (GDPR).
