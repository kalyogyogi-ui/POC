# Chapter 3
# The Regulatory and Policy Landscape

---

Meridian Mutual Bank's General Counsel received the DORA compliance briefing in January 2025, six weeks after the regulation's entry into force. The briefing, prepared by external counsel, was thorough on ICT risk management frameworks, incident reporting timelines, and third-party oversight obligations. It devoted four paragraphs to encryption policy.

Paragraph three contained the sentence that redirected Meridian's PQC programme: *"Financial entities shall design cryptographic control policies on the basis of ICT risk assessment, taking into account developments in cryptanalysis, including threats from quantum advancements."*

The sentence did not mention post-quantum cryptography. It did not reference ML-KEM, FIPS 203, or migration timelines. It did not require migration by a specific date. It required something more demanding: a **documented, risk-based cryptographic governance programme** that could withstand supervisory scrutiny when quantum threats materialized — and that demonstrably accounted for them before they did.

Meridian's legal team asked the question that compliance officers across Europe were asking in the same quarter: *What evidence satisfies this obligation?*

The Head of Regulatory Affairs, Thomas Bergström, scheduled a working session with Elena Vasquez, the bank's Data Protection Officer, and external counsel. The session produced a list of twenty-three regulatory instruments across eight jurisdictions — Meridian operated in six EU member states, the United Kingdom, and Switzerland — that touched cryptographic governance. None named ML-KEM. All required state-of-the-art practice. The gap between "we are monitoring quantum developments" and "here is our documented programme" became the compliance objective for the year.

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

PQC compliance is therefore demonstrated not by citing a regulation that says "use ML-KEM" but by presenting a **documented programme** that supervisory reviewers recognise as state-of-the-art cryptographic governance in a post-2024 environment.

This logic applies across jurisdictions. The specific instruments differ. The evidentiary standard does not.

### Why regulators avoid algorithm mandates

Regulators deliberately avoid mandating specific algorithms in primary legislation because algorithms age. Legislation is slow. Cryptanalysis is not. The state-of-the-art formulation — requiring measures appropriate to current risk and current cryptographic science — allows regulatory expectations to evolve without legislative amendment for each algorithm transition.

For enterprises, this creates a compliance challenge: the obligation is dynamic. What satisfied auditors in 2023 — encryption policies referencing RSA-2048 and AES-256 — may not satisfy supervisors in 2026 if state of the art has moved to include PQC migration planning. The August 2024 FIPS finalization is the inflection point that makes PQC planning part of state-of-the-art practice rather than forward-looking research.

### The evidence standard

Across jurisdictions, supervisory reviewers converge on a common evidence standard:

- **Documented** — written policies, not oral assurances
- **Risk-based** — tied to threat assessment and data classification
- **Current** — reflecting post-2024 standards landscape
- **Operational** — supported by inventories, change records, and governance structures
- **Honest** — acknowledging gaps with credible remediation plans

An enterprise that presents all five characteristics is defensible. An enterprise that presents policies without inventories, or inventories without migration plans, is not.

---

## 3.2 United States Federal Framework

### National Security Memorandum 10

NSM-10, issued in May 2022, established U.S. policy for quantum computing and cryptographic transition. Its core requirement: migrate vulnerable cryptographic systems to quantum-resistant alternatives with the goal of mitigating quantum risk **as far as is feasible by 2035**.

NSM-10 is policy, not regulation. Its binding force for federal agencies derives from implementation through OMB guidance, NIST standards, and agency-specific requirements. Its influence on commercial enterprises is indirect but substantial: federal procurement requirements, supply chain standards, and the de facto authority of NIST FIPS create market pressure that commercial CISOs cannot ignore.

For defence contractors and technology providers serving federal customers, NSM-10's 2035 target functions as a **commercial planning anchor** even where not contractually binding. Federal acquisition regulations increasingly reference NIST cryptographic standards. A commercial product that cannot demonstrate PQC migration alignment by 2030 will be non-competitive in federal procurement by 2033.

### Executive Order 14144 and federal cybersecurity modernisation

Executive Order 14144 (2024) strengthens federal cybersecurity requirements across agency systems, with emphasis on modernising defensive capabilities and critical infrastructure protection. It is not a dedicated PQC mandate, but it reinforces agency obligations to adopt current NIST guidance — which, after August 2024, includes post-quantum standards. Federal contractors should monitor OMB implementation memoranda and agency-specific procurement clauses for cryptographic modernisation flow-down, rather than treating EO 14144 as a standalone algorithm specification.

### NIST IR 8547 transition timelines

NIST's Initial Public Draft of IR 8547 (November 2024) articulates the expected transition:

- **After 2030:** Deprecation of quantum-vulnerable public-key algorithms at the 112-bit security level. Continued use requires documented risk acceptance.
- **After 2035:** Disallowance of quantum-vulnerable public-key algorithms in federal systems and standards.

These dates are policy anchors, not suggestions. NIST has stated they will inform revisions to SP 800-131A and other algorithm transition documents. Federal contractors, cloud providers serving federal customers, and enterprises whose auditors reference NIST guidance will encounter these dates as de facto compliance milestones.

**Deprecation vs. disallowance** carries distinct compliance meaning. Deprecation permits continued use with documented risk acceptance — an explicit acknowledgment that the algorithm is no longer recommended but may be necessary during transition. Disallowance removes the algorithm from approved standards entirely. Enterprises should structure migration waves to achieve deprecation compliance by 2030 and disallowance compliance by 2035, with risk acceptance documented only for systems that cannot transition earlier.

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

