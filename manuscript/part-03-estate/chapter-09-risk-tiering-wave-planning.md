# Chapter 9
# Risk Tiering and Migration Wave Planning

---

Apex Defense Technologies' board risk committee received a migration plan in March 2026 that did not sort systems alphabetically, did not mirror NIST dates verbatim, and did not claim every workload would be PQC-native by 2028. Priya Nair presented **four migration waves** with explicit dependency gates, TRADE scores, contract renewal alignment, and a documented list of systems that would **not** migrate in Wave 1 despite executive visibility.

The committee approved the plan in one session. The differentiator was not slide design — it was **defensible multi-dimensional prioritisation** backed by CBOM rows, CDG blocking nodes, and scored trade-offs the board could audit.

This chapter teaches readers to produce the same artefact: a board-approved migration wave plan that survives supervisory review, vendor reality, and dependency topology.

---

## 9.1 From Inventory to Action

Parts I and II established urgency and standards. Chapters 7 and 8 produced visibility — CBOM and CDG. Chapter 9 converts visibility into **sequenced action**.

| Artefact | Question answered | Chapter |
|----------|-------------------|---------|
| CBOM | What cryptography exists? | 7 |
| CDG | What breaks if we change it? | 8 |
| TRADE-scored register | How urgent is each workload? | 9 |
| Wave plan | What moves when, and why? | 9 |

Without wave planning, enterprises default to:

- **Visibility-driven migration** — external TLS first because scans are easy
- **Vendor-driven migration** — whatever the HSM vendor ships next quarter
- **Calendar-driven migration** — NIST 2035 copied into project plans without dependency analysis

Each default fails. This chapter replaces defaults with the **TRADE Decision Engine** and explicit wave governance.

> **Migration Moment**
>
> *"We have 14,200 assets. Just start with the most critical."*
>
> "Critical" is multidimensional. Meridian's customer PII KMS is critical on Threat, Regulatory, and Data longevity — but Ecosystem readiness gated production until 2027. GlobalSync's partner mTLS policy is moderate on Threat but **blocking** for 200 microservices. Single-dimension sorting produces wrong wave membership.

---

## 9.2 The TRADE Decision Engine (Full Specification)

Chapter 2 introduced TRADE and developed the **Threat (T)** dimension. Chapter 8 previewed **Architectural dependency (A)** via CDG. This section completes all five dimensions.

**TRADE** scores each in-scope system or workload on five dimensions, each **1–5** (5 = highest urgency or friction as defined per dimension):

| Dimension | Symbol | Scores high when… | Primary inputs |
|-----------|--------|-------------------|----------------|
| **Threat exposure** | T | Long confidentiality horizon; high-value data; integrity-critical signing | Threat models, HNDL analysis, TES |
| **Regulatory obligation** | R | Supervisory mandate, contract flow-down, sector rules | DORA, CNSA, NIS2, contracts |
| **Architectural dependency** | A | Blocking node; many dependents; programme leverage | CDG fan-in, blocking flags |
| **Data longevity** | D | Data must remain confidential many years post-migration | Classification, retention |
| **Ecosystem readiness** | E | *Low* score = immature vendor/partner/protocol support | Vendor roadmaps, partner SLAs |

**Note on E:** Ecosystem readiness is inverted in interpretation — **low E (1–2) gates production deployment** but does not reduce planning priority. High T with low E means *start vendor escalation and architecture now; deploy when ready.*

### Default MPI weights

**Migration Priority Index (MPI):**

**MPI = (wT×T + wR×R + wA×A + wD×D + wE×E) / (wT + wR + wA + wD + wE)**

| Dimension | Symbol | Default weight | Rationale |
|-----------|--------|---------------|-----------|
| Threat | wT | 1.5 | Primary driver for HNDL |
| Regulatory | wR | 1.25 | Compliance forcing function |
| Architectural dependency | wA | 1.25 | Blocking leverage |
| Data longevity | wD | 1.0 | Reinforces HNDL |
| Ecosystem readiness | wE | 0.75 | Gates execution timing |

Sector overlays (Part VI) modify weights — defence increases wR; SaaS increases wE. **Document weights** in programme charter; auditors will compare scores year-over-year.

### MPI interpretation bands

| MPI range | Tier | Programme action |
|-----------|------|------------------|
| ≥ 4.0 | **Immediate planning** | Wave 0–1 candidate; executive visibility |
| 3.2 – 3.9 | **High** | Wave 1–2; resource allocation |
| 2.5 – 3.1 | **Moderate** | Wave 2–3; align refresh cycles |
| < 2.5 | **Low** | Defer to natural refresh or decommission |

MPI informs priority; **CDG blocking overrides** pure MPI ordering when a low-MPI consumer depends on a high-blocker anchor.

---

## 9.3 Dimension Scoring Rubrics

### 9.3.1 Threat exposure (T)

