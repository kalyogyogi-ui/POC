# Chapter 18
# FIPS Validation, Testing, and Assurance

---

Apex Defense Technologies' CMMC Level 2 assessment was scheduled for October 2028. Dr. Priya Nair's assurance team received the C3PAO evidence request list in March — ninety-two control objectives, each demanding artefacts that traced policy to implementation. The assessor's cryptographic control family questions looked familiar: *Are encryption mechanisms FIPS-validated where required? Is key management documented? Are cryptographic modules configured per vendor security guidance?*

What the assessor did not ask — but what Priya knew would surface in follow-up interviews — was whether Apex could **demonstrate post-quantum readiness** without violating FIPS boundaries. Commercial IT had deployed hybrid TLS in development using OpenSSL 3.5. NSS programmes waited on HSM module revalidation. A product manager had circulated a slide claiming "full PQC support" based on laboratory builds that sat outside the validated module boundary. The CMMC package would either reconcile those layers honestly or produce a finding that blocked contract renewal.

Priya's team spent six weeks assembling not a folder of certificates, but an **assurance programme**: validation coverage matrices linked to CDG blocking nodes, test harness artefacts from Chapter 10's agility standard, HSM assessment scores from Chapter 14, and a dependency timeline showing which production paths were gated on CMVP listings versus which were legitimately lab-only. The C3PAO assessor marked cryptographic controls **MET** with one observation: accelerate closure of the ML-DSA module gap on the payment-adjacent signing partition. The observation was expected, documented, and already on the steering committee risk register.

This chapter teaches enterprises to build the same assurance machinery — not as a pre-audit scramble, but as **programme-integrated validation and testing** that satisfies CMMC, FedRAMP, DORA, and internal risk committees simultaneously.

---

## 18.1 Assurance as a Programme Constraint

Parts I through IV established *why* to migrate, *what* algorithms to standardise on, *where* cryptography lives in the estate, and *how* to architect agility and key custody. Part V (Chapters 15–17) governs who runs the programme, how procurement enforces requirements, and how supply-chain gates verify dependencies. Chapter 18 completes the **Assurance layer** of the PQC Governance Stack (Chapter 3): the evidence machinery that proves migration progress is real, controlled, and auditable.

The central argument:

> **Validation is a programme constraint, not a post-deployment checkbox.** FIPS 140-3 module transitions, interoperability suites, performance baselines, and security assessments must be planned on the same dependency timeline as HSM firmware, PKI overlap, and vendor roadmaps — because production deployment in regulated paths cannot proceed without them.

Three misconceptions cause assurance programme failure:

| Misconception | Reality |
|---------------|---------|
| "Algorithm in library = production-ready" | Regulated paths require CMVP-listed module implementations |
| "We will validate after the pilot succeeds" | Pilots that bypass validation boundaries cannot promote without retest |
| "Assurance is InfoSec's job before audit season" | Crypto assurance spans engineering, operations, procurement, and compliance year-round |

**PQ-ADAPT Level 4 (*Transitioning*)** requires an active validation programme: production hybrids where policy permits, supplier contracts updated, and **evidence that testing gates precede production promotion**. Enterprises with architecture standards but no assurance integration remain at Level 3 — they know what to build but cannot prove it safely reached production.

> **Migration Moment**
>
> *"Our OpenSSL build supports ML-KEM — we are PQC-ready for CMMC."*
>
> CMMC and FedRAMP evaluate whether production cryptographic modules operate inside **validated boundaries** with documented configuration. Development builds, container images without module attestation, and cloud regions without FIPS endpoints do not satisfy controlled unclassified information (CUI) protection requirements — regardless of algorithm availability in upstream source code.

---

## 18.2 FIPS 140-3 Module Validation versus Algorithm Validation

Enterprise teams routinely conflate **algorithm standardisation** (FIPS 203–205) with **module validation** (FIPS 140-3). The distinction governs every production gate in regulated environments.

### 18.2.1 What each layer provides

| Layer | Document | What it certifies | What it does not certify |
|-------|----------|-------------------|--------------------------|
| **Algorithm** | FIPS 203, 204, 205 | Mathematical specification of ML-KEM, ML-DSA, SLH-DSA | Your vendor's implementation quality |
| **Module** | FIPS 140-3 | A bounded cryptographic module meets security requirements at a given level | Enterprise configuration, key ceremony, or protocol use |
| **Protocol** | IETF RFCs, SP 800-series | On-the-wire interoperability conventions | Module validation status |
| **Enterprise policy** | Internal standards | Which algorithms apply to which workload class | Automatic compliance |

**FIPS 140-3** defines security requirements for cryptographic modules — hardware, software, firmware, or hybrid — at levels 1 through 4. The **Cryptographic Module Validation Program (CMVP)**, operated by NIST and the Canadian Centre for Cyber Security, issues validation certificates for modules that pass accredited laboratory testing.

An enterprise does not "get FIPS validated." A **vendor module** — payShield HSM firmware, cloud KMS HSM pool, OpenSSL FIPS provider boundary, Java FIPS security provider — receives a certificate listing **approved algorithms and modes** inside the module boundary. Enterprise architects must verify:

1. **Certificate number** — current, not superseded
2. **Module boundary** — which software and hardware are inside the validated configuration
3. **Algorithm implementation list** — ML-KEM-768 listed explicitly, not inferred from "lattice support"
4. **Operational environment** — OS, firmware, and hardware versions matching the certificate
5. **Entropy and key management** — how the module meets key generation requirements for PQC key sizes

### 18.2.2 Module boundary discipline

The **module boundary** is the assurance team's most important concept. Operations inside the boundary are evaluated by CMVP. Operations outside are enterprise responsibility — and audit findings when they touch production data.

```
┌─────────────────────────────────────────────────────────────┐
│                  FIPS 140-3 MODULE BOUNDARY                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ ML-KEM      │  │ ML-DSA      │  │ Key generation,     │  │
│  │ implement.  │  │ implement.  │  │ zeroise, self-test  │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
         ▲                                    │
         │ validated                          │ NOT validated
         │                                    v
   [HSM firmware / FIPS provider]      [Application TLS config,
                                        load balancer policy,
                                        custom key ceremony scripts]
```

Meridian Mutual Bank discovered that its cloud provider's **FIPS endpoint** covered KMS wrap operations but not the application server's default TLS stack — two module boundaries, one procurement slide. Chapter 14's HSM assessment matrix (Table 14.1) exists precisely to prevent this confusion: each custody platform receives a row with explicit **in-boundary algorithm list**.

