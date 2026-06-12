
# Post-Quantum Cryptography: Enterprise Migration Handbook
## Book Architecture & Development Package (v1.0)

**Status:** Part IV draft complete (Chapters 10–14); Part V next  
**Date:** June 2026  
**Architecture approved:** June 2026  
**Publisher targets:** Wiley · CRC Press · O'Reilly · IEEE Press · Apress

---

# 1. Book Positioning Analysis

## 1.1 Market Context

The post-quantum cryptography market crossed an inflection point in August 2024, when NIST published FIPS 203 (ML-KEM), FIPS 204 (ML-DSA), and FIPS 205 (SLH-DSA). For the first time, enterprises have *final* algorithm standards—not candidates, not drafts. Concurrently:

- **NIST IR 8547** (initial public draft, November 2024) establishes deprecation (post-2030) and disallowance (post-2035) timelines for quantum-vulnerable public-key algorithms.
- **NSA CNSA 2.0** imposes binding migration milestones for National Security Systems (2027–2035).
- **DORA** (effective January 2025) requires EU financial entities to maintain encryption policies responsive to developments in cryptanalysis, explicitly including quantum advancements.
- **NIS2** mandates state-of-the-art security measures for essential and important entities across critical sectors.
- **OpenSSL 3.5+**, major cloud HSM platforms, and IETF hybrid TLS constructions are entering production adoption cycles.

The industry no longer debates *whether* to migrate. It debates *how*, *in what order*, *under what governance*, and *with what evidence of progress*—across estates that routinely require 5–15+ years to complete (Campbell, *Computers*, 2025).

## 1.2 Positioning Statement

**This book is the first practitioner-grade enterprise programme reference for post-quantum cryptographic migration**—not an algorithm textbook, not a NIST republication, and not a vendor readiness brochure.

It occupies the space between:

| Too theoretical | **This book** | Too superficial |
|---|---|---|
| Lattice mathematics | Enterprise migration architecture | Executive slide decks |
| Proof techniques | Governance and assurance | Blog checklists |
| Academic PQC primers | Sector playbooks with decision logic | Vendor "start now" whitepapers |

## 1.3 Primary Reader Personas

| Persona | Primary need | What they will extract |
|---|---|---|
| **CISO / Security Leader** | Board-credible programme design, regulatory defensibility | Governance frameworks, maturity model, executive dashboards |
| **Enterprise Architect** | Cross-domain dependency mapping, hybrid design | Architecture patterns, CBOM methodology, protocol transition maps |
| **Cryptographic Engineer** | Standards-to-implementation translation | Algorithm selection logic, validation paths, interoperability constraints |
| **Compliance Officer** | Evidence of state-of-the-art practice | Regulatory mapping matrices, audit artefacts, policy templates |
| **Government / Defense security teams** | Alignment with CNSA 2.0, FIPS, NSS requirements | Federal transition overlays, classified system considerations |
| **Critical infrastructure operators** | OT/IT convergence, long-lived asset protection | Sector constraints, operational continuity patterns |

## 1.4 Strategic Promise

After reading this book, a security leader will be able to:

1. **Commission** a cryptographically grounded migration programme with defensible scope, timeline, and budget.
2. **Govern** migration as a cross-functional enterprise transformation—not a PKI project or a TLS upgrade.
3. **Prioritize** systems using a structured threat-and-dependency model rather than vendor urgency.
4. **Design** hybrid and agile architectures that survive both quantum advances and standards evolution.
5. **Demonstrate** compliance with DORA, NIS2, GDPR, PCI, and federal transition guidance through documented artefacts.
6. **Anticipate** supply-chain, PKI, and key-management failure modes before they block production deployment.

## 1.5 Reader Transformation

| Before | After |
|---|---|
| "We need a PQC strategy" (undefined) | A chartered programme with phases, owners, and measurable gates |
| Algorithm awareness without inventory | A maintained Cryptographic Asset Register (CBOM-grounded) |
| Fear of breaking interoperability | Hybrid deployment patterns with explicit sunset criteria |
| Regulatory anxiety without evidence | Mapped controls, policies, and audit trails |
| Siloed pilot projects | Coordinated migration across IT, OT, cloud, and third parties |

## 1.6 Publisher Fit

| Publisher | Fit rationale |
|---|---|
| **Wiley** | Enterprise security and compliance catalogue; strong CISO readership |
| **CRC Press** | Technical credibility; complements (does not compete with) Stinson's forthcoming academic primer |
| **O'Reilly** | Practitioner architecture audience; playbook and framework format |
| **IEEE Press** | Standards-adjacent reference; government and critical infrastructure buyers |
| **Apress** | Implementation depth for engineers; CBOM and tooling chapters |

**Recommended primary pitch:** Wiley or O'Reilly (enterprise security + architecture crossover). **Secondary:** IEEE Press (standards and government procurement channels).

## 1.7 Distinctive Market Claim

> *Standards tell you what algorithms exist. This book tells you how an enterprise survives the decade it takes to deploy them.*

---

# 2. Competitive Gap Analysis

## 2.1 Competing Literature Map

