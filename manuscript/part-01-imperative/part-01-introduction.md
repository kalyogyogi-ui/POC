# Part I
# The Migration Imperative
## Introduction

---

Post-quantum cryptography ceased to be a research question in August 2024, when NIST finalised FIPS 203, 204, and 205. For enterprise security leaders, the question is no longer *which algorithms* but *how an organisation survives the decade it takes to deploy them*.

Part I answers that question at the level of framing, analysis, and evidence. It does not teach lattice mathematics. It does not reproduce standards documents. It establishes the organisational logic that makes every subsequent technical decision defensible — to the board, to regulators, and to the engineers who must execute migration without breaking production systems.

---

## What Part I Delivers

Part I comprises three chapters with a deliberate progression:

**Chapter 1 — The Synchronization Problem** establishes the book's central thesis: post-quantum cryptographic migration is not a cryptographic upgrade. It is an enterprise-wide synchronization problem whose success depends on dependency topology, cross-functional governance, and ecosystem alignment — not algorithm selection alone.

**Chapter 2 — Threat Models That Drive Priorities** replaces quantum hype with decision-grade threat analysis. It introduces the TRADE Decision Engine's Threat dimension, confidentiality and integrity horizons, and the harvest-now-decrypt-later model that makes long-lived data a present-tense risk.

**Chapter 3 — The Regulatory and Policy Landscape** maps global forcing functions to evidence requirements. It introduces the PQC Governance Stack and demonstrates that compliance is a governance property demonstrated through coherent artefacts — not a single algorithm deployment.

Together, these chapters complete the **Awareness** phase of the ARCS Framework and establish the analytical foundation for Parts II through VI.

---

## Who Should Read Part I

| Reader | Read | Then proceed to |
|--------|------|-----------------|
| CISO / Security Leader | All three chapters | Chapters 15, 9, 19–22 |
| Enterprise Architect | All three chapters | Parts II, III, IV |
| Cryptographic Engineer | Chapters 1–2; skim Chapter 3 | Parts II, IV, Chapter 18 |
| Compliance Officer | Chapters 1, 3 | Chapter 16; sector playbook (Part VI) |
| Board / Executive | Chapter 1 (§1.9); Chapter 3 (§3.7–3.8) | Chapter 15 §15.2 |

Readers seeking immediate inventory methodology may be tempted to jump to Part III. Readers seeking hybrid TLS configuration may be tempted to jump to Part IV. Both will encounter dependencies on TRADE scoring, Governance Stack artefacts, and blocking-node analysis introduced in Part I. The learning progression is deliberate.

---

## What This Book Is and Is Not

This book is a practitioner reference for security leaders, enterprise architects, cryptographic engineers, and compliance officers who must design, govern, and evidence a post-quantum cryptographic migration programme.

It is **not** a mathematics textbook. FIPS 203, 204, and 205 are treated as inputs — authoritative algorithm specifications that inform architectural decisions — not as content to reproduce. Readers who need lattice reduction tutorials or security proof techniques should consult the academic literature, including Stinson's forthcoming *Primer on Post-Quantum Cryptography*.

It is **not** a vendor guide. Product names appear only where necessary for interoperability illustration. No vendor roadmap is endorsed. The frameworks in this book are designed to evaluate vendor claims, not repeat them.

It is **not** a quantum computing primer. The book assumes the reader accepts that cryptographically relevant quantum computers pose a credible long-term threat to RSA, DH, and ECC. It does not forecast quantum hardware timelines beyond what is necessary for migration planning.

It **is** a source of original enterprise methodologies: the Cryptographic Dependency Graph, the TRADE prioritisation engine, the Hybrid Lifecycle Model, the PQC Governance Stack, and the Sector Overlay Matrix. These frameworks are designed for this book. They are not adapted consulting methodologies or repackaged standards documents.

---

## The Teaching Organisations

Part I introduces four fictional organisations whose constraints span the enterprise landscape. Each reappears throughout the book as a teaching instrument — not a consulting case study, but a composite drawn from patterns observed across financial services, critical infrastructure, defence industrial base, and multinational SaaS environments.

**Meridian Mutual Bank** — 8,000 employees, retail and commercial banking, EU-headquartered, DORA-regulated. Teaches vendor dependency, payment HSM constraints, and regulatory evidence under financial supervision. Key characters: Elena Vasquez (DPO/programme), Thomas Bergström (regulatory affairs), Sofia Andersson (PKI engineering lead).

**Northfield Energy Systems** — 12,000 employees, gas transmission and distribution, US critical infrastructure. Teaches OT/IT convergence, long certificate validity, nation-state threat models, and operational continuity requirements. Key character: James Whitfield (OT Security Director).

**Apex Defense Technologies** — 25,000 employees, defence prime contractor, CMMC and FedRAMP obligations. Teaches CNSA 2.0 alignment, classified/unclassified boundary management, and programme consolidation under competing mandates. Key character: Dr. Priya Nair (assurance/NSS architecture).

**GlobalSync Logistics** — 3,500 employees, multinational SaaS platform, forty-country operations. Teaches cloud-native agility, tenant contractual constraints, cross-border compliance, and ecosystem synchronisation at scale. Key characters: Marcus Chen (security architecture), Sofia Lindström (programme director).

Following a single organisation's thread through the book — Meridian for financial services, Northfield for critical infrastructure, Apex for defence — provides narrative continuity for readers who prefer case-driven learning.

---

## Conventions

- **British English** is used throughout (*programme*, *artefact*, *finalised*, *defence*).
- **Illustrative figures** labelled as programme economics or budget estimates are modelled examples for planning discussions, not industry benchmarks.
- **Standards status** is noted at time of writing; NIST IR 8547 was in initial public draft. Monitor authoritative sources for final publication.
- **Figures** in manuscript form use structured placeholders; production artwork follows.

---

*Proceed to Chapter 1: The Synchronization Problem.*
