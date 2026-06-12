# Chapter 20
# Defense, Government, and Critical Infrastructure

---

Dr. Priya Nair's Apex Defense Technologies programme office convened a joint steering review in February 2028. The agenda item was not algorithm selection — Apex had standardised on CNSA 2.0-aligned suites for National Security System (NSS) workloads eighteen months earlier. The question was **interface discipline**: whether a commercial FedRAMP Moderate authorisation package could reuse NSS validation evidence for a CUI-facing analytics platform without contaminating the classified evidence zone.

Across the country, James Whitfield's Northfield Energy Systems team faced a structurally similar problem with different vocabulary. Northfield is a US gas transmission operator — **not subject to NIS2** — but accountable to NERC Critical Infrastructure Protection (CIP), Transportation Security Administration (TSA) pipeline security directives, and Cybersecurity and Infrastructure Security Agency (CISA) sector guidance. James's WAN IPsec hybrid rollout (Chapter 12) had cleared laboratory qualification. Field deployment stalled on **OT continuity**: compressor controllers could not tolerate rekey windows that corporate IT considered routine, and three OT vendors still lacked PQC-capable firmware verification paths (Chapter 6).

Priya and James do not share a programme office. They share a **sector constraint pattern**: federal cryptographic floors set the pace for defence and government-adjacent work; critical infrastructure adds operational technology (OT) continuity requirements that no TLS pilot can override. This chapter teaches enterprises to align commercial and government requirements **without duplicating programmes** — and to treat OT migration as a synchronisation problem across decades-long asset lifetimes, not a certificate rotation project.

---

## 20.1 Sector Context and the Central Argument

Parts I through V established universal migration architecture — inventory, dependency graphs, hybrid patterns, programme governance, procurement enforcement, supply-chain gates, and assurance machinery. Part VI applies that architecture to sectors where regulatory floors, accreditation boundaries, and field operations impose constraints the universal model must respect.

The central argument:

> **CNSA 2.0 sets the floor for defence and National Security Systems; critical infrastructure adds OT continuity constraints that extend timelines, reshape TRADE weights, and demand evidence models distinct from corporate IT — but both sectors execute against the same programme machinery from Parts I–V.**

Three propositions support this argument:

| Proposition | Defence / government implication | Critical infrastructure implication |
|-------------|----------------------------------|-----------------------------------|
| **Regulatory floors are binding** | CNSA 2.0 milestones (2027–2035) constrain NSS algorithm and protocol choices | NERC CIP, TSA, and CISA create evidence obligations without naming ML-KEM |
| **Boundaries are architectural** | Classified, NSS, CUI, and commercial zones require separate evidence and promotion paths | OT/IT convergence zones require maintenance-window governance, not unified PKI |
| **Dependencies outlive pilots** | CMVP module listings gate production faster than executive slide timelines | Firmware stores, CPE firmware, and historian archives gate IPsec and signing before concentrators matter |

**PQ-ADAPT Level 4 (*Transitioning*)** in defence and critical infrastructure looks like production hybrids in authorised zones, honest validation gap registers, OT vendor evidence flow-down, and steering committees that refuse to merge incompatible evidence streams. Level 5 (*Quantum-Resilient*) remains the 2030–2035 disallowance horizon — but sector overlays modify **how** waves are sequenced, not **whether** inventory and governance precede deployment.

> **Migration Moment**
>
> *"We are not NSS — CNSA 2.0 does not apply to us."*
>
> Correct for a standalone commercial utility. Incorrect for a defence contractor, dual-use manufacturer, or critical infrastructure operator whose **vendors and partners** increasingly align supply chains to CNSA and NSS requirements. Northfield's compressor vendor prioritised LMS firmware signing because defence customers demanded it — commercial operators inherit vendor roadmaps shaped by federal floors even when federal floors do not bind them directly.

---

## 20.2 CNSA 2.0: The Defence Cryptographic Floor

The National Security Agency's **Commercial National Security Algorithm Suite 2.0 (CNSA 2.0)** advisory establishes binding cryptographic requirements for National Security Systems. For enterprises in the defence industrial base, CNSA 2.0 is not guidance to consider — it is the **algorithm and timeline floor** against which NSS programmes are assessed.

### 20.2.1 CNSA 2.0 algorithm suite

CNSA 2.0 specifies approved post-quantum algorithms for NSS contexts, aligned with NIST FIPS 203–205 and SP 800-208 for stateful firmware signing:

| Use case | CNSA 2.0 approved algorithms | Enterprise planning note |
|----------|------------------------------|--------------------------|
| Key establishment | ML-KEM (specific parameter sets) | Hybrid transition permitted during H1; NSS timelines define cutover |
| Digital signatures | ML-DSA, SLH-DSA | Signature size affects HSM partitions (Chapter 14) |
| Firmware signing | ML-DSA, SLH-DSA, LMS (SP 800-208) | LMS state management is operational, not library (Chapter 6) |
| Symmetric / hash | AES, SHA-2/SHA-3 families | Unchanged; anchor for hybrid constructions |

Enterprises must distinguish **CNSA alignment** (following the approved suite and milestones) from **CNSA applicability** (systems designated NSS under CNSSP 15). Apex operates both NSS-designated enclaves and commercial IT governed by NIST IR 8547 — the suite may converge, but **governance and evidence do not merge**.

### 20.2.2 CNSA 2.0 milestones

CNSA 2.0 establishes migration milestones that programme offices map to wave plans:

| Milestone domain | Representative requirement | Programme implication |
|------------------|---------------------------|----------------------|
| Software/firmware signing | PQC signatures for NSS software and firmware | Chapter 6 signing strategy; CMVP module gaps |
| Key establishment | PQC key exchange for NSS data in transit | Chapter 12 protocol transition; hybrid IKE |
| Cloud services | PQC for NSS cloud service encryption | FedRAMP boundary + NSS accreditation |
| General disallowance | Quantum-vulnerable PKC retired per CNSA schedule | HLM H3; CBOM disallowance verification |

Internal enterprise timelines must reflect **dependency reality**, not milestone headlines alone. Apex's programme office mapped CNSA 2030 firmware signing to a **2028 module gap closure** on the payment-adjacent signing partition — because CMVP listing, not policy publication, authorised production (Chapter 18).

### 20.2.3 CNSA 2.0 and NIST IR 8547

NIST IR 8547 (Initial Public Draft at time of writing) proposes deprecation and disallowance timelines for federal non-NSS systems. CNSA 2.0 milestones are **stricter and earlier** for NSS. Defence contractors therefore run **parallel policy tracks**:

- **NSS track** — CNSA 2.0 milestones; accreditation authority liaison; classified evidence zones
- **Corporate IT track** — NIST IR 8547 aligned; CMMC/FedRAMP evidence; commercial module boundaries
- **Interface track** — cross-domain guard nodes; data diode patterns; shared procurement leverage

Priya Nair's architecture board rejected a single enterprise algorithm matrix without zone annotations — one matrix, three **authorisation columns** (NSS, CUI/commercial regulated, general corporate).

