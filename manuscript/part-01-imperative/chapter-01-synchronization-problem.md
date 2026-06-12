# Chapter 1
# The Synchronization Problem

---

In March of her second year as Chief Information Security Officer, Elena Vasquez received a report she had not commissioned and did not fully understand. A penetration testing firm, engaged for an unrelated PCI scope review, had flagged an RSA-2048 certificate embedded in the firmware validation chain of a payment hardware security module deployed across Meridian Mutual Bank's card-processing estate. The certificate was not expired. It was not misconfigured. It was not, by any current compliance framework, out of policy.

It was, however, quantum-vulnerable. And the HSM vendor's published roadmap for post-quantum firmware signing would not deliver a production-validated module until fourteen months after Meridian's next PCI re-certification window.

Elena's first instinct — shared by most security leaders encountering post-quantum cryptography for the first time — was to treat the finding as a technology refresh item. Replace the algorithm. Patch the module. Close the ticket. That instinct is wrong. Not because the algorithm does not need replacing, but because the finding sits at the bottom of a dependency chain that includes the HSM firmware, the payment switch integration layer, the acquiring bank's trust store, three third-party payment service providers, and a certificate profile that Meridian's public key infrastructure team had not reviewed in four years.

Meridian did not have a post-quantum cryptography problem. It had a synchronization problem. And until Elena understood the difference, any budget she allocated to "PQC readiness" would produce pilots that never reached production.

Three weeks after receiving the report, Elena convened a meeting she had been avoiding: PKI engineering, payment systems operations, procurement, the HSM vendor's account team, and a representative from the acquiring bank's integration group. The meeting lasted four hours. It produced no decision about algorithms. It produced a list of forty-three dependencies, eleven external parties whose cooperation was required, and one conclusion that reframed the bank's entire security strategy: **no team in the room could migrate the HSM firmware signing chain alone.**

The meeting's most contentious moment came when payment operations asked whether the HSM could continue operating with RSA-2048 firmware signing until the vendor delivered PQC support. The cryptographic engineering answer was yes — the system was secure today. The compliance answer was more complicated: DORA's encryption policy requirements, then entering implementation, expected financial entities to monitor cryptanalytic developments and plan transitions. Continuing indefinitely without a documented migration path was not a permanent option. The procurement answer added that the HSM vendor contract contained no clause requiring post-quantum algorithm support on any timeline. The acquiring bank representative noted, without commitment, that the card network's trust store update cycle for new root certificates typically ran eighteen to thirty-six months from submission to production availability.

Elena left the meeting with a whiteboard photograph and no budget approval. She had, however, the material for a board conversation that would not mention algorithms at all. It would describe a synchronization problem — and request authority to solve it as a programme.

This chapter establishes why that conclusion generalizes to every enterprise confronting post-quantum cryptography — and why the organizational response must be a programme, not a project.

---

## 1.1 What Changed in August 2024

For fifteen years, enterprise security teams treated post-quantum cryptography as a research programme with an uncertain finish line. NIST's Post-Quantum Cryptography Standardization Project, launched in 2016, evaluated candidate algorithms through multiple public rounds. The first round received sixty-nine submissions. The third round narrowed the field to fifteen candidates in two tracks: public-key encryption and key establishment on one side, digital signatures on the other. Vendors hedged. Regulators waited. CISOs filed the topic under "emerging risk" and returned to ransomware, identity breaches, and patch backlogs.

The process was deliberately transparent. NIST published analysis reports, solicited public comment, and adjusted the candidate pool when cryptanalytic results weakened specific schemes. CRYSTALS-Kyber and CRYSTALS-Dilithium emerged as primary candidates. SPHINCS+ provided a hash-based signature alternative with conservative security assumptions and larger signature sizes. FALCON and HQC remained under evaluation as potential complements.

That posture became untenable on 13 August 2024, when the U.S. Secretary of Commerce approved three Federal Information Processing Standards:

- **FIPS 203** — Module-Lattice-Based Key-Encapsulation Mechanism (ML-KEM)
- **FIPS 204** — Module-Lattice-Based Digital Signature Algorithm (ML-DSA)
- **FIPS 205** — Stateless Hash-Based Digital Signature Algorithm (SLH-DSA)

These are not draft candidates. They are final standards specifying algorithms derived from the CRYSTALS-Kyber, CRYSTALS-Dilithium, and SPHINCS+ submissions respectively. NIST's guidance is explicit: organizations should begin migrating now. Cybersecurity products, services, and protocols that depend on quantum-vulnerable public-key cryptography — RSA, finite-field and elliptic-curve Diffie-Hellman, ECDSA, EdDSA — require identification, planning, and replacement.

The finalization matters for reasons beyond algorithm selection. **Procurement language changes.** Federal agencies and their contractors must reference approved standards, not candidate algorithms. **Vendor liability shifts.** Products marketed as "PQC-ready" using non-standard implementations face increasing scrutiny from enterprise buyers and assessors. **Regulatory interpretation hardens.** Supervisory guidance that previously treated quantum threat as forward-looking now references finalized standards as the definition of state-of-the-art practice. **Insurance and contractual risk allocation adjusts.** Cyber insurance questionnaires and supply-chain security clauses increasingly ask whether organizations have migration programmes aligned with NIST transition guidance.

The standards answer a question the industry had deferred: *which algorithms*. They do not answer the questions enterprises actually face:

- *Where* is vulnerable cryptography deployed?
- *What breaks* if we change it?
- *Who else* must change before we can?
- *How do we prove* to regulators and auditors that we are making defensible progress?

Those questions define the scope of this book.

### The global standards landscape beyond NIST

NIST's decisions carry disproportionate influence because of FIPS authority, federal procurement scale, and the historical alignment of international standards bodies with NIST cryptographic selections. ISO/IEC JTC 1 SC 27 working groups are incorporating ML-KEM and ML-DSA into international standards. ETSI is developing quantum-safe profiles for telecommunications and PKI. The IETF is specifying hybrid TLS constructions that combine classical and post-quantum key exchange in deployable protocol formats.

Enterprises operating in multiple jurisdictions should not wait for perfect international harmonization before acting. The direction of travel is consistent: quantum-vulnerable public-key cryptography is being deprecated. The specific timelines and regulatory instruments differ. The algorithm suite converges on NIST's selections as the practical deployment baseline.

