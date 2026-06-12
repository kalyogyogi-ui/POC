# Book Proposal — Taylor & Francis / CRC Press

**Submitted to:** Chapman & Hall / CRC Press — Cryptography and Network Security Series (proposed)  
**Date:** June 2026  
**Proposal contact:** Nagnath Savant · nagnathsavant@gmail.com · +91 9822548376 · Pune, Maharashtra, India

---

## 1. Author

**Name:** Nagnath Savant  
**Affiliation:** Independent researcher and technical author; former Assistant Professor, Electronics and Telecommunication Engineering, KPC Pandharpur (2017–2023)  
**Email:** nagnathsavant@gmail.com  
**ORCID / LinkedIn:** LinkedIn: Nagnath Savant

### About the author

I have worked at the intersection of cryptographic systems, distributed computing, and security engineering since 2016 — first in university teaching and embedded systems research, and since 2017 as an independent researcher and author focused on blockchain architecture and post-quantum cryptography.

My earlier work on microcontroller-based systems and IoT gave me a practical view of long-lived embedded assets, firmware trust chains, and operational constraints that textbook cryptography often treats briefly. That background informs how this book addresses OT, payment HSM, and firmware signing — domains where migration timelines are measured in years, not sprints.

I have published peer-reviewed journal articles (IJSART, IRJET, 2016), authored *The Post-Quantum Cryptocurrency Revolution* (2025, 87,606 words) on quantum threats to digital-asset cryptography and NIST PQC standards, and have books under contract or active development with Oxford University Press and Apress on blockchain and cryptographic foundations. My research programme since 2020 has concentrated on migration pathways from classical to post-quantum algorithms in production systems — not lattice mathematics for its own sake, but the engineering and governance problems enterprises encounter after FIPS 203–205.

I am an active participant in the practitioner discourse around NIST PQC standardisation, harvest-now-decrypt-later risk, and enterprise inventory methods. I am not a member of a vendor product team; the manuscript is vendor-neutral by design.

**Co-authors:** None. Single-authored manuscript.

**Availability:** I am available to complete copy-editing revisions, respond to peer review, support production (figures, permissions, index), and participate in marketing as required. A complete draft exists; I can deliver camera-ready manuscript within an agreed schedule after contract (see Section 8).

**CV:** Enclosed separately (Nagnath Savant, June 2026).

---

## 2. Proposed title

**Primary title:**  
*Post-Quantum Cryptography: Enterprise Migration Handbook*

**Subtitle (optional):**  
*Governance, Inventory, Architecture, and Sector Playbooks for Organisational Transition*

**Series placement (proposed):**  
Chapman & Hall/CRC Cryptography and Network Security — as a **practitioner companion** to algorithm-focused texts (including Douglas Stinson’s forthcoming *Primer on Post-Quantum Cryptography*, CRC, 2026).

---

## 3. Book description (approx. 750 words)

When NIST published FIPS 203, 204, and 205 in August 2024, enterprise security teams received an answer to a fifteen-year question: which algorithms. They did not receive an answer to the questions that determine whether migration succeeds — where vulnerable cryptography is deployed, what breaks when it is changed, who else must change first, and how regulators and auditors are shown defensible progress.

This handbook addresses that gap. It is written for security leaders, enterprise architects, cryptographic engineers, and compliance officers who must run a migration programme across IT, OT, cloud, and third-party estates — typically over five to fifteen years, as independent timeline analysis and industry experience now recognise (Campbell, *Computers*, 2025; USENIX Security deployment considerations, 2024).

The book’s central argument is direct: **post-quantum cryptographic migration is not a cryptographic upgrade. It is an enterprise synchronisation problem.** Success depends on dependency topology, cross-functional governance, and ecosystem alignment — not on selecting ML-KEM in isolation.

The manuscript is organised in six parts and twenty-two chapters, supported by five appendices of templates and reference material (~200,000 words complete draft).

