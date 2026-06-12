# Chapter 21
# Cloud, SaaS, and Multinational Compliance

---

In January 2028, GlobalSync Logistics' Dublin data protection officer received a supervisory information request from a German healthcare tenant: *demonstrate state-of-the-art encryption for cross-border shipment metadata processing, including post-quantum readiness, with evidence that tenant cryptographic isolation was maintained during the platform's Wave 1 hybrid transition.*

The request arrived forty-eight hours after Sofia Lindström's programme office declared Wave 1 exit criteria met across all three regions. Marcus Chen's security architecture team had the technical answer — hybrid TLS profiles deployed, tenant-scoped key hierarchies operational, CI/CD gates enforcing agility standards on every container promotion. What the DPO lacked was a **single cross-border evidence pack** linking platform CBOM rows, cloud provider shared-responsibility attestations, tenant contract profile mappings, and GDPR Article 32 documentation into a coherent supervisory narrative.

Sofia convened a forty-eight-hour evidence sprint — not because GlobalSync had failed migration, but because **cloud centralisation had concentrated regulatory scrutiny** along with cryptographic agility. One platform change affected four hundred tenants across twelve jurisdictions. One KMS module gap blocked seventy-three BYOK customers. One partner gateway profile negotiation determined whether two hundred microservices could exit H1 hybrid phase. The programme had optimised for engineering velocity; the supervisory request exposed that **velocity without jurisdictional evidence architecture** creates compliance latency at the worst moment.

GlobalSync delivered the pack on time. The tenant renewed. The lesson generalises: for multinational SaaS operators, post-quantum migration is simultaneously an **agility opportunity** — centralised policy, automated gates, tenant profile inheritance — and a **regulatory concentration risk** — single points of cryptographic failure, cross-border evidence gaps, and contractual custody ambiguities that supervisors and enterprise customers now interrogate with increasing precision.

This chapter develops the **cloud and SaaS sector overlay** for post-quantum migration: multi-tenant architecture patterns, shared responsibility models, BYOK and HYOK custody, vendor-neutral cloud capability assessment, three-region programme design, and GDPR-aligned cross-border evidence. It completes GlobalSync's teaching arc from programme charter (Chapter 15) through supply chain enforcement (Chapter 17) and procurement leverage (Chapter 16) into sector proof — demonstrating how a platform operator sustains PQ-ADAPT Level 4 operations across forty countries without fragmenting into incompatible regional cryptography programmes.

---

## 21.1 Sector Overlay: SaaS and Platform Economics

Part VI applies the **Sector Overlay Matrix (SOM)** to modify universal TRADE weights, HLM timelines, and evidence requirements without duplicating programme machinery from Parts I–V. For SaaS and cloud-native platform operators, the SOM adjustment is precise:

| SOM parameter | SaaS / platform modification | Rationale |
|---------------|------------------------------|-----------|
| TRADE weight — Ecosystem (wE) | **+0.25** (default 0.75 → 1.00) | Partner APIs, tenant integrations, and cloud provider roadmaps gate execution |
| TRADE weight — Regulatory (wR) | +0.10 for EU-regulated tenant segments | GDPR, NIS2, DORA flow-down via customer contracts |
| HLM timeline | Partner ecosystem Wave 0 mandatory | CDG blocking at gateway tier (Chapter 8) |
| Evidence overlay | Per-tenant assurance tiers; cross-border packs | Contractual profile mapping; processor documentation |
| Procurement emphasis | Cloud KMS/HSM; tenant addenda | Shared responsibility clarity (Chapter 16) |

**MPI impact:** Chapter 9 documented that ±0.25 on wE moved approximately eleven percent of systems across wave boundaries in sensitivity analysis. SaaS operators must **document wE +0.25 in programme charter before scoring** — retroactive weight changes invalidate year-over-year MPI comparison and undermine board confidence in wave sequencing.

The sector overlay does not declare SaaS migration "easier" because cloud providers ship features faster. It declares SaaS migration **ecosystem-gated** — platform engineering can deploy hybrids in weeks while partner negotiation, tenant contractual sunsets, and cloud KMS validation cycles determine whether those hybrids constitute programme progress or pilot theatre.

> **Migration Moment**
>
> *"We're cloud-native — our provider handles encryption. PQC is their problem."*
>
> Cloud providers manage infrastructure cryptography under a **shared responsibility model**. Tenant data encryption, application-layer signing, mutual TLS to partners, JWT validation, and customer-managed keys remain **customer responsibilities** — or SaaS provider responsibilities in the application layer, depending on contract tier. Provider roadmap announcements do not migrate your microservices, your tenant profiles, or your cross-border evidence packs. GlobalSync's 2026 stall occurred precisely where provider readiness slides met **application custody reality**.

### 21.1.1 The chapter's central argument

**Cloud centralisation is an agility opportunity and a regulatory concentration risk.**

| Dimension | Agility opportunity | Concentration risk |
|-----------|--------------------|--------------------|
| Policy deployment | Single crypto-agility standard propagates via CI/CD to hundreds of services | Single policy error propagates at equal speed |
| Key management | Centralised KMS patterns; profile inheritance across tenants | One module validation gap blocks entire tenant tiers |
| Inventory | Platform CBOM covers fan-in nodes | Provider obscurity masks 30–40% of estate (Chapter 7) |
| Partner negotiation | Gateway-tier centralisation resolves CDG blocking | One incompatible partner profile stalls wave exit |
| Evidence | Automated pipeline artefacts; tenant assurance packs | Supervisory requests target platform operator as single processor |
| Regulatory | Harmonised HLM timeline with regional overlays | Cross-border transfer documentation must cite actual custody |

Enterprises that optimise only for the left column discover concentration risk during examination, tenant audit, or Wave exit review. Enterprises that optimise only for the right column forfeit the decade-long migration speed advantage cloud architecture provides. **Sector playbook discipline** holds both columns in programme balance.

---

## 21.2 ARCS Proof and PQ-ADAPT Positioning

Chapter 21 sits in **Part VI — Sector Playbooks and Proof**, completing the **Proof** phase of ARCS for cloud and multinational operators. Parts I–V delivered universal migration architecture; Part VI demonstrates survivability under sector constraints.

| Framework | Chapter 21 contribution |
|-----------|-------------------------|
| **ARCS — Proof** | Tenant-isolated PQC architecture; cross-border evidence; Year 2–3 GlobalSync outcomes |
| **PQ-ADAPT Level 4 → 5** | Sustained hybrid operations with tenant contractual sunsets; disallowance readiness per tier |
| **SOM — SaaS overlay** | wE +0.25; partner Wave 0; assurance tier evidence |
| **PQC Governance Stack** | Three-region programme office; tenant governance in Programme layer |
| **TRADE engine** | Ecosystem-weighted prioritisation for platform estates |

**PQ-ADAPT Level 4** for SaaS operators requires production hybrids under programme governance — not merely platform engineering enthusiasm. GlobalSync declared Level 4 Q2 2027 (Chapter 15). Level 5 approaches when quantum-vulnerable public-key cryptography is retired from in-scope production per wave plan and tenant contractual obligations — typically aligned to 2030–2035 disallowance horizons with **per-tenant sunset schedules** for BYOK and regulated tiers.