CNSA 2.0 specifies ML-KEM-1024, ML-DSA-87, and SLH-DSA as the approved suite, with hybrid key establishment required during transition. Defence contractors, FedRAMP-authorised cloud providers, and enterprises serving the defence industrial base encounter CNSA 2.0 as a **contractual and certification requirement**, not advisory guidance.

Apex Defense Technologies, examined throughout this book, maps its programme milestones directly to CNSA 2.0 dates. Commercial subsidiaries without NSS obligations follow NIST IR 8547 timelines — creating the dual-track regulatory overlay common in defence industrial base enterprises.

### FedRAMP, CMMC, and certification frameworks

**FedRAMP** authorisation requires compliance with NIST SP 800-53 controls, including cryptographic protections for federal cloud services. As NIST updates SP 800-53 and related control baselines to reference PQC standards, FedRAMP-authorised providers will face authorisation revision requirements tied to cryptographic migration.

**CMMC (Cybersecurity Maturity Model Certification)** for defence contractors references NIST SP 800-171 and 800-172 controls including cryptographic protections for CUI. CMMC assessors will increasingly evaluate whether contractors' encryption controls reflect state-of-the-art practice — which, after 2024, includes PQC planning evidence.

These certification frameworks do not yet mandate PQC deployment on specific dates for all authorised systems. They create **assessment surfaces** where quantum-vulnerable cryptography will be questioned and where absence of migration planning will be treated as a control deficiency.

### CISA and sector agency initiatives

The Cybersecurity and Infrastructure Security Agency's Post-Quantum Cryptography Initiative coordinates federal outreach to critical infrastructure sectors. Sector Risk Management Agencies have issued sector-specific guidance aligning with NIST transition timelines. For critical infrastructure operators like Northfield Energy, these instruments create supervisory expectations even where no statute explicitly names PQC.

NERC CIP (North American Electric Reliability Corporation Critical Infrastructure Protection) standards do not explicitly reference quantum computing as of this writing. They require protection of BES Cyber Systems including cryptographic controls for remote access and electronic security perimeters. As NIST deprecates quantum-vulnerable algorithms, NERC CIP compliance will require alignment — through standards updates or interpretive guidance — that critical infrastructure operators should anticipate in programme planning.

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

### DORA Articles 28–30: Third-party ICT risk

DORA's third-party ICT risk management provisions extend cryptographic expectations to critical suppliers. Financial entities must:

- Maintain a register of contractual arrangements with ICT third-party providers
- Assess ICT concentration risk
- Ensure that contractual arrangements enable compliance with DORA's ICT risk requirements
- Conduct due diligence on ICT third-party providers supporting critical or important functions

For PQC migration, this means **supplier cryptographic posture is a DORA compliance obligation**, not a procurement preference. A financial entity whose encryption policy mandates PQC migration but whose critical payment HSM vendor has no PQC roadmap has a compliance gap in both policy and supply chain dimensions.

Meridian's procurement workstream, initiated in Phase 2, added PQC roadmap requirements to renewal negotiations with four critical ICT providers. Two providers met the requirement with documented roadmaps. One provided a marketing whitepaper that did not satisfy due diligence. One had no response — triggering concentration risk escalation to the steering committee.

### European Banking Authority and supervisory expectations

The European Banking Authority (EBA) issues guidelines on ICT and security risk management that national competent authorities implement in supervisory review. While EBA guidelines predate DORA's full applicability, the supervisory convergence is toward **evidence-based cryptographic governance** — not checkbox compliance.

Supervisory review of encryption policies will increasingly ask:

- Does the policy reference current standards (including NIST FIPS 203–205)?
- Is the policy supported by a risk assessment that addresses quantum threat?
- Is the certificate register complete and current?
- What is the migration plan for identified gaps?
- How are critical ICT third-party providers assessed?

Meridian prepared a supervisory examination readiness package addressing these five questions before its first DORA-focused review. The package did not claim full PQC deployment. It documented programme status, gap analysis, and remediation timeline.

### NIS2 Directive

Directive (EU) 2022/2555 (NIS2) requires essential and important entities across energy, transport, health, digital infrastructure, financial market infrastructure, and other sectors to implement appropriate and proportionate technical and organisational measures — including encryption — based on an all-hazards risk assessment.

NIS2 does not explicitly reference quantum computing. It requires measures **consistent with the state of the art**. ENISA's implementation guidance, published in 2025, recommends that entities adopt quantum-resistant algorithms to protect sensitive data against harvest-now-decrypt-later attacks.

For financial entities, DORA is **lex specialis** — it prevails over NIS2 where both apply to the same obligation. For EU energy companies subject to NIS2 (as transposed into national law), NIS2 is a primary cryptographic compliance vehicle alongside sector-specific rules. **US operators such as Northfield Energy are not subject to NIS2** — they map evidence to NERC CIP, TSA, and CISA guidance (Chapter 20) while using the same programme structure with jurisdiction annotations.

**NIS2 transposition variation** matters for multinational enterprises. Member States transposed NIS2 by October 2024 with national variations in scope, enforcement authority, and penalty structures. Germany's BSIG amendment, France's *loi relative à la sécurité des systèmes d'information* transposition measures, and the Netherlands' *Cyberbeveiligingswet* create jurisdiction-specific enforcement contexts for the same EU directive. Programme regulatory overlays should annotate national transposition differences where they affect evidence requirements or timelines.

**Table 3.1 — Regulatory Mapping Matrix (Selected Frameworks)**