---

## 1.2 Why This Transition Is Not Like the Others

Enterprise security leaders have navigated cryptographic transitions before. SHA-1 deprecation. SSL and early TLS retirement. 1024-bit RSA phase-out. TLS 1.3 adoption. Each followed a recognizable pattern: a standards body declares an algorithm weak or deprecated; vendors release updates; security teams schedule upgrades within maintenance windows; compliance frameworks adjust audit checklists.

Post-quantum migration resembles none of these closely enough to reuse their playbooks. Understanding where the analogies hold — and where they fail — prevents the most common category of migration planning error: applying a timeline and organizational model from a structurally simpler transition.

**Table 1.1 — Cryptographic Transition Comparison Matrix**

| Dimension | SHA-1 deprecation | TLS 1.3 adoption | 1024-bit RSA phase-out | **PQC migration** |
|-----------|-------------------|------------------|------------------------|-------------------|
| Primary trigger | Demonstrated collision attacks | Protocol security improvement | Key size weakness | Future CRQC + present HNDL |
| Scope of affected systems | Certificate hashing, signatures | TLS endpoints | Key generation parameters | All asymmetric PKC operations |
| Ecosystem coordination | CA-centric; moderate | Client-server pairs; moderate | CA and key stores; moderate | Enterprise-wide; **extensive** |
| Parameter size change | Minimal | Moderate (cipher suites) | Moderate (key sizes) | **Substantial** (keys, signatures, ciphertexts) |
| Interim hybrid model | No | No (version negotiation) | No | **Yes — required near-term** |
| Typical enterprise timeline | 2–4 years | 3–5 years | 3–5 years | **5–15+ years** |
| Primary failure mode | Missed certificates | Client incompatibility | Weak keys remain | **Dependency blocking** |
| Regulatory driver | Industry + browser pressure | Compliance + best practice | FIPS/NIST mandate | Multi-regulatory convergence |

The matrix's final row merits emphasis. PQC migration is the first cryptographic transition where regulatory, national security, and sector-specific frameworks are converging simultaneously — before the underlying threat has manifested in production attacks. SHA-1 was deprecated because it was broken. PQC migration is undertaken because mathematics predicts breakage, because adversaries may be collecting ciphertext now, and because regulators are requiring governance evidence before breakage occurs.

### Scale of ecosystem coordination

SHA-1 retirement primarily affected certificate authorities and applications computing certificate hashes. The blast radius was large but structurally simple: find SHA-1 signatures, re-issue certificates, update trust stores. Discovery tools existed. The dependency graph was shallow.

PQC migration touches every asymmetric cryptographic operation in the enterprise: TLS handshakes, VPN tunnels, code signing, email encryption, document signing, API authentication, database encryption key wrapping, hardware security module key ceremonies, smart card authentication, firmware validation, blockchain anchoring, and partner B2B integrations. Each operates on different timelines, different vendor roadmaps, and different tolerance for interoperability disruption.

Campbell's 2025 analysis of enterprise migration timelines, synthesizing expert input and historical precedent, estimates **5–7 years for small enterprises, 8–12 years for medium enterprises, and 12–15 or more years for large enterprises** under baseline assumptions. These are not pessimistic outliers. They reflect the reality that PQC migration is, in Campbell's term, a **global synchronization exercise** — deeply intertwined with vendor readiness, personnel availability, budget cycles, and the cryptographic posture of partners who do not share your urgency.

Campbell identifies six dependency categories that extend timelines beyond initial executive estimates: infrastructure upgrade requirements, personnel and expertise availability, budget allocation patterns, planning quality, inter-enterprise synchronization, and the interaction with broader security modernization programmes such as Zero Trust architecture. Enterprises attempting PQC migration in parallel with — but not integrated into — identity modernization, cloud migration, or PKI consolidation will experience timeline extension from resource contention alone.

### Parameter and protocol implications

NIST's selected algorithms use different mathematical foundations and, critically, different performance and size characteristics than the RSA and elliptic-curve schemes they replace. ML-DSA public keys and signatures are substantially larger than ECDSA equivalents. ML-KEM ciphertexts exceed the payload assumptions of protocols designed around compact classical key exchange.

These are not implementation inconveniences. They are architecture constraints. A TLS middlebox sized for classical handshake profiles may fail on post-quantum extensions. A smart card with fixed storage cannot accommodate ML-DSA certificate chains without hardware redesign. An API gateway with header size limits may reject post-quantum signed tokens. A message queue with maximum message size constraints may truncate post-quantum signed payloads. A DNSSEC deployment sized for ECDSA signatures may exceed UDP fragmentation thresholds with ML-DSA.

Each constraint is discoverable during architectural assessment. None is discoverable during a pilot that tests only TLS on a single web server. Transitions that assumed algorithm substitution within existing size envelopes do not apply.

### The hybrid interim

NIST and industry consensus accept that the near-term deployment model is **hybrid cryptography**: combining a classical algorithm with a post-quantum algorithm so that security holds if either component remains sound. Hybrid TLS constructions, combining X25519 with ML-KEM-768 for example, are entering standards-track specification.

Hybrids solve an interoperability problem. They introduce a governance problem: hybrids are transitional states, not destinations. An enterprise that deploys hybrids without defined sunset criteria for the classical component will carry permanent dual-algorithm complexity — twice the attack surface, twice the validation burden, twice the operational confusion, and twice the training requirement for operations staff.

No SHA-1 migration required this level of explicit phase management. SHA-1 was removed. The endpoint was unambiguous. PQC migration's endpoint is unambiguous — quantum-vulnerable PKC retired — but the path runs through a hybrid phase whose duration depends on ecosystem readiness, not enterprise will alone.

### The threat timeline asymmetry

SHA-1 was broken in practice before enterprises finished retiring it. The motivating evidence was present-tense: collision attacks demonstrated, certificates forged.

Quantum threat analysis operates on a different logic. Cryptographically relevant quantum computers — machines capable of running Shor's algorithm at scale sufficient to break RSA-2048 and ECC P-256 — do not exist today. Projections for their arrival range widely. The uncertainty is genuine.