### Category A: Academic & Cryptographic Textbooks

| Title | Authors/Publisher | Strengths | Gaps relative to this book |
|---|---|---|---|
| *Post-Quantum Cryptography* (2009) | Bernstein, Buchmann, Dahmen / Springer | Foundational algorithm families; mathematical rigor | Pre-NIST-finalization; no enterprise migration; no FIPS 203–205 |
| *A Primer on Post-Quantum Cryptography* (forthcoming 2026–27) | Stinson / CRC | Accessible algorithm introduction; NIST-aware | Undergraduate/research audience; no organizational playbooks |
| *Lattice-Based Cryptography: From Theory to Practice* (2024) | O'Neill et al. / Springer | Hardware/software implementation depth | Algorithm-centric; limited governance or sector guidance |
| *Mathematical Foundations for Post-Quantum Cryptography* (2026) | Takagi et al. / Springer Open Access | Advanced mathematical cryptography | Not written for enterprise decision-makers |
| *Cryptography: Theory and Practice* (Stinson/Paterson) | CRC | Classical crypto pedagogy | PQC treated peripherally; not a migration handbook |

### Category B: General Security Architecture

| Title | Focus | Gap |
|---|---|---|
| *Security Engineering* (Anderson) | Broad security design | PQC not treated as enterprise programme |
| *Zero Trust Architecture* (Rose et al. / NIST SP 800-207) | Identity and segmentation | Crypto transition treated indirectly |
| Cloud security references (CSA, Well-Architected) | Platform patterns | PQC treated as emerging, not operationalized |

### Category C: NIST & Government Guidance

| Document | Role | Gap |
|---|---|---|
| FIPS 203, 204, 205 | Algorithm specifications | Not migration methodology |
| NIST IR 8547 | Transition timelines | Federal orientation; limited sector playbooks |
| NIST CSWP 15 / Getting Ready for PQC (2021) | High-level readiness | Dated relative to finalized FIPS; lacks implementation depth |
| CISA PQC Initiative materials | Awareness and inventory | Not a cohesive book-length programme design |
| NSA CNSA 2.0 Advisory | NSS algorithm policy | Narrow scope; not commercial enterprise architecture |

### Category D: Industry Frameworks & Whitepapers

| Source | Contribution | Gap |
|---|---|---|
| Applied Quantum PQC Migration Framework (Ivezic, 2025–26) | Strong 8-phase practitioner methodology | Not a published book; limited regulatory and sector synthesis |
| WEF Quantum Security (2024) | Executive framing | Not implementable at engineering depth |
| ENISA NIS2 implementation guidance | EU regulatory context | Not a full migration architecture reference |
| Vendor guides (Entrust, IBM, Cryptomathic, etc.) | Product-adjacent roadmaps | Commercial bias; fragmented coverage |

### Category E: Peer-Reviewed Enterprise Research

| Source | Contribution | Gap |
|---|---|---|
| Campbell, "Enterprise Migration to PQC: Timeline Analysis" (*Computers*, 2025) | Evidence-based timeline modeling (5–15+ years) | Academic paper; no operational playbooks or sector cases |
| Basescu et al., USENIX Security 2024 | Deployment considerations in practice | Research paper; not programme governance |

## 2.2 What the Industry Already Knows

- Shor's algorithm threatens RSA, DH, and ECC at scale.
- NIST has standardized ML-KEM, ML-DSA, and SLH-DSA.
- Hybrid constructions are the near-term deployment norm.
- Cryptographic inventory is the necessary first step.
- Migration timelines exceed executive expectations.
- "Harvest now, decrypt later" (HNDL) creates urgency for long-confidentiality data.

## 2.3 What Existing Books Cover Well

- Algorithm mathematics and security reductions.
- Lattice, hash, code, and multivariate scheme families.
- NIST competition history and algorithm design principles.
- High-level executive awareness of quantum risk.

## 2.4 What Existing Books Fail to Cover

1. **Programme architecture** — How to structure a 10-year migration as a governed enterprise capability.
2. **Dependency-chain reasoning** — Why PKI, HSM, firmware signing, and partner APIs create blocking dependencies.
3. **Hybrid sunset logic** — When hybrids are mandatory, transitional, or non-compliant.
4. **Regulatory synthesis** — How DORA, NIS2, GDPR, PCI DSS 4.0, and US federal guidance converge on *demonstrable* PQC readiness without explicit "PQC" mandates.
5. **OT/IT cryptographic divergence** — Critical infrastructure constraints absent from cloud-centric guides.
6. **FIPS 140-3 validation paths** — Module transition strategy for regulated environments.
7. **Crypto-agility as organizational capability** — Beyond "use a library that supports multiple algorithms."
8. **Third-party cryptographic risk** — CBOM/SBOM integration, contractual leverage, and ecosystem synchronization.
9. **Decision-grade case studies** — Fictional but realistic organizations with constraints, trade-offs, and measurable outcomes.
10. **Failure modes** — What breaks when enterprises treat PQC as a certificate rotation project.

## 2.5 Why This Book Must Exist