**Part I — The Migration Imperative** frames threat, regulatory forcing functions, and programme structure. It introduces the ARCS framework (Awareness, Register, Capability, Synchronize) and the thesis that pilots without governance produce activity metrics, not migrated estates.

**Part II — Standards as Inputs** treats FIPS 203–205, NIST IR 8547 timelines, CNSA 2.0, and SP 800-208 stateful signatures as **inputs to programme decisions** — sufficient algorithm literacy for architects without reproducing FIPS documents or teaching lattice reduction.

**Part III — Knowing Your Cryptographic Estate** develops Cryptographic Bill of Materials (CBOM) methodology aligned to CycloneDX, the Cryptographic Dependency Graph (CDG) for blocking-node analysis, and the TRADE decision engine (Threat, Regulatory, Architectural dependency, Data longevity, Ecosystem readiness) for migration wave planning.

**Part IV — Architecting for Transition** specifies cryptographic agility requirements, Hybrid Lifecycle Model (HLM) deployment patterns, protocol transition playbooks (TLS, IPsec, SSH, messaging), PKI evolution, and HSM/KMS/cloud key management under FIPS 140-3 constraints.

**Part V — Running the Migration Programme** covers programme governance, procurement and contract enforcement, software supply chain and CI/CD gates, and FIPS validation and assurance evidence — the organisational machinery that prevents architecture standards from remaining slide decks.

**Part VI — Sector Playbooks and Proof** applies the universal model to financial services (DORA examination evidence), defence and critical infrastructure (CNSA 2.0, CMMC, NERC CIP), and multinational SaaS (GDPR cross-border evidence), closing with sustained quantum resilience at PQ-ADAPT Level 5.

Four fictional teaching organisations — a EU bank, a US defence contractor, a critical infrastructure operator, and a multinational SaaS provider — carry consistent case threads across sector chapters. Metrics and examination scenarios are illustrative; the regulatory and standards references are not.

**What this book is not:** an algorithm textbook, a NIST republication, or a vendor readiness brochure. **What it is:** a programme reference that connects standards to inventory, dependency analysis, hybrid deployment with sunset criteria, and audit-ready artefacts.

The timing is constrained by regulation and standards, not by marketing urgency. DORA is in force for EU financial entities. NIS2 expects state-of-the-art measures. NSA CNSA 2.0 imposes milestones on National Security Systems. NIST IR 8547 establishes deprecation and disallowance anchors for quantum-vulnerable public-key algorithms. Enterprises that treat PQC as a TLS upgrade or a single HSM refresh will discover blocking dependencies — often in PKI, firmware signing, or partner mTLS — that no algorithm choice resolves retroactively.

I wrote this book because my work on post-quantum migration pathways kept returning to the same organisational failure modes: algorithm-first planning, TLS myopia, vendor roadmap substitution, compliance theatre, and perpetual pilot. The manuscript names those patterns and replaces them with structures I have tested against published deployment research and regulatory text — not against product roadmaps.

---

## 4. Keywords

post-quantum cryptography; PQC migration; enterprise cryptography; FIPS 203; ML-KEM; ML-DSA; cryptographic inventory; CBOM; CycloneDX; cryptographic dependency graph; hybrid TLS; PKI migration; HSM; FIPS 140-3; NIST IR 8547; CNSA 2.0; DORA; NIS2; quantum risk; harvest now decrypt later; crypto agility; programme governance; critical infrastructure; OT security

---

## 5. Table of contents

### Front matter
- Preface  
- Conventions and How to Use This Book  
- Framework Quick Reference (ARCS · PQ-ADAPT · TRADE · HLM · CDG · CBOM)

### Part I — The Migration Imperative
- Introduction  
- **Chapter 1** The Synchronization Problem  
- **Chapter 2** Threat Models That Drive Priorities  
- **Chapter 3** The Regulatory and Policy Landscape  