---

## 21.3 Multi-Tenant PQC Architecture

Multi-tenant SaaS cryptography differs from single-enterprise migration in one structural respect: **cryptographic policy must compose** — platform baseline plus tenant overlay plus jurisdiction constraint — without per-tenant code forks. Chapter 10's profile inheritance model (GlobalSync Crypto-Agility Standard v1.0) provides the implementation pattern; this section defines the architecture.

### 21.3.1 Architectural layers

| Layer | Responsibility | PQC migration concern |
|-------|----------------|----------------------|
| **Platform policy** | Enterprise algorithm matrix; HLM phase; approved profile catalogue | Global baseline; steering-approved |
| **Tenant overlay** | Contractual profile tier (T0–T3); elevated algorithms for regulated segments | Profile inheritance, not fork |
| **Jurisdiction overlay** | EU, US federal, APAC regulatory rule sets in policy service | Gate scoping (Chapter 17) |
| **Isolation boundary** | Namespace, KMS key hierarchy, network segmentation | Tenant crypto blast radius |
| **Custody tier** | Provider-managed, CMK, BYOK, HYOK | Validation and evidence per tier |
| **Egress / ingress** | Partner mTLS, tenant API gateways, webhook signing | Wave 0 CDG blocking nodes |

### 21.3.2 Tenant assurance tiers

GlobalSync standardised four tenant assurance tiers — referenced in procurement (Chapter 16), validation (Chapter 18), and tenant contracts:

| Tier | Profile | Custody model | PQC evidence expectation |
|------|---------|---------------|--------------------------|
| **T0 — Standard** | Platform default profiles | Provider-managed KMS | Platform assurance pack |
| **T1 — Enhanced** | Elevated signing/TLS profiles | CMK per tenant | Platform + tenant config attestation |
| **T2 — Regulated** | Financial/healthcare overlay | CMK + enhanced audit | Per-tenant validation matrix excerpt |
| **T3 — BYOK/HYOK** | Customer-defined within allow-list | Customer HSM/KMS anchor | Customer module cert + interop pack |

Tier assignment is **contractual**, not engineering discretion. Sofia Lindström's programme office owned tier-to-profile mapping — preventing sales-led tier inflation that created evidence gaps.

### 21.3.3 Figure 21.1 — Multi-Tenant PQC Architecture

**Figure 21.1 — Multi-Tenant PQC Architecture (GlobalSync Reference)**

```
                         ┌─────────────────────────────────────────────┐
                         │           PQC Governance Stack               │
                         │  Charter (Ch 15) · Steering · Crypto board   │
                         └──────────────────────┬──────────────────────┘
                                                │
                         ┌──────────────────────▼──────────────────────┐
                         │        Global policy service (HLM, profiles)  │
                         │   jurisdiction rules: EU · US · APAC         │
                         └──────────────────────┬──────────────────────┘
                                                │
          ┌─────────────────────────────────────┼─────────────────────────────────────┐
          │                                     │                                     │
   ┌──────▼──────┐                      ┌─────────▼─────────┐                  ┌───────▼───────┐
   │  Ingress /   │                      │  Platform KMS      │                  │  Egress /      │
   │  partner     │                      │  hierarchy         │                  │  tenant API    │
   │  gateway     │                      │                    │                  │  gateway       │
   │  (Wave 0)    │                      │  ┌─────────────┐ │                  │                │
   │  hybrid mTLS │                      │  │ Platform KEK │ │                  │  profile-bound │
   └──────┬──────┘                      │  └──────┬──────┘ │                  │  signing       │
          │                              │         │         │                  └───────┬───────┘
          │                              │    ┌────┴────┐    │                          │
          │                              │    │         │    │                          │
          │                         ┌────▼──┐ ┌▼────┐ ┌▼────┐                     │
          │                         │T0 KMS │ │T1   │ │T3   │                     │
          │                         │shared │ │CMK  │ │BYOK │                     │
          │                         └───┬───┘ └──┬──┘ └──┬──┘                     │
          │                             │        │       │                         │
          └─────────────────────────────┼────────┼───────┼─────────────────────────┘
                                        │        │       │
                         ┌──────────────▼────────▼───────▼──────────────────────────┐
                         │              Tenant isolation boundary                    │
                         │  namespace · network policy · audit stream segregation     │
                         ├──────────────┬──────────────┬──────────────┬──────────────┤
                         │  Tenant A    │  Tenant B    │  Tenant C    │  Tenant D    │
                         │  T0 / EU     │  T2 / EU     │  T1 / US     │  T3 BYOK/DE  │
                         │  gs-tenant-  │  gs-health-  │  gs-fed-     │  customer    │
                         │  tls-v4      │  tls-v5      │  logistics-v3│  HSM anchor  │
                         └──────────────┴──────────────┴──────────────┴──────────────┘
                                        │
                         ┌──────────────▼──────────────────────────────────────────────┐
                         │  CI/CD cryptographic gates (Ch 17)                          │
                         │  CycloneDX CBOM · OPA policy · agility harness · IaC lint    │
                         └──────────────┬──────────────────────────────────────────────┘
                                        │
                         ┌──────────────▼──────────────────────────────────────────────┐
                         │  Evidence plane: platform CBOM · tenant packs · GDPR Art 28  │
                         │  cross-border matrix · customer-facing CBOM summaries        │
                         └─────────────────────────────────────────────────────────────┘
```

**Production brief — Figure 21.1:** Full-width architecture diagram with colour-coded custody tiers (T0 grey, T1 blue, T2 amber, T3 red for customer anchor). Annotate data flows: ingress partner negotiation telemetry feeding CBOM `hybrid_negotiation_rate`; KMS wrap paths from platform KEK to tenant DEKs; evidence plane outputs linked to DPO pack template (§21.8). Include callout box for Wave 0 partner gateway as CDG blocking node.

### 21.3.4 Isolation principles

**Profile inheritance, not per-tenant forks.** Engineering maintains one service codebase; tenant tier selects profile ID from approved catalogue. Healthcare tenants on T2 inherit `gs-health-tls-v5` — elevated cipher policy and audit signing — without a separate deployment branch.

**Cryptographic blast radius containment.** Tenant isolation boundary enforces: separate KMS key hierarchies per tier; network policies preventing cross-tenant key material access; audit log streams tagged `tenant_id` × `profile_id` × `hlm_phase` for evidence retrieval.

**Jurisdiction-scoped policy evaluation.** Chapter 17's multinational gate overlay returns rule sets based on deployment region and tenant jurisdiction — EU tenants evaluated against GDPR and NIS2 flow-down; US federal logistics tenants against FedRAMP-oriented controls. One global rule set either over-constrains Americas deployments or under-protects EU healthcare workloads.

> **Architect's Decision**
>
> **Centralise partner negotiation at the gateway; distribute tenant profile selection at the contract layer.** GlobalSync's Wave 0 succeeded when the programme director mandated `gs-partner-mtls-v3` globally (Chapter 15). Tenant-facing TLS remained profile-inherited per tier. Programmes that regionalise partner profiles recreate CDG blocking; programmes that per-tenant fork partner profiles recreate engineering bankruptcy.

