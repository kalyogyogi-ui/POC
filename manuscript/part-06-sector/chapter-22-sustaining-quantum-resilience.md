# Chapter 22
# Sustaining Quantum Resilience

---

In September 2028, Elena Vasquez convened a session she had not imagined when Meridian Mutual Bank's board approved its post-quantum programme charter three years earlier. The room held not only Meridian's programme office and internal audit, but representatives from Northfield Energy Systems, Apex Defense Technologies, and GlobalSync Logistics — four organisations that had never shared infrastructure, contracts, or regulatory supervisors. They shared something more valuable: **three years of migration evidence** under sector constraints that no universal framework could fully predict.

James Whitfield from Northfield described a firmware signing programme that had consumed two maintenance seasons and still left twelve percent of field devices on transitional hybrid profiles. Dr. Priya Nair from Apex presented CMMC closure evidence alongside an NSS track that remained six months ahead of commercial IT on disallowance readiness. Marcus Chen from GlobalSync reported that tenant contract sunsets had retired classical-only mTLS for ninety-four percent of enterprise customers — and that the remaining six percent were the programme's most politically expensive blocking nodes.

Elena listened, then offered Meridian's Year 3 numbers: retail mobile banking on HLM Phase H2 hybrids; payment HSM chain on validated ML-DSA firmware signing; DORA supervisory examination closed with no material findings on cryptographic governance. She also offered Meridian's honest failures: a vendor consolidation that reset CBOM quality for four months; an exception register that had aged badly before internal audit intervened; a board slide that once claimed "PQC complete" when only Wave 2 had exited.

The session was not a conference panel. It was a **structured retrospective** — the kind of organisational learning loop this chapter argues must become permanent capability, not a one-time programme close-out. The four organisations had reached PQ-ADAPT Level 4 (*Transitioning*) in 2027. By late 2028, each approached **Level 5 (*Quantum-Resilient*)** on different timelines, under different regulators, with different blocking nodes — but with convergent lessons about what sustains migration after the first deployment wave ends.

This chapter closes the book with that argument: **migration ends in capability, not in a single deployment.** Enterprises that treat Wave 3 completion as programme termination will rediscover quantum vulnerability in the next acquisition, the next vendor substitution, the next standards publication, and the next generation of engineers who never sat through the 2026 charter briefing. Sustaining quantum resilience requires the continuous loop this chapter defines — standards watch, contingency planning, organisational learning, and PQ-ADAPT Level 5 operations integrated into the governance stack Parts I–V established.

---

## 22.1 Migration Ends in Capability, Not Deployment

The most dangerous sentence in enterprise post-quantum migration is a variant of Elena's rejected board slide: *"We completed PQC."* Cryptography does not complete. Standards evolve. Estates grow. Vendors merge. Algorithms face new analysis. Regulatory supervisors ask not whether you deployed ML-KEM in 2027, but whether your **governance demonstrates state-of-the-art practice** in 2032 when NIST disallowance milestones arrive.

**Capability** means the organisation can:

- **Detect** quantum-vulnerable cryptography as it enters the estate — through maintained CBOM, supply-chain gates, and acquisition due diligence
- **Decide** migration priority under changed threat and regulatory conditions — through TRADE rescoring and CDG updates
- **Deploy** algorithm substitution within defined change windows — through crypto-agility architecture and validated modules
- **Demonstrate** evidence to supervisors, assessors, and boards — through assurance rhythm and regulatory overlay maintenance
- **Adapt** when standards bodies publish new algorithms or deprecate existing ones — through contingency planning and policy amendment without programme recharter

A **deployment** is a point-in-time state: hybrid TLS on the customer portal, ML-DSA on the firmware signing chain, partner mTLS profile version 4. Deployments are necessary evidence of Level 4 maturity. They are insufficient evidence of Level 5 sustainability.

Campbell's timeline research (Chapter 1) established that large-enterprise migration spans 12–15 or more years. An enterprise declaring victory at Year 3 has typically addressed the highest-visibility, highest-priority wave — not the long tail of embedded devices, acquired subsidiaries, legacy partner integrations, and shadow IT cryptography that inventory programmes surface continuously. The Year 3 retrospective across Meridian, Northfield, Apex, and GlobalSync confirms the pattern: **progress is real; completion is illusory.**

> **Migration Moment**
>
> *"Wave 2 exited on schedule. Can we close the programme office and return headcount to BAU?"*
>
> Wave exit is a funding gate milestone, not organisational capability transfer. Programme offices that dissolve after early waves leave CBOM maintenance, standards watch, and substitution drills without owners — and Level 4 maturity decays to Level 2 within two budget cycles. Sustaining quantum resilience requires **permanent custodianship** embedded in operational and assurance layers of the governance stack, with programme-layer intensity scaling down — not disappearing.

### Deployment versus capability — diagnostic questions

Programme directors assessing whether their organisation has transitioned from *project* to *capability* should answer five questions annually:

| Question | Deployment mindset answer | Capability mindset answer |
|----------|---------------------------|---------------------------|
| What triggers algorithm review? | NIST press release noticed by an engineer | Standards watch calendar with assigned owners and board reporting |
| Who owns CBOM quality? | Programme contractor during waves | Named operational custodian with quarterly certification |
| How are new systems approved? | Architecture review ad hoc | SDLC gates enforcing agility NFRs (Chapter 17) |
| What happens when a vendor ships RSA-only firmware? | Incident response | Procurement clause enforcement and CDG blocking escalation |
| How is maturity measured? | Wave completion percentage | PQ-ADAPT self-assessment with evidence artefacts |

Meridian's internal audit used this diagnostic in 2028 Q2 and concluded that Meridian had **capability in payment services and retail channels** but **deployment-only posture** in two acquired insurance subsidiaries still on Level 2 inventory. Elena's response was not defensive — she requested charter amendment to bring acquisitions into scope with explicit Wave 4 funding. Capability organisations acknowledge gaps; deployment organisations hide them behind aggregate progress metrics.

### The sustainment funding model

Programmes that fund only **wave execution** without **sustainment line items** discover at Year 3 that CBOM custodianship, standards watch, and substitution drills compete for "BAU security" budget — and lose. Mature enterprises separate:

| Budget line | Typical annual range (illustrative) | Funded activities |
|-------------|-------------------------------------|-------------------|
| **Wave execution** | Decreases post-Year 3 | Protocol migration, PKI cutover, HSM upgrades |
| **Sustainment custodianship** | Stable 15–25% of peak programme spend | CBOM certification, watch calendar, gate maintenance |
| **Assurance and drill** | Stable or increasing | Substitution drills, validation renewal, exam readiness |
| **Contingency reserve** | 5–10% of sustainment | FN-DSA/HQC lab evaluation; emergency TRADE rescore capacity |

