# Chapter 16
# Procurement, Contracts, and Third-Party Risk

---

In March 2027, Meridian Mutual Bank's procurement team presented the steering committee with a vendor readiness dashboard: **40 critical ICT suppliers** assessed against a standardised PQC evidence checklist, scored on CBOM attestation quality, roadmap credibility, and contractual compliance. The dashboard replaced the **94% PQC readiness** slide Elena Vasquez had debunked fourteen months earlier in Chapter 7 — the one that counted questionnaire optimism instead of cryptographic inventory.

This time the numbers were defensible. **31 suppliers** provided machine-readable CBOM attestations or structured cryptographic disclosures within contractual deadlines. **6 suppliers** delivered credible roadmaps with binding milestone dates and audit rights. **3 suppliers** triggered concentration risk escalation — including the hosted payment processor whose HSM attestation had blocked Meridian's Level 2 baseline declaration.

Thomas Bergström linked the assessment register to DORA Articles 28–30 third-party ICT risk obligations. Elena linked the same register to CBOM third-party rows and CDG trust edges. Legal linked it to renewal clauses, SLA audit rights, and flow-down language for subcontractors. The steering committee approved Wave 0 contract amendments for two HSM vendors and deferred one SaaS renewal pending evidence — not because procurement had become adversarial, but because **contracts are the enforcement mechanism** for cryptographic migration when engineering cannot see inside vendor systems.

Third-party cryptography is your cryptography. A hybrid TLS pilot succeeds in the laboratory while a payment processor remains RSA-only in production. A cloud KMS advertises PQC readiness while the FIPS boundary your DORA evidence requires excludes ML-KEM in your region. An OT firmware signer controls LMS state your internal ceremony team cannot touch. Procurement, contracts, and third-party risk management translate architecture standards into **supplier obligations** — the commercial layer that Part IV assumes and Part V operationalises.

This chapter teaches readers to build that layer: contractual clause libraries, vendor evidence checklists, DORA-aligned assessment processes, CBOM supplier requirements, and sector-specific procurement patterns illustrated through Meridian, GlobalSync, Apex, and Northfield.

---

## 16.1 Why Procurement Owns Cryptographic Outcomes

Post-quantum migration programmes frequently treat procurement as a late-stage activity — a renewal negotiation after architecture decides what to buy. That sequencing fails for three structural reasons.

**First, visibility gap.** Chapter 7 established that third-party obscurity typically represents 30–40% of enterprise CBOM rows at Level 2 baseline. Engineering discovery cannot resolve vendor-managed HSM firmware, SaaS application-layer signing, or partner-controlled trust stores without **contractual disclosure rights**. Procurement holds those rights; security architecture does not.

**Second, dependency leverage.** Chapter 8 showed that CDG blocking nodes often sit at vendor boundaries — payment HSM firmware, card scheme trust policy, partner mTLS hubs. Wave 0 funding gates in Chapter 9 require vendor SOWs referencing `blocking_node_id`. Procurement inserts that reference at contract signature, not after production stall.

**Third, regulatory flow-down.** DORA, NIS2, PCI DSS, CNSA flow-down, and customer contractual obligations require enterprises to **demonstrate** third-party cryptographic posture — not merely assert internal policy. Supervisory reviewers evaluate process and evidence, not per-vendor algorithm speed (Chapter 12). Procurement produces the evidence chain.

| Programme artefact | Owner | Procurement role |
|-------------------|-------|------------------|
| CBOM third-party rows | Crypto engineering / programme office | Contractual attestation obligation |
| CDG trust edges | Security architecture | SLA and roadmap verification |
| TRADE Ecosystem (E) score | Risk / programme office | Vendor evidence quality input |
| Wave funding gates | Programme director | SOW deliverables tied to graph |
| DORA ICT provider register | Compliance / third-party risk | Assessment aligned to Articles 28–30 |

> **Migration Moment**
>
> *"Security should just tell vendors what algorithms to use."*
>
> Security defines policy profiles (Chapter 10). Procurement enforces them in contracts vendors sign. Without contractual teeth, vendor roadmaps remain slide decks. Meridian's payment HSM vendor delivered ML-DSA firmware on programme timeline only after Wave 0 contract amendment tied payment milestones to CMVP certificate listing — not after a security architecture email.

---

## 16.2 DORA Articles 28–30: Third-Party ICT Risk

For financial entities and their ICT supply chains, DORA transforms third-party cryptographic assessment from best practice into **supervisory expectation**. Articles 28–30 establish the framework; RTS 2024/1532 and EBA guidelines operationalise it. PQC migration programmes must map procurement activities to these articles explicitly — auditors will not infer the mapping.

### 16.2.1 Article 28 — ICT third-party risk management

Financial entities shall manage ICT third-party risk as an integral part of ICT risk management. Core obligations relevant to PQC:

- **Strategy and policy** for ICT third-party risk, including critical or important functions supported by external providers
- **Register** of contractual arrangements with ICT third-party providers
- **Due diligence** before entering or renewing arrangements
- **Ongoing monitoring** of ICT third-party performance and risk
- **Exit strategies** and transition plans where concentration or substitutability is limited

**PQC programme mapping:** The ICT provider register must include **cryptographic posture fields** — not generic "security certified" checkboxes. Meridian mapped each critical provider row to CBOM `third_party_id`, CDG trust edge, and PQC assessment score. Thomas Bergström's supervisory pack demonstrated that Article 28 monitoring included quarterly cryptographic attestation chase — the same operational cadence as CBOM maintenance (Chapter 7 §7.43).

### 16.2.2 Article 29 — Preliminary assessment of ICT concentration risk

Article 29 requires assessment of whether reliance on ICT third-party providers creates **concentration risk** — including where multiple critical functions depend on a single provider or where substitutability is limited.

**PQC concentration scenarios:**

| Scenario | Concentration signal | Programme response |
|----------|---------------------|-------------------|
| Single HSM vendor for payment and corporate PKI | High | Dual-vendor strategy or contractual roadmap with penalties |
| Dominant cloud KMS in one region | Medium–high | Multi-region evidence; secondary provider evaluation |
| Card scheme trust policy hub | Structural | Scheme-level negotiation before per-merchant projects |
| SaaS platform with embedded JWT signing | Medium | Contractual CBOM; exit plan if roadmap fails |

Meridian's three escalated suppliers in the 40-provider assessment each triggered Article 29 review — steering committee documented substitutability analysis and interim compensating controls.

### 16.2.3 Article 30 — Key contractual provisions

Article 30 specifies minimum contractual content for arrangements supporting critical or important functions. Provisions relevant to PQC migration:

- **Full description** of ICT services and service levels
- **Locations** where data is processed and where ICT services are provided
- **Accessibility, availability, integrity, and security** of data and ICT services
- **Notice periods** and termination rights
- **Participation** in ICT security awareness and training where appropriate
- **Right to monitor** ICT third-party performance — including **audit and inspection rights**
- **Cooperation** with competent authorities and financial entity oversight
- **Exit strategies** — data portability, transition assistance, deletion certification