| Score | Criteria |
|-------|----------|
| 5 | TES 5; nation-state HNDL concern; long-horizon classified or PCI/PII at scale |
| 4 | TES 4; regulated financial or health data; integrity-critical firmware |
| 3 | TES 3; standard enterprise confidential data |
| 2 | TES 2; internal operational data, short horizon |
| 1 | TES 1; public or ephemeral data |

*See Chapter 2 for TES workshop methodology.*

**Scoring discipline:** Threat scores require documented threat actor assumptions. Meridian worksheet field `threat_actor_basis` mandatory for T ≥ 4. Apex NSS systems default T ≥ 4 without workshop — policy floor documented in methodology.

**Integrity vs confidentiality:** Payment HSM firmware scores T = 5 on **integrity** even when firmware binary is not confidential — forged firmware exceeds decryption risk (Chapter 2). Worksheet separates `tes_confidentiality` and `tes_integrity`; T dimension uses maximum of the two.

### 9.3.2 Regulatory obligation (R)

| Score | Criteria |
|-------|----------|
| 5 | NSS/CNSA binding; explicit supervisory order; contract penalty clause |
| 4 | DORA/NIS2 essential entity measures; PCI DSS crypto requirements |
| 3 | Industry guidance with supervisory expectation; customer contract |
| 2 | Best practice alignment; voluntary frameworks |
| 1 | No applicable regulatory driver |

Apex NSS workloads default R ≥ 4 regardless of other dimensions.

### 9.3.3 Architectural dependency (A)

| Score | Criteria |
|-------|----------|
| 5 | CDG blocking node; fan-in > 50 dependents |
| 4 | Major PKI issuer; HSM root; partner policy hub |
| 3 | Shared KMS partition; multi-team dependency |
| 2 | Limited shared infrastructure |
| 1 | Isolated leaf system |

Chapter 8 blocking flags map directly to A ≥ 4.

### 9.3.4 Data longevity (D)

| Score | Criteria |
|-------|----------|
| 5 | Confidentiality horizon > 15 years |
| 4 | 10–15 years |
| 3 | 5–10 years |
| 2 | 1–5 years |
| 1 | < 1 year or no long-term confidentiality |

Aligns with HNDL analysis (Chapter 2).

### 9.3.5 Ecosystem readiness (E)

| Score | Criteria |
|-------|----------|
| 5 | PQC-native production validated; partners aligned |
| 4 | Hybrid production-ready; vendor GA |
| 3 | Pilot available; partial partner support |
| 2 | Roadmap only; partner undefined |
| 1 | No vendor or partner path |

**Production gate:** E < 3 typically blocks production PQC deployment without risk acceptance.

---

## 9.4 Worked MPI Examples

### Example 1 — Meridian customer PII KMS (Chapter 2 recap)

| Dimension | Score | Weighted |
|-----------|-------|----------|
| T | 5 | 7.5 |
| R | 5 | 6.25 |
| A | 4 | 5.0 |
| D | 5 | 5.0 |
| E | 2 | 1.5 |

MPI = 25.25 / 5.75 = **4.39** → Immediate planning; production gated by E = 2.

### Example 2 — GlobalSync partner mTLS policy (blocking hub)

| Dimension | Score | Weighted |
|-----------|-------|----------|
| T | 3 | 4.5 |
| R | 3 | 3.75 |
| A | 5 | 6.25 |
| D | 2 | 2.0 |
| E | 2 | 1.5 |

MPI = 18.0 / 5.75 = **3.13** → Moderate by MPI alone — but **Wave 0 mandatory** due to blocking (200 microservices). CDG override documented in wave plan.

### Example 3 — Northfield historian archive

| Dimension | Score | Weighted |
|-----------|-------|----------|
| T | 5 | 7.5 |
| R | 4 | 5.0 |
| A | 2 | 2.5 |
| D | 5 | 5.0 |
| E | 3 | 2.25 |

MPI = 22.25 / 5.75 = **3.87** → High; Wave 1 threat-immediate (Chapter 2) — but WAN concentrator Wave 0 may gate delivery path.

### Example 4 — Apex NSS firmware signing module

| Dimension | Score | Weighted |
|-----------|-------|----------|
| T | 4 | 6.0 |
| R | 5 | 6.25 |
| A | 5 | 6.25 |
| D | 3 | 3.0 |
| E | 2 | 1.5 |

MPI = 23.0 / 5.75 = **4.00** → Immediate; Wave 0 with CNSA 2030 firmware anchor.

---

## 9.5 Wave Taxonomy

Migration waves are **programme containers** — not arbitrary calendar quarters. Standard taxonomy:

| Wave | Name | Typical contents | Duration |
|------|------|------------------|----------|
| **Wave 0** | Structural unblockers | Blocking nodes: roots, HSM firmware, partner policy, VPN concentrators | 12–24 months |
| **Wave 1** | Threat-immediate | TES 5 / MPI ≥ 4.0 systems not blocked by Wave 0 gaps | 12–18 months |
| **Wave 2** | Enterprise PKI and shared services | Issuing CAs, shared KMS, API gateways | 18–24 months |
| **Wave 3** | General IT application estate | Line-of-business apps, internal TLS | 24–36 months |
| **Wave 4** | OT / embedded / long-tail | Firmware, PLCs, partner long-tail | 36–60+ months |

Waves are **overlapping**, not serial waterfalls — Wave 1 planning starts while Wave 0 executes. Overlap requires capacity planning (§9.8).

**Quick wins** — systems with high MPI, low A, E ≥ 3 — may execute in parallel with Wave 0 for morale and learning, but must not divert Wave 0 funding.

---

## 9.6 Sequencing Rules

Apply rules in order; document exceptions in risk register.

**Rule 1 — Blocking first:** CDG `blocking: true` nodes enter Wave 0 unless risk acceptance approved at board level.

**Rule 2 — MPI orders within wave:** Sort wave candidates by MPI descending.

**Rule 3 — Ecosystem gate:** No production PQC deploy when E < 3 without documented risk acceptance.

**Rule 4 — HLM alignment:** Hybrid deployments require `h2_trigger_value` in CBOM (Chapter 5).

**Rule 5 — Partner before consumer:** Partner trust policy migrates before dependent microservices (GlobalSync).

**Rule 6 — Signing before verify:** Issuer migrates before verifiers accept new algorithms — or dual-trust period explicit on CDG.

**Rule 7 — Contract alignment:** Systems with renewal clauses referencing cryptography align wave timing to renewal (Apex).

**Rule 8 — Decommission bypass:** Systems retiring before 2028 deprecation may **not migrate** — document decommission instead (§9.7).

**Figure 9.1 — Migration Wave Gantt with Dependency Gates**

```
2026        2027        2028        2029        2030
  |           |           |           |           |
  [==== Wave 0: blocking nodes ====]
       [==== Wave 1: threat-immediate ====]
            [======== Wave 2: PKI / shared ========]
                 [============= Wave 3: general IT =============]
                      [================ Wave 4: OT / long-tail ========>]
  |           |           |           |           |
  Gate A      Gate B      NIST        Gate C      Deprecation
  partner     HSM fw      deprecation anchor      anchor
  policy      dual-sig                review
```

**Production brief — Figure 9.1:** Gantt with dependency gates labelled (partner policy, HSM firmware, PKI root). Distinguish planning start from production deploy. Overlay NIST 2030 deprecation anchor as vertical line.

---

## 9.7 "Do Not Migrate Yet" Conditions

Explicit **deferral** prevents wasted engineering on systems that cannot or should not move now.

| Condition | Rationale | Programme action |
|-----------|-----------|------------------|
| E < 3 and no hybrid path | Production deploy unsafe | Vendor escalation; architecture only |
| Blocking ancestor not in Wave 0 plan | Migration would fail integration test | CDG sequencing |
| Decommission before deprecation | Migration cost > retirement value | Document retirement date |
| OT device cannot accept ML-DSA chain | Physical constraint | Compensating control; refresh cycle |
| Partner prohibits PQC until date X | Contractual | Partner programme; contractual amendment |
| NSS accreditation artefact pending | Authority to operate | Apex waiver path |
| Unknown CBOM confidence | Cannot score TRADE accurately | Discovery tranche first |

**Anti-pattern:** "Do not migrate yet" without owner and review date — becomes permanent deferral. Every deferral requires risk acceptance with **maximum twelve-month review** (Chapter 5).

GlobalSync listed **47 microservices** as "do not migrate yet" pending partner policy Wave 0 — preventing teams from shipping hybrid TLS that partners would reject.

---

## 9.8 Wave Sizing and Capacity

Waves fail when overloaded. Sizing heuristics (*illustrative planning examples*):

| Factor | Guidance |
|--------|----------|
| Systems per wave | 50–200 major workloads; unlimited CBOM rows if rolled up |
| FTE per wave | 0.5–2 FTE per major workload for migration project (varies by complexity) |
| Wave 0 cap | ≤ 30% programme budget — blocking work is expensive |
| Parallel waves | Max 2 active execution waves for same team |
| Steering cadence | Monthly progress; quarterly MPI re-score |

Meridian Wave 0 contained **8 blocking nodes** — not 800 servers. GlobalSync Wave 0 contained **3 policy nodes** affecting 200+ services. **Count nodes, not servers.**

**Illustrative budget (planning example):** Apex Waves 0–2 combined **$14M–$22M** over three years — firmware, NSS accreditation, PKI, partner coordination. Labelled planning example, not industry benchmark.

---

## 9.9 Table 9.1 — TRADE Scoring Worksheet