But a separate threat does not depend on quantum computer arrival: **harvest now, decrypt later**. An adversary who records encrypted traffic today — or exfiltrates encrypted archives — holds ciphertext that may become readable when quantum decryption becomes feasible. For data whose confidentiality must hold for fifteen, twenty, or thirty years, the threat is present-tense even when the quantum computer is not.

This asymmetry means migration urgency is driven as much by **data longevity** as by **quantum computer forecasts**. Compliance frameworks are beginning to recognize this distinction. Enterprises that wait for a quantum computer before acting will have already lost confidentiality for their longest-lived data. Chapter 2 develops this threat analysis in full.

> **Migration Moment**
>
> *"We completed TLS 1.3 migration in eighteen months. PQC should be similar."*
>
> TLS 1.3 migration replaced one protocol version with another within a bounded client-server negotiation framework. The cryptographic algorithms within TLS 1.3 remained classical. PQC migration replaces the mathematical foundations of asymmetric cryptography across the entire estate, with larger parameters, hybrid interim requirements, and dependencies that extend into firmware, HSMs, and partner ecosystems. The organizational model that succeeded for TLS 1.3 — a network engineering project with security oversight — will fail for PQC.

---

## 1.3 The Synchronization Problem

The central argument of this book is stated plainly:

**Post-quantum cryptographic migration is not a cryptographic upgrade. It is an enterprise-wide synchronization problem.**

A cryptographic upgrade replaces one algorithm with a better one within a bounded system. The security team controls the system. The vendor provides the patch. The change window is scheduled. Success is measured by deployment completion within the system boundary.

A synchronization problem arises when the value of a change depends on coordinated action across systems, organizations, and time horizons that no single team controls. Success is measured by ecosystem alignment, not deployment completion in isolation.

### Meridian's dependency chain

Consider Meridian's HSM finding in detail. Migrating to a post-quantum firmware signing chain requires:

1. The HSM vendor to ship a FIPS-validated module supporting ML-DSA or SLH-DSA
2. Meridian's PKI team to issue new firmware signing certificates with post-quantum-capable profiles
3. The payment switch vendor to accept the new certificate chain without service interruption
4. Acquiring banks and card networks to update trust stores on their timelines, not Meridian's
5. PCI assessors to recognize and accept the new validation evidence
6. Meridian's procurement team to negotiate contract terms covering algorithm migration obligations
7. Internal change management to schedule firmware updates across 340 payment terminals without transaction disruption
8. Operations staff to be trained on new certificate validation behaviour in monitoring systems

Meridian can complete step 2 on its own schedule. It cannot complete step 1 without the vendor. It cannot complete steps 3–4 without partners. It cannot complete step 6 without a programme that predates the immediate technical finding. Steps 7–8 require organizational capacity that competes with every other operational priority.

Every item on that list is a **dependency**. Dependencies compose into **chains**. Chains have **blocking nodes** — assets whose delayed migration prevents all downstream transitions. The HSM firmware signing certificate was not the most visible cryptographic asset in Meridian's estate. It was the most blocking.

### A second pattern: GlobalSync Logistics

The synchronization problem is not confined to regulated industries with legacy hardware. GlobalSync Logistics, a fictional multinational SaaS provider examined throughout this book, encountered a structurally similar pattern in a cloud-native environment.

GlobalSync's platform team deployed hybrid TLS on its public API gateway in a well-executed pilot. Client compatibility exceeded ninety-five percent. Performance overhead was within acceptable bounds. The pilot was declared successful.

Production rollout stalled for eleven months. The stall had nothing to do with TLS. Three enterprise tenants connected to GlobalSync's API through mutual TLS authentication with certificate chains signed by a partner CA that had not published a post-quantum roadmap. Two tenants operated in jurisdictions where data residency requirements mandated encryption in transit using algorithms approved by national authorities who had not yet recognized ML-KEM. One tenant's security contract required thirty days' notice for any cryptographic parameter change — and treated key size increases as material contract amendments requiring legal review.

GlobalSync's platform was ready. The ecosystem was not. The pilot measured technical feasibility. It did not measure synchronization feasibility.

> **Migration Moment**
>
> *"We'll start with TLS because it's the most exposed."*
>
> External exposure is one dimension. Dependency topology is another. An internal firmware signing chain can block more production systems than an external web server certificate, because everything built on validated firmware inherits the vulnerability. A tenant's contractual constraints can block a cloud provider's platform upgrade even when the platform is technically ready. Inventory without dependency analysis produces confident priorities that are structurally wrong.

### Why pilots fail to become programmes

The synchronization problem explains why well-funded enterprises with competent security teams stall after initial PQC pilots. The pilot succeeds in a controlled environment. Production deployment requires ecosystem readiness that the pilot did not test. The programme loses credibility. Budget shifts elsewhere. The estate remains vulnerable while the board receives reports that "PQC is in progress."

The failure pattern follows a recognizable sequence:

1. **Awareness event** — executive briefing, regulatory publication, or vendor announcement creates urgency
2. **Pilot authorization** — limited budget for technical experimentation, often on external-facing TLS
3. **Pilot success** — hybrid TLS or PQC library integration works in test environment
4. **Production collision** — partner, vendor, PKI, or compliance constraint blocks rollout
5. **Credibility loss** — pilot declared "complete" while estate remains quantum-vulnerable
6. **Programme stall** — budget reallocated; PQC demoted to "monitoring" status

Avoiding this failure mode requires treating migration as a **programme** — a governed, multi-year enterprise capability — rather than a **project** with a defined end date and a single technical deliverable. Section 1.5 develops the programme-project distinction.

---

## 1.4 The Enterprise Dependency Iceberg

Visualize the enterprise cryptographic estate as an iceberg. The metaphor is overused in management literature. Here it is used precisely: because the mass that determines whether the enterprise floats or sinks through migration is below the surface.

**Above the waterline** sit the assets security teams can readily identify: web server certificates, VPN concentrator configurations, API gateway TLS settings, code signing certificates for public releases. These are visible in certificate transparency logs, network scans, and configuration management databases. Security teams scanning for PQC readiness typically find these first. Executive dashboards built on scan results show progress against visible assets.