**PQC clause alignment:** Article 30 audit rights are the legal foundation for **roadmap verification** and **CBOM attestation sampling** — not penetration testing alone. Meridian legal standardised "cryptographic audit rights" as a sub-clause referencing machine-readable disclosure, CMVP certificate provision, and annual roadmap review meetings.

> **Regulatory Lens**
>
> DORA does not mandate ML-KEM in supplier contracts. It mandates that financial entities **manage ICT third-party risk** for critical functions — including cryptographic controls that reflect state-of-the-art practice (RTS Article 6, Recital 9). A critical payment processor with no PQC roadmap and no contractual obligation to provide one is a **dual deficiency**: policy supply chain gap and Article 30 auditability gap. Supervisors evaluate whether the institution **knows** its third-party cryptography and **can verify** it — not whether every vendor has deployed hybrids.

### 16.2.4 Integrating DORA with the PQC Governance Stack

Chapter 3 introduced the PQC Governance Stack. Procurement sits primarily in the **Operational** and **Policy** layers:

| Governance Stack layer | Procurement contribution |
|------------------------|-------------------------|
| Policy | Flow-down of algorithm and HLM requirements to suppliers |
| Architecture | Vendor capability constraints inform pattern selection (Ch 14) |
| Operational | CBOM attestation cadence; SLA monitoring |
| Assurance | Audit rights exercised; evidence in examination pack |
| Programme | Vendor assessment register; steering escalation |

Meridian's DORA ICT risk register and PQC vendor register are **one dataset with two views** — compliance exports Article 28 fields; programme office exports TRADE E scores and wave linkage. Duplicating questionnaires across teams produced the 94% readiness fiction Elena eliminated.

---

## 16.3 CBOM Supplier Requirements

Chapter 7 established contractual CBOM clauses as a resolution path for third-party obscurity. Chapter 16 operationalises those clauses into **supplier requirements** procurement can enforce.

### 16.3.1 Minimum supplier disclosure

| Requirement | Format | Frequency | Verification |
|-------------|--------|-----------|--------------|
| Algorithm inventory for in-scope services | CycloneDX CBOM JSON or agreed CSV schema | Quarterly + on material change | Automated diff against prior quarter |
| Key custody model | Structured attestation: HSM, KMS, software, customer BYOK | Annual + on architecture change | Cross-check CMVP certs (Ch 14) |
| FIPS 140-3 module identifiers | Certificate numbers per algorithm | On module update | CMVP listing lookup |
| HLM phase commitment | H0–H3 per service component | Semi-annual roadmap review | Milestone acceptance testing |
| Subcontractor flow-down | List of ICT subprocessors with crypto role | Annual | Register reconciliation |

**Meridian standard:** Critical providers must deliver CycloneDX within **30 days** of contract effective date and within **15 days** of any material cryptographic change. Material change definitions include: new algorithm deployment, HSM firmware update, subprocessor change affecting key custody, or region expansion affecting data processing location.

### 16.3.2 CBOM quality tiers

Not all attestations are equal. Meridian scored supplier CBOM quality:

| Tier | Criteria | TRADE E impact |
|------|----------|----------------|
| **A — Verified** | Machine-readable; fields complete; sampled verification passed | E = 4–5 |
| **B — Structured** | Machine-readable; minor gaps; no sampling yet | E = 3 |
| **C — Narrative** | PDF whitepaper or questionnaire only | E = 2 |
| **D — Absent** | No response within contractual deadline | E = 1; escalation |

Chapter 9 production gates require E ≥ 3 for Wave 1+ production PQC deployment. Suppliers at Tier C effectively **gate** dependent workloads regardless of internal architecture readiness.

### 16.3.3 Linking supplier CBOM to enterprise CBOM

Supplier attestations merge into enterprise CBOM — not stored in a separate procurement spreadsheet.

```
  Supplier CycloneDX  ──►  Normalisation  ──►  Enterprise CBOM
        │                      │                    │
        │                      │                    ├── TRADE scoring
        │                      │                    ├── CDG trust edges
        │                      │                    └── DORA provider register
        │
        └── Contractual SLA: completeness, timeliness, change notification
```

**Field mapping minimum:** `supplier_id`, `supplier_component_id`, `algorithm_family`, `parameter_set`, `asset_type`, `custody_model`, `fips_module_id`, `hlm_phase`, `last_attested_date`, `confidence=attested`.

GlobalSync, as a **provider**, published customer-facing CBOM summaries for platform cryptography — reducing customer unknown bucket. Chapter 16 addresses the **customer** side; GlobalSync's provider obligations appear in §16.10.

### 16.3.4 Worked example — merging supplier attestation

Consider Meridian's hosted card payment gateway supplier. The enterprise CBOM contained **214 rows** with `third_party_id=PAY-GW-01`, all at `confidence=unknown` after Phase 1. The supplier's first CycloneDX attestation (Tier B) listed **47 components** — not row-for-row identical to Meridian's inferred inventory, but mappable.

| Supplier component | Algorithm | Custody | Enterprise CBOM action |
|-------------------|-----------|---------|------------------------|
| `tls-terminator-prod` | ECDSA-P256 TLS 1.3 | Supplier KMS (FIPS module X) | Update 89 TLS rows; `confidence=attested` |
| `jwt-issuer-api` | RSA-2048 | Software HSM partition | Create 12 new application_signing rows |
| `field-encrypt-pan` | AES-256-GCM | Supplier-managed DEK | Update 34 field-encryption rows |
| `hsm-pin-verify` | RSA-2048 | Payment HSM vendor Y | Link to nested third_party_id; escalate |

**Normalisation rules** procurement and crypto engineering agreed:

1. Supplier `bom-ref` preserved in `supplier_component_id` — traceability for audit
2. Algorithm names mapped to FIPS identifiers (Chapter 7 §7.11)
3. Unmatched enterprise rows remain `confidence=unknown` until resolved or decommissioned
4. Nested third parties (HSM vendor Y) trigger **subprocessor flow-down** review under PQC-08

After merge, PAY-GW-01 unknown bucket dropped from 214 to **31 rows**; TRADE E moved from 2 to 3 — not production-gate ready, but honest. Normalisation consumed four engineering days — standardise CycloneDX early rather than accepting PDF attestations that cannot merge automatically.

### 16.3.5 Subprocessor chains and fourth-party risk

Critical suppliers rarely operate alone. Payment processors use HSM hosts. SaaS platforms use hyperscaler KMS. OT integrators resell vendor firmware signers. **Fourth-party obscurity** replicates third-party obscurity unless contracts require subprocessor disclosure.

