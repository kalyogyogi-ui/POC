# Chapter 15
# Programme Governance and Operating Model

---

GlobalSync Logistics' board approved a four-wave migration plan in June 2026. Marcus Chen's security organisation had spent eighteen months building the inventory, dependency graph, and TRADE-scored priorities that made the plan defensible. Six weeks later, Wave 0 stalled — not because hybrid TLS failed in the laboratory, but because **no one with authority could compel** the partner gateway team in Frankfurt, the tenant contract team in Singapore, and the platform engineering squad in Oregon to accept the same programme calendar.

Each region had funded pilots. Each region had named a "PQC lead." None had a **programme office** with charter authority to resolve cross-region priority conflicts, enforce CBOM quality standards, or escalate vendor delays to a steering committee that could reallocate budget. Marcus presented the diagnosis to the board risk committee in September 2026: *"We have architecture standards and a wave plan. We do not have an operating model. Pilots are becoming permanent exceptions."*

The board's response was not additional security headcount. It was a **programme charter** establishing a three-region programme office, a migration authority matrix, and a steering committee with quarterly funding gates tied to wave exit criteria. Within four months, GlobalSync's partner mTLS policy — the CDG blocking node affecting two hundred microservices — reached production under a single approved profile. The lesson generalises: Parts I through IV produce the *what* and *how* of post-quantum migration. Part V produces the *who*, *when*, and *with what authority* — without which wave plans decay into slide decks.

This chapter develops the **PQC Governance Stack** introduced in Chapter 3 into a functioning operating model. It specifies programme charter content, migration authority, steering committee design, RACI assignments, KPI dashboards, board reporting, funding models, and the operating rhythm calendar that sustains migration across a multi-year horizon. The chapter completes the **Synchronize** phase of the ARCS Framework and defines **PQ-ADAPT Level 4 (*Transitioning*)** entry criteria — the point at which production hybrid deployments, supplier alignment, and validation programmes operate under governed programme discipline rather than heroic engineering effort.

---

## 15.1 ARCS Synchronize and PQ-ADAPT Level 4 Entry

Chapter 1 introduced ARCS as four interlocking capabilities: **Awareness**, **Register**, **Capability**, and **Synchronize**. Parts I through III delivered Awareness and Register. Part IV delivered Capability — architecture standards, hybrid patterns, protocol playbooks, PKI evolution, and key management paths. Part V delivers **Synchronize**: the programme machinery that aligns internal teams, external partners, vendor roadmaps, and regulatory timelines on a shared migration sequence.

Synchronize is not a phase that begins after Capability is complete. It runs in parallel once Register produces inventory evidence. Many enterprises, however, **under-invest in Synchronize** until Execute-phase collisions appear — partner policy conflicts, procurement without contractual teeth, regional engineering teams optimising locally, assurance findings without remediation owners. Chapter 15 is the corrective.

**Table 15.1 — ARCS Phase × Part Mapping (Programme View)**

| ARCS phase | Primary parts | Programme governance contribution |
|------------|---------------|-----------------------------------|
| Awareness | I | Strategic layer charter; board narrative |
| Register | III | Operational layer CBOM/CDG custodianship |
| Capability | II, IV | Policy layer standards; architecture gates |
| **Synchronize** | **V–VI** | **Programme office; steering; procurement; assurance rhythm** |

**PQ-ADAPT Level 4 (*Transitioning*)** marks the transition from *knowing how to build migration-ready systems* (Level 3 — *Architected*) to *operating production migration under programme governance*. Level 4 is not "fully quantum-resilient." Level 5 (*Quantum-Resilient*) remains the 2030–2035 disallowance horizon for most enterprises. Level 4 is the honest middle: hybrid deployments in production, supplier contracts updated, validation programmes active, and governance structures that prevent pilot permanence.

**Table 15.2 — PQ-ADAPT Level 4 Entry Criteria**

| Criterion | Evidence artefact | Governance layer |
|-----------|-------------------|------------------|
| Programme charter board-approved | Signed charter with scope, authority, funding | Strategic / Programme |
| Steering committee operational | TOR, membership, minutes ≥ 3 cycles | Programme |
| RACI published and acknowledged | RACI matrix with named owners | Programme |
| Wave 0+ execution under governance | Wave status linked to CBOM; exit criteria tracked | Programme / Operational |
| Production hybrid deployments | HLM H1/H2 systems in production with change records | Operational |
| Supplier PQC clauses in renewal path | Contract amendment tracker (Chapter 16) | Policy / Programme |
| KPI dashboard live | Monthly metrics to steering committee | Programme |
| Validation programme active | Test plans executing for deployed hybrids (Chapter 18) | Assurance |
| Exception/risk acceptance register current | No expired acceptances without renewal | Policy / Assurance |
| Regulatory overlay maintained | Quarterly horizon report | Strategic / Programme |

Enterprises declaring Level 3 based on published architecture standards alone — without programme office, steering cadence, or production hybrid evidence — overstate maturity. Chapter 15 provides the operating model that makes Level 4 defensible to boards and supervisors.

The transition from Level 3 to Level 4 is where many programmes stall. Architecture teams publish agility standards and hybrid patterns; engineering pilots succeed; then **organisational antibodies** appear — procurement cycles that ignore PQC clauses, regional VPs who reprioritise headcount, partners who accept classical profiles because no one with authority mandates change. Synchronize exists to overcome organisational antibodies with charter-backed authority, not with better slide decks.

**Level 4 exit** (preview for Part VI) approaches when quantum-vulnerable public-key cryptography is retired from in-scope production systems per wave plan — approaching PQ-ADAPT Level 5 (*Quantum-Resilient*) as NIST disallowance milestones arrive. Level 4 is the sustained middle phase where hybrids are normal operations, not exceptions.

> **Migration Moment**
>
> *"We approved the wave plan. Why isn't anything migrating?"*
>
> Board approval authorises direction and budget envelope — not daily execution. Without migration authority (who can mandate partner profile changes, reject non-compliant vendor renewals, or reallocate wave capacity), approval becomes ceremonial. Programme charter and RACI convert approval into **operational authority**.

---

## 15.2 From Governance Stack to Operating Model

Chapter 3 introduced the **PQC Governance Stack** — five layers from board strategy to operational assurance. Chapter 3 defined *what evidence* each layer produces for regulatory defensibility. Chapter 15 defines *how each layer operates* — roles, cadences, decision rights, and artefact flows.