### 18.2.3 Algorithm validation (CAVP) relationship

NIST's **Cryptographic Algorithm Validation Program (CAVP)** certifies that implementations produce correct outputs for known answer tests (KATs). CAVP algorithm certificates are **inputs to** module validation — not substitutes for it.

| Evidence type | Proves | Typical consumer |
|---------------|--------|------------------|
| CAVP certificate | Implementation matches test vectors | Module lab during FIPS 140-3 testing |
| FIPS 140-3 certificate | Module meets physical/logical security requirements | Enterprise procurement, CMMC assessors |
| Vendor "FIPS-compliant" marketing | Often undefined | Should not appear in evidence packages |

**Architect's Decision**

**Require CMVP certificate numbers in procurement and evidence packages — not CAVP alone, not algorithm support claims.** When a vendor cites CAVP for ML-DSA, the correct follow-up question is: *In which FIPS 140-3 module, at what level, on which firmware version, is that implementation listed?*

### 18.2.4 Transition from FIPS 140-2 modules

PQC migration often requires **new FIPS 140-3 validations** — firmware upgrades, software provider changes, and cloud KMS algorithm additions each alter the operational environment and trigger retest. Apex maintained a **module transition register** linking classical certificates, target PQC certificates, and decommission dates — feeding the validation dependency timeline (§18.14).

---

## 18.3 The Validation Coverage Matrix

Chapter 4 introduced the **validation coverage matrix** as the Operational-layer companion to the algorithm standards matrix. Chapter 18 operationalises it as a **living assurance artefact** — updated quarterly, linked to CDG blocking nodes, and cited in audit packages.

### 18.3.1 Matrix structure

**Table 18.1 — Validation Coverage Matrix (Extended)**

| Field | Description | Example |
|-------|-------------|---------|
| `system_class` | Workload category from algorithm matrix | Payment HSM firmware signing |
| `validation_required` | Policy mandate | FIPS 140-3 Level 3 |
| `module_product` | Vendor module identifier | payShield 10K firmware 4.2 |
| `cmvp_cert_id` | Certificate number | #4747 (*illustrative*) |
| `algorithms_in_boundary` | Explicit list | ML-DSA-87, ECDSA-P384 (H1) |
| `operational_environment` | Approved OS/firmware combo | RHEL 8.8 + firmware 4.2.1 |
| `gap_status` | Open / Closed / N/A | Open |
| `hlm_phase_authorised` | Highest phase permitted | H0 (classical only) until gap closes |
| `cdg_blocking_ref` | Link to dependency graph | BN-MER-HSM-001 |
| `test_harness_profile` | Agility profile IDs gated | `mer-firmware-sign-v2` |
| `evidence_owner` | Role accountable | Crypto operations lead |
| `next_review_date` | Quarterly cycle | 2028-06-30 |

### 18.3.2 Gap status rules

| Status | Definition | Production rule |
|--------|------------|-----------------|
| **Closed** | CMVP cert lists required algorithms in approved environment | H1+ authorised per policy |
| **Open** | Algorithm required but not in validated boundary | No production PQC in this path; lab only |
| **Interim** | Dual validation: classical closed, PQC pending | H1 dual-signature with classical primary |
| **N/A** | Policy does not require validation (dev/lab) | No production data |

Meridian's matrix prevented the failure mode described in Chapter 4 §4.21: engineering teams demoing OpenSSL PQC in paths that payment policy required HSM validation for. The matrix was published internally alongside the algorithm standards matrix — engineers mapped systems to rows before architecture review.

### 18.3.3 Cross-organisation matrix variants

| Organisation | Matrix emphasis |
|--------------|-----------------|
| **Meridian** | DORA-critical functions; payment HSM; EU cloud regions |
| **Apex** | NSS vs corporate partitions; STIG-approved module list |
| **GlobalSync** | Per-cloud-region KMS modules; tenant BYOK boundaries |
| **Northfield** | OT vendor-held modules; contractual validation flow-down |

GlobalSync extended the matrix with **`tenant_assurance_tier`** — linking validation requirements to customer contract tiers (§18.15).

