# Appendix C
# Regulatory Mapping Matrix
## DORA, NIS2, GDPR, PCI, and US Federal Overlays

---

This appendix supports Chapter 3 and sector playbooks (Chapters 19–21). It provides a **regulatory overlay matrix** mapping programme artefacts from the PQC Governance Stack (Chapter 3) to obligations in multiple jurisdictions — enabling a **single migration programme** with jurisdiction annotations, not parallel architectures.

**Usage:** Compliance officers maintain the matrix as a living document. Link each cell to evidence artefact IDs (CBOM baseline, charter version, test report). Update when RTS, delegated acts, or sector guidance change.

---

## C.1 Matrix Structure

Each row is a **programme artefact**. Each column is a **regulatory instrument**. Cell content: **article / control reference** + **evidence expectation**.

**Legend:** Cells list primary article or control references. Mark **n/a** where the instrument does not apply to your jurisdiction or sector. Verify mappings against current authoritative publications before examination or assessment use.

---

## C.2 Programme Artefact × Regulatory Instrument Matrix

| Programme artefact | DORA (EU financial) | NIS2 (EU essential/important) | GDPR (EU) | PCI DSS 4.0 | US FedRAMP / FISMA | CMMC (US defence CUI) | NERC CIP (US energy) |
|-------------------|----------------------|------------------------------|-----------|-------------|-------------------|------------------------|---------------------|
| **Programme charter** | Art. 6 governance; ICT risk framework | Art. 21 risk management | Art. 32 accountability | Req. 12 (programme) | PM-1, PM-9 | CA.L2-3.12.4 planning | CIP-003 cyber security policy |
| **Encryption / crypto policy** | RTS Art. 6; Recital 9 (quantum) | Art. 21 state-of-the-art | Art. 32 security measures | Req. 3, 4 (crypto) | SC-12, SC-13 | SC.L2-3.13.11 encryption | CIP-005, CIP-007 electronic access |
| **CBOM / certificate register** | RTS Art. 6 register | Risk assessment evidence | Processing records support | Req. 2, 12 | CM-8, SA-22 | CM.L2-3.4.1 asset inventory | Asset identification |
| **Threat assessment (TRADE T)** | Art. 6 ICT risk assessment | Art. 21 all-hazards | DPIA input for high risk | Req. 6 | RA-3 | RA.L2-3.11.2 risk assessment | BES cyber system categorisation |
| **CDG / dependency analysis** | Art. 6 proportionality | Critical dependency mapping | — | Req. 12 | SA-4, SA-9 | SA.L2-3.13.4 architecture | Electronic security perimeter deps |
| **Wave plan** | Art. 6 remediation planning | Art. 21 measures implementation | — | Req. 12 | PL-2, CA-5 POA&M | CA.L2-3.12.2 plan of action | Patch / change management |
| **Third-party register** | Arts. 28–30 ICT TP risk | Supply chain measures | Art. 28 processor DPAs | Req. 12.8 | SA-9, SR-2 | SC.L2-3.12.4 flow-down | Vendor remote access |
| **Vendor PQC assessment** | Art. 30 due diligence | Supply chain security | Art. 28 processor assurance | Req. 12.8 | SA-9 | SC.L2-3.12.4 subcontractor | Vendor security controls |
| **Hybrid / HLM policy** | RTS Art. 6 techniques selection | State-of-the-art encryption | Art. 32 appropriate measures | Req. 3, 4 | SC-13 | SC.L2-3.13.11 | Communications protection |
| **Validation / test evidence** | Art. 25 resilience testing | Art. 21 testing | Art. 32 effectiveness | Req. 11 | CA-2, SA-11 | CA.L2-3.12.1 security assessment | Security event monitoring |
| **Incident response (crypto)** | Art. 17–19 ICT incidents | Art. 23 incident handling | Art. 33 breach notification | Req. 12 | IR-4 | IR.L2-3.6.1 incident handling | Incident reporting |
| **Board / oversight reporting** | Art. 5 governance | Management accountability | — | Req. 12 | PM-1 | AM.L2-3.12.4 executive oversight | Senior leadership |
| **Standards watch / horizon** | Recital 9 monitoring | State-of-the-art evolution | Art. 32 evolving measures | Req. 6 | PL-2 | RA.L2-3.11.1 continuous monitoring | Emerging threat response |

---

## C.3 Jurisdiction Overlay Annotation Template

For multinational enterprises, annotate each subsidiary row:

| Entity | Primary instrument | Secondary instruments | Sector overlay (Ch 19–21) | Programme artefact pack ID |
|--------|-------------------|----------------------|----------------------------|---------------------------|
| Meridian Mutual Bank (EU) | DORA | GDPR; NIS2 (where applicable) | Financial services SOM | `MER-EU-DORA-2027` |
| Northfield Energy (US) | NERC CIP; TSA; CISA | — (not NIS2) | Critical infrastructure SOM | `NF-US-CIP-2027` |
| Apex Defense Technologies (US) | CMMC; DFARS; CNSA 2.0 (NSS) | FedRAMP (commercial) | Defence SOM | `APX-US-CMMC-2028` |
| GlobalSync Logistics | GDPR; NIS2 (EU ops) | SOC 2; customer flow-down | SaaS SOM | `GS-EU-GDPR-2028` |