> **Regulatory Lens**
>
> CNSA 2.0 does not replace CMMC, FedRAMP, or NIST SP 800-53 — it **specialises** cryptographic control selection for NSS. CMMC assessors evaluate whether CUI protection uses FIPS-validated modules and documented configuration (Chapter 18). FedRAMP authorisation evaluates significant change when modules change. CNSA tells NSS programmes **which algorithms** must appear inside those validated boundaries — and **when**.

---

## 20.3 National Security Systems versus the Defence Industrial Base

Not every system at a defence contractor is an NSS. CNSSP 15 defines National Security Systems — systems that store, process, or transmit classified information, or operate in support of national security missions under specified criteria. The defence industrial base (DIB) additionally handles Controlled Unclassified Information (CUI) under DFARS, CMMC, and contract flow-down — often on infrastructure that is **not** NSS-designated.

### 20.3.1 System classification drives programme structure

| Class | Typical data | Primary crypto governance | Evidence consumer |
|-------|-------------|---------------------------|-----------------|
| **NSS / classified** | Classified, SCI, SAP | CNSA 2.0; accreditation authority | DAA, NSA/CSS guidance |
| **CUI / CMMC** | Export-controlled, contract CUI | NIST SP 800-171; FIPS 140-3 | C3PAO, government assessors |
| **FedRAMP cloud** | Agency data per authorisation boundary | FedRAMP baselines; FIPS modules | 3PAO, AO |
| **Corporate IT** | Business operations | NIST IR 8547; enterprise policy | Internal audit, insurers |

Apex's programme charter (Chapter 15) defined **swim lanes** per class — separate wave plans, shared procurement clauses for common HSM vendors, and explicit **forbidden merges** on evidence packages (Chapter 18 §18.15).

### 20.3.2 Contract flow-down as synchronisation mechanism

Defence contractors receive cryptographic requirements through **contract flow-down** — DD254, security classification guides, and programme-specific security requirements. Flow-down creates synchronisation obligations that internal policy alone cannot relax:

- Prime contractor PQC roadmap must match subcontractor evidence timelines
- Shared HSM manufacturers must serve multiple accreditation boundaries
- Partner API cryptography must satisfy both corporate interoperability and classified guard requirements

Chapter 16's flow-down clause library applies directly — Priya Nair's team inserted PQC roadmap audit rights into Tier 1 subcontract renewals in 2027, preventing a subcontractor's classical-only PKI from blocking Apex integration testing in 2029.

### 20.3.3 Government civilian agencies

Civilian federal agencies — not defence contractors — face FedRAMP, FISMA, and NIST SP 800-53 Rev. 5 cryptographic controls without CNSA 2.0 NSS designation for most systems. The sector overlay in §20.6 includes a **government civilian** column for readers in federal civil departments; the programme machinery remains identical to Part V, with **FedRAMP significant change** as the primary assurance gate for cloud paths.

Civilian agency programmes differ from DIB in three practical ways. **First**, authorising officials (AOs) evaluate risk through FISMA continuous monitoring rather than CMMC C3PAO assessment — evidence packages emphasise ongoing ConMon artefacts over point-in-time certification. **Second**, cloud-first mandates concentrate cryptographic transition in FedRAMP boundaries — agency security teams must coordinate significant change submissions with cloud service providers rather than operating enterprise HSM estates directly. **Third**, mission system lifetimes in civilian agencies span decades for records and scientific archives — HNDL exposure resembles critical infrastructure historian risk more than corporate IT session keys.

Agency programme directors should map SP 800-53 control families **SC-12, SC-13, SC-17** (cryptographic key establishment, cryptographic protection, and PKI certificates) to the validation coverage matrix from Chapter 18 — assessors expect control implementation statements that reference CMVP certificates and transition timelines, not algorithm awareness briefings.

### 20.3.4 DFARS, export control, and foreign ownership

Defence contractors face **DFARS 252.204-7012** and related clauses requiring adequate security for covered defence information — including cryptographic protection for CUI on contractor systems. PQC migration evidence supports DFARS compliance the same way it supports CMMC: documented FIPS implementation, key management, and credible transition plans.

Export control (**ITAR**, **EAR**) intersects cryptographic migration when dual-use products cross national boundaries. Algorithm selection, key ceremony participants, and evidence package distribution may require legal review independent of technical architecture. Apex's programme office routes **foreign national access** to PQC evidence packages through export compliance review — technical teams do not distribute validation matrices containing implementation detail to offshore integration partners without clearance.

Foreign ownership, control, or influence (FOCI) considerations add programme complexity for multinational defence suppliers. FOCI mitigation agreements may restrict which custody platforms and HSM geographies are permissible — constraining cloud KMS options before algorithm selection begins. Programme charters should reference FOCI constraints in scope exclusions to prevent architecture teams from designing PQC paths that legal cannot approve.

---

## 20.4 Classified and Unclassified Cryptographic Boundaries

The highest-consequence failure mode in defence-sector PQC migration is **evidence zone contamination** — classified configuration details, key ceremony procedures, or module identifiers appearing in commercial CMMC packages, or commercial test artefacts promoted into NSS enclaves without accreditation review.

**Figure 20.1 — Classified / Unclassified Cryptographic Boundary (Planning Example)**

```
                    ┌─────────────────────────────────────────┐
                    │           INTERNET / COMMERCIAL          │
                    │  ┌─────────────┐    ┌─────────────────┐  │
                    │  │ Corporate   │    │ FedRAMP /       │  │
                    │  │ IT, SaaS    │    │ CUI workloads   │  │
                    │  │ (IR 8547)   │    │ (CMMC, 800-171) │  │
                    │  └──────┬──────┘    └────────┬────────┘  │
                    │         │                      │           │
                    │         │    EVIDENCE ZONE B   │           │
                    │         │    (commercial pack) │           │
                    └─────────┼──────────────────────┼───────────┘
                              │                      │
                    ══════════╪══════════════════════╪══════════  CROSS-DOMAIN
                    GUARD     │                      │           GUARD / DATA DIODE
                    NODE      │                      │
                              ▼                      ▼
                    ┌─────────────────────────────────────────┐
                    │              NSS ENCLAVE                 │
                    │  ┌─────────────┐    ┌─────────────────┐  │
                    │  │ Classified  │    │ NSS unclassified │  │
                    │  │ processing  │    │ (CNSA 2.0)       │  │
                    │  └──────┬──────┘    └────────┬────────┘  │
                    │         │                      │           │
                    │         │    EVIDENCE ZONE A   │           │
                    │         │    (classified pack) │           │
                    │         └──────────┬───────────┘           │
                    │                    │                       │
                    │         ┌──────────▼───────────┐           │
                    │         │ HSM ROOT OF TRUST    │           │
                    │         │ (partition isolated) │           │
                    │         └──────────────────────┘           │
                    └─────────────────────────────────────────┘

  Promotion rules:
  ────────────────
  Zone A artefacts  ──X──>  Zone B  (NEVER — classification breach)
  Zone B artefacts  ──?──>  Zone A  (ONLY via accreditation review)
  Shared vendor     ──✓──>  Both zones via SEPARATE module configs
  Algorithm policy  ──✓──>  Published summary; zone-specific implementation
```