| Field | Value |
|-------|-------|
| System / workload ID | |
| CBOM asset reference(s) | |
| CDG blocking node? (Y/N) | |
| **T** Threat (1–5) | |
| **R** Regulatory (1–5) | |
| **A** Architectural dependency (1–5) | |
| **D** Data longevity (1–5) | |
| **E** Ecosystem readiness (1–5) | |
| Weights (if non-default) | wT, wR, wA, wD, wE |
| **MPI** (calculated) | |
| Proposed wave | |
| CDG override? (Y/N + rationale) | |
| "Do not migrate yet"? (Y/N + condition) | |
| Owner | |
| Review date | |

Meridian stored worksheets in GRC platform linked to CBOM `asset_id`. Re-scoring triggered on: regulatory change, vendor GA, CDG edge change, data classification change.

---

## 9.10 Table 9.2 — Wave Definition Template

| Field | Wave 0 example |
|-------|----------------|
| Wave ID | W0 |
| Wave name | Structural unblockers |
| Objectives | Resolve CDG blocking nodes; enable downstream waves |
| Entry criteria | CBOM ≥80% verified; CDG-2 maturity |
| Exit criteria | Blocking nodes migrated or dual-trust operational; downstream E ≥ 3 |
| In-scope systems | Partner mTLS policy; payment HSM firmware signer; internal root CA rotation plan |
| Out-of-scope | General application TLS (Wave 3) |
| Dependencies | Vendor firmware GA; partner negotiation |
| Budget range | €X–Y (*planning example*) |
| Executive sponsor | |
| Success metrics | Fan-in reduction; partner acceptance % |
| Risk register link | |

---

## 9.11 Apex Defense: Contract-Aligned Waves

Priya Nair faced a mandate collision familiar from Chapter 1: NSS programmes required CNSA 2030 firmware signing; commercial division promised customers NIST-aligned roadmaps; international subsidiaries referenced host-nation guidance. A single wave plan would either over-promise to commercial customers or under-resource NSS deliverables.

Apex's resolution was **dual-track wave plans** in one board document — NSS track and commercial track — sharing procurement where possible but not merging sequencing. CDG enforced separation: NSS subgraph contained no `trusts` edges to commercial roots without cross-domain guard nodes.

Apex's wave plan aligned to **defence contract renewal cycles** and CNSA milestones — not generic IT refresh.

**Wave 0 (2026–2027):** NSS firmware signing module; cross-domain guard crypto profiles; deliverable signing HSM partition. Driven by three contracts with 2027 renewal clauses referencing "approved national security algorithms."

**Wave 1 (2027–2028):** NSS external interfaces; classified enclave TLS. R weight elevated to 2.0 in MPI formula for NSS rows.

**Wave 2 (2028–2030):** Corporate IT PKI; commercial product signing. NIST IR 8547 deprecation alignment.

**Wave 3 (2030–2033):** Long-tail OT in defence supply chain subsidiaries.

**Deferrals:** Corporate marketing websites — MPI 2.1, decommission planned 2029 — **do not migrate**; document retirement.

Priya's board package included **contract clause cross-reference** — each Wave 0 item mapped to customer flow-down obligation. Committee approved because migration spend connected to revenue risk, not abstract compliance.

> **Regulatory Lens**
>
> Defence contractors face **dual anchors** — CNSA for NSS, NIST for corporate IT. Wave plan must show both tracks without implying single deadline. Apex board slides used two timeline bars — NSS and commercial — preventing the collision failures described in Chapter 1.

---

## 9.12 Meridian Mutual Bank: Wave Plan Summary

Meridian's steering committee approved five waves in October 2026:

| Wave | Focus | Key systems | MPI / blocking driver |
|------|-------|-------------|----------------------|
| W0 | Blocking | Payment HSM firmware; card-scheme trust policy; manufacturing root | A = 5 |
| W1 | Threat-immediate | PII KMS; wire transfer signing; core ledger field encryption | MPI ≥ 4.0 |
| W2 | PKI | Issuing CAs; API gateway mTLS templates | A = 4 |
| W3 | Application estate | Retail banking apps; internal microservices | MPI 2.5–3.9 |
| W4 | Third-party residual | SaaS with incomplete attestation | E low |

**€4.2M** Wave 0 budget (*illustrative*) — HSM vendor co-funding negotiation reduced net to €3.1M.

**Wave 1 detail:** PII KMS (MPI 4.39), wire transfer HSM signing service (MPI 4.12), core ledger field encryption (MPI 3.95) — twelve systems total in Wave 1 after roll-up from 340 CBOM rows. Each Wave 1 system had E ≥ 3 or approved hybrid path before production gate.

**Wave 2 detail:** Internal issuing CA migration, API gateway mTLS template standardisation — 45 CBOM rows rolled to 8 PKI meta-nodes. Wave 2 start gated on Wave 0 manufacturing root dual-trust operational.