The market has bifurcated into **mathematics** (academic texts) and **urgency** (vendor whitepapers). NIST IR 8547 and DORA created a **compliance forcing function**, but no single reference teaches leaders how to:

- Translate standards into **portfolio decisions**
- Build **evidence** regulators and auditors accept
- Coordinate **ecosystem dependencies** across a decade-long transition
- Operate **hybrid cryptography** without accumulating permanent technical debt

Stinson's forthcoming primer will strengthen the *algorithm* shelf. This book owns the *enterprise migration* shelf.

---

# 3. Core Thesis

## 3.1 Central Argument

**Post-quantum cryptographic migration is not a cryptographic upgrade. It is an enterprise-wide synchronization problem** that must be governed, inventoried, architected, and evidenced across organizational boundaries—because the technical work cannot outrun the dependency graph.

## 3.2 Supporting Propositions

1. **Standards are inputs, not programmes.** FIPS 203–205 define algorithms; they do not define inventory methods, governance structures, hybrid policies, or sector-specific continuity requirements.

2. **Time asymmetry is the primary risk.** Data confidentiality lifetimes, certificate validity periods, and regulatory evidence horizons exceed the time required for ecosystem readiness—making early structured action rational even under quantum timeline uncertainty.

3. **Hybrid deployment is a programme phase, not a destination.** Hybrids exist to preserve interoperability during transition; enterprises that fail to define sunset criteria will carry dual-algorithm complexity indefinitely.

4. **Cryptographic agility is an organizational property.** Agility requires separable algorithm configuration, observable inventories, testable rollback, and procurement enforceability—not merely selecting a PQC-capable library.

5. **Regulatory compliance is achieved through demonstrable state-of-the-art practice.** DORA and NIS2 do not name ML-KEM; they require policies, risk assessments, and controls that *cannot* be satisfied without a documented PQC trajectory.

6. **Migration failure is predictable.** Organizations that skip inventory, treat PKI as late-stage work, ignore OT constraints, or defer supply-chain engagement will encounter blocking dependencies that no algorithm selection can resolve.

## 3.3 What This Book Argues Against

- **Timeline complacency** — "We have until 2035."
- **Algorithm-first planning** — Selecting ML-KEM before knowing where RSA-2048 lives.
- **Pilot proliferation without governance** — Multiple teams experimenting without a migration authority.
- **Vendor substitution for architecture** — Buying "PQC-ready" products without CBOM integration.
- **Permanent hybridism** — Deploying X25519MLKEM768 without a classical sunset plan.

## 3.4 Evidence Base (Manuscript Requirements)

The book will ground claims in:

- NIST FIPS 203, 204, 205; NIST IR 8547; SP 800-208 (stateful hash signatures)
- NSA CNSA 2.0 Advisory and CNSSP 15
- EU DORA (Regulation 2022/2554) and RTS 2024/1532
- NIS2 Directive 2022/2555; ENISA implementation guidance
- GDPR Article 32 (state-of-the-art security measures)
- CycloneDX CBOM specification (v1.6+)
- IETF hybrid TLS constructions (RFC 9180 ecosystem)
- Peer-reviewed timeline research (Campbell, 2025)
- USENIX Security 2024 deployment considerations (Basescu et al.)

---

# 4. Intellectual Framework

## 4.1 The ARCS Knowledge Framework

The book organizes all content around four interlocking enterprise capabilities:

```
┌─────────────────────────────────────────────────────────────┐
│                        ARCS FRAMEWORK                        │
├──────────────┬──────────────┬──────────────┬────────────────┤
│  AWARENESS   │  REGISTER    │  CAPABILITY  │  SYNCHRONIZE   │
│  Threat,     │  CBOM,       │  Agility,    │  Ecosystem,    │
│  regulatory  │  dependency  │  hybrid      │  vendors,      │
│  drivers,    │  graph,      │  patterns,   │  standards     │
│  executive   │  risk        │  validation  │  bodies,       │
│  narrative   │  tiers       │  paths       │  partners      │
└──────────────┴──────────────┴──────────────┴────────────────┘
```

**Awareness** — Establish why migration is a programme, not a project.  
**Register** — Maintain authoritative cryptographic knowledge.  
**Capability** — Build systems that can adopt, test, and retire algorithms.  
**Synchronize** — Align internal and external dependencies on a shared timeline.

## 4.2 Original Framework: PQ-ADAPT Maturity Model

A six-level maturity model for enterprise PQC readiness (original to this book):

| Level | Name | Characteristics |
|---|---|---|
| 0 | **Unaware** | No quantum risk in risk register; no crypto inventory |
| 1 | **Alerted** | Executive awareness; ad hoc discovery; no charter |
| 2 | **Inventoried** | CBOM baseline; HNDL-tiered data classification; no architecture standards |
| 3 | **Architected** | Crypto-agility requirements in SDLC; hybrid policy defined; PKI roadmap approved |
| 4 | **Transitioning** | Production hybrids; HSM/KMS PQC paths; supplier contracts updated; validation programme active |
| 5 | **Quantum-Resilient** | Quantum-vulnerable PKC retired per policy; continuous CBOM; agility tested annually |