### 20.4.1 Boundary design principles

| Principle | Implementation | Apex practice |
|-----------|----------------|---------------|
| **Compile-time separation** | Different build pipelines per zone (Chapter 17) | No artefact promotion across enclave |
| **Key custody separation** | HSM partitions per zone (Chapter 14) | Classified root never in corporate partition |
| **Evidence taxonomy** | Separate GRC repositories with access control | CMMC pack ≠ NSS accreditation pack |
| **Policy summary sharing** | High-level algorithm matrix published enterprise-wide | Implementation detail zone-scoped |
| **Cross-domain guards** | Data diodes, guards, manual review for interface data | Interface track steering metrics |

Priya Nair's CMMC assessment (Chapter 18) succeeded because the evidence package was **honest about zone boundaries** — commercial hybrid TLS in production where validated; NSS paths documented with POA&M for open ML-DSA module gaps; no classified filenames in the C3PAO submission.

> **Architect's Decision**
>
> **Default: separate evidence zones with a cross-reference index, not a unified evidence folder.** Unified folders optimise for convenience; assessors and accreditation authorities optimise for boundary integrity. Publish a one-page **interface map** showing which systems cross guards and which cryptographic profiles apply — the map is shareable; guard configuration is not.

---

## 20.5 CMMC, FedRAMP, and Dual Compliance Architecture

Defence contractors and government technology providers routinely pursue **multiple authorisation regimes simultaneously**. PQC migration must satisfy each regime's evidence rules without assuming one assessment satisfies all.

### 20.5.1 CMMC and cryptographic controls

Cybersecurity Maturity Model Certification (CMMC) Level 2 maps to NIST SP 800-171 controls for CUI protection. Cryptographic controls assessors evaluate include:

- FIPS-validated modules where required for CUI protection
- Key management documentation and configuration baseline
- Encryption for CUI in transit and at rest per policy
- **Transition credibility** — documented PQC roadmap with evidence, not marketing

Chapter 18's assurance programme is the CMMC preparation backbone. Apex's assessor marked cryptographic controls **MET** with one observation on ML-DSA module gap — an expected, documented outcome that did not block contract renewal because the POA&M showed compensating controls and a dated closure plan.

### 20.5.2 FedRAMP and significant change

FedRAMP authorisation covers cloud service offerings for federal agency use. **Significant change** policy requires reassessment when cryptographic modules, algorithms, or boundary components change. PQC migration is almost always significant change when production modules change — not when a lab build demonstrates algorithm support.

| FedRAMP concern | PQC migration trigger | Programme action |
|-----------------|----------------------|------------------|
| Module change | HSM pool firmware with ML-KEM | Submit significant change package |
| Boundary change | New KMS integration | Impact analysis; possible re-authorisation |
| Customer responsibility matrix | Tenant BYOK with PQC keys | Update CRM artefact; customer evidence |
| Continuous monitoring | Algorithm policy drift | ConMon evidence of config compliance |

Apex's FedRAMP Moderate analytics platform scheduled PQC module upgrade as a **2029 significant change** — sequenced after corporate CMMC evidence stabilised, because the 3PAO engagement could reuse test matrices with boundary-scoped differences.

### 20.5.3 Dual compliance without duplicate testing

| Shared artefact | CMMC reuse | FedRAMP reuse | NSS reuse |
|-----------------|------------|---------------|-----------|
| Validation coverage matrix | ✓ (CUI rows) | ✓ (boundary rows) | ✓ (enclave rows) |
| CMVP certificates | ✓ | ✓ | ✓ (separate configs) |
| Harness reports | ✓ (commercial profiles) | ✓ | ✗ (separate harness) |
| Interop matrices | ✓ | ✓ | Partial (guard-scoped) |
| Pen test reports | ✓ | ✓ | Separate scope |

The reuse taxonomy (Chapter 18 §18.18) applies directly — **artefact type is shared; scope is zone-scoped**. Duplicate testing occurs when zones differ, not when assessors differ.

> **Dependency Alert**
>
> **FedRAMP authorisation does not authorise NSS deployment.** A cloud service authorised at FedRAMP Moderate for CUI still requires NSS accreditation review for classified data paths. Conversely, NSS-accredited modules do not automatically satisfy FedRAMP boundary documentation. Plan **three evidence packages** where enterprises operate all three zones — not one package with redactions.

---

## 20.6 Sector Overlay Matrix — Defense, Government, and Critical Infrastructure

The **Sector Overlay Matrix (SOM)** modifies universal TRADE weights, HLM timelines, procurement emphasis, and assurance evidence for sector-specific constraints. Table 20.1 consolidates the defence, government, and critical infrastructure overlay for programme charter annotation.

**Table 20.1 — Sector Overlay: Defense / Government / Critical Infrastructure**

| Dimension | Defence industrial base (DIB) | Government civilian (US) | Critical infrastructure (US OT-heavy) |
|-----------|------------------------------|--------------------------|---------------------------------------|
| **Primary regulatory floor** | CNSA 2.0 (NSS); CMMC; DFARS | FedRAMP; FISMA; NIST 800-53 | NERC CIP; TSA SDs; CISA guidance |
| **TRADE: Threat (T)** | Weight 5 for classified/CUI; HNDL mandatory | Weight 4 for agency mission systems | Weight 5 for safety/process historians |
| **TRADE: Regulatory (R)** | Weight 5 — contract flow-down | Weight 4 — OMB policy | Weight 4 — CIP evidence; state commissions |
| **TRADE: Architectural (A)** | Weight 5 — guard nodes, HSM zones | Weight 4 — cloud boundary | Weight 5 — OT vendor dependencies |
| **TRADE: Data longevity (D)** | Weight 5 — classified archives | Weight 4 — records retention | Weight 5 — 30-year SCADA archives |
| **TRADE: Ecosystem (E)** | Weight 5 — subcontractor sync | Weight 4 — FedRAMP marketplace | Weight 5 — OT vendor roadmaps |
| **HLM default (IT)** | H1 2026–2028; H2 2029–2031 | H1 2027–2029; H2 2030–2032 | H1 on IT demilitarised zone only |
| **HLM default (OT)** | NSS firmware per CNSA | N/A typically | H1 2028–2032; H2 tied to vendor refresh |
| **Procurement emphasis** | Flow-down; NSS/non-NSS separation | FedRAMP marketplace; ATO inheritance | OT vendor evidence; maintenance windows |
| **Assurance emphasis** | CMMC 3PAO; accreditation authority | FedRAMP 3PAO; Ongoing authorisation | NERC evidence; internal audit; CISA VRP |
| **Blocking node pattern** | HSM partition; guard config | Cloud KMS module | CPE firmware; firmware signing chain |
| **Evidence zone model** | Classified / CUI / commercial | Agency ATO boundary | OT / IT / corporate (three lanes) |
| **Executive narrative** | Contract + accreditation risk | ATO continuity | Safety + reliability + cyber |