Meridian's PQC-08 clause mandated annual subprocessor registers with **cryptographic role**, 15-day custody-change notification, and prime-supplier liability for subprocessor compliance. When PAY-GW-01 disclosed HSM vendor Y without ML-DSA roadmap, Meridian escalated to the prime under contract — not direct negotiation with Y, which fragments leverage and confuses DORA register entries.

> **Dependency Alert**
>
> **Procurement cannot enforce CBOM clauses retroactively without leverage.** Renewal cycles are enforcement moments. Meridian prioritised the 40 critical suppliers by CDG fan-in and contract renewal date — not alphabetically. A blocking HSM vendor with renewal in nine months received escalation eighteen months before expiry to allow negotiation runway.

---

## 16.4 Contract Clause Library

Table 16.1 provides **informative clause samples** for legal adaptation. Organisation-specific legal review is required before use in binding instruments. Clauses align to DORA Article 30, CBOM supplier requirements (§16.3), and architecture standards from Parts II and IV.

**Table 16.1 — PQC Contract Clause Library**

| ID | Clause category | Sample language (abridged) | DORA / programme basis |
|----|-----------------|---------------------------|------------------------|
| **PQC-01** | Cryptographic standards alignment | *Supplier shall implement cryptographic controls consistent with Customer's published Algorithm Policy [Exhibit A] and shall not deploy quantum-vulnerable public-key algorithms in new components after [date] without prior written approval.* | RTS Art. 6; policy flow-down |
| **PQC-02** | HLM phase commitment | *Supplier commits to Hybrid Lifecycle Model phase [H1/H2] for Service [X] by [binding date], with interim milestones in Roadmap Exhibit B. Failure to meet milestones constitutes material breach after cure period.* | Programme wave alignment |
| **PQC-03** | CBOM attestation | *Supplier shall deliver machine-readable Cryptographic Bill of Materials (CycloneDX or equivalent) within 30 days of contract effective date and within 15 days of any Material Cryptographic Change, including algorithm, key custody, module validation, or subprocessor changes.* | Ch 7 §7.7; Art. 28 monitoring |
| **PQC-04** | Roadmap verification | *Supplier shall publish annual PQC Roadmap with quarterly updates, identifying algorithms, implementation dates, and dependent subprocessors. Customer may request roadmap review meetings no fewer than twice annually.* | Art. 30 audit rights |
| **PQC-05** | FIPS / validation evidence | *For regulated workloads, Supplier shall provide CMVP certificate numbers (or equivalent) for all cryptographic modules processing Customer data, identifying approved algorithms within module boundary.* | Ch 14 Table 14.1 |
| **PQC-06** | Audit and inspection | *Customer retains right to audit Supplier's cryptographic controls relevant to the Service, including third-party penetration test summaries, module validation certificates, and CBOM accuracy sampling. Supplier shall cooperate within 30 days of written request.* | Art. 30 monitoring |
| **PQC-07** | SLA — crypto incident | *Supplier shall notify Customer within 24 hours of any cryptographic incident: algorithm deprecation, module validation lapse, key compromise, or failure to meet HLM milestone.* | ICT incident alignment |
| **PQC-08** | Subprocessor flow-down | *Supplier shall impose equivalent cryptographic obligations on ICT subprocessors material to the Service and shall provide subprocessor register updates within 15 days of change.* | Art. 28 supply chain |
| **PQC-09** | Agility / no hardcoding | *Custom development deliverables shall reference Customer crypto profile IDs; no algorithm string literals in application source; acceptance testing includes profile substitution harness per Exhibit C.* | Ch 10 §10.11.5 |
| **PQC-10** | Exit and transition | *Upon termination, Supplier shall provide transition assistance including key export (where Customer-held), 90-day parallel operation, and CBOM final export. Destruction certification for Supplier-held keys per Exhibit D.* | Art. 30 exit |
| **PQC-11** | Concentration remedy | *If Supplier fails to meet PQC Roadmap milestones for Critical Service [X], parties shall negotiate in good faith: accelerated delivery, compensating service credits, or Customer termination without penalty.* | Art. 29 concentration |
| **PQC-12** | Partner / B2B negotiation | *For mutual TLS and partner integrations, Supplier shall support Customer-approved hybrid negotiation profiles [Exhibit E] within [N] days of Customer request.* | Ch 11–12 protocol transition |

**Clause packaging:** Meridian attached **Exhibits** — Algorithm Policy excerpt, CycloneDX schema, crypto profile catalogue, test harness container image reference — so vendors received implementable artefacts, not abstract "PQC-ready" language. Two custom development vendors achieved agility compliance within one sprint once exhibits replaced questionnaire ambiguity (Chapter 10).

**Renewal vs new procurement:** New contracts receive full clause set. Renewals prioritise PQC-03, PQC-04, PQC-05, PQC-06 for critical providers; non-critical providers receive PQC-01 and PQC-03 minimum.

---

## 16.5 Vendor Evidence Checklist

Questionnaires produce optimism. Checklists produce **evidence tiers**. Table 16.2 is Meridian's standard assessment instrument for critical ICT providers — adapted for financial services and reusable across sectors with regulatory column substitution.

**Table 16.2 — Vendor PQC Evidence Checklist**

| # | Evidence item | Required for critical? | Acceptable formats | Fail signal |
|---|---------------|------------------------|-------------------|-------------|
| 1 | Signed contract clauses PQC-01–08 (or equivalent) | Yes | Executed agreement | Missing crypto flow-down |
| 2 | Machine-readable CBOM (current quarter) | Yes | CycloneDX JSON; signed attestation | PDF only; stale > 90 days |
| 3 | Algorithm inventory matches production | Yes | CBOM + customer-side scan correlation | >10% mismatch unexplained |
| 4 | PQC roadmap with binding dates | Yes | Dated roadmap; executive signatory | "Monitoring NIST" without dates |
| 5 | CMVP / FIPS 140-3 certificates | Yes (regulated workloads) | Certificate PDF; module number | "FIPS compliant" without cert |
| 6 | Algorithm-in-boundary letter | Yes (HSM/KMS) | Vendor implementation letter per algorithm | Marketing slide |
| 7 | HLM phase per service component | Yes | Roadmap + CBOM `hlm_phase` | Undifferentiated "hybrid support" |
| 8 | Subprocessor crypto register | Yes | List with custody role | Incomplete subprocessor disclosure |
| 9 | Penetration test / crypto review summary | Recommended | Executive summary; scope statement | Refusal without alternative |
| 10 | Incident history (crypto-related, 24 months) | Yes | Incident register extract | Undisclosed module lapse |
| 11 | Customer audit cooperation record | Yes | Prior audit completion evidence | Audit rights refused |
| 12 | Interoperability test results (hybrid) | If B2B crypto | Test report; profile IDs | Lab-only; no production path |
| 13 | Performance impact disclosure | If signing/HSM | Benchmark for ML-DSA/ML-KEM | No data; "negligible" claim |
| 14 | Exit / transition plan | Yes | Documented per Art. 30 | No key export path |
| 15 | Insurance / liability (crypto breach) | Recommended | Certificate of coverage | — |