> **Dependency Alert**
>
> **A closed gap on the corporate HSM row does not close gaps on the payment HSM row.** Validation is per module, per operational environment. CDG fan-in from a single blocking node (Meridian's firmware signing chain) can hold dozens of dependent systems on one open matrix row. Assure the blocking node first; do not aggregate status across unrelated modules.

---

## 18.4 The Test Category Matrix

Validation certificates prove module integrity. **Enterprise testing** proves the estate operates correctly under policy. Chapter 18 defines four test categories — functional, interoperability, performance, and security — each with distinct owners, environments, and evidence artefacts.

**Table 18.2 — Test Category Matrix**

| Category | Primary question | Environment | Owner | Gate type |
|----------|------------------|-------------|-------|-----------|
| **Functional** | Does the system perform crypto operations correctly per policy profile? | CI, lab, pre-prod | Crypto engineering | SDLC merge gate |
| **Interoperability** | Do peers agree on algorithms, formats, and certificate chains? | Staging, partner testbed | Integration / partner engineering | Wave promotion gate |
| **Performance** | Do PQC sizes and latency meet SLOs under load? | Performance lab, canary | Performance engineering | Capacity gate |
| **Security** | Can adversaries break, downgrade, or misuse crypto controls? | Pen test, red team, fuzz | Security assurance | Release / annual gate |

### 18.4.1 Functional testing

Functional testing verifies **correctness** — the right algorithm, parameter set, and key handle produce expected outputs. It is the operational expression of Chapter 10's enterprise test harness.

| Test type | Scope | Evidence artefact |
|-----------|-------|-------------------|
| Profile round-trip | Sign/verify, encaps/decaps per policy profile | Harness JSON report |
| Module path verification | Production profile uses FIPS provider not default | Config audit + harness |
| Key lifecycle | Generate, wrap, rotate in HSM partition | Ceremony log + harness |
| Regression on substitution | Config-only algorithm change passes | Substitution drill record |
| Negative tests | Reject disallowed algorithms at negotiation | Harness failure-injection log |

**GlobalSync** ran functional tests on every merge to `main` for in-scope services — twelve-minute pipeline stage. **Meridian** required functional harness pass attached to DORA change tickets for ICT systems supporting critical functions.

Functional tests use **NIST CAVP test vectors** where available, plus enterprise-generated vectors for integration-specific formats (CMS profiles, custom firmware envelopes).

### 18.4.2 Interoperability testing

Interoperability testing verifies **agreement between parties** — TLS handshakes with partners, certificate chain acceptance, firmware signature verification on devices, API gateway cipher negotiation.

| Test type | Scope | Typical failure |
|-----------|-------|-----------------|
| Partner TLS matrix | N partner profiles × M local profiles | Handshake size limit exceeded |
| PKI chain walk | ML-DSA cert to trust anchor | Unknown critical extension |
| Firmware dual-sign | Terminal fleet verifies both signatures | Legacy device rejects PQC |
| Cross-cloud KMS | Wrap in region A, unwrap in region B | Different module certificates |
| Email S/MIME | Hybrid CMS with external recipient | Client downgrade |

Chapter 12's protocol transition guidance and Chapter 13's PKI overlap strategy define **what** to test. Chapter 18 defines **how to evidence** it: partner test logs, signed interoperability statements, and versioned test matrices stored in the GRC repository.

Apex required **bilateral interoperability packets** for each federal integrator — signed PDF listing tested algorithm combinations, module certificate IDs, and test dates. Integrators reused packets across subcontracts, reducing repeated test cycles.

### 18.4.3 Performance testing

PQC increases handshake sizes, signature bytes, and CPU cost. Performance testing verifies **operational acceptability** under realistic load — not micro-benchmark optimism.

| Metric | Typical threshold approach | Owner |
|--------|---------------------------|-------|
| TLS handshake p99 latency | ≤ baseline + 30% for H1 hybrid | Platform SRE |
| ML-DSA signing throughput | ≥ minimum batch window TPS | Crypto operations |
| HSM partition capacity | Object count within 80% limit | HSM admin |
| API payload size | Below gateway limits with PQC certs | API architecture |
| Terminal firmware verify time | Within boot window SLA | OT engineering |

GlobalSync set **warning thresholds** at 25% latency regression (Chapter 10); performance tests in staging triggered architecture decision records before production. Meridian's payment path required **HSM throughput proof** on target firmware before dual-signature H1 — vendor lab report plus internal confirmation.

Performance testing is not a one-time gate. **Annual re-baseline** captures firmware drift, traffic growth, and certificate size changes as ML-DSA chains deepen.

### 18.4.4 Security testing

Security testing verifies **resilience against adversarial behaviour** — downgrade attacks, misconfiguration exploitation, key extraction attempts, and protocol confusion. It encompasses penetration testing, red team exercises, and cryptographic fuzzing.

| Test type | Scope | Differs from functional how? |
|-----------|-------|-------------------------------|
| Penetration test | External attack surface | Adversary methodology, chained exploits |
| Red team | Objective-based campaign | Tests detection and response, not just config |
| Crypto fuzzing | Parser and negotiation code | Malformed inputs, edge cases |
| Downgrade simulation | Force classical-only when policy requires hybrid | Policy enforcement verification |
| Key custody attack | KMS IAM, HSM access controls | No key extraction success |

Section 18.10 develops security testing and red team considerations for cryptography specifically.

### 18.4.5 Test category integration matrix

**Table 18.3 — Test Category × Programme Phase**

| Programme phase | Functional | Interoperability | Performance | Security |
|-----------------|------------|------------------|-------------|----------|
| Lab / pilot | Required | Selective partners | Baseline | Optional fuzz |
| Pre-production | Required | Full partner matrix | Load test | Pen test scope |
| Production H1 | Continuous CI | Partner re-test on change | Canary monitoring | Annual pen test |
| Production H2/H3 | Continuous CI | Chain migration tests | Re-baseline | Red team cycle |
| Regulatory examination | Evidence export | Signed partner statements | Capacity reports | Findings remediation |

---

## 18.5 Building the Validation Programme Plan

Assurance requires a **programme plan** — not ad hoc test activity. The plan links validation matrices, test categories, owners, and calendar to wave milestones.

### 18.5.1 Plan components

| Component | Contents |
|-----------|----------|
| **Scope statement** | System classes, regions, classification zones in scope |
| **Validation register** | All CMVP certificates with expiry and succession |
| **Test strategy** | Category matrix per wave; environments; tooling |
| **Harness integration** | CI gates, profile manifest, artefact storage (Chapter 10) |
| **Partner test programme** | Bilateral schedules, escalation for blocking partners |
| **Security assessment calendar** | Pen test, red team, fuzz cadence |
| **Evidence repository** | GRC system structure, retention, integrity controls |
| **RACI** | Crypto engineering, assurance, operations, compliance |
| **Dependency timeline** | Figure 18.1 — validation gates on CDG critical path |
| **Escalation** | Open matrix gaps > 90 days → steering committee |

### 18.5.2 Integration with programme governance

Chapter 15's steering committee receives **quarterly assurance dashboards**:

| KPI | Target (illustrative) |
|-----|----------------------|
| Open validation gaps (production-critical) | Trending down; zero surprise opens |
| Harness coverage (% in-scope services) | ≥ 95% Wave 1+ |
| Interop test freshness | < 180 days for Tier 1 partners |
| Pen test crypto findings open | Zero critical > 30 days |
| Evidence artefact completeness | 100% for regulated paths |

Assurance KPIs feed the same dashboard as wave burn-down (Chapter 9) — preventing assurance from becoming a parallel reporting silo Priya's team almost created before consolidation under the PQC programme office.

---

## 18.6 CMMC Cryptographic Assurance Context

**Cybersecurity Maturity Model Certification (CMMC)** assesses defence contractors' implementation of NIST SP 800-171 and, for Level 3, SP 800-172 controls. Cryptographic controls appear across access control, identification and authentication, system and communications protection, and media protection families.

### 18.6.1 What CMMC assessors evaluate

CMMC assessors do not ask "Are you post-quantum?" in 2028 — they ask whether **current cryptographic controls** meet documented policy. After FIPS 203–205 publication and CNSA 2.0 influence, assessors increasingly expect **PQC planning evidence** for enterprises claiming state-of-the-art practice.

| Control theme | Typical assessor question | PQC-relevant evidence |
|---------------|---------------------------|----------------------|
| Encryption in transit | TLS configuration standard? | Hybrid policy; cipher suite baseline |
| Encryption at rest | FIPS-validated modules? | CMVP certs; KMS configuration |
| Key management | Key generation, storage, rotation documented? | Ceremony logs; HSM partition policy |
| Cryptographic module use | FIPS 140 validated where required? | Validation matrix; gap remediation plan |
| System hardening | STIG or vendor guidance applied? | HSM STIG checklist; firmware version proof |

### 18.6.2 CUI boundary and module discipline

**Controlled Unclassified Information (CUI)** environments require FIPS-validated encryption for data at rest and in transit unless exempted by authorisation. Apex's CMMC boundary encompassed engineering document repositories, export-controlled technical data, and programme management systems — not the classified NSS enclave, which falls under separate accreditation.

The assurance mistake Apex avoided: deploying PQC in the CUI boundary **before** module validation completed. Instead, Apex documented:

1. **Current state** — FIPS 140-2/140-3 classical modules, MET
2. **Target state** — CNSA 2.0 algorithm suite in validated modules
3. **Gap** — ML-DSA module pending; matrix row open
4. **Compensating controls** — No CUI data in lab PQC paths; network segmentation
5. **Timeline** — Validation dependency timeline with contract milestones

Assessors accept **honest gaps with credible plans** more readily than false production claims.

### 18.6.3 CMMC Level 2 versus Level 3 assurance depth

| Level | Assurance expectation | PQC programme implication |
|-------|----------------------|----------------------------|
| Level 2 | Documented practices; C3PAO assessment | Validation matrix; test harness for CUI paths |
| Level 3 | Expert-led assessment; heightened controls | Deeper key custody evidence; supply-chain crypto (Chapter 17) |

Apex's Level 2 assessment covered corporate CUI.environments. NSS programmes maintained **separate accreditation packages** — evidence structures similar but assessor communities different. Priya's team used a **shared evidence taxonomy** with zone-specific folders to prevent corporate CMMC artefacts from contaminating classified packages.

> **Regulatory Lens**
>
> **CMMC assessors evaluate documented implementation, not roadmap ambition.** A PQC strategy slide without validation matrix, test results, and configuration baseline produces findings under configuration management and media protection controls. Apex's MET rating reflected *current* FIPS compliance plus *documented* transition — not premature PQC production claims.

---

## 18.7 FedRAMP Cryptographic Assurance Context

**FedRAMP** authorises cloud services for federal agency use. Cryptographic controls derive from NIST SP 800-53 — notably SC-12 (cryptographic key establishment and management), SC-13 (cryptographic protection), and related controls.

### 18.7.1 FedRAMP and FIPS 140-3

FedRAMP authorisation packages document **FIPS 140-3 validated modules** used by the cloud service offering. Federal customers inherit provider validation for platform cryptography; **customer responsibility** remains for configuration, key custody, and application-layer crypto.

| Responsibility | Provider | Customer (agency or contractor) |
|----------------|----------|--------------------------------|
| Underlying KMS/HSM module | Validates and documents | Selects FIPS endpoints |
| TLS termination on IaaS/PaaS | Documents supported ciphers | Configures policy |
| Application crypto | — | Validates own modules or uses provider APIs |
| Key rotation | Provides capability | Executes rotation policy |
| PQC roadmap | Publishes engineering plans | Maps to authorisation change |

GlobalSync pursued FedRAMP authorisation for its **US sovereign region** — a programme distinct from EU GDPR operations. The authorisation package required **algorithm inventory** inside the FIPS boundary and a **transition plan** aligned to NIST IR 8547. GlobalSync's validation matrix included `fedramp_boundary` tags linking each module to authorisation package sections.

### 18.7.2 Authorisation change triggers

PQC module upgrades are FedRAMP **significant changes** — requiring reassessment, updated crypto tables, and agency notification. Apex tracked **provider crypto change notifications** in its assurance calendar, feeding impact assessment when cloud modules gained PQC algorithms.

### 18.7.3 Contractor flow-down

Defence contractors using FedRAMP-authorized cloud for CUI must trace **flow-down requirements** from DFARS, CMMC, and agency-specific clauses. The evidence chain:

```
Agency mission need → FedRAMP auth package → Provider crypto table →
Customer responsibility matrix → Apex validation matrix → System config baseline
```

Breaks in this chain — using non-FIPS endpoints for CUI because they supported a pilot algorithm — produce assessment findings. Chapter 16's contractual clauses operationalise flow-down; Chapter 18 evidences compliance.

---

## 18.8 DORA, NIS2, and EU Assurance Expectations

European regulated entities face **outcome-based** cryptographic assurance — DORA and NIS2 do not mandate FIPS or CMVP by name, but require state-of-the-art technical measures and ICT risk management testing.

### 18.8.1 DORA testing and evidence

DORA (Regulation 2022/2554) and RTS 2024/1532 require financial entities to maintain encryption policies responsive to cryptanalytic developments and to **test ICT systems** supporting critical or important functions.

| DORA expectation | Assurance artefact |
|------------------|-------------------|
| Encryption policy current with threat landscape | Algorithm standards matrix + horizon review (Chapter 4) |
| ICT change management | Harness results on production changes |
| Resilience testing | Performance and failover tests including crypto paths |
| Third-party risk | Vendor validation matrix rows (Chapter 16) |
| Evidence on request | GRC repository with integrity controls |

**Meridian's DORA testing evidence** is developed in §18.16 — Thomas Bergström's team mapped test categories to RTS control language.

NIS2 essential and important entities face parallel expectations: documented encryption measures, supply-chain oversight, and evidence that controls work in practice. National competent authorities differ in examination style, but convergence on **tested cryptographic governance** — interoperability results, pen test closure, vendor validation gaps — mirrors the artefact sets CMMC and FedRAMP already demand. European enterprises should maintain one evidence taxonomy serving DORA, NIS2, and ISO 27001 audits rather than rebuilding packages per framework.

> **Regulatory Lens**
>
> **DORA does not cite ML-KEM — it cites resilience.** Supervisors evaluate whether the institution can change cryptography without uncontrolled failure. Chapter 10 agility NFRs plus Chapter 18 test evidence demonstrate that capability more persuasively than algorithm name-checks in policy prose.

---

## 18.9 Enterprise Test Harness Integration

Chapter 10 defined the **enterprise crypto agility test harness** — profile matrix runner, round-trip tests, negotiation simulator, validation module check, and failure injection. Chapter 18 positions the harness as the **functional testing backbone** of the assurance programme.

### 18.9.1 Harness-to-assurance mapping

| Harness component (Ch 10) | Test category | Evidence output |
|---------------------------|---------------|-----------------|
| Profile matrix runner | Functional | `harness-report-{build}.json` |
| Validation module check | Functional + compliance | CMVP ID match log |
| Negotiation simulator | Interoperability | Peer handshake transcript |
| Performance baseline | Performance | Latency regression chart |
| Failure injection | Security (lightweight) | Downgrade rejection proof |

### 18.9.2 Production promotion gate

GlobalSync's CI/CD pipeline (Chapter 17) enforced:

```
Code merge → Unit tests → crypto-agility-verify → Integration tests →
Security scan → Staging deploy → Interop smoke → Production canary
```

A failed `crypto-agility-verify` stage blocked merge — **non-bypassable** except by CISO risk acceptance with 30-day expiry. Meridian attached harness PDF summaries to change records; supervisors reviewed samples during thematic reviews.

### 18.9.3 Harness limitations

The harness does **not** replace:

- HSM hardware integration tests (require lab appliances)
- Partner bilateral interoperability (require partner participation)
- Penetration testing (require adversarial methodology)
- Formal module validation (vendor CMVP process)

Programme offices document harness **scope boundaries** in the validation plan to prevent false confidence — "harness green" does not mean "CMMC crypto family complete."

---

## 18.10 HSM and KMS Validation Assessment

Chapter 14's **HSM/KMS capability assessment matrix** (Table 14.1) scores platforms against PQC readiness. Chapter 18 converts scores into **assurance gates**.

### 18.10.1 Assessment-to-gate mapping

| Table 14.1 score | Assurance gate |
|------------------|----------------|
| 0 — No PQC roadmap | No lab pilot beyond R&D tagging |
| 1 — Roadmap only | Procurement escalation; no production |
| 2 — Beta/lab module | Functional harness in lab; interop planning |
| 3 — CMVP listed, limited algorithms | H1 production for listed algorithms only |
| 4 — Full algorithm suite validated | H2 planning authorised |

### 18.10.2 Annual reassessment

HSM vendors issue firmware updates that **change operational environment**. Assurance teams re-run Table 14.1 scoring annually and on every firmware upgrade — updating CMVP certificate references and re-running functional harness against production profiles.

Meridian's 2027 annual review discovered a **general-purpose HSM** firmware upgrade that temporarily removed ML-KEM from the validated boundary — a regression caught by certificate monitoring before production impact. The matrix row moved from Closed to Open; steering committee notified within 48 hours.

### 18.10.3 Ceremony and validation coupling

Key ceremonies (Chapter 14) must use **validated module paths** for production key generation. Ceremony scripts are assurance artefacts — assessors sample whether operators followed procedures tied to validated configurations.

| Ceremony step | Validation check |
|---------------|------------------|
| HSM firmware version | Matches CMVP operational environment |
| Algorithm selection | Listed on certificate |
| Key size / parameter set | Matches policy profile |
| Audit log export | Signed with validated module |

---

## 18.11 Interoperability Testing Programme

Interoperability failures are the **most common production blocker** after validation gaps — especially during H1 hybrid phases when peers present heterogeneous algorithm support.

### 18.11.1 Partner test matrix

**Table 18.4 — Partner Interoperability Test Matrix (Template)**

| Partner ID | System | Protocol | Local profile | Partner profile | Last test | Result | Next due |
|------------|--------|----------|---------------|-----------------|-----------|--------|----------|
| P-001 | Acquiring bank | mTLS | `mer-api-h1-v3` | RSA + ML-KEM hybrid | 2028-04-12 | Pass | 2028-10-12 |
| P-002 | Federal integrator | TLS 1.3 | `apex-cui-tls-v2` | CNSA hybrid | 2028-02-28 | Pass | 2028-08-28 |
| P-003 | Logistics API | TLS 1.3 | `gs-tenant-tls-v4` | Classical only | 2028-05-01 | **Fail** | Escalated |

### 18.11.2 Failure escalation

Partner failures trigger **CDG review** (Chapter 8) — a failed partner may become a blocking node for hundreds of services. GlobalSync's P-003 failure blocked Wave 2 tenant migrations; programme office engaged partner procurement channel (Chapter 16) with interoperability retest scheduled as contract deliverable.

### 18.11.3 Certificate chain interoperability

PKI overlap (Chapter 13) requires explicit chain tests:

1. ML-DSA end-entity → ML-DSA intermediate → hybrid root
2. Cross-sign path to legacy trust anchor
3. Partner trust store update verification
4. OCSP/CRL responder signature algorithm check

Apex packaged chain walk results as **signed test reports** — federal integrators attached them to their own accreditation evidence, multiplying Apex's assurance investment.

---

## 18.12 Performance Testing and Capacity Evidence

Performance testing produces **capacity evidence** for regulators and internal SRE teams — demonstrating PQC migration does not breach availability commitments.

### 18.12.1 Test design

| Load scenario | Measure | Environment |
|---------------|---------|-------------|
| Steady-state API traffic | p50/p99 latency | Staging at 120% prod load |
| TLS handshake storm | Connection establishment rate | Dedicated perf lab |
| HSM signing batch | Max TPS sustained 1 hour | Vendor lab + internal |
| Firmware verify fleet | Boot time distribution | Terminal sample pool |
| Failover | RTO with PQC keys on secondary | DR exercise |

---

## 18.13 Security Testing: Red Team and Penetration Testing for Cryptography

Conventional penetration tests check for SQL injection and misconfigured S3 buckets. **Cryptographic penetration testing** evaluates whether controls enforce policy under adversarial pressure — a distinct discipline easy to scope poorly.

### 18.13.1 Crypto-specific pen test scope

| In scope | Out of scope (unless explicitly resourced) |
|----------|---------------------------------------------|
| TLS downgrade and weak cipher negotiation | Novel cryptanalysis of ML-KEM |
| Certificate validation bypass | Side-channel lab analysis of HSM hardware |
| KMS IAM privilege escalation | Breaking hash functions |
| Key material in logs, crash dumps, backups | Supply-chain hardware implants |
| JWT/JWS algorithm confusion | Formal verification of protocols |
| Hybrid combiner misconfiguration | — |
| PKCS#11 caller misuse | — |

Pen test firms without cryptographic depth produce generic findings ("enable TLS 1.3") — useless for PQC assurance. Apex required **crypto pen test competency** in RFP evaluation: demonstrable prior engagements testing PKI, HSM integrations, and protocol downgrade.

### 18.13.2 Red team considerations

**Red teams** simulate adversaries with objectives — exfiltrate CUI, forge firmware signatures, intercept partner API traffic. Cryptographic red team scenarios for PQC migration:

| Scenario | Tests | Success criterion for defence |
|----------|-------|------------------------------|
| Downgrade attack | Force classical-only against hybrid policy | Connection rejected; alert fired |
| Trust store poisoning | Install rogue ML-DSA CA | Detection before production trust |
| KMS key exfiltration | Compromise operator credentials | No raw key export; HSM policy blocks |
| Lab-to-prod bleed | Move unvalidated module config to prod | Change gates prevent promotion |
| Ceremony social engineering | Impersonate custodian | Quorum procedure halts ceremony |
| Algorithm confusion | Submit ML-DSA sig as ECDSA | Parser rejects; logged |

Red team findings feed **steering committee risk register** — not only IT ticket queues. Apex's 2028 red team compromised a **staging** KMS role — not production — but demonstrated insufficient IAM boundary between environments. Remediation preceded ML-KEM production wrap.

### 18.13.3 Co-ordinating with validated boundaries

Red team and pen test activity must **not violate FIPS operational environment** — destructive tests on production HSMs, entropy exhaustion attacks, or firmware tamper triggers can cause compliance incidents.

| Rule | Rationale |
|------|-----------|
| Production HSM pen test read-only | Tamper events affect accreditation |
| Destructive crypto tests in lab partitions | Isolated from production keys |
| Document test windows in change management | Operations awareness |
| No novel attack tools on production modules | Undefined failure modes |

Pen test findings use standard severity tiers: **critical** key-extraction paths halt production within 72 hours; **high** downgrade successes on CUI paths within 30 days; documented validation gaps track as steering committee observations with POA&M entries.

---

## 18.14 Validation Dependency Timeline

Production PQC deployment follows **validation dependencies** — not programme ambition alone. Figure 18.1 visualises the critical path.

**Figure 18.1 — Validation Dependency Timeline (Brief)**

```
2026          2027          2028          2029          2030
  |             |             |             |             |
  v             v             v             v             v
[Algorithm     [CMVP lab     [Module       [Interop      [H2 classical
 policy        submission    cert          partner       sunset
 published]    peak]         issued]       matrix        gate]
                              |            complete]       |
                              v                          v
                    [HSM firmware GA]──────────────>[Production
                              |                    PQC-primary]
                              v
                    [Ceremony + harness]
                              |
                              v
                    [H1 dual-sign production]
```

**Production brief — Figure 18.1:** Gantt-style chart with swimlanes: Policy, CMVP/vendor, HSM/KMS, Testing (functional/interop/perf), Production gates. Highlight CDG blocking node BN-MER-HSM-001 spanning vendor cert to H1. Annotate Apex CMMC assessment (Oct 2028) relative to module gap closure. Colour-code: green = closed gate; amber = interim H1; red = open gap.

### 18.14.1 Timeline construction method

1. Extract CDG blocking nodes with `validation_required=true`
2. Query vendor CMVP roadmap dates — contractual, not marketing
3. Add ceremony and harness lead time (Chapter 14: 60+ days)
4. Add interoperability partner lead time (slowest Tier 1 partner)
5. Add regulatory examination windows — avoid production changes before audits unless planned
6. Publish integrated timeline to steering committee

Meridian's timeline showed **eighteen months** from module GA to H3 classical key destroy — dual-signature fleet propagation dominated, not cryptography. Programme directors should treat the timeline as a **steering committee artefact**, revised quarterly when CMVP listings change or partners slip interop windows. Static timelines displayed once become liability when assessors compare slides to production reality.

> **Architect's Decision**
>
> **Schedule production PQC dates from validation dependency timeline backward — not from NIST 2035 forward.** NIST dates are policy anchors; your critical path is CMVP listings, partner matrices, and fleet trust propagation. Apex's CMMC assessment succeeded because the timeline honestly showed ML-DSA gap closure in Q2 2029 — not because the slide claimed 2027 PQC completion.

---

## 18.15 Case Study: Apex Defense CMMC Assessment Evidence Package

Apex's CMMC Level 2 evidence package for cryptographic controls demonstrates **assurance architecture** — reusable across assessments, customer audits, and FedRAMP customer responsibility documentation.

### 18.15.1 Package structure

| Folder / section | Contents | Control mapping |
|------------------|----------|-----------------|
| `CRYPTO-POLICY` | Algorithm standards matrix; hybrid policy; CNSA overlay | SC-13, 3.13.x |
| `VALIDATION-MATRIX` | Table 18.1 export; gap remediation plans | 3.13.11, 3.13.16 |
| `CMVP-CERTS` | PDF certificates; operational environment sheets | 3.13.11 |
| `CONFIG-BASELINE` | HSM partition config; TLS baseline; STIG checklists | 3.13.8, 3.13.11 |
| `KEY-MGMT` | Ceremony procedures; sample redacted logs | 3.13.10, 3.13.12 |
| `TEST-FUNCTIONAL` | Harness reports (commercial zone) | 3.12.1 |
| `TEST-INTEROP` | Integrator signed matrices | 3.13.8 |
| `TEST-PERF` | Capacity reports for CUI services | 3.13.4 |
| `TEST-SECURITY` | Pen test executive summary; finding closure | 3.12.1, 3.14.x |
| `PQC-TRANSITION` | Validation dependency timeline; steering minutes | POA&M items |

### 18.15.2 Evidence traceability

Each artefact carried **metadata**: owner, creation date, review date, system class, classification zone. Apex's GRC tool generated **traceability matrices** linking assessor questions to artefact IDs — reducing interview time.

### 18.15.3 The ML-DSA observation

The C3PAO observation on ML-DSA module gap received a **Plan of Action and Milestones (POA&M)** entry:

| Field | Value |
|-------|-------|
| Weakness | ML-DSA not in CUI signing partition validated boundary |
| Compensating control | Classical FIPS module; no CUI signed with unvalidated PQC |
| Milestone | CMVP cert expected Q2 2029 |
| Evidence | Vendor contract; validation matrix row; timeline Figure 18.1 |
| Risk acceptance | CISO signed; customer notification for affected contracts |

Honest POA&M entries preserve **assessment credibility** for re-certification. Apex avoided the competitor failure mode from Chapter 4 — claiming PQC support without validated modules.

### 18.15.4 Zone separation in evidence

Classified NSS evidence **never** appeared in CMMC packages. Cross-references stated "NSS zone — separate accreditation" with sanitised summaries only. Priya's team rejected a well-meaning engineer's suggestion to "show the classified harness results" — accreditation boundary violation.

---

## 18.16 Case Study: Meridian DORA Testing Evidence

Meridian Mutual Bank's supervisory dialogue under DORA required **testing evidence** for ICT systems supporting payment critical functions — not policy PDFs alone.

### 18.16.1 Evidence mapping to RTS expectations

| RTS theme | Meridian artefact | Test category |
|-----------|-------------------|---------------|
| Encryption policy maintenance | Algorithm matrix v3.2 + horizon review minutes | Governance |
| ICT change management | Change tickets with harness PDF attachments | Functional |
| Resilience testing | Annual DR exercise including PQC KMS failover | Performance + functional |
| Vulnerability management | Pen test report § crypto findings | Security |
| Third-party register | Vendor validation matrix rows | Compliance |

### 18.16.2 Thematic review sample

EBA thematic review in 2028 sampled **fourteen production changes** to payment-channel systems. Meridian produced:

1. Change record with risk classification
2. Harness report showing profile `mer-payment-tls-h1-v2` pass
3. Interop log with acquiring bank retest
4. Validation matrix row showing Closed status for cloud KMS EU region
5. Open row for payment HSM with remediation plan

Supervisors accepted the **open payment HSM row** because evidence demonstrated controlled H1 dual-signature operation — classical validated path primary, PQC in staged rollout — not uncontrolled algorithm improvisation.

### 18.16.3 Thomas Bergström's evidence principles

Meridian's Head of Regulatory Affairs codified three principles:

1. **Every production crypto change has a test artefact** — no exceptions for "minor config"
2. **Open validation gaps appear in the same pack as closed rows** — supervisors distrust selective disclosure
3. **Third-party crypto inherits the same evidence standard** — vendor matrix rows mandatory (Chapter 16)

### 18.16.4 DORA resilience test scenario

Meridian's 2028 resilience exercise scenario: **primary payment HSM unavailable; failover to secondary partition with ML-KEM wrap keys.**

| Phase | Result | Evidence |
|-------|--------|----------|
| Failover trigger | Success at RTO 12 min | Operations log |
| Crypto operations on secondary | ML-DSA sign pass | Harness rerun |
| Acquiring bank connectivity | Maintained | Interop smoke log |
| Supervisor notification | Within 4 hours | Incident comms record |

The exercise demonstrated **operational resilience of PQC-capable custody** — not merely laboratory correctness.

---

## 18.17 Case Study: GlobalSync Tenant Assurance

GlobalSync Logistics operates **multi-tenant SaaS** across forty countries. Tenant assurance — proving each customer's cryptographic isolation and policy compliance — is a product differentiator and contractual obligation.

### 18.17.1 Tenant assurance tiers

| Tier | Customer profile | Validation evidence |
|------|------------------|---------------------|
| **T1 — Standard** | Shared platform KMS | Platform FedRAMP/GDPR docs + SOC 2 |
| **T2 — Regulated** | Financial services tenants | Per-tenant validation matrix excerpt |
| **T3 — BYOK/HYOK** | Customer-managed keys | Customer module cert + interop test pack |
| **T4 — Sovereign** | Dedicated region/deployment | Full boundary evidence; custom pen test |

### 18.17.2 Tenant-facing assurance pack

GlobalSync published **annual tenant assurance packs** containing:

- Platform validation matrix (redacted to tenant-relevant rows)
- Hybrid TLS policy and sunset schedule
- Pen test executive summary (sanitised)
- Subprocessor crypto change notification log
- Incident history involving cryptographic controls (if any)

EU tenants received **GDPR Article 28** processor documentation cross-linking assurance packs. US federal tenants received **FedRAMP responsibility matrix** excerpts mapping shared controls.

### 18.17.3 Per-tenant harness evidence

T2+ tenants could request **profile-specific harness reports** — proving their configured algorithm profiles passed functional testing in the tenant's isolation boundary. Marcus Chen's platform team automated generation from CI artefacts — reducing manual audit support from weeks to hours.

### 18.17.4 Tenant migration gates

Chapter 11 hybrid patterns required **per-tenant sunset consent** for classical algorithm removal. GlobalSync's assurance model tied tenant migration waves to:

1. Tenant notification 90 days ahead
2. Interop test offer with tenant's test endpoints
3. Harness report for tenant profiles
4. Validation matrix confirmation for tenant region
5. Contract amendment for H2/H3 transitions

A **T3 BYOK tenant** in Germany delayed H2 migration until their customer-managed HSM received ML-KEM validation — GlobalSync's platform was ready; tenant custody was not. The validation dependency timeline applied per-tenant, not per-platform.

> **Migration Moment**
>
> *"Our SaaS is FedRAMP authorised — tenants inherit PQC automatically."*
>
> Authorisation covers the **provider boundary**. Tenants using BYOK, custom cipher policies, or regional data residency still need **their own validation evidence** inside their custody model. GlobalSync learned to sell "assurance enablement" — packs and test support — not assume inheritance.

---

## 18.18 Assembling Evidence Packages

Cross-framework evidence reuse reduces programme cost. Apex, Meridian, and GlobalSync converged on a **common evidence taxonomy**:

| Artefact | CMMC | FedRAMP | DORA | SOC 2 | ISO 27001 |
|----------|------|---------|------|-------|-----------|
| Validation matrix | ✓ | ✓ | ✓ | ✓ | ✓ |
| CMVP certificates | ✓ | ✓ | ○ | ○ | ○ |
| Harness reports | ✓ | ✓ | ✓ | ✓ | ✓ |
| Interop matrices | ✓ | ✓ | ✓ | ○ | ○ |
| Pen test reports | ✓ | ✓ | ✓ | ✓ | ✓ |
| Key ceremony procedures | ✓ | ✓ | ✓ | ✓ | ✓ |
| PQC transition timeline | ✓ | ✓ | ✓ | ○ | ○ |

✓ = commonly requested; ○ = optional or mapped to broader controls

Evidence stores require integrity controls — hashed harness artefacts, access audit, retention aligned to DORA and contract schedules. Internal audit quarterly samples matrix accuracy against CMVP listings, harness freshness, POA&M ownership, and config baseline drift.

---

## 18.19 Common Assurance Failures

| Failure | Symptom | Remediation |
|---------|---------|-------------|
| Validation theatre | Certs in folder; production uses different firmware | Operational environment audit |
| Harness bypass | Risk acceptance becomes permanent waiver | Executive expiry on waivers |
| Interop optimism | Single partner test generalised | Full matrix per Tier 1 partner |
| Performance surprise | Production latency after cert upgrade | Pre-production load test gate |
| Pen test checkbox | Generic scope; no crypto findings | Crypto-qualified assessors |
| Zone contamination | Classified config in commercial package | Evidence taxonomy enforcement |
| Timeline fiction | NIST 2035 on slides; CMVP 2029 in reality | Validation dependency timeline |
| Tenant assumption | Platform ready = tenant ready | Per-tenant custody matrix |

Northfield Energy's OT programme added **vendor validation flow-down** as assurance failure prevention — OT devices with vendor-held keys require contractual CMVP evidence, not enterprise self-attestation.

---

## 18.20 Cross-Reference Map

| Topic | See |
|-------|-----|
| Algorithm standards and validation matrix introduction | Chapter 4 §4.26 |
| Hybrid lifecycle and sunset testing triggers | Chapter 5 |
| CBOM validation attributes | Chapter 7 |
| CDG blocking nodes and partner dependencies | Chapter 8 |
| Wave gates and MPI sequencing | Chapter 9 |
| Enterprise test harness, agility NFRs | Chapter 10 §10.14 |
| Hybrid interoperability patterns | Chapter 11 |
| Protocol test matrices | Chapter 12 |
| PKI chain interoperability | Chapter 13 |
| HSM assessment matrix, ceremonies | Chapter 14 §14.7 |
| Programme governance, steering KPIs | Chapter 15 |
| Vendor evidence requests | Chapter 16 |
| CI/CD verification gates | Chapter 17 |
| Sector-specific assurance (banking, defence) | Chapters 19–20 |

---

## 18.21 Apply in Your Organisation

1. **Publish a validation coverage matrix** (Table 18.1) — extend Chapter 4's example with CMVP cert IDs, operational environments, and CDG blocking refs.
2. **Distinguish module validation from algorithm availability** — train procurement and engineering on module boundary discipline (§18.2).
3. **Adopt the test category matrix** (Table 18.2) — assign owners and gate types per category.
4. **Integrate Chapter 10's harness** as the functional testing backbone — non-bypassable CI gate for in-scope systems.
5. **Score HSM/KMS platforms with Chapter 14 Table 14.1** — link scores to production authorisation levels.
6. **Build the validation dependency timeline** (Figure 18.1) — schedule production dates backward from CMVP and partner gates.
7. **Map assurance artefacts to your regulatory frameworks** — CMMC, FedRAMP, DORA, NIS2, SOC 2 reuse taxonomy (§18.18).
8. **Scope crypto-qualified penetration tests** — downgrade, KMS IAM, algorithm confusion in scope; novel cryptanalysis out of scope unless resourced.
9. **Run red team scenarios** against staging — production HSM destructive tests prohibited.
10. **Maintain partner interoperability matrices** — escalate failures through CDG and procurement (Chapter 16).
11. **Package evidence with traceability metadata** — owner, review date, control mapping; Apex folder structure as template.
12. **Document open validation gaps honestly** — POA&M with compensating controls beats false production claims.
13. **Separate classified and commercial evidence zones** — Apex zone separation pattern.
14. **Publish tenant assurance packs** for SaaS operators — per-tier evidence (GlobalSync model).
15. **Quarterly assurance dashboard to steering committee** — open gaps, harness coverage, pen test status, interop freshness.

---

## 18.22 Chapter Summary

- **Validation is a programme constraint** — FIPS 140-3 module transitions gate production in regulated paths; algorithm standardisation alone does not authorise deployment.
- **Module validation differs from algorithm validation** — CMVP certificates list algorithms inside bounded operational environments; CAVP alone is insufficient.
- **The validation coverage matrix** operationalises Chapter 4's framework — quarterly updated, linked to CDG blocking nodes, with honest gap status.
- **Four test categories** — functional, interoperability, performance, security — each with distinct owners, environments, and evidence artefacts.
- **Chapter 10's test harness** provides functional testing backbone; it does not replace HSM integration tests, partner interop, or pen testing.
- **Chapter 14's HSM assessment** converts platform scores into assurance gates — annual rescore on firmware change.
- **CMMC assessors** evaluate documented FIPS implementation and credible PQC transition plans — not roadmap slides without evidence.
- **FedRAMP** requires significant change reassessment when cryptographic modules change — customer responsibility matrix must stay current.
- **DORA and NIS2** expect testing evidence demonstrating cryptographic resilience — harness results, DR exercises, pen test closure.
- **Crypto pen tests and red teams** target downgrade, KMS misuse, and algorithm confusion — scoped to avoid production HSM compliance incidents.
- **Validation dependency timeline** schedules production backward from CMVP listings, ceremonies, and partner matrices — not forward from NIST 2035 alone.
- **Apex's CMMC package** demonstrates traceable evidence taxonomy with honest POA&M for open ML-DSA gaps.
- **Meridian's DORA evidence** maps test categories to supervisory expectations — open gaps disclosed with compensating controls.
- **GlobalSync tenant assurance** tiers evidence by custody model — platform authorisation does not substitute for tenant BYOK validation.

**Closing note:** Assurance is where architecture meets accountability. The enterprises in this book that passed assessments without delaying migration treated validation and testing as **Wave 0 programme infrastructure** — planned on the dependency timeline, evidenced continuously, and disclosed honestly when gaps remained open.

**Next:** Part VI applies the full programme model to sector playbooks — banking, defence, cloud, and sustained quantum resilience.

---

*Chapter 18 — References*

- Cybersecurity Maturity Model Certification Program. (2024–2026). *CMMC assessment guides* and Level 2 scoping guidance. U.S. Department of Defense Chief Information Officer. https://dodcio.defense.gov/CMMC/
- European Banking Authority. (2024–2026). *DORA implementation* and ICT risk testing guidance. https://www.eba.europa.eu/
- European Union. (2022). Regulation (EU) 2022/2554 on digital operational resilience for the financial sector (DORA). *Official Journal of the European Union*.
- European Union. (2022). Directive (EU) 2022/2555 on measures for a high common level of cybersecurity (NIS2). *Official Journal of the European Union*.
- FedRAMP Program Management Office. (2024–2026). *FedRAMP authorisation playbook* and significant change policy. https://www.fedramp.gov/
- National Institute of Standards and Technology. (2019). FIPS 140-3: Security Requirements for Cryptographic Modules. https://doi.org/10.6028/NIST.FIPS.140-3
- National Institute of Standards and Technology. (2024). FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard. https://doi.org/10.6028/NIST.FIPS.203
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Institute of Standards and Technology. (2024). *Cryptographic Module Validation Program (CMVP)*. https://csrc.nist.gov/projects/cmvp
- National Institute of Standards and Technology. (2020). NIST SP 800-171: Protecting Controlled Unclassified Information in Nonfederal Systems and Organizations. https://doi.org/10.6028/NIST.SP.800-171