GlobalSync's board approved sustainment funding through 2032 explicitly — Marcus presented disallowance countdown alongside headcount plan. Northfield tied sustainment to **reliability capital** rather than "cyber project" — James secured OT maintenance budget alignment for firmware sunset work. Funding vocabulary matters: capabilities funded as projects expire; capabilities funded as controls persist.

> **Case Study Thread**
>
> *Year 3 funding conversation — four organisations, one pattern.*
>
> Elena asked for insurance subsidiary Wave 4 funding, not programme victory laps. James asked for 2029 maintenance season firmware slots, not OT exceptions. Priya asked for commercial IT catch-up headcount, not NSS duplication. Marcus asked for partner SDK inventory tooling, not another hybrid TLS pilot. **Sustainment requests are specific, scoped, and evidence-backed** — the retrospective's shared lesson for board conversations.

---

## 22.2 ARCS Synthesis: From Awareness to Sustained Proof

Chapter 1 introduced **ARCS** — Awareness, Register, Capability, and Synchronize — as four interlocking enterprise capabilities. Parts I through VI developed each phase. Chapter 22 completes the arc by showing how the four phases **operate continuously** at Level 5 rather than sequentially during a finite programme.

**Table 22.1 — ARCS Phase Synthesis (Full Book Arc)**

| ARCS phase | Primary parts | Core artefacts | Level 5 sustainment function |
|------------|---------------|----------------|------------------------------|
| **Awareness** | I | Threat models, regulatory overlay, board narrative | Annual threat and regulatory horizon refresh; CRQC timeline updates without panic or complacency |
| **Register** | III | CBOM, CDG, TRADE waves | Continuous inventory; acquisition and decommission delta; blocking node permanence |
| **Capability** | II, IV | Standards policy, agility architecture, hybrid patterns, PKI/KMS paths | Substitution drills; validation programme renewal; HLM phase progression to H3 |
| **Synchronize** | V–VI | Programme governance, procurement, supply chain, assurance, sector overlays | Standards bodies, vendors, partners, supervisors — ongoing alignment, not one-time wave coordination |

The ARCS framework is not a waterfall. An enterprise at Level 5 runs all four phases simultaneously on a **continuous quantum resilience loop** (§22.5). Awareness without Register produces executive briefings without inventory. Register without Capability produces spreadsheets without deployable architecture. Capability without Synchronize produces pilots that partners cannot adopt. Synchronize without Awareness produces vendor roadmaps followed without regulatory context.

Part VI's sector playbooks (Chapters 19–21) delivered **Proof** — evidence that the universal model survives banking supervision, defence assessment, OT field operations, and multinational cloud regulation. Chapter 22 elevates Proof from a programme phase to an **operating discipline**: annual PQ-ADAPT assessment, supervisory examination readiness, and cross-organisational lessons learned synthesis.

**Figure 22.1 — ARCS Continuous Operation Model**

```
                    ┌─────────────────────────────────────┐
                    │         AWARENESS (Strategic)        │
                    │  Threat · Regulation · Board narrative │
                    └──────────────┬──────────────────────┘
                                   │ informs
         ┌─────────────────────────┼─────────────────────────┐
         │                         │                         │
         ▼                         ▼                         ▼
┌─────────────────┐    ┌─────────────────────┐    ┌─────────────────┐
│   REGISTER      │◄──►│    CAPABILITY       │◄──►│  SYNCHRONIZE    │
│ CBOM · CDG      │    │ Agility · Hybrids   │    │ Vendors · Partners│
│ TRADE waves     │    │ PKI · KMS · Protocol│    │ Standards · Sector│
└────────┬────────┘    └──────────┬──────────┘    └────────┬────────┘
         │                        │                         │
         └────────────────────────┼─────────────────────────┘
                                  │
                                  ▼
                    ┌─────────────────────────────────────┐
                    │   PROOF (Assurance + Sector evidence) │
                    │  PQ-ADAPT · Exams · Lessons learned   │
                    └─────────────────────────────────────┘
                                  │
                                  └──► feeds back to Awareness
```

James Whitfield observed at the September 2028 retrospective that Northfield's OT organisation understood **Register** deeply — device-class CBOM fields, firmware BOM, maintenance windows — but treated **Synchronize** as "vendor management's problem" until a WAN concentrator vendor missed a hybrid profile deadline and blocked twelve substation integrations. Northfield's corrective linked OT asset owners to the programme office's partner escalation path — Synchronize embedded in field operations, not delegated to procurement alone.

Marcus Chen noted the inverse at GlobalSync: **Capability** was strong — platform agility standards, CI/CD gates, tenant profile catalogues — but **Register** lagged in the partner long-tail where microservices consumed classical-only SDKs not visible in platform scans. GlobalSync's 2028 investment was CBOM extension to **partner-ingested dependency manifests** — Register catching up to Capability.

> **Regulatory Lens**
>
> DORA, NIS2, and GDPR Article 32 do not expire when Wave 2 exits. Supervisory expectations for **ongoing** ICT risk management and state-of-the-art security measures imply **continuous** cryptographic governance — not a one-time migration project report. Meridian's 2028 examination pack led with the continuous resilience loop and standards watch calendar, not Wave 2 completion certificates. Thomas Bergström's regulatory affairs team documented that supervisors responded favourably to **sustained process evidence** over **point-in-time deployment claims**.

---

## 22.3 PQ-ADAPT Levels 4 and 5: Transitioning to Quantum-Resilient

Chapter 15 defined **PQ-ADAPT Level 4 (*Transitioning*)** entry criteria: programme charter, steering committee, production hybrids, supplier clauses, validation programme active. Level 4 is the sustained middle phase where hybrid deployments are normal operations governed by the Hybrid Lifecycle Model (Chapter 5), not exceptions requiring CISO sign-off per incident.

**Level 5 (*Quantum-Resilient*)** marks the organisational state where:

- Quantum-vulnerable public-key cryptography is **retired from in-scope production systems** per enterprise disallowance policy — aligned with but not blindly copying NIST IR 8547 milestones
- **Continuous CBOM** confirms zero disallowed algorithms in production scope, with defined tolerance for documented transitional exceptions approaching sunset
- **Crypto-agility is tested annually** through substitution drills — not assumed from architecture standards
- **Standards watch and contingency planning** operate on published calendar with board visibility
- **Organisational learning loops** convert incidents, near-misses, and retrospective findings into policy and gate updates

Level 5 is not "immune to quantum computers." It is **governed readiness for algorithm evolution** with evidence that the organisation will detect and respond to the next transition — whether driven by disallowance deadlines, cryptanalytic developments, or contract requirements for FN-DSA or HQC deployment.

**Table 22.2 — PQ-ADAPT Level 4 vs Level 5 Comparison**