| Framework | Jurisdiction | Explicit PQC reference? | Effective obligation | Primary evidence artefact |
|-----------|-------------|------------------------|---------------------|--------------------------|
| NSM-10 | US (policy) | Yes — 2035 target | Federal; supply chain influence | Migration programme plan |
| NIST IR 8547 | US (guidance) | Yes — 2030/2035 | Federal; industry de facto | Risk acceptance documentation |
| CNSA 2.0 | US (NSS) | Yes — algorithm suite | NSS; defence contractors | CNSA compliance certification |
| DORA RTS 2024/1532 | EU (financial) | Implicit — quantum in recital | Financial entities (Jan 2025) | Encryption policy; certificate register |
| NIS2 | EU (multi-sector) | Implicit — state of the art | Essential/important entities | Risk assessment; encryption controls |
| GDPR Art. 32 | EU (data protection) | No — state of the art | All personal data controllers | TOMs documentation |
| PCI DSS 4.0 | Global (payments) | Emerging — crypto inventory | Card data environments | Cryptographic architecture documentation |
| UK NCSC guidance | UK | Yes — planning by 2028 | Government; industry guidance | Migration roadmap |
| ASD guidance | Australia | Yes — cease traditional PKC by 2030 | Australian government | Crypto transition plan |
| NERC CIP | US/Canada (energy) | No — implicit via NIST | BES Cyber System operators | CIP compliance evidence |

**Figure 3.2 — Global Regulatory Convergence Map**

```
                    ┌──────────────────────────────────────────┐
                    │     STATE OF THE ART (post-Aug 2024)      │
                    │  NIST FIPS 203–205 · NIST IR 8547 · ENISA │
                    └────────────────────┬─────────────────────┘
                                         │
         ┌───────────────────────────────┼───────────────────────────────┐
         │                               │                               │
         ▼                               ▼                               ▼
┌─────────────────┐           ┌─────────────────┐           ┌─────────────────┐
│  US FEDERAL     │           │  EU FRAMEWORK   │           │  NATIONAL       │
│  NSM-10 · IR    │           │  DORA · NIS2    │           │  UK NCSC · ASD  │
│  8547 · CNSA    │           │  GDPR Art. 32   │           │  · FINMA · CSA  │
│  2.0 · CISA     │           │                 │           │                 │
└────────┬────────┘           └────────┬────────┘           └────────┬────────┘
         │                               │                               │
         └───────────────────────────────┼───────────────────────────────┘
                                         ▼
                    ┌──────────────────────────────────────────┐
                    │   COMMON EVIDENCE STANDARD (5 elements)   │
                    │  Documented · Risk-based · Current ·       │
                    │  Operational · Honest gaps documented    │
                    └────────────────────┬─────────────────────┘
                                         ▼
                    ┌──────────────────────────────────────────┐
                    │        PQC GOVERNANCE STACK               │
                    │  Strategic → Programme → Policy →        │
                    │  Operational → Assurance                 │
                    └──────────────────────────────────────────┘
```

---

## 3.4 GDPR and Data Protection Law

The General Data Protection Regulation does not mention quantum computing. Article 32 requires controllers and processors to implement **appropriate technical and organisational measures** ensuring a level of security appropriate to the risk, taking into account the state of the art.

Data protection authorities have not, as of this writing, issued binding enforcement decisions specifically requiring PQC migration. The compliance logic is anticipatory:

- If NIST and ENISA define post-quantum algorithms as state of the art for long-term data protection
- And if a controller processes personal data with confidentiality requirements extending beyond CRQC arrival timelines
- Then continued reliance on quantum-vulnerable encryption for that data is difficult to defend as "appropriate" under Article 32

This is particularly acute for **special categories of personal data** under Article 9 (health, biometric, genetic, racial, political) and for data subject to **legal retention requirements** that extend confidentiality horizons beyond quantum threat timelines.

### GDPR compliance integration

GDPR compliance officers should coordinate with security teams to ensure that:

**Records of Processing Activities (Article 30)** reference cryptographic controls protecting each processing activity and note PQC migration status for long-retention data.

**Data Protection Impact Assessments (Article 35)** address cryptographic controls as part of necessity and proportionality analysis. A DPIA for processing involving ten-year data retention that identifies confidentiality risk without addressing PQC migration is incomplete.

**Technical and Organizational Measures (TOMs) documentation** provided to data subjects and supervisory authorities should reflect current cryptographic standards, not standards at the time of initial processing authorisation.

**Cross-border data transfer mechanisms** — Standard Contractual Clauses, Binding Corporate Rules — increasingly reference encryption as a supplementary measure. Transfer impact assessments should address whether encryption protecting transferred data will remain adequate for the transfer's duration. A transfer impact assessment that certifies RSA-2048 protection for data retained twenty years is difficult to defend.

### The EDPB and supervisory convergence

European Data Protection Board guidance on security measures emphasizes proportionality and state of the art without prescribing algorithms. National data protection authorities — CNIL (France), ICO (UK, pre/post-Brexit relevance for UK GDPR), BfDI (Germany) — are expected to converge on supervisory expectations aligned with ENISA's NIS2 implementation guidance as quantum threat awareness increases in the supervisory community.

Meridian's Data Protection Officer participated in the PQC steering committee from inception. The DPO's contribution was not cryptographic expertise. It was ensuring that programme artefacts satisfied GDPR documentation requirements and that migration prioritisation aligned with data subject impact — highest sensitivity data first.

---

## 3.5 PCI DSS and Payment Industry Standards

PCI DSS version 4.0, with phased requirements taking effect through March 2025, introduces enhanced cryptographic documentation obligations. While PCI SSC has not mandated specific PQC algorithms, the standard's architecture documentation requirements (Requirements 2, 4, and 12) create audit surfaces where quantum-vulnerable cryptography will be questioned.