### Part II — Standards as Inputs
- Introduction  
- **Chapter 4** From NIST Competition to FIPS 203–205  
- **Chapter 5** Transition Timelines and Hybrid Policy  
- **Chapter 6** Stateful Signatures, Firmware, and Special Cases  

### Part III — Knowing Your Cryptographic Estate
- Introduction  
- **Chapter 7** Cryptographic Discovery and the CBOM  
- **Chapter 8** The Cryptographic Dependency Graph  
- **Chapter 9** Risk Tiering and Migration Wave Planning  

### Part IV — Architecting for Transition
- Introduction  
- **Chapter 10** Cryptographic Agility as Architecture  
- **Chapter 11** Hybrid Deployment Patterns  
- **Chapter 12** Protocol Transition — TLS, IPsec, SSH, and Messaging  
- **Chapter 13** PKI Evolution and Certificate Lifecycle  
- **Chapter 14** Key Management, HSMs, and Cloud Cryptography  

### Part V — Running the Migration Programme
- Introduction  
- **Chapter 15** Programme Governance and Operating Model  
- **Chapter 16** Procurement, Contracts, and Third-Party Risk  
- **Chapter 17** Software Supply Chain and Embedded Cryptography  
- **Chapter 18** FIPS Validation, Testing, and Assurance  

### Part VI — Sector Playbooks and Proof
- Introduction  
- **Chapter 19** Financial Services Playbook  
- **Chapter 20** Defense, Government, and Critical Infrastructure  
- **Chapter 21** Cloud, SaaS, and Multinational Compliance  
- **Chapter 22** Sustaining Quantum Resilience  

### Appendices
- **Appendix A** CBOM and CDG Templates  
- **Appendix B** PQ-ADAPT Self-Assessment Questionnaire  
- **Appendix C** Regulatory Mapping Matrix  
- **Appendix D** Migration Programme Charter Template  
- **Appendix E** Glossary and Standards Quick Reference  

### Back matter
- References  
- Index (author to compile, or publisher-produced per agreement)

---

## 6. Chapter abstracts and keywords

### Part I

**Introduction** — Scope, reader paths, teaching organisations, and conventions. Keywords: *programme design, reader map, ARCS overview*.

**Chapter 1 — The Synchronization Problem**  
Establishes the book’s thesis against the August 2024 FIPS finalisation. Contrasts PQC migration with SHA-1 and TLS transitions; introduces enterprise dependency chains, programme-versus-project governance, board communication, and the ARCS framework. Keywords: *synchronisation, FIPS 203, enterprise programme, ARCS*.

**Chapter 2 — Threat Models That Drive Priorities**  
Separates CRQC arrival, harvest-now-decrypt-later, and classical cryptanalysis as decision inputs. Develops confidentiality and authentication horizons, the TRADE Threat dimension, sector calibration, and worked MPI examples. Keywords: *HNDL, threat modelling, TRADE, data longevity*.

**Chapter 3 — The Regulatory and Policy Landscape**  
Maps US federal (NSM-10, IR 8547, CNSA 2.0, FedRAMP, CMMC), EU (DORA, NIS2, GDPR), PCI, and allied frameworks to evidence requirements. Introduces the PQC Governance Stack and regulatory overlay design. Keywords: *DORA, NIS2, compliance evidence, governance stack*.

### Part II

**Introduction** — Standards-as-inputs principle and PQ-ADAPT policy artefacts. Keywords: *standards literacy, hybrid policy*.

**Chapter 4 — From NIST Competition to FIPS 203–205**  
Algorithm literacy for architects: ML-KEM, ML-DSA, SLH-DSA, parameter selection, FIPS 140-3 validation gap, vendor claim evaluation. Explicit scope boundary — not a maths text. Keywords: *FIPS 204, FIPS 205, algorithm selection, CMVP*.

**Chapter 5 — Transition Timelines and Hybrid Policy**  
Translates IR 8547 and CNSA milestones into enterprise timelines. Defines the Hybrid Lifecycle Model (H1–H3), sunset criteria, exceptions, and board reporting. Keywords: *HLM, deprecation, hybrid policy, IR 8547*.