| Dimension | Level 4 (*Transitioning*) | Level 5 (*Quantum-Resilient*) |
|-----------|---------------------------|-------------------------------|
| **Primary posture** | Production hybrids (HLM H1/H2) under programme governance | PQC-native or H3; classical component retired per policy |
| **CBOM** | Maintained; wave-linked updates | Continuous; quarterly certified baseline; acquisition integration SLA |
| **Exceptions** | Risk acceptance register with renewal discipline | Minimal; aged exceptions trigger board escalation |
| **Validation** | Active for deployed hybrids | Annual renewal; substitution drill evidence |
| **Procurement** | PQC clauses in renewal path | PQC clauses standard; non-compliant vendors disqualified |
| **Standards watch** | Quarterly horizon report | Calendar-driven with contingency activation criteria |
| **Programme office** | Full wave execution intensity | Reduced to custodian + steering rhythm; permanent operational owners |
| **Board narrative** | Migration progress | Resilience capability; disallowance readiness countdown |
| **Sector evidence** | Examination preparation | Examination closure; sustained compliance demonstration |

### Level 4 exit and Level 5 entry criteria

**Table 22.3 — PQ-ADAPT Level 5 Entry Criteria**

| Criterion | Evidence artefact | Governance layer |
|-----------|-------------------|------------------|
| Disallowance policy operational | Board-approved policy aligned to NIST IR 8547 / sector anchors | Strategic / Policy |
| HLM H3 or classical sunset complete for in-scope production | CBOM query: zero disallowed PKC in production scope | Operational |
| Continuous CBOM certified quarterly | Custodian sign-off; coverage metrics within tolerance | Operational |
| Annual crypto-agility substitution drill passed | Test report; remediation closed within 90 days | Assurance |
| Standards watch calendar active | Published calendar; owner assignments; last review minutes | Policy |
| Contingency algorithm posture documented | FN-DSA/HQC monitoring record; activation criteria | Policy |
| Validation programme current | FIPS 140-3 module inventory matches production | Assurance |
| Lessons learned loop operational | Retrospective outputs linked to policy/gate updates | Programme |
| Regulatory overlay current | Horizon report within 90 days | Strategic |
| PQ-ADAPT self-assessment completed | Appendix B questionnaire with evidence index | Assurance |

No teaching organisation achieved Level 5 across its entire estate by September 2028. That honesty matters. **Level 5 is a governed target with measurable criteria**, not a marketing claim. Apex's NSS enclave track approached Level 5 on key establishment and signing for new acquisitions; commercial IT remained Level 4 with H2 hybrids on FedRAMP workloads. GlobalSync's EU tenant tier approached Level 5 on external mTLS; APAC legacy tenants remained Level 4. Meridian's card-processing chain approached Level 5; insurance subsidiaries remained Level 3–4. Northfield's WAN and SCADA concentrators approached Level 5; field device long-tail remained Level 4 with documented H2 sunset dates through 2031.

> **Architect's Decision**
>
> **Declare Level 5 per scope zone, not per enterprise banner.** Apex's dual-track governance (Chapter 15) prevented the common failure mode: claiming enterprise Level 5 because the NSS enclave succeeded while commercial SaaS remains classical-hybrid. CBOM scope tags (`nss_enclave`, `commercial_it`, `ot_field`) enable honest maturity reporting that supervisors and assessors trust.

---

## 22.4 PQ-ADAPT Full Maturity Model

The complete **PQ-ADAPT** maturity model — introduced progressively across Parts I–VI — provides the book's longitudinal assessment framework. Chapter 22 presents the consolidated reference for sustained operations and Appendix B self-assessment.

**Table 22.4 — PQ-ADAPT Full Maturity Model**

| Level | Name | Entry criteria (summary) | Typical failure modes | Upgrade investments | Primary book parts |
|-------|------|------------------------|----------------------|---------------------|-------------------|
| **0** | *Unaware* | No quantum risk in risk register; no crypto inventory | Timeline complacency; "wait for CRQC" | Executive briefing; regulatory horizon scan | Part I |
| **1** | *Alerted* | Executive awareness; ad hoc discovery; no charter | Pilot proliferation; algorithm debates without inventory | Programme charter initiation; CBOM scoping | Part I |
| **2** | *Inventoried* | CBOM baseline; HNDL-tiered classification; no architecture standards | Inventory as one-time project; stale CBOM | Agility standards; CDG; TRADE scoring | Parts I, III |
| **3** | *Architected* | Crypto-agility in SDLC; hybrid policy; PKI roadmap approved | Architecture without enforcement; pilots without gates | Programme office; production hybrid path; procurement clauses | Parts II–IV, V start |
| **4** | *Transitioning* | Production hybrids; HSM/KMS PQC paths; supplier contracts; validation active | Pilot permanence; exception register decay; wave heroics | Disallowance policy; HLM H3 execution; continuous CBOM | Parts V–VI |
| **5** | *Quantum-Resilient* | Quantum-vulnerable PKC retired per policy; continuous CBOM; annual agility test | Complacency after first disallowance; acquisition regression | Contingency activation readiness; cross-sector learning loops | Part VI; sustained ops |

**Figure 22.2 — PQ-ADAPT Maturity Progression (Poster View)**

```
  LEVEL 0          LEVEL 1          LEVEL 2          LEVEL 3
  Unaware    ──►   Alerted    ──►   Inventoried  ──►  Architected
     │                  │                │                 │
     │                  │                │                 │
  No inventory    No charter       No agility        No production
  No board item   Ad hoc pilots    Stale CBOM        hybrids governed
                                                       │
                                                       ▼
  LEVEL 5          LEVEL 4
  Quantum-     ◄──  Transitioning
  Resilient          │
     │               │
  H3 / disallowance  Production hybrids
  Continuous CBOM    Programme office
  Annual drill       Validation active
        ▲                  │
        └──────────────────┘
              HLM progression
              Exception sunset
              Wave exit → sustainment
```

Elena Vasquez used Table 22.4 as Meridian's 2028 board slide — not to claim Level 5, but to show **zone-level maturity** with investment asks per zone. The board approved insurance subsidiary acceleration funding because the gap was visible and bounded — not because Meridian's headline was ambiguous.

---

## 22.5 The Continuous Quantum Resilience Loop

Sustained quantum resilience requires a **closed-loop operating model** connecting awareness through proof and back to awareness. The loop replaces the linear "programme plan → execute → close" model that fails for decade-long cryptographic transitions.

**Figure 22.3 — Continuous Quantum Resilience Loop**