**Requirement 4** (Protect cardholder data with strong cryptography during transmission) and **Requirement 3** (Protect stored account data) reference industry standards for cryptographic strength. As industry standards evolve toward PQC, PCI assessment methodologies will follow.

Payment networks and card schemes are developing PQC migration guidance independently. Visa, Mastercard, and regional schemes operate certification programmes for payment terminals, HSMs, and processing systems with multi-year certification cycles. Merchants and acquirers should monitor scheme publications and treat payment HSM certification cycles as binding constraints on migration timelines — as Meridian discovered in Chapter 1.

**Table 3.2 — PCI DSS 4.0 Documentation Surfaces Relevant to PQC**

| Requirement | Documentation obligation | PQC relevance |
|-------------|-------------------------|---------------|
| 2.1.1 | Configuration standards for system components | Crypto library versions, algorithm configs |
| 4.2.1 | Strong cryptography for transmission | TLS cipher suites, certificate algorithms |
| 12.3.4 | Cryptographic architecture diagrams | Full crypto inventory for CDE |
| 12.5.2 | PCI scope documentation | Systems using quantum-vulnerable PKC in scope |

Meridian's PCI re-certification cycle became a **binding constraint** on HSM firmware migration timing. The PQC programme documented this constraint in the CDG as an ecosystem readiness factor — not a threat analysis failure, but a synchronization reality.

---

## 3.6 United Kingdom, Australia, and Other National Frameworks

### United Kingdom

NCSC guidance establishes that UK government organisations should complete PQC discovery and planning by 2028, with migration execution through 2035. The guidance applies to government directly and serves as supervisory reference for critical national infrastructure operators in the private sector.

Post-Brexit, UK regulatory alignment with EU DORA and NIS2 diverges. UK financial services are subject to Bank of England and PRA supervisory expectations that mirror DORA's direction on ICT risk without identical instruments. UK-headquartered multinationals like Meridian's hypothetical UK subsidiary must maintain regulatory overlays for both EU and UK supervisory regimes.

### Australia

The Australian Signals Directorate's Information Security Manual directs Australian government systems to cease traditional asymmetric cryptography by 2030. The timeline is more aggressive than NIST IR 8547's deprecation anchor. Multinational enterprises with Australian government contracts should treat this as a binding contractual requirement.

### Canada, Japan, Singapore

Canada's Centre for Cyber Security, Japan's METI and ISC, and Singapore's CSA have published PQC awareness and planning guidance aligned with NIST standards. None mandate specific enterprise timelines with the binding force of CNSA 2.0 or ASD's 2030 target, but all establish planning expectations that multinational enterprises should incorporate into regulatory overlays.

### Switzerland

Swiss financial market supervisory authority FINMA's operational risk circulars require institutions to maintain adequate ICT risk management including encryption. Swiss banks operating under both FINMA and EU market access (via equivalence or branch structures) face dual supervisory contexts. Switzerland's participation in bilateral data protection adequacy arrangements adds cross-border encryption adequacy considerations.

---

## 3.7 What Evidence Satisfies the Obligation

Regulators and auditors do not accept awareness as compliance. The following artefacts, mapped to the PQC Governance Stack introduced in this chapter, constitute the evidence package a supervisory review should find.

### Strategic layer (board and executive)

- Quantum risk documented in enterprise risk management register
- Board-approved PQC migration programme charter with scope, authority, and funding
- Annual board reporting on migration progress against milestones
- Risk appetite statement addressing quantum threat and migration timeline acceptance

### Programme layer

- Cross-functional steering committee with defined membership and meeting cadence
- Migration wave plan with TRADE-scored priorities (Chapter 9)
- Budget allocation and resource plan covering multi-year horizon
- Steering committee minutes documenting decisions and escalations

### Policy layer

- Cryptographic standards policy referencing NIST FIPS 203–205 as approved algorithms
- Hybrid deployment policy with defined lifecycle phases (Chapter 11)
- Exception and risk acceptance process aligned with NIST IR 8547 documentation requirements
- Procurement policy clauses requiring supplier PQC readiness (Chapter 16)
- Data classification policy linked to confidentiality horizon methodology (Chapter 2)

### Operational layer

- Cryptographic Bill of Materials maintained and current (Chapter 7)
- Cryptographic Dependency Graph with identified blocking nodes (Chapter 8)
- Certificate register for critical and important functions (DORA RTS Article 6)
- Change management records for cryptographic transitions
- Key management procedures updated for PQC parameter sizes

### Assurance layer

- Internal audit plan covering cryptographic controls
- Penetration testing scope including cryptographic configuration review
- Third-party assessments of critical cryptographic systems
- Regulatory examination readiness package
- Annual PQ-ADAPT maturity self-assessment

No single artefact satisfies the obligation. Compliance is demonstrated by the **coherence of the package** — policies that reference inventories, inventories that inform migration plans, migration plans that produce change records, and change records that auditors can verify.

> **Regulatory Lens — Meridian Mutual Bank**
>
> Meridian's DORA compliance workstream mapped each RTS Article 6 requirement to a PQC programme deliverable. The encryption policy update (policy layer) referenced NIST FIPS 203–205 and established ML-KEM and ML-DSA as approved algorithms for new deployments. The certificate register (operational layer) was populated from the CBOM discovery in Phase 1. The gap between policy and current state — 14,200 assets, 89% quantum-vulnerable — was documented as the migration programme scope, not concealed. Supervisory reviewers respond better to documented gaps with credible remediation plans than to policies that overstate current compliance.