**At the waterline** sit the integration dependencies: partner API endpoints, B2B trust stores, federated identity certificates, cross-signed CA hierarchies, cloud provider KMS configurations. These require deliberate discovery. They are not always in the CMDB. They may not appear in certificate transparency logs because they are used in private mutual TLS or VPN contexts. Discovery requires interviews with integration teams, review of partner agreements, and analysis of identity provider configurations.

**Below the waterline** sit the assets that block everything else: root and intermediate CA keys, HSM master key ceremonies, firmware signing roots, embedded cryptographic libraries in third-party appliances, OT device certificates with ten-year validity periods, legacy mainframe cryptographic modules, and protocol implementations in vendor software whose source code the enterprise does not control.

**Table 1.2 — Iceberg Layer Examples by Enterprise Function**

| Layer | IT example | OT example | Cloud example | Third-party example |
|-------|-----------|-----------|---------------|---------------------|
| Visible | Corporate web TLS | Remote access VPN | API gateway TLS | SaaS admin portal |
| Integration | SAML federation certs | Vendor remote maintenance | Cross-account KMS trust | Partner mTLS API |
| Blocking | Internal issuing CA | PLC firmware signing root | Platform root of trust | Payment HSM firmware chain |

PQC migration programmes that begin above the waterline — upgrading external TLS, running hybrid experiments on public-facing services — generate visible activity without addressing blocking dependencies below the waterline. The iceberg diagram is not a metaphor for difficulty. It is a map of where migration programmes actually fail.

**Figure 1.1 — The Enterprise Cryptographic Dependency Iceberg**

```
                    ┌─────────────────────────────────┐
   VISIBLE          │  Web TLS, public code signing,  │
   (scanned first)  │  API gateway certificates       │
                    ├─────────────────────────────────┤
   INTEGRATION      │  Partner trust stores, B2B PKI, │
   (discovered)     │  federated identity, cloud KMS  │
                    ├─────────────────────────────────┤
   BLOCKING         │  Root CA keys, HSM ceremonies,  │
   (migrates last   │  firmware signing, embedded     │
    or blocks all)  │  libs, OT certs, vendor crypto  │
                    └─────────────────────────────────┘
                              ▲
                              │
                    Dependency flows downward.
                    Blocking nodes sit at the base.
```

Part III of this book introduces the **Cryptographic Dependency Graph (CDG)** — a methodology for making the iceberg explicit, machine-readable where possible, and actionable in migration wave planning. The CDG assigns edge types — `implements`, `trusts`, `terminates`, `signs`, `inherits` — to relationships between cryptographic assets. Blocking nodes are identified by graph analysis: nodes with high out-degree whose migration status gates the largest subgraph of dependent systems.

For now, the essential point is this: the iceberg's shape means that **discovery and dependency mapping precede prioritization**. Always.

> **Dependency Alert**
>
> Meridian's Phase 1 discovery found that 62% of visible-layer assets (web TLS, public certificates) depended on an internal issuing CA whose own certificate chain terminated at a root CA stored in an HSM partition with no post-quantum roadmap. Upgrading the visible layer without migrating the root would produce certificates that were individually post-quantum-capable in algorithm selection but issued by a quantum-vulnerable authority — a compliance and security posture that satisfies neither auditors nor threat models.

---

## 1.5 Programme Versus Project

The distinction between programme and project is organizational, not semantic. Confusing the two is the single most common cause of PQC migration failure in enterprises that are otherwise technically competent.

A **project** has a defined deliverable, a bounded scope, a budget, and an end date. Success is measured by on-time, on-budget delivery of the deliverable. A TLS hybrid pilot is a project. A PKI certificate profile update is a project. A library upgrade to OpenSSL 3.5 is a project.

A **programme** has a strategic objective, evolving scope, multi-year funding, and no fixed end date until the objective is achieved. Success is measured by progress against maturity milestones and risk reduction across the estate. PQC migration is a programme.

**Table 1.3 — Project vs. Programme Characteristics for PQC Migration**

| Attribute | Project model (fails) | Programme model (succeeds) |
|-----------|----------------------|---------------------------|
| Scope | "Deploy hybrid TLS on public services" | "Migrate estate to quantum-resistant cryptography" |
| Duration | 6–18 months | 5–15+ years |
| Funding | One-time capital request | Multi-year budget line with annual review |
| Governance | Security team project lead | Cross-functional steering committee |
| Success metric | Pilot completion | PQ-ADAPT maturity level progression |
| Dependency management | Out of scope | Core programme function |
| Vendor engagement | Procurement at purchase | Continuous roadmap assessment |
| Reporting | Project status to CISO | Programme dashboard to board risk committee |

Enterprises that charter PQC as a project create an organizational antibody response when the project "completes" but the estate remains vulnerable. The project team disbands. The budget closes. The blocking dependencies remain. The board receives a completion report that is technically accurate and strategically misleading.

Programme chartering — developed in Chapter 15 — establishes a migration authority with decision rights, a multi-year funding envelope, and reporting obligations that survive individual project completions. Meridian's programme charter, approved eight months after Elena's HSM finding, defined a five-year initial phase with explicit maturity targets, not a single deliverable.

---

## 1.6 Who Must Be in the Room

PQC migration fails organizationally when it is owned exclusively by the security team. The synchronization problem crosses functional boundaries. The following stakeholder map defines the minimum coalition for a credible programme.

**Table 1.4 — PQC Programme Stakeholder Map**