```
                    ┌──────────────────────────────────────────┐
                    │                                          │
                    ▼                                          │
            ┌───────────────┐                                  │
            │   SENSE       │  Standards publications            │
            │   (Watch)     │  Threat intel · Vendor advisories  │
            │               │  Regulatory updates · CBOM drift   │
            └───────┬───────┘                                  │
                    │                                          │
                    ▼                                          │
            ┌───────────────┐                                  │
            │   INTERPRET   │  Horizon report                  │
            │   (Analyse)   │  TRADE rescore · CDG update        │
            │               │  Contingency trigger evaluation    │
            └───────┬───────┘                                  │
                    │                                          │
                    ▼                                          │
            ┌───────────────┐                                  │
            │   DECIDE      │  Policy amendment                │
            │   (Govern)    │  Wave replan · Exception triage  │
            │               │  Board / steering escalation     │
            └───────┬───────┘                                  │
                    │                                          │
                    ▼                                          │
            ┌───────────────┐                                  │
            │   ACT         │  Deployment · Substitution       │
            │   (Execute)   │  Procurement enforcement         │
            │               │  Validation · Gate updates       │
            └───────┬───────┘                                  │
                    │                                          │
                    ▼                                          │
            ┌───────────────┐                                  │
            │   PROVE       │  CBOM certification              │
            │   (Assure)    │  Audit · Exam · Drill evidence   │
            │               │  PQ-ADAPT assessment             │
            └───────┬───────┘                                  │
                    │                                          │
                    ▼                                          │
            ┌───────────────┐                                  │
            │   LEARN       │  Retrospective                   │
            │   (Improve)   │  Lessons → policy/gate updates   │
            │               │  Training refresh                │
            └───────┬───────┘                                  │
                    │                                          │
                    └──────────────────────────────────────────┘
                              feeds SENSE (Watch)
```

Each loop phase maps to governance stack layers (Chapter 15):

| Loop phase | Primary governance layer | Cadence |
|------------|-------------------------|---------|
| **Sense** | Policy + Strategic | Continuous automation; weekly digest for crypto board |
| **Interpret** | Programme + Policy | Monthly crypto board; quarterly steering |
| **Decide** | Programme + Strategic | Steering committee; board quarterly |
| **Act** | Operational | Continuous CI/CD; change windows |
| **Prove** | Assurance | Quarterly CBOM cert; annual drill; exam cycle |
| **Learn** | Programme + Assurance | Annual retrospective; post-incident review |

Marcus Chen implemented the loop explicitly at GlobalSync in 2028 Q1 after a near-miss: a cloud provider rotated default TLS policies in a minor region, dropping hybrid negotiation for eleven tenants. **Sense** caught the drift via runtime verification (Chapter 17). **Interpret** rescored affected tenants TRADE-high. **Decide** escalated to steering within 48 hours. **Act** deployed profile correction. **Prove** produced CBOM drift report for affected tenant IDs. **Learn** added provider policy change notification to the standards watch calendar and contractual SLA clause. Without the loop, the incident would have been "fixed" — but not **organisationally absorbed**.

> **Dependency Alert**
>
> The resilience loop's **Sense** phase is only as good as CBOM freshness and runtime verification coverage. Enterprises that certify CBOM quarterly but never compare build-time to runtime cryptography will sense inventory truth, not operational truth. GlobalSync's near-miss was a **runtime drift** problem invisible to build-time gates alone. Level 5 requires both.

---

## 22.6 Organisational Learning Loops

Deployment programmes produce **artefacts** — charters, wave plans, CBOM exports, examination packs. Sustained resilience programmes produce **organisational learning** — changes in behaviour, policy, gates, and incentives that survive staff turnover and vendor substitution.

Organisational learning loops operate at three scales:

### 22.6.1 Incident and near-miss loop (days to weeks)

Triggered by assurance findings, gate failures, partner outages, supervisory questions, or substitution drill defects. Outputs: remediation tickets, exception register updates, targeted training.

Northfield's 2027 firmware signing near-miss — an engineering laptop with exportable keys discovered during internal audit — triggered workstation governance gates (Chapter 17) within six weeks. James Whitfield reported the loop worked because **accountability was named**: OT security owned workstation rows in firmware BOM; internal audit owned verification.

### 22.6.2 Programme retrospective loop (quarterly to annual)

Triggered by wave exit, steering committee annual review, or PQ-ADAPT assessment. Outputs: charter amendments, TRADE weight adjustments, procurement clause updates, training curriculum refresh.

Meridian's annual retrospective identified that **acquisition due diligence** repeatedly reset CBOM quality. Elena's 2028 charter amendment required M&A integration playbook with 90-day CBOM certification SLA — learning converted to policy.

### 22.6.3 Cross-organisational and sector learning loop (annual)

Triggered by industry forums, regulator thematic reviews, peer exchange, or structured multi-organisation retrospectives. Outputs: sector overlay updates, standards watch calendar entries, contingency posture review.

The September 2028 four-organisation session — fictional composite, but representative of industry working groups forming under CISA and ENISA PQC initiatives — produced the **lessons learned synthesis** in Table 22.7. None of the four organisations could have generated the full table from internal evidence alone.

**Table 22.5 — Organisational Learning Loop × Governance Integration**

| Loop scale | Trigger examples | Decision forum | Typical outputs | Anti-pattern |
|------------|------------------|----------------|-----------------|--------------|
| **Incident** | Gate failure; pen test finding; vendor advisory | Crypto board / CCB | Hotfix; gate rule; targeted training | Fix without root-cause policy update |
| **Programme** | Wave exit; annual charter renewal | Steering committee | Charter amendment; wave replan; KPI revision | Retrospective without funding consequence |
| **Sector / peer** | Supervisory thematic; industry WG | Strategic / CISO council | SOM update; watch calendar; contingency review | Attending conferences without artefact updates |

Priya Nair institutionalised learning at Apex through **dual-track retrospective separation**: NSS and commercial IT retrospectives share methodology but not classified detail — commercial lessons flow to programme office; NSS lessons flow through security-cleared channel to policy board. Blending tracks had failed in 2027 when a commercial engineer referenced NSS timeline in a customer-facing RFP response.

---

## 22.7 Standards Watch and Horizon Management

Standards bodies, regulators, and industry consortia publish on **predictable and unpredictable cadences**. Sustaining quantum resilience requires a **standards watch calendar** — not ad hoc monitoring when an engineer notices a NIST mailing list post.

### 22.7.1 Watch calendar principles

1. **Assign owners** — regulatory affairs, crypto engineering, programme office — not "the team"
2. **Define interpretation authority** — who decides whether a publication triggers TRADE rescore or policy amendment
3. **Link to board reporting** — quarterly horizon report minimum at Strategic layer
4. **Separate signal from noise** — Internet-Drafts and vendor blogs are awareness inputs; FIPS publications and IR finalisation are decision triggers
5. **Integrate contingency track** — FN-DSA and HQC milestones appear explicitly, not as footnotes

