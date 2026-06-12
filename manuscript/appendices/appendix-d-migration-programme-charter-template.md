# Appendix D
# Migration Programme Charter Template
## Board-Approved Programme Authority Document

---

This appendix provides a **fillable charter template** implementing Chapter 15 Table 15.4. Legal review required before board submission — sample language is informative, not legal advice.

**Approval authority:** Board risk committee or delegated audit committee (financial services); equivalent governance body for other sectors.

**Renewal:** Annual minimum; amendment within five business days of material scope or authority change.

---

## D.1 Charter Cover Sheet

| Field | Entry |
|-------|-------|
| **Programme name** | Enterprise Post-Quantum Cryptography Migration Programme |
| **Charter version** | e.g. 2.1 |
| **Effective date** | |
| **Board approval date** | |
| **Programme director** | [Name, title] |
| **CISO / accountable executive** | |
| **Next renewal date** | |
| **Prior charter version superseded** | |

---

## D.2 Section 1 — Purpose and Scope

### 1.1 Purpose

The organisation establishes this programme to **synchronise** post-quantum cryptographic migration across [enterprise / named subsidiaries] in response to:

- Quantum computing threat to public-key cryptography (harvest-now-decrypt-later and future cryptanalytic capability)
- Regulatory and contractual obligations for state-of-the-art encryption
- NIST FIPS 203–205 standardisation and NIST IR 8547 transition timelines
- [Sector-specific drivers: DORA / NERC CIP / CMMC / GDPR — as applicable]

### 1.2 Scope — In scope

| Category | Description |
|----------|-------------|
| Geographies | |
| Subsidiaries / entities | |
| System classes | e.g. production IT, OT, cloud, SaaS platform, payment CDE |
| Cryptographic domains | TLS, PKI, HSM/KMS, firmware signing, application-layer, partner mTLS |
| Third-party dependencies | Critical ICT providers per DORA Art. 28 register / equivalent |

### 1.3 Scope — Explicit exclusions

| Exclusion | Rationale | Review date |
|-----------|-----------|-------------|
| e.g. Divestiture subsidiary X | Transaction closing Q2 2027 | 2027-06-30 |
| e.g. Retail CPE (customer premises) | Out of enterprise custody | 2028-01-01 |

### 1.4 Scope zones

| `scope_zone` tag | Description | Separate PQ-ADAPT reporting (Y/N) |
|------------------|-------------|-----------------------------------|
| `cde_payment` | Cardholder data environment | Y |
| `corporate_it` | General enterprise IT | Y |
| `ot_field` | Operational technology field devices | Y |

---

## D.3 Section 2 — Regulatory and Sector Overlay

| Instrument | Applicable entities | Overlay matrix reference |
|------------|--------------------|-------------------------|
| DORA | | Appendix C §C.3 |
| NIS2 | | |
| GDPR | | |
| PCI DSS | | |
| NERC CIP / TSA / CISA | | |
| CMMC / CNSA 2.0 | | |

**Sector Overlay Matrix (SOM) parameters documented:**

| Parameter | Value | Effective date |
|-----------|-------|----------------|
| wR modifier (financial) | +0.25 | |
| wE modifier (SaaS) | +0.25 | |
| NSS wR modifier | +0.50 | |
| OT wT modifier | +0.25 | |

---

## D.4 Section 3 — Organisational Authority

### 3.1 Programme director appointment

[Name] is appointed Programme Director with accountability for wave execution outcomes, KPI integrity, and steering committee leadership.

### 3.2 Migration authority matrix

Reference: Chapter 15 Table 15.5. Summary:

| Decision | Authority |
|----------|-----------|
| Partner profile mandate | Programme director + commercial lead |
| Wave funding reallocation >10% | Steering committee |
| Exception >90 days | CISO + risk committee chair |
| Algorithm policy change | Crypto governance board |
| Charter amendment | Board risk committee |

### 3.3 Escalation ladder