| Role | Primary contribution | Common failure mode | Minimum engagement |
|------|---------------------|---------------------|-------------------|
| **CISO / Security Leader** | Programme sponsorship, board narrative, risk acceptance | Treating PQC as a technical sub-project | Programme owner |
| **Enterprise Architect** | Dependency mapping, agility requirements, cross-domain design | Engaging only after algorithm selection | Steering committee member |
| **PKI / Identity Engineering** | CA hierarchy, certificate profiles, trust store management | Underestimating certificate size and validity impacts | Working group lead |
| **Cryptographic Engineering** | Algorithm selection, implementation review, validation | Optimizing for performance before inventory completeness | Technical authority |
| **Infrastructure / Network** | Protocol transitions (TLS, IPsec, SSH), middlebox assessment | Scheduling upgrades without partner compatibility analysis | Working group member |
| **Cloud Platform Engineering** | KMS, HSM-as-a-service, tenant isolation | Assuming cloud provider roadmap equals enterprise readiness | Working group member |
| **OT / ICS Security** | Operational technology constraints, continuity requirements | Excluded from programme until OT blocks IT migration | Steering committee member |
| **Procurement / Vendor Management** | Contractual PQC requirements, supplier assessment | Engaged after vendor roadmaps prove inadequate | Working group member |
| **Legal / Compliance** | Regulatory evidence, data retention alignment, contractual risk | Treated as reviewers rather than programme participants | Steering committee member |
| **Internal Audit** | Assurance criteria, evidence standards, control testing | Brought in at audit time rather than programme design | Annual review participant |
| **Business Unit Leadership** | Migration priority input, continuity risk acceptance | Informed rather than accountable | Quarterly briefing recipient |

No row in this table is optional for a large enterprise. Small and medium enterprises may combine roles, but the functions must be performed. A programme that lacks procurement engagement will discover, at contract renewal, that critical suppliers have no PQC roadmap. A programme that lacks OT representation will design IT migration sequences that OT cannot execute.

### Engagement sequencing

Stakeholder engagement follows a sequence that mirrors the ARCS Framework:

1. **CISO and Legal/Compliance** establish programme mandate and regulatory framing (Awareness)
2. **Enterprise Architect and PKI Engineering** lead discovery and dependency mapping (Register)
3. **Cryptographic Engineering and Cloud/Infrastructure** define agility requirements and technical standards (Capability)
4. **Procurement and Business Unit Leadership** align vendor roadmaps and business continuity (Synchronize)

Engaging procurement after technical standards are defined produces standards that no vendor can meet. Engaging OT after IT migration is planned produces rework. The sequencing is not bureaucratic. It reflects the dependency structure of the synchronization problem itself.

---

## 1.7 Lessons from Prior Migrations — and Their Limits

Enterprise security retains institutional memory of cryptographic transitions. Those memories inform — and mislead — PQC planning.

**SHA-1 deprecation (2005–2017)** taught enterprises that certificate discovery is harder than expected and that browser vendors can force timelines faster than internal planning cycles. The lesson applies: discovery is foundational. The limit: SHA-1's scope was certificate signatures. PQC's scope is all asymmetric cryptography.

**1024-bit RSA phase-out (2010–2015)** taught enterprises that cryptographic policy must be enforced in key generation, not just certificate issuance. The lesson applies: policy without inventory enforcement is ineffective. The limit: key size increases were backward-compatible within the same algorithm family. PQC changes algorithm families.

**TLS 1.3 adoption (2018–2023)** taught enterprises that protocol negotiation enables gradual client migration. The lesson partially applies: hybrid constructions serve a similar transitional function. The limit: TLS 1.3 did not change key or signature sizes materially. PQC does, breaking middleboxes and size-constrained systems that tolerated TLS 1.3.

**ECC introduction (2005–2015)** taught enterprises that algorithm agility in libraries enables faster transition. The lesson applies strongly: crypto-agility is the most valuable architectural investment an enterprise can make before PQC migration begins. The limit: ECC was adopted because it was faster and smaller than RSA. PQC algorithms are larger and slower — agility must accommodate parameter growth, not just algorithm substitution.

The meta-lesson: **prior migrations succeeded when the enterprise controlled the dependency graph.** PQC migration is the first enterprise cryptographic transition where the dependency graph extends comprehensively beyond organizational boundaries.

---

## 1.8 The ARCS Framework

This book organizes its guidance around four interlocking enterprise capabilities. Together they form the **ARCS Framework** — Awareness, Register, Capability, and Synchronize.

**Awareness** is the organizational understanding that PQC migration is a programme with a decade-scale horizon, driven by threat asymmetry and regulatory forcing functions, not by vendor product announcements. Awareness produces the board narrative, the risk register entry, and the programme charter. Part I of this book establishes Awareness.

**Register** is the maintained, authoritative inventory of cryptographic assets — algorithms, keys, protocols, libraries, certificates, and their deployment contexts — extended with dependency relationships. The Cryptographic Bill of Materials (CBOM), grounded in the CycloneDX specification, is the technical foundation of the Register. Part III builds the Register.

**Capability** is the architectural and operational ability to adopt, test, deploy, and retire cryptographic algorithms without re-engineering the systems that depend on them. Cryptographic agility, hybrid lifecycle management, and validation programmes are Capability investments. Part IV builds Capability.

**Synchronize** is the programme discipline that aligns internal teams, external partners, vendor roadmaps, and regulatory timelines on a shared migration sequence. Governance structures, procurement requirements, and sector playbooks are Synchronization mechanisms. Parts V and VI build Synchronize.

ARCS is sequential in learning order but parallel in execution. An enterprise does not finish Awareness before beginning Register work. It does, however, need Awareness before it can justify Register investment to the board — and Register before it can make defensible Capability investments.

### PQ-ADAPT Maturity Model — Levels 0 Through 2

The **PQ-ADAPT Maturity Model** provides a measurable progression through ARCS capabilities from Level 0 (Unaware) to Level 5 (Quantum-Resilient). Part III develops the full model. Part I establishes the baseline:

**Level 0 — Unaware:** No quantum risk in enterprise risk register. No cryptographic inventory. PQC not referenced in policies. *Most enterprises before 2024.*

**Level 1 — Alerted:** Executive awareness established. Ad hoc discovery initiated. No programme charter. Pilots may be authorized without governance. *Many enterprises in 2025–2026.*

**Level 2 — Inventoried:** CBOM baseline established. Data classified by confidentiality horizon. HNDL risk assessed. Blocking dependencies identified. No enterprise-wide architecture standards for agility. *Target for Phase 1 completion.*

Meridian Mutual Bank reached Level 2 at the end of its twelve-month Phase 1. It had not deployed post-quantum cryptography in production. By the PQ-ADAPT model, it was ahead of most peers — because it knew what it had, what blocked migration, and what threatened it.

---

## 1.9 Communicating With the Board

The board does not need to understand lattice cryptography. It needs to understand three propositions that justify programme investment:

**Proposition 1: The threat timeline is asymmetric.** Adversaries can collect encrypted data today and decrypt it later. Data the organization must protect for decades is already at risk. This is not speculative. It is the operating model of sophisticated threat actors against high-value targets.

**Proposition 2: Migration is a multi-year programme, not a project.** Industry analysis and historical precedent support 5–15+ year timelines for comprehensive migration. Starting now aligns with regulatory guidance. Starting in 2030 does not.

**Proposition 3: Early investment is cheaper than emergency migration.** Cryptographic inventory, agility requirements in new systems, and governance structures are modest investments. Emergency retrofit under regulatory deadline pressure — or after a quantum computing breakthrough — is not.

**Table 1.5 — Board Reporting Framework (Annual Programme Review)**

| Report element | Source | Board question answered |
|---------------|--------|------------------------|
| PQ-ADAPT maturity level | Programme self-assessment | Are we progressing? |
| Percentage of estate inventoried | CBOM | Do we know what we have? |
| Blocking dependencies resolved vs. open | CDG | What is preventing progress? |
| Regulatory alignment status | Compliance overlay | Are we defensible to supervisors? |
| Budget consumed vs. planned | Programme finance | Is investment adequate? |
| Partner/vendor readiness summary | Procurement assessment | Can the ecosystem support us? |

Elena's first board presentation on PQC migration did not mention ML-KEM. It presented the dependency chain behind the HSM finding, the timeline research, and a request for a chartered programme with three-year funding. The board approved the charter. Algorithm selection came later.

---

## 1.10 What This Book Is and Is Not

This book is a practitioner reference for security leaders, enterprise architects, cryptographic engineers, and compliance officers who must design, govern, and evidence a post-quantum cryptographic migration programme.

It is **not** a mathematics textbook. FIPS 203, 204, and 205 are treated as inputs — authoritative algorithm specifications that inform architectural decisions — not as content to reproduce. Readers who need lattice reduction tutorials or security proof techniques should consult the academic literature, including Stinson's forthcoming *Primer on Post-Quantum Cryptography*.

It is **not** a vendor guide. Product names appear only where necessary for interoperability illustration. No vendor roadmap is endorsed. The frameworks in this book are designed to evaluate vendor claims, not repeat them.

It is **not** a quantum computing primer. The book assumes the reader accepts that cryptographically relevant quantum computers pose a credible long-term threat to RSA, DH, and ECC. It does not forecast quantum hardware timelines beyond what is necessary for migration planning.

It **is** a source of original enterprise methodologies: the Cryptographic Dependency Graph, the TRADE prioritization engine, the Hybrid Lifecycle Model, the PQC Governance Stack, and the Sector Overlay Matrix. These frameworks are designed for this book. They are not adapted consulting methodologies or repackaged standards documents.

---

## 1.11 The Programme Horizon

Return to Meridian Mutual Bank. Elena's programme, chartered six months after the HSM finding, did not begin with algorithm selection. It began with a board-approved migration authority, a cross-functional steering committee, and a twelve-month Phase 1 scope limited to cryptographic discovery and dependency mapping across the card-processing and retail banking estates.

By the end of Phase 1, Meridian had identified 14,200 cryptographic assets, of which 38% resided in third-party systems with incomplete visibility. The HSM firmware signing chain was one of forty-seven blocking nodes in the dependency graph. The external TLS upgrade that Elena's predecessor had scoped as "the PQC project" ranked fourteenth in the TRADE prioritization analysis.

Phase 1 cost approximately €1.2 million — primarily staffing, tooling, and external consulting for CBOM establishment. Phase 2, scoped for algorithm standards definition and agility requirements in the systems development lifecycle, was budgeted at €2.4 million over eighteen months. Total five-year programme estimate: €11–14 million, presented to the board as comparable to a medium-scale regulatory compliance programme, not a security tool purchase.

Meridian's story continues throughout this book. It is joined by three other fictional organizations — Northfield Energy Systems, Apex Defense Technologies, and GlobalSync Logistics — each illustrating different constraints, sectors, and failure modes. They are composites drawn from patterns observed across financial services, critical infrastructure, defense industrial base, and multinational SaaS environments. They are not case studies in the consulting sense. They are teaching instruments.

The programme horizon for organizations like Meridian is measured in years, not quarters. NIST's transition guidance, articulated in IR 8547, anchors deprecation of quantum-vulnerable algorithms after 2030 and disallowance after 2035. NSA's CNSA 2.0 suite imposes binding milestones for National Security Systems on a comparable timeline. The EU's Digital Operational Resilience Act requires financial entities to maintain encryption policies responsive to developments in cryptanalysis — language that regulators and auditors are increasingly interpreting as requiring a documented PQC trajectory.

These timelines are not deadlines that permit inaction until 2029. They are policy anchors around which a programme must be structured. An enterprise that begins discovery in 2026, architectures agility requirements in 2027, and executes production migration from 2028 onward is aligned with the guidance. An enterprise that begins in 2030 is not.

### Programme scale by enterprise size

Migration programme scale varies with estate complexity, not headcount alone. A 500-person fintech with cloud-native architecture and heavy third-party dependency may require a larger programme than a 5,000-person manufacturing company with centralized IT and limited cryptographic diversity.

**Table 1.6 — Programme Scale Indicators**

| Indicator | Small enterprise | Medium enterprise | Large enterprise |
|-----------|-----------------|-------------------|------------------|
| Cryptographic asset count (estimated) | 200–2,000 | 2,000–20,000 | 20,000–200,000+ |
| Distinct algorithm implementations | 5–15 | 15–50 | 50–200+ |
| Third-party crypto dependencies | Low–moderate | Moderate–high | High |
| OT/ICS presence | Rare | Occasional | Common (CI operators) |
| Regulatory frameworks | 1–2 | 2–4 | 4–10+ |
| Recommended Phase 1 duration | 3–6 months | 6–12 months | 12–18 months |
| Steering committee size | 5–7 members | 8–12 members | 12–20 members |

These indicators inform staffing and budget, not urgency. A small enterprise with thirty-year archival data faces the same HNDL threat as a large one. A large enterprise with mature PKI and crypto-agile development practices may migrate faster than a small one with embedded legacy dependencies.

### The four teaching organizations

