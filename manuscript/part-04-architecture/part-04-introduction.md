# Part IV
# Architecting for Transition
## Introduction

---

Part I established *why* migration is a programme. Part II established *what* standards apply. Part III established *where* cryptography lives and *what moves first*. Part IV answers the question architects and engineers ask when wave plans receive board approval: **how do we build and migrate systems without breaking production?**

Wave plans without architecture standards produce heroic engineering — each team improvises hybrid TLS, PKI changes, and HSM integrations independently. Production collisions follow: partner outages, firmware bricking, incompatible certificate chains, and audit findings on systems that deployed PQC without validation or sunset criteria. Part IV provides **implementable architecture patterns** governed by policies from Parts II and III.

---

## What Part IV Delivers

Part IV comprises five chapters progressing from foundational agility requirements through deployment patterns to domain-specific migration paths:

**Chapter 10 — Cryptographic Agility as Architecture** defines crypto-agility as separation of cryptographic policy from implementation. New systems receive non-functional requirements; existing systems receive retrofit patterns. PQ-ADAPT Level 3 (*Architected*) entry criteria are satisfied when agility requirements are embedded in SDLC and enterprise architecture standards.

**Chapter 11 — Hybrid Deployment Patterns** provides production-ready hybrid constructions for TLS, VPN, code signing, and application-layer cryptography — each governed by the Hybrid Lifecycle Model (HLM) from Chapter 5 with explicit H2 triggers.

**Chapter 12 — Protocol Transition** maps migration paths for TLS, IPsec, SSH, and messaging protocols — recognising that each protocol has distinct ecosystem readiness curves and partner constraints.

**Chapter 13 — PKI Evolution and Certificate Lifecycle** addresses the most common enterprise blocking domain: root and issuing CAs, certificate profiles, validity periods, trust store mechanics, and automation.

**Chapter 14 — Key Management, HSMs, and Cloud Cryptography** covers KMS architectures, HSM partitioning, key ceremonies adapted for larger PQC keys, and multi-cloud custody patterns.

Together, these chapters complete the **Decide** and begin the **Execute** phases of the ARCS Framework — converting wave plans into engineering standards that development teams can implement.

---

## ARCS and PQ-ADAPT Positioning

| Framework | Part IV contribution |
|-----------|---------------------|
| **ARCS — Decide** | Architecture standards, pattern selection, validation criteria |
| **ARCS — Execute** | Implementation patterns, protocol migration playbooks |
| **PQ-ADAPT Level 3** | Crypto-agility in SDLC; hybrid policy operationalised; PKI roadmap approved |
| **PQ-ADAPT Level 4 prep** | Production hybrid patterns; HSM/KMS paths defined |
| **HLM** | Full deployment specification (Chapter 11) |
| **PQC Governance Stack** | Architecture layer populated — standards, patterns, review gates |

Enterprises with wave plans but no architecture standards remain at PQ-ADAPT Level 2 — they know what to migrate but not how to build migration-ready systems.

---

## Part IV Exit Artefacts

| Artefact | Owner | Chapter |
|----------|-------|---------|
| Crypto-agility NFR template | Enterprise architecture | 10 |
| Agility requirements by system class | Security architecture | 10 |
| Hybrid pattern catalog (HLM-governed) | Security architecture | 11 |
| Protocol migration playbooks | Network / platform engineering | 12 |
| PQC PKI architecture document | PKI team | 13 |
| Certificate profile specifications | PKI team | 13 |
| HSM/KMS capability assessment | Crypto engineering | 14 |
| Key ceremony adaptation procedures | Crypto operations | 14 |

---

## Prerequisites

Part IV assumes:

- Algorithm literacy from Part II (FIPS 203–205, HLM policy, timeline anchors)
- CBOM and CDG from Part III with wave plan approved
- Wave membership known for systems in scope — architecture work prioritises Wave 0–2 workloads first

Implementation in Part IV references CBOM `asset_id`, CDG blocking nodes, and TRADE wave assignments — not greenfield design in isolation.

---

## Who Should Read Part IV

| Reader | Read | Then proceed to |
|--------|------|-----------------|
| Enterprise Architect | All five chapters | Part V |
| Cryptographic Engineer | All five chapters | Chapters 17–18 |
| Security Architect | Chapters 10–12 | Chapter 16 |
| PKI Engineer | Chapters 10, 13 | Chapter 13 deep implementation |
| Platform / Cloud Engineer | Chapters 10, 12, 14 | Chapter 17 |
| OT Engineer | Chapters 10–12 (OT sections) | Chapter 19 |
| Programme Director | Chapters 10, 11 (governance) | Chapters 15–16 |

---

## The Teaching Organisations in Part IV

**Meridian Mutual Bank** — Hybrid TLS pilot with measured client compatibility; root CA strategy with ten-year overlap; payment HSM key ceremony adaptation; DORA-aligned architecture evidence.

**Northfield Energy Systems** — IPsec migration blocked by CPE firmware; OT gateway protocol constraints; WAN concentrator hybrid IKE qualification.

**Apex Defense Technologies** — NSS vs commercial architecture tracks; HSM partition strategy for classified zones; CNSA parameter profile enforcement.

**GlobalSync Logistics** — Platform-wide crypto-agility requirements in engineering standards; tenant-scoped hybrid rollout; multi-CDN TLS transition.

---

## What Part IV Is and Is Not

Part IV is **architecture and pattern guidance** — how to design migration-ready systems and execute protocol, PKI, and key management transitions.

It is **not** a product configuration manual. OpenSSL cipher strings, vendor CLI commands, and cloud console screenshots age quickly; patterns and decision criteria endure.

It is **not** programme governance — chartering, procurement, and steering committee operations are Part V.

It is **not** sector-specific playbooks — energy, defence, and healthcare specialisations are Part VI.

It **is** the engineering foundation that makes Part V programme execution and Part VI sector overlays technically credible.

---

## Conventions

British English, illustrative figures labelled as planning examples, pedagogical boxes (*Migration Moment*, *Dependency Alert*, *Regulatory Lens*, *Architect's Decision*), and *Apply in Your Organisation* checklists continue from prior parts.

Standards references align with FIPS 203–205 and IETF specifications at time of writing; monitor NIST and IETF for updates before production deployment.

---

*Proceed to Chapter 10: Cryptographic Agility as Architecture.*