| Level | Forum | Trigger |
|-------|-------|---------|
| 1 | Programme office weekly | Operational blockers |
| 2 | Steering committee monthly | Wave exit miss; vendor non-compliance |
| 3 | Board risk committee quarterly | >15% behind regulatory anchor; material risk acceptance |
| 4 | Full board | Regulatory enforcement; major incident |

---

## D.5 Section 4 — Governance Structure

| Forum | Chair | Cadence | Charter / TOR reference |
|-------|-------|---------|------------------------|
| Board risk committee | | Quarterly | |
| PQC steering committee | Programme director | Monthly | Annex D-1 |
| Crypto governance board | CISO | Monthly | |
| CBOM quality review | CBOM custodian | Weekly | |

**Annex D-1:** Steering committee terms of reference (membership, quorum, decision log format).

---

## D.6 Section 5 — Wave Plan and Dependencies

| Reference document | Version | Board approval date |
|-------------------|---------|---------------------|
| Wave plan (Chapter 9) | | |
| CBOM baseline | | |
| CDG blocking node register | | |

**Replanning triggers:** CDG blocking node stall >4 weeks; regulatory publication; CMVP listing change; acquisition >[threshold] revenue.

---

## D.7 Section 6 — Funding Envelope

| Component | Years 1–3 budget range | Notes |
|-----------|------------------------|-------|
| Wave execution | | |
| Programme office | | |
| Vendor / procurement | | |
| Assurance / validation | | |
| Contingency (10–15%) | | |
| **Sustainment (Year 3+)** | | Chapter 22 custodianship |

**Wave funding gates:** Wave N+1 funding released upon Wave N exit criteria met or documented risk acceptance.

---

## D.8 Section 7 — KPI Framework

Reference dashboard template: Chapter 15 §15.12.

| KPI | Target | Reporting cadence |
|-----|--------|-------------------|
| CBOM verified coverage | ≥ 70% | Monthly |
| Blocking nodes resolved / total | | Monthly |
| Production hybrids (count) | | Monthly |
| Vendor Tier A–B % | | Monthly |
| Open validation gaps | | Monthly |

---

## D.9 Section 8 — RACI and Accountability

RACI matrix version: [ID] — Annex D-2.

**Acknowledgement:** Domain VPs confirm RACI within 30 days of charter approval.

---

## D.10 Section 9 — Assurance Integration

| Assurance activity | Owner | Link to programme |
|-------------------|-------|-------------------|
| Validation programme | | Chapter 18 test matrix |
| Internal audit | | Annual plan includes PQC |
| Regulatory examination | | Appendix C examination map |
| Penetration test (crypto-qualified) | | Annual scope includes downgrade / KMS |

---

## D.11 Section 10 — Review and Amendment

| Event | Action |
|-------|--------|
| Annual charter renewal | Board risk committee |
| Material scope change | Amendment within 5 business days |
| PQ-ADAPT level declaration change | Steering notification |
| Post-acquisition | Scope zone integration within 90 days |

---

## D.12 Annex D-3 — Third-Party Contract Exhibit Pointer

Procurement attaches **PQC clause library** (Chapter 16 Table 16.1) as contract exhibits:

| Exhibit | Content |
|---------|---------|
| Exhibit A | Algorithm policy excerpt |
| Exhibit B | CycloneDX CBOM schema + minimum fields (Appendix A) |
| Exhibit C | Approved crypto profile catalogue |
| Exhibit D | Test harness / agility verification reference |
| Exhibit E | Hybrid TLS negotiation profile IDs |

*This annex satisfies Chapter 19 reference to third-party contractual templates within the charter package.*

---

## D.13 Signatures

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Board risk committee chair | | | |
| CISO | | | |
| Programme director | | | |
| General counsel (acknowledgement) | | | |

---

*Proceed to Appendix E: Glossary and Standards Quick Reference.*

---

*Appendix D — References*

- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards.
- Post-Quantum Cryptography Enterprise Migration Handbook. (2026). Chapter 15 — programme charter contents.
