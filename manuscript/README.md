# Manuscript: Post-Quantum Cryptography — Enterprise Migration Handbook

**Status:** Appendices A–E draft complete (June 2026); full manuscript Chapters 1–22 + appendices  
**Architecture approved:** June 2026

## Structure

| Part | Directory | Chapters | Status |
|------|-----------|----------|--------|
| I — The Migration Imperative | `part-01-imperative/` | Intro + 1–3 | Editorial revision complete |
| II — Standards as Inputs | `part-02-standards/` | Intro + 4–6 | Editorial revision complete |
| III — Knowing Your Cryptographic Estate | `part-03-estate/` | Intro + 7–9 | Draft complete |
| IV — Architecting for Transition | `part-04-architecture/` | Intro + 10–14 | Draft complete |
| V — Running the Migration Programme | `part-05-programme/` | Intro + 15–18 | Draft complete |
| VI — Sector Playbooks and Proof | `part-06-sector/` | Intro + 19–22 | Draft complete |
| Appendices | `appendices/` | A–E | Draft complete |

## Part I Files

| File | ~Words | Notes |
|------|--------|-------|
| `part-01-introduction.md` | 864 | Scope, reading paths, teaching organisations, conventions |
| `chapter-01-synchronization-problem.md` | 7,812 | Thesis, ARCS Awareness, programme vs project |
| `chapter-02-threat-models.md` | 7,393 | TRADE Threat dimension, MPI formula, Figure 2.2 |
| `chapter-03-regulatory-landscape.md` | 7,683 | Governance Stack, Figure 3.2, regulatory overlay |

**Part I total (chapters + intro):** ~24,470 words

## Part II Files

| File | ~Words | Notes |
|------|--------|-------|
| `part-02-introduction.md` | 1,229 | Standards-as-inputs, PQ-ADAPT L3, reading sequences |
| `chapter-04-nist-competition-to-fips.md` | 7,937 | FIPS 203–205, key wrapping, agility, standards horizon |
| `chapter-05-transition-timelines-hybrid-policy.md` | 7,999 | IR 8547, HLM, five-year phases, auditor engagement |
| `chapter-06-stateful-signatures-firmware.md` | 7,958 | SP 800-208, trust horizons, IR playbooks, training |

**Part II total (chapters + intro):** ~24,123 words (chapter depth matches Part I)

## Part III Files

| File | ~Words | Notes |
|------|--------|-------|
| `part-03-introduction.md` | 871 | Register phase, exit artefacts, teaching orgs |
| `chapter-07-cryptographic-discovery-cbom.md` | 7,948 | CBOM, discovery methods, PQ-ADAPT L2, case studies |
| `chapter-08-cryptographic-dependency-graph.md` | 7,795 | CDG spec, blocking nodes, PKI roll-up |
| `chapter-09-risk-tiering-wave-planning.md` | 7,924 | Full TRADE engine, MPI, wave planning, board package |

**Part III total (chapters + intro):** ~23,405 words

## Part IV Files

| File | ~Words | Notes |
|------|--------|-------|
| `part-04-introduction.md` | 1,297 | Decide/Execute phase, PQ-ADAPT L3, reading sequences |
| `chapter-10-cryptographic-agility.md` | 7,919 | Agility NFRs, SDLC gates, maturity model |
| `chapter-11-hybrid-deployment-patterns.md` | 7,948 | Full HLM deployment, hybrid TLS/VPN/signing |
| `chapter-12-protocol-transition.md` | 8,428 | TLS, IPsec, SSH, messaging protocol playbooks |
| `chapter-13-pki-evolution-certificate-lifecycle.md` | 7,834 | PQC PKI hierarchy, Meridian root overlap |
| `chapter-14-key-management-hsm-cloud.md` | 7,889 | HSM/KMS, ceremonies, multi-cloud custody |

**Part IV total (chapters + intro):** ~41,315 words

## Part V Files