**Scoring:** Each item scored **0** (absent), **1** (partial), **2** (complete). Critical providers require **≥ 24/30** aggregate and no zero on items 1–5. Below threshold triggers Article 29 concentration review and steering visibility.

**Sampling verification:** Meridian assurance sampled **3 of 31** Tier-A suppliers annually — independent cryptographic review comparing attestation to observable behaviour (TLS scan, API token algorithms, documented HSM partition). One sample in 2027 identified CBOM drift — supplier had deployed ECDSA upgrade not reflected in quarterly attestation; corrective process strengthened change-notification SLA.

### 16.5.1 Worked scoring example — two suppliers compared

**Supplier A — Enterprise HSM vendor (critical):**

| Item | Score | Notes |
|------|-------|-------|
| 1 Contract clauses | 2 | Full PQC set executed 2026 |
| 2 CBOM | 2 | CycloneDX quarterly |
| 3 Inventory match | 2 | Sampled 8/8 match |
| 4 Roadmap | 2 | ML-DSA-87 binding date in exhibit |
| 5 CMVP | 2 | Certificate attached |
| 6 Boundary letter | 2 | Per-algorithm letter |
| 7 HLM phase | 1 | H1 date firm; H2 indicative only |
| 8 Subprocessors | 2 | Complete |
| 9 Pen test summary | 2 | Provided |
| 10 Incident history | 2 | None crypto-related |
| 11 Audit cooperation | 2 | Prior audit 2026 |
| 12 Interop | N/A | — |
| 13 Performance | 2 | ML-DSA benchmark shared |
| 14 Exit plan | 2 | Documented |
| 15 Insurance | 1 | Partial coverage disclosure |

**Total: 26/28 applicable items** — passes threshold; HLM phase item 7 drives semi-annual roadmap focus.

**Supplier B — HR SaaS (critical function):** Scored **9/30** — PDF whitepaper only, no CMVP, no verifiable inventory. Cure period or replacement evaluation; TRADE E remains at 2 for dependent identity workloads.

The comparison illustrates **proportionality**: critical crypto processors need items 1–6 at score 2 before Wave 0 dependency is acceptable; lower-depth SaaS still fails when items 1–5 score zero.

### 16.5.2 Vendor pushback patterns and responses

Procurement teams should anticipate standard objections — prepared responses reduce negotiation cycle time.

| Vendor objection | Programme response |
|------------------|-------------------|
| "PQC is too immature to contract" | Cite RTS Recital 9; require roadmap not immediate deployment |
| "CBOM is proprietary / security risk" | Redacted CycloneDX; NDA exhibit; field subset minimum |
| "Audit rights too broad" | Tiered audit model (§16.6.3); crypto-scoped not full SOC |
| "Binding dates create liability" | Milestone structure with cure periods; fee linkage mutual |
| "Subprocessor flow-down impractical" | Prime remains liable; minimum crypto-role register |
| "No CMVP — we use SOC 2" | Distinguish compliance regimes; regulated workloads need module evidence |

Meridian legal prepared **one-page response memoranda** for each objection — procurement leads negotiation; legal supports; crypto engineering answers technical exhibits. Security architecture does not negotiate payment terms — boundary prevents adversarial dynamic while preserving technical accuracy.

---

## 16.6 SLA Audit Rights and Roadmap Verification

Contract clauses and checklists fail without **operational verification**. This section defines the rhythm that converts paper rights into programme evidence.

### 16.6.1 SLA structures for cryptographic obligations

| SLA element | Metric | Target | Remedy |
|-------------|--------|--------|--------|
| CBOM timeliness | Days from quarter end to delivery | ≤ 15 | Service credit; escalation |
| CBOM completeness | % required fields populated | ≥ 95% | Corrective action plan |
| Roadmap milestone | On-time HLM phase delivery | Per exhibit | PQC-11 concentration remedy |
| Change notification | Days before material crypto change | ≥ 30 | Breach notification |
| Audit cooperation | Days to schedule audit | ≤ 30 | Executive escalation |
| Incident notification | Hours from crypto incident | ≤ 24 | Incident register |

**Meridian hosted payment processor case:** Processor missed two consecutive CBOM deadlines (items scored 0 on timeliness). Contractual service credits accumulated; steering committee authorised parallel processor evaluation under Article 29 — substitutability assessment completed in 120 days. Processor delivered compliant attestation before switch decision; concentration risk downgraded with continued monitoring.

### 16.6.2 Roadmap verification meetings

Roadmaps without verification are marketing. Meridian's **semi-annual roadmap review** agenda (90 minutes, critical providers):

1. **Attestation diff** — CBOM quarter-over-quarter algorithm changes
2. **Milestone status** — HLM phase deliverables vs exhibit dates
3. **Module validation** — CMVP status; pending revalidation risks
4. **Subprocessor changes** — new regions, custody shifts
5. **Customer impact** — CDG dependents; wave plan linkage
6. **Minutes and actions** — DORA provider register update within 10 business days

Thomas Bergström attended reviews for **top five** providers by critical function — not to negotiate algorithms, but to ensure minutes entered supervisory evidence chain.

### 16.6.3 Exercising audit rights

Audit rights need not mean full on-site inspection for every provider. **Tiered audit model:**

| Tier | Scope | Frequency |
|------|-------|-----------|
| **Light** | CBOM accuracy sample; CMVP cert refresh | Annual |
| **Standard** | Above + roadmap milestone acceptance test | Annual for critical |
| **Deep** | On-site or independent third-party crypto review | Risk-triggered |

**Triggers for deep audit:** CBOM sampling mismatch > 10%; crypto incident; concentration risk escalation; Wave 0 blocking node dependency.

> **Architect's Decision**
>
> **Treat roadmap milestones as acceptance criteria, not aspirations.** Meridian's payment HSM contract tied 40% of annual maintenance fee release to CMVP listing ML-DSA-87 — measurable, binary, verifiable. Soft milestones ("commercial GA expected") produced schedule slip in early negotiations; binding milestones with fee linkage produced firmware delivery aligned to Wave 0.

---

## 16.7 Procurement Gates and Wave Funding (Chapter 9 Cross-Reference)

Chapter 9 §9.24 defined procurement gates tied to wave funding. Chapter 16 supplies the **vendor-side specifications** those gates require.

| Gate | Vendor deliverable | Contract reference |
|------|-------------------|-------------------|
| Wave 0 | SOW with `blocking_node_id`; HSM/KMS capability matrix (Table 14.1) | PQC-02, PQC-05 |
| Wave 1 | E ≥ 3 evidence; hybrid interoperability test report | PQC-12, Table 16.2 items 12–13 |
| Wave 2+ | Prior wave exit; updated CBOM `hlm_phase` | PQC-03 |
| Renewal hold | No funding release until checklist ≥ 24/30 | Programme charter |