**Funding profile:** Waves 0–1 consumed 55% of five-year migration budget — structural and threat-immediate work front-loaded per Campbell timeline analysis (Chapter 1).

Elena required **DORA evidence mapping** — each wave linked to ICT risk register entries. Supervisors received wave plan as evidence of "state of the art" migration planning.

---

## 9.13 GlobalSync Logistics: Partner-First Sequencing

GlobalSync's wave plan inverted typical "customer-facing API first" instinct:

**Wave 0:** Partner mTLS policy; internal service mesh root; tenant isolation KMS partition.

**Wave 1:** Public API tier hybrid TLS (H1) — after partner policy exit criteria met for B2B path.

**Wave 2:** Regional tenant segments by regulatory overlay (EU DORA tenants first).

**Wave 3:** Internal admin and corporate systems.

Marcus Chen measured Wave 0 success by **partner acceptance rate** — target 85% partners accepting hybrid or PQC client cert profiles before Wave 1 production traffic shift.

**47 microservices** on "do not migrate yet" list — communicated to engineering managers to prevent local optimisation.

---

## 9.14 Northfield Energy Systems: OT and Threat Waves

James Whitfield's steering presentation opened with historian archive MPI scores — TES 5, MPI 3.87 — and closed with WAN concentrator blocking. Board members asked why archives were not Wave 0 if threat scores were highest. James walked CDG slide: archive encryption keys could be rotated locally, but **distribution paths** for new keys traversed VPN concentrators still on classical IKE profiles with OT gateway firmware not qualified for hybrid until Q3 2027.

The explanation converted board scepticism into Wave 0 funding — structural sequencing as physical reality, not bureaucracy.

Northfield combined **threat-immediate** (Chapter 2 historian archives) with **structural** WAN blocking:

**Wave 0:** VPN concentrator firmware path; OT gateway vendor qualification.

**Wave 1:** Historian archives; SCADA configuration backups; safety documentation stores.

**Wave 2:** Enterprise IT and cloud analytics TLS.

**Wave 3:** Field device long-tail — device refresh cycles.

James Whitfield refused to sequence Wave 1 archive encryption delivery until Wave 0 WAN could transport keys — CDG sequencing rule 6 in practice.

OT **maintenance window** constraints limited Wave 0 to two concentrator upgrades per quarter — wave duration extended, not scope reduced.

---

## 9.15 Board Approval Package

Steering committee recommends; board risk committee approves. Minimum package:

1. **Executive summary** — waves, dates, budget ranges, policy anchor alignment
2. **TRADE methodology** — weights, re-score cadence
3. **Top 20 MPI systems** with worksheet excerpts
4. **Blocking node register** — CDG fan-in, owners, Wave 0 status
5. **"Do not migrate yet" register** — with review dates
6. **Regulatory mapping** — DORA, CNSA, NIS2 as applicable
7. **Risk acceptance queue** — exceptions requiring board visibility
8. **Figure 9.1** Gantt with dependency gates

**Duration:** 30-minute board slot; 15 minutes Q&A. Priya's Apex presentation allocated 10 minutes to contract alignment — board engagement increased when revenue risk explicit.

---

## 9.16 Wave Reassessment

Waves are not frozen. **Quarterly reassessment** triggers:

| Trigger | Action |
|---------|--------|
| Vendor GA announcement | Re-score E; accelerate wave |
| New blocking node in CDG | Insert Wave 0 item or reprioritise |
| Regulatory publication | Re-score R; adjust anchors |
| Decommission executed | Remove from wave; rebalance capacity |
| Partner acceptance threshold met | Close Wave 0 gate; open Wave 1 |
| MPI drift > 0.5 | Review wave membership |

Meridian re-scored entire estate annually; TES 5 systems quarterly. GlobalSync re-scored on partner policy changes — monthly during Wave 0.

---

## 9.17 TRADE and HLM Interaction

Wave membership must align with Hybrid Lifecycle Model phase (Chapter 5):

| HLM phase | Wave implication |
|-----------|------------------|
| H1 eligible | Wave 1+ if E ≥ 3 or hybrid approved |
| H2 transition | Wave 2+ typically |
| H3 target | Final wave or dedicated compliance wave |

Systems entering Wave 1 with hybrid deployment require `h2_trigger_value` before steering approval. Systems without triggers remain in planning wave — not production wave.

---

## 9.18 Common Wave Planning Failure Modes

**Alphabetical waves.** Sorted server list. *Remediation:* TRADE worksheets mandatory.

**TLS-first waves.** External scan drives sequence. *Remediation:* CDG Rule 1.

**Infinite Wave 0.** Blocking nodes multiply; nothing completes. *Remediation:* Cap Wave 0 scope; time-box; escalate unresolvable blockers to board risk acceptance.