Programme directors annotate charter wave plans with SOM columns relevant to their estate — Apex uses DIB + partial government civilian; Northfield uses critical infrastructure column exclusively.

---

## 20.7 TRADE Weight Modifications and Wave Sequencing

Chapter 9 introduced TRADE scoring and Migration Priority Index (MPI) calculation. Sector overlays adjust dimension weights — not the scoring mechanics.

### 20.7.1 Defence weight adjustments

For Apex NSS workloads, Priya Nair's programme applied:

| TRADE dimension | Universal default (Ch 9 §9.3) | NSS overlay weight | Modifier | Rationale |
|-----------------|------------------------------|-------------------|----------|-----------|
| Threat (T) | 1.5 | 1.75 | +0.25 | Classified data HNDL exposure |
| Regulatory (R) | 1.25 | **1.75** | **+0.50** | CNSA binding milestones (Ch 9 §9.22) |
| Architectural (A) | 1.25 | 1.50 | +0.25 | Guard and HSM blocking nodes |
| Data longevity (D) | 1.0 | 1.25 | +0.25 | Long-retention mission archives |
| Ecosystem (E) | 0.75 | 1.00 | +0.25 | Subcontractor synchronisation |

Weighted MPI shifts Wave 0 toward **HSM module validation, firmware signing infrastructure, and guard configuration** — not toward corporate SaaS TLS, which scored lower despite executive visibility.

### 20.7.2 Critical infrastructure weight adjustments

James Whitfield's Northfield overlay emphasised:

| TRADE dimension | Universal default (Ch 9 §9.3) | OT overlay weight | Modifier | Rationale |
|-----------------|------------------------------|-------------------|----------|-----------|
| Threat (T) | 1.5 | **1.75** | **+0.25** | Historian and SCADA archive confidentiality (Ch 9 §9.22) |
| Regulatory (R) | 1.25 | 1.40 | +0.15 | NERC CIP audit evidence |
| Architectural (A) | 1.25 | 1.50 | +0.25 | OT vendor firmware dependencies |
| Data longevity (D) | 1.0 | 1.25 | +0.25 | 30-year operational data retention |
| Ecosystem (E) | 0.75 | 1.00 | +0.25 | Three-vendor firmware signing chain |

Northfield's Wave 0 prioritised **firmware CBOM completion and vendor contractual PQC roadmap clauses** (Chapters 6, 16) before WAN IPsec production — reversing the order corporate IT would naturally prefer.

> **Dependency Alert**
>
> **Sector weight modifiers do not override CDG blocking nodes.** Elevating wT or wR for OT historians raises MPI rank — but WAN concentrator firmware may still block archive key rotation paths (Chapter 9 §9.14). Northfield's steering committee learned this when highest threat scores did not produce fastest field deployment; James Whitfield escalated through programme authority, not by rescore alone.

### 20.7.3 "Do not migrate yet" conditions

Sector overlays strengthen Chapter 9's **do not migrate yet** conditions:

| Condition | Sector | Consequence of ignoring |
|-----------|--------|-------------------------|
| OT maintenance window unavailable | CII | Production trip; regulatory incident |
| CMVP gap open on signing partition | DIB | CMMC finding; contract hold |
| Guard configuration unapproved | NSS | Accreditation revocation risk |
| CPE firmware below minimum version | CII | WAN rollback; field truck rolls |
| Subcontractor evidence missing | DIB | Integration test false positive |

---

## 20.8 Critical Infrastructure: OT Continuity Constraints

Critical infrastructure operators protect **safety, reliability, and national economic function** — constraints that supersede IT migration convenience. Northfield Energy Systems illustrates the pattern: a gas transmission operator with OT-heavy estate, corporate IT, and regulatory accountability across NERC, TSA, and CISA — **without EU NIS2 obligations** (Chapter 3, Chapter 15 §15.18).

### 20.8.1 OT versus IT cryptographic divergence

| Property | Corporate IT | Operational technology |
|----------|-------------|------------------------|
| Change window | Monthly maintenance | Annual outage; unplanned = emergency |
| Certificate lifetime | 1–2 years (automated renewal) | 10–20 years embedded in firmware |
| Protocol scope | TLS, SSH, SAML | Modbus/TCP overlays, proprietary, IPsec WAN |
| Validation path | Enterprise HSM, cloud KMS | Vendor-held keys; device buffer limits |
| Failure impact | Service degradation | Physical process impact |
| Inventory source | CBOM, network scan | Firmware CBOM, vendor attestations |

Chapter 7's CBOM methodology extends to OT with additional attributes — `device_class`, `site_id`, `maintenance_window`, `firmware_signing_scheme` — populated by James Whitfield's team for Northfield's fourteen compressor sites and three vendor chains.

### 20.8.2 OT continuity as programme gate

Every OT migration step requires **operations sign-off** — not security sign-off alone. Northfield's steering committee includes **Director of Operations** voting rights on OT wave promotion — a governance adaptation from Chapter 15 that prevents security teams from scheduling rekey windows during peak heating season.

| Gate | IT programme | OT programme |
|------|-------------|--------------|
| Change approval | CAB | OT change board + operations |
| Rollback test | Automated revert | Physical fallback procedure documented |
| Partner sync | API version negotiation | Vendor field engineer availability |
| Evidence | Harness report | Firmware CBOM + vendor attestation |

> **Migration Moment**
>
> *"OT is air-gapped — we have years before PQC matters."*
>
> Air-gapped OT still **verifies firmware signatures** and may **decrypt archived historian data**. Air gap protects network exposure; it does not protect long-confidentiality archives from HNDL (Chapter 2). Northfield's thirty-year SCADA archive scored TRADE Data longevity 5 — higher than corporate email TLS.

---

## 20.9 OT/IT Convergence and Cryptographic Divergence

Modern critical infrastructure converges OT and IT on shared network paths — DMZ concentrators, remote access, historian replication, and cloud analytics. Convergence creates **cryptographic policy collision** at junction points.

**Figure 20.2 — OT/IT Convergence Migration Map (Planning Example)**