### Examination scenarios: what supervisors ask

Based on emerging supervisory practice in EU financial services and US federal contractor assessment, reviewers are likely to ask:

1. **Show us your encryption policy.** Does it address quantum threat? When was it last updated?
2. **Show us your certificate register.** Is it complete? When was it last verified?
3. **Show us your risk assessment.** How did you assess quantum risk? What methodology?
4. **Show us your migration plan.** What is the timeline? What are the blocking dependencies?
5. **Show us your third-party assessment.** What is your critical HSM vendor's PQC roadmap?
6. **Show us a cryptographic change record.** Have you migrated anything? What did you learn?

Meridian rehearsed these six questions in a mock examination before its first supervisory review. The exercise identified two gaps: incomplete certificate register for third-party SaaS integrations, and missing procurement clauses in two vendor contracts. Both were remediated before examination.

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

**Table 3.3 — Governance Stack Layer × Regulatory Instrument Mapping**

| Stack layer | DORA | NIS2 | GDPR | NIST/IR 8547 | CNSA 2.0 |
|-------------|------|------|------|-------------|----------|
| Strategic | Art. 6 governance | Art. 21 risk mgmt | Art. 32 TOMs | NSM-10 policy | NSS policy |
| Programme | Art. 9 ICT risk | Art. 21 measures | Art. 35 DPIA | Transition plan | Milestone plan |
| Policy | RTS Art. 6 policy | State of art | Art. 32 measures | Algorithm policy | Algorithm suite |
| Operational | Certificate register | Encryption controls | Art. 30 RoPA | Inventory | Compliance evidence |
| Assurance | Art. 25 testing | Supervisory review | DPA audit | Risk acceptance | CMMC/FedRAMP |

Chapter 15 develops the Governance Stack into an operating model. Part I establishes it as the structural response to the regulatory logic in this chapter: **compliance is a governance property, not a cryptographic one.**

---

## 3.9 Regulatory Convergence and Programme Design

A practical implication of the landscape above: **enterprises should not design separate compliance programmes for each regulation.** The CBOM satisfies DORA's certificate register requirement and NIS2's risk assessment evidence. The migration wave plan satisfies NSM-10's 2035 objective and NIST IR 8547's transition expectations. The encryption policy satisfies DORA RTS Article 6 and GDPR Article 32's state-of-the-art requirement.

Divergent compliance programmes — one for DORA, one for NIST, one for PCI — produce inconsistent priorities, duplicated discovery effort, and audit findings when artefacts contradict each other.

The recommended approach is a **single PQC migration programme** with a regulatory overlay matrix (Appendix C) annotating which artefacts satisfy which obligations in which jurisdictions. Northfield Energy, subject primarily to NERC CIP and US sector agency guidance (not NIS2), uses the same programme structure as Meridian Mutual Bank, subject primarily to DORA — with sector and jurisdiction annotations, not separate architectures.

### Building the regulatory overlay

For each jurisdiction and regulatory instrument in scope:

1. Identify the cryptographic obligation (explicit or implicit)
2. Map to Governance Stack layer
3. Identify the evidence artefact
4. Assign artefact owner
5. Define update cadence

Meridian's overlay covered twenty-three instruments across eight jurisdictions. Twelve mapped to the same five artefacts. The overlay's value was not creating twenty-three compliance programmes. It was demonstrating to Thomas Bergström's regulatory affairs team that one programme satisfied twelve regulatory contexts — reducing compliance cost and eliminating contradiction risk.

---

## 3.10 Compliance Failure Modes

Understanding how regulatory compliance fails helps programmes avoid predictable deficiencies.

**Failure mode 1: Policy without inventory.** Encryption policy references FIPS 203–205. No CBOM exists. Supervisory question "show us your certificate register" produces nothing. Compliance gap is immediate and indefensible.

**Failure mode 2: Inventory without plan.** CBOM documents 89% quantum-vulnerable assets. No migration wave plan exists. Supervisory question "what is your timeline?" produces "we are assessing." Assessment is not a plan.

**Failure mode 3: Plan without execution.** Migration plan exists. No cryptographic change records exist. Supervisory question "what have you migrated?" produces silence. Planning without execution is indistinguishable from inaction.

**Failure mode 4: Concealed gaps.** Policy overstates current compliance. Examination reveals discrepancy. Supervisory trust is damaged. Remediation is more expensive than honest gap documentation would have been.

**Failure mode 5: Third-party blindness.** Internal programme is credible. Critical payment HSM vendor has no PQC roadmap. DORA Articles 28–30 due diligence gap. Supply chain compliance failure.

Meridian's mock examination identified Failure mode 5 before the real examination. The remediation — procurement escalation with contractual PQC requirements — became a programme deliverable with its own timeline and owner.

---

## 3.11 Northfield Energy: Regulatory Context for Critical Infrastructure

Northfield Energy operates in the United States and is **not subject to NIS2** — an EU directive. Its regulatory landscape is sector-fragmented but converges on state-of-the-art cryptographic governance expectations:

- **NERC CIP** for bulk electric system cyber systems
- **TSA Security Directives** for pipeline operators
- **State public utility commission** cybersecurity reporting requirements
- **CISA Post-Quantum Cryptography Initiative** and sector ISAC guidance establishing NIST-aligned expectations for critical infrastructure

Unlike Meridian, Northfield does not have a single comprehensive financial regulation equivalent to DORA. Supervisory expectations nonetheless require documented encryption policies, risk assessments, and evidence of migration planning — the same five-element evidence standard as EU frameworks, delivered through different instruments.