Each level defines: entry criteria, required artefacts, typical failure modes, and upgrade investments.

## 4.3 Original Framework: TRADE Decision Engine

**T**hreat exposure · **R**egulatory obligation · **A**rchitectural dependency · **D**ata longevity · **E**cosystem readiness

A prioritization engine for migration waves. Each system receives scored dimensions (1–5) producing a composite **Migration Priority Index (MPI)**. The book provides worked examples, weighting guidance by sector, and explicit "do not migrate yet" conditions.

## 4.4 Original Framework: Cryptographic Dependency Graph (CDG)

A methodology extending CBOM with:

- **Nodes:** Applications, protocols, libraries, HSM partitions, CAs, firmware images, partner endpoints
- **Edges:** `implements`, `trusts`, `terminates`, `signs`, `inherits`
- **Attributes:** Algorithm, key size, validity horizon, agility class, validation status

The CDG identifies **blocking nodes**—assets whose delayed migration prevents downstream transitions. This is the book's primary antidote to "start with TLS" simplifications.

## 4.5 Original Framework: Hybrid Lifecycle Model (HLM)

Three hybrid phases with explicit exit criteria:

| Phase | Name | Objective | Exit criterion |
|---|---|---|---|
| H1 | **Protective Hybrid** | Maintain interoperability; add quantum resistance | Ecosystem threshold met (e.g., >90% client support) |
| H2 | **Transitional Hybrid** | Reduce classical dependency | Classical component deprecated in policy |
| H3 | **PQC-Native** | Quantum-vulnerable PKC removed | CBOM confirms zero disallowed algorithms |

## 4.6 Original Framework: PQC Governance Stack

Five governance layers (board to engineering):

1. **Strategic** — Board risk appetite; quantum risk in ERM
2. **Programme** — Migration authority; charter; funding model
3. **Policy** — Algorithm standards; hybrid policy; exception process
4. **Operational** — CBOM maintenance; change windows; validation gates
5. **Assurance** — Internal audit; penetration testing; regulatory evidence

## 4.7 Original Framework: Sector Overlay Matrix (SOM)

A cross-reference structure mapping universal migration phases to sector-specific constraints (banking, defense, energy, healthcare, government civilian). Each sector overlay modifies TRADE weights, HLM timelines, and compliance evidence requirements.

## 4.8 Learning Progression

```
Part I:  WHY (risk + regulatory forcing functions)
   ↓
Part II: WHAT (standards as inputs — concise, not exhaustive)
   ↓
Part III: WHERE (inventory + dependency graph)
   ↓
Part IV: HOW (architecture + implementation patterns)
   ↓
Part V: WHO & WHEN (governance + programme management)
   ↓
Part VI: PROOF (sector playbooks + case studies + assurance)
```

---

# 5. Recommended Book Architecture

## 5.1 Structural Decision Rationale

**Parts: 6** — Mirrors the ARCS learning progression and separates standards literacy from programme execution.  
**Chapters: 22** — Sufficient for depth without redundancy; each chapter maps to one accountable deliverable in a migration programme.  
**Estimated length: 420–480 pages** — Reference handbook scale; 18–22 pages per chapter average with figures/tables.  
**Appendices: 5** — Artefact templates, not manuscript padding.

## 5.2 Book Structure Overview

| Part | Title | Chapters | Purpose |
|---|---|---|---|
| I | **The Migration Imperative** | 1–3 | Establish threat, regulatory, and organizational framing |
| II | **Standards as Inputs** | 4–6 | Translate NIST FIPS and transition guidance for architects |
| III | **Knowing Your Cryptographic Estate** | 7–9 | Inventory, classification, dependency analysis |
| IV | **Architecting for Transition** | 10–14 | Agility, hybrids, protocols, PKI, keys, cloud |
| V | **Running the Migration Programme** | 15–18 | Governance, procurement, supply chain, validation |
| VI | **Sector Playbooks and Proof** | 19–22 | Industry patterns, compliance, cases, future-proofing |

## 5.3 Appendices

- **A:** CBOM and CDG templates (CycloneDX-aligned)
- **B:** PQ-ADAPT self-assessment questionnaire
- **C:** Regulatory mapping matrix (DORA, NIS2, GDPR, PCI, US federal)
- **D:** Migration programme charter template
- **E:** Glossary and standards quick-reference tables

## 5.4 Pedagogical Devices (Used Throughout)

- **Migration Moment** — Short boxed interruptions highlighting common executive misconceptions
- **Dependency Alert** — CDG-derived warnings about blocking relationships
- **Regulatory Lens** — Sidebars mapping chapter content to DORA/NIS2/GDPR evidence
- **Architect's Decision** — Structured decision trees with recommended defaults
- **Case Study Thread** — Four fictional organizations followed across Parts V–VI

## 5.5 Fictional Case Study Organizations