```
  FIELD SITES                          ENTERPRISE IT
  ───────────                          ─────────────

  ┌──────────────┐                     ┌──────────────┐
  │ RTU / PLC    │  serial / fieldbus  │ Corporate    │
  │ (20-yr life) │◄───────────────────►│ IT / IdP     │
  └──────┬───────┘                     └──────┬───────┘
         │                                    │
         │ IPsec / private WAN                │ TLS 1.3
         ▼                                    ▼
  ┌──────────────┐      DMZ /           ┌──────────────┐
  │ Site CPE     │      CONVERGENCE   │ API gateway  │
  │ (vendor FW)  │◄─────ZONE─────────►│ (hybrid OK)  │
  └──────┬───────┘                     └──────┬───────┘
         │                                    │
         │                                    │
         ▼                                    ▼
  ┌──────────────┐                     ┌──────────────┐
  │ WAN          │                     │ Cloud        │
  │ concentrator │                     │ historian /  │
  │ (hybrid IKE) │                     │ analytics    │
  └──────┬───────┘                     └──────────────┘
         │
         │  MIGRATION PACE SET BY SLOWEST LAYER:
         │  ─────────────────────────────────────
         │  1. CPE firmware (241/312 below min — Ch 12)
         │  2. RTU firmware verify buffer (Ch 6)
         │  3. Concentrator (qualified 2026)
         │  4. Corporate IT (ready 2027)
         │
         ▼
  ┌──────────────┐
  │ Historian    │  ← archive encryption: HNDL tier 5
  │ (30-yr data) │
  └──────────────┘

  Programme lanes:
  ═══════════════
  [OT lane]  — vendor-led; maintenance-window gated
  [IT lane]  — corporate PQC programme
  [Convergence lane]  — DMZ only; interface cryptography
```

### 20.9.1 Convergence zone policy

Northfield defined **three programme lanes** (Chapter 15 §15.18) with cryptographic policies scoped per lane:

| Lane | Scope | HLM phase (2028) | Owner |
|------|-------|------------------|-------|
| **OT** | Field devices, RTU, compressor controllers | H0/H1 partial | OT security (James Whitfield) |
| **IT** | Corporate, cloud, identity | H1 | Enterprise security |
| **Convergence** | DMZ concentrators, jump hosts, historian replication | H1 hybrid | Joint OT/IT architecture board |

Convergence lane changes require **both** OT and IT sign-off — preventing corporate IT from enabling hybrid TLS on a jump host that OT has not validated for operational impact.

### 20.9.2 Demilitarised zone sequencing

DMZ is where OT/IT cryptographic policies meet. Northfield sequenced DMZ migration **after** concentrator qualification but **before** field CPE bulk refresh — because concentrator-to-corporate paths carried the highest HNDL exposure for cross-domain historian data, while field CPE refresh remained vendor-scheduled through 2031.

---

## 20.10 NERC CIP, TSA, and CISA for US Critical Infrastructure

Northfield's regulatory overlay differs from EU NIS2 — a deliberate teaching point. US critical infrastructure operators map PQC evidence to **sector-specific frameworks** without importing EU directive language into board packs.

### 20.10.1 NERC CIP intersection

NERC Critical Infrastructure Protection standards apply to bulk electric system cyber assets — and gas transmission operators like Northfield face parallel CIP programmes through regional entity requirements and asset categorisation. Cryptographic controls appear across:

| CIP requirement area | PQC programme connection |
|---------------------|-------------------------|
| BES Cyber System categorisation | CBOM asset classification |
| Electronic security perimeters | IPsec/TLS policy at DMZ |
| Remote interactive access | VPN cryptography; MFA key types |
| Vendor electronic remote access | Third-party crypto evidence (Chapter 16) |
| Transient cyber assets | Engineering workstation signing (Chapter 6) |

James Whitfield linked firmware CBOM rows to **CIP compliance documentation** — vendor crypto attestation supporting evidence packages for audits, not as a substitute for technical validation.

### 20.10.2 TSA security directives

Transportation Security Administration security directives for pipeline operators impose **cybersecurity performance requirements** including network segmentation, access control, and incident reporting. TSA does not name post-quantum algorithms — but **state-of-the-art** security measures under directive compliance include documented cryptographic risk assessment and transition planning, analogous to DORA's cryptanalysis developments language (Chapter 3) without EU legal structure.

Northfield's TSA compliance narrative included a **PQC transition appendix** — two pages in the annual cybersecurity assessment describing inventory coverage, OT vendor status, and WAN migration timeline. Plain language; no algorithm mathematics.

### 20.10.3 CISA guidance and sector engagement

CISA's post-quantum cryptography initiative provides awareness materials, inventory guidance, and sector-specific engagement. For critical infrastructure, CISA emphasises:

- Cryptographic inventory as foundation
- OT asset owner engagement with vendors
- Long-lived asset protection against HNDL
- Coordinated disclosure through CISA Vulnerability Response Program where applicable

James Whitfield participated in CISA sector roundtables — not for regulatory mandate, but for **vendor synchronisation intelligence** that informed procurement roadmap audit clauses.

> **Regulatory Lens**
>
> **US critical infrastructure operators should not force NIS2 vocabulary into compliance artefacts.** NIS2 does not apply to Northfield. NERC CIP, TSA, state utility commissions, and CISA guidance provide the evidence framework. The underlying programme machinery — CBOM, CDG, wave plans, assurance — is jurisdiction-agnostic; only overlay annotations and board narrative tone adapt (Chapter 15 §15.18).

---

## 20.11 Air-Gapped Signing and Long-Lived Asset Protection

OT firmware signing frequently operates through **air-gapped ceremony facilities** — engineering workstations disconnected from enterprise networks, physical media transfer, and manual state synchronisation for stateful schemes (Chapter 6).

### 20.11.1 Air-gap signing architecture

| Component | Classical practice | PQC migration adaptation |
|-----------|-------------------|---------------------------|
| Signing workstation | Offline ECDSA with HSM | Offline ML-DSA or LMS with state store |
| State management | N/A (ECDSA) | Physical state media for LMS/XMSS |
| Media transfer | USB with malware scan | Same + larger signature payloads |
| Verification on device | Embedded ECDSA chain | Buffer size validation per vendor |
| Ceremony frequency | Quarterly releases | Unchanged; signature scheme changes |

Northfield's compressor vendor adopted LMS for new hardware revisions — CNSA-driven investment benefiting Northfield's refresh cycle. Legacy devices remained on ECDSA with **documented risk acceptance** tied to hardware end-of-life dates in the CDG — not indefinite classical extension.

### 20.11.2 Long-lived certificate and archive protection

| Asset | Lifetime | PQC concern | Northfield response |
|-------|----------|-------------|---------------------|
| Historian archive | 30 years | HNDL on stored data | Hybrid archive encryption pilot |
| Embedded device cert | 10–20 years | ML-DSA chain size | Vendor hardware refresh linkage |
| WAN IKE identity | 5–7 years | Hybrid IKE on concentrator | CPE dependency gating |
| Firmware trust anchor | Device lifetime | Root key migration | Dual-signature H1 pattern (Chapter 6) |

Chapter 2's HNDL framing drives Northfield's **archive encryption priority** — higher than email TLS, lower than safety-system integrity controls that demand OT continuity above cryptographic upgrades.

---

## 20.12 Firmware and Protocol Transition in OT Context

Sector playbooks connect to Part II and Part IV protocol guidance through OT-specific constraints.

### 20.12.1 Firmware signing (Chapter 6 cross-reference)

Chapter 6 taught stateful versus stateless signature selection for firmware — ML-DSA, SLH-DSA, and LMS under SP 800-208. Northfield's three-vendor chain required **per-vendor signature strategy**:

| Vendor | Device class | Strategy | Status (2028) |
|--------|-------------|----------|---------------|
| Compressor OEM | Field controllers | LMS on new hardware; ECDSA legacy | Dual-sign H1 on releases |
| RTU supplier | Remote terminals | ML-DSA pending buffer upgrade | Vendor roadmap 2030 |
| Eng. workstation | Signing tool | Air-gapped LMS ceremony | Operational |

James Whitfield's programme rejected **synchronised cutover** across vendors — CDG showed independent blocking nodes with independent timelines. Steering committee tracked **three firmware workstreams**, not one enterprise firmware milestone.

### 20.12.2 IPsec WAN migration (Chapter 12 cross-reference)

Chapter 12 documented Northfield's hybrid IKE qualification and CPE firmware blockage — 241 of 312 CPEs below minimum firmware. The sector overlay adds **operational sequencing**:

1. **Concentrator upgrade** — completed 2026 laboratory qualification
2. **Corporate path hybrid** — DMZ to cloud historian; H1 enabled 2027
3. **Regional CPE refresh** — vendor-scheduled; 2029–2031 maintenance windows
4. **Classical sunset on WAN** — H2 gated on CPE threshold >90%

IPsec migration in CII is **field logistics**, not network engineering alone. Northfield's programme office tracked **truck rolls remaining** as a KPI alongside cipher policy — a sector-adapted dashboard metric Chapter 15's template did not originally include.

> **Dependency Alert**
>
> **Concentrator readiness without CPE readiness creates partial security theatre.** Hybrid IKE on the concentrator protects the hub; field sites remain classical-terminated until CPE firmware updates. Document the split honestly in board packs — "WAN hub migrated; field tail pending vendor refresh" — rather than reporting "IPsec PQC complete."

---

## 20.13 HSM Partition Strategy (Chapter 14 Cross-Reference)

Chapter 14 taught KMS migration architecture, HSM assessment matrices, and ceremony adaptation. Sector overlays stress **partition isolation** and **validation-per-zone** discipline.

### 20.13.1 Apex HSM zone architecture

Apex operates HSM partitions across classified, CUI, and corporate zones (Chapter 14 §14.9):

| Partition | Zone | Algorithms (2028) | Validation status |
|-----------|------|-------------------|-------------------|
| P-NSS-ROOT | Classified | ML-DSA-87, AES-256 | Accredited module; closed gap |
| P-CUI-SIGN | CMMC CUI | ML-DSA-65, ECDSA-P384 H1 | ML-DSA gap open — POA&M |
| P-CORP-TLS | Commercial | ML-KEM-768 hybrid, ECDSA | Closed; corporate TLS H1 |
| P-INT-GUARD | Cross-domain | Zone-specific profiles | Guard-configured |

Priya Nair's architecture board prohibited **shared root ceremonies** across NSS and corporate partitions — common vendor appliance, cryptographically separate roots.

### 20.13.2 Northfield custody model

Northfield does not operate classified HSMs — custody is **enterprise plus vendor-held**:

| Custody location | Function | PQC path |
|------------------|----------|----------|
| Enterprise HSM | Corporate PKI, VPN identities | ML-KEM hybrid wrap; ML-DSA CA pending |
| Vendor HSM (OEM) | Firmware signing | LMS air-gapped; contractual evidence |
| Cloud KMS | Historian replication encryption | ML-KEM when provider module listed |
| Device trust store | Field verification | Vendor-delivered chain updates |

Chapter 14 Table 14.1 HSM assessment matrix applies to enterprise custody; OT vendor custody requires **contractual CMVP flow-down** (Chapter 16 §16.12, Chapter 18 §18.19).

---

## 20.14 Assurance and Evidence Packages (Chapter 18 Cross-Reference)

Chapter 18 defined validation coverage matrices, test category matrices, and cross-framework evidence reuse. Sector overlays add **assessor-specific packaging** without duplicate testing.

### 20.14.1 Defence assurance package structure

Apex's CMMC evidence package (Chapter 18 §18.15) organised artefacts by zone:

```
evidence/
├── zone_b_cui_cmmc/
│   ├── validation_matrix_cui_rows.pdf
│   ├── cmvp_certificates/
│   ├── harness_reports_commercial/
│   ├── interop_matrices_partners/
│   ├── poam_ml_dsa_gap.pdf
│   └── config_baselines_cui/
├── zone_a_nss/          [ACCESS RESTRICTED]
│   └── ...              [separate accreditation package]
└── cross_reference_index.pdf   [shareable summary]
```

### 20.14.2 Critical infrastructure assurance package

Northfield's NERC audit evidence and TSA annual assessment reused:

| Artefact | NERC CIP | TSA | Internal audit |
|----------|----------|-----|----------------|
| OT firmware CBOM | ✓ | ✓ | ✓ |
| Vendor validation flow-down | ✓ | ○ | ✓ |
| WAN IPsec interop matrix | ✓ | ✓ | ✓ |
| PQC transition timeline | ○ | ✓ | ✓ |
| OT maintenance window log | ✓ | ○ | ✓ |

○ = supporting, not primary

James Whitfield added **vendor validation flow-down** after Chapter 18's assurance failure analysis — OT devices with vendor-held keys require contractual CMVP evidence, not enterprise self-attestation.

### 20.14.3 PQ-ADAPT sector entry criteria

Sector overlays modify PQ-ADAPT level declarations when enterprises operate under defence or CII constraints:

| Level | Defence / DIB additional evidence | CII additional evidence |
|-------|-----------------------------------|-------------------------|
| **Level 3** | Zone-labelled CBOM; swim lane charter | OT firmware CBOM; three-lane governance |
| **Level 4** | CMMC or accreditation evidence in progress; validation matrix with zone rows | OT vendor clauses executed; WAN or DMZ H1 in production |
| **Level 5** | NSS disallowance per CNSA; zero open zone contamination | OT H2 on refresh cycle; historian archive policy |

An enterprise may legitimately declare **different PQ-ADAPT levels per lane** — Northfield at Level 4 on corporate IT and Level 3 on OT in 2028 is honest maturity reporting, not programme failure.

---

## 20.15 Case Study: Apex Defense Technologies — Year 2 Arc

Apex Defense Technologies — approximately 12,000 employees, mixed NSS and commercial portfolio, CMMC Level 2 and FedRAMP Moderate pursuits — illustrates defence-sector programme execution across two years.

### 20.15.1 Initial conditions (2026)

- PQ-ADAPT Level 3 (*Architected*): algorithm matrix published; CDG blocking nodes identified
- NSS enclave on CNSA 2.0 policy track; corporate IT on NIST IR 8547 track
- HSM partition strategy approved (Chapter 14) but ML-DSA module gap on CUI partition
- CMMC assessment scheduled October 2028

### 20.15.2 Year 1 actions (2027)