**Chapter 6 — Stateful Signatures, Firmware, and Special Cases**  
SP 800-208, LMS/XMSS operational design, firmware and OT signing chains, air-gapped workflows, payment HSM constraints. Keywords: *SP 800-208, firmware signing, OT, code signing*.

### Part III

**Introduction** — Register phase exit artefacts and CDG preview. Keywords: *inventory, CBOM, PQ-ADAPT Level 2*.

**Chapter 7 — Cryptographic Discovery and the CBOM**  
CycloneDX-aligned CBOM schema, discovery methods, third-party obscurity, OT extensions, DORA supervisory evidence. Keywords: *CBOM, CycloneDX, discovery, inventory*.

**Chapter 8 — The Cryptographic Dependency Graph**  
CDG node/edge model, blocking nodes, PKI roll-up, partner and firmware chains, TRADE integration. Keywords: *dependency graph, blocking node, fan-in*.

**Chapter 9 — Risk Tiering and Migration Wave Planning**  
Full TRADE specification, MPI weighting, wave taxonomy, sequencing rules, board approval package, sector overlay preview. Keywords: *TRADE, MPI, wave planning, prioritisation*.

### Part IV

**Introduction** — Agility and hybrid deployment prerequisites. Keywords: *PQ-ADAPT Level 3, architecture patterns*.

**Chapter 10 — Cryptographic Agility as Architecture**  
Agility NFRs, provider abstraction, SDLC gates, test harness design, DORA change-management evidence. Keywords: *crypto agility, SDLC, NFR*.

**Chapter 11 — Hybrid Deployment Patterns**  
HLM deployment specification for hybrid TLS, IKE, dual code signing; performance and middlebox constraints; CBOM tracking. Keywords: *hybrid TLS, X25519MLKEM768, H1 exit criteria*.

**Chapter 12 — Protocol Transition**  
TLS cohort analysis, IPsec/SSH/messaging migration methodology, partner synchronisation, observability metrics. Keywords: *TLS 1.3, IPsec, protocol migration*.

**Chapter 13 — PKI Evolution and Certificate Lifecycle**  
PQC PKI hierarchy, root overlap, ML-DSA certificate sizes, ACME automation, trust store mechanics. Keywords: *PKI, ML-DSA, certificate lifecycle*.

**Chapter 14 — Key Management, HSMs, and Cloud Cryptography**  
KMS patterns, HSM partitioning, FIPS 140-3 selection, multi-cloud BYOK/HYOK, ceremony governance. Keywords: *HSM, KMS, FIPS 140-3, key ceremony*.

### Part V

**Introduction** — Synchronize phase and PQ-ADAPT Level 4 entry. Keywords: *programme office, governance stack*.

**Chapter 15 — Programme Governance and Operating Model**  
Charter content, RACI, steering committee design, KPI dashboards, funding models, operating rhythm. Keywords: *governance, RACI, steering committee*.

**Chapter 16 — Procurement, Contracts, and Third-Party Risk**  
DORA Articles 28–30, contract clause library, vendor assessment, concentration risk. Keywords: *procurement, third-party risk, DORA ICT*.

**Chapter 17 — Software Supply Chain and Embedded Cryptography**  
SBOM/CBOM CI/CD gates, SSDF alignment, firmware BOM, classified build pipeline considerations. Keywords: *supply chain, CI/CD, SBOM*.

**Chapter 18 — FIPS Validation, Testing, and Assurance**  
Validation coverage matrix, test categories, CMMC/FedRAMP/DORA evidence packages. Keywords: *FIPS validation, assurance, CMMC*.

### Part VI

**Introduction** — Sector Overlay Matrix (SOM) and four-organisation arcs. Keywords: *sector overlay, proof phase*.

**Chapter 19 — Financial Services Playbook**  
DORA-aligned architecture, payment HSM certification cycles, PCI, SWIFT dependencies, examination evidence pack structure. Keywords: *DORA, banking, payment HSM, examination*.

