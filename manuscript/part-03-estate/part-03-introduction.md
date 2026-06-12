# Part III
# Knowing Your Cryptographic Estate
## Introduction

---

Part I established *why* migration is a programme and *who* must be involved. Part II established *what* standards apply — algorithms, timelines, hybrid policy, firmware exceptions. Part III answers the question every security leader asks next: **where is our cryptography, and what must move first?**

Without authoritative answers, programme budgets fund pilots on visible endpoints while blocking dependencies — HSM roots, firmware signing chains, partner trust stores, shared KMS partitions — remain invisible until production collision. Part III provides the inventory and dependency methodologies that convert awareness and standards literacy into **defensible sequencing**.

---

## What Part III Delivers

Part III comprises three chapters with a deliberate progression from visibility to topology to action:

**Chapter 7 — Cryptographic Discovery and the CBOM** teaches authoritative inventory methodology. The Cryptographic Bill of Materials becomes the system of record — maintained, normalised, and scoped with explicit coverage limits.

**Chapter 8 — The Cryptographic Dependency Graph** extends the CBOM with relationships. Migration sequence is determined by dependency topology, not asset criticality alone. Blocking nodes — assets whose delayed migration prevents downstream transitions — emerge from graph analysis, not executive intuition.

**Chapter 9 — Risk Tiering and Migration Wave Planning** converts inventory and dependencies into phased migration waves using the full TRADE Decision Engine. The reader produces a board-approved wave plan with multi-dimensional prioritisation — not a sorted spreadsheet of server names.

Together, these chapters complete the **Register** phase of the ARCS Framework and advance enterprises from PQ-ADAPT Level 1 (*Alerted*) toward Level 2 (*Inventoried*) and Level 3 preparation (*Architected*).

---

## PQ-ADAPT and ARCS Positioning

| Framework | Part III contribution |
|-----------|----------------------|
| **ARCS — Register** | CBOM as cryptographic system of record; CDG as planning topology |
| **PQ-ADAPT Level 2** | CBOM baseline; HNDL-tiered data classification mapped to assets |
| **PQ-ADAPT Level 3 prep** | Dependency-aware sequencing inputs for architecture standards (Part IV) |
| **TRADE engine** | Full five-dimension scoring and MPI-driven wave planning (Chapter 9) |
| **PQC Governance Stack** | Operational layer populated — CBOM, CDG, wave plan artefacts |

Enterprises with executive slides claiming "PQC awareness" but no maintained CBOM remain at PQ-ADAPT Level 1 regardless of hybrid policy quality from Part II.

---

## Part III Exit Artefacts

| Artefact | Owner | Chapter |
|----------|-------|---------|
| CBOM baseline (≥80% coverage target) | Crypto engineering / programme office | 7 |
| Discovery methodology and scope document | Enterprise architecture | 7 |
| CBOM maintenance cadence and tooling | Operations | 7 |
| Cryptographic Dependency Graph (initial) | Enterprise architecture | 8 |
| Blocking node register | Programme office | 8 |
| TRADE-scored asset register | Risk / security | 9 |
| Migration wave plan (board-approved) | Programme director | 9 |
| Wave reassessment schedule | Steering committee | 9 |

---

## Who Should Read Part III

| Reader | Read | Then proceed to |
|--------|------|-----------------|
| Enterprise Architect | All three chapters | Part IV |
| Cryptographic Engineer | Chapters 7–8; Chapter 9 §9.1–9.3 | Chapters 10–14 |
| CISO / Programme Director | Chapters 7, 9 | Chapters 15–16 |
| Compliance Officer | Chapter 7 (evidence); Chapter 9 (wave justification) | Chapter 16 |
| OT / Critical Infrastructure | Chapters 7–8 (OT sections) | Chapter 19 |
| Procurement / Vendor management | Chapter 7 §7.7; Chapter 8 partner edges | Chapter 17 |

---

## The Teaching Organisations in Part III

**Meridian Mutual Bank** — Phase 1 CBOM: 14,200 assets, 38% third-party obscured; payment HSM as CDG blocking node; DORA certificate register fed from CBOM.

**Northfield Energy Systems** — OT/IT discovery convergence; firmware and SCADA assets in CBOM; VPN concentrators as Wave 1 structural blockers.

**Apex Defense Technologies** — NSS vs corporate IT inventory boundaries; wave plan aligned to contract renewal and CNSA milestones.

**GlobalSync Logistics** — Cloud-native discovery pipelines; partner mutual-TLS API as root blocker for 200+ microservices; tenant-scoped CBOM annotations.

---

## What Part III Is and Is Not

Part III is **estate knowledge methodology** — how to see cryptography and how to model dependencies for sequencing.

It is **not** a vendor tool guide. Tool names appear as categories; no product is endorsed.

It is **not** implementation guidance for hybrid TLS or PKI migration — that is Part IV.

It is **not** programme governance — chartering, RACI, and board operating rhythm are Part V.

It **is** the analytical foundation that makes Part IV implementation and Part V governance credible.

---

## Prerequisites

Part III assumes completion of Part I framing (synchronisation thesis, threat analysis, regulatory evidence) and Part II standards literacy (algorithm matrix, HLM policy, timeline overlay). CBOM entries reference FIPS algorithm names (Chapter 4). Wave planning applies TRADE weights introduced in Chapter 2 and HLM phases from Chapter 5.

---

## Conventions

British English, illustrative figures labelled as planning examples, pedagogical boxes (*Migration Moment*, *Dependency Alert*, *Regulatory Lens*, *Architect's Decision*), and *Apply in Your Organisation* checklists continue from Parts I and II.

CycloneDX CBOM references align with specification evolution at time of writing; monitor [cyclonedx.org](https://cyclonedx.org) for schema updates.

---

*Proceed to Chapter 7: Cryptographic Discovery and the CBOM.*