| Action | Outcome |
|--------|---------|
| Swim lane steering committees operational | NSS and commercial waves decoupled |
| Subcontractor PQC clause insertion (Tier 1) | 14 of 16 primes amended |
| Validation coverage matrix published | Open gap on P-CUI-SIGN documented |
| Corporate hybrid TLS H1 | Development and staging; production gated on CMMC |
| Cross-domain guard configuration review | Accreditation liaison sign-off |
| Evidence zone taxonomy deployed | Zero contamination incidents |

### 20.15.3 Year 2 results (2028)

| Metric | Result |
|--------|--------|
| CMMC cryptographic controls | MET (one observation: ML-DSA gap) |
| NSS firmware signing | LMS ceremony operational for new releases |
| FedRAMP significant change | Scheduled 2029; impact analysis approved |
| Wave 0 blocking nodes closed | 4 of 6; HSM and guard nodes remain |
| PQ-ADAPT level | Level 4 (*Transitioning*) declared for commercial track |

Priya Nair's board narrative emphasised **interface metrics** — guard throughput, cross-zone policy summary publication, subcontractor evidence completion — rather than a single enterprise percentage migrated.

### 20.15.4 Lessons learned

Three lessons from Apex's arc generalise to DIB programmes. **Lesson one:** assessors reward honest POA&M over false production claims — the ML-DSA module observation was manageable because compensating controls were operational. **Lesson two:** subcontractor synchronisation is ecosystem readiness (TRADE E) — internal readiness without supply-chain evidence produces integration test failures in classified guard paths. **Lesson three:** evidence zone discipline is cultural — tooling and access control must enforce separation because well-intentioned engineers will otherwise copy the fastest path to an assessor deadline.

---

## 20.16 Case Study: Northfield Energy Systems — Year 2 Arc

Northfield Energy Systems — US gas transmission operator, fourteen compressor sites, three OT vendor chains, NERC CIP and TSA accountability — illustrates critical infrastructure execution.

### 20.16.1 Initial conditions (2026)

- PQ-ADAPT Level 2 (*Inventoried*): CBOM baseline with OT extension fields
- WAN concentrator hybrid IKE laboratory-qualified; CPE firmware gap identified (Chapter 12)
- Firmware signing strategy per vendor (Chapter 6); LMS path for one OEM
- No NIS2 obligation; US regulatory overlay per Chapter 15 §15.18

### 20.16.2 Year 1 actions (2027)

| Action | Outcome |
|--------|---------|
| OT firmware CBOM completed | 2,400 field assets catalogued |
| Vendor roadmap audit clauses (Chapter 16) | All three OEMs contractually committed |
| DMZ historian path hybrid encryption H1 | Operations-approved window executed |
| Steering committee operations voting rights | OT change governance formalised |
| TSA assessment PQC appendix | Accepted without finding |
| CISA sector engagement | Vendor intelligence on CNSA-driven LMS investment |

### 20.16.3 Year 2 results (2028)

| Metric | Result |
|--------|--------|
| WAN hub hybrid IKE | Production on Gulf Coast corridor |
| CPE firmware ≥ minimum | 38% (target 90% for H2) |
| Firmware dual-sign H1 | Compressor OEM releases verified |
| NERC CIP audit | No cryptographic finding; 2 observations on vendor evidence timing |
| PQ-ADAPT level | Level 3 (*Architected*) — OT lane; Level 4 on corporate IT lane |

James Whitfield's board pack reported **truck rolls remaining** and **vendor refresh dates** alongside HLM phase — metrics a defence contractor board would not need, but a utility commission expects.

### 20.16.4 Lessons learned

Northfield's arc teaches complementary lessons. **Lesson one:** OT vendor roadmaps driven by CNSA-adjacent customers (defence OEMs) accelerate commercial utility refresh — ecosystem synchronisation flows across sectors even without shared regulation. **Lesson two:** partial migration honesty preserves board credibility — reporting thirty-eight per cent CPE compliance with a named vendor refresh schedule outperforms a green dashboard that field operations cannot sustain. **Lesson three:** operations voting rights on OT waves are not bureaucracy — they prevent security programmes from scheduling cryptography changes during operational peaks that create safety incidents and regulatory scrutiny exceeding any cryptographic audit finding.

---

## 20.17 Unifying Defence and CII Programmes Without Duplication

Enterprises that span defence contracting and critical infrastructure — or hold both DIB and utility subsidiaries — temptation merges programmes for "efficiency." The teaching cases recommend **shared machinery, separate lanes**.

### 20.17.1 What to share

| Shared element | Rationale |
|----------------|-----------|
| Programme office tooling | CBOM platform, GRC repository |
| Procurement clause library | Chapter 16 baseline |
| Test harness infrastructure | Chapter 10 profiles per zone |
| Training and awareness | Algorithm literacy common |
| Vendor relationships | HSM manufacturer negotiations |

### 20.17.2 What to separate

| Separated element | Rationale |
|-------------------|-----------|
| Evidence zones | Classification and assessor boundaries |
| Wave plans | OT maintenance windows ≠ contract renewal cycles |
| Steering metrics | Truck rolls vs accreditation milestones |
| HSM partitions | Zone isolation non-negotiable |
| Regulatory narrative | NERC/TSA language ≠ CMMC language |

### 20.17.3 Interface programme office

Organisations with both DIB and CII holdings benefit from an **interface programme office role** — not to merge zones, but to prevent duplicate vendor assessments and align shared manufacturer roadmaps. Apex and Northfield share no corporate parent in the teaching narrative, but **shared HSM vendor** intelligence flows through industry ISACs — a synchronisation channel Chapter 1's ecosystem dimension describes.

---

## 20.18 Common Sector Failure Modes

| Failure | Symptom | Sector | Remediation |
|---------|---------|--------|-------------|
| Zone contamination | Classified config in CMMC pack | Defence | Evidence taxonomy enforcement |
| NSS timeline on commercial slides | False urgency or false comfort | Defence | Parallel policy tracks |
| OT big-bang migration | Production trip | CII | Maintenance-window governance |
| CPE-last planning | Hub migrated; field classical | CII | CDG tail dependency visibility |
| Vendor attestation as validation | CMVP gap hidden | CII | Contractual flow-down |
| Single enterprise HLM banner | OT dragged into IT phase | CII | Lane-scoped HLM |
| NIS2 vocabulary in US packs | Board confusion | CII | US overlay annotations |
| FedRAMP = NSS | Authorisation overreach | Defence | Separate evidence packages |
| Firmware = IT signing | Wrong ceremony model | CII | Chapter 6 strategy per vendor |
| Partner test generalisation | Interop false positive | Both | Full partner matrix |

---

## 20.19 Cross-Reference Map