**Chapter 20 — Defense, Government, and Critical Infrastructure**  
CNSA 2.0 floors, CMMC, classified boundaries, NERC CIP, OT continuity, air-gapped signing. Keywords: *CNSA 2.0, NERC CIP, OT, NSS*.

**Chapter 21 — Cloud, SaaS, and Multinational Compliance**  
Multi-tenant architecture, shared responsibility, GDPR cross-border evidence, tenant assurance packs. Keywords: *SaaS, multi-tenant, GDPR, BYOK*.

**Chapter 22 — Sustaining Quantum Resilience**  
PQ-ADAPT Levels 4–5, continuous resilience loop, standards watch, FN-DSA/HQC contingency, four-organisation retrospective. Keywords: *sustained migration, maturity model, standards horizon*.

### Appendices A–E

Template and reference material: CBOM/CDG schemas, PQ-ADAPT questionnaire, regulatory matrix, programme charter, glossary. Keywords: *templates, self-assessment, artefact library*.

---

## 7. Length, schedule, and manuscript status

| Item | Detail |
|------|--------|
| **Current manuscript status** | **Complete draft** — 22 chapters, 6 part introductions, 5 appendices; editorial review complete (June 2026) |
| **Word count (body + appendices)** | ~199,800 words (references and front matter additional) |
| **Estimated printed length** | 420–480 pages (reference handbook format, tables and figures) |
| **Figures** | ~18–22 proposed (dependency iceberg, ARCS, TRADE worksheet, HLM phases, wave Gantt, governance stack, sector overlays); production briefs in manuscript — author to deliver final artwork per publisher spec |
| **Tables** | Extensive (worksheets, matrices, RACI, contract clauses) — integral to text |
| **Equations** | Minimal (MPI formula, weighting expressions); no advanced mathematical notation |
| **LaTeX** | Not required; manuscript composed in Markdown, convertible to Word |
| **Previously published material** | None in this manuscript. Author’s 2025 self-published work on cryptocurrency and PQC addresses a different scope (digital assets); overlap is thematic only, not textual |
| **Proposed delivery after contract** | Final manuscript + figures within **90 days** of signed agreement, subject to copy-edit revision cycle |
| **Open Access** | Not requested; standard royalty model preferred |

---

## 8. Market breadth and international appeal

### Primary audience
- Chief Information Security Officers and security programme directors  
- Enterprise and security architects  
- Cryptographic engineering leads and PKI/HSM teams  
- Compliance and regulatory affairs officers (financial services, critical infrastructure)  
- Government and defence security teams (NSS, CMMC, FedRAMP environments)

### Secondary audience
- Procurement and vendor risk managers  
- Cloud platform and DevSecOps engineers  
- Internal audit and risk management  
- Graduate professional programmes in information security management (reference, not introductory textbook)

### Geographic appeal
- **United States:** CNSA 2.0, CMMC, FedRAMP, NERC CIP, executive orders — Chapters 3, 6, 15, 18, 20  
- **European Union / UK:** DORA, NIS2, GDPR, EBA supervisory expectations — Chapters 3, 7, 16, 19  
- **Multinational enterprises:** Cross-border SaaS, tenant evidence — Chapter 21  
- **Middle East / APAC / India:** Same English reference; regulatory overlays adaptable via Appendix C matrix

### Courses and professional bodies
Suitable as reference reading for:
- (ISC)² CISSP continuing education and CCSP  
- ISACA CISM/CISA professional development  
- SANS governance and architecture curricula (supplemental)  
- University postgraduate modules in information security management and cryptographic engineering (practitioner track, not undergraduate maths)

