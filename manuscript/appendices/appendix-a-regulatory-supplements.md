# Appendix A
# Regulatory Supplements
## International Standards, Insurance, and Contractual Risk

---

This appendix supports Chapter 3. It provides reference depth on international standards bodies, cyber insurance, and contractual risk — material that informs regulatory programme design but exceeds the scope of a single chapter.

---

## A.1 International Standards: ISO, ETSI, and Industry Bodies

Regulatory instruments reference "leading practices and standards" without always naming specific bodies. Enterprise compliance officers need a map of the international standards landscape and its relationship to NIST FIPS 203–205.

### ISO/IEC JTC 1 SC 27

ISO/IEC JTC 1 Subcommittee 27 develops information security standards including cryptographic mechanisms. Work items are underway to incorporate ML-KEM and ML-DSA into ISO/IEC standards, aligning international normative references with NIST selections. Enterprises whose policies reference ISO/IEC 18033 (encryption algorithms) or ISO/IEC 14888 (digital signatures) should monitor SC 27 publications for PQC updates.

ISO/IEC 27001:2022 Annex A control 8.24 (Use of cryptography) requires cryptographic controls consistent with organisational policies. An ISO 27001-certified organisation whose cryptography policy does not address PQC migration faces a surveillance audit gap after FIPS finalisation.

### ETSI

The European Telecommunications Standards Institute develops standards for telecommunications and PKI that EU regulators reference. ETSI TR 103 619 and related work items address quantum-safe cryptography for telecommunications infrastructure. Financial entities operating private telecommunications infrastructure (MPLS networks, dedicated WAN) should monitor ETSI guidance for protocol-level PQC requirements that may precede broader NIST IR 8547 timelines.

### IETF

The Internet Engineering Task Force specifies protocol-level PQC deployment through working groups including CFRG (Cryptographic Forum Research Group) and TLS working group extensions. Hybrid TLS constructions specified in IETF documents are the operational deployment format for ML-KEM in web and API contexts. Enterprise policies should reference IETF standards-track specifications for hybrid deployment, not proprietary implementations.

### Industry-specific bodies

| Body | Relevance |
|------|-----------|
| PCI SSC | Evolving cryptographic requirements for card data environments |
| SWIFT | Customer security programme requirements for financial messaging |
| GSMA | Mobile network operator security requirements affecting IoT and SIM-based authentication |
| IEC 62443 | Industrial automation and control system security (OT environments) |

Each body publishes on independent timelines. The regulatory overlay matrix (Appendix C) should include industry body publications where they create binding or quasi-binding obligations for the enterprise's sector.

---

## A.2 Insurance, Contractual, and Litigation Risk

Regulatory compliance is not the only driver for documented PQC programmes. Insurance, contractual, and litigation contexts create additional incentives.

### Cyber insurance

Cyber insurance underwriters are beginning to include cryptography and quantum readiness questions in renewal applications. Questions typically ask whether the organisation has conducted cryptographic inventory, whether a PQC migration plan exists, and whether long-retention data is protected by quantum-vulnerable algorithms. Organisations that cannot answer affirmatively may face premium increases, coverage exclusions for quantum-related losses, or renewal denial.

The insurance market's treatment of quantum risk is evolving. Documented PQC programmes — even incomplete ones — demonstrate risk management maturity that underwriters reward. Absence of any programme demonstrates the opposite.

### Contractual obligations

Enterprise contracts increasingly include:

- Security exhibit requirements referencing NIST standards
- Data processing agreements requiring state-of-the-art encryption
- Supply chain security clauses requiring cryptographic inventory (CBOM/SBOM)
- Government contract flow-downs referencing CNSA 2.0 or FedRAMP requirements

Meridian Mutual Bank's review of its top fifty vendor contracts identified twelve with encryption language that would be difficult to satisfy after NIST IR 8547 disallowance without migration. Three contracts required immediate renegotiation. Procurement integration (Chapter 16) addresses this systematically.

### Litigation and duty of care

As of this writing, no major litigation has established quantum-related duty of care in published court decisions. The legal theory is nonetheless straightforward: organisations that knew or should have known of quantum threat to long-retention data, and that failed to take reasonable migration steps, may face negligence claims when breaches occur. Documented threat assessment and migration planning support a reasonable-care defence. Absence of documentation does not.

General Counsel Thomas Bergström's contribution to Meridian's programme included a litigation risk memo recommending programme chartering as a duty-of-care measure — independent of regulatory deadline pressure.

---

*Appendix A — References*

- European Telecommunications Standards Institute. (ongoing). TR 103 619 series (quantum-safe cryptography).
- International Organization for Standardization / IEC. (2022). ISO/IEC 27001:2022.
- Internet Engineering Task Force. (ongoing). CFRG and TLS working group PQC specifications.