This book follows four fictional organizations whose constraints span the enterprise landscape:

**Meridian Mutual Bank** — 8,000 employees, retail and commercial banking, EU-headquartered, DORA-regulated. Teaches vendor dependency, payment HSM constraints, and regulatory evidence under financial supervision.

**Northfield Energy Systems** — 12,000 employees, gas transmission and distribution, US critical infrastructure. Teaches OT/IT convergence, long certificate validity, nation-state threat models, and operational continuity requirements.

**Apex Defense Technologies** — 25,000 employees, defense prime contractor, CMMC and FedRAMP obligations. Teaches CNSA 2.0 alignment, classified/unclassified boundary management, and programme consolidation under competing mandates.

**GlobalSync Logistics** — 3,500 employees, multinational SaaS platform, forty-country operations. Teaches cloud-native agility, tenant contractual constraints, cross-border compliance, and ecosystem synchronization at scale.

Each organization reappears in case study threads, sector playbooks (Part VI), and worked examples. Their problems are specific. The underlying synchronization dynamics are universal.

---

## 1.12 Cryptography as Invisible Infrastructure

A contributing factor to the synchronization problem is that cryptography is **invisible infrastructure**. Unlike network firewalls or endpoint protection platforms, cryptographic components rarely have dedicated operational teams, executive dashboards, or line-item budgets. Cryptography is embedded — in libraries, in protocols, in hardware, in vendor appliances — and discovered only when something breaks or an assessor asks.

Basescu et al., in their 2024 USENIX Security Symposium analysis of post-quantum deployment considerations, identify "cryptographic inventory gap" as the most consistent barrier to migration readiness across organizations of varying size and sector. The gap is not a tooling failure. It is an organizational visibility failure. Enterprises know how many servers they operate. They rarely know how many distinct cryptographic implementations those servers depend on, including transitive dependencies through shared libraries and container base images.

This invisibility creates a planning trap. Executives ask "are we PQC ready?" Security leaders answer with pilot status or vendor roadmap summaries because those are the visible artefacts. The invisible estate — embedded firmware, partner integrations, legacy mainframe cryptographic modules — remains unassessed. The honest answer to "are we PQC ready?" before inventory completion is: **we do not know.**

The Register phase of ARCS exists to make cryptography visible. It is not a preliminary step that can be abbreviated. It is the foundation on which every subsequent investment depends.

### The National Cybersecurity Center of Excellence

NIST's National Cybersecurity Center of Excellence (NCCoE) launched the Migration to Post-Quantum Cryptography project to demonstrate tools and practices for enterprise migration. The project focuses on discovery, prioritization, and interoperable deployment — explicitly acknowledging that migration is an enterprise coordination challenge, not an algorithm implementation exercise.

Enterprises should monitor NCCoE publications for reference architectures and tooling guidance. They should not wait for NCCoE deliverables before beginning inventory. The NCCoE's own framing treats discovery as the immediate action. This book's Register methodology (Part III) is aligned with NCCoE's direction while providing the governance and sector overlays that reference implementations typically omit.

---

## 1.13 PQC Migration and Zero Trust Modernization

Many enterprises are simultaneously executing Zero Trust architecture programmes — identity-centric access, micro-segmentation, continuous verification. PQC migration intersects with Zero Trust in ways that create both opportunity and contention.

**Opportunity:** Zero Trust programmes already require identity modernization, certificate lifecycle improvement, and device attestation — capabilities that overlap with PQC migration prerequisites. An identity team replacing password-dependent VPN access with certificate-based device authentication is building infrastructure that must eventually use post-quantum signatures. Integrating PQC requirements into Zero Trust architecture standards avoids duplicate migration.

**Contention:** Zero Trust and PQC programmes compete for the same teams — PKI engineering, identity architecture, network security — and the same budget envelopes. Enterprises that treat them as independent programmes will experience timeline extension from resource contention. Campbell's timeline analysis explicitly identifies interaction with broader security modernization as a timeline-extending factor.

**Architect's Decision:** Integrate PQC agility requirements into Zero Trust architecture standards where both programmes are active. Do not sequence them serially unless resource constraints require it. If serial sequencing is unavoidable, prioritize the programme whose blocking dependencies are more severe — typically PQC for long-confidentiality data, Zero Trust for access control gaps. For most regulated enterprises in 2026, PQC inventory and agility requirements should be embedded in Zero Trust standards documents, not deferred until Zero Trust is "complete."

Apex Defense Technologies, introduced in later chapters, attempted to run CMMC compliance, Zero Trust implementation, and PQC migration as three independent programmes. The programmes converged at the PKI team, which became the bottleneck for all three. Consolidation under a single cryptographic governance function reduced timeline overlap by an estimated eighteen months — not by working faster, but by eliminating contradictory priorities assigned to the same engineers.

---

## 1.14 Common Failure Patterns

Reviewing PQC migration programmes across sectors reveals recurring failure patterns. Naming them explicitly helps security leaders recognize early warning signs before programmes stall.

**Pattern 1: Algorithm-first planning.** The programme begins with algorithm selection workshops before inventory is complete. Standards are chosen. Policies are drafted. Discovery then reveals that the chosen algorithms cannot be deployed in the systems that matter most — because of HSM limitations, certificate size constraints, or partner incompatibility. The policy is correct. The estate cannot comply. *Remediation: inventory before standards definition.*

**Pattern 2: TLS myopia.** External TLS is upgraded. Internal systems, PKI hierarchies, code signing, and partner integrations remain on quantum-vulnerable cryptography. Executive reporting shows "PQC deployed" because the customer-facing metric moved. The estate remains vulnerable. *Remediation: CBOM-based reporting, not pilot-based reporting.*

**Pattern 3: Vendor roadmap substitution.** The programme consists of reviewing vendor PQC roadmaps and marking products "on track." No contractual requirements are added. No independent validation is performed. Vendor delays become enterprise delays without escalation mechanism. *Remediation: procurement integration with evidence requirements (Chapter 16).*

**Pattern 4: Compliance theatre.** Policies reference NIST FIPS 203–205. The certificate register is empty. The gap between policy and practice is not documented. Supervisory examination or audit reveals the discrepancy. The organization is worse positioned than one with honest gap documentation and a remediation plan. *Remediation: document current state accurately; policies describe target state and transition plan.*

