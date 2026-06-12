# Manuscript: Post-Quantum Cryptography — Enterprise Migration Handbook

**Status:** Part V editorial revision complete (June 2026); ~8,000 words/chapter parity  
**Architecture approved:** June 2026

## Structure

| Part | Directory | Chapters | Status |
|------|-----------|----------|--------|
| I — The Migration Imperative | `part-01-imperative/` | Intro + 1–3 | Editorial revision complete |
| II — Standards as Inputs | `part-02-standards/` | Intro + 4–6 | Editorial revision complete |
| III — Knowing Your Cryptographic Estate | `part-03-estate/` | Intro + 7–9 | Draft complete |
| IV — Architecting for Transition | `part-04-architecture/` | Intro + 10–14 | Draft complete |
| V — Running the Migration Programme | `part-05-programme/` | Intro + 15–18 | Draft complete |
| VI — Sector Playbooks and Proof | `part-06-sector/` | 19–22 | Planned |
| Appendices | `appendices/` | A (draft); B–E planned | Appendix A drafted |

## Part I Files

| File | ~Words | Notes |
|------|--------|-------|
| `part-01-introduction.md` | 864 | Scope, reading paths, teaching organisations, conventions |
| `chapter-01-synchronization-problem.md` | 7,812 | Thesis, ARCS Awareness, programme vs project |
| `chapter-02-threat-models.md` | 7,393 | TRADE Threat dimension, MPI formula, Figure 2.2 |
| `chapter-03-regulatory-landscape.md` | 7,683 | Governance Stack, Figure 3.2, regulatory overlay |
| `appendices/appendix-a-regulatory-supplements.md` | 718 | ISO/ETSI/IETF, insurance, contractual risk |

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

**Part V total (chapters + intro):** ~32,978 words

## Editorial Revisions — Part V (June 2026)

Expert technical review against Parts I–IV standards:

- British English pass (*authorise*, *defence industrial base*, *FedRAMP-authorised*)
- Organisation name consistency: Apex Defense Technologies (corrected Ch 15 §15.12 *Defence* variant)
- Part V introduction expanded: IR 8547 IPD qualification, ASCII figure convention, vendor category disclaimer (Part IV parity)
- Chapter 15: pedagogical box added (§15.13 funding model); five teaching boxes verified
- Chapter 16: *Proceed to Chapter 17* navigation line added after references
- Cross-references to Parts I–IV verified: Governance Stack (Ch 3), 94% readiness callback (Ch 7), CDG blocking (Ch 8), wave gates (Ch 9), agility gates (Ch 10), hybrid CBOM (Ch 11), HSM assessment (Ch 14)
- Character consistency: Marcus Chen (GlobalSync), Elena Vasquez (Meridian), Dr. Priya Nair (Apex), James Okafor (Northfield) — no cross-org attribution errors
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
- Chapter 3 restructured: meta-bridge removed; ISO/insurance depth moved to Appendix A
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