---

## C.4 Supervisory Examination Question Map (Financial Services)

Maps Chapter 3 examination questions to evidence volumes (Chapter 19):

| Examiner question | Primary artefact | DORA reference |
|-------------------|------------------|----------------|
| Does encryption policy address quantum developments? | Crypto policy + standards watch | RTS Art. 6; Recital 9 |
| Is the certificate register complete? | CBOM baseline + quality scorecard | RTS Art. 6 |
| How are third-party crypto risks managed? | Vendor assessment + contract clauses | Arts. 28–30 |
| What is the migration timeline? | Wave plan + validation dependency timeline | Art. 6 remediation |
| What testing demonstrates resilience? | Test matrix + harness results | Art. 25 |
| How are incidents involving crypto handled? | IR playbook + crypto incident clause | Arts. 17–19 |

---

## C.5 Regulatory Supplements
### International Standards, Insurance, and Contractual Risk

*Supports Chapter 3. Material moved from prior regulatory supplements appendix.*

### C.5.1 International standards: ISO, ETSI, and industry bodies

Regulatory instruments reference "leading practices and standards" without always naming specific bodies. Enterprise compliance officers need a map of the international standards landscape and its relationship to NIST FIPS 203–205.

**ISO/IEC JTC 1 SC 27** develops information security standards including cryptographic mechanisms. Work items incorporate ML-KEM and ML-DSA into ISO/IEC 18033 (encryption) and ISO/IEC 14888 (signatures). ISO/IEC 27001:2022 Annex A control 8.24 (Use of cryptography) requires cryptographic controls consistent with organisational policies. An ISO 27001-certified organisation whose cryptography policy does not address PQC migration faces a surveillance audit gap after FIPS finalisation.

**ETSI** develops telecommunications and PKI standards referenced by EU regulators. ETSI TR 103 619 addresses quantum-safe cryptography for telecommunications infrastructure. Financial entities operating private MPLS or dedicated WAN should monitor ETSI guidance for protocol-level PQC requirements.

**IETF** specifies protocol-level PQC deployment through CFRG and TLS working groups. Hybrid TLS constructions are the operational deployment format for ML-KEM in web and API contexts. Enterprise policies should reference IETF standards-track specifications, not proprietary implementations.

| Body | Relevance |
|------|-----------|
| PCI SSC | Evolving cryptographic requirements for card data environments |
| SWIFT | Customer security programme for financial messaging |
| GSMA | Mobile network operator security affecting IoT authentication |
| IEC 62443 | Industrial automation and control system security (OT) |

Include industry body publications in this matrix where they create binding or quasi-binding obligations.

### C.5.2 Insurance, contractual, and litigation risk

**Cyber insurance:** Underwriters include cryptography and quantum readiness questions in renewal applications. Documented PQC programmes demonstrate risk management maturity; absence demonstrates the opposite.

**Contractual obligations:** Security exhibits, DPAs requiring state-of-the-art encryption, supply chain CBOM clauses, and government flow-downs (CNSA 2.0, FedRAMP) create obligations independent of primary legislation. Procurement integration (Chapter 16) addresses these systematically.

**Litigation and duty of care:** Documented threat assessment and migration planning support a reasonable-care defence for long-retention data exposed to HNDL risk. Programme chartering serves duty-of-care objectives independent of regulatory deadlines. General Counsel and regulatory affairs should link charter approval to litigation risk memos where long-retention data and HNDL exposure are material (Chapter 3; Meridian teaching narrative).

---

## C.6 Matrix Maintenance Cadence

| Activity | Owner | Cadence |
|----------|-------|---------|
| Regulatory horizon scan | Regulatory affairs / DPO | Quarterly |
| Matrix cell evidence link validation | Compliance | Quarterly |
| New instrument integration | Legal + CISO | On publication |
| Examination / assessment pack refresh | Programme office | Pre-examination |
| Sector overlay alignment | Enterprise architect | Annual |

---

*Proceed to Appendix D: Migration Programme Charter Template.*

---

*Appendix C — References*

- Commission Delegated Regulation (EU) 2024/1532 supplementing DORA (ICT risk management RTS).
- European Parliament and Council. (2022). Regulation (EU) 2022/2554 (DORA). *Official Journal of the European Union*.
- European Parliament and Council. (2022). Directive (EU) 2022/2555 (NIS2). *Official Journal of the European Union*.
- European Parliament and Council. (2016). Regulation (EU) 2016/679 (GDPR). *Official Journal of the European Union*.
- European Telecommunications Standards Institute. (ongoing). TR 103 619 series (quantum-safe cryptography).
- International Organization for Standardization / IEC. (2022). ISO/IEC 27001:2022.
- Internet Engineering Task Force. (ongoing). CFRG and TLS working group PQC specifications.
- Payment Card Industry Security Standards Council. (2024). PCI DSS v4.0.
- National Institute of Standards and Technology. (2020). NIST SP 800-53 Rev. 5.
- North American Electric Reliability Corporation. (2024–2026). CIP standards series.