**Table 22.6 — Standards Watch Calendar (Illustrative Planning Example)**

| Watch item | Source | Typical cadence | Next review window | Decision trigger | Assigned owner | Enterprise action on trigger |
|------------|--------|-----------------|-------------------|------------------|----------------|----------------------------|
| NIST IR 8547 finalisation | NIST CSRC | IPD → final (TBD) | Q1/Q2 annually until final | Final publication | Regulatory affairs | Deprecation/disallowance policy alignment review within 60 days |
| FIPS 203/204/205 errata | NIST CSRC | As published | Continuous | Errata affecting implementation | Crypto engineering | Validation impact assessment; module vendor engagement |
| FN-DSA standardisation | NIST PQC project | 12–18 month cycles | Semi-annual | FIPS publication draft | Crypto engineering + policy | Contingency activation review (§22.8) |
| HQC-KEM standardisation | NIST PQC project | 12–18 month cycles | Semi-annual | FIPS publication draft | Crypto engineering | KEM diversification assessment |
| CNSA 2.0 advisory updates | NSA | Annual–ad hoc | Quarterly | Milestone change | NSS lead / regulatory | NSS track wave replan |
| IETF hybrid TLS RFC status | IETF datatracker | RFC publication ad hoc | Monthly | RFC status change to standards-track | Protocol engineering | TLS profile catalogue update |
| CA/B Forum PQC ballot | CA/Browser Forum | Quarterly meetings | Quarterly | Ballot passing | PKI operations | Certificate profile roadmap update |
| CycloneDX CBOM spec | OWASP CycloneDX | Major versions ~12 months | Per release | Schema breaking change | CBOM custodian | CBOM pipeline migration plan |
| DORA / RTS implementation Q&A | EBA / national supervisors | Thematic reviews | Quarterly | Supervisory statement | Compliance | Evidence pack template update |
| ENISA NIS2 guidance | ENISA | Annual updates | Semi-annual | Guidance revision | Compliance | NIS2 evidence mapping refresh |
| PCI DSS crypto guidance | PCI SSC | 3–5 year cycles | Annual | DSS or guidance update | PCI programme | Payment HSM validation path review |
| Major cloud provider crypto roadmaps | Provider trust centres | Quarterly | Quarterly | Deprecation notice | Cloud architecture | Tenant profile and KMS review |
| OpenSSL / BoringSSL release notes | Open source | Per release | Monthly | Algorithm default change | Platform engineering | Base image refresh wave |

Thomas Bergström at Meridian maintained Table 22.6 as a **living document** — version-controlled, steering committee reviewed, board appendix refreshed quarterly. When NIST published FN-DSA draft FIPS for public comment in 2028 H1, Meridian's calendar triggered contingency review within the published 30-day window — not six months later during annual planning.

> **Migration Moment**
>
> *"We'll notice when NIST publishes something important."*
>
> Enterprises that discovered FIPS 203–205 finalisation from vendor emails in 2024 started programmes late. Enterprises that discover IR 8547 finalisation from the same passive posture will misalign disallowance policy with supervisory expectations. **Active watch** is a Level 5 criterion, not optional intelligence gathering.

---

## 22.8 FN-DSA and HQC Contingency Planning

Chapter 4 established that **FN-DSA** (compact lattice signatures) and **HQC-KEM** (code-based key establishment) are **contingency algorithms** — monitored for diversification and future standardisation, not blocking dependencies for current ML-KEM and ML-DSA deployment. Chapter 22 addresses **operational contingency planning**: what the enterprise does when FN-DSA or HQC progress from "monitor" to "activate."

### 22.8.1 Why contingency planning matters at Level 5

Level 5 organisations have retired or sunsetted quantum-vulnerable PKC in production scope. They face a different risk than Level 2 enterprises paralysed by algorithm choice: **second-transition risk**. If cryptanalytic developments weaken lattice schemes — or if contract requirements mandate FN-DSA for bandwidth-constrained systems — Level 5 organisations must substitute algorithms **without rebuilding programme governance from scratch**.

Crypto-agility architecture (Chapter 10) exists precisely for this scenario. Contingency planning ensures agility is **pre-approved**, not improvised under crisis.

### 22.8.2 FN-DSA contingency posture

**Triggers for formal contingency review** (any one):

- NIST publishes FN-DSA as draft or final FIPS
- Contract explicitly requires FN-DSA support by date
- Supervisory or assessor guidance recommends compact signature alternative
- Internal workload analysis identifies ML-DSA size constraints blocking deployment (bandwidth, embedded storage, DNSSEC UDP limits)

**Pre-approved enterprise actions before activation:**

| Action | Owner | Artefact |
|--------|-------|----------|
| Policy future-proofing clause | Crypto governance board | Algorithm matrix "disabled: FN-DSA-*" rows |
| Lab evaluation environment | Crypto engineering | Non-production validation sandbox |
| HSM/KMS vendor roadmap confirmation | Key management | Vendor evidence request template |
| CBOM normalisation mapping | CBOM custodian | Pre-standard name → FIPS name mapping |
| Agility profile stub | Platform engineering | `policy_profile: signing-compact-contingency-v0` (disabled) |

Priya Nair's Apex policy (Chapter 4, Chapter 10) required **contingency profiles exist in policy service but remain disabled** until CISO and policy board joint activation. In 2028, Apex activated lab evaluation — not production — when FN-DSA draft FIPS entered public comment. Production remained ML-DSA. Apex's CMMC assessor accepted the distinction: **preparedness evidence** without premature non-validated deployment.

**Activation criteria for production FN-DSA** (Apex default — enterprises should document equivalents):

1. Final FIPS publication
2. FIPS 140-3 validated module available for target platform class
3. Policy board approval with TRADE impact assessment
4. Partner ecosystem readiness threshold met for affected protocols (or documented exception)
5. Substitution drill successful in lab and staging

### 22.8.3 HQC-KEM contingency posture

HQC addresses **algorithmic diversification** for key establishment — structurally distinct from ML-KEM's lattice construction. Enterprise trigger scenarios:

- NIST finalises HQC-KEM as approved KEM
- Published cryptanalysis materially affects confidence in ML-KEM parameter sets (governance review — not automatic panic migration)
- Sector guidance mandates code-based KEM for specific workloads
- Customer contract requires non-lattice KEM optionality

**Enterprise actions:**

| Phase | Action |
|-------|--------|
| **Monitor** (default) | Track NIST status; maintain HQC evaluation in lab; document in standards watch calendar |
| **Prepare** | Enable agility profile stub for HQC parameter sets; confirm KMS/HSM vendor roadmap |
| **Evaluate** | TRADE rescore for systems with longest confidentiality horizons; CDG identify ML-KEM-only nodes |
| **Activate** | Policy board decision; staged substitution per wave plan; validation programme extension |