Northfield's regulatory overlay mapped the same Governance Stack artefacts to each instrument. The CBOM satisfied NERC CIP evidence requirements for electronic access controls. The threat assessment (Chapter 2) satisfied TSA reporting on cyber risk. The migration plan aligned with CISA PQC initiative timelines.

The regulatory diversity did not require programme diversity. It required **annotation** — the same artefact, tagged with the regulatory instruments it satisfies.

---

## 3.12 International Standards, Insurance, and Contractual Risk

Regulatory instruments reference "leading practices and standards" (ISO/IEC, ETSI, IETF) and create obligations beyond primary legislation — including cyber insurance questionnaires, contractual security exhibits, and litigation exposure for undocumented migration planning. **Appendix C §C.5** provides reference depth on these supplements. Enterprise compliance officers should ensure the regulatory overlay matrix (Appendix C) includes industry body publications and insurance renewal cycles where they create quasi-binding obligations.

Apex Defense Technologies encountered contractual flow-down early: a 2026 DoD subcontract amendment required CNSA 2.0 alignment evidence before option-year exercise — eighteen months before the enterprise's internal corporate IT migration plan would have produced equivalent documentation. Apex's regulatory overlay now tags **contractual instruments** alongside statutory ones, with equal weight in horizon monitoring.

---

## 3.13 Regulatory Timeline Overlay

Enterprises operating across jurisdictions benefit from a single visual overlay of regulatory milestones. The following table consolidates the instruments discussed in this chapter into a planning reference. Dates are policy anchors subject to revision; monitor authoritative sources for updates.

**Table 3.4 — Regulatory Timeline Overlay (Planning Reference)**

| Date | Instrument | Requirement | Primary affected sectors |
|------|-----------|-------------|-------------------------|
| Aug 2024 | FIPS 203–205 | PQC algorithms finalized | All |
| Jan 2025 | DORA | Applicability begins | EU financial |
| 2025 | CNSA 2.0 | NSS CNSA 1.0 compliance or waiver | US government/NSS |
| 2027 | CNSA 2.0 | New NSS acquisitions CNSA 2.0 compliant | Defense, FedRAMP |
| 2028 | UK NCSC | Discovery and planning complete | UK government, CNI |
| 2030 | NIST IR 8547 | Deprecate quantum-vulnerable PKC (112-bit) | Federal; industry de facto |
| 2030 | ASD | Cease traditional asymmetric crypto | Australian government |
| 2030 | CNSA 2.0 | PQC firmware signing; networking CNSA 2.0 | NSS |
| 2033 | CNSA 2.0 | Most NSS platforms migrated | Defense |
| 2035 | NSM-10 / IR 8547 | Disallow quantum-vulnerable PKC | Federal; industry de facto |
| 2035 | CNSA 2.0 | All NSS fully migrated | NSS |

Programme planning should position the enterprise to meet the **most aggressive applicable milestone** in each jurisdiction, not the most permissive. Meridian plans for 2030 deprecation compliance across its EU and UK operations. Apex Defense plans against CNSA 2.0's more aggressive NSS milestones for classified systems and NIST IR 8547 for corporate IT.

---

## 3.14 Regulatory Engagement Strategy

Compliance is not passive. Enterprises can shape supervisory expectations through structured regulatory engagement — within the bounds of appropriate regulatory relations practice.

### Proactive supervisory dialogue

Financial entities under DORA should consider whether proactive engagement with competent authorities on PQC programme design is appropriate in their jurisdiction. Some authorities welcome pre-examination consultations on novel compliance topics. Others prefer to assess during examination without prior disclosure. Legal counsel should advise on jurisdictional practice.

Where proactive dialogue is appropriate, present:

- Programme charter and governance structure
- Threat assessment methodology (Chapter 2)
- CBOM scope and completion status
- Migration timeline with identified gaps
- Specific questions where supervisory interpretation would reduce compliance uncertainty

Meridian's Head of Regulatory Affairs conducted a non-examination briefing with its home-state competent authority's innovation unit. The briefing did not produce formal guidance, but it established that Meridian's programme methodology was understood and that the authority's examination expectations aligned with the Governance Stack artefacts described in this chapter.

### Industry association participation

Sector trade associations — banking federations, energy ISACs, defence industry groups — increasingly develop collective responses to PQC regulatory questions. Participation provides:

- Visibility into peer supervisory experiences
- Collective advocacy for reasonable transition timelines
- Shared interpretation of ambiguous regulatory language
- Sector-specific guidance that supplements this book's Sector Overlay Matrix

### Comment processes

NIST IR 8547 and similar instruments accept public comment. Enterprises with specific implementation constraints — OT device lifetimes, payment HSM certification cycles, cross-border data residency complications — should submit comments through industry associations or directly. Regulatory instruments that account for enterprise constraints produce more achievable timelines.

---

## 3.15 GlobalSync Logistics: Multinational Regulatory Complexity

GlobalSync Logistics operates in forty countries with varying data protection, cybersecurity, and sector-specific requirements. Its regulatory overlay is the most complex of the four teaching organisations.

**EU operations:** GDPR Article 32, NIS2 (as transposed in markets where GlobalSync qualifies as important entity), and customer contractual requirements referencing EU data protection standards.

**United States:** State privacy laws (CCPA/CPRA and successors), federal contractor requirements for logistics providers serving defence customers, and SOC 2 Type II examination expectations from enterprise customers.

**Asia-Pacific:** Singapore CSA guidance, Japan APPI requirements, Australia's Privacy Act and ASD guidance for government-connected tenants.