**No deferral list.** Teams migrate undeployable systems. *Remediation:* §9.7 register.

**Single deadline.** Board told "2035 compliant" without waves. *Remediation:* Figure 9.1 multi-wave Gantt.

**MPI without CDG.** High scores without sequencing. *Remediation:* blocking override column in worksheet.

---

## 9.19 Workshop: Building Wave 0

**Duration:** Half day. **Participants:** Programme director, enterprise architecture, CDG owner, risk, representative domain architects.

**Steps:**

1. Import top 20 CDG blocking nodes by fan-in
2. Score each on TRADE (focus A, E)
3. Assign Wave 0 membership — max 8–12 nodes
4. Estimate lead time and budget range per node
5. Identify "do not migrate yet" dependents
6. Draft Wave 0 exit criteria
7. Present to steering committee for funding gate

**Output:** Wave 0 charter using Table 9.2 template.

---

## 9.20 Apply in Your Organisation

1. **Adopt TRADE worksheet** (Table 9.1) for all in-scope systems — link to CBOM rows.
2. **Document MPI weights** in programme charter; justify sector modifications.
3. **Build Wave 0 from CDG blocking nodes** — not from scan visibility.
4. **Apply sequencing rules** (§9.6) — document CDG overrides explicitly.
5. **Maintain "do not migrate yet" register** with owners and review dates.
6. **Size waves by capacity** — avoid parallel overload (§9.8).
7. **Align defence and regulated waves** to contract and supervisory anchors.
8. **Prepare board package** (§9.15) for risk committee approval.
9. **Schedule quarterly wave reassessment** (§9.16).
10. **Complete Register phase** — CBOM, CDG, TRADE register, wave plan — before Part IV architecture standards.

---

## 9.21 Reconciling TRADE with Business Priority

Business leaders advocate for **revenue systems first** — payment channels, customer portals, flagship products. TRADE may score internal KMS higher than customer marketing site. Programme office reconciles through **three lanes**:

| Lane | Sequencing driver | Example |
|------|-------------------|---------|
| **Structural** | CDG blocking | Partner policy before microservices |
| **Risk** | MPI / TES | PII KMS before marketing TLS |
| **Business** | Revenue / contract | Apex deliverable signing before corporate intranet |

Lanes interact: business priority **cannot override** structural lane without board risk acceptance. Business priority **may accelerate** risk lane within capacity limits.

Meridian agreed to accelerate **retail mobile app** TLS in Wave 1 for customer commitment — MPI 3.4, not highest — because CDG showed no blocking dependency and E = 4. Same steering committee rejected accelerating corporate intranet with lower MPI — no business case.

---

## 9.22 Sector Overlay Preview (Part VI)

Part VI modifies TRADE weights by sector. Preview for wave planning:

| Sector | Weight modifier | Wave implication |
|--------|-----------------|------------------|
| Financial services | wR +0.25 | Regulatory systems earlier in Wave 1 |
| Defence / NSS | wR +0.5 for NSS | Separate NSS wave track |
| Energy / OT | wT +0.25 for OT data | Historian Wave 1; WAN Wave 0 |
| SaaS / platform | wE +0.25 | Partner ecosystem Wave 0 emphasis |

Document sector modifiers in programme charter before scoring — retroactive weight changes invalidate year-over-year MPI comparison.

---

## 9.23 Five-Year Programme Phase Model Integration

Chapter 5 introduced five-year programme phases. Wave plan maps to phases:

| Programme phase | Years | Wave focus |
|-----------------|-------|------------|
| Phase 1 — Discover | 1–2 | CBOM, CDG; Wave 0 planning |
| Phase 2 — Decide | 2–3 | TRADE scoring; board wave approval |
| Phase 3 — Unblock | 2–4 | Wave 0 execution |
| Phase 4 — Migrate | 3–7 | Waves 1–3 |
| Phase 5 — Sustain | ongoing | Wave 4; HLM H3 verification |

Waves are **tactical**; phases are **strategic**. Apex board pack showed both — phases for multi-year funding; waves for annual operational targets.

---

## 9.24 Procurement and Wave Funding Gates

Wave execution requires **funding gates** tied to procurement:

| Gate | Requirement before funding release |
|------|-----------------------------------|
| Wave 0 gate | CDG blocking brief; vendor SOW with node reference |
| Wave 1 gate | TRADE worksheets for all members; E ≥ 3 or hybrid approved |
| Wave 2+ gate | Prior wave exit criteria met ≥ 80% |

Meridian procurement inserted CDG `blocking_node_id` into HSM renewal SOW — vendor deliverables traceable to graph. GlobalSync partner programme funding released only after partner acceptance pilot results documented.

---

## 9.25 Wave Governance Cadence