| Organization | Profile | Teaches |
|---|---|---|
| **Meridian Mutual Bank** | EU bank, 8,000 staff, DORA-regulated | CBOM under vendor dependency; HSM validation; payment HSM constraints |
| **Northfield Energy Systems** | US critical infrastructure, OT-heavy | OT certificate lifetimes; air-gapped signing; NERC CIP intersection |
| **Apex Defense Technologies** | US defense contractor, CMMC/FedRAMP | CNSA 2.0 alignment; classified/unclassified boundary patterns |
| **GlobalSync Logistics** | Multinational SaaS, 40-country footprint | Cloud-native agility; tenant isolation; GDPR cross-border evidence |

---

# 6. Chapter Blueprint

---

## PART I — THE MIGRATION IMPERATIVE

### Chapter 1: The Synchronization Problem
**Purpose:** Reframe PQC from algorithm news to enterprise transformation.  
**Reader outcome:** Can articulate to the board why migration is a decade-long programme.  
**Key argument:** PQC migration fails when treated as a security upgrade rather than an ecosystem synchronization exercise.  
**Supporting arguments:** Timeline research (5–15+ years); dependency chains; historical SHA-1/TLS transitions as inadequate analogies.  
**Evidence:** Campbell 2025; NIST IR 8547 NSM-10 alignment; WEF quantum security framing.  
**Case study:** Opening vignette — Meridian Bank discovers RSA-2048 in a payment HSM firmware chain.  
**Figures:** (1) PQC migration vs. prior crypto transitions comparison matrix; (2) Enterprise dependency iceberg.  
**Tables:** (1) Stakeholder map (CISO, EA, PKI, OT, Legal, Procurement).  
**Frameworks introduced:** ARCS overview; thesis statement.

---

### Chapter 2: Threat Models That Drive Priorities
**Purpose:** Replace quantum hype with decision-grade threat analysis.  
**Reader outcome:** Can classify data and systems by HNDL exposure and operational impact.  
**Key argument:** Not all quantum risk is equal; confidentiality lifetime drives urgency more than headline CRQC dates.  
**Supporting arguments:** HNDL model; authentication vs. confidentiality horizons; integrity and non-repudiation considerations.  
**Evidence:** NIST and NSA threat framing; ENISA long-term confidentiality guidance.  
**Case study:** Northfield Energy — 30-year SCADA archive vs. session-key TLS.  
**Figures:** (1) HNDL exposure timeline; (2) Threat-to-control mapping.  
**Tables:** (1) Data classification × algorithm vulnerability matrix.  
**Frameworks:** TRADE engine (Threat dimension).

---

### Chapter 3: The Regulatory and Policy Landscape
**Purpose:** Map global forcing functions to enterprise evidence requirements.  
**Reader outcome:** Can identify which regulations create PQC obligations in their jurisdiction.  
**Key argument:** Regulations require state-of-the-art cryptographic governance; PQC is how you demonstrate it.  
**Supporting arguments:** DORA RTS cryptographic policy requirements; NIS2 Article 21; GDPR Article 32; US NSM-10; PCI DSS 4.0 crypto documentation.  
**Evidence:** DORA RTS 2024/1532 text; ENISA NIS2 guidance; ASD/NCSC national timelines.  
**Case study:** Meridian Bank legal team interprets DORA "developments in cryptanalysis."  
**Figures:** (1) Global regulatory convergence map.  
**Tables:** (1) Regulatory mapping matrix (jurisdiction × obligation × evidence artefact).  
**Frameworks:** PQC Governance Stack (Strategic layer); Appendix C preview.

---

## PART II — STANDARDS AS INPUTS

### Chapter 4: From NIST Competition to FIPS 203–205
**Purpose:** Provide architects sufficient algorithm literacy without textbook depth.  
**Reader outcome:** Can explain why NIST selected ML-KEM, ML-DSA, and SLH-DSA and what remains in development.  
**Key argument:** Enterprises standardize on NIST's finalized suite; FN-DSA/HQC are contingency planning, not blocking dependencies.  
**Supporting arguments:** Algorithm family properties; security levels; signature size and performance trade-offs.  
**Evidence:** FIPS 203, 204, 205; NIST PQC project status (FN-DSA, HQC).  
**Case study:** Apex Defense evaluates CNSA 2.0 algorithm set against commercial product availability.  
**Figures:** (1) NIST PQC standards family tree; (2) Algorithm selection decision tree.  
**Tables:** (1) FIPS 203–205 parameter sets and use-case fit.  
**Frameworks:** Standards-as-inputs principle.

---

### Chapter 5: Transition Timelines and Hybrid Policy
**Purpose:** Translate NIST IR 8547 and CNSA 2.0 into enterprise planning horizons.  
**Reader outcome:** Can set internal deprecation/disallowance policies aligned with—but not blindly copying—NIST timelines.  
**Key argument:** 2030/2035 are policy anchors; internal timelines must reflect dependency analysis.  
**Supporting arguments:** Deprecation vs. disallowance; hybrid permissibility; exception documentation requirements.  
**Evidence:** NIST IR 8547; NSA CNSA 2.0 milestones; industry comments on IR 8547 flexibility.  
**Case study:** GlobalSync sets global policy with EU and US operating company variants.  
**Figures:** (1) Multi-jurisdiction timeline overlay.  
**Tables:** (1) NIST/CNSA/ASD/NCSC milestone comparison.  
**Frameworks:** Hybrid Lifecycle Model (HLM) introduction.

