# Chapter 5
# Transition Timelines and Hybrid Policy

---

GlobalSync Logistics' VP of Security Engineering, Marcus Chen, faced a board question in April 2025 that sounded simple and was not: *"When will GlobalSync be post-quantum compliant?"*

The board had read NIST's 2035 disallowance date and assumed a single deadline. Marcus knew GlobalSync operated in forty countries with EU entities under DORA, US operations under state privacy and federal customer requirements, and Asia-Pacific tenants referencing ASD and Singapore CSA guidance. A single date would either be misleadingly optimistic or unnecessarily conservative.

Marcus's answer reframed the question: *"We will achieve NIST-aligned deprecation compliance for quantum-vulnerable public-key algorithms in externally facing services by 2030, disallowance by 2035, with NSS-elevated customer contracts on accelerated paths. Internal timelines are derived from our dependency graph — not copied from NIST press releases."*

The board accepted a **timeline overlay** — multiple policy anchors mapped to a single programme with jurisdiction annotations. This chapter teaches how to build that overlay and the hybrid policy that governs the years between today's estate and the PQC-native target state.

---

## 5.1 From Standards Timelines to Enterprise Policy

NIST IR 8547, NSA CNSA 2.0, and national guidance from ASD, NCSC, and allied agencies provide **policy anchors** — dates and terminology that enterprises reference in cryptography policies, board reports, and regulatory evidence. They do not provide **migration schedules**.

The distinction is structural:

| Policy anchor (external) | Migration schedule (internal) |
|--------------------------|-------------------------------|
| Published by standards or government body | Derived from CBOM, CDG, and TRADE analysis |
| Applies uniformly to all organisations in scope | Unique per enterprise estate topology |
| Uses deprecation/disallowance terminology | Uses migration waves, gates, and validation milestones |
| Updated when NIST/NSA revise guidance | Updated quarterly by programme office |

Enterprises that copy NIST dates into project plans without dependency analysis produce schedules that fail on first contact with HSM vendor roadmaps. Enterprises that ignore NIST dates produce policies that fail supervisory review. The correct posture is **alignment without substitution**: internal schedules derived from analysis, justified against external anchors.

Part I established that migration timelines extend 5–15+ years for most enterprises (Campbell, 2025). Part II adds the standards vocabulary for **what** must be achieved by anchor dates. Part III will teach **how** to derive achievable schedules from inventory and dependency data.

---

## 5.2 NIST IR 8547: Deprecation and Disallowance

NIST's Initial Public Draft of IR 8547 (November 2024; **subject to revision before final publication**) articulates the expected transition for quantum-vulnerable public-key algorithms at the 112-bit security level — the category encompassing RSA-2048, finite-field DH-2048, and ECC P-256. Enterprise policies should reference IR 8547 as a **planning anchor**, monitor NIST for final text, and avoid embedding draft language verbatim in contractual instruments without legal review.

### Key definitions

**Deprecation** means an algorithm is no longer recommended for new applications. Continued use in existing systems may be permitted with **documented risk acceptance** during a transition period. Deprecation is not permission to ignore migration — it is recognition that immediate universal replacement is infeasible.

**Disallowance** means an algorithm is removed from approved use. Systems continuing to use disallowed algorithms are non-compliant with NIST-aligned policy. Disallowance is the target end state for quantum-vulnerable PKC in federal and NIST-referenced environments.

### Timeline anchors

| Milestone | Target (IR 8547 IPD) | Enterprise implication |
|-----------|---------------------|------------------------|
| PQC standards available | August 2024 (achieved) | Algorithm policy can reference FIPS 203–205 |
| Deprecation of quantum-vulnerable PKC (112-bit) | After 2030 | New deployments should use PQC; legacy requires risk acceptance |
| Disallowance of quantum-vulnerable PKC | After 2035 | No quantum-vulnerable PKC in compliant systems |

These dates inform revisions to SP 800-131A and related NIST transition documents. Federal contractors, FedRAMP-authorized cloud providers, and enterprises whose auditors reference NIST guidance will encounter them as **de facto compliance milestones** — regardless of whether the enterprise is legally bound by federal regulation.

> **Migration Moment**
>
> *"2035 is nine years away. We have plenty of time."*
>
> Nine years is the **disallowance anchor** for final quantum-vulnerable algorithm retirement — not the time available before programme work completes. Inventory, dependency resolution, vendor validation, partner coordination, and hybrid interim deployment consume most of the horizon. Campbell's 2025 analysis estimates 8–15+ years for large-enterprise migration under baseline assumptions. Enterprises beginning discovery in 2030 will not achieve disallowance compliance by 2035.

### Risk acceptance under deprecation