---

## 21.4 Shared Responsibility Model

Cloud cryptography operates under a **shared responsibility model** — the contractual and operational partition of cryptographic duties between provider and customer. PQC migration fails when enterprises treat provider readiness announcements as transfer of **algorithm transition obligation**.

### 21.4.1 Responsibility partition

| Control domain | Provider typical responsibility | Customer / SaaS operator responsibility |
|----------------|--------------------------------|----------------------------------------|
| Physical data centre security | ✓ | — |
| Hypervisor and host integrity | ✓ | — |
| Managed KMS platform availability | ✓ | — |
| **Algorithm implementation inside validated module** | ✓ (when claimed) | **Verify CMVP scope** |
| **Key hierarchy design** | Platform defaults | **Architecture** |
| **Tenant key isolation** | Isolation mechanisms | **Configuration and audit** |
| **Application-layer signing** | — | **SaaS operator** |
| **Mutual TLS to partners** | Edge termination optional | **Policy and negotiation** |
| **CBOM inventory** | Provider disclosure | **Merge into estate CBOM** |
| **HLM phase execution** | — | **Programme governance** |
| **Cross-border evidence** | Processor sub-services list | **Article 28/32 documentation** |

### 21.4.2 SaaS operator as both customer and provider

GlobalSync occupies **both sides** of the shared responsibility model:

- **As cloud customer:** GlobalSync consumes hyperscaler KMS, HSM, and networking — responsible for verifying PQC algorithm availability inside FIPS boundaries per region, BYOK import paths, and provider CBOM merge (Chapter 7).
- **As SaaS provider:** GlobalSync provides logistics platform to tenants — responsible for application-layer cryptography, tenant isolation, profile inheritance, and processor documentation under GDPR Article 28.

The **concentration risk** intensifies at this dual boundary: a cloud KMS module gap affects GlobalSync's platform keys *and* cascades into tenant assurance packs for T0–T2 tiers.

### 21.4.3 Shared responsibility matrix artefact

Chapter 16 required procurement to attach a **signed shared responsibility matrix** for cloud KMS contracts. GlobalSync extended the matrix to **tenant-facing documentation**:

| Matrix row | Provider (hyperscaler) | GlobalSync (platform) | Tenant (customer) |
|------------|------------------------|----------------------|-------------------|
| Data encryption at rest | KMS platform | Key hierarchy; profile selection | BYOK key custody (T3) |
| TLS to tenant users | Optional edge | Termination; hybrid negotiation | Client compatibility |
| Application signing | — | Audit, webhook, API signatures | Custom integrations (tenant code) |
| PQC roadmap evidence | CMVP certs; roadmap | Assurance pack merge | T3: customer module evidence |
| Incident notification | Provider SLA | Tenant notification clause | Flow-down to sub-processors |

> **Regulatory Lens**
>
> GDPR Article 32 requires appropriate technical measures including encryption — measured against **state of the art** and risk. Supervisory authorities do not accept "our cloud provider encrypts data" without **demonstrating** that encryption meets current risk, including documented trajectory toward post-quantum resilience. For SaaS processors, Article 28 requires sufficient guarantees — assurance packs must cite **actual algorithms, custody model, and migration timeline**, not marketing language inherited from hyperscaler press releases.

### 21.4.4 Concentration risk under shared responsibility

Chapter 16's Article 29 concentration analysis applies to cloud cryptography:

| Concentration signal | GlobalSync example | Programme response |
|---------------------|-------------------|-------------------|
| Single hyperscaler for 85% of KMS operations | Primary EU and US regions | Secondary provider evaluation; region-pinned evidence |
| Dominant partner gateway vendor | Single API hub for customs integrations | Contractual PQC roadmap; Wave 0 retest SOW |
| Embedded JWT library across 200 services | Transitive dependency fan-in | Platform golden image remediation (Chapter 17) |
| One HSM vendor for platform signing | Corporate ML-DSA root | Parallel vendor qualification in procurement pipeline |

Sofia Lindström escalated hyperscaler concentration to steering Q3 2027 — not for immediate migration, but for **evidence redundancy**: secondary KMS provider interop testing began so assurance packs could cite substitutability analysis if primary module validation delayed.

---

## 21.5 BYOK, HYOK, and Tenant Key Custody

**Bring Your Own Key (BYOK)** and **Hold Your Own Key (HYOK)** models transfer key custody toward the tenant — shifting PQC migration evidence requirements across the shared responsibility boundary.

### 21.5.1 Custody model definitions

| Model | Key generation | Key storage | Platform access | Typical tier |
|-------|---------------|-------------|-----------------|--------------|
| **Provider-managed** | Platform KMS | Provider HSM | Full wrap/unwrap | T0 |
| **Customer-managed (CMK)** | Platform or tenant | Provider HSM, tenant-controlled policy | Platform unwrap for operations | T1–T2 |
| **BYOK** | Tenant | Tenant HSM; key imported to platform KMS | Platform operations on imported key | T3 |
| **HYOK** | Tenant | Tenant HSM exclusively | Platform never holds raw key | T3 (defence, finance) |

PQC migration adds complexity: **import format support** for ML-DSA and ML-KEM key material; **larger key components** stressing ceremony media; **validation boundary** — tenant's module may lag platform module by quarters.

### 21.5.2 BYOK/HYOK PQC checklist

| Requirement | Platform obligation | Tenant obligation | Evidence artefact |
|-------------|--------------------|--------------------|-------------------|
| ML-KEM / ML-DSA import support | Document supported formats; test harness | Provide compliant key material | Interop test report |
| Key size limits | Publish maximum sizes per tier | Validate HSM capacity | CMVP implementation letter |
| Rotation choreography | API and runbook for dual-key H1 | Participate in rotation window | Change record per tenant |
| HLM phase alignment | Notify per contract clause | Accept or defer sunset | Contract amendment log |
| Validation module ID | Publish platform `validation_module_id` | Provide customer module ID | Merged validation matrix |
| Destruction attestation | Platform key deletion cert | Tenant HSM destruction cert | Cross-boundary audit pack |

### 21.5.3 The T3 validation dependency

Chapter 18 documented GlobalSync's **T3 BYOK tenant in Germany** — platform H2-ready while customer-managed HSM awaited ML-KEM validation. The migration dependency timeline applied **per-tenant**, not per-platform.

Marcus Chen's architecture board rejected "platform ready" marketing for T3 tiers. Tenant assurance packs explicitly stated:

- Platform HLM phase and date
- Tenant custody model and tenant HLM commitment
- **Blocking dependency** if tenant module validation lags platform
- Interop test offer with tenant endpoints

> **Dependency Alert**
>
> BYOK tenants are CDG leaf nodes that can become **blocking nodes for tenant relationship revenue** — not for platform engineering, but for Wave exit claims. GlobalSync's Wave 1 exit criteria included "platform tiers T0–T2 migrated"; T3 tenants tracked on **separate tenant wave register** with contractual sunset dates. Conflating platform and tenant wave completion produces false PQ-ADAPT maturity declarations.

### 21.5.4 HYOK and confidential computing intersections