---

### Chapter 6: Stateful Signatures, Firmware, and Special Cases
**Purpose:** Address SP 800-208 (LMS/XMSS) and deployments FIPS 204/205 do not cleanly cover.  
**Reader outcome:** Can select stateful vs. stateless hash signatures for code signing and firmware.  
**Key argument:** Firmware and long-lived embedded systems require distinct signature strategies.  
**Supporting arguments:** Stateful key management risks; SLH-DSA performance; LMS/XMSS operational constraints.  
**Evidence:** SP 800-208; CNSA 2.0 firmware signing requirements.  
**Case study:** Northfield Energy firmware signing chain across three vendors.  
**Figures:** (1) Firmware signing architecture with PQC insertion points.  
**Tables:** (1) Signature scheme selection matrix (ML-DSA vs. SLH-DSA vs. LMS/XMSS).  
**Frameworks:** Sector Overlay (OT firmware).

---

## PART III — KNOWING YOUR CRYPTOGRAPHIC ESTATE

### Chapter 7: Cryptographic Discovery and the CBOM
**Purpose:** Teach authoritative inventory methodology.  
**Reader outcome:** Can commission a CBOM programme with defined scope, tooling, and maintenance cadence.  
**Key argument:** You cannot prioritize what you cannot see; CBOM is the system of record.  
**Supporting arguments:** Static vs. dynamic discovery; CycloneDX CBOM; limitations of network scanning alone.  
**Evidence:** CycloneDX Authoritative Guide to CBOM; NCCoE Migration to PQC project.  
**Case study:** Meridian Bank Phase 1 CBOM — 14,000 assets, 38% third-party obscured.  
**Figures:** (1) CBOM discovery architecture; (2) Inventory maturity progression.  
**Tables:** (1) Discovery method × asset type coverage matrix.  
**Frameworks:** PQ-ADAPT Level 2 criteria; Appendix A.

---

### Chapter 8: The Cryptographic Dependency Graph
**Purpose:** Move from inventory to dependency-aware planning.  
**Reader outcome:** Can construct a CDG and identify blocking nodes.  
**Key argument:** Migration sequence is determined by dependency topology, not asset criticality alone.  
**Supporting arguments:** PKI as hidden blocker; library transitive dependencies; partner API constraints.  
**Evidence:** CDG methodology (original); IBM CBOM dependency types.  
**Case study:** GlobalSync discovers a partner API as the root blocker for 200 microservices.  
**Figures:** (1) Sample CDG with blocking node highlighted; (2) PKI dependency explosion diagram.  
**Tables:** (1) Edge type definitions and discovery sources.  
**Frameworks:** CDG methodology (full specification).

---

### Chapter 9: Risk Tiering and Migration Wave Planning
**Purpose:** Convert inventory and dependencies into phased migration waves.  
**Reader outcome:** Can produce a board-approved migration wave plan with defensible prioritization.  
**Key argument:** Prioritization is multi-dimensional; single-score sorting fails.  
**Supporting arguments:** TRADE scoring; wave sizing; quick wins vs. structural blockers.  
**Evidence:** TRADE engine (original); NIST risk-based transition guidance.  
**Case study:** Apex Defense wave plan aligned to contract renewal cycles.  
**Figures:** (1) Migration wave Gantt with dependency gates.  
**Tables:** (1) TRADE scoring worksheet; (2) Wave definition template.  
**Frameworks:** TRADE engine (full); MPI calculation.

---

## PART IV — ARCHITECTING FOR TRANSITION

### Chapter 10: Cryptographic Agility as Architecture
**Purpose:** Define crypto-agility as implementable architecture requirements.  
**Reader outcome:** Can write crypto-agility non-functional requirements for new systems.  
**Key argument:** Agility is separation of policy from implementation—not optional for any system built today.  
**Supporting arguments:** Algorithm negotiation; configuration-driven selection; test harness requirements.  
**Evidence:** NIST crypto agility concepts; DORA agility expectations.  
**Case study:** GlobalSync agility requirements in platform engineering standards.  
**Figures:** (1) Agility reference architecture; (2) Anti-pattern: hardcoded algorithm constants.  
**Tables:** (1) Agility requirements checklist by system class.  
**Frameworks:** PQ-ADAPT Level 3 criteria.

---

### Chapter 11: Hybrid Deployment Patterns
**Purpose:** Provide production-ready hybrid patterns with sunset criteria.  
**Reader outcome:** Can select and govern hybrid schemes for TLS, VPN, and application-layer crypto.  
**Key argument:** Hybrids are transitional states with defined exit criteria, not permanent architectures.  
**Supporting arguments:** TLS hybrid named groups; combiner security considerations; performance and bandwidth impact.  
**Evidence:** IETF hybrid TLS specifications; NIST IR 8547 hybrid guidance.  
**Case study:** Meridian Bank hybrid TLS pilot with measured client compatibility.  
**Figures:** (1) HLM phase transitions; (2) Hybrid TLS handshake sequence.  
**Tables:** (1) Hybrid pattern catalog (protocol × phase × sunset trigger).  
**Frameworks:** HLM (full specification).

