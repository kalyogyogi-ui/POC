# Appendix E
# Glossary and Standards Quick Reference

---

Quick-reference tables for terms and standards used throughout this handbook. Definitions are **programme-oriented** — not mathematical specifications. Consult FIPS and IETF documents for normative algorithm and protocol detail.

---

## E.1 Glossary

| Term | Definition |
|------|------------|
| **ARCS Framework** | Awareness → Register → Capability → Synchronize — four enterprise capabilities for PQC migration (Chapter 1). Part VI sector playbooks deliver programme *proof*: validated outcomes under sector constraints (Chapter 22). |
| **Blocking node** | CDG vertex whose migration must complete before dependents can adopt PQC (Chapter 8). |
| **CBOM** | Cryptographic Bill of Materials — inventory of cryptographic components with programme attributes (Chapter 7). |
| **CDG** | Cryptographic Dependency Graph — directed graph of cryptographic relationships and trust (Chapter 8). |
| **CNSA 2.0** | NSA Commercial National Security Algorithm Suite 2.0 — binding NSS algorithm policy (Chapter 20). |
| **CMVP** | Cryptographic Module Validation Program — NIST/CCCS FIPS 140-3 module validation (Chapter 18). |
| **CRQC** | Cryptographically Relevant Quantum Computer — quantum machine capable of breaking deployed public-key cryptography. |
| **CUI** | Controlled Unclassified Information — US federal information requiring protection per NIST SP 800-171. |
| **DORA** | Digital Operational Resilience Act — EU Regulation 2022/2554 for financial entities (Chapter 3). |
| **FN-DSA** | FALCON — NIST additional PQC signature candidate under standardisation (Chapter 22 contingency). |
| **FIPS 140-3** | US standard for cryptographic module security requirements (Chapter 18). |
| **Governance Stack** | Five-layer model: Strategic, Programme, Policy, Operational, Assurance (Chapter 3). |
| **HLM** | Hybrid Lifecycle Model — H1 Protective Hybrid, H2 Transitional Hybrid, H3 PQC-Native (Chapter 5). |
| **HNDL** | Harvest Now, Decrypt Later — threat model recording ciphertext for future decryption (Chapter 2). |
| **HQC** | Hamming Quasi-Cyclic — NIST additional PQC KEM candidate under standardisation (Chapter 22). |
| **ML-DSA** | Module-Lattice-Based Digital Signature Algorithm — FIPS 204. |
| **ML-KEM** | Module-Lattice-Based Key-Encapsulation Mechanism — FIPS 203. |
| **MPI** | Migration Priority Index — TRADE-weighted prioritisation score (Chapter 9). |
| **NSS** | National Security System — US systems under CNSSP 15 policy. |
| **PQ-ADAPT** | Post-Quantum ADAPTation maturity model — Levels 0–5 from Unaware to Quantum-Resilient. |
| **PQC** | Post-Quantum Cryptography — cryptography resistant to quantum adversaries. |
| **SBOM** | Software Bill of Materials — software component inventory; CBOM extends for cryptography. |
| **SLH-DSA** | Stateless Hash-Based Digital Signature Algorithm — FIPS 205. |
| **SOM** | Sector Overlay Matrix — TRADE weight and timeline modifiers by industry (Chapters 9, 19–21). |
| **SSDF** | NIST Secure Software Development Framework — supply chain practices (Chapter 17). |
| **TES** | Threat Exposure Score — TRADE Threat dimension input (Chapter 2). |
| **TRADE** | Threat, Regulatory, Architectural dependency, Data longevity, Ecosystem — prioritisation engine (Chapters 2, 9). |
| **Proof (programme)** | Part VI outcome phase — sector playbooks, examination results, and sustained resilience evidence (Chapters 19–22). |

---

## E.2 Algorithm Quick Reference