**Cross-cutting:** ISO 27001 certification maintained across all regions; customer security questionnaires requiring PQC readiness statements; cyber insurance renewal requirements.

GlobalSync's compliance strategy is a **single programme with forty-jurisdiction annotation**. The CBOM is global. The Governance Stack artefacts are global. The regulatory overlay matrix tags each artefact with applicable jurisdictions. When a new customer in Brazil requires LGPD-compliant encryption documentation, GlobalSync maps the request to existing artefacts rather than creating Brazil-specific compliance infrastructure.

This approach scales. The alternative — separate compliance programmes per jurisdiction — produced the contradictory priorities and duplicated effort that Section 3.9 warns against. GlobalSync learned this from a failed attempt to run EU and US PQC programmes independently in its first year of awareness. Consolidation under a single programme office reduced compliance staff effort by an estimated thirty percent.

---

## 3.16 Auditor and Assessor Engagement

External auditors — financial statement auditors reviewing IT controls, PCI Qualified Security Assessors, ISO 27001 certification bodies, SOC 2 examination firms — are beginning to include cryptographic governance in assessment scope. Internal programmes should prepare for external assessment by understanding what each assessor type evaluates.

**Financial statement auditors (IT general controls):** Evaluate whether IT controls supporting financial reporting are adequately designed and operating. Cryptographic controls protecting financial data integrity and confidentiality fall within scope. Expect questions on encryption policy currency and key management procedures.

**PCI QSA:** Evaluate cardholder data environment cryptographic configurations against PCI DSS Requirements 3 and 4. Expect architecture diagrams and algorithm inventories. Quantum-vulnerable PKC in the CDE will attract scrutiny even before PCI SSC mandates PQC.

**ISO 27001 certification bodies:** Evaluate Annex A 8.24 implementation against the organisation's stated cryptography policy. A policy referencing only pre-2024 algorithms is a nonconformity.

**SOC 2 examination firms:** Evaluate Trust Services Criteria CC6 (Logical and Physical Access) and CC7 (System Operations) including encryption controls described in system description documents.

**Table 3.5 — External Assessment Preparation Checklist**

| Assessment type | Cryptographic artefacts to prepare | Common finding if absent |
|----------------|-----------------------------------|-------------------------|
| Financial ITGC | Encryption policy, key management procedures | Policy not updated for PQC |
| PCI QSA | Crypto architecture diagram, cipher suite inventory | No quantum risk documentation |
| ISO 27001 | Cryptography policy, risk assessment | Policy lacks state-of-the-art reference |
| SOC 2 | System description encryption section | No migration plan referenced |
| CMMC C3PAO | NIST 800-171 cryptographic controls evidence | No CNSA 2.0 alignment plan |

Meridian shared its Governance Stack artefacts with its external financial auditors during the annual IT controls review. The auditors mapped PQC programme documentation to their control testing framework without requiring additional evidence collection — because the artefacts were already produced for regulatory compliance. This is the efficiency argument for unified programme design: evidence collected once serves multiple assessment contexts.

---

## 3.17 DORA Deep Dive: Article-by-Article PQC Relevance

For financial entities building regulatory overlays, a granular mapping of DORA articles to PQC programme activities prevents gaps in compliance coverage.

**Article 6 (ICT risk management framework):** Requires a documented framework addressing ICT risk including cyber threats. Quantum threat must appear in the framework's threat taxonomy. *Programme artefact: enterprise risk register entry, ICT risk framework update.*

**Article 8 (Identification):** Requires identification and classification of ICT assets supporting critical or important functions. Cryptographic assets are ICT assets. *Programme artefact: CBOM, asset classification records.*

**Article 9 (Protection and prevention):** Requires ICT security policies including encryption and cryptographic controls. This is the primary DORA article for encryption policy. *Programme artefact: encryption policy, cryptographic standards policy.*

**Article 10 (Detection):** Requires mechanisms to detect anomalous activities. Cryptographic configuration monitoring — certificate expiry, deprecated algorithm detection — supports detection. *Programme artefact: CBOM monitoring, cryptographic configuration alerting.*

**Article 25 (Testing):** Requires testing of ICT tools and systems. Cryptographic transition testing — hybrid compatibility, performance benchmarking — satisfies testing obligations for crypto changes. *Programme artefact: test plans, test results for PQC pilots and deployments.*

**Articles 28–30 (ICT third-party risk):** Requires due diligence, contractual provisions, and concentration risk assessment for ICT providers. Supplier PQC readiness is a due diligence item. *Programme artefact: vendor assessment records, contractual PQC clauses.*

**Article 45 (Supervisory cooperation):** Requires cooperation with competent authorities. Proactive programme briefing supports cooperation. *Programme artefact: examination readiness package.*

Meridian's compliance team maintained this article-level mapping as a living document, updated when programme artefacts were produced or revised. The mapping demonstrated to Thomas Bergström's regulatory affairs function that DORA compliance was not a separate workstream from the PQC programme — it was the regulatory expression of the same work.

### Penalties, enforcement, and proportionality

Regulatory frameworks carry enforcement mechanisms that compliance officers must understand when prioritising programme investment. **Penalty ceilings vary by violation category, entity type, and national transposition.** Legal counsel should verify applicable maxima for the entity's jurisdiction and supervisory authority. The following summaries are planning anchors, not legal advice.

**DORA (Regulation (EU) 2022/2554, Articles 99–101):** Competent authorities may impose administrative penalties for ICT risk management failures. Maximum penalties differ between financial entities and critical ICT third-party service providers, and between violation categories. Cryptographic control deficiencies that contribute to broader ICT risk management failures may fall within enforcement scope when supervisory review identifies systemic governance gaps — not merely the absence of production PQC deployment during the transition period.