| Forum | Cadence | Inputs | Outputs |
|-------|---------|--------|---------|
| Domain architect sync | Weekly | MPI changes, blockers | Escalation list |
| Steering committee | Monthly | Wave burn-down, deferral register | Reprioritisation decisions |
| Board risk committee | Quarterly | Phase progress, budget variance | Funding approval |
| TRADE re-score | Annual (quarterly TES 5) | CBOM/CDG updates | Wave membership changes |

---

## 9.26 Executive MPI Dashboard

| Metric | Target | Action if missed |
|--------|--------|------------------|
| % estate scored | 100% in-scope | Discovery backlog |
| MPI ≥ 4.0 with no wave | 0 | Assign wave or defer with approval |
| Wave 0 exit criteria | On date | Escalate blocking owners |
| Deferral register overdue | 0 items | Risk acceptance renewal |
| CDG override undocumented | 0 | Audit remediation |

---

## 9.27 Risk Acceptance Integration

Systems in "do not migrate yet" with MPI ≥ 4.0 require **risk acceptance** (Chapter 5):

- Maximum duration 12 months
- CISO approval; board visibility if > 3 systems or regulated data
- Linked to CBOM row and TRADE worksheet
- Review triggers: vendor GA, ecosystem change

Meridian limited **10 concurrent** high-MPI deferrals — steering committee cap preventing deferral register becoming shadow wave plan.

---

## 9.28 Communicating Waves to Engineering

Engineering teams receive:

1. **Wave charter** — scope, dates, exit criteria
2. **System list** — CBOM IDs they own
3. **Explicit non-list** — "do not migrate yet" to prevent local heroics
4. **Dependency map excerpt** — CDG subgraph for their domain
5. **HLM requirements** — hybrid triggers if applicable

GlobalSync published Wave 0 internal wiki page listing 47 services **not** to migrate — reducing wasted sprint work.

---

## 9.29 Auditor and Assessor Engagement

Auditors ask: *How did you decide migration order?* Evidence bundle:

- TRADE methodology document
- Sample worksheets (10% stratified)
- CDG blocking node register
- Board-approved wave plan minutes
- Deferral register with approvals

Thomas Bergström's supervisory dialogue succeeded because Meridian could trace **payment HSM Wave 0** decision to CDG fan-in and contract — not oral tradition.

---

## 9.30 Conducting a TRADE Scoring Workshop

**Duration:** Full day per domain (payments, corporate IT, OT). **Participants:** Security, risk, domain architects, compliance, data owners.

**Pre-work:** CBOM rows for domain; CDG subgraph; draft TES from Chapter 2 workshop if available.

**Agenda:**

| Block | Activity | Output |
|-------|----------|--------|
| 1 | Review CBOM coverage gaps in domain | Gap list |
| 2 | Score T and D with data owners | T, D columns |
| 3 | Score R with compliance | R column |
| 4 | Score A from CDG fan-in | A column |
| 5 | Score E from vendor/partner data | E column |
| 6 | Calculate MPI; assign provisional wave | Worksheet complete |
| 7 | Identify CDG overrides and deferrals | Override column |

**Facilitation rule:** No system leaves workshop without owner and review date. Unknown CBOM confidence → defer to discovery, not guessed scores.

Meridian ran four domain workshops over six weeks — 1,200 worksheets completed for in-scope workloads (rolled up from 14,200 CBOM rows).

---

## 9.31 Wave Plan Document Structure

Board-approved wave plan document template:

1. Executive summary (2 pages)
2. TRADE methodology and weights
3. Wave definitions (Table 9.2 per wave)
4. System-to-wave mapping (appendix)
5. CDG blocking register
6. Deferral register
7. Budget ranges by wave
8. Regulatory and contract alignment
9. Figure 9.1 Gantt
10. Reassessment schedule

Apex document classified annex for NSS wave detail — board received summary with classified appendix in secure brief.

---

## 9.32 Decommission vs Migrate Decision Tree

```
System quantum-vulnerable?
  No → Out of scope (document)
  Yes → Decommission before 2030 deprecation?
    Yes → Decommission path (no migration spend)
    No → CDG blocking node?
      Yes → Wave 0 (unless override approved)
      No → MPI ≥ 4.0?
        Yes → Wave 1 candidate
        No → E ≥ 3?
          Yes → Wave 2–3 by MPI
          No → "Do not migrate yet" + vendor escalation
```

Meridian applied tree to 14,200 CBOM rows — **1,800** routed to decommission path (*illustrative*), avoiding wasted migration budget on retiring systems.

---

## 9.33 Hybrid Quick Wins vs Structural Waves

Programmes need **early demonstrable progress** without undermining Wave 0. **Quick win criteria:**

- MPI ≥ 3.2
- Not dependent on blocking node (CDG check)
- E ≥ 4
- Isolated blast radius — failure does not affect payment or safety systems
- Completable in < 90 days engineering effort

Meridian quick win: internal engineering wiki TLS upgrade — MPI 3.1, marginal quick win approval for team morale. **Rejected** quick win: customer mobile app without partner policy check — CDG showed partner webhook verification dependency.