Meridian procurement inserted CDG `blocking_node_id` into HSM renewal SOW — vendor deliverables traceable to graph. GlobalSync partner programme funding released only after partner acceptance pilot documented (Chapter 9).

**Procurement gate failure mode:** Releasing Wave 0 funds without contractual deliverables produces vendor queue priority without binding dates — the HSM firmware stall Elena encountered in Chapter 14. Gates enforce **pay for evidence**, not pay for roadmap slides.

---

## 16.8 HSM and KMS Vendor Assessment (Chapter 14 Cross-Reference)

Key management vendors require **enhanced evidence** beyond generic ICT provider checklist. Chapter 14 Table 14.1 capability matrix is the technical instrument; Chapter 16 supplies the **contractual wrapper**.

### 16.8.1 HSM vendor essential clauses

Beyond PQC-01–08, HSM/KMS contracts should specify:

- **Partition capacity** for PQC object sizes (ML-DSA-87 keys and signatures)
- **Ceremony support** — M-of-N procedures; media compatibility
- **Firmware delivery** — lead times; rollback; dual-signature H1 support
- **Regional availability** — which regions expose PQC inside FIPS boundary
- **BYOK/HYOK** — import formats for ML-DSA key material
- **Performance SLAs** — signing throughput; wrap latency under PQC load

Meridian's Wave 0 contract amendment referenced Table 14.1 scores — vendor required to achieve score **2** on ML-DSA generation, signing, and FIPS module rows before maintenance fee release.

### 16.8.2 Cloud KMS shared responsibility

Cloud KMS contracts blur custody lines. Procurement must attach **shared responsibility matrix** signed by security and platform engineering:

| Responsibility | Customer | Provider |
|----------------|----------|----------|
| Algorithm policy | ✓ | |
| CMK algorithm selection | ✓ | |
| FIPS endpoint usage | ✓ | ✓ (availability) |
| Module validation evidence | | ✓ (provision) |
| Key rotation | ✓ | |
| PQC roadmap per region | | ✓ |

Marcus Chen's GlobalSync team rejected tenant contracts that assumed provider-side rotation of customer-managed keys — procurement standardised tenant addendum clarifying customer obligation.

---

## 16.9 Case Study: Meridian — 40 Critical Supplier Assessment

Meridian's assessment programme ran **parallel to Wave 0 execution** — not as a Phase 5 afterthought.

### 16.9.1 Selection methodology

**40 critical suppliers** selected by:

1. Supports critical or important function under DORA
2. CDG fan-in ≥ 5 dependents **or** CBOM third-party row count ≥ 50
3. Contract renewal within 24 months **or** Wave 0 blocking dependency

Excluded: pure non-ICT suppliers, commodity SaaS without cryptographic processing, internal captive centres already in enterprise CBOM.

### 16.9.2 Programme timeline

| Phase | Duration | Activities |
|-------|----------|------------|
| **Prepare** | 6 weeks | Clause library finalised; checklist; exhibit pack; legal sign-off |
| **Notify** | 2 weeks | Contractual amendment or side letter for existing providers |
| **Collect** | 12 weeks | CBOM and evidence intake; weekly triage |
| **Score** | 4 weeks | TRADE E update; concentration flags |
| **Escalate** | Ongoing | Steering for 3 sub-threshold; renewal decisions |

**Resource model:** 1 FTE procurement lead; 0.5 FTE legal; 0.25 FTE crypto engineering for sampling; Thomas Bergström's team for DORA register integration.

### 16.9.3 Results summary

| Outcome | Count | % |
|---------|-------|---|
| Tier A (verified CBOM) | 18 | 45% |
| Tier B (structured) | 13 | 32.5% |
| Tier C (narrative only) | 6 | 15% |
| Tier D (non-responsive) | 3 | 7.5% |

**Post-programme actions:**

- **2 HSM/KMS vendors** — Wave 0 contract amendments with milestone fee linkage
- **1 hosted payment processor** — concentration review; dual-track evaluation
- **6 Tier C vendors** — 90-day cure period to deliver CycloneDX or face renewal non-renewal
- **TRADE E updates** — 22 workloads rescored; 4 Wave 1 items deferred on E < 3

### 16.9.4 Supervisory examination use

Thomas Bergström's DORA examination pack included:

- Provider register extract with PQC assessment scores
- Redacted contract clause samples (PQC-03, PQC-06)
- Minutes from three roadmap verification meetings
- Concentration risk assessment for payment processor
- CBOM third-party row reconciliation (register 1:1 match)

Supervisor feedback: *"Process credible; continue monitoring Tier C cure period."* — validation that **evidence chain** mattered more than universal PQC deployment.

### 16.9.5 The three escalated suppliers — anatomy

**Escalation 1 — Hosted payment processor (PAY-GW-01):** Highest CDG fan-in; nested HSM subprocessor without roadmap. Article 29 review documented **14-month** switching cost — parallel evaluation authorised. Cure period produced Tier B attestation at month 9; concentration downgraded to monitored.

**Escalation 2 — Workforce identity SaaS:** Failed CMVP and CBOM checks; supplier cited SOC 2. Steering approved non-renewal preparation at month 6; supplier delivered CycloneDX before deadline — credible exit preparation accelerated response.

**Escalation 3 — Document archive vendor:** Classical encryption at rest; roadmap dates slipped twice. PQC-11 remedy invoked; independent review confirmed HNDL misalignment for **12-year** legal holds. Contract amendment added H2 milestone with termination right.

### 16.9.6 Cost and staffing (*illustrative planning example*)

Meridian's six-month assessment cost approximately **€198,000** — procurement lead, legal support, three sampling audits, and one external review for the payment processor concentration case (*illustrative; ~0.7% of Wave 0 budget*). Elena framed spend as examination and outage risk reduction; board approved when linked to DORA review calendar.

> **Migration Moment**
>
> *"We can't force 40 vendors to migrate on our timeline."*
>
> Correct — and not the objective. The objective is **visibility, contractual alignment, and concentration management**. Meridian did not require ML-KEM in production from every supplier in 2027. It required honest CBOM, binding roadmaps, and audit rights — transforming Ecosystem readiness from guesswork into scored evidence.

---

## 16.10 GlobalSync: Multinational Procurement Overlay

GlobalSync Logistics operates across **EU, UK, and North America** — procurement must reconcile DORA-influenced customer contracts, UK NCSC guidance, and US customer flow-down without fragmenting platform standards.

### 16.10.1 Regional contract overlays

| Region | Primary regulatory driver | Procurement overlay |
|--------|--------------------------|---------------------|
| EU | DORA (customers); GDPR | Full PQC clause set; CBOM to customers |
| UK | UK GDPR; FCA operational resilience | NCSC migration planning alignment |
| US | Customer contract; state privacy | NIST IR 8547 flow-down; CNSA for defence tenants |