Marcus Chen noted at the 2028 retrospective that GlobalSync's **tenant isolation architecture** simplified KEM contingency: tenant profiles could add HQC rows without cross-tenant migration — configuration change within agility boundaries. Meridian's payment HSM chain could not — **HQC contingency for payment HSMs required vendor module validation** with 18-month lead time. Contingency planning is **sector and architecture specific**; the universal principle is pre-approved activation criteria, not universal timelines.

> **Architect's Decision**
>
> **Do not deploy FN-DSA or HQC in production to "get ahead of standards."** Pre-standard deployment forfeits FIPS validation, confuses CBOM inventory, and creates assessor findings. Lab evaluation, disabled policy profiles, and vendor roadmap confirmation constitute **credible contingency preparedness**. Apex's competitor who claimed "full FN-DSA support" in 2025 failed evaluation for absent validated modules (Chapter 4). The lesson still applies in 2028.

### 22.8.4 Contingency planning artefact pack

Level 5 enterprises maintain a **contingency pack** updated annually:

1. Contingency algorithm status summary (FN-DSA, HQC, others per NIST)
2. Activation criteria checklist (§22.8.2, §22.8.3)
3. Affected system classes from CDG query (ML-KEM-only; ML-DSA size-constrained)
4. Vendor validation roadmap with dates and gaps
5. Substitution drill plan for contingency activation (lab scope)
6. Board briefing template for cryptanalytic event response — separates hype from governance triggers

---

## 22.9 Year 3 Retrospective: Four Organisations

The composite retrospective synthesises programme arcs from Chapters 1, 15–21. Year 3 (~2028) situates each organisation approaching Level 5 in core domains while carrying honest long-tail gaps.

### 22.9.1 Meridian Mutual Bank — Elena Vasquez, CISO

**Year 3 posture:** Level 4 enterprise; Level 5 approaching in card-processing and retail digital channels; insurance subsidiaries Level 3–4.

Elena's programme began with the payment HSM firmware signing chain (Chapter 1) — still the pedagogical example of dependency blocking. By 2028, that chain operated on **validated ML-DSA firmware signing** with acquiring bank trust store updates complete. Retail mobile banking completed HLM H2 hybrid TLS with measured client negotiation above policy threshold. DORA supervisory examination in 2027 closed with **no material findings** on cryptographic governance; 2028 thematic follow-up focused on **sustained process**, not redeployment.

**Year 3 wins:**

- Payment HSM and switch integration — CDG root blocker resolved
- 40-supplier assessment programme (Chapter 16) reduced critical vendor classical-only count from 23 to 4
- Container cryptographic gates (Chapter 17) integrated with DORA change evidence
- Board reporting matured from activity metrics to outcome and capability metrics (Chapter 15)

**Year 3 honest gaps:**

- Insurance subsidiary acquisition reset CBOM coverage for four months
- Exception register aged beyond 90 days until internal audit escalation — **learning loop produced automated ageing alerts**
- One board pack headline "PQC on track" overstated subsidiary progress — Elena instituted zone-level reporting (§22.4)

**Elena's Year 3 lesson:** *"Supervisors reward sustained governance rhythm more than algorithm enthusiasm. Our examination pack leads with the resilience loop and watch calendar — Wave 2 certificates are appendices."*

### 22.9.2 Northfield Energy Systems — James Whitfield, OT Security Director

**Year 3 posture:** Level 4 enterprise; Level 5 approaching on WAN concentrators and SCADA integration layer; field device long-tail Level 4 with H2 profiles through 2031.

James's programme confronted **OT time constants** throughout: maintenance windows measured in seasons, vendor firmware measured in years, NERC CIP evidence measured in audit cycles. Year 3 completed WAN hybrid rollout (Chapter 12) for primary transmission corridors. Firmware signing programme (Chapter 6, Chapter 17) reached production on two of three vendor platforms — third vendor delayed to 2029 maintenance season.

**Year 3 wins:**

- Board reporting in plain language — James's quarterly one-pager linked cryptographic milestones to reliability metrics, not algorithm names
- Firmware BOM and workstation governance integrated after 2027 audit finding
- NERC CIP evidence pack included PQC as **sustained controls**, not one-time project
- OT vendor contracts gained PQC roadmap clauses mirroring IT procurement (Chapter 16)

**Year 3 honest gaps:**

- Twelve percent of field devices on transitional hybrids — physically inaccessible until scheduled outage
- Retail customer premises equipment explicitly out of scope — CDG honesty prevented false enterprise claims
- IPsec migration on legacy CPE still blocked by vendor — **blocking node escalated to steering with regulatory affairs support**

**James's Year 3 lesson:** *"OT teaches patience without complacency. We document sunset dates for every H2 device class and report overdue devices as reliability risk — not as security shame."*

### 22.9.3 Apex Defense Technologies — Dr. Priya Nair, Chief Cryptographic Architect

**Year 3 posture:** NSS track Level 5 approaching for new acquisitions; commercial IT Level 4; dual-track governance maintained without evidence zone bleed.

Priya's February 2025 procurement questionnaire discipline (Chapter 4) scaled to enterprise policy: **standardise on FIPS 203–205; monitor contingency; never claim validated support without modules**. Year 3 closed CMMC assessment (Chapter 18) with PQC controls mapped as SSDF extensions. CNSA 2.0 alignment on NSS track met 2027 milestones for key establishment on new systems; ML-DSA module gap remediation completed 2028 Q2.

**Year 3 wins:**

- CMMC Level 2 closure with PQC gate evidence from CI/CD pipelines (Chapter 17)
- Classified/unclassified boundary enforcement in build promotion — no aggregate metrics across zones
- FN-DSA lab evaluation initiated on draft FIPS — production remained ML-DSA
- FedRAMP hybrid workloads on H2 with documented classical sunset criteria

**Year 3 honest gaps:**

- Commercial IT trail NSS by approximately six months — acceptable per charter; politically tense with sales
- One customer RFP answer in 2027 referenced NSS timeline in commercial context — **learning loop produced RFP review gate**
- Stateful hash signature (LMS/XMSS) firmware on legacy platform still in SP 800-208 operational regime — separate sunset from ML-DSA path

**Priya's Year 3 lesson:** *"Defence customers distinguish preparedness from posturing. Contingency profiles disabled in policy service are evidence. Unvalidated FN-DSA in a demo environment is liability."*

### 22.9.4 GlobalSync Logistics — Marcus Chen, CISO

**Year 3 posture:** Level 4 enterprise; Level 5 approaching on EU and US enterprise tenant tiers; APAC legacy tenants and partner long-tail Level 4.