**Figure 15.1 — PQC Governance Stack Operating Model**

```
┌─────────────────────────────────────────────────────────────────────┐
│  STRATEGIC          Board / ERM · Risk appetite · Charter renewal     │
│                     Cadence: quarterly board · annual charter review  │
├─────────────────────────────────────────────────────────────────────┤
│  PROGRAMME          Programme office · Steering · Waves · Budget    │
│                     Cadence: weekly office · monthly KPI · quarterly  │
│                     steering · wave funding gates                   │
├─────────────────────────────────────────────────────────────────────┤
│  POLICY             Crypto board · Standards · Exceptions · Procure   │
│                     Cadence: monthly policy board · exception triage  │
├─────────────────────────────────────────────────────────────────────┤
│  OPERATIONAL        CBOM · CDG · Change mgmt · CI/CD gates          │
│                     Cadence: continuous automation · weekly quality   │
│                     review · quarterly baseline certification         │
├─────────────────────────────────────────────────────────────────────┤
│  ASSURANCE          Internal audit · Pen test · Validation · Exam   │
│                     Cadence: annual audit cycle · per-wave validation │
│                     · examination readiness refresh                   │
└─────────────────────────────────────────────────────────────────────┘
              Authority flows downward. Evidence flows upward.
```

The operating model principle is simple: **each layer has named owners, defined cadences, and explicit escalation paths**. Layers do not collapse into one "PQC working group" that meets monthly without decision authority. Collapsed governance produces the pilot permanence Marcus Chen diagnosed at GlobalSync — activity without outcomes.

**Table 15.3 — Governance Stack Layer × Operating Functions**

| Layer | Primary owner | Key operating functions | Escalation trigger |
|-------|---------------|------------------------|-------------------|
| **Strategic** | Board risk committee / CISO | Charter approval; risk appetite; annual progress | Programme > 15% behind regulatory anchor |
| **Programme** | Programme director | Wave execution; budget; steering; KPI reporting | Wave exit miss > 4 weeks |
| **Policy** | Crypto governance board | Algorithm matrix; hybrid policy; exceptions | Exception backlog > 30 days |
| **Operational** | CBOM custodian + domain leads | Inventory quality; CDG maintenance; change records | CBOM coverage drop; blocking node stall |
| **Assurance** | Internal audit / assurance lead | Validation; pen test; exam readiness | Critical finding without remediation plan |

Parts III and IV populated Operational and Policy layers with CBOM, CDG, TRADE scoring, agility standards, and hybrid patterns. Chapter 15 completes the **Programme** and **Strategic** operating functions — the layers that Parts III–IV assumed but did not fully specify.

---

## 15.3 Strategic Layer: Board Integration and Risk Appetite

The Strategic layer connects PQC migration to enterprise risk management — not as a security sub-project, but as a **multi-year enterprise change programme** with board visibility.

### Board risk committee integration

Quantum threat belongs in the enterprise risk register with documented likelihood, impact, and velocity — using the threat methodology from Chapter 2. The board risk committee (or equivalent) receives **annual charter renewal** and **quarterly progress reporting** tied to wave exit criteria and regulatory milestones, not activity counts.

**Strategic layer artefacts:**

- Enterprise risk register entry: quantum / cryptographic obsolescence
- Board-approved programme charter (initial and annual renewal)
- Risk appetite statement: acceptable migration timeline variance, exception tolerance, dual-algorithm overlap duration
- Annual board narrative: progress, gaps, funding adequacy, regulatory horizon changes

Meridian Mutual Bank's board risk committee added PQC as a **standing agenda item** in Q1 2026 — not a one-time briefing. Elena Vasquez ensured each quarterly pack answered the same four questions: What migrated? What blocks? What regulatory dates apply? What investment is required next period? Consistency trained the board to evaluate outcomes, not enthusiasm.

### Charter renewal versus charter creation

Initial charter creation authorises the programme. **Annual charter renewal** re-authorises scope, funding, and authority against changed estate reality. Renewals incorporate CBOM delta (new acquisitions, decommissions), regulatory horizon updates (Chapter 3), and wave replanning outcomes (Chapter 9). Enterprises that treat charter as write-once documentation discover authority drift — new organisations join through M&A without programme scope; regulatory overlays expand without budget adjustment.

### Regulatory overlay at Strategic layer

Chapter 3's regulatory overlay matrix belongs at Strategic layer with **quarterly horizon monitoring** feeding steering committee and board packs. Thomas Bergström's regulatory affairs function at Meridian produced horizon reports that triggered policy updates twice in 2026 — demonstrating governance responsiveness supervisors expect under DORA's flexible, risk-based formulation.

---

## 15.4 Programme Layer: Charter, Authority, and Scope

The Programme layer is where migration **executes as managed portfolio** — waves, budget, dependencies, and cross-functional conflict resolution.

### Programme charter — mandatory contents

The programme charter is the Programme layer's founding document. It requires board or board-delegated approval — typically the board risk committee or audit committee for financial institutions. A charter without explicit **migration authority** is a communications plan, not a programme.

**Table 15.4 — Programme Charter Contents**

| Section | Purpose | Minimum content |
|---------|---------|-----------------|
| **Purpose and scope** | Define boundaries | In-scope systems, geographies, subsidiaries; explicit exclusions |
| **Regulatory drivers** | Link to Strategic layer | Overlay matrix reference; applicable milestones |
| **Organisational authority** | Empower execution | Programme director appointment; decision rights matrix |
| **Governance structure** | Define forums | Steering committee TOR reference; escalation ladder |
| **Wave plan reference** | Connect to Chapter 9 | Board-approved wave document ID; replanning trigger |
| **Funding envelope** | Multi-year commitment | Capital and operational budget ranges by wave; contingency reserve |
| **KPI framework** | Outcome measurement | Dashboard template (§15.12); reporting cadence |
| **RACI reference** | Accountability | RACI matrix version; acknowledgement process |
| **Dependency management** | CDG integration | Blocking node escalation; cross-domain coordination |
| **Assurance integration** | Close the loop | Validation programme link; audit access rights |
| **Review and renewal** | Prevent drift | Annual renewal date; amendment process |

GlobalSync's 2026 charter explicitly named **three regional programme leads** reporting to a global programme director — matrixed, not federated. Regional leads owned local stakeholder management; the global director owned wave integrity, CBOM standards, and steering committee agenda. Federated models without global wave authority reproduced the Frankfurt–Singapore–Oregon collision Marcus presented to the board.