---

### Chapter 12: Protocol Transition — TLS, IPsec, SSH, and Messaging
**Purpose:** Map protocol-by-protocol migration paths.  
**Reader outcome:** Can plan protocol upgrades without breaking partner connectivity.  
**Key argument:** Each protocol has distinct ecosystem readiness curves; synchronize to the slowest critical partner.  
**Supporting arguments:** Client compatibility; middlebox interference; email S/MIME and PKI implications.  
**Evidence:** OpenSSL 3.5+ PQC support; protocol-specific RFCs and deployment drafts.  
**Case study:** Northfield Energy IPsec migration blocked by vendor CPE firmware.  
**Figures:** (1) Protocol readiness radar chart; (2) Phased protocol rollout diagram.  
**Tables:** (1) Protocol × algorithm × readiness status matrix.

---

### Chapter 13: PKI Evolution and Certificate Lifecycle
**Purpose:** Address the most common enterprise blocking domain.  
**Reader outcome:** Can design a PQC-capable PKI architecture with CA hierarchy, certificate profiles, and validity policies.  
**Key argument:** PKI migration is on the critical path for most enterprises; deferring it defers everything else.  
**Supporting arguments:** ML-DSA certificate sizes; cross-certification; trust store update mechanics; ACME and automation.  
**Evidence:** CA/Browser Forum PQC discussions; major CA roadmaps (analyzed, not reproduced).  
**Case study:** Meridian Bank root CA strategy with 10-year overlap period.  
**Figures:** (1) PQC PKI hierarchy; (2) Certificate lifecycle state machine.  
**Tables:** (1) Certificate profile comparison (RSA vs. ML-DSA).

---

### Chapter 14: Key Management, HSMs, and Cloud Cryptography
**Purpose:** Cover key lifecycle, HSM partitioning, and cloud KMS PQC paths.  
**Reader outcome:** Can evaluate HSM/KMS readiness and design key ceremony adaptations for larger PQC keys.  
**Key argument:** Key management infrastructure must migrate before or in parallel with consuming applications.  
**Supporting arguments:** Key size and performance impacts; FIPS 140-3 validation; multi-cloud key custody; confidential computing intersections.  
**Evidence:** FIPS 140-3; cloud provider PQC roadmaps; CNSA 2.0 key establishment requirements.  
**Case study:** Apex Defense HSM partition strategy for classified and unclassified zones.  
**Figures:** (1) KMS migration architecture; (2) Key ceremony adaptation diagram.  
**Tables:** (1) HSM/KMS capability assessment matrix.

---

## PART V — RUNNING THE MIGRATION PROGRAMME

### Chapter 15: Programme Governance and Operating Model
**Purpose:** Establish the migration authority, charter, and operating rhythm.  
**Reader outcome:** Can stand up a PQC programme office with defined RACI, funding, and reporting.  
**Key argument:** Without a migration authority, pilots become permanent exceptions.  
**Supporting arguments:** Steering committee composition; KPI design; board reporting; relationship to existing risk management.  
**Evidence:** PQC Governance Stack (original); enterprise transformation precedents.  
**Case study:** GlobalSync programme office structure across three regions.  
**Figures:** (1) PQC Governance Stack diagram; (2) Programme operating rhythm calendar.  
**Tables:** (1) RACI matrix; (2) KPI dashboard template.  
**Frameworks:** PQC Governance Stack (full); Appendix D.

---

### Chapter 16: Procurement, Contracts, and Third-Party Risk
**Purpose:** Encode PQC requirements in commercial relationships.  
**Reader outcome:** Can draft PQC contractual clauses and assess vendor readiness with evidence requirements.  
**Key argument:** Third-party cryptography is your cryptography; contracts are enforcement mechanisms.  
**Supporting arguments:** CBOM supplier requirements; SLA and roadmap audit rights; DORA third-party ICT risk.  
**Evidence:** DORA Articles 28–30; CBOM in supply chain guidance.  
**Case study:** Meridian Bank vendor assessment of 40 critical suppliers.  
**Figures:** (1) Vendor readiness assessment flow.  
**Tables:** (1) Contract clause library; (2) Vendor evidence request checklist.

---

### Chapter 17: Software Supply Chain and Embedded Cryptography
**Purpose:** Integrate PQC migration with SBOM/CBOM and CI/CD pipelines.  
**Reader outcome:** Can require and verify PQC readiness in build pipelines and embedded dependencies.  
**Key argument:** Most enterprise cryptography lives in dependencies, not application code.  
**Supporting arguments:** CycloneDX integration; static analysis limits; firmware bill of materials.  
**Evidence:** CycloneDX; NIST SSDF alignment.  
**Case study:** GlobalSync CI/CD gate rejecting non-agile crypto libraries.  
**Figures:** (1) CI/CD cryptographic verification pipeline.  
**Tables:** (1) Build-time vs. runtime verification methods.