HYOK tenants — common in defence-adjacent logistics segments GlobalSync serves — require **cryptographic operations inside tenant boundary** with attested execution evidence. Confidential computing (TEE-based enclaves) provides an intermediate pattern: platform operates on encrypted data without raw key access, but attestation chains must still reflect PQC algorithms in quoting and sealing paths.

GlobalSync's HYOK architecture limited platform obligations to:

- Relay encrypted payloads
- Provide attestation verification APIs
- Maintain CBOM rows for **platform-visible** cryptography only
- Document explicit **blind spots** in tenant-facing CBOM summaries — tenant-internal HSM operations marked `custody=tenant; visibility=none`

Honest blind-spot documentation prevented supervisory findings when auditors compared marketing claims to evidence scope.

### 21.5.5 Key rotation choreography across custody tiers

PQC migration conflates **algorithm substitution** with **scheduled rotation** more severely in multi-tenant estates than in single-enterprise deployments — because rotation windows must align across platform KMS, tenant CMK policies, and BYOK ceremony calendars without forcing simultaneous tenant outages.

GlobalSync adopted a **tiered rotation choreography** model:

| Phase | T0–T1 action | T2 action | T3 action |
|-------|-------------|-----------|-----------|
| **H1 entry** | Platform dual KEK; tenant DEK re-wrap | Elevated audit signing key dual-stack | Interop test for imported PQC key |
| **H1 sustain** | Automated re-wrap on tenant login burst | Manual change window per tenant SLA | Tenant-led ceremony with platform witness |
| **H2 transition** | Disable classical KEK generation | Contractual 90-day notice | Tenant amendment required |
| **H3 verification** | CBOM scan confirms zero classical wrap | Per-tenant attestation in assurance pack | Customer destruction cert collected |

Marcus Chen's operations team published **runbooks per tier** — not one enterprise rotation document. A T0 rotation completed in automated maintenance; a T3 BYOK rotation required six-week lead time and interop harness re-execution. Steering committee approved choreography before Wave 1 to prevent operations from improvising per incident.

**Rollback posture:** H1 dual-stack rotations retained classical KEK material in escrow until verification windows closed — typically fourteen days for T0, thirty days for T2, contract-defined for T3. GlobalSync's January 2028 evidence pack cited rollback posture explicitly when the German healthcare tenant asked whether hybrid transition introduced irreversible risk.

---

## 21.6 Cloud Provider Capability Comparison Framework

The book deliberately avoids vendor product endorsements. Assessment uses **vendor-neutral capability categories** applicable to hyperscaler KMS, cloud HSM, managed PKI, edge TLS, and confidential computing services. Procurement embeds this framework in RFP scoring (Chapter 16); architecture maintains living assessments quarterly.

**Table 21.1 — Cloud Provider Capability Comparison Framework (Vendor-Neutral Categories)**

| Category | Assessment question | Evidence required | Scoring guide (1–5) |
|----------|--------------------|--------------------|---------------------|
| **A. Algorithm breadth** | Which FIPS 203–205 algorithms are available in production API? | CMVP certificate; algorithm implementation list | 1=roadmap only; 5=all required algorithms in scope regions |
| **B. Validation boundary** | Which algorithms are inside FIPS 140-3 module vs software implementation? | CMVP security policy PDF; boundary diagram | 1=unclear boundary; 5=explicit per-algorithm module mapping |
| **C. Regional availability** | Do capabilities vary by region/jurisdiction? | Region capability matrix | 1=undocumented variance; 5=published per-region with dates |
| **D. BYOK/HYOK import** | Supported import formats for ML-KEM, ML-DSA key material? | Import API documentation; test results | 1=not supported; 5=production import with interop harness |
| **E. Hybrid support** | TLS hybrid groups, hybrid wrap, dual-signature options? | Configuration reference; interop test pack | 1=classical only; 5=production hybrid with telemetry |
| **F. Key ceremony scale** | Maximum key sizes; HSM partition limits; throughput | Performance whitepaper; measured benchmarks | 1=ML-DSA exceeds limits; 5=certified at required parameter sets |
| **G. CBOM / transparency** | Machine-readable cryptographic disclosure available? | Provider CBOM or equivalent JSON | 1=none; 5=CycloneDX-compatible or mergeable format |
| **H. Roadmap binding** | Are PQC milestones contractually binding? | Contract clause; SLA attachment | 1=marketing slide; 5=milestone penalties in contract |
| **I. Audit and attest** | Third-party audit rights; SOC/FedRAMP crypto control mapping? | Audit report excerpts; responsibility matrix | 1=no audit rights; 5=full cryptographic audit clause |
| **J. Exit and portability** | Key export, migration assistance, destruction certification? | Exit runbook; sample destruction cert | 1=lock-in; 5=documented portable exit |
| **K. Multi-tenant isolation** | Cryptographic isolation between customer keys? | Architecture whitepaper; pen test summary | 1=logical only; 5=hardware-backed isolation evidence |
| **L. Agility operations** | API-driven algorithm policy update without redeployment? | API reference; change logs | 1=manual ticket; 5=programmatic policy with version API |

**Composite assessment:** Categories A, B, C, D are **blocking** — score below 3 triggers Wave gate hold for workloads depending on that capability. Categories E–L are **programme** — score below 3 triggers risk acceptance or compensating controls.

**Assessment cadence:** Quarterly refresh aligned to steering committee; ad hoc refresh on provider major release or CMVP recertification.

GlobalSync maintained assessments for **three hyperscaler categories** and **two specialist cloud HSM providers** — scores published internally to programme office, not externally. Marcus Chen used composite scores to sequence **Pattern C cloud KMS migration** (Chapter 14) — EU region first where Category C scored highest; APAC deferred where Category B boundary ambiguity required legal review.

> **Architect's Decision**
>
> **Score the validation boundary, not the press release.** Meridian's DORA lesson (Chapter 14) applies to SaaS operators as cloud customers: ML-KEM in a marketing blog is not ML-KEM inside the FIPS boundary your tenant assurance pack cites. Category B is the most common false-positive source — require security policy PDF annotation, not sales engineering summary.

---

## 21.7 Three-Region Programme Design

GlobalSync's **three-region programme office** under Sofia Lindström (Chapter 15 §15.15) is the organisational pattern this chapter operationalises for cryptographic migration — not a generic project management convenience, but a **Synchronize** mechanism for multinational platform operators.

### 21.7.1 Structure recap and cryptographic functions

| Function | Centralised (global) | Distributed (regional) |
|----------|---------------------|------------------------|
| CBOM platform and CDG | ✓ Global custodian | Regional discovery feeds |
| Wave register and KPI dashboard | ✓ Programme office | Regional execution status |
| Partner programme (Wave 0) | ✓ Marcus Chen matrix | Regional partner liaison |
| Crypto policy service | ✓ Single versioned source | Jurisdiction rule activation |
| Tenant contract tier mapping | ✓ APAC lead + legal | Regional sales alignment |
| Change windows | Framework | Regional maintenance bands |
| Regulatory liaison | Horizon monitoring | DPO, local counsel, supervisory interface |
| Assurance pack assembly | Template and platform content | Jurisdiction-specific annexes |

