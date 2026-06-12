# Appendix B
# PQ-ADAPT Self-Assessment Questionnaire
## Maturity Assessment with Evidence Index

---

This appendix provides a **zone-scoped self-assessment** for the PQ-ADAPT maturity model (Chapters 1, 9, 15, 22). Complete assessments **per scope zone** — `cde_payment`, `corporate_it`, `ot_field`, `nss_enclave`, `tenant_tier_t2`, etc. — not as a single enterprise aggregate. Aggregate only after zone scores are documented; honest partial maturity prevents supervisory and board overstatement.

**Cadence:** Annual minimum; after major wave exit; before regulatory examination or CMMC assessment; within 90 days of acquisition integration.

**Scoring:** Each criterion scored **0** (absent), **1** (partial), **2** (complete with evidence). Zone level declared only when **all mandatory criteria** for that level score 2, or documented risk acceptance exists for gaps.

---

## B.1 Assessment Metadata

| Field | Value |
|-------|-------|
| Organisation | |
| Assessment date | |
| Assessor(s) | |
| Scope zone (`scope_zone`) | |
| In-scope systems / CBOM row count | |
| Regulatory overlay(s) applied | |
| Prior assessment date / level | |
| Declared PQ-ADAPT level (this assessment) | |

---

## B.2 Level 0 → Level 1 (*Unaware* → *Alerted*)

| # | Criterion | Score (0–2) | Evidence artefact | Location / ID |
|---|-----------|-------------|-------------------|---------------|
| L1.1 | Quantum threat documented in enterprise risk register | | Risk register extract | |
| L1.2 | Executive briefing delivered to board or risk committee | | Board minutes / pack | |
| L1.3 | Regulatory horizon scan completed (jurisdiction-specific) | | Horizon report | |
| L1.4 | Named executive sponsor for PQC programme | | Charter draft or memo | |
| L1.5 | Ad hoc cryptographic discovery initiated | | Discovery plan | |

**Level 1 entry:** L1.1 and L1.2 score ≥ 1.

---

## B.3 Level 1 → Level 2 (*Alerted* → *Inventoried*)

| # | Criterion | Score (0–2) | Evidence artefact | Location / ID |
|---|-----------|-------------|-------------------|---------------|
| L2.1 | CBOM baseline established for scope zone | | Certified baseline export | |
| L2.2 | Algorithm normalisation rules applied (Chapter 4) | | Normalisation rule set | |
| L2.3 | `quantum_vulnerable` flagged on ≥ 90% of rows | | CBOM quality scorecard | |
| L2.4 | HNDL / confidentiality horizon assessed for high-value data | | Threat assessment (Chapter 2) | |
| L2.5 | CDG seed graph or blocking node list exists | | CDG export / register | |
| L2.6 | TRADE worksheets completed for top 20% MPI candidates | | TRADE scoring workbook | |
| L2.7 | Third-party cryptographic dependencies identified | | CBOM `third_party_flag` report | |

**Level 2 entry:** L2.1, L2.3, L2.5 score 2.

---

## B.4 Level 2 → Level 3 (*Inventoried* → *Architected*)

| # | Criterion | Score (0–2) | Evidence artefact | Location / ID |
|---|-----------|-------------|-------------------|---------------|
| L3.1 | Board-approved programme charter (or zone annex) | | Signed charter | |
| L3.2 | Crypto-agility NFRs in SDLC / EA standards (Chapter 10) | | Standards document | |
| L3.3 | Hybrid policy and HLM templates published (Chapter 5) | | Policy document | |
| L3.4 | Approved algorithm matrix with validation status (Chapter 4) | | Algorithm matrix | |
| L3.5 | PKI / key management roadmap approved (Chapters 13–14) | | PKI architecture doc | |
| L3.6 | Wave plan approved with CDG blocking gates (Chapter 9) | | Board wave pack | |
| L3.7 | CI/CD or change gates defined (not yet universal) | | Gate specification | |