During the deprecation period, enterprises may operate quantum-vulnerable algorithms on specific systems with documented risk acceptance. Risk acceptance is not a waiver of migration obligation — it is a **time-bounded exception** requiring:

- System identification in the CBOM with quantum-vulnerable flag
- TRADE scoring demonstrating why migration cannot complete before deprecation
- Blocking dependency documentation (CDG reference)
- Named owner and review date (maximum twelve months)
- CISO or delegated authority approval

Meridian's risk acceptance template required supervisory-notification assessment for systems holding regulated financial data — ensuring legal review before exceptions entered audit evidence.

---

## 5.3 CNSA 2.0 Milestones

NSA's Commercial National Security Algorithm Suite 2.0 imposes binding requirements for National Security Systems and influences defence industrial base contractors through CMMC, FedRAMP, and contract flow-down.

**Table 5.1 — CNSA 2.0 Milestone Summary**

| Date | Requirement |
|------|-------------|
| 2025 | CNSA 2.0 algorithms approved for use in NSS |
| 2025–2027 | Transition planning; CNSA 1.0 phased out |
| 2027 | New NSS acquisitions must support CNSA 2.0 |
| 2030 | PQC firmware signing required; networking products CNSA 2.0 compliant |
| 2033 | Most NSS platforms migrated |
| 2035 | Full NSS migration complete |

CNSA 2.0 mandates ML-KEM-1024, ML-DSA-87, and SLH-DSA — the Category 5 parameter profile. Apex Defense Technologies treats CNSA dates as **floors** for NSS workloads: internal schedules may be more aggressive where ecosystem readiness permits, but not less aggressive without waiver authority.

Commercial IT within defence enterprises follows NIST IR 8547 unless contract flow-down elevates specific programmes. The dual-track overlay — introduced in Chapters 3 and 4 — is the operational pattern, not an optional simplification.

---

## 5.4 Allied National Timelines

Enterprises operating outside the US federal context still encounter NIST-influenced timelines through auditors, customers, and international alignment. National agencies publish complementary guidance:

**Table 5.2 — National Timeline Comparison (Planning Reference)**

*Extends Chapter 3 Table 3.4 with enterprise planning columns. Regulatory instrument detail remains in Chapter 3; this table supports timeline policy derivation.*

| Authority | Discovery/planning | Deprecation posture | Disallowance/target |
|-----------|-------------------|---------------------|---------------------|
| NIST IR 8547 | Now (standards final) | Post-2030 | Post-2035 |
| NSA CNSA 2.0 | 2025–2027 | 2030 (firmware, networking) | 2035 (full NSS) |
| UK NCSC | By 2028 | Migration execution 2028–2035 | 2035 alignment |
| Australian ASD | Now | Cease traditional asymmetric crypto by 2030 | 2035 ecosystem |
| EU (DORA/NIS2) | State of the art now | No fixed EU-wide date | Supervisory expectation |

No single row governs a multinational enterprise. GlobalSync's regulatory overlay matrix (Chapter 3) tags each programme artefact with applicable anchors per jurisdiction. The **most aggressive applicable anchor** in each jurisdiction sets the planning floor — not the most permissive.

---

## 5.5 Deriving Internal Timelines

Internal migration timelines are outputs of programme analysis, not inputs from standards documents. The derivation process:

### Step 1: CBOM baseline

Identify all quantum-vulnerable PKC implementations. Without inventory, timeline estimates are fiction. Part III develops CBOM methodology; Part II assumes its existence for timeline planning.

### Step 2: TRADE prioritisation

Score systems using the TRADE engine (Chapter 2). High MPI systems anchor the near-term waves. Low MPI systems migrate during natural refresh cycles or decommission.

### Step 3: CDG blocking analysis

Identify blocking nodes whose migration gates downstream systems. Timeline critical path runs through blocking nodes — not through the highest-visibility external TLS endpoints.

### Step 4: Ecosystem readiness assessment