Marcus Chen retained **Americas security architecture accountability** while matrixing to global programme on Wave 0 partner gateway — dual hat explicit in RACI (Chapter 15, Table 15.7).

### 21.7.2 EU/US regulatory split without duplicate programmes

GlobalSync serves EU healthcare and enterprise tenants under GDPR and NIS2 flow-down, US federal logistics contractors under FedRAMP-oriented expectations, and APAC tenants under heterogeneous national frameworks. **Regulatory split does not justify cryptographic fork** — it justifies **jurisdiction overlay on unified profiles**.

| Dimension | Unified globally | Jurisdiction overlay |
|-----------|-----------------|---------------------|
| Algorithm matrix (ML-KEM, ML-DSA) | ✓ | — |
| HLM phase timeline | ✓ | Notification timing per regulation |
| Partner mTLS profiles | ✓ | — |
| CI/CD gate schema | ✓ | Rule set selection by region |
| Evidence pack structure | ✓ | GDPR annex vs FedRAMP excerpt |
| Tenant tier definitions | ✓ | T2 evidence depth varies |
| Procurement clause library | ✓ Base | Regional addenda (Chapter 16) |

Sofia Lindström rejected proposals for **EU-only forked microservices** — correctly identifying fork as Level 2 inventory decay accelerator. Instead, policy service returned `rule_set_id=eu-healthcare` or `rule_set_id=us-fed` at gate evaluation — same container image, different policy bundle.

### 21.7.3 Three-region collision resolution pattern

The September 2026 collision (Chapter 15) — Frankfurt partner team, Singapore tenant contracts, Oregon platform engineering — established the **resolution template** reused for PQC conflicts:

1. **Steering decision** on global technical standard (profile ID, not region)
2. **Funding** from corporate contingency for retest or acceleration
3. **Calendar alignment** to maintenance band minimising tenant impact
4. **Contract overlay** for tenants requiring elevated notification periods
5. **Evidence update** within 30 days — cross-border pack revision published

Cryptographic programme governance **is** change management at scale. Sofia's programme office measured success by **decision latency** — time from blocking identification to steering resolution — targeting <21 days for Tier 1 blockers.

---

## 21.8 GDPR Cross-Border Evidence

The January 2028 supervisory request that opened this chapter exemplifies **GDPR cross-border evidence** requirements for SaaS operators undertaking PQC migration. Migration changes algorithms, custody attestations, and processor documentation — triggering **Article 28** review and **Article 32** state-of-the-art assessment.

### 21.8.1 Evidence components

**Table 21.2 — Cross-Border Evidence Matrix (GDPR Processor Migration)**

| Evidence component | GDPR anchor | Source artefact | Update trigger |
|-------------------|-------------|-----------------|----------------|
| Processing description | Art 28(3) | DPIA; RoPA | New crypto processing step |
| Sub-processor list | Art 28(2) | Cloud provider register | Provider region change |
| Encryption measures | Art 32(1)(a) | Platform assurance pack | HLM phase transition |
| State-of-the-art trajectory | Art 32(1) | PQC programme charter; HLM timeline | Annual charter renewal |
| Key custody model | Art 32(1)(a) | Shared responsibility matrix | BYOK tenant onboarding |
| Cross-border transfer basis | Chapter V | SCCs; transfer impact assessment | Data residency change |
| Tenant isolation evidence | Art 32 | Architecture diagram; pen test | Isolation boundary change |
| Incident crypto impact | Art 33–34 | IR playbooks with crypto impact | Algorithm deprecation |
| CBOM processor summary | Art 28; accountability | Customer-facing CBOM (Chapter 7) | Quarterly CBOM refresh |
| Migration notification | Art 28(3)(e) | Tenant comms template | 90 days before material change |

### 21.8.2 The cross-border evidence pack

GlobalSync assembled **jurisdiction-scoped evidence packs** from reusable modules:

1. **Platform module** — validation matrix, CMVP references, HLM status, CBOM summary (redacted)
2. **Custody module** — shared responsibility matrix per tier (T0–T3)
3. **Transfer module** — SCCs, transfer impact assessment, region pinning statement
4. **Migration module** — what changed, when, tenant impact, rollback posture
5. **Supervisory module** — DPO attestation; prior supervisory correspondence index

The January 2028 German healthcare tenant request consumed modules 1, 2, 4, and 5 — assembled in forty-eight hours because modules were **maintained living**, not authored under deadline panic.

> **Regulatory Lens**
>
> Cross-border GDPR evidence is not a translation exercise. A US FedRAMP excerpt pasted into an EU supervisory response without Article 32 framing creates **jurisdiction category error** — correct cryptography, wrong legal grammar. GlobalSync's DPO insisted on **Article 32 narrative** linking encryption measures to risk and state of art, with PQC migration as demonstrable improvement trajectory — not checkbox compliance.

### 21.8.3 NIS2 and tenant flow-down

EU enterprise tenants under NIS2 **flow down** state-of-the-art security expectations to processors. GlobalSync's T2 regulated tier contracts explicitly referenced:

- NIS2 Article 21 security measures mapping
- PQC migration timeline alignment to tenant's own programme
- Annual assurance pack delivery within 30 days of request
- CBOM summary update within 14 days of material platform change

Procurement standardised flow-down language (Chapter 16 §16.9) — GlobalSync's commercial team could not accept unlimited liability for tenant's NIS2 interpretation, but **could** contractually commit to documented platform measures and evidence delivery cadence.

### 21.8.4 Data residency and cryptography interaction

Data residency constraints interact with cryptography: **region-pinned KMS keys** may prevent logical centralisation of key management even when application architecture centralises. GlobalSync's EU tenant data remained in EU regions with **EU-scoped CMVP modules** — Category C regional availability (Table 21.1) scored independently per region.

Marcus Chen documented **residency-crypto matrix**: data region × key region × validation module jurisdiction. Steering approved matrix before Wave 1 — preventing engineering shortcuts that stored EU healthcare metadata keys in US modules for "temporary" performance optimisation.

### 21.8.5 Supervisory question rehearsal

GlobalSync's DPO and programme office rehearsed **six supervisory questions** quarterly — adapting Meridian's financial services pattern (Chapter 15 §15.16) for processor accountability:

1. What encryption algorithms protect tenant data at rest and in transit today?
2. What is the documented post-quantum migration trajectory and HLM phase?
3. How is tenant cryptographic isolation demonstrated — architecture, test, audit?
4. Which sub-processors perform cryptographic processing and in which jurisdictions?
5. How are material algorithm changes notified to tenants and documented?
6. What evidence demonstrates state-of-the-art practice under Article 32?

Each question mapped to evidence modules (§21.8.2). Sofia Lindström required **steering committee review** of rehearsal findings — two Q3 2027 gaps (APAC Category C documentation; T2 tenant notification template lag) became funded remediation before January 2028 supervisory contact.

### 21.8.6 Schrems II and cryptographic evidence

Cross-border transfer mechanisms — Standard Contractual Clauses, supplementary measures — increasingly reference **technical controls** including encryption strength and key custody. PQC migration updates the technical narrative: supervisors and tenant counsel ask whether supplementary measures remain adequate when quantum threat models are considered.

GlobalSync's transfer impact assessment addendum (2027 revision) stated:

- Current classical algorithms and key sizes per tier
- Hybrid deployment status and measured negotiation rates
- Timeline to PQC-native operation per HLM phase
- Key custody model preventing foreign authority access inconsistent with SCC commitments

Cryptographic evidence **supports** transfer law analysis; it does not replace legal assessment. GlobalSync's legal team owned Schrems framing; Marcus Chen's architecture team supplied **accurate algorithm and custody facts** — preventing legal documents from citing obsolete cipher suites after Wave 1 deployment.

---

## 21.9 CI/CD Gates and Platform Engineering Integration

Chapter 17 established GlobalSync's **CI/CD cryptographic verification pipeline** — the engineering enforcement layer for multinational SaaS. Chapter 21 positions that pipeline as **sector-critical infrastructure**, not optional DevSecOps maturity.

### 21.9.1 Platform-scale gate requirements

| Gate | SaaS-specific extension | GlobalSync implementation |
|------|------------------------|---------------------------|
| CycloneDX schema | `tenant_tier`, `jurisdiction_rule_set` fields | Gate profile v2.3 |
| OPA policy bundles | Region-scoped rule sets | `eu`, `us`, `apac` bundles |
| Agility harness | Profile catalogue per tier | T0–T3 harness fixtures |
| IaC crypto lint | Multi-region load balancer parity | Weekly infra pipeline |
| Hybrid field validation | `hybrid_negotiation_rate` from telemetry | Ingress ETL weekly |
| Runtime drift detection | Per-tenant TLS scan sampling | T2+ tenants monthly |

The March 2027 **AGL-01 violation** on `TenantAuditSigner.java` (Chapter 17) demonstrated gate value at tenant boundary — non-agile signing pattern rejected before entering healthcare tenant audit chain.

### 21.9.2 Customer-facing CBOM summaries

GlobalSync published **customer-facing CBOM summaries** generated from same pipeline artefacts internal gates consumed — tenants merged provider summary with tenant-side CBOM for complete trust boundary picture (Chapter 7 §7.14). Pipeline integrity directly supported commercial trust: sales engineering cited signed CBOM artefacts in eleven tenant security reviews.

**Concentration risk mitigation:** Customer-facing summaries required **legal review queue** — engineering could not unilaterally publish algorithm claims. DPO reviewed summaries for Article 28 alignment before publication.

### 21.9.3 Multinational gate performance

GlobalSync capped gate overhead at **six minutes p95** (Chapter 17) — multinational rule evaluation risked latency explosion. Policy service cached jurisdiction bundles; SBOM merge ran incremental on dependency delta. Sofia Lindström rejected "skip gates in APAC" regional exception — correctly identifying exception as **evidence integrity fracture**.

### 21.9.4 Platform edge hybrid TLS and tenant-facing negotiation

SaaS operators terminate TLS at **platform edge** — load balancers, ingress controllers, API gateways — where hybrid negotiation rates determine HLM exit criteria (Chapter 11). GlobalSync instrumented edge telemetry feeding CBOM `hybrid_negotiation_rate` per tenant cohort:

| Telemetry dimension | Purpose | Steering use |
|--------------------|---------|--------------|
| `negotiated_group` | Hybrid vs classical outcome | H2 promotion threshold |
| `tenant_tier` | T0–T3 cohort analysis | Tier-specific sunset planning |
| `jurisdiction` | EU vs US vs APAC split | Regional rule set effectiveness |
| `client_class` | Browser, mobile SDK, partner API | Partner Wave 0 dependency tracking |

Edge negotiation centralisation is an **agility opportunity** — one profile update propagates to all tenants inheriting `gs-tenant-tls-v4`. It is a **concentration risk** — one misconfigured cipher policy affects every tenant on that profile. GlobalSync mandated **canary tenant cohort** deployment for edge profile changes: T0 internal tenants first, T2 healthcare tenants after seventy-two-hour soak, T3 BYOK tenants excluded from canary unless contractually opted in.

IaC crypto lint (Chapter 17) caught a **load balancer cipher mismatch** in US region — microservices negotiated hybrid while edge terminated classical-only. Drift detection flagged `confidence=conflicted` on 1,200 CBOM rows until remediation merged — illustrating build-time and runtime verification interdependence for platform operators.

### 21.9.5 Agility at SaaS scale: the profile catalogue as product

Chapter 10's crypto-agility standard becomes a **product artefact** for SaaS operators — tenants purchase tier and inherit profile catalogue rows. GlobalSync published **developer-facing profile documentation** synchronised to gate policy bundles:

- Profile ID and HLM phase
- Permitted algorithms and constructions
- Sunset date and successor profile
- Harness fixture reference for tenant integration testing
- Validation module requirements for T2+

Sales engineering could not promise algorithms outside the catalogue — procurement linked master agreement exhibits to catalogue version hash. When crypto governance board approved ML-KEM parameter set elevation, catalogue version incremented, gates updated within five business days, and tenant notification workflow triggered for T2+ cohorts — **synchronisation as commercial process**, not merely engineering discipline.

---

## 21.10 Procurement, Tenant Contracts, and Cloud Concentration

Chapter 16's procurement machinery applies to SaaS operators **bidirectionally** — as buyer of cloud services and as seller of platform services with cryptographic flow-down.

### 21.10.1 As cloud customer

GlobalSync procurement applied Table 16.2 vendor evidence checklist to hyperscaler and cloud HSM contracts:

- Machine-readable CBOM or cryptographic disclosure
- CMVP certificate with algorithm implementation annotation
- Binding PQC roadmap milestones with audit rights
- BYOK import format documentation
- Exit and key destruction assistance

**Concentration escalation:** Three cloud providers below Category H (roadmap binding) score triggered Article 29-style substitutability review — documented in steering minutes Q3 2027.

### 21.10.2 As SaaS provider

Tenant master agreements received **PQC addenda** (Chapter 16 §16.8.3):

| Clause element | Purpose |
|----------------|---------|
| Profile tier assignment | Links contract to T0–T3 assurance |
| Migration notification period | 90/180 days by tier before material algorithm change |
| Assurance pack delivery | Annual + on-request within SLA |
| BYOK interop obligation | Tenant participation in rotation windows |
| Classical sunset | Contractual alignment to GlobalSync HLM timeline |
| Sub-processor crypto flow-down | Tenant approval for provider changes affecting crypto |

APAC programme lead owned **tenant renewal cohort tracking** — KPI dashboard row `tenant_profile_adoption` prevented silent classical continuation in renewals (Chapter 15 §15.15).

### 21.10.3 Partner ecosystem procurement

wE +0.25 sector modifier elevates **partner ecosystem** to Wave 0 procurement priority. GlobalSync's customs integration partner (CDG blocking node for two hundred microservices) received contract amendment tying payment milestones to:

- Hybrid mTLS profile support by date
- Interop test participation
- Machine-readable CBOM disclosure
- Quarterly negotiation rate telemetry sharing

Partner procurement channel operated through **global programme director authority** — not regional partner managers incentivised to accept classical compatibility for quarterly revenue targets.

### 21.10.4 DORA flow-down via tenant contracts