Marcus's Wave 0 stall (Chapter 15) — three regions without programme authority — became the book's governance cautionary tale. Year 3 demonstrated **Synchronize at scale**: partner mTLS policy unified; tenant contract sunsets retired classical-only profiles for ninety-four percent of enterprise customers. Platform CI/CD gates (Chapter 17) rejected non-agile cryptography at merge time — the tenant notification service incident became cultural reference.

**Year 3 wins:**

- Three-region programme office operating rhythm sustained post-Wave 2 with reduced but permanent headcount
- GDPR cross-border evidence matrix (Chapter 21) linked to CBOM tenant tags
- Runtime drift detection caught cloud provider TLS policy near-miss (§22.5)
- Customer-facing CBOM summaries supported enterprise sales security reviews

**Year 3 honest gaps:**

- Six percent enterprise tenants on classical-only mTLS — commercial blocking nodes with contract renewal leverage through 2029
- Partner-ingested SDK dependencies under-inventoried until 2028 — **Register investment priority**
- Platform concentration risk in single cloud KMS — documented with diversification roadmap

**Marcus's Year 3 lesson:** *"Cloud teaches that agility without inventory is hollow. We can substitute algorithms in hours for tenants we see. We cannot substitute for partners we never scanned."*

### 22.9.5 Cross-case patterns programme directors should expect

Three patterns repeated across all four Year 3 narratives — independent of sector:

**Pattern 1: The long tail dominates headcount years 4–10.** Early waves address CDG blocking nodes and supervisory visibility. Remaining work is numerous low-criticality systems, acquired units, partner SDKs, and field devices — high transaction cost per migration, low individual TRADE score. Programmes without long-tail funding models stall at Level 4 indefinitely.

**Pattern 2: Assurance shifts from "prove we started" to "prove we sustain."** DORA examinations, CMMC assessments, and NERC CIP audits in Years 1–2 tested programme existence. Year 3 questions tested **operating rhythm**: Who owns the watch calendar? When was the last substitution drill? What happens when CBOM coverage drops post-acquisition? Assurance evidence packs must evolve accordingly.

**Pattern 3: Organisational memory decays without deliberate transfer.** Engineers who built hybrid pilots rotate roles; vendor account teams turn over; board members refresh. The September 2028 retrospective existed partly to **re-anchor narrative** before Meridian's original programme sponsor rolled off the board. Sustainment includes onboarding curricula linking new engineers to charter rationale — not only to agility standard version numbers.

---

## 22.10 Lessons Learned Synthesis Across Four Cases

**Table 22.7 — Lessons Learned Synthesis (Four-Organisation Retrospective)**

| Theme | Meridian (Financial) | Northfield (Energy/OT) | Apex (Defence) | GlobalSync (Cloud/SaaS) | Universal principle |
|-------|---------------------|------------------------|----------------|-------------------------|---------------------|
| **Governance** | DORA rhythm sustains board confidence | Plain-language board packs link crypto to reliability | Dual-track prevents evidence bleed | Three-region authority prevents pilot permanence | Programme office permanence — intensity scales, custodianship does not |
| **Inventory** | Acquisitions reset CBOM — M&A playbook required | Firmware BOM + workstation rows blocking | NSS/commercial scope tags mandatory | Partner SDK gap invisible to platform scan | Continuous Register — not wave-scoped project |
| **Architecture** | Payment HSM blocking chain — migrate roots first | OT maintenance windows dictate sunset | Contingency profiles disabled until activation | Tenant profiles enable fast substitution | CDG blocking nodes before visible systems |
| **Supply chain** | Container gates produce exam evidence | Air-gapped promotion workflow | Dual-signature build manifests | Runtime drift detection essential | Build-time green ≠ runtime green |
| **Assurance** | Supervisors prefer process evidence | NERC CIP sustained controls framing | CMMC maps PQC to SSDF extensions | Customer CBOM summaries for trust | Proof layer continuous, not project-closeout |
| **Sector overlay** | PCI/HSM validation cycles dominate | Long device lifetimes; honest scope exclusions | CNSA 2.0 floor; classified boundaries | GDPR cross-border; tenant tier variation | SOM modifies TRADE weights — universal wave plan fails |
| **Failure mode** | Exception register ageing | Vendor firmware delay | RFP zone confusion | Partner long-tail inventory | Learning loops must produce policy/gate changes |
| **Level 5 path** | Zone-level honesty — insurance lag | Field device H2 with dated sunsets | NSS first, commercial follows | Tenant tier graduation criteria | Level 5 per scope zone — not enterprise banner |

The synthesis table is the **artefact programme directors should produce annually** — even without four-organisation peer sessions. Internal retrospective supplemented by sector working groups (ISACs, EBA industry forums, CISA PQC initiative) externalises blind spots.

---

## 22.11 Sustaining the Governance Stack at Level 5

Chapter 15's **PQC Governance Stack** does not dissolve at Level 5. Layer functions evolve:

**Table 22.8 — Governance Stack Evolution Level 4 → Level 5**

| Layer | Level 4 emphasis | Level 5 emphasis |
|-------|------------------|------------------|
| **Strategic** | Charter renewal; wave funding | Resilience capability narrative; disallowance countdown; acquisition crypto policy |
| **Programme** | Wave execution; steering intensity | Custodian rhythm; retrospective; reduced PMO headcount |
| **Policy** | Hybrid policy; exception triage | Disallowance policy; contingency activation; standards watch ownership |
| **Operational** | CBOM wave updates; hybrid deployments | Continuous CBOM certification; H3 enforcement; substitution drills |
| **Assurance** | Wave validation; exam preparation | Annual drill; sustained exam readiness; PQ-ADAPT self-assessment |

Elena reduced Meridian programme office headcount thirty percent post-Wave 2 — but **named custodians** for CBOM, standards watch, and substitution drills with KPI linkage. Marcus maintained GlobalSync's steering committee quarterly — agenda shifted from wave funding to **tenant tier graduation** and **provider concentration risk**. James embedded crypto milestones in Northfield's existing **Change Control Board** — OT security did not maintain parallel governance forever.

### 22.11.1 Annual operating rhythm at Level 5

**Table 22.9 — Level 5 Annual Operating Rhythm (Illustrative)**

| Month | Strategic | Programme | Policy | Operational | Assurance |
|-------|-----------|-----------|--------|-------------|-----------|
| Q1 | Board annual resilience briefing | Retrospective; charter touchpoint | Standards watch annual refresh | CBOM Q1 certification | Substitution drill planning |
| Q2 | Regulatory horizon report | Steering: contingency review | FN-DSA/HQC status update | Acquisition CBOM SLA audit | Drill execution |
| Q3 | PQ-ADAPT self-assessment to board | Wave long-tail review | Algorithm matrix review | HLM sunset compliance scan | Exam / audit readiness refresh |
| Q4 | Next-year funding | Lessons learned synthesis | Policy board annual | CBOM Q4 certification | Validation programme renewal |