---

### Chapter 18: FIPS Validation, Testing, and Assurance
**Purpose:** Define the assurance programme for regulated and high-assurance environments.  
**Reader outcome:** Can plan FIPS 140-3 module transitions and independent security assessments.  
**Key argument:** Validation is a programme constraint, not a post-deployment checkbox.  
**Supporting arguments:** Module vs. algorithm validation; interoperability testing; red team considerations.  
**Evidence:** FIPS 140-3; CMMC and FedRAMP crypto requirements.  
**Case study:** Apex Defense CMMC assessment evidence package.  
**Figures:** (1) Validation dependency timeline.  
**Tables:** (1) Test category matrix (functional, interoperability, performance, security).

---

## PART VI — SECTOR PLAYBOOKS AND PROOF

### Chapter 19: Financial Services Playbook
**Purpose:** Sector-specific migration patterns for banking and payments.  
**Reader outcome:** Can execute a DORA-aligned PQC programme in a financial institution.  
**Key argument:** Payment system constraints and HSM certification cycles dominate financial timelines.  
**Supporting arguments:** PCI DSS 4.0; SWIFT and market infrastructure dependencies; EBA oversight expectations.  
**Evidence:** DORA RTS; Cryptomathic/EBA-adjacent guidance.  
**Case study:** Meridian Bank — full programme arc (initial conditions through Year 2 results).  
**Figures:** (1) Banking PQC architecture reference.  
**Tables:** (1) Sector Overlay — Financial Services.  
**Frameworks:** SOM financial overlay.

---

### Chapter 20: Defense, Government, and Critical Infrastructure
**Purpose:** Sector patterns for NSS, defense industrial base, and OT-heavy operators.  
**Reader outcome:** Can align commercial and government requirements without duplicating programmes.  
**Key argument:** CNSA 2.0 sets the floor for defense; critical infrastructure adds OT continuity constraints.  
**Supporting arguments:** FedRAMP; NERC CIP; air-gap signing; long certificate lifetimes in OT.  
**Evidence:** CNSA 2.0; NIST 800-53 crypto controls.  
**Case study:** Apex Defense + Northfield Energy parallel threads.  
**Figures:** (1) Classified/unclassified crypto boundary; (2) OT/IT convergence diagram.  
**Tables:** (1) Sector Overlay — Defense/Government/CII.

---

### Chapter 21: Cloud, SaaS, and Multinational Compliance
**Purpose:** Address cloud-native architectures and cross-border evidence.  
**Reader outcome:** Can design tenant-isolated PQC architectures with GDPR-compliant evidence.  
**Key argument:** Cloud centralization is an agility opportunity and a regulatory concentration risk.  
**Supporting arguments:** Shared responsibility model; tenant key custody; cross-border data residency.  
**Evidence:** GDPR Article 32; cloud provider shared responsibility documentation.  
**Case study:** GlobalSync — full programme arc with EU/US split.  
**Figures:** (1) Multi-tenant PQC architecture.  
**Tables:** (1) Cloud provider capability comparison framework (vendor-neutral).

---

### Chapter 22: Sustaining Quantum Resilience
**Purpose:** Close the book with continuous improvement, standards watch, and organizational learning.  
**Reader outcome:** Can maintain PQ-ADAPT Level 5 operations and prepare for algorithm transitions beyond the first NIST suite.  
**Key argument:** Migration ends in capability, not in a single deployment.  
**Supporting arguments:** FN-DSA/HQC contingency; CRQC timeline updates; organizational learning loops.  
**Evidence:** NIST ongoing PQC project; lessons from case study organizations.  
**Case study:** All four organizations — Year 3 retrospective and lessons learned.  
**Figures:** (1) Continuous quantum resilience loop; (2) PQ-ADAPT full maturity model poster.  
**Tables:** (1) Standards watch calendar; (2) Lessons learned synthesis across cases.  
**Frameworks:** PQ-ADAPT Levels 4–5; ARCS synthesis.

---

# 7. Manuscript Development Notes (For Editorial Review)

## 7.1 Quality Gate Checklist (Per Chapter)

- [ ] Would a senior enterprise architect learn something new?
- [ ] Would a regulator find it credible?
- [ ] Would a CISO trust the recommendations?
- [ ] Would a technical reviewer approve the analysis?
- [ ] Would a publisher consider the chapter distinctive?

## 7.2 Deliberate Exclusions (Scope Control)

- No lattice reduction algorithm tutorials
- No reproduction of FIPS text
- No vendor product comparisons or endorsements
- No quantum computing hardware forecasts beyond decision-relevant horizons
- No QKD as primary solution (brief positioning only where enterprise asks)

## 7.3 Approval Gate

**Manuscript drafting begins only after editorial approval of:**

1. Book positioning (Section 1)
2. Competitive differentiation (Section 2)
3. Core thesis (Section 3)
4. Intellectual frameworks (Section 4)
5. Part/chapter structure (Sections 5–6)

---

*End of Book Architecture Package v1.0*