| Algorithm (FIPS) | Type | Typical use | Quantum-resistant | Notes |
|------------------|------|-------------|-------------------|-------|
| **ML-KEM-512** | KEM | Key establishment | Yes | Smaller parameters; limited use cases |
| **ML-KEM-768** | KEM | TLS, VPN, general | Yes | Common enterprise default |
| **ML-KEM-1024** | KEM | NSS / high assurance | Yes | CNSA preferred parameter set |
| **ML-DSA-44** | Signature | General signing | Yes | Smaller signatures |
| **ML-DSA-65** | Signature | Code signing, certs | Yes | Common enterprise default |
| **ML-DSA-87** | Signature | NSS / high assurance | Yes | CNSA preferred |
| **SLH-DSA** | Signature | Firmware, long-term trust | Yes | Larger signatures; stateless hash-based |
| **LMS / XMSS** | Stateful signature | Firmware (SP 800-208) | Yes | Stateful — careful key management |
| **RSA-2048+** | Signature / KEM | Legacy | **No** | Disallowance horizon per IR 8547 |
| **ECDSA P-256+** | Signature | Legacy | **No** | Disallowance horizon per IR 8547 |
| **ECDHE / DH** | Key exchange | Legacy TLS | **No** | Hybrid transition path via HLM |

---

## E.3 Standards and Documents Quick Reference

| Document | Issuer | Role in programme |
|----------|--------|-------------------|
| **FIPS 203** | NIST | ML-KEM specification |
| **FIPS 204** | NIST | ML-DSA specification |
| **FIPS 205** | NIST | SLH-DSA specification |
| **FIPS 140-3** | NIST | Cryptographic module validation |
| **NIST IR 8547** | NIST | Transition timelines (IPD at time of writing) |
| **NIST SP 800-208** | NIST | Stateful hash-based signatures |
| **NIST SP 800-53** | NIST | US federal security controls |
| **NIST SP 800-171** | NIST | CUI protection (CMMC basis) |
| **NIST SP 800-218** | NIST | SSDF supply chain |
| **CNSA 2.0** | NSA | NSS algorithm policy |
| **DORA + RTS 2024/1532** | EU | Financial ICT risk and crypto policy |
| **NIS2** | EU | Essential entity cybersecurity |
| **GDPR** | EU | Personal data security (Art. 32) |
| **PCI DSS v4.0** | PCI SSC | Payment card cryptography |
| **CycloneDX CBOM** | OWASP | Machine-readable CBOM format |
| **IETF hybrid TLS** | IETF | Protocol-level hybrid deployment |

---

## E.4 HLM Phase Quick Reference

| Phase | Name | Objective | Exit signal |
|-------|------|-----------|-------------|
| **H1** | Protective Hybrid | Add PQC alongside classical | Ecosystem threshold met |
| **H2** | Transitional Hybrid | Reduce classical dependency | Classical deprecated in policy |
| **H3** | PQC-Native | Remove quantum-vulnerable PKC | CBOM confirms zero disallowed algorithms |

---

## E.5 PQ-ADAPT Level Quick Reference

| Level | Name | One-line criterion |
|-------|------|-------------------|
| **0** | Unaware | No quantum risk in risk register |
| **1** | Alerted | Executive awareness; no charter |
| **2** | Inventoried | CBOM baseline; CDG started |
| **3** | Architected | Agility standards; wave plan approved |
| **4** | Transitioning | Production hybrids under governance |
| **5** | Quantum-Resilient | Disallowance compliance; continuous capability |

---

## E.6 Programme Artefact Index

| Artefact | Primary appendix / chapter |
|----------|---------------------------|
| CBOM schema and export | Appendix A; Chapter 7 |
| CDG templates | Appendix A; Chapter 8 |
| PQ-ADAPT assessment | Appendix B; Chapter 22 |
| Regulatory overlay matrix | Appendix C; Chapter 3 |
| Programme charter | Appendix D; Chapter 15 |
| Contract clause library | Chapter 16 Table 16.1 |
| Vendor evidence checklist | Chapter 16 Table 16.2 |
| Validation test matrix | Chapter 18 Table 18.2 |
| Sector overlays | Chapters 19–21 |

---

*End of appendices. Return to manuscript overview: `manuscript/README.md`.*

---

*Appendix E — References*

- National Institute of Standards and Technology. (2024). FIPS 203, 204, 205. U.S. Department of Commerce.
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft).
- Post-Quantum Cryptography Enterprise Migration Handbook. (2026). Full manuscript Parts I–VI.