**Charter scope discipline** matters as much as authority. Charters that declare "enterprise-wide PQC migration" without naming exclusions create audit contradictions — subsidiaries mid-divestiture, acquired platforms pending integration, and OT enclaves under separate accreditation boundaries should appear explicitly as in-scope, out-of-scope, or phased-entry. Apex's charter listed **NSS enclaves** and **commercial IT** as separate scope sections with cross-reference indices only — never merged scope statements. Northfield's charter excluded **retail customer premises equipment** from Wave 0–2 scope while including **WAN concentrators** — honest scope preventing false progress claims.

### Programme director role

The programme director is accountable for **wave execution outcomes**, not cryptographic engineering depth. Typical profile: senior programme manager with enterprise change experience, dotted-line authority to domain VPs, and direct access to CISO and CFO for escalation.

**Programme director responsibilities:**

- Maintain wave register linked to CBOM IDs
- Chair or co-chair steering committee
- Own KPI dashboard integrity
- Coordinate cross-domain blocking resolution
- Manage programme office staff and vendor PMO interfaces
- Prepare board quarterly packs with CISO

The programme director does **not** unilaterally approve algorithm policy (Policy layer), override risk appetite (Strategic layer), or waive assurance findings (Assurance layer). Clear boundary prevents both overreach and accountability vacuum.

---

## 15.5 Migration Authority and Decision Rights

Migration authority defines **who can decide what** — the most common governance gap in PQC programmes. Architecture standards (Part IV) specify correct constructions; migration authority specifies who can mandate their adoption across organisational boundaries.

**Table 15.5 — Migration Authority Matrix**

| Decision type | Authority level | Consulted | Informed |
|---------------|----------------|-----------|----------|
| Wave membership change | Programme director + domain VP | CISO; enterprise architect | Steering committee |
| Wave funding reallocation (>10%) | Steering committee | CFO; programme director | Board risk committee |
| Production hybrid deployment approval | Domain VP + CISO | Crypto engineering; assurance | Programme office |
| Partner profile mandate | Programme director + commercial lead | Legal; partner management | Affected domain teams |
| Vendor non-compliance escalation | Procurement + programme director | Legal; CISO | Steering committee |
| Exception / risk acceptance (>90 days) | CISO + risk committee chair | Legal; internal audit | Board (if regulatory exposure) |
| Algorithm policy change | Crypto governance board | Engineering; assurance | All domains |
| CBOM scope expansion | Programme director + enterprise architect | Finance (M&A) | Steering committee |
| Programme charter amendment | Board risk committee | CISO; programme director | Executive committee |

> **Architect's Decision**
>
> **Centralise partner-facing negotiation authority; distribute implementation authority.** GlobalSync's Wave 0 succeeded when the programme director could mandate a single partner mTLS profile at the gateway tier (Chapter 10). Microservice teams retained implementation autonomy within profile constraints. Programmes that centralise all implementation decisions create bottlenecks; programmes that distribute negotiation create incompatible partner matrices.

### Authority without charter backing

Informal authority — "the CISO said so" — fails at organisational seams: procurement, legal, regional MDs, and product P&L owners. Charter-backed authority gives programme directors **documented escalation** when consulted parties withhold cooperation. Marcus Chen's September 2026 board session explicitly amended charter §4.2 to authorise programme director escalation to regional MDs within five business days — converting cultural norm into enforceable governance.

---

## 15.6 Steering Committee Design

The PQC steering committee is the Programme layer's **decision forum** — not a status meeting. Status belongs in KPI dashboards and programme office weekly reviews. Steering committee time is for decisions that require cross-functional trade-offs: funding, wave reprioritisation, vendor escalation, deferral approvals, and regulatory response.

### Membership

**Core voting members:**

- Programme director (chair)
- CISO or deputy
- Enterprise architect
- Representative VP Engineering (rotating or domain-specific by agenda)
- Procurement / vendor management lead
- Legal / compliance representative
- Finance / portfolio management representative

**Standing advisors (non-voting):**

