# Manuscript: Post-Quantum Cryptography — Enterprise Migration Handbook

**Status:** Part II editorial revision complete; Part III next (June 2026)  
**Architecture approved:** June 2026

## Structure

| Part | Directory | Chapters | Status |
|------|-----------|----------|--------|
| I — The Migration Imperative | `part-01-imperative/` | Intro + 1–3 | Editorial revision complete |
| II — Standards as Inputs | `part-02-standards/` | Intro + 4–6 | Editorial revision complete |
| III — Knowing Your Cryptographic Estate | `part-03-estate/` | 7–9 | Planned |
| IV — Architecting for Transition | `part-04-architecture/` | 10–14 | Planned |
| V — Running the Migration Programme | `part-05-programme/` | 15–18 | Planned |
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
| `chapter-04-nist-competition-to-fips.md` | 6,837 | FIPS 203–205, vendor rubric, validation matrix |
| `chapter-05-transition-timelines-hybrid-policy.md` | 6,710 | IR 8547, HLM, hybrid policy, exception lifecycle |
| `chapter-06-stateful-signatures-firmware.md` | 6,619 | SP 800-208, LMS/XMSS, OT/cloud firmware patterns |

**Part II total (chapters + intro):** ~21,395 words (~88% of Part I chapter depth)

## Expansion — Part II (June 2026)

- Expanded chapters to ~6,600–6,850 words each (Part I benchmark ~7,600)

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