GlobalSync quick win: internal admin SSO cert upgrade — E = 5, no partner dependency. **Approved** as parallel to Wave 0 — separate budget line to prevent Wave 0 starvation.

---

## 9.34 MPI Sensitivity Analysis

Leadership may challenge weights. Programme office should run **sensitivity analysis** — if wT varies ±0.25, how many systems change wave membership?

Meridian analysis: ±0.25 on wT moved **4%** of systems across wave boundaries — stable enough for board confidence. ±0.5 on wE moved **11%** — ecosystem weight changes require steering approval.

Document sensitivity in board pack appendix — demonstrates methodology robustness.

---

## 9.35 Regulatory Dimension Deep Dive

Regulatory scoring (R) draws from Chapter 3 overlay matrix. Practical assignment rules:

| Signal | R score guidance |
|--------|------------------|
| NSS/CNSA flow-down | 5 |
| DORA essential entity ICT risk | 4–5 for critical providers |
| PCI DSS crypto scope | 4 for in-scope systems |
| NIS2 essential entity measures | 4 for critical infrastructure OT |
| Customer contract explicit PQ clause | 3–4 |
| Voluntary NIST alignment | 2–3 |

**Multi-jurisdiction systems:** Use **highest applicable R** per jurisdiction where system processes data — GlobalSync tenant workloads scored per tenant overlay, not platform default.

**Evidence link:** Worksheet field `regulatory_ref` points to contract clause, policy section, or supervisory letter — auditors trace wave decision to obligation source.

Thomas Bergström used R dimension traceability in DORA dialogue — wire transfer system R = 5 linked to ECB supervisory expectation letter reference, not generic "banking is regulated."

---

## 9.36 Architectural Dependency Deep Dive

A dimension (Chapter 8) scoring consumes CDG metrics:

| CDG metric | A score |
|------------|---------|
| `blocking: true` | 5 |
| Fan-in > 50 | 5 |
| Fan-in 20–50 | 4 |
| Fan-in 5–19 | 3 |
| Shared KMS partition | 3 |
| Fan-in 1–4 | 2 |
| Isolated leaf | 1 |

**Negative dependency:** System is **only** dependent — does not block others. High T, low A — Wave 1 candidate after Wave 0 clears blockers.

**Positive dependency (blocking):** System blocks others. May have moderate T but **Wave 0** via CDG override — GlobalSync partner policy exemplar.

---

## 9.37 Ecosystem Readiness Deep Dive

E dimension gates production — low E is not low priority for **planning**:

| E | Vendor/partner state | Programme action |
|---|---------------------|------------------|
| 5 | GA, validated in prod | Deploy PQC-native or H2 |
| 4 | Hybrid production-ready | H1 with H2 trigger |
| 3 | Pilot / limited prod | H1 pilot only |
| 2 | Roadmap | Architecture, vendor escalation, Wave 0 negotiation |
| 1 | No path | Defer; compensating controls; refresh planning |

**Partner ecosystem:** E score for consumer microservice **cannot exceed** partner policy E score for mutual TLS — consumer E capped by minimum partner readiness along CDG path.

---

## 9.38 Chapter Summary

- TRADE provides multi-dimensional prioritisation — Threat, Regulatory, Architectural dependency, Data longevity, Ecosystem readiness.
- MPI aggregates dimensions with documented weights; default formula in §9.2.
- CDG blocking nodes override pure MPI ordering — Wave 0 exists for structural unblockers.
- Waves 0–4 taxonomy sequences blocking, threat-immediate, PKI, general IT, and OT long-tail.
- "Do not migrate yet" conditions prevent wasted execution — require review dates.
- Apex contract alignment, Meridian DORA evidence, GlobalSync partner-first, and Northfield OT/WAN cases illustrate application.
- Board approval package connects waves to budget, regulation, and dependency gates.
- Part III exit artefacts: CBOM, CDG, TRADE register, board-approved wave plan.

**Next:** Part IV — Architecting for Transition — implements hybrid TLS, PKI migration, and application patterns within the waves defined here.

---

*Chapter 9 — References*

- Campbell, P. (2025). Enterprise post-quantum migration timeline analysis. *Industry synthesis*.
- National Institute of Standards and Technology. (2024). *IR 8547* — transition for post-quantum cryptography (draft).
- National Security Agency. (2022). *Commercial National Security Algorithm Suite 2.0*.
- National Institute of Standards and Technology. (2024). *SP 1800-38* — PQC migration planning practices (informative).
- Cybersecurity and Infrastructure Security Agency. (2024). Post-quantum cryptography migration guidance.
- World Economic Forum. (2024). *Quantum security: Preparing for the post-quantum era*.

---

*End of Part III. Proceed to Part IV: Architecting for Transition.*