**NIS2 (Directive (EU) 2022/2555, Article 34):** Member States set maximum penalties within EU minimum floors — essential entities face higher ceilings than important entities. National transposition varies. Consult national implementing legislation.

**GDPR (Article 83):** Fines are proportionate to infringement severity. Quantum-vulnerable encryption for long-retention personal data is unlikely to be the primary enforcement trigger before a breach occurs, but inadequate Article 32 measures may aggravate penalties following a disclosure event.

Enforcement for PQC readiness before CRQC arrival is expected to be **progressive** — supervisory engagement, remediation orders, and penalties typically following sustained non-compliance after reasonable transition periods, not the mere absence of completed migration. This does not justify deferral. It defines the enforcement trajectory that documented programmes navigate successfully.

Proportionality is the compliance officer's ally. A financial entity that demonstrates documented threat assessment, current encryption policy, complete certificate register, credible migration plan, and honest gap reporting is exercising the "flexible approach based on risk mitigation" that DORA Recital 9 describes. An entity with none of these artefacts is not.

### Regulatory horizon monitoring

Compliance is not a point-in-time achievement. Regulatory instruments evolve. Programme governance must include **regulatory horizon monitoring** — a structured process for tracking new publications, draft guidance, comment periods, and enforcement precedents.

**Monitoring sources:**

- NIST CSRC publications and IR/SP revision notices
- European Commission delegated regulations and EBA guidelines
- ENISA technical guidance and threat landscape reports
- National competent authority publications in operating jurisdictions
- PCI SSC bulletin and PCI DSS revision schedules
- Industry association regulatory briefings

**Monitoring outputs:**

- Quarterly regulatory horizon report to steering committee
- Impact assessment when new instruments publish
- Programme timeline adjustment recommendations
- Policy update triggers

Meridian assigned regulatory horizon monitoring to Thomas Bergström's team with quarterly reporting to the PQC steering committee. The function identified three material regulatory developments in its first year: DORA RTS final text, ENISA NIS2 PQC guidance, and a draft EBA opinion on cryptographic control testing. Each triggered a mapped impact assessment against existing programme artefacts — two required policy updates, one required no action beyond documentation.

---

> **Dependency Alert**
>
> **NIS2 is an EU instrument.** US critical infrastructure operators — including Northfield Energy — are not subject to NIS2 regardless of sector parallels. Map US obligations through NERC CIP, TSA directives, state utility commissions, and CISA sector guidance. Multinational enterprises need jurisdiction-specific overlays, not a single regulation assumed globally.

---

## 3.18 Apply in Your Organisation

1. **Build one programme with a regulatory overlay matrix** — not parallel compliance silos per jurisdiction.
2. **Map Governance Stack artefacts to your top five regulatory instruments** using Table 3.3 as a template.
3. **Rehearse six supervisory questions** from §3.7 before your first DORA- or NIS2-focused examination.
4. **Assign regulatory horizon monitoring** with quarterly steering committee reporting.
5. **Document honest gaps** between policy target state and CBOM current state — supervisors respond better to credible remediation plans than to overclaimed compliance.

---

## 3.19 Chapter Summary

- Most regulations do not name PQC algorithms. They require state-of-the-art cryptographic governance that, after August 2024, necessarily includes a documented PQC trajectory.
- U.S. federal framework: NSM-10 (2035 target), NIST IR 8547 (2030/2035 deprecation/disallowance), CNSA 2.0 (binding for NSS and defence industrial base), FedRAMP/CMMC assessment surfaces.
- EU framework: DORA RTS 2024/1532 (encryption policy, certificate register, quantum in recital 9), NIS2 (state of the art), GDPR Article 32 (appropriate measures).
- PCI DSS 4.0 and payment scheme certification create binding timeline constraints for card-processing environments.
- Compliance evidence is a coherent package of governance artefacts — not a single certificate or algorithm deployment.
- The PQC Governance Stack (Strategic, Programme, Policy, Operational, Assurance) structures the evidence package.
- One programme, multiple regulatory overlays — not parallel compliance silos.
- Mock supervisory examination rehearsal identifies gaps before real examinations do.

**Next:** Part II begins the standards literacy that architects and engineers require — treating FIPS 203, 204, and 205 as inputs to programme decisions, not as the programme itself.

---

*Chapter 3 — References*

- Commission Delegated Regulation (EU) 2024/1532 of 19 October 2024 supplementing Regulation (EU) 2022/2554 with regard to regulatory technical standards for ICT risk management. *Official Journal of the European Union*, L 2024/1532.
- Directive (EU) 2022/2555 of the European Parliament and of the Council on measures for a high common level of cybersecurity across the Union (NIS2). *Official Journal of the European Union*, L 333.
- European Union Agency for Cybersecurity. (2025). *NIS2 implementation guidance*. https://www.enisa.europa.eu/
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- National Security Memorandum 10 (2022). The White House.
- PCI Security Standards Council. (2022). *Payment Card Industry Data Security Standard v4.0*. https://www.pcisecuritystandards.org/
- Regulation (EU) 2016/679 of the European Parliament and of the Council on the protection of natural persons with regard to the processing of personal data (GDPR). *Official Journal of the European Union*, L 119.
- Regulation (EU) 2022/2554 of the European Parliament and of the Council on digital operational resilience for the financial sector (DORA). *Official Journal of the European Union*, L 333.

---

*End of Part I. Proceed to Part II: Standards as Inputs.*