- Crypto engineering lead
- CBOM custodian
- Internal audit liaison
- Regulatory affairs (Meridian: Thomas Bergström's function)
- Regional programme leads (GlobalSync: when cross-region items on agenda)

**Table 15.6 — Steering Committee Terms of Reference (Summary)**

| Element | Specification |
|---------|---------------|
| **Purpose** | Resolve cross-domain migration decisions; approve wave funding gates; escalate to board |
| **Cadence** | Monthly standard; bi-weekly during Wave 0 execution |
| **Quorum** | Chair + CISO + one domain VP + finance or procurement |
| **Decision method** | Consensus preferred; programme director tie-break on operational items; board escalation on risk appetite |
| **Standing agenda** | KPI review; blocking nodes; wave exit status; exceptions; vendor escalations; regulatory horizon |
| **Minutes** | Decision log with owner, date, artefact reference — not narrative summaries |
| **Escalation** | Items unresolved in two sessions → board risk committee |

### Steering versus architecture board

Enterprises conflate steering committee with crypto governance board (Policy layer). Separation preserves decision quality:

- **Steering committee** — portfolio, funding, waves, vendor escalation, cross-domain conflicts
- **Crypto governance board** — algorithm matrix, profile catalogue, hybrid policy interpretation, technical exception triage

Meridian held crypto governance board monthly (Thomas Bergström chairing technical policy) and steering committee monthly (Elena Vasquez's programme director chairing execution). Overlap membership — CISO, enterprise architect — provided coherence without forum collapse.

---

## 15.7 RACI Matrix — Programme Functions

The RACI matrix assigns **Responsible, Accountable, Consulted, and Informed** roles for programme functions. Publish RACI with named individuals, not role titles alone. Require acknowledgement from Accountable parties during charter approval.

**Table 15.7 — PQC Programme RACI Matrix**

| Function | Board / risk committee | Programme director | CISO | Enterprise architect | Domain VP eng | CBOM custodian | Procurement | Legal / compliance | Internal audit | Crypto engineering |
|----------|------------------------|-------------------|------|-------------------|---------------|----------------|-------------|-------------------|----------------|-------------------|
| Programme charter approval | **A** | R | C | C | I | I | I | C | I | I |
| Wave plan maintenance | I | **A** | C | R | C | C | I | I | I | C |
| Wave funding gate approval | **A** | R | C | I | C | I | C | I | I | I |
| CBOM baseline certification | I | C | C | C | I | **A** | I | I | C | R |
| CDG blocking resolution | I | **A** | C | R | R | C | I | I | I | C |
| Algorithm policy updates | I | C | C | C | I | I | I | C | I | **A** |
| Hybrid production approval | I | C | **A** | C | R | C | I | C | I | R |
| Partner profile mandate | I | **A** | C | C | R | I | C | C | I | R |
| Vendor PQC escalation | I | R | C | I | I | I | **A** | C | I | C |
| Exception / risk acceptance | **A** | R | R | C | C | I | I | C | C | C |
| KPI dashboard integrity | I | **A** | C | C | I | R | I | I | I | C |
| Board quarterly reporting | **I** | R | **A** | C | I | C | I | C | I | I |
| Regulatory horizon report | I | C | C | I | I | I | I | **A** | I | I |
| Validation programme (Ch. 18) | I | C | C | C | R | I | I | I | **A** | R |
| Examination readiness pack | I | R | **A** | C | I | R | C | R | C | C |
| CI/CD crypto gate policy (Ch. 17) | I | C | C | **A** | R | C | I | I | I | R |

**RACI discipline rules:**

1. Exactly one **A** per function — if two Accountables, no accountability
2. **R** executes; **A** answers for outcomes — may be same person on small programmes
3. Minimise **C** — over-consultation paralyses Wave 0
4. Review RACI when organisation restructures — M&A, cloud centre consolidation, regional splits

GlobalSync added a **partner programme director** as Accountable for partner profile mandate alongside global programme director — dual Accountable only because charter specified joint signature on partner-facing changes. RACI exceptions require explicit charter language; otherwise enforce single Accountable.

---

## 15.8 Policy Layer Operations

Policy layer operations translate Part II standards and Part IV architecture into **governed, versioned policy** — algorithm matrix, hybrid lifecycle rules, exception process, procurement clauses.

### Crypto governance board cadence

Monthly crypto governance board reviews:

- Algorithm matrix change requests (Chapter 4)
- Policy profile catalogue updates (Chapter 10)
- HLM phase interpretation disputes (Chapter 5)
- Exception triage — ageing, renewal, closure
- Procurement clause template alignment (Chapter 16 preview)

### Exception and risk acceptance integration

NIST IR 8547's deprecation/disallowance framework requires **documented risk acceptance** for continued quantum-vulnerable algorithm use. Policy layer owns the exception template; Assurance layer validates control compensations; Programme layer tracks exception ageing on KPI dashboard.

**Exception register minimum fields:**

- CBOM asset ID and CDG node reference
- Algorithm and protocol in exception
- Regulatory instrument affected
- Risk acceptance owner and expiry date
- Compensating controls
- Remediation wave target
- Steering committee approval reference

Meridian prohibited exceptions exceeding **twelve months** without board risk committee renewal — aligning with DORA's expectation of active risk mitigation rather than indefinite deferral.

---

## 15.9 Operational Layer Cadence

Operational layer is the **system of record** for cryptographic reality — CBOM, CDG, certificate register, change management, CI/CD gates. Chapter 7 and Chapter 8 defined artefacts; Chapter 15 defines **operating cadence**.

**Table 15.8 — Operational Layer Cadence**

| Activity | Owner | Cadence | Output |
|----------|-------|---------|--------|
| CBOM automated ingestion | CBOM custodian | Continuous | Updated rows; quality alerts |
| CBOM quality review | Programme office | Weekly | Quality scorecard |
| CBOM baseline certification | CBOM custodian + steering | Quarterly | Signed baseline declaration |
| CDG edge validation | Enterprise architect | Monthly | Blocking node status |
| Certificate register reconciliation | PKI operations | Weekly | DORA register completeness |
| Wave status ↔ CBOM sync | Programme office | Weekly | Wave burn-down metrics |
| Change record audit | Internal controls | Monthly | Crypto change sample |
| Agility gate compliance (Ch. 10) | Platform engineering | Per deploy | Gate pass/fail metrics |
| TRADE re-score triggers | Programme office | Per trigger event | Updated MPI (Chapter 9) |

GlobalSync automated wave status from CBOM fields — `wave_id`, `hlm_phase`, `blocking_resolved_date` — eliminating slide-deck lag. Steering committee reviewed live dashboard, not programme office reinterpretation.

> **Dependency Alert**
>
> **Operational layer decay is the leading indicator of programme failure.** CBOM coverage that drops after M&A, CDG edges not updated when PKI hierarchy changes, and change records that omit hybrid deployments produce assurance findings that invalidate board narrative. Programme office must treat operational cadence as non-negotiable infrastructure — not discovery project aftermath.

---

## 15.10 Assurance Layer Integration

Assurance layer provides **independent verification** — internal audit, penetration testing, third-party assessments, validation programmes, examination readiness. Chapter 18 develops validation depth; Chapter 15 positions assurance within governance rhythm.

### Assurance operating principles

1. **Assurance plans reference wave plan** — validation effort follows production deployment, not pilot curiosity
2. **Findings feed steering committee** with remediation owners and dates
3. **Examination readiness pack** is living document — quarterly refresh, not annual panic
4. **PQ-ADAPT self-assessment** annual — honest scoring, not marketing

Internal audit at Meridian scoped **cryptographic control testing** to Wave 0–1 production systems in 2027 — aligned with DORA Article 25 testing expectations. Audit findings on incomplete partner certificate register entries triggered procurement escalation within steering committee — closing the loop between Assurance and Programme layers.

---

## 15.11 KPI Dashboard Template

KPIs must measure **outcomes** — assets migrated, blocking reduced, vulnerabilities retired — not activity — pilots launched, meetings held, policies drafted. Chapter 1 warned against substituting activity for outcome; the dashboard enforces discipline.

**Table 15.9 — KPI Dashboard Template**

| KPI category | Metric | Definition | Target (illustrative) | Source | Reporting cadence |
|--------------|--------|------------|----------------------|--------|-------------------|
| **Inventory health** | CBOM verified coverage | % in-scope assets with Tier 1+ evidence | ≥ 90% | CBOM | Monthly |
| **Inventory health** | Quantum-vulnerable % | % in-scope rows with `quantum_vulnerable=true` | Decreasing QoQ | CBOM | Monthly |
| **Dependency** | Blocking fan-in | Sum of dependent systems on unresolved blocking nodes | Decreasing QoQ | CDG | Monthly |
| **Wave execution** | Wave exit on-time % | Waves meeting exit criteria by target date | ≥ 80% | Wave register | Quarterly |
| **Wave execution** | Wave 0 status | Blocking nodes resolved / total | 100% before Wave 1 scale | CDG + wave | Monthly |
| **Deployment** | Production hybrid count | Systems at HLM H1+ in production | Per wave plan | CBOM + change | Monthly |
| **Deployment** | Agility coverage | % CBOM rows at agility Tier 2+ | ≥ 80% by Wave 2 exit | CBOM | Monthly |
| **Deferral** | Overdue deferrals | "Do not migrate yet" past review date | 0 | TRADE register | Monthly |
| **Exceptions** | Exception ageing | Count exceptions > 90 days | Decreasing | Exception register | Monthly |
| **Ecosystem** | Partner profile adoption | % partners on approved profiles | Per wave gate | Partner registry | Quarterly |
| **Ecosystem** | Vendor PQC readiness | % critical vendors with acceptable evidence | ≥ 75% | Procurement tracker | Quarterly |
| **Assurance** | Critical open findings | Assurance findings without remediation | 0 past SLA | Audit tracker | Monthly |
| **Financial** | Budget variance | Actual vs wave budget range | ± 10% | Finance | Quarterly |
| **Maturity** | PQ-ADAPT level | Self-assessment with evidence links | Level 4 entry | Programme office | Annual |

**Dashboard implementation guidance:**

- Pull from CBOM/CDG where possible — manual KPI spreadsheets decay
- RAG thresholds agreed with steering committee — avoid subjective colour each month
- One-page executive view; drill-down for programme office
- Include **regulatory milestone countdown** — NIST 2030 deprecation, CNSA dates, DORA examination windows

Marcus Chen's programme office displayed **blocking fan-in reduction** as headline KPI — aligning with Chapter 1's synchronisation thesis. Meridian added **DORA register completeness** as KPI after mock examination gap — operational layer metric with regulatory consequence.

---

## 15.12 Board Reporting

Board reporting translates programme complexity into **decision-ready narrative** — four to six pages quarterly, annual deep dive at charter renewal.

### Quarterly board pack structure

1. **Executive summary** — RAG status; one paragraph outcome narrative
2. **Regulatory position** — applicable milestones; horizon changes since last report
3. **Wave progress** — exit criteria status; blocking items; next quarter commitments
4. **KPI dashboard** — one-page visual from §15.11
5. **Risk and exceptions** — top five; ageing; regulatory exposure
6. **Funding** — spend vs envelope; next quarter ask if gate approval needed
7. **Assurance summary** — audit/validation status; examination readiness
8. **Appendix** — wave member changes; deferral register; glossary avoided in main text

### Board narrative anti-patterns

| Anti-pattern | Why it fails | Replacement |
|--------------|--------------|-------------|
| "Completed hybrid TLS pilot" | Activity, not outcome | "Migrated N production systems; M% vulnerable PKC retired" |
| "Monitoring NIST developments" | Passive | "Policy updated for IR 8547 draft; wave replan submitted" |
| "Vendor engagement ongoing" | Undefined | "12/16 critical vendors evidenced; 4 escalated" |
| Green everywhere | Credibility loss | Honest amber on blocking nodes with remediation |

Elena Vasquez trained Meridian's CISO office to open quarterly reports with **blocking node status** — board members learned to ask about structural dependencies, not algorithm enthusiasm.

### Board reporting templates

Programme office maintains three reusable templates aligned with Chapter 9 wave governance:

**Template A — Quarterly progress:** Executive summary RAG; wave exit status; KPI one-pager; top five risks; funding position; regulatory countdown.

**Template B — Wave gate approval:** Prior wave exit evidence links; requested budget range; dependency gates; regulatory alignment statement; risk register excerpt.

**Template C — Escalation:** Issue description; weeks overdue; options with cost/timeline; recommended decision; authority required (steering vs board).

Templates reduce authoring burden and train consistent board narrative. Meridian's Template B included DORA article mapping appendix — supervisors received familiar structure during examination.

### Dual-track reporting (Apex)

Apex Defence Technologies required **NSS and commercial swim lanes** in board reporting — Priya Nair presented separate wave progress with shared procurement savings. Forced single-track narrative either understated NSS urgency or overstated commercial progress. Board risk committee appreciated parallel lanes with explicit **interface boundary** metrics — cross-domain guard nodes, not unified PKI.

---

## 15.13 Funding Model

PQC migration funding fails when treated as **one-time capital project** rather than **multi-year change portfolio**. Programme charter must specify funding envelope, wave gates, and contingency.

### Funding components

| Component | Typical % of programme | Notes |
|-----------|------------------------|-------|
| **Wave execution** | 55–65% | Engineering, HSM, PKI, licensing |
| **Programme office** | 8–12% | PMO, CBOM tooling, dashboard |
| **Vendor/procurement** | 10–15% | Upgrades, contractual premiums, dual-run |
| **Assurance/validation** | 8–12% | FIPS transitions, pen test, audit |
| **Contingency** | 10–15% | Partner delays, accreditation rework |

### Wave funding gates

Steering committee approves **wave execution budget** when prior wave exit criteria are met — or documented risk acceptance for partial exit. Gate model prevents Wave 3 funding absorption before Wave 0 blocking resolution.

**GlobalSync gate example:**

- **Gate 0→1:** Partner mTLS profile production; blocking fan-in < 50 dependents on unresolved nodes
- **Gate 1→2:** Tenant contractual profile overlays approved; agility Tier 2 on 70% Wave 1 services
- **Gate 2→3:** Regional PKI issuing hybrid certs; procurement clauses on top 20 vendors

### Portfolio integration

PQC waves compete with cloud migration, ERP, and regulatory programmes. Chapter 9's portfolio rules apply: cap domain change capacity, ring-fence NSS budget (Apex), report **wave capacity utilisation** monthly. Programme director negotiates with portfolio management office — not informal engineering pleas.

### Chargeback and regional funding

GlobalSync adopted **corporate-funded central programme office** with **regional execution budgets** aligned to wave membership. Regional MDs funded domain engineering effort; corporate funded cross-region blocking work — partner gateway, global CBOM platform, steering secretariat. Without corporate funding for cross-region assets, Wave 0 becomes orphan.

---

## 15.14 Operating Rhythm Calendar

Governance fails when cadences are **documented but not calendar-managed**. Programme office maintains master calendar integrating all layers.

**Table 15.10 — Annual Operating Rhythm Calendar**

| Cadence | Forum / activity | Layer | Typical timing | Output |
|---------|------------------|-------|----------------|--------|
| Weekly | Programme office stand-up | Programme | Monday | Action log; escalation flags |
| Weekly | CBOM quality review | Operational | Wednesday | Quality scorecard |
| Bi-weekly | Wave execution sync | Programme | Alternate Tuesdays | Domain status |
| Monthly | Steering committee | Programme | First week | Decision log |
| Monthly | Crypto governance board | Policy | Second week | Policy decisions |
| Monthly | KPI dashboard publish | Programme | After steering | RAG dashboard |
| Monthly | Assurance remediation review | Assurance | Third week | Finding status |
| Quarterly | CBOM baseline certification | Operational | Quarter end | Signed baseline |
| Quarterly | Board risk committee report | Strategic | Per board cycle | Quarterly pack |
| Quarterly | Regulatory horizon report | Strategic / Programme | Quarter start | Horizon brief |
| Quarterly | TRADE re-score cycle | Programme | Mid-quarter | MPI updates |
| Quarterly | Vendor PQC review | Programme / Policy | Per procurement cycle | Vendor scorecard |
| Annual | Charter renewal | Strategic | Anniversary month | Renewed charter |
| Annual | PQ-ADAPT self-assessment | Assurance | Q4 | Maturity report |
| Annual | Substitution drill (Ch. 10) | Operational / Assurance | Scheduled | Drill results |
| Annual | Examination readiness refresh | Assurance | Pre-examination window | Updated pack |

**Calendar discipline:** Programme office publishes **12-month forward calendar** with named owners. Steering committee cancellations for "no decisions" indicate dashboard failure — if KPIs surface issues, decisions exist.

Meridian aligned steering committee with **ICT risk committee** monthly cycle — reducing forum fatigue. Elena Vasquez refused to add ad hoc PQC meetings without steering agenda slot — preserving decision authority concentration.

---

## 15.15 Case Study: GlobalSync Three-Region Programme Office

GlobalSync Logistics operates SaaS logistics platforms across **Americas, EMEA, and APAC** — forty countries, multi-tenant healthcare and enterprise logistics segments, defence-adjacent tenants with contractual crypto requirements. Marcus Chen's 2026 governance redesign created a **three-region programme office** under global programme director Sofia Lindström (appointed from corporate PMO, not security — signalling programme not project).

### Structure

```
                    ┌─────────────────────────────┐
                    │  Board risk committee        │
                    │  Charter · quarterly pack    │
                    └──────────────┬──────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │  Global programme director   │
                    │  Sofia Lindström             │
                    └──────────────┬──────────────┘
           ┌───────────────────────┼───────────────────────┐
           │                       │                       │
    ┌──────▼──────┐         ┌──────▼──────┐         ┌──────▼──────┐
    │ Americas PO  │         │  EMEA PO     │         │  APAC PO     │
    │ Marcus Chen  │         │  (security   │         │  (tenant     │
    │  (matrix)    │         │   liaison)   │         │   contracts) │
    └──────────────┘         └──────────────┘         └──────────────┘
```

**Global functions (centralised):** CBOM platform; CDG maintenance; wave register; KPI dashboard; partner programme; steering secretariat.

**Regional functions (distributed):** Domain engineering execution; local regulatory liaison; tenant notification; regional change windows.

Marcus Chen retained **Americas security architecture accountability** while matrixing to global programme on Wave 0 partner gateway — dual hat explicit in RACI.

### Three-region collision resolution

The September 2026 collision — Frankfurt partner team, Singapore tenant contracts, Oregon platform engineering — resolved through:

1. **Steering decision:** Single partner mTLS profile `gs-partner-mtls-v3` mandatory globally
2. **Funding:** Corporate contingency released for partner retest programme
3. **Calendar:** Aligned regional change windows to Q4 2026 maintenance band
4. **Tenant overlay:** Healthcare tenants received profile inheritance per Chapter 10 — not regional algorithm forks

### Outcomes by Q2 2027

- Wave 0 exit criteria met — blocking fan-in reduced 78%
- Agility Tier 2+ on 74% Wave 1 services
- KPI dashboard live — steering eliminated monthly slide prep
- PQ-ADAPT Level 4 declared for platform workstream — production hybrids under governance

GlobalSync's case demonstrates **Synchronize** as organisational design — not conference calls.

### Tenant and contractual governance

Multi-tenant SaaS adds a **contractual governance** dimension absent from single-enterprise programmes. GlobalSync's APAC programme lead owned **tenant profile overlay** negotiation — healthcare tenants under GDPR Article 9 required elevated profiles (Chapter 9) without per-tenant engineering forks. Steering committee approved **contract clause library** mapping tenant tiers to profile IDs; legal reviewed profile definitions before sales enablement. Programme office tracked **tenant contractual sunset dates** for classical-only profiles — KPI dashboard row "tenant profile adoption" prevented silent classical continuation in renewals.

Marcus Chen noted that three-region structure succeeded because **tenant governance sat in programme office**, not in regional sales organisations incentivised to minimise renewal friction.

---

## 15.16 Meridian Mutual Bank: DORA-Aligned Steering

Meridian's PQC programme predated DORA applicability (January 2025) but **restructured steering in Q2 2025** when Elena Vasquez integrated DORA evidence requirements into programme operating model — not parallel compliance workstream.

### DORA steering integration

| DORA expectation | Steering committee adaptation |
|------------------|------------------------------|
| ICT risk management framework | Standing agenda: framework alignment check |
| Encryption policy currency | Crypto governance board pre-steering review |
| Certificate register | CBOM custodian KPI: DORA register completeness |
| Third-party ICT risk | Procurement escalation slot monthly |
| Testing (Art. 25) | Assurance update on hybrid validation |

Thomas Bergström's regulatory affairs team joined steering as **standing advisor** — not to approve engineering decisions, but to flag supervisory interpretation shifts before examination.

### Supervisory examination rehearsal

Meridian conducted **mock examination** in Q3 2026 using Chapter 3's six supervisory questions. Steering committee received findings as decisions:

- SaaS certificate register gaps → procurement contract amendments (Chapter 16)
- Two vendor roadmaps inadequate → escalation with concentration risk assessment
- Exception register ageing → 90-day renewal policy enforced

Elena's programme office produced **examination readiness pack** as living Assurance layer artefact — linked from KPI dashboard, refreshed quarterly.

### Steering decision example

HSM vendor delay threatened Wave 0 payment processing migration. Steering options: (a) delay Wave 0 six months, (b) temporary classical continuation with risk acceptance, (c) accelerate alternate vendor qualification. Decision: **(b) with twelve-month maximum** risk acceptance, vendor escalation to board if not resolved — documented in minutes with DORA Art. 9 risk mitigation framing.

---

## 15.17 Apex Defense Technologies: NSS Governance Separation

Apex operates under **mandate collision** (Chapter 1): CNSA 2.0 for NSS, NIST IR 8547 for corporate IT, CMMC for CUI, contract flow-down from multiple agencies. Priya Nair's governance model **refuses single-track steering** for classified and commercial cryptography.

### Dual governance tracks

| Element | NSS track | Commercial track |
|---------|-----------|------------------|
| Steering sub-committee | NSS migration board | Commercial IT steering |
| CBOM namespace | `nss` boundary tag | `commercial` |
| Algorithm authority | CNSA matrix | Enterprise matrix (Ch. 4) |
| Assurance | Accreditation authority | SOC 2 / CMMC assessors |
| Board reporting | Swim lane 1 | Swim lane 2 |

**Shared services:** Procurement negotiation for common vendors; interface specification for cross-domain guards; programme office PMO tooling.

**Hard separation:** No unified PKI; no shared signing keys; no proxy CBOM. Priya's architecture board rejected cost-saving unification proposals — CDG review showed cross-classification trust edges (Chapter 8).

### NSS programme authority

NSS migration board includes **accreditation authority liaison** — decisions that affect accreditation boundaries require liaison sign-off before steering escalation. Priya Nair chairs technical policy; programme director chairs execution — separating Policy and Programme layers within NSS track.

### CMMC and contract alignment

Apex linked steering agenda to **contract renewal calendar** — CDG nodes carry `contract_renewal_date`. 2027 renewals referencing CNSA algorithms received Wave 0 priority despite lower commercial MPI scores. Board reporting shows **contract-gated milestones** explicitly — defensible to defence customer auditors.

---

## 15.18 Northfield Energy Systems: Essential Entity Reporting

Northfield Energy is a US critical infrastructure operator — **not NIS2 subject** (Chapter 3) — but faces NERC CIP, TSA directives, state utility commission reporting, and CISA sector guidance. James Whitfield's programme adapted Governance Stack operating model with **US regulatory overlay** without duplicating EU programme structure.

### Essential entity equivalent reporting

Northfield's board receives **essential-entity-equivalent reporting** — terminology borrowed from NIS2's proportionality concept without claiming EU jurisdiction:

- Risk-based measures documentation (state utility commission)
- Encryption control evidence (NERC CIP electronic access)
- Supply chain assessment (TSA pipeline security)
- Migration plan alignment (CISA PQC initiative)

James mapped Governance Stack artefacts to **US instruments** using Chapter 3's annotation approach — same CBOM, same wave plan, different regulatory tags.

### OT governance adaptation

Northfield's steering committee includes **OT operations VP** as core voting member — WAN concentrator programme (Chapter 12) demonstrated IT-only governance fails OT reality. OT Wave 4 long-tail items receive **honest deferral** with review dates — not steering neglect.

**Field operations calendar integration:** OT maintenance windows drive wave scheduling — programme office publishes **OT blackout periods** on master calendar. James rejected IT-centric steering dates that ignored harvest season and storm response holds.

### KPI adaptations

Northfield added:

- **OT agility ceiling honesty** — % OT devices at documented ceiling vs fictional Tier 4 claims
- **CPE firmware readiness** — partner ecosystem metric from Chapter 12
- **Historian confidentiality coverage** — threat-immediate Wave 1 metric

Assurance layer coordinates with **NERC CIP evidence collection** — examination readiness pack structured for CIP auditors, not DORA templates copied incorrectly.

James Whitfield's board pack used **plain-language OT risk framing** — historian confidentiality, remote access concentrator integrity, firmware signing trust — rather than EU regulatory vocabulary that confused US utility commissioners. The Governance Stack structure remained identical; only overlay annotations and narrative tone adapted. This portability is deliberate: programme directors should not rebuild governance from scratch per jurisdiction.

### James Whitfield's escalation example

When CPE firmware readiness stalled WAN hybrid rollout (Chapter 12), James escalated through programme authority matrix — not informal field operations relationships. Steering committee approved **phased concentrator hybrid** with classical fallback for legacy CPE cohort, twelve-month exception register entries per site cluster, and vendor escalation funded from contingency. Board received Template C escalation — options, costs, recommended phased approach — and approved without requesting algorithm tutorial. Governance converted a field operations deadlock into documented risk acceptance.

> **Regulatory Lens**
>
> **Governance models are portable; regulatory overlays are not.** Northfield's steering structure mirrors Meridian's — charter, RACI, KPI dashboard, board pack — but regulatory horizon monitoring tracks NERC, TSA, and CISA publications, not DORA RTS. Multinational enterprises need jurisdiction-specific overlay annotations on a **single programme operating model**, not separate programme offices per regulation.

---

## 15.19 Programme Office Functions and Staffing

Minimum programme office functions for Level 4 enterprises:

| Function | FTE range (illustrative) | Notes |
|----------|--------------------------|-------|
| Programme director | 1 | Dedicated; not dual-hat CISO |
| PMO / wave coordination | 1–3 | Scales with wave count |
| CBOM custodian | 1–2 | May share with GRC tooling team |
| Reporting / KPI analyst | 0.5–1 | Dashboard integrity |
| Steering secretariat | 0.5 | Minutes, decision log, calendar |

Small enterprises may combine roles — but **programme director and CBOM custodian should not be one person**; inventory quality suffers when execution pressure mounts.

### Programme office anti-patterns

| Anti-pattern | Symptom | Remediation |
|--------------|---------|-------------|
| **Steering theatre** | Monthly status, no decisions | KPI-driven agenda; decision log |
| **RACI wallpaper** | Published once, ignored | Acknowledgement at charter renewal |
| **Pilot permanence** | H1 in lab, not production | Wave exit criteria; migration authority |
| **Regional fiefdoms** | Wave 0 blocked at seams | Charter escalation; corporate funding |
| **Assurance surprise** | Audit findings without owners | Assurance layer in steering cadence |
| **Funding cliff** | Annual budget only | Multi-year envelope; wave gates |

---

## 15.20 Cross-References and Prerequisites

Chapter 15 assumes artefacts from Parts III–IV:

| Prerequisite | Chapter | Programme use |
|--------------|---------|---------------|
| Board-approved wave plan | 9 | Wave funding gates; KPI targets |
| CBOM baseline | 7 | Operational layer cadence |
| CDG with blocking nodes | 8 | Escalation; Wave 0 priority |
| TRADE methodology | 9 | Re-score triggers; deferral register |
| Algorithm / hybrid policy | 4–6, 10–11 | Policy layer operations |
| Agility standards | 10 | KPI agility coverage |
| Architecture patterns | 11–14 | Production approval criteria |

**Forward references:** Chapter 16 operationalises procurement and vendor RACI rows. Chapter 17 defines CI/CD gate ownership. Chapter 18 defines validation programme assurance integration.

---

## 15.21 PQ-ADAPT Level 4 Entry Checklist

Before declaring Level 4 (*Transitioning*), programme office confirms:

- [ ] Programme charter board-approved with migration authority matrix
- [ ] Steering committee operational ≥ 3 cycles with decision log
- [ ] RACI published with named Accountables acknowledged
- [ ] KPI dashboard live with automated CBOM/CDG feeds where feasible
- [ ] Wave 0 exit criteria met or documented risk acceptance
- [ ] Production HLM H1+ deployments with change records
- [ ] Exception register current — no expired acceptances
- [ ] Regulatory overlay quarterly report active
- [ ] Board quarterly pack delivered at least once
- [ ] Assurance validation programme scoped to production deployments
- [ ] Operating rhythm calendar published 12 months forward
- [ ] Procurement PQC clause programme initiated (Chapter 16)

GlobalSync declared Level 4 Q2 2027. Meridian declared Level 4 Q3 2027 after first hybrid production payment services. Apex declared NSS track Level 4 Q4 2027 after firmware signing H2 on two platforms — commercial track remained Level 3 until 2028.

---

## 15.22 Figure Production Briefs

**Figure 15.1** (§15.2): Five-layer Governance Stack with operating cadences annotated on right margin. Show authority downward arrows on left, evidence upward arrows on right. Include small callouts linking layers to teaching org artefacts (GlobalSync charter, Meridian DORA pack, Apex dual track, Northfield OT calendar).

**Figure 15.2** (§15.15): GlobalSync three-region programme office structure — org chart with centralised vs regional functions colour-coded. Show partner programme and CBOM platform as shared services. Include escalation path to board risk committee.

**Figure 15.3** (§15.14): Annual operating rhythm calendar as circular or Gantt-style wheel — monthly inner ring (steering, crypto board, KPI), quarterly outer ring (baseline, board, horizon), annual markers (charter, PQ-ADAPT, substitution drill). Legend for Governance Stack layer colour.

**Figure 15.4** (§15.12): Sample one-page board KPI dashboard mock — RAG indicators, blocking fan-in trend line, wave progress bars, regulatory countdown, exception ageing table. Watermark "illustrative planning example."

---

## 15.23 Apply in Your Organisation

1. **Draft programme charter** using Table 15.4 — secure board risk committee approval before Wave 0 scale.
2. **Publish migration authority matrix** (Table 15.5) — resolve partner and procurement gaps explicitly.
3. **Establish steering committee TOR** (Table 15.6) — decision log from first session.
4. **Publish RACI** (Table 15.7) with named individuals — require Accountable acknowledgement.
5. **Implement KPI dashboard** (Table 15.9) — automate from CBOM/CDG where possible.
6. **Deliver first quarterly board pack** using §15.12 structure — outcome metrics only.
7. **Define funding envelope and wave gates** — multi-year, not annual cliff.
8. **Publish 12-month operating rhythm calendar** (Table 15.10) with named owners.
9. **Integrate regulatory overlay** quarterly report — Chapter 3 horizon monitoring.
10. **Separate steering from crypto governance board** — portfolio vs policy decisions.
11. **Complete Level 4 entry checklist** (§15.21) before declaring Transitioning maturity.
12. **Rehearse supervisory or audit questions** — examination readiness pack as living document.

---

## 15.24 Chapter Summary

- Parts I–IV produce standards, inventory, architecture, and patterns; **Part V produces the operating model** that prevents pilot permanence and governance decay.
- The **PQC Governance Stack** operates through five layers with named owners, cadences, and escalation paths — Strategic, Programme, Policy, Operational, Assurance.
- **Programme charter**, **migration authority**, and **steering committee** form the Programme layer core — wave execution requires documented decision rights.
- **RACI matrix** and **KPI dashboard** convert accountability and outcomes into steering committee inputs — activity metrics excluded.
- **Board reporting**, **funding model**, and **operating rhythm calendar** sustain multi-year migration as enterprise discipline.
- **GlobalSync** three-region programme office demonstrates Synchronize at scale; **Meridian** integrates DORA into steering; **Apex** separates NSS and commercial governance; **Northfield** adapts essential-entity reporting for US critical infrastructure.
- **ARCS Synchronize** and **PQ-ADAPT Level 4** entry require production hybrids under programme governance — not architecture standards alone.

**Next:** Chapter 16 — Procurement, Contracts, and Third-Party Risk — encodes PQC requirements in commercial relationships and activates vendor RACI rows this chapter defined.

---

*Chapter 15 — References*

- Commission Delegated Regulation (EU) 2024/1532 of 19 October 2024 supplementing Regulation (EU) 2022/2554 with regard to regulatory technical standards for ICT risk management. *Official Journal of the European Union*, L 2024/1532.
- Cybersecurity and Infrastructure Security Agency. (2024). *Post-quantum cryptography migration guidance for critical infrastructure*. U.S. Department of Homeland Security.
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Institute of Standards and Technology. (2024). NIST SP 1800-38: Migration to post-quantum cryptography. National Cybersecurity Center of Excellence.
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- Regulation (EU) 2022/2554 of the European Parliament and of the Council on digital operational resilience for the financial sector (DORA). *Official Journal of the European Union*, L 333.
- World Economic Forum. (2024). *Quantum security: Preparing for the post-quantum era*. Insight Report.
- ISACA. (2025). *Governance of enterprise technology: Programme and portfolio management*. Guidance framework.
- Project Management Institute. (2021). *The standard for program management* (4th ed.). PMI.
- GlobalSync Logistics programme office. (2027). *Illustrative three-region PQC operating model* (composite case study).

---

*Proceed to Chapter 16: Procurement, Contracts, and Third-Party Risk.*