---

## 22.12 CRQC Timeline Updates Without Panic or Complacency

Awareness phase sustainment requires **measured response** to cryptographically relevant quantum computer (CRQC) news. Level 5 organisations predefine **governance triggers** separating research milestones from enterprise action thresholds.

**Recommended posture:**

- **Research announcements** (qubit count, error correction papers): Awareness digest only — no automatic TRADE rescore
- **National security or regulatory advisories** shifting timelines: Horizon report within 30 days; steering agenda item
- **Demonstrated attacks on hybrid constructions** or deprecated parameter sets: Emergency crypto board within 14 days; TRADE rescore for affected algorithms
- **CRQC affecting RSA/ECC at enterprise-relevant scale** (hypothetical future): Pre-documented escalation to board; emergency substitution drill; partner notification protocol

Meridian's board asked Elena in 2028 Q3 whether a prominent quantum computing press release should accelerate disallowance. Elena's answer followed pre-documented triggers: **no change** — CRQC remained non-production for cryptanalysis at enterprise scale; HNDL drivers unchanged; disallowance policy already aligned to NIST anchors. Measured response preserved board confidence. Panic acceleration would have diverted funding from insurance subsidiary CBOM integration — higher TRADE priority.

### Hybrid sunset sustainment

HLM Phase H3 — PQC-native posture with quantum-vulnerable PKC removed — is the technical terminus of migration for each system class. Sustaining Level 5 requires **sunset enforcement machinery** that survives programme office downsizing:

1. **CBOM queries** scheduled weekly reporting systems past H2 sunset date without approved exception
2. **Certificate profile automation** rejecting new issuances with disallowed algorithms (Chapter 13)
3. **Partner contract clauses** (Chapter 16) with financial consequences for classical-only regression after sunset date
4. **CI/CD gates** (Chapter 17) blocking promotion when `hlm_phase` metadata regresses from H3 to H2 without exception ID

Northfield's twelve percent field device long-tail is not a governance failure — it is an **honest H2 extension** with named maintenance season sunsets through 2031. Apex's commercial IT six-month NSS lag is **documented charter variance**, not drift. Sustained resilience distinguishes **managed transitional state** from **unmanaged permanent hybridism** — the failure mode Chapter 5 warned against. Permanent hybridism often re-enters through the supply chain, not deliberate policy — a vendor firmware update re-enabling classical-only negotiation on an H2 device will not appear in application CI/CD gates. Northfield's firmware BOM weekly diff and GlobalSync's runtime TLS telemetry exist to catch **regression**; sustainment is defence against backsliding, not only forward migration.

---

## 22.13 Apply in Your Organisation

1. **Adopt the continuous quantum resilience loop** (§22.5) — name owners for Sense, Interpret, Decide, Act, Prove, Learn phases.
2. **Publish standards watch calendar** (Table 22.6) — assign owners; link to quarterly board horizon report.
3. **Complete PQ-ADAPT self-assessment** (Appendix B) — zone-level scoring, not enterprise aggregate.
4. **Document FN-DSA and HQC contingency pack** (§22.8) — activation criteria, disabled policy profiles, vendor roadmaps.
5. **Schedule annual substitution drill** — lab and staging; remediate within 90 days; report to assurance layer.
6. **Produce lessons learned synthesis** (Table 22.7 template) — annual retrospective with funding consequences.
7. **Certify CBOM quarterly** — operational custodian sign-off; coverage and drift metrics to steering.
8. **Transition programme office to custodian model** — reduce intensity; preserve permanent ownership.
9. **Define CRQC response triggers** (§22.12) — separate research noise from governance action.
10. **Declare Level 5 per scope zone** — honest gaps with charter amendments and investment asks.
11. **Integrate acquisition/M&A crypto playbook** — 90-day CBOM certification SLA (Meridian lesson).
12. **Extend runtime verification** — build-time gates necessary but insufficient (GlobalSync lesson).

---

## 22.14 Chapter Summary

- **Migration ends in capability, not deployment** — Wave exit is milestone, not termination; sustained quantum resilience requires permanent custodianship.
- **ARCS synthesis** — Awareness, Register, Capability, and Synchronize operate continuously at Level 5; Part VI Proof becomes ongoing assurance discipline.
- **PQ-ADAPT Levels 4–5** — Transitioning to Quantum-Resilient; Level 5 criteria include disallowance compliance, continuous CBOM, annual agility drill, and standards watch.
- **Continuous quantum resilience loop** — Sense → Interpret → Decide → Act → Prove → Learn feeds permanent organisational response.
- **Organisational learning loops** — incident, programme, and sector scales convert experience into policy, gate, and charter updates.
- **Standards watch calendar** — active monitoring with decision triggers; FN-DSA/HQC contingency planning with pre-approved activation criteria.
- **Year 3 retrospective** — Meridian (Elena), Northfield (James Whitfield), Apex (Priya Nair), GlobalSync (Marcus Chen) demonstrate convergent lessons under sector constraints.
- **Honest zone-level maturity** — Level 5 claims per scope; long-tail gaps documented with sunset dates and investment.

**Next:** Appendices A–E — CBOM and CDG templates, PQ-ADAPT self-assessment questionnaire, regulatory mapping matrix, migration programme charter template, and glossary with standards quick-reference tables. The appendices supply the artefact library this handbook references throughout; they are the practical close-out to the practitioner reference the book promised from Chapter 1.

---

*Chapter 22 — References*

- Basescu, M., Cimpanu, D., & others. (2024). Deployment considerations for post-quantum cryptography. *Proceedings of the USENIX Security Symposium*.
- Campbell, A. J. (2025). Enterprise migration to post-quantum cryptography: Timeline analysis. *Computers*, 14(3). https://doi.org/10.3390/computers14030058
- Cybersecurity and Infrastructure Security Agency. (2024). *Post-quantum cryptography migration guidance for critical infrastructure*. U.S. Department of Homeland Security.
- European Union Agency for Cybersecurity. (2024). *NIS2 implementation guidance: Cryptographic measures*. ENISA.
- National Institute of Standards and Technology. (2024). FIPS 203: Module-lattice-based key-encapsulation mechanism standard. U.S. Department of Commerce.
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Institute of Standards and Technology. (2024–2028). *Post-Quantum Cryptography Standardization Project: FN-DSA and HQC status updates*. NIST CSRC.
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- Regulation (EU) 2022/2554 on digital operational resilience for the financial sector (DORA). *Official Journal of the European Union*, L 333.
- World Economic Forum. (2024). *Quantum security: Preparing for the post-quantum era*. Insight Report.

---

*Proceed to Appendix A: CBOM and CDG Templates.*