Marcus Chen's platform team maintained **one internal crypto profile catalogue** — regional contracts referenced profile IDs, not region-specific code paths. Legal maintained **regional exhibit variants** where mandatory language differed.

### 16.10.2 Tenant contractual sunsets

GlobalSync's multi-tenant SaaS model required **tenant notification clauses** for algorithm transitions:

- **180-day notice** before default profile elevation
- **Tenant opt-down unavailable** for below-minimum-security profiles
- **CBOM summary** published on trust portal quarterly

Tenant contracts referencing classical-only profiles received **amendment packs** during renewal — linking to GlobalSync HLM timeline (Chapter 5). Procurement tracked tenant renewal cohorts aligned to Wave 2 regional segmentation (Chapter 9).

### 16.10.3 Provider-side evidence programme

As **supplier** to enterprises, GlobalSync operationalised Table 16.2 internally — customer audit requests answered from pre-maintained evidence repository. Reduced duplicate questionnaires; improved customer E scores for ecosystem readiness.

**Partner procurement:** GlobalSync's B2B partner integrations required **mutual** checklist completion — both parties scored. Partner blocking node (`partner-mtls-policy-v3`) unblocked only when partner met item 12 (interop test) — funding gate from Chapter 9.

### 16.10.4 Multinational RFP harmonisation

GlobalSync maintains **three jurisdictional exhibit variants** — EU (DORA), UK (FCA/NCSC), US (NIST IR 8547 flow-down) — over identical technical requirements: one profile catalogue, one CycloneDX schema, one test harness image. Marcus Chen refused per-region algorithm forks in code; legal variance in contracts only.

### 16.10.5 Customer audit volume management

Pre-maintained evidence repository — Table 16.2 items pre-scored for GlobalSync's stack — reduced customer audit response time from **18 days to 4 days** median (*illustrative*).

---

## 16.11 Apex Defense Technologies: Flow-Down and NSS Separation

Apex operates under **CNSA 2.0 flow-down** from prime contracts and **NIST IR 8547** for commercial subsidiaries — procurement must not merge obligations across classification boundaries.

### 16.11.1 Prime contract flow-down

Defence primes flow cryptographic requirements to subcontractors via **DFARS-style** and programme-specific clauses:

| Flow-down element | Apex obligation as subcontractor | Apex obligation as prime |
|-------------------|----------------------------------|--------------------------|
| CNSA algorithm floor | Comply; evidence to prime | Flow to subs; verify |
| Validation evidence | CMVP per module | Collect from subs |
| Roadmap dates | Align to contract CDRL | Enforce via milestone payment |
| Classification separation | NSS enclave isolation | No commingling in sub awards |

Priya Nair's programme office rejected **single vendor assessment pool** for NSS and commercial — separate registers with cross-reference index for shared HSM manufacturer (Chapter 7 Apex pattern).

### 16.11.2 Subcontractor assessment

Apex extended Table 16.2 with **NSS columns:**

- SCIF custody attestation
- Air-gapped module distribution path
- Accreditation boundary diagram
- LMS state management for firmware (Chapter 6)

Subcontractors scoring below threshold cannot receive NSS work packages — commercial work may continue under separate contract vehicle.

### 16.11.3 Customer flow-down to Apex

Commercial customers increasingly attach PQC requirements to Apex product contracts. Procurement **maps customer clauses to internal profile IDs** — avoiding bespoke engineering per customer while satisfying flow-down. Unmappable clauses escalate to architecture board.

---

## 16.12 Northfield Energy Systems: OT Vendor Management

Northfield's cryptographic dependencies concentrate in **OT vendors** — firmware signers, WAN appliances, safety system integrators — where procurement cycles measure in years, not quarters.

### 16.12.1 OT vendor taxonomy

| Vendor class | Crypto role | Procurement lever |
|--------------|-------------|-------------------|
| Compressor OEM firmware signer | LMS/ML-DSA signing | Long-term framework agreement |
| WAN concentrator manufacturer | IKE/TLS hybrid | Fleet refresh contract |
| OT integrator | Site-specific cert stores | Project SOW per site |
| Safety PLC vendor | Fixed key storage | Wave 4; roadmap monitoring |

James Whitfield's team **does not conflate** enterprise VPN procurement with OT vendor procurement — separate CDG nodes, separate assessment tracks (Chapter 14 §14.18).

### 16.12.2 OT-specific clause adaptations

OT contracts adapt Table 16.1 for **firmware cadence reality:**

- **PQC-02** milestones tied to **maintenance window** availability, not arbitrary calendar dates
- **PQC-03** CBOM at **device class** granularity when per-site impractical
- **PQC-06** audit via vendor security whitepaper + annual workshop when on-site infeasible
- **PQC-10** exit acknowledges **air-gapped** constraints — physical media transition

### 16.12.3 NERC CIP evidence integration

Northfield linked OT vendor evidence to **NERC CIP** compliance documentation — vendor crypto attestation supporting BES Cyber System categorisation. Procurement coordinates with compliance; James Whitfield's OT security team validates technical content.

**WAN case recap:** Concentrator hybrid-ready; 241 of 312 CPE devices rejected hybrid IKE (Chapter 12). OT vendor assessment identified **CPE firmware** as blocking — procurement accelerated CPE vendor roadmap clause in fleet refresh RFP.

### 16.12.4 OT vendor workshop format

Northfield adapted Meridian's roadmap verification for **field reality** —  half-day remote workshops per vendor, not 90-minute slide reviews:

1. **Device class inventory** — models, firmware trains, crypto features per train
2. **Certificate store constraints** — bytes available for PQC chain growth (Chapter 13 OT parallels)
3. **Maintenance window binding** — when firmware can deploy to Gulf Coast corridor
4. **Signing ceremony ownership** — vendor air-gapped signer vs customer-held keys
5. **Action register** — procurement milestone dates tied to next fleet refresh RFP

James Whitfield's team brought **OT security engineering** to workshops — procurement brought contract authority. Separating the roles prevented technical concessions without commercial backing, and commercial deadlines without engineering feasibility.

> **Dependency Alert**
>
> **OT procurement cycles exceed programme patience.** A vendor whose next firmware train ships in eighteen months cannot meet a six-month contractual milestone — negotiate **device-class roadmaps** and **fleet refresh alignment**, not enterprise IT calendar fiction. Northfield's Wave 4 OT long-tail (Chapter 9) exists because contracts follow maintenance physics, not steering committee quarters.

---

## 16.13 Vendor Readiness Assessment Flow

**Figure 16.1 — Vendor Readiness Assessment Flow**