GlobalSync is not a DORA-regulated financial entity — but **hosts** logistics workloads for EU banking tenants who are. Tenant T2 contracts therefore include **DORA ICT flow-down** clauses mirroring Meridian's supplier expectations (Chapter 16):

- Right to audit cryptographic controls supporting critical tenant functions
- Sub-processor notification for material cloud provider changes
- Co-operation with tenant ICT risk management and incident notification
- Exit assistance including cryptographic data portability specifications

Thomas Bergström consulted on Meridian's clause library; GlobalSync legal adapted **processor-side** language — demonstrating sector playbook cross-pollination without duplicating DORA compliance programmes GlobalSync does not operate. The clause structure ensured EU banking tenants could **embed GlobalSync assurance packs** directly into Article 28 due diligence files without re-interviewing Marcus Chen's engineers quarterly.

### 21.10.5 Concentration risk register

Sofia Lindström maintained a **cryptographic concentration risk register** — distinct from enterprise risk register quantum entry (Chapter 3) but cross-linked:

| Register row | Concentration type | Mitigation status | Next review |
|--------------|-------------------|-------------------|-------------|
| Hyperscaler A — EU/US KMS | Provider | Secondary interop testing | Q1 2028 |
| Customs partner gateway | Partner | Contract amendment + retest | Q4 2027 |
| Embedded JWT library | Transitive dependency | Golden image v4.2 promoted | Complete |
| Platform ML-DSA root HSM | Signing | Parallel vendor qualification | Q2 2028 |
| T3 BYOK tenant cohort (n=47) | Tenant custody | Separate wave register | Monthly |

Steering committee reviewed register quarterly — escalation when mitigation slipped more than one review cycle. The register made **concentration risk visible** alongside migration velocity — balancing the chapter's central argument in operational artefact form.

---

## 21.11 TRADE, Wave Planning, and Partner Ecosystem

Chapter 9's TRADE engine with **wE +0.25** produces SaaS-specific wave sequencing distinguishable from single-enterprise patterns.

### 21.11.1 SaaS wave sequencing defaults

| Wave | SaaS priority (wE-weighted) | GlobalSync outcome |
|------|----------------------------|-------------------|
| **Wave 0** | Partner gateways; shared libraries; platform KMS | Partner mTLS v3; blocking fan-in −78% |
| **Wave 1** | Ingress/egress; tenant API signing; golden images | Hybrid TLS production; agility Tier 2+ 74% |
| **Wave 2** | Tenant tier migrations; T2 regulated | EU healthcare cohort; FedRAMP tenants |
| **Wave 3** | T3 BYOK/HYOK per-tenant tracks | Germany HSM validation dependency |
| **Wave 4** | H3 verification; classical sunset | Tenant contract enforcement |

**Structural lane precedence** (Chapter 9): partner ecosystem Wave 0 could not be accelerated by business priority without board risk acceptance — Sofia enforced precedence when sales requested tenant feature freeze during partner retest.

### 21.11.2 Ecosystem readiness telemetry

Chapter 17's ingress telemetry — `tenant_id` × `negotiated_group` — fed TRADE **E** rescore triggers. When four-week rolling hybrid negotiation rate crossed policy threshold, programme office initiated H2 promotion review for eligible services.

Meridian's financial services overlay emphasises wR; GlobalSync's SaaS overlay emphasises **wE** — same TRADE engine, different sector truth.

---

## 21.12 Tenant Assurance Packs and Year 2–3 Programme Arc

GlobalSync's **Year 2–3 programme arc** synthesises chapter themes into measurable outcomes — the Proof phase deliverable Part VI promises.

### 21.12.1 Year 2 outcomes (2027)

| Metric | Target | Actual | Evidence |
|--------|--------|--------|----------|
| PQ-ADAPT Level 4 | Platform workstream | Declared Q2 2027 | Chapter 15 checklist |
| Wave 0 exit | Blocking fan-in <25% baseline | −78% | CDG dashboard |
| Agility Tier 2+ (Wave 1 services) | >70% | 74% | CBOM query |
| CI/CD gate bypass | Zero unapproved | Zero | Audit sampling |
| Tenant assurance packs published | T0–T2 | Annual release | DPO sign-off |
| Cloud provider assessment | Quarterly | Q1–Q4 complete | Table 21.1 scores |
| GDPR module maintenance | Living packs | 48-hour assembly proven | Jan 2028 request |
| Procurement tenant addenda | >80% renewals | 83% | Contract tracker |

### 21.12.2 Year 3 challenges (2028)

| Challenge | Concentration risk manifestation | Response |
|-----------|----------------------------------|----------|
| T3 BYOK Germany | Tenant HSM validation lag | Separate tenant wave register |
| Hyperscaler module delay (APAC) | Category C score drop | Region-pinned Wave 2 deferral |
| Tenant classical sunset resistance | Contract renewal friction | Steering-backed notification campaign |
| Supervisory crypto questionnaire surge | EU healthcare cohort | Evidence module automation |
| Partner P-003 interop failure | Wave 2 tenant block | Chapter 16 partner escalation |

Marcus Chen noted Year 3 truth: **platform migration velocity exceeded tenant custody velocity** — a predictable SaaS concentration risk. Sofia Lindström reframed KPI dashboard to show **platform HLM** and **tenant HLM** swim lanes — preventing false aggregate progress claims.

### 21.12.3 Lessons learned

1. **Tenant governance belongs in programme office**, not sales — three-region structure succeeded when contractual tier mapping was centralised (Chapter 15).
2. **Evidence modules beat emergency packs** — GDPR cross-border assembly in forty-eight hours required living documentation.
3. **wE +0.25 is not optional** for SaaS — partner Wave 0 precedence saved Wave 1 from permanent hybrid pilot status.
4. **BYOK tenants require separate wave tracks** — platform Level 4 does not imply tenant Level 4.
5. **Shared responsibility matrix is commercial artefact** — unsigned matrices produced tenant audit findings in two T2 renewals.
6. **Cloud concentration requires substitutability evidence** even when migration is not imminent — Article 29 logic applies to SaaS as buyer.

> **Migration Moment**
>
> *"We hit Level 4 on the platform — can we tell customers we're quantum-safe?"*
>
> PQ-ADAPT Level 4 means production hybrids under **programme governance** — not quantum-vulnerable algorithm retirement. Customer communications must align to **HLM phase**, tenant tier, and custody model. GlobalSync's marketing team received steering-approved language: *"Platform operating transitional hybrid cryptography under governed migration programme aligned to NIST IR 8547 anchors"* — not *"quantum-safe."*

---

## 21.13 Sector Overlay Summary Table

**Table 21.3 — Sector Overlay Matrix: SaaS / Cloud-Native Platform**

| SOM element | Universal default | SaaS / platform modifier |
|-------------|-------------------|--------------------------|
| TRADE wT | 1.00 | Unchanged |
| TRADE wR | 1.00 | +0.10 for regulated tenant segments |
| TRADE wA | 1.00 | Unchanged |
| TRADE wD | 1.00 | Unchanged |
| TRADE wE | 0.75 | **+0.25 → 1.00** |
| HLM Wave 0 | CDG blocking nodes | Partner ecosystem + platform KMS |
| Procurement focus | General third-party | Cloud KMS + tenant addenda + partner SOW |
| Assurance | Validation programme | Tenant assurance tiers T0–T3 |
| Governance | Standard programme office | Three-region model; tenant contract KPI |
| Evidence | CBOM + validation | Cross-border GDPR packs; customer CBOM summaries |
| Failure mode | Pilot permanence | **False platform progress** ignoring tenant custody |

