# Part II
# Standards as Inputs
## Introduction

---

Part I established *why* migration is a programme: threat asymmetry, regulatory convergence, and the synchronization problem. Part II establishes *what* architects and engineers must know about the standards landscape — without reproducing FIPS documents or teaching lattice mathematics.

The distinction matters. Enterprise teams that treat FIPS 203, 204, and 205 as implementation manuals produce over-scoped engineering programmes. Teams that ignore standards produce pilots that fail validation, procurement, and supervisory review. Part II occupies the middle ground: **standards as inputs to programme decisions**.

---

## What Part II Delivers

Part II comprises three chapters with a deliberate progression from algorithm literacy to policy design to special-case deployment:

**Chapter 4 — From NIST Competition to FIPS 203–205** provides sufficient algorithm literacy for architects. It explains why NIST selected ML-KEM, ML-DSA, and SLH-DSA; what parameter sets mean in practice; and how FN-DSA and HQC fit contingency planning — not blocking dependencies.

**Chapter 5 — Transition Timelines and Hybrid Policy** translates NIST IR 8547, CNSA 2.0, and allied national timelines into enterprise planning horizons. It introduces the Hybrid Lifecycle Model (HLM) — the book's framework for governing interim hybrid deployments with explicit sunset criteria.

**Chapter 6 — Stateful Signatures, Firmware, and Special Cases** addresses deployments FIPS 204 and 205 do not cleanly cover: firmware signing, long-lived embedded systems, and stateful hash-based signatures under SP 800-208. OT and defence readers should not skip this chapter.

Together, these chapters complete the **Capability** foundation of standards literacy within the ARCS Framework and enable PQ-ADAPT Level 3 (*Architected*) — hybrid policy defined, algorithm standards documented, PKI roadmap informed by authoritative sources.

---

## Who Should Read Part II

| Reader | Read | Then proceed to |
|--------|------|-----------------|
| Enterprise Architect | All three chapters | Parts III, IV |
| Cryptographic Engineer | All three chapters | Chapters 10–14, 18 |
| CISO / Security Leader | Chapters 4–5; skim Chapter 6 | Chapters 15–16 |
| Compliance Officer | Chapter 5 (policy); Chapter 4 (standards references) | Chapter 16 |
| OT / Critical Infrastructure | Chapters 4, 6 | Chapter 19 (energy playbook) |
| Defence / Government | Chapters 4–6 | Chapter 20 (defence playbook) |

Readers who completed Part I's regulatory chapter already know *that* state-of-the-art practice requires a documented PQC trajectory. Part II supplies the standards vocabulary to make that trajectory technically credible.

---

## The Standards-as-Inputs Principle

This book treats NIST FIPS 203, 204, and 205 as **authoritative algorithm specifications** — inputs to architectural and policy decisions, not substitutes for:

- Cryptographic asset inventory (Part III)
- Dependency-aware sequencing (Part III)
- Hybrid deployment patterns (Part IV)
- Programme governance and evidence (Part V)

The principle has three operational implications:

1. **Do not defer programme chartering pending standards finalisation.** FIPS 203–205 are final. Remaining NIST work (FN-DSA, HQC, IR 8547 finalisation) informs contingency planning, not whether to begin.

2. **Do not reproduce standards in internal policies.** Enterprise cryptography policies should reference FIPS parameter sets and approved use cases. They should not paste algorithm pseudocode or security proofs.

3. **Do not treat algorithm selection as the programme's critical path.** For most enterprises, ecosystem readiness and dependency resolution consume more calendar time than choosing between ML-DSA-65 and ML-DSA-87.

---

## Conventions

Part II continues Part I conventions: British English, illustrative figures labelled as planning examples, four teaching organisations (Meridian, Northfield, Apex, GlobalSync), and pedagogical boxes (*Migration Moment*, *Dependency Alert*, *Regulatory Lens*, *Architect's Decision*).

Standards citations reference publication status at time of writing. Monitor NIST, NSA, and IETF sources for updates — particularly NIST IR 8547 final publication and FN-DSA standardisation progress.

---

*Proceed to Chapter 4: From NIST Competition to FIPS 203–205.*