### Evidence of demand
- NIST FIPS 203–205 finalisation (August 2024) ended algorithm uncertainty; procurement and policy cycles are active  
- DORA effective January 2025 for EU financial entities  
- Campbell (*Computers*, 2025): enterprise migration timelines 5–15+ years — validates programme-scale framing  
- Industry migration playbooks (e.g. large-platform operator publications, 2026) confirm inventory-first methodology; no book-length enterprise programme reference exists at this depth  
- Gap alongside Stinson’s forthcoming CRC *Primer on Post-Quantum Cryptography* (2026, ~304 pp, graduate algorithm focus)

---

## 9. Competing and related titles

| Title | Publisher / type | Strengths | Gap this book fills |
|-------|------------------|-----------|---------------------|
| *A Primer on Post-Quantum Cryptography* (Stinson, forthcoming 2026) | CRC Press | Algorithm introduction for graduate students | No enterprise programme, CBOM, governance, or sector playbooks |
| *Post-Quantum Cryptography* (Bernstein et al., 2009) | Springer | Foundational maths | Pre-FIPS 203–205; no migration methodology |
| NIST FIPS 203/204/205; IR 8547 | NIST | Normative standards | Not organisational migration design |
| NIST CSWP / CISA PQC materials | Government | Awareness, inventory starting points | Not cohesive handbook; limited EU sector depth |
| Campbell, enterprise timeline analysis (2025) | *Computers* / MDPI | Timeline evidence | Academic paper; no operational playbooks |
| Vendor whitepapers (IBM, Entrust, etc.) | Commercial | Product-adjacent roadmaps | Fragmented; commercial bias |
| *The Post-Quantum Cryptocurrency Revolution* (Savant, 2025) | Self-published | Digital-asset PQC threat survey | Different scope — not enterprise IT/OT estate migration |

**Positioning statement:** Stinson teaches *which algorithms*. This handbook teaches *how an organisation survives the decade required to deploy them* — with inventory, dependency graphs, hybrid sunset logic, procurement enforcement, and regulatory evidence.

---

## 10. Sample material available

Upon request:
- **Chapter 1** (complete) — thesis and programme framing  
- **Chapter 9** (complete) — TRADE engine and wave planning  
- **Chapter 19** (complete) — financial services / DORA examination narrative  
- **Appendix D** — programme charter template  
- Full table of contents (684 sections)

Sample chapters selected to show narrative opening, framework specification, and sector proof respectively.

---

## 11. Third-party material and permissions

- Standards citations: fair use / factual reference to NIST, EU regulations, PCI SSC (no extensive reproduction)  
- CycloneDX schema references: OWASP Foundation specifications (attribution per licence)  
- No reproduced figures from third-party sources without permission  
- Fictional case studies: original to manuscript; no real organisation identification  
- Author will secure all permissions prior to final submission per publisher guidelines

---

## 12. Suggested independent reviewers

(Without close connection to author; subject to editor discretion)

| Suggested profile | Rationale |
|-------------------|-----------|
| Enterprise security architect with PKI/HSM programme experience | Validate Part III–IV technical architecture |
| EU financial sector ICT risk / DORA practitioner | Validate Chapter 19 regulatory mapping |
| US federal or defence cryptographic engineering lead (unclassified) | Validate Chapters 6, 20 CNSA/CMMC treatment |
| Cryptographic inventory / CBOM practitioner (industry or research) | Validate Chapters 7–8 methodology |
| Academic researcher in PQC deployment (not author of competing book) | Validate standards translation Chapters 4–5 |

I decline to nominate individuals with whom I have co-authored or commercial relationships.

---

## 13. Funding and Open Access

No external grant funding is attached to this proposal. Open Access publication charges are not requested. Standard CRC/Chapman & Hall royalty contract preferred.

---

## 14. Author statement

I confirm that this manuscript is original work, has not been published elsewhere, and is not under simultaneous consideration with another publisher. I am prepared to revise the manuscript in response to peer review and to deliver production-ready material in accordance with Taylor & Francis author guidelines.

---

**Nagnath Savant**  
Pune, Maharashtra, India  
nagnathsavant@gmail.com · +91 9822548376  
June 2026