```
                    ┌─────────────────────────────────┐
                    │  Critical provider identification │
                    │  (DORA register, CDG fan-in)    │
                    └───────────────┬─────────────────┘
                                    │
                                    v
                    ┌─────────────────────────────────┐
                    │  Contract baseline               │
                    │  PQC clauses + exhibits          │
                    └───────────────┬─────────────────┘
                                    │
                                    v
                    ┌─────────────────────────────────┐
                    │  Evidence collection             │
                    │  Table 16.2 checklist            │
                    └───────────────┬─────────────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    │                               │
                    v                               v
           ┌────────────────┐              ┌────────────────┐
           │ Score ≥ threshold│              │ Score < threshold│
           └───────┬────────┘              └───────┬────────┘
                   │                               │
                   v                               v
           ┌────────────────┐              ┌────────────────┐
           │ CBOM merge      │              │ Cure period /   │
           │ TRADE E update  │              │ concentration   │
           └───────┬────────┘              │ escalation      │
                   │                       └───────┬────────┘
                   v                               │
           ┌────────────────┐                      │
           │ Roadmap verify  │◄─────────────────────┘
           │ (semi-annual)   │      (re-assess)
           └───────┬────────┘
                   │
                   v
           ┌────────────────┐
           │ Sampling audit  │
           │ (annual)        │
           └───────┬────────┘
                   │
                   v
           ┌────────────────┐
           │ DORA register + │
           │ steering report │
           └────────────────┘
```

**Production brief — Figure 16.1:** Vertical flowchart with decision diamond at score threshold; left path green (compliant), right path amber (escalation loop back to evidence collection). Annotate side inputs: Legal (contract), Crypto engineering (sampling), Compliance (DORA register). Include legend for Tier A–D colouring.

---

## 16.14 Integrating Vendor Assessment with Programme Office Rhythm

Chapter 15 (programme governance) defines steering cadence. Vendor assessment feeds **monthly steering inputs:**

| Metric | Source | Action trigger |
|--------|--------|----------------|
| % critical providers Tier A–B | Vendor register | < 80% → procurement escalation |
| CBOM attestation overdue count | SLA monitoring | > 3 → legal review |
| Concentration risk open items | Article 29 register | Any → board quarterly visibility |
| Cure period expirations | Contract tracker | 30-day warning → renewal decision |
| E < 3 workload count | TRADE rescoring | Wave deferral per Ch 9 |

Elena Vasquez's programme office owned the **vendor register dashboard**; procurement owned **contract negotiation**; Thomas Bergström owned **regulatory mapping** — RACI documented in programme charter.

### 16.14.1 Procurement–security collaboration model

Successful programmes avoid two failure modes: **procurement without security context** (clauses that vendors cannot implement) and **security without procurement authority** (architecture emails without contract leverage).

| Activity | Responsible | Accountable | Consulted | Informed |
|----------|-------------|-------------|-----------|----------|
| Clause library maintenance | Legal | General Counsel | CISO, procurement | Programme office |
| Checklist scoring | Procurement | CPO | Crypto engineering | Steering |
| Roadmap verification meeting | Procurement lead | Programme director | Security architecture | Compliance |
| CBOM merge | Crypto engineering | CBOM owner | Procurement | TRADE owners |
| Concentration escalation | Risk / compliance | CISO | Legal, procurement | Board risk committee |
| Sampling audit | Assurance | Internal audit | Crypto engineering | Vendor management |

Meridian's **weekly 30-minute triage** during evidence collection phase — procurement, legal liaison, crypto engineering — cleared blockers without steering escalation. Items older than 14 days escalated automatically.

### 16.14.2 Onboarding vs renewal differentiation

| Stage | Leverage | Minimum clause set | Negotiation posture |
|-------|----------|-------------------|---------------------|
| **New procurement (RFP)** | High — competitive | Full PQC-01–12 | Disqualify inadequate evidence |
| **Renewal (incumbent)** | Medium — switching cost | PQC-03–06 priority | Amendment or side letter |
| **Mid-contract amendment** | Low–medium | Targeted (blocking node) | Fee linkage; milestone payment |
| **Post-incident** | High — remedial | Full set + enhanced audit | Remediation or exit |

Enterprises overweight renewal negotiation and underweight **new procurement gates** — GlobalSync shifted 40% of affected spend to competitive RFP where incumbents scored below threshold on first assessment, not only at renewal.

---

## 16.15 Concentration Risk Escalation Playbook

When Table 16.2 scoring or Article 29 assessment triggers escalation:

1. **Document substitutability** — alternative providers, switching cost, timeline
2. **Quantify CDG impact** — fan-in, blocking status, wave delay in weeks
3. **Interim compensating controls** — enhanced monitoring, data minimisation, contractual penalties
4. **Steering decision** — accept risk, accelerate renewal, or initiate parallel procurement
5. **Board visibility** — if critical function or > €X contract value (*illustrative threshold*)

Meridian payment processor escalation followed this playbook — parallel evaluation authorised; processor improved before switch required; concentration risk register entry maintained with quarterly review.

---

## 16.16 SaaS, Shadow IT, and Marketplace Procurement

Chapter 7 §7.40 addressed shadow IT cryptographic surprise. Procurement **prevention** controls:

- **Marketplace pre-approval** — CBOM clause required before enterprise purchase
- **SSO gateway** — no production data without security review
- **Shadow discovery feedback** — CT-found SaaS enters procurement queue for contractual catch-up

**SaaS-specific checklist additions:**

- Tenant isolation model for keys
- Customer-managed keys (CMK/BYOK) availability
- Hypervisor vs application-layer encryption clarity

### 16.16.1 Customer contract flow-down (non-DORA enterprises)

Even non-financial enterprises receive **customer PQC flow-down** in master service agreements. Apex commercial division mapped customer clauses to internal checklist — identical evidence machinery, different regulatory citation. GlobalSync tenant contracts; Northfield utility customer cyber requirements; Meridian correspondent banking obligations — all converge on Table 16.2 structure.

**Flow-down register:** Legal maintained **customer obligation → internal control** mapping — when customer contract requires ML-KEM by 2029, row appears in programme register with same priority as internal policy. Procurement negotiates **supplier** capacity to meet customer flow-down, not only internal architecture preference.

### 16.16.2 PCI DSS and payment brand requirements

Payment processors face **PCI DSS v4.0** cryptographic architecture documentation expectations and card brand security programmes. Meridian's payment processor escalation aligned PCI assessor questions with Table 16.2 — single evidence pack served DORA examination and PCI audit. Duplication avoided when procurement owns **one vendor evidence repository** with multiple compliance exports.

---

## 16.17 RFP and Renewal Playbooks

### 16.17.1 New procurement RFP crypto section

Minimum RFP language:

1. Reference Customer Algorithm Policy and HLM requirements
2. Require Table 16.2 response at proposal stage (not post-award)
3. Weight technical evaluation **15–25%** on PQC evidence quality (*illustrative*)
4. Disqualify narrative-only roadmaps without binding dates for critical workloads
5. Require named executive accountable for crypto roadmap

### 16.17.2 Renewal playbook

