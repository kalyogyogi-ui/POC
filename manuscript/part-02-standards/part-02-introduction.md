# Part II
# Standards as Inputs
## Introduction

---

Part I established *why* migration is a programme: threat asymmetry, regulatory convergence, and the synchronisation problem. Part II establishes *what* architects and engineers must know about the standards landscape — without reproducing FIPS documents or teaching lattice mathematics.

The distinction matters. Enterprise teams that treat FIPS 203, 204, and 205 as implementation manuals produce over-scoped engineering programmes. Teams that ignore standards produce pilots that fail validation, procurement, and supervisory review. Part II occupies the middle ground: **standards as inputs to programme decisions**.

---

## What Part II Delivers

Part II comprises three chapters with a deliberate progression from algorithm literacy to policy design to special-case deployment:

**Chapter 4 — From NIST Competition to FIPS 203–205** provides sufficient algorithm literacy for architects. It explains why NIST selected ML-KEM, ML-DSA, and SLH-DSA; what parameter sets mean in practice; and how FN-DSA and HQC fit contingency planning — not blocking dependencies.

**Chapter 5 — Transition Timelines and Hybrid Policy** translates NIST IR 8547, CNSA 2.0, and allied national timelines into enterprise planning horizons. It introduces the Hybrid Lifecycle Model (HLM) — the book's framework for governing interim hybrid deployments with explicit sunset criteria.

**Chapter 6 — Stateful Signatures, Firmware, and Special Cases** addresses deployments FIPS 204 and 205 do not cleanly cover: firmware signing, long-lived embedded systems, and stateful hash-based signatures under SP 800-208. OT and defence readers should not skip this chapter.

Together, these chapters complete the **Capability** foundation of standards literacy within the ARCS Framework and enable **PQ-ADAPT Level 3 (*Architected*)**.

---

## PQ-ADAPT Level 3 Exit Artefacts

Part II completion should produce the following artefacts in the enterprise programme — the evidence that standards literacy has converted to governed architecture:

| Artefact | Governance layer | Chapter source |
|----------|-----------------|----------------|
| Algorithm standards matrix | Policy | Chapter 4 |
| Validation coverage matrix | Operational | Chapter 4 |
| Timeline overlay (internal + anchors) | Programme | Chapter 5 |
| Hybrid cryptography policy (HLM phases, approved constructions) | Policy | Chapter 5 |
| Exception / risk acceptance register template | Assurance | Chapter 5 |
| Firmware and special-case signature matrix | Policy | Chapter 6 |
| CBOM attribute schema (`hlm_phase`, `signature_scheme`) | Operational | Chapters 5–6 |

Enterprises holding policy documents that name ML-KEM without validation matrices, hybrid sunset criteria, or firmware exception paths remain at PQ-ADAPT Level 2 (*Inventoried*) regardless of executive briefing quality.

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

## What Part II Is and Is Not

Part II is **standards literacy for programme architects** — sufficient depth to write policies, evaluate vendors, and commission engineering work without becoming a cryptographer.

It is **not** a reproduction of FIPS 203, 204, or 205. Readers needing test vectors, security proofs, or implementation pseudocode should consult NIST publications and academic references.

It is **not** a protocol implementation guide. Hybrid TLS configuration, PKI migration, and HSM integration are developed in Part IV.

It is **not** an inventory methodology. CBOM discovery and dependency graph construction are Part III.

It **is** the bridge between Part I's *why* and Part III's *where* — translating finalised NIST standards into enterprise policy inputs that survive audit, procurement, and production deployment.

---

## The Teaching Organisations in Part II

The four organisations introduced in Part I reappear with standards-specific challenges:

**Meridian Mutual Bank** — Algorithm standards matrix linked to DORA encryption policy; payment HSM validation gap; physical token refresh sizing for ML-DSA chains.

**Northfield Energy Systems** — OT certificate and firmware store constraints; Wave 1 capital expenditure tied to VPN and firmware timelines; LMS evaluation for constrained field devices.

**Apex Defense Technologies** — CNSA 2.0 dual-track algorithm matrix; NSS vs corporate IT timeline floors; classified/unclassified firmware signing boundaries.

**GlobalSync Logistics** — Multinational timeline overlay; hybrid TLS client compatibility measurement; container image signing as cloud-native firmware analogue.

Following one organisation's Part II thread — Apex for defence, Northfield for OT — complements Part I narrative continuity.

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

Part II continues Part I conventions: British English, illustrative figures labelled as planning examples, four teaching organisations, and pedagogical boxes (*Migration Moment*, *Dependency Alert*, *Regulatory Lens*, *Architect's Decision*).

Standards citations reference publication status at time of writing. NIST IR 8547 remains in Initial Public Draft at time of writing — monitor authoritative sources for final publication. FN-DSA standardisation is ongoing.

ASCII figures in manuscript form include production briefs for artwork; final diagrams follow in production.

---

## How Part II Connects to the Book Arc

| Part | Question | Part II contribution |
|------|----------|-------------------|
| I | Why migrate? | Threat, regulation, synchronisation thesis |
| **II** | **What standards apply?** | **FIPS suite, timelines, hybrids, firmware exceptions** |
| III | Where is crypto deployed? | CBOM and CDG consume algorithm policy |
| IV | How to implement? | Hybrid TLS, PKI, KMS execute HLM phases |
| V | Who governs and when? | Programme office maintains timeline overlay |
| VI | Sector proof? | SOM modifies defaults from Chapters 4–6 |

Readers skipping Part II arrive at inventory and architecture chapters without algorithm vocabulary, hybrid sunset criteria, or firmware exception frameworks — producing CBOM entries that name "PQC" generically and policies that fail supervisory scrutiny.

---

## Suggested Reading Sequences

**Architect fast path:** Introduction → Chapter 4 (§4.1, §4.8, §4.12–4.14) → Chapter 5 (§5.6–5.7, §5.24–5.25) → Chapter 6 (§6.4, §6.8) → Part III.

**OT / critical infrastructure path:** Introduction → Chapter 4 (§4.9) → Chapter 6 (full) → Chapter 5 (§5.14, §5.17) → Chapter 19 (Part VI).

**Compliance officer path:** Introduction → Chapter 4 (§4.15, Table 4.7) → Chapter 5 (§5.2, §5.11, §5.15) → Chapter 3 cross-reference (Part I).

---

*Proceed to Chapter 4: From NIST Competition to FIPS 203–205.*