**Pattern 5: Perpetual pilot.** Hybrid TLS or PQC library integration is demonstrated annually without production deployment. Each demonstration resets the "progress" narrative. Budget is consumed. Estate is unchanged. *Remediation: define production deployment gates in programme charter; pilots require explicit exit criteria.*

**Pattern 6: OT exclusion.** IT migration proceeds without OT involvement. OT systems share PKI hierarchies, network infrastructure, or vendor relationships with IT. IT changes break OT. OT blocks IT migration retroactively. *Remediation: OT representation on steering committee from programme inception.*

Meridian exhibited early signs of Patterns 2 and 4 before Elena chartered the formal programme. The HSM finding disrupted the pattern by making a blocking dependency visible before the TLS pilot could be declared complete.

### Measuring programme progress honestly

Enterprises under board or regulatory pressure to demonstrate PQC progress face incentive to report activity metrics — pilots launched, policies drafted, vendors assessed — rather than outcome metrics — assets migrated, vulnerabilities retired, blocking dependencies resolved. The PQ-ADAPT maturity model provides outcome-oriented measurement. Reporting "we completed a hybrid TLS pilot" corresponds to Level 1 (Alerted) activity. Reporting "we migrated Wave 1 assets representing 15% of TES 5 systems" corresponds to Level 4 (Transitioning) progress.

Honest measurement requires defining metrics before migration begins and resisting the substitution of activity for outcome. The board reporting framework in Section 1.9 is designed to prevent this substitution. If the metric can be achieved without changing the quantum-vulnerable state of the estate, it is the wrong metric.

### The cost of synchronization failure

Quantifying synchronization failure is difficult because the counterfactual — what happens when an enterprise treats PQC as a project rather than a programme — manifests as delayed production deployment, not as a single incident. The costs are nonetheless real and accumulate across several categories.

**Rework cost.** Pilots that cannot reach production because blocking dependencies were not identified must be repeated after dependencies are resolved. Meridian's abandoned TLS-first pilot consumed approximately €180,000 in engineering time before the programme was restructured. The work was not wasted — it informed hybrid compatibility data — but it was not migration progress.

**Vendor leverage cost.** Enterprises that engage procurement after discovering vendor roadmap inadequacy negotiate from weakness. Contractual PQC requirements inserted at renewal, when the enterprise has no alternative supplier, carry premium pricing. Early procurement engagement — before roadmap gaps become urgent — produces better commercial terms.

**Regulatory examination cost.** Supervisory findings that could have been avoided with honest gap documentation require remediation under examination timelines, external consultant engagement, and management attention disproportionate to the cost of proactive programme chartering.

**Opportunity cost.** Engineering teams assigned to repeated PQC pilots that do not reach production cannot be assigned to agility requirements in new systems — the investment that most efficiently reduces long-term migration cost.

These costs are not arguments for panic. They are arguments for programme structure — the organizational response the synchronization problem demands.

### Reading this book

This book is structured for sequential reading and reference use. Part I establishes why migration is necessary and how to frame the organizational response. Parts II through VI assume Part I's foundations and develop progressively more operational guidance. Readers seeking immediate inventory methodology may be tempted to jump to Part III. Readers seeking hybrid TLS configuration may be tempted to jump to Part IV. Both will encounter dependencies on concepts — TRADE scoring, Governance Stack artefacts, blocking node analysis — introduced in Part I and developed in intervening chapters.

The recommended reading paths:

- **CISO / Security Leader:** Part I complete, then Chapters 15 (governance), 9 (wave planning), 19–22 (sector playbooks)
- **Enterprise Architect:** Part I, Part II, Part III (CDG focus), Part IV complete
- **Cryptographic Engineer:** Part II, Part IV, Chapter 18 (validation)
- **Compliance Officer:** Part I Chapter 3, Chapter 16 (procurement), sector playbook for your industry
- **Board / Executive:** Part I complete, Chapter 15 Section 15.2 (board reporting), annual review of PQ-ADAPT maturity

Each chapter includes case study threads from the four teaching organizations. Following a single organization's thread through the book — Meridian for financial services, Northfield for critical infrastructure — provides narrative continuity for readers who prefer case-driven learning.

---

## 1.15 Chapter Summary

- NIST finalized FIPS 203, 204, and 205 in August 2024, ending the algorithm selection phase and beginning the enterprise deployment phase.
- PQC migration differs fundamentally from prior cryptographic transitions in ecosystem scope, parameter implications, hybrid complexity, and threat timeline asymmetry.
- The central thesis: migration is a **synchronization problem**, not a cryptographic upgrade. Dependency chains, not exposure alone, determine migration sequence.
- The enterprise cryptographic estate resembles an iceberg: visible assets above the waterline, blocking dependencies below it.
- Programmes, not projects, are the correct organizational model for migration governance.
- Credible programmes require cross-functional stakeholder coalitions with defined engagement sequencing.
- The ARCS Framework — Awareness, Register, Capability, Synchronize — organizes the book's guidance and the PQ-ADAPT maturity progression.
- Board communication focuses on threat asymmetry, programme duration, and investment rationale — not algorithm details.
- Realistic migration timelines extend 5–15+ years for most enterprises. Programme structure must reflect this horizon.

**Next:** Chapter 2 examines the threat models that should drive migration priorities — replacing quantum hype with the decision-grade analysis that determines which systems move first and which can wait.

---

*Chapter 1 — References*

- Campbell, R. (2025). Enterprise Migration to Post-Quantum Cryptography: Timeline Analysis and Strategic Frameworks. *Computers*, 15(1), 9.
- National Institute of Standards and Technology. (2024). FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard.
- National Institute of Standards and Technology. (2024). FIPS 204: Module-Lattice-Based Digital Signature Standard.
- National Institute of Standards and Technology. (2024). FIPS 205: Stateless Hash-Based Digital Signature Standard.
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to Post-Quantum Cryptography Standards.
- National Security Memorandum 10 on Promoting United States Leadership in Quantum Computing While Mitigating Risks to Vulnerable Cryptographic Systems (2022).
- World Economic Forum. (2024). Quantum Security: Preparing for the Post-Quantum Era.