| Topic | See |
|-------|-----|
| Stateful firmware signing, LMS/XMSS | Chapter 6 |
| CNSA 2.0 timelines, hybrid policy | Chapter 5 |
| HNDL and historian archive threat | Chapter 2 |
| Regulatory landscape, NIS2 vs US | Chapter 3 |
| CBOM OT extension fields | Chapter 7 |
| CDG blocking nodes, wave gates | Chapters 8–9 |
| IPsec hybrid IKE, CPE dependency | Chapter 12 |
| HSM partitions, ceremony adaptation | Chapter 14 |
| NSS/commercial swim lane governance | Chapter 15 §15.17–15.18 |
| OT vendor procurement | Chapter 16 §16.12 |
| Air-gapped pipeline separation | Chapter 17 §17.14 |
| CMMC evidence, validation matrix | Chapter 18 |
| Financial services sector overlay | Chapter 19 |
| Cloud multinational overlay | Chapter 21 |

---

## 20.20 Apply in Your Organisation

1. **Classify systems** into NSS, CUI/CMMC, FedRAMP, corporate IT, and OT — annotate CBOM rows with zone labels before wave assignment.
2. **Publish parallel policy tracks** where CNSA 2.0 applies to NSS but NIST IR 8547 governs corporate IT — one matrix, multiple authorisation columns.
3. **Deploy evidence zone taxonomy** — separate repositories; cross-reference index only; never promote classified artefacts to commercial packs (§20.4).
4. **Annotate programme charter with SOM Table 20.1** — adjust TRADE weights for defence or CII columns relevant to your estate.
5. **Map CNSA 2.0 milestones to validation dependency timeline** (Chapter 18) — schedule production backward from CMVP listings, not forward from policy dates alone.
6. **Establish OT/IT/convergence lanes** with separate HLM phases and joint sign-off at DMZ (§20.9).
7. **Link firmware strategy to Chapter 6** — per-vendor signature selection; dual-sign H1 where legacy devices persist.
8. **Sequence IPsec per Chapter 12** — hub, DMZ, and CPE tail as separate CDG nodes with honest status reporting.
9. **Implement HSM partition isolation per Chapter 14** — shared vendor appliance permitted; shared root custody forbidden across zones.
10. **Build CMMC/FedRAMP/NERC evidence reuse taxonomy** — shared artefact types, zone-scoped instances (§20.14).
11. **Insert vendor validation flow-down clauses** (Chapters 16, 18) — OT vendor-held keys require CMVP evidence, not attestation slides.
12. **Add sector KPIs to steering dashboard** — accreditation milestones (defence), truck rolls and vendor refresh dates (CII), interface guard metrics (both).
13. **Use US regulatory overlay for US CII** — NERC CIP, TSA, CISA; do not import NIS2 vocabulary where it does not apply.
14. **Engage operations on OT change gates** — security approval necessary but not sufficient for field migration.
15. **Document honest partial migration** — hub migrated / field pending beats enterprise banner claims that erode board trust.

---

## 20.21 Chapter Summary

- **CNSA 2.0 sets the defence floor** for NSS algorithm selection and milestones; commercial and CUI zones require parallel policy tracks with shared procurement leverage.
- **Classified and unclassified boundaries** are architectural — evidence zones, HSM partitions, build pipelines, and promotion rules must enforce separation; cross-reference indexes are shareable, guard configuration is not.
- **CMMC and FedRAMP** evaluate FIPS-validated module boundaries and transition credibility; FedRAMP significant change applies when production modules change; neither substitutes for NSS accreditation.
- **Sector Overlay Matrix Table 20.1** modifies TRADE weights, HLM timelines, procurement emphasis, and assurance evidence for DIB, government civilian, and critical infrastructure columns.
- **Critical infrastructure adds OT continuity constraints** — maintenance windows, vendor firmware dependencies, and safety impacts supersede IT migration convenience.
- **Northfield is US-regulated, not NIS2 subject** — NERC CIP, TSA, and CISA provide the evidence framework; programme machinery remains universal.
- **OT/IT convergence** requires three programme lanes with joint governance at DMZ junctions; migration pace follows the slowest critical layer — often CPE firmware, not concentrators.
- **Air-gapped signing and long-lived assets** demand Chapter 6 signature strategies and archive encryption priorities driven by HNDL exposure on historian data.
- **IPsec and firmware migration** connect to Chapters 12 and 6 — field logistics and vendor workstreams, not single enterprise milestones.
- **HSM partition strategy** (Chapter 14) and **assurance packages** (Chapter 18) apply zone-scoped validation matrices and honest POA&M for open gaps.
- **Apex Year 2** demonstrates CMMC MET with observation, swim lane governance, and Level 4 commercial track declaration.
- **Northfield Year 2** demonstrates partial WAN migration honesty, OT vendor flow-down, and lane-differentiated PQ-ADAPT levels.

**Closing note:** Defence and critical infrastructure programmes fail when enterprises treat federal floors as someone else's problem, or OT constraints as security delays. Priya Nair and James Whitfield succeed by honouring boundaries and continuity — executing the same programme machinery as Meridian and GlobalSync, with sector overlays that make migration credible to assessors, accreditation authorities, and utility commissioners alike.

**Next:** Chapter 21 — *Cloud, SaaS, and Multinational Compliance* applies sector overlays to tenant-isolated architectures, shared responsibility models, and GDPR cross-border evidence. GlobalSync Logistics' three-region programme demonstrates how platform concentration becomes an agility opportunity when governance spans jurisdictions without duplicate programme offices.

---

*Proceed to Chapter 21: Cloud, SaaS, and Multinational Compliance.*

---

*Chapter 20 — References*

- Cybersecurity and Infrastructure Security Agency. (2024–2026). *Post-quantum cryptography initiative* and critical infrastructure guidance. U.S. Department of Homeland Security. https://www.cisa.gov/quantum
- Cybersecurity Maturity Model Certification Program. (2024–2026). *CMMC assessment guides* and Level 2 scoping guidance. U.S. Department of Defense Chief Information Officer. https://dodcio.defense.gov/CMMC/
- FedRAMP Program Management Office. (2024–2026). *FedRAMP authorisation playbook* and significant change policy. https://www.fedramp.gov/
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Institute of Standards and Technology. (2020). NIST SP 800-53 Rev. 5: Security and Privacy Controls for Information Systems and Organizations. https://doi.org/10.6028/NIST.SP.800-53r5
- National Institute of Standards and Technology. (2020). NIST SP 800-171: Protecting Controlled Unclassified Information in Nonfederal Systems and Organizations. https://doi.org/10.6028/NIST.SP.800-171
- National Security Agency. (2022–2025). *Commercial National Security Algorithm Suite 2.0* and CNSSP 15 guidance. https://www.nsa.gov/Cybersecurity/Quantum-Key-Distribution-QKD-and-Post-Quantum-Cryptography-PQC/
- North American Electric Reliability Corporation. (2024–2026). *Critical Infrastructure Protection (CIP) standards*. https://www.nerc.com/pa/Stand/Pages/CIPStandards.aspx
- Transportation Security Administration. (2021–2026). *Pipeline security directives* and cybersecurity performance requirements. U.S. Department of Homeland Security. https://www.tsa.gov/for-industry/pipeline-security
- Committee on National Security Systems. (2022). CNSSP 15: National Security Systems cryptographic policy. (*Via NSA public releases*.)