| Months before renewal | Action |
|----------------------|--------|
| 18 | Score current evidence; identify gaps |
| 12 | Issue amendment negotiation or side letter |
| 6 | Finalise PQC clauses; milestone dates |
| 3 | CBOM baseline for renewal effective date |
| 0 | Renewal signature with exhibits attached |

### 16.17.3 Facilitation guide — vendor evidence workshop

For providers resisting narrative-only responses, Meridian ran optional **half-day workshops** before escalation. Pre-work: Table 16.2 self-assessment and draft CycloneDX. Agenda: programme context, exhibit walkthrough, live CBOM field mapping, milestone negotiation, audit-tier agreement, written action register. Procurement leads; crypto engineering supports technically; legal attends only for contract interpretation. Minutes become roadmap verification baseline.

### 16.17.4 Insurance and contractual liability

Cyber insurance renewals increasingly query PQC readiness. Meridian linked vendor insurance certificates (Table 16.2 item 15) to enterprise policy — coverage gaps informed concentration severity. PQC-07 incident notification aligned with insurer timelines; programme office supplied CDG fan-in estimates for liability cap discussions without overriding counsel.

---

## 16.18 Auditor and Supervisory Questions

| Question | Evidence source |
|----------|-----------------|
| How do you assess third-party crypto? | Table 16.2 scores; Figure 16.1 process |
| Are contracts adequate? | PQC clause library samples; legal review record |
| How do you verify roadmaps? | Roadmap meeting minutes; milestone acceptance |
| What about concentration? | Article 29 assessments |
| CBOM third-party coverage? | Ch 7 reconciliation report |
| HSM vendor validation? | Ch 14 Table 14.1; CMVP certs |

---

## 16.19 Cross-Reference Map

| Topic | See |
|-------|-----|
| CBOM third-party obscurity, contractual clauses | Chapter 7 §7.7, §7.17 |
| CDG trust edges, partner blocking | Chapter 8 §8.3, §8.11 |
| Procurement gates, wave funding | Chapter 9 §9.24 |
| Agility NFRs in custom development SOWs | Chapter 10 §10.11.5 |
| Hybrid partner requirements | Chapters 11–12 |
| HSM vendor capability matrix | Chapter 14 Table 14.1 |
| Programme office rhythm, RACI | Chapter 15 |
| DORA encryption policy, Article 28–30 | Chapter 3 §3.2 |
| Software supply chain verification | Chapter 17 |
| Sector procurement (banking, defence, energy) | Part VI |

---

## 16.20 Apply in Your Organisation

1. **Map critical ICT providers** to DORA Article 28 register (or equivalent) with CBOM `third_party_id` linkage.
2. **Adopt Table 16.1 clause library** — legal review; attach exhibits (policy, schema, profiles).
3. **Deploy Table 16.2 checklist** for critical providers; set scoring threshold and cure periods.
4. **Require machine-readable CBOM** — reject PDF-only attestations for critical workloads.
5. **Tie Wave 0 funding** to vendor SOW with CDG `blocking_node_id` and Table 14.1 for HSM/KMS.
6. **Schedule semi-annual roadmap verification** — minutes to provider register within 10 days.
7. **Exercise audit rights annually** — light tier minimum; deep tier on triggers.
8. **Integrate SLA metrics** — CBOM timeliness, milestone delivery, incident notification.
9. **Run concentration risk playbook** for sub-threshold scores — document substitutability.
10. **Align renewal calendar** to 18-month negotiation runway for blocking vendors.
11. **Separate NSS and commercial assessment pools** if classification boundaries apply (Apex pattern).
12. **Adapt OT vendor clauses** for firmware cadence and device-class CBOM (Northfield pattern).
13. **Publish provider CBOM summaries** if you are a platform supplier (GlobalSync pattern).
14. **Feed vendor scores to TRADE E** — rescoring triggers wave deferral when E < 3.
15. **Report vendor metrics monthly** to steering — % Tier A–B, overdue attestations, open escalations.

---

## 16.21 Chapter Summary

- **Third-party cryptography is enterprise cryptography** — procurement encodes visibility and enforcement when engineering cannot scan vendor interiors.
- **DORA Articles 28–30** require provider registers, concentration assessment, and contractual audit rights — map directly to PQC vendor assessment, not parallel compliance theatre.
- **CBOM supplier requirements** demand machine-readable attestations with quality tiers — merge into enterprise CBOM for TRADE, CDG, and supervisory evidence.
- **Table 16.1 clause library** provides informative samples for standards alignment, CBOM delivery, roadmap verification, audit rights, and exit — exhibits make clauses implementable.
- **Table 16.2 evidence checklist** converts questionnaires into scored evidence — sampling verification catches attestation drift.
- **SLA and roadmap verification** operationalise contractual rights — milestone fee linkage outperforms soft commitments.
- **Chapter 9 procurement gates** release funding only when vendor deliverables match CDG and capability evidence.
- **Chapter 14 HSM assessment** requires enhanced clauses — CMVP per algorithm, partition capacity, regional FIPS boundary.
- **Meridian 40-supplier case** demonstrates DORA-aligned assessment at scale — Tier A–D outcomes, concentration escalation, examination-ready evidence.
- **GlobalSync, Apex, and Northfield** illustrate multinational overlays, NSS flow-down, and OT vendor realism respectively.

**Closing note:** The 94% PQC readiness slide was procurement measuring hope. The 40-supplier dashboard measured evidence. Post-quantum migration programmes that survive supervisory review and production reality treat **contracts as cryptographic control instruments** — not administrative paperwork after architecture finishes.

**Next:** Chapter 17 extends procurement enforcement into the software supply chain — SBOM/CBOM pipelines, CI/CD verification gates, and dependency management where most enterprise cryptography actually lives.

---

*Chapter 16 — References*

- Cybersecurity and Infrastructure Security Agency. (2024). Post-quantum cryptography initiative — supply chain considerations. https://www.cisa.gov/quantum
- CycloneDX. (2024). *Authoritative guide to CBOM and cryptographic bill of materials*. OWASP Foundation.
- European Banking Authority. (2024). *Guidelines on ICT and security risk management* (EBA/GL/2019/04, as applicable under DORA).
- European Parliament and Council. (2022). Regulation (EU) 2022/2554 on digital operational resilience for the financial sector (DORA). *Official Journal of the European Union*.
- European Commission. (2024). Commission Delegated Regulation (EU) 2024/1532 supplementing DORA with regard to ICT risk management tools, methods, processes, and policies.
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Institute of Standards and Technology. (2019). FIPS 140-3: Security Requirements for Cryptographic Modules. https://doi.org/10.6028/NIST.FIPS.140-3
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- World Economic Forum. (2024). *Quantum security: Preparing for the post-quantum era* — third-party risk dimensions.
- Payment Card Industry Security Standards Council. (2024). PCI DSS v4.0 — third-party service provider cryptographic requirements (informative mapping).