| File | ~Words | Notes |
|------|--------|-------|
| `part-05-introduction.md` | 1,184 | Synchronize phase, PQ-ADAPT L4, Governance Stack operating model |
| `chapter-15-programme-governance-operating-model.md` | 8,114 | Charter, RACI, KPIs, steering rhythm, board reporting |
| `chapter-16-procurement-contracts-third-party-risk.md` | 8,042 | Contract clauses, DORA ICT risk, vendor assessment |
| `chapter-17-software-supply-chain-embedded-cryptography.md` | 7,900 | SBOM/CBOM CI/CD gates, SSDF alignment |
| `chapter-18-fips-validation-testing-assurance.md` | 7,904 | FIPS 140-3, CMMC evidence, test matrix |

**Part V total (chapters + intro):** ~33,144 words

## Part VI Files

| File | ~Words | Notes |
|------|--------|-------|
| `part-06-introduction.md` | 1,461 | Proof phase, SOM, PQ-ADAPT L4–5, four-org arcs |
| `chapter-19-financial-services-playbook.md` | 8,042 | DORA examination, SOM wR +0.25, Meridian Year 2 arc |
| `chapter-20-defense-government-critical-infrastructure.md` | 7,984 | CNSA 2.0, CMMC, NERC CIP; Apex + Northfield |
| `chapter-21-cloud-saas-multinational-compliance.md` | 8,190 | Multi-tenant PQC, GDPR evidence; GlobalSync arc |
| `chapter-22-sustaining-quantum-resilience.md` | 7,965 | Standards watch, Level 5, four-org Year 3 retrospective |

**Part VI total (chapters + intro):** ~33,642 words

**Full manuscript (Parts I–VI, chapters + intros):** ~193,099 words

## Appendices

| File | ~Words | Notes |
|------|--------|-------|
| `appendix-a-cbom-cdg-templates.md` | 1,682 | CycloneDX schema, CDG graph, blocking register |
| `appendix-b-pq-adapt-self-assessment.md` | 1,212 | Levels 0–5 questionnaire with evidence index |
| `appendix-c-regulatory-mapping-matrix.md` | 1,414 | DORA/NIS2/GDPR/PCI/US matrix; supplements §C.5 |
| `appendix-d-migration-programme-charter-template.md` | 1,238 | Board charter template; third-party exhibit pointer |
| `appendix-e-glossary-standards-reference.md` | 1,160 | Glossary, algorithm and standards quick reference |

**Appendices total:** ~6,706 words

**Complete handbook (chapters + intros + appendices):** ~199,805 words

## Editorial Revisions — Part VI (June 2026)

Expert technical review against Parts I–V standards:

- British English pass; Northfield NIS2 framing verified (US operator; NERC CIP/TSA/CISA only)
- TRADE weight consistency with Chapter 9 §9.3: corrected Ch 19 Table 19.1 defaults (wT 1.5, wA 1.25, wD 1.0, wE 0.75); fixed wA mislabel (*Architectural dependency*, not *Agility*)
- Ch 20 §20.7 NSS/OT overlay tables aligned to Ch 9 sector modifiers (wR +0.50 NSS; wT +0.25 OT)
- Part VI introduction expanded: IETF hybrid TLS note, vendor category disclaimer (Part V parity)
- Ch 19: vendor-neutral references (removed Cryptomathic); composite case study citation format standardised
- Ch 20: Dependency Alert added (§20.7 CDG blocking vs weight modifiers)
- Ch 21: composite author reference merged to org case study format; SSDF reference added
- Ch 22: Apply checklist expanded to 15 items (parity with Ch 19–21)
- Character consistency: Marcus Chen (GlobalSync), Elena Vasquez (Meridian), Dr. Priya Nair (Apex), James Whitfield (Northfield), Thomas Bergström (Meridian regulatory), Sofia Lindström (GlobalSync PO)
- Cross-references to Parts I–V verified: SOM (Ch 9 §9.22), Governance Stack (Ch 15), procurement (Ch 16), CI/CD gates (Ch 17), assurance (Ch 18)
- Pedagogical boxes (6–8 per chapter), Apply checklists (15 items), 10 references per chapter verified
- Navigation: Proceed lines Ch 19–21; Ch 22 handoff to Appendices A–E

## Editorial Revisions — Part V (June 2026)

Expert technical review against Parts I–IV standards:

- British English pass (*authorise*, *defence industrial base*, *FedRAMP-authorised*)
- Organisation name consistency: Apex Defense Technologies (corrected Ch 15 §15.12 *Defence* variant)
- Part V introduction expanded: IR 8547 IPD qualification, ASCII figure convention, vendor category disclaimer (Part IV parity)
- Chapter 15: pedagogical box added (§15.13 funding model); five teaching boxes verified
- Chapter 16: *Proceed to Chapter 17* navigation line added after references
- Cross-references to Parts I–IV verified: Governance Stack (Ch 3), 94% readiness callback (Ch 7), CDG blocking (Ch 8), wave gates (Ch 9), agility gates (Ch 10), hybrid CBOM (Ch 11), HSM assessment (Ch 14)
- Character consistency: Marcus Chen (GlobalSync), Elena Vasquez (Meridian), Dr. Priya Nair (Apex), James Whitfield (Northfield) — no cross-org attribution errors
- Northfield NIS2 framing corrected in Ch 17 (US operator; NERC CIP/CISA overlay)
- Pedagogical boxes, Apply checklists (12–15 items), and 10 references per chapter verified
- Word counts meet ~8,000/chapter target; Part V handoff to Part VI documented in Ch 18

## Editorial Revisions — Part IV (June 2026)

Expert technical review against Parts I–II standards:

- British English pass (*synchronisation*, *summarised*, *parameterised*, *organisation*)
- Character consistency: Marcus Chen (GlobalSync) vs Elena Vasquez (Meridian) — corrected Ch 11–12 cross-org attributions
- Part IV introduction expanded: book arc table, suggested reading sequences, IR 8547 IPD qualification
- Chapter 10: DORA regulatory lens, programme artefact linkage (§10.24), figure production briefs
- Pedagogical boxes, Apply checklists, and 8–14 references per chapter verified
- Cross-references to Parts II–III (HLM, CBOM, CDG, TRADE) standardised

## Expansion — Part III (June 2026)

- Polished chapters to ~8,000 words each (Part I/II parity)
- Application-layer discovery, API gateway aggregation, baseline declaration ceremony (Ch 7)
- Service mesh, blast-radius exercise, partner programme, EA integration (Ch 8)
- Wave exit criteria, worked Northfield/Apex worksheets, escalation ladder (Ch 9)

## Expansion — Part II (June 2026)

- Polished chapters to ~8,000 words each (Part I parity)

## Editorial Revisions — Part II (June 2026)

- Expanded chapters toward Part I parity
- British English pass; IR 8547 IPD qualification; Ch 5 timeline arithmetic fix
- Pedagogical boxes standardised; Dependency Alert (Ch 5), Regulatory Lens (Ch 6)
- HLM failure modes, CBOM `hlm_phase` attributes, sample hybrid policy language
- Northfield OT constraints (Ch 4); Apex/Northfield timeline sections (Ch 5)
- Meridian payment HSM firmware case (Ch 6); worked matrix and validation examples
- References expanded to 8–10 per chapter; Figure production briefs added

## Editorial Revisions (June 2026)

Priority 1–3 editorial review items addressed:

- Part I Introduction created; preface material moved from Chapter 1
- Chapter 3 restructured: meta-bridge removed; ISO/insurance depth moved to Appendix C §C.5
- Figure 2.2 (Threat-to-control mapping) and Figure 3.2 (Regulatory convergence map) added
- TRADE MPI weighting formula and worked example (MPI = 4.39) in Chapter 2
- Northfield NIS2 framing corrected (US operators not under NIS2)
- DORA/EO 14144/NIS2 penalty claims qualified; British English standardised
- "Apply in Your Organisation" checklists added to Chapters 1–3
- Apex mandate-collision thread in Chapter 1; Apex TRADE weighting in Chapter 2

## Conventions

- One file per chapter: `chapter-NN-short-title.md`
- Part introduction: `part-01-introduction.md`
- Figures and tables referenced inline; production artwork to follow
- British English throughout (*programme*, *artefact*, *organisation*, *defence*)
- Illustrative budget figures labelled as planning examples, not benchmarks
- Case study organisations: Meridian Mutual Bank, Northfield Energy Systems, Apex Defense Technologies, GlobalSync Logistics