Vendor roadmaps, partner trust store updates, and protocol ecosystem maturity gate **production deployment dates** — not planning start dates. A system with MPI 4.39 and Ecosystem readiness 2 (Meridian's PII KMS, Chapter 2) begins vendor escalation immediately but may not reach production until 2027.

### Step 5: Anchor alignment

Map derived waves to external policy anchors. If TRADE analysis requires TES 5 system migration before 2030 but ecosystem readiness gates production to 2029, document the constraint and initiate risk acceptance only if migration genuinely cannot accelerate — not if programme priority was insufficient.

**Figure 5.1 — Multi-Jurisdiction Timeline Overlay**

```
2024    2026    2028    2030    2032    2034    2035
  |       |       |       |       |       |       |
  FIPS    |       NCSC    |       |       |       |
  203-205 |       plan    |       |       |       |
  final   |       complete|       |       |       |
          |               |       |       |       |
          +-- Programme --+-------+-------+-------+
          |  Wave 1 (TES 5, blocking nodes)      |
          |       Wave 2 (TES 4, PKI)            |
          |               Wave 3 (general IT)    |
          |                       |       |       |
          |                       v       |       |
          |              NIST DEPRECATION anchor  |
          |                               v       |
          |                      NIST DISALLOWANCE |
          |                               anchor  |
          |                                       |
  CNSA 2.0: 2027 new acquisitions --+             |
          2030 firmware/networking -+             |
```

**Production brief — Figure 5.1:** Swim-lane diagram with programme waves (internal schedule) overlaid on policy anchors (NIST, CNSA, NCSC). Distinguish solid lines (anchors) from dashed lines (derived waves). Include legend for jurisdiction annotations used by multinational enterprises.

---

## 5.6 The Hybrid Lifecycle Model (HLM)

Near-term production deployment requires **hybrid cryptography** — combining classical and post-quantum algorithms so security holds if either component remains sound. Hybrids solve interoperability during transition. They create governance risk if deployed without sunset criteria.

The Hybrid Lifecycle Model defines three phases with explicit exit criteria — the book's framework for governing hybrids as transitional states, not permanent architectures.

**Table 5.3 — Hybrid Lifecycle Model Phases**

| Phase | Name | Objective | Entry criterion | Exit criterion |
|-------|------|-----------|-----------------|----------------|
| **H1** | Protective Hybrid | Maintain interoperability; add quantum resistance | PQC algorithm selected; ecosystem partially ready | Ecosystem threshold met (e.g., >90% client/partner support for PQC component) |
| **H2** | Transitional Hybrid | Reduce classical dependency | H1 exit achieved; classical deprecation policy active | Classical component deprecated in enterprise policy; new deployments PQC-only |
| **H3** | PQC-Native | Remove quantum-vulnerable PKC | H2 exit achieved; validation complete | CBOM confirms zero disallowed algorithms in scope |

### H1: Protective Hybrid

H1 is the deployment phase most enterprises occupy in 2026–2028. Hybrid TLS (X25519 + ML-KEM-768), hybrid code signing (classical + ML-DSA), and hybrid VPN configurations maintain backward compatibility while adding quantum resistance.

**H1 governance requirements:**

- Hybrid construction must reference standards-track specifications (IETF), not proprietary combinations
- Classical component identified and logged in CBOM
- Sunset date or phase-gate for H2 transition assigned at deployment approval
- Monitoring for ecosystem readiness metrics (client support, partner acceptance)

GlobalSync's H1 hybrid TLS deployment targeted 92% client compatibility before declaring H1 exit for its public API tier — measured against production traffic analysis, not laboratory tests.

### H2: Transitional Hybrid

H2 reduces classical dependency. New deployments within scope use PQC-only where ecosystem permits. Legacy systems retain hybrid or classical-only with documented risk acceptance and migration dates.

**H2 governance requirements:**

- Enterprise policy deprecates classical component for new deployments in scope
- Exception process for classical-only new deployments (rare; heavily documented)
- Quarterly CBOM review of systems remaining in H1

### H3: PQC-Native

H3 is the target state: quantum-vulnerable PKC removed from the estate per disallowance policy. Hybrids are retired. CBOM verification confirms compliance.

**H3 governance requirements:**

- Internal audit or automated CBOM scan confirms zero disallowed algorithms
- Penetration testing validates no regression to classical-only in scope
- Regulatory evidence package updated for supervisory review

> **Architect's Decision**
>
> **Do not deploy H1 hybrids without a documented H2 trigger.** The trigger may be ecosystem metrics (90% client support), a calendar date (aligned to 2030 deprecation), or a vendor milestone (HSM PQC module GA). Hybrids without triggers become permanent dual-algorithm architectures — the SHA-1 equivalent failure mode for PQC.

### HLM failure modes by phase

| Phase | Typical failure | Programme symptom | Recovery |
|-------|----------------|-------------------|----------|
| **H1** | No H2 trigger defined | Hybrid deployed indefinitely | Policy committee assigns trigger retroactively; audit finding likely |
| **H1** | Ecosystem threshold never met | Stuck at 70–85% client support for years | Segment traffic; tiered endpoints; tenant outreach programme |
| **H2** | Classical component not deprecated in policy | New systems still ship classical-only | Policy update; SDLC gate enforcement |
| **H2** | Exception register grows without sunset | Hundreds of "temporary" classical systems | Steering committee cap on exceptions; executive escalation |
| **H3** | CBOM scan false negatives | Quantum-vulnerable PKC in shadow IT | Expand discovery; automated scanning in CI/CD |
| **H3** | Partner lag | Enterprise H3 but partner classical-only | Partner programme; contractual upgrade clauses |

Apex Defense documented HLM failure modes in programme risk register — NSS programmes hitting H2 before commercial IT completed H1 created engineering confusion until matrix rows clarified independent phase tracking per workload class.

### CBOM attributes for HLM tracking

Part III develops full CBOM methodology. Part II defines minimum attributes for hybrid governance:

| Attribute | Values | Purpose |
|-----------|--------|---------|
| `hlm_phase` | H1, H2, H3 | Current lifecycle phase |
| `h2_trigger_type` | ecosystem, calendar, vendor, dependency | Trigger category |
| `h2_trigger_value` | e.g. `90%_client_support`, `2030-01-01`, `vendor_module_GA` | Measurable exit condition |
| `classical_component` | e.g. `ECDSA_P256`, `RSA_2048` | Algorithm to sunset |
| `pqc_component` | e.g. `ML-KEM-768`, `ML-DSA-65` | Target algorithm |
| `hybrid_construction_ref` | IETF RFC/draft ID or vendor profile ID | Standards traceability |
| `exception_id` | Link to risk acceptance register | Audit trail |

GlobalSync automated `hlm_phase` assignment in its CBOM pipeline — systems without `h2_trigger_value` failed change-management approval for hybrid deployments.

---

## 5.7 Enterprise Hybrid Policy Requirements

Hybrid policy belongs in the **Policy layer** of the PQC Governance Stack (Chapter 3). A complete hybrid policy addresses:

### Approved hybrid constructions

List permitted combinations by use case:

| Use case | Approved H1 construction | Standards reference |
|----------|--------------------------|---------------------|
| TLS 1.3 | X25519 + ML-KEM-768 | IETF standards-track hybrid |
| VPN (IKEv2) | ECDH + ML-KEM (per vendor/IETF profile) | Vendor-validated profile |
| Code signing | Classical + ML-DSA dual signature | Organisation-defined; CMS updates |
| Email (S/MIME) | Classical + ML-DSA | IETF/CMS profile when available |

Prohibited: ad hoc hybrid combinations without cryptanalysis-backed construction proofs; hybrids using deprecated classical algorithms (RSA-1024, ECDSA with weak curves); permanent hybrid deployment without H2 trigger.

### Sample hybrid policy language

The following excerpt illustrates Policy-layer tone — organisation-specific legal review required:

> **Hybrid Cryptography Standard (excerpt)**
>
> 1. Near-term production deployments of quantum-vulnerable protocols shall implement Protective Hybrid (H1) constructions listed in Annex B unless Ecosystem readiness assessment (TRADE dimension E ≥ 4) supports PQC-native deployment.
> 2. Every H1 deployment shall record `h2_trigger_type` and `h2_trigger_value` in the Cryptographic Bill of Materials before production approval.
> 3. Classical components in approved hybrid constructions are deprecated for new deployments effective 1 January 2030, aligned to NIST IR 8547 planning anchors. Continued classical use requires entry in the Risk Acceptance Register (Annex C).
> 4. Transitional Hybrid (H2) begins when H1 exit criteria are met for a defined scope (service tier, business unit, or estate segment). H2 scopes shall not regress to classical-only new deployments without CISO exception.
> 5. PQC-Native (H3) is the target state for all in-scope systems by 31 December 2035 unless disallowance policy is revised following NIST final guidance.

Meridian adopted language closely matching this structure — enabling Thomas Bergström's team to demonstrate policy-to-CBOM traceability in supervisory dialogue.

### Phase assignment rules

Every system receiving hybrid deployment is assigned H1 with an H2 trigger at change approval. CBOM entries include `hlm_phase` attribute: H1, H2, or H3.

### Classical component sunset

Enterprise policy names the classical algorithms subject to sunset — typically RSA, finite-field DH, ECDSA, EdDSA at enterprise-standard key sizes. Sunset means: no new deployments after date X; existing deployments migrate by date Y.

### Performance and operational limits

Hybrids increase handshake size, signature size, and CPU cost. Policy should reference infrastructure assessment requirements before H1 production approval — preventing deployment on systems that cannot sustain operational load.

---

## 5.8 Exceptions and Risk Acceptance

Exceptions are inevitable. Exceptions without governance are compliance failures.

### Exception types

| Type | Example | Maximum duration | Approval |
|------|---------|------------------|----------|
| **Ecosystem-gated** | HSM vendor PQC module unavailable | Until vendor delivery + 90 days integration | CISO |
| **Partner-gated** | Acquiring bank trust store delay | Until partner confirmation + 6 months | CISO + business owner |
| **Technical constraint** | OT device cannot accommodate ML-DSA chain | Until device refresh or compensating control | CISO + OT security |
| **Deprecation risk acceptance** | Legacy system retiring 2029 | Until decommission date | CISO; legal review if regulated data |

### Exception documentation

Each exception requires a CBOM record with: algorithm in use, TRADE scores, blocking dependency reference, compensating controls, review date, and named owner. Exceptions expiring without remediation escalate to steering committee — not silent renewal.

Meridian limited ecosystem-gated exceptions to **two renewal cycles** before steering committee escalation to the board risk committee — preventing perpetual "waiting for vendor" status.

---

## 5.9 Sunset Criteria and Deprecation Governance

Sunset criteria convert policy anchors into operational gates. Effective sunset governance includes:

### Calendar-based sunsets

Aligned to NIST IR 8547: no new quantum-vulnerable PKC deployments after 2030; no quantum-vulnerable PKC in production after 2035. Calendar sunsets apply to the enterprise default — exceptions require the process above.

### Ecosystem-based sunsets

H1 → H2 transition triggered when measured client/partner support exceeds threshold. GlobalSync used production TLS handshake analytics — not synthetic monitoring — to measure PQC client support.

### Dependency-based sunsets

Blocking node resolution triggers downstream migration waves. When Meridian's HSM firmware signing chain reaches H3, twelve dependent systems become eligible for accelerated migration — a CDG-driven sunset cascade.

### Exception register structure

Maintain a live exception register — not spreadsheet fragments across teams. Minimum fields:

| Field | Purpose |
|-------|---------|
| System ID | CBOM cross-reference |
| Algorithm in use | Classical scheme and key size |
| Exception type | Ecosystem / partner / technical / deprecation |
| TRADE MPI | Prioritisation context |
| Blocking dependency | CDG node reference |
| Compensating controls | Active risk reduction |
| Approval authority | Named individual and date |
| Review date | Maximum twelve months |
| Sunset or remediation date | Hard stop |

Steering committee reviews exceptions exceeding two renewal cycles — preventing perpetual classical PKC in TES 5 systems.

### Policy review cadence

Cryptography policy and sunset dates are reviewed **quarterly** by the programme office and **annually** by the policy committee. NIST IR 8547 revisions, CNSA updates, and regulatory publications trigger ad hoc review.

---

## 5.10 GlobalSync: Multinational Policy Variants

GlobalSync Logistics operates a **single global programme** with **jurisdiction annotations** — the pattern introduced in Chapter 3 for regulatory compliance, applied here to timeline and hybrid policy.

**Table 5.4 — GlobalSync Timeline Overlay (Excerpt)**

| Programme element | Global default | EU annotation | US annotation | APAC annotation |
|-------------------|---------------|---------------|---------------|-----------------|
| Algorithm policy | FIPS 203–205 | Same; DORA evidence tag | Same; FedRAMP customer overlay | Same; ASD 2030 reference |
| H1 hybrid TLS | Approved | Same | Same | Same |
| Deprecation target | 2030 | DORA state-of-the-art | NIST IR 8547 | ASD 2030 |
| Disallowance target | 2035 | Supervisory alignment | NIST IR 8547 | ASD 2035 |
| NSS customer contracts | CNSA 2.0 elevated | Per contract | Per contract | Per contract |

Marcus Chen's board presentation used the global default row — jurisdiction annotations appeared in appendix slides for regional compliance officers, not in the executive summary. The board needed one programme; compliance teams needed annotated evidence.

GlobalSync's failed first-year approach — separate EU and US PQC programmes — produced contradictory hybrid policies and duplicated CBOM effort. Consolidation under Marcus's global programme office reduced compliance staff effort by an estimated thirty percent (Chapter 3) and eliminated a case where EU pilots deployed different hybrid constructions than US production.

---

## 5.11 Meridian: DORA-Aligned Timeline Evidence

Meridian Mutual Bank linked timeline policy to DORA supervisory evidence. Thomas Bergström's regulatory team mapped:

- **Encryption policy** (Policy layer) → names algorithms and sunset dates
- **Certificate register** (Operational layer) → DORA RTS requirement; tracks classical vs PQC certificates
- **Migration plan** (Programme layer) → wave schedule with TRADE justification
- **Risk acceptance register** (Assurance layer) → documents deprecation-period exceptions

Supervisory dialogue in Meridian's home jurisdiction focused on whether the **migration plan's timeline was credible given vendor dependencies** — not whether Meridian had selected the correct lattice parameters. Thomas's team presented HSM vendor correspondence, TRADE scores, and CDG blocking analysis as timeline evidence. Algorithm standards (Chapter 4) were referenced but not debated.

> **Regulatory Lens**
>
> DORA does not specify 2030 or 2035. It requires encryption policies responsive to cryptanalytic developments. An enterprise that presents NIST-aligned sunset dates **justified by risk assessment and dependency analysis** demonstrates state-of-the-art practice. An enterprise that presents dates without CBOM backing demonstrates policy theatre.

---

## 5.12 PQ-ADAPT and HLM Integration

The PQ-ADAPT maturity model (book architecture) connects HLM to programme progression:

| PQ-ADAPT level | HLM requirement |
|----------------|-----------------|
| Level 2 — Inventoried | CBOM identifies hybrid vs classical-only systems |
| Level 3 — Architected | Hybrid policy defined; H1 constructions approved; H2 triggers documented |
| Level 4 — Transitioning | Production H1/H2 deployments; risk acceptance register active |
| Level 5 — Quantum-Resilient | H3 achieved; CBOM confirms disallowance compliance |

Enterprises self-assessing at Level 3 after writing hybrid policy on paper — without H1 production deployments or H2 triggers — are overestimating maturity. Level 3 requires **approved policy plus architectural standards embedded in SDLC and change management**.

---

## 5.13 Apex Defense: NSS Timeline Floors

Apex Defense Technologies maps CNSA 2.0 milestones as **non-negotiable floors** for NSS workloads while applying NIST IR 8547 anchors to corporate IT. Priya Nair's programme office maintains a timeline overlay with separate swim lanes:

| Milestone | NSS track | Corporate IT track | Conflict resolution |
|-----------|-----------|-------------------|---------------------|
| 2027 new acquisitions | CNSA 2.0 required | NIST-aligned planning | Contract review flags NSS flow-down |
| 2030 firmware signing | ML-DSA-87 / LMS | Hybrid code signing H1 | Shared PKI team prioritises NSS queue |
| 2030 deprecation | NSS largely PQC-native | Deprecation with risk acceptance | Board reports separate RAG status per track |
| 2035 disallowance | Full NSS migration | Disallowance target | Single programme; dual evidence packages |

When NSS programmes required H2 entry before corporate IT completed H1, Apex's steering committee approved **parallel phase tracking** — not forced synchronisation across classification boundaries. Corporate IT did not delay NSS compliance; NSS did not relax corporate IT ecosystem gates.

---

## 5.14 Northfield Energy: Wave 1 Capital and Timeline Anchors

Northfield's TRADE analysis (Chapter 2) elevated VPN concentrators and firmware signing to Wave 1 — linking threat urgency to capital planning before 2030 deprecation anchors.

| Wave 1 asset | TRADE driver | Capital estimate (*illustrative*) | Anchor alignment |
|--------------|-------------|----------------------------------|------------------|
| WAN VPN concentrators (2 models) | TES 5; HNDL on SCADA archives | $2.8M hardware refresh | Pre-2030 deprecation |
| Compressor firmware LMS programme | TES 5; firmware forgery | $1.1M vendor + signing appliance | CISA PQC initiative alignment |
| RTU dual-sign programme | TES 4–5 | $0.4M vendor engineering | 2028 pilot / 2030 deprecation |

James Whitfield presented Wave 1 to the board as **threat-driven capital** — not as a response to a single regulatory date. Regulatory anchors (CISA, NERC CIP evidence) provided secondary justification. The distinction mattered: Northfield's board approved threat-driven spend more readily than compliance-driven spend with ambiguous ROI.

Northfield's internal schedule targets 2028 completion for Wave 1 — **ahead of** NIST 2030 deprecation — because OT refresh cycles and vendor lead times require early commitment, not because regulation mandated 2028.

---

## 5.15 Hybrid TLS: Operational Deep Dive

TLS is the most common H1 deployment target — and the most common source of false programme confidence. Operational depth beyond pilot success separates production-ready hybrid policy from slide-deck compliance.

### Client compatibility measurement

Measure compatibility from **production traffic**, not synthetic scans. GlobalSync analysed thirty days of API TLS handshakes, classifying clients by negotiated cipher suite and ClientHello extensions. Clients not sending supported hybrid extensions were enumerated by tenant and revenue impact — enabling commercial conversations with high-value tenants before deprecating classical-only paths.

**Table 5.5 — Client Compatibility Tiers**

| Tier | Definition | Programme action |
|------|------------|------------------|
| A — PQC-capable | Negotiates hybrid successfully | Full H1 deployment |
| B — Classical only, updatable | Legacy client; vendor patch available | Tenant notification; sunset date |
| C — Classical only, fixed | Embedded integration; no update path | Risk acceptance; compensating controls |
| D — Unknown | Insufficient handshake logging | Instrument before migration |

> **Dependency Alert**
>
> **TLS hybrid pilots succeed on unconstrained endpoints; production fails at middleboxes.** Load balancers, IDS/IPS platforms, SSL inspection proxies, and mobile carrier gateways enforce buffer limits invisible to application-team pilots. Assess infrastructure **before** board approval of H1 production dates — not after pilot demonstration.

### Middlebox and infrastructure assessment

Hybrid handshakes exceed classical sizes. Infrastructure assessment checklist:

- Load balancer maximum handshake buffer
- IDS/IPS reassembly limits
- CDN edge configuration
- Corporate proxy SSL inspection buffers
- Mobile network carrier middleboxes (for consumer-facing services)

Northfield assessed VPN concentrators separately from TLS — IKE hybrid constructions carry different fragmentation behaviour. Two concentrator models required hardware refresh before hybrid deployment; refresh was funded as Wave 1 capital expenditure linked to TES 5 scoring.

### Cipher suite policy

Enterprise TLS policy should name **approved cipher suites** including hybrid combinations — not "TLS 1.3 with PQC." Examples at time of writing follow IETF standards-track naming; policy owners must update as specifications finalise:

- Hybrid key exchange: X25519MLKEM768 or equivalent standards-track identifier
- Prohibited: non-standard hybrid combinations; classical-only for new deployments post-H2 entry

### Certificate lifecycle integration

Hybrid TLS requires certificates signed with ML-DSA (or transitional classical certificates during early H1). Certificate lifecycle management — issuance, renewal, revocation, transparency logging — must accommodate larger certificates and new CA hierarchy plans (Chapter 12). Timeline policy without PKI roadmap integration fails at first renewal cycle.

---

## 5.16 Board and Executive Reporting on Timelines

Executives require timeline communication without algorithm detail. Effective board reporting structure:

**Slide 1 — Policy anchors:** NIST 2030/2035, applicable CNSA or national dates — one row per jurisdiction for multinationals.

**Slide 2 — Programme waves:** Three to five waves with business-language descriptions ("customer data key management," not "ML-KEM-768 key wrap").

**Slide 3 — Critical path:** Top three blocking dependencies with owner and status — ecosystem gates explicit.

**Slide 4 — HLM status:** Percentage of estate in H1/H2/H3 by criticality tier — not percentage of pilots completed.

**Slide 5 — Exceptions:** Count and aggregate risk acceptance exposure; ageing exceptions highlighted.

**Slide 6 — Investment:** Current-year spend vs programme budget; capital vs operational split for OT refresh.

Marcus Chen's board deck never mentioned lattice cryptography. It reported that Wave 1 — tenant API authentication and key management — was ecosystem-gated on two HSM products with validated ML-KEM modules expected Q3 2026, and that risk acceptance covered fourteen Tier-C legacy clients representing **2.1%** of API traffic (*illustrative*).

---

## 5.17 Integration with Zero Trust and Identity Programmes

Enterprises running Zero Trust architecture programmes alongside PQC migration must integrate timeline policy — not sequence blindly.

### Shared dependencies

Zero Trust and PQC programmes share:

- PKI engineering capacity
- HSM and key management infrastructure
- Identity provider certificate profiles
- Device authentication and attestation chains

### Policy integration options

| Approach | When appropriate | Risk |
|----------|------------------|------|
| **Unified programme** | Sufficient staff; executive sponsorship for combined charter | Programme complexity |
| **PQC embedded in Zero Trust standards** | Zero Trust is primary executive mandate | PQC deprioritised within identity workstreams |
| **Parallel with shared PKI governance** | Resource constraints require separate charters | PKI team bottleneck (Apex pattern, Chapter 1) |
| **Serial: Zero Trust first** | Rare; only if identity gaps are acute breach drivers | PQC delayed past regulatory comfort |

Chapter 1's Dependency Alert recommended embedding PQC agility in Zero Trust standards when both programmes are active. Timeline policy should reference both charters — sunset dates for quantum-vulnerable PKC in device authentication certificates align with Zero Trust certificate renewal cycles.

---

## 5.18 Conducting a Timeline Alignment Workshop

Before publishing enterprise timeline policy, run a alignment workshop connecting standards anchors to estate reality.

**Participants:** Programme director, enterprise architect, PKI lead, OT lead (if applicable), regulatory affairs, vendor management, finance planner.

**Inputs:** Draft CBOM summary; top ten TRADE-scored systems; vendor roadmap letters; regulatory overlay matrix.

**Agenda (full day):**

1. **Anchor review** (60 min) — confirm applicable NIST, CNSA, national, contractual dates
2. **Critical path mapping** (90 min) — CDG blocking nodes vs anchor dates; identify conflicts
3. **Wave drafting** (90 min) — assign systems to waves; no calendar dates yet — sequence only
4. **Ecosystem gate assessment** (60 min) — vendor validation dates vs wave sequence
5. **Calendar assignment** (60 min) — map waves to quarters; document conflicts requiring risk acceptance or accelerated investment
6. **Executive narrative** (30 min) — draft board slide structure

**Outputs:** Timeline overlay diagram; wave schedule with TRADE justification; risk acceptance preliminary list; investment gaps for finance planning.

Meridian's workshop identified that Wave 1 could not achieve 2030 deprecation for payment HSM chain without vendor acceleration — producing a board request for executive engagement with the HSM vendor's CEO office, not merely procurement escalation.

---

## 5.19 Common Hybrid Policy Failures

**Permanent hybrid.** H1 deployed without H2 trigger; classical component never sunset. Dual attack surface indefinitely.

**Pilot-as-production.** Hybrid TLS on one load balancer declared "PQC complete" while 94% of estate remains classical-only without risk acceptance.

**Inconsistent constructions.** EU region deploys IETF hybrid; US region deploys vendor-proprietary hybrid. Interoperability testing does not cover cross-region traffic.

**Missing CBOM annotation.** Hybrid systems not flagged in inventory; auditors cannot distinguish transitional from target-state deployments.

**Calendar denial.** Internal schedule ignores 2030 deprecation because "our refresh cycle is 2032" — without risk acceptance or accelerated refresh business case.

---

## 5.20 Apply in Your Organisation

1. **Publish a timeline overlay** mapping NIST, CNSA, and applicable national anchors to your programme waves — distinguish anchors from internal schedules.
2. **Adopt the HLM** with mandatory H2 triggers on every H1 deployment — no permanent hybrids.
3. **Define risk acceptance templates** for deprecation-period classical PKC — maximum duration, approval authority, CBOM fields.
4. **Measure ecosystem readiness** with production traffic data for TLS/client hybrids — not lab tests alone.
5. **Consolidate multinational programmes** under one policy with jurisdiction annotations — avoid parallel regional programmes.

---

## 5.21 HLM Governance Cadence

Sustaining HLM across a decade requires operational rhythm — not one-time policy publication.

| Cadence | Activity | Owner |
|---------|----------|-------|
| Weekly | Change approvals verify `h2_trigger` populated for hybrid deployments | Change management |
| Monthly | CBOM `hlm_phase` distribution report to programme office | Crypto engineering |
| Quarterly | Exception register review; ecosystem readiness remeasurement | PQC steering committee |
| Annually | Hybrid policy review; anchor date alignment with NIST/NSA updates | Policy committee |
| Per release | SDLC gate: no classical-only new deployments in H2 scope | Application security |

Meridian added HLM phase distribution to the board dashboard introduced in Chapter 1 — replacing misleading "PQC pilot complete" counts with percentage of estate in H1/H2/H3 by criticality tier.

---

## 5.22 Chapter Summary

- NIST IR 8547 (IPD) provides deprecation (post-2030) and disallowance (post-2035) anchors for quantum-vulnerable PKC — not enterprise migration schedules.
- CNSA 2.0 imposes more aggressive milestones for NSS and defence industrial base workloads.
- Internal timelines derive from CBOM, TRADE, CDG, and ecosystem readiness — aligned to, not copied from, external anchors.
- The Hybrid Lifecycle Model (H1 Protective → H2 Transitional → H3 PQC-Native) governs interim hybrids with explicit exit criteria.
- Hybrid policy must specify approved constructions, phase assignment, classical sunset, and exception governance.
- Multinational enterprises use one programme with jurisdiction annotations — not parallel policies.
- DORA and EU frameworks require credible timeline evidence linked to risk assessment — not algorithm expertise.

**Next:** Chapter 6 addresses deployments where FIPS 204 and 205 do not cleanly fit: firmware signing, embedded systems, and stateful hash-based signatures under SP 800-208.

---

*Chapter 5 — References*

- Campbell, R. (2025). Enterprise migration to post-quantum cryptography: Timeline analysis and strategic frameworks. *Computers*, 15(1), 9. https://doi.org/10.3390/computers15010009
- Commission Delegated Regulation (EU) 2024/1532 of 19 October 2024 supplementing Regulation (EU) 2022/2554 (DORA RTS). *Official Journal of the European Union*, L 2024/1532.
- European Union Agency for Cybersecurity. (2025). *NIS2 implementation guidance*. https://www.enisa.europa.eu/
- National Institute of Standards and Technology. (2020). NIST SP 800-131A: Transitioning the use of cryptographic algorithms and key lengths. https://doi.org/10.6028/NIST.SP.800-131A
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- National Security Memorandum 10 (2022). The White House.
- National Cyber Security Centre. (2024). *Quantum-safe cryptography: Migration planning guidance*. UK Government.
- Australian Signals Directorate. (2024). *Post-quantum cryptography guidance*. Australian Government.