**Level 3 entry:** L3.1, L3.2, L3.3, L3.6 score 2.

---

## B.5 Level 3 → Level 4 (*Architected* → *Transitioning*)

| # | Criterion | Score (0–2) | Evidence artefact | Location / ID |
|---|-----------|-------------|-------------------|---------------|
| L4.1 | Programme office operational with RACI acknowledged | | RACI matrix | |
| L4.2 | Steering committee ≥ 3 cycles with decision log | | Steering minutes | |
| L4.3 | Production hybrid deployment in scope zone (HLM H1/H2) | | Change records | |
| L4.4 | KPI dashboard live and reported monthly | | Dashboard export | |
| L4.5 | Critical vendor PQC clauses in renewal path (Chapter 16) | | Contract tracker | |
| L4.6 | Validation programme active for deployed paths (Chapter 18) | | Test matrix | |
| L4.7 | Exception register current; no expired acceptances | | Risk register | |
| L4.8 | CBOM maintained with quarterly baseline certification | | Custodian sign-off | |

**Level 4 entry:** L4.3, L4.5, L4.6, L4.8 score 2 (Chapter 15 Table 15.2 alignment).

---

## B.6 Level 4 → Level 5 (*Transitioning* → *Quantum-Resilient*)

| # | Criterion | Score (0–2) | Evidence artefact | Location / ID |
|---|-----------|-------------|-------------------|---------------|
| L5.1 | Disallowance policy aligned to NIST IR 8547 / sector anchors | | Board policy | |
| L5.2 | Zero disallowed PKC in production scope (CBOM query) | | CBOM compliance report | |
| L5.3 | HLM H3 or classical sunset complete per policy | | Sunset records | |
| L5.4 | Annual crypto-agility substitution drill passed | | Drill report | |
| L5.5 | Standards watch calendar active with assigned owners | | Calendar + minutes | |
| L5.6 | FN-DSA / HQC contingency documented with activation criteria | | Contingency pack | |
| L5.7 | FIPS module inventory matches production (regulated paths) | | Validation matrix | |
| L5.8 | Lessons learned loop linked to policy updates | | Retrospective record | |
| L5.9 | Sustainment funding approved beyond wave execution | | Budget line | |
| L5.10 | Acquisition CBOM integration SLA ≤ 90 days | | M&A playbook | |

**Level 5 entry:** Chapter 22 Table 22.3 — majority of L5.x score 2; honest gaps documented with board-approved timeline.

---

## B.7 Zone Aggregation Worksheet

| Scope zone | Declared level | Blocking gaps | Target level date | Board / steering acknowledged |
|------------|----------------|---------------|-----------------|------------------------------|
| `cde_payment` | | | | |
| `corporate_it` | | | | |
| `ot_field` | | | | |
| `partner_ecosystem` | | | | |

**Rule:** Enterprise banner level = **minimum** zone level unless explicitly qualified in board reporting (Chapter 22 §22.4).

---

## B.8 Evidence Index Template

| Criterion ID | Artefact name | Owner | Last updated | Review cycle | Storage location |
|--------------|---------------|-------|--------------|--------------|------------------|
| L4.3 | Hybrid TLS production change record | platform-eng | | | |
| L4.6 | Validation test matrix v3 | assurance | | | |

---

## B.9 Assessor Attestation

| Role | Name | Signature / date | Statement |
|------|------|------------------|-----------|
| Programme director | | | Zone-level scores reflect evidence reviewed |
| CISO / zone security lead | | | Gaps disclosed to steering / board |
| Internal audit (optional) | | | Independent sample completed |

---

*Proceed to Appendix C: Regulatory Mapping Matrix.*

---

*Appendix B — References*

- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards.
- Post-Quantum Cryptography Enterprise Migration Handbook. (2026). Chapters 1, 9, 15, 22 — PQ-ADAPT model definition.