---

## 21.14 Integration with Prior Chapters

| Prerequisite | Chapter | Chapter 21 use |
|--------------|---------|----------------|
| Three-region programme office | 15 §15.15 | Sofia Lindström operating model; collision resolution |
| Procurement clause library | 16 | Cloud customer + tenant provider clauses |
| CI/CD cryptographic gates | 17 | Platform enforcement; customer CBOM summaries |
| KMS/BYOK patterns | 14 | Custody tier architecture |
| Crypto-agility profiles | 10 | Tenant profile inheritance |
| TRADE wE modifier | 9 §9.22 | Sector wave sequencing |
| CBOM customer summaries | 7 §7.14 | Tenant trust boundary evidence |
| GDPR Article 32 | 3 | Cross-border evidence framing |

**Forward reference:** Chapter 22 — *Sustaining Quantum Resilience* — closes the book with standards watch, PQ-ADAPT Level 5 operations, and Year 3 retrospective across all four teaching organisations.

---

## 21.15 Figure Production Briefs

**Figure 21.1** (§21.3.3): Multi-tenant PQC architecture — full-width with custody tier colour coding, evidence plane at base, CI/CD gate band, partner gateway callout. Include legend for T0–T3 and jurisdiction overlay icons.

**Figure 21.2 — Shared Responsibility Swim Lanes:** Three lanes (hyperscaler, GlobalSync platform, tenant) with PQC migration artefacts annotated at boundary crossings. Highlight dual-role GlobalSync position.

**Figure 21.3 — Cross-Border Evidence Module Assembly:** Flowchart from supervisory request to module selection to DPO attestation — 48-hour path vs 3-week panic path contrast.

**Figure 21.4 — Platform vs Tenant HLM Swim Lanes:** Dual Gantt showing GlobalSync platform H2 progression while T3 tenant tracks remain H1 — prevents false aggregate reporting.

---

## 21.16 Apply in Your Organisation

1. **Document SOM wE +0.25** in programme charter before TRADE rescoring — SaaS sector modifier is mandatory, not advisory.
2. **Publish multi-tenant PQC architecture** using Figure 21.1 pattern — profile inheritance, not per-tenant forks.
3. **Define tenant assurance tiers T0–T3** with custody model, evidence pack, and contract mapping.
4. **Complete cloud provider capability assessment** (Table 21.1) for all in-scope providers — quarterly refresh.
5. **Sign shared responsibility matrices** for cloud contracts and tenant-facing documentation.
6. **Establish BYOK/HYOK interop harness** with T3 tenant test endpoints before marketing custody options.
7. **Separate platform wave register from tenant wave register** — especially for BYOK and regulated tiers.
8. **Implement jurisdiction-scoped CI/CD policy bundles** — not regional code forks (Chapter 17).
9. **Assemble cross-border evidence modules** (Table 21.2) as living artefacts — rehearse 48-hour assembly.
10. **Integrate tenant PQC addenda** into renewal workflow (Chapter 16) — track `tenant_profile_adoption` KPI.
11. **Escalate cloud concentration** when Table 21.1 Category H scores below 3 — substitutability analysis in steering.
12. **Align three-region programme office** with centralised partner programme and distributed regulatory liaison (Chapter 15).
13. **Publish customer-facing CBOM summaries** from pipeline artefacts — legal/DPO review before release.
14. **Track platform HLM and tenant HLM separately** in board and customer reporting.
15. **Rehearse supervisory crypto questions** using GDPR Article 32 framing — not US control language in EU responses.

---

## 21.17 Chapter Summary

- **Cloud centralisation** simultaneously accelerates PQC migration through policy propagation and CI/CD gates — and **concentrates regulatory, custody, and partner risk** in single platform decisions.
- The **SaaS sector overlay** applies **wE +0.25** — ecosystem readiness gates Wave 0 partner and platform KMS work before tenant-facing migration claims.
- **Multi-tenant PQC architecture** composes platform policy, tenant tier overlay, and jurisdiction rules through **profile inheritance** — avoiding per-tenant engineering forks.
- **Shared responsibility models** must be documented bidirectionally: GlobalSync as cloud customer and SaaS provider; unsigned matrices create tenant audit findings.
- **BYOK/HYOK** shifts validation evidence to tenant custody — requiring separate wave tracks and honest assurance pack blind-spot documentation.
- **Table 21.1** provides vendor-neutral cloud capability assessment — score validation boundaries, not marketing readiness.
- **Three-region programme design** under Sofia Lindström (Chapter 15) enables EU/US regulatory split without duplicate cryptography programmes — jurisdiction overlays on unified profiles.
- **GDPR cross-border evidence** requires living module assembly — Article 32 state-of-the-art narrative linking PQC migration to processor accountability.
- **Chapter 17 CI/CD gates** and **Chapter 16 procurement** are sector-critical for SaaS — gates enforce agility; contracts enforce tenant and partner obligations.
- **GlobalSync Year 2–3 arc** demonstrates platform Level 4 with tenant custody lag — honest dual swim-lane reporting prevents false quantum-safe claims.

**Next:** Chapter 22 — *Sustaining Quantum Resilience* — standards watch, algorithm contingency, PQ-ADAPT Level 5 operations, and Year 3 retrospective across Meridian, Northfield, Apex, and GlobalSync.

---

*Chapter 21 — References*

- European Data Protection Board. (2024). *Guidelines on Article 32 GDPR: Security of processing* (revised draft and stakeholder consultation materials).
- European Parliament and Council. (2016). Regulation (EU) 2016/679 (General Data Protection Regulation). *Official Journal of the European Union*, L 119.
- European Parliament and Council. (2022). Directive (EU) 2022/2555 on measures for a high common level of cybersecurity across the Union (NIS2). *Official Journal of the European Union*, L 333.
- Cloud Security Alliance. (2024). *Cloud key management and cryptographic responsibility matrix*. CSA Guidance.
- National Institute of Standards and Technology. (2024). *FIPS 203* (ML-KEM), *FIPS 204* (ML-DSA), *FIPS 205* (SLH-DSA). U.S. Department of Commerce.
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- CycloneDX Contributors. (2024). *Authoritative Guide to CBOM* and *CycloneDX specification v1.6+*. OWASP Foundation.
- International Organization for Standardization. (2024). *ISO/IEC 27001:2022* — Information security management systems (processor control mapping for cloud services).
- National Institute of Standards and Technology. (2022). NIST SP 800-218: Secure Software Development Framework (SSDF) Version 1.1. https://doi.org/10.6028/NIST.SP.800-218
- GlobalSync Logistics programme office. (2028). *Illustrative multi-tenant PQC architecture, three-region operating model, and cross-border evidence packs* (composite case study).

---

*Proceed to Chapter 22: Sustaining Quantum Resilience.*
