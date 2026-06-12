# Chapter 10
# Cryptographic Agility as Architecture

---

GlobalSync Logistics' platform engineering council met in January 2027 with a problem that no amount of hybrid TLS configuration could solve. Marcus Chen's security team had approved fourteen production-ready hybrid deployments. Partner trust policy — Wave 0 from the CDG — was on track. Individual microservices still failed architecture review because engineers had embedded `RSA-2048` and `ECDSA-P256` as compile-time constants in payment adapters, tenant key-wrapping modules, and audit-signing utilities.

Marcus did not need another cipher suite document. He needed **engineering standards** that made algorithm choice a configuration and policy problem — not a redeployment problem. Over six weeks, GlobalSync published **Crypto-Agility Standard v1.0**: mandatory provider abstraction, config-driven algorithm profiles, negotiation rules for partner-facing protocols, and an enterprise test harness that exercised every approved profile before SDLC gates opened.

The standard did not mention ML-KEM once in its opening pages. It defined **separation of cryptographic policy from implementation** — the architectural principle this chapter develops. When NIST deprecates an algorithm, GlobalSync changes policy rows and configuration bundles. Services that violated the standard would require code changes, regression cycles, and tenant notification — exactly the synchronisation failure Part I warned against.

This chapter teaches readers to produce the same artefact: architecture standards and non-functional requirements that satisfy **PQ-ADAPT Level 3 (*Architected*)** and complete the **Decide** phase of ARCS with implementable patterns engineering teams can adopt without improvising per project.

---

## 10.1 ARCS Decide Phase and PQ-ADAPT Level 3

Parts I through III completed **Awareness**, **Capability**, and **Register**. The enterprise holds algorithm policy (Chapters 4–6), hybrid lifecycle rules (Chapter 5), a CBOM baseline (Chapter 7), a cryptographic dependency graph (Chapter 8), and a board-approved wave plan (Chapter 9). None of that tells a development team how to build a migration-ready microservice.

**ARCS — Decide** converts programme intelligence into **architecture standards**: what new systems must implement, what legacy systems must retrofit, and what evidence SDLC gates require before production. Chapter 10 is the Decide-phase foundation — agility before hybrid deployment patterns (Chapter 11), protocol transition (Chapter 12), PKI evolution (Chapter 13), and key management (Chapter 14).

| ARCS phase | Part | Primary output | Chapter 10 contribution |
|------------|------|----------------|-------------------------|
| Register | III | CBOM, CDG, wave plan | Agility attributes on CBOM rows |
| **Decide** | **IV** | **Architecture standards, NFRs** | **Crypto-agility standard, maturity model** |
| Execute | IV–V | Production patterns, programme delivery | Test harness, SDLC gates |
| Sustain | V–VI | Assurance, sector overlays | Continuous agility verification |

**PQ-ADAPT Level 3 (*Architected*)** requires more than policy documents naming ML-KEM. Level 3 entry criteria relevant to this chapter:

| Criterion | Evidence artefact | Owner |
|-----------|-------------------|-------|
| Crypto-agility embedded in SDLC | Agility NFR template adopted; gates active | Enterprise architecture |
| Hybrid policy operationalised | HLM phases referenced in standards (Chapter 5) | Security architecture |
| Architecture standards by system class | IT, SaaS platform, OT, NSS variants | Domain architects |
| Provider abstraction mandated for new development | Coding standards, library allow-list | Platform engineering |
| Test harness for algorithm profiles | CI pipeline integration | Crypto engineering |
| CBOM agility fields populated | `agility_tier`, `policy_profile_id` | CBOM custodian |

Enterprises with wave plans but no agility standards remain at **Level 2 (*Inventoried*)** — they know what to migrate but build systems that harden today's algorithms into tomorrow's blocking dependencies.

> **Migration Moment**
>
> *"We approved hybrid TLS in the security standard. Isn't that agility?"*
>
> Protocol policy is one layer. Application code that calls `Signature.getInstance("SHA256withECDSA")` directly will not migrate when the TLS terminator does. GlobalSync learned this when three "PQ-ready" services failed review — TLS was hybrid-capable; application-layer signing was not. Agility is an **architecture property**, not a cipher suite checkbox.

---

## 10.2 What Cryptographic Agility Is — and Is Not

**Cryptographic agility** is the capability to substitute algorithms, parameter sets, or providers within defined change windows **without redesigning the system** that consumes cryptography.

Agility is **not**:

- Running hybrid TLS while application code hard-codes RSA key wrapping
- Maintaining a spreadsheet of "approved algorithms" that engineers ignore
- Selecting PQC libraries per project without enterprise abstraction
- Deferring all algorithm decisions to "when migration starts" (Chapter 4 established that migration started in August 2024)

Agility **is**:

- **Policy** — which algorithms are permitted for which workload class, governed by HLM phase (Chapter 5)
- **Configuration** — which permitted algorithm a deployment instance uses, changeable without recompilation where feasible
- **Negotiation** — how protocols select algorithms with partners, tenants, or devices at runtime
- **Verification** — test harnesses proving substitution works before production gates open

The ECC transition (Chapter 1) demonstrated partial agility: enterprises with crypto provider libraries migrated faster than those with algorithm constants scattered through codebases. PQC amplifies the lesson — keys and signatures are larger, validation paths are more complex, and hybrid interim states last years. Agility is the highest-leverage architectural investment before wave execution accelerates.

### 10.2.1 Historical lesson: SHA-1 deprecation

Enterprises that confused **protocol agility** with **application agility** suffered during SHA-1 certificate retirement. Load balancers negotiated SHA-256; internal signing pipelines still emitted SHA-1 CMS signatures for years. PQC migration repeats the pattern at larger scale: TLS may negotiate ML-KEM while application-layer key wrapping still calls RSA-2048. Chapter 10 addresses application and platform layers — Chapter 12 addresses protocol layers — but both require the same policy/implementation separation.

### 10.2.2 Agility versus performance optimisation

Teams sometimes resist provider abstraction citing latency. The counter-argument is economic, not purely technical: a direct library call saves microseconds; an emergency fourteen-system retrofit costs person-years. GlobalSync benchmarked enterprise crypto service overhead at 2–4 ms p99 for signing operations — acceptable for all but ultra-low-latency paths, which received **annotated exceptions** with hardware acceleration and unchanged profile IDs. Performance tuning happens inside the provider; algorithm selection does not move back into application code.

---

## 10.3 The Core Principle: Policy Separated from Implementation

The chapter's central architectural argument:

> **Cryptographic agility is achieved by separating policy (what algorithms may be used, under what lifecycle phase) from implementation (how a specific deployment invokes cryptography).**

### Three-layer model

| Layer | Contents | Changes when… | Owned by |
|-------|----------|---------------|----------|
| **Policy** | Algorithm matrix, HLM phase rules, workload-class defaults | NIST deprecation, regulatory shift, breach of contingency algorithm | CISO office / crypto governance board |
| **Configuration** | Profile IDs, tenant overrides, environment-specific algorithm bundles | Wave progression, partner negotiation, pilot promotion | Platform / domain engineering |
| **Implementation** | Provider calls, negotiation handlers, key custody interfaces | Provider upgrade, performance optimisation — **not** routine algorithm change | Development teams |

When layers collapse, agility fails:

```
ANTI-PATTERN                          AGILITY PATTERN
─────────────────────────────────────────────────────────────
Policy in code:                        Policy in governance:
  if (usePqc) ML-DSA-65               policy_profile: "financial-signing-v3"
  else ECDSA-P256                     config: profile_id from service mesh
                                      code: cryptoService.sign(payload, profile)
```

**Meridian Mutual Bank** encoded this separation in its Java and .NET standards (Chapter 4): direct BouncyCastle algorithm string literals are banned in application code; services call the enterprise crypto service with a **policy profile identifier**. The crypto service resolves profile → algorithm → validated provider module. When Meridian's algorithm matrix elevates a workload from ML-DSA-65 to ML-DSA-87, policy updates propagate through profile resolution — not through fourteen hundred microservice pull requests.

> **Architect's Decision**
>
> **Do not embed algorithm names in application business logic — embed policy profile identifiers.** Profile identifiers are stable across algorithm generations (`tenant-encryption-standard`, `audit-signing-production`). Algorithm names inside profiles change with HLM phase transitions. This single convention is the highest-ROI agility decision an enterprise architect can enforce.

---

## 10.4 The Cryptographic Agility Maturity Model

Enterprises progress through five agility tiers. The model is orthogonal to PQ-ADAPT — an enterprise can be Level 2 inventoried with Tier 0 agility on most systems. Chapter 10 targets **Tier 3+** for new development and **Tier 2 minimum** for Wave 0–2 retrofits.

| Tier | Name | Characteristics | Typical estate % (illustrative) |
|------|------|-----------------|--------------------------------|
| **0** | **Frozen** | Hardcoded algorithms; no provider abstraction; config change requires release | Legacy OT, embedded firmware pre-redesign |
| **1** | **Library-bound** | Central crypto library but algorithm constants in code | Mature enterprise Java monoliths |
| **2** | **Configurable** | External config selects algorithm from small allow-list; restart may be required | Standard three-tier web applications |
| **3** | **Negotiated** | Runtime protocol negotiation + config profiles; hot reload or sidecar update | Microservices, API gateways, SaaS platforms |
| **4** | **Policy-driven** | Policy service resolves profiles; CBOM-linked; automated compliance verification | GlobalSync target state; Meridian new development |
| **5** | **Continuous** | Automated policy rollout, canary algorithm substitution, telemetry on negotiation failures | Aspirational; few enterprises 2027 |

**Wave planning integration (Chapter 9):** Each CBOM row carries `agility_tier`. Wave 0 blocking nodes require Tier 3+ before dependents migrate. Wave 3 bulk estate may accept Tier 2 retrofits with documented sunset dates.

**Assessment method:** Architecture review samples ten systems per domain; classifies tier; rolls up domain score. Steering committee tracks **percentage of in-scope systems at Tier 2+** alongside quantum-vulnerable percentage.

### 10.4.1 Tier progression roadmap

Enterprises should publish a **tier progression schedule** aligned to waves — not aspirational "everything Tier 4 by 2035" slogans:

| Wave | Minimum tier (new build) | Minimum tier (retrofit) | Exemption allowed? |
|------|--------------------------|-------------------------|-------------------|
| Wave 0 blocking nodes | Tier 3 | Tier 3 | No |
| Wave 1 threat-immediate | Tier 3 | Tier 2 | Risk acceptance ≤ 12 months |
| Wave 2 PKI / shared services | Tier 3 | Tier 2 | Documented sunset |
| Wave 3 general estate | Tier 3 | Tier 2 | Decommission path alternative |
| Wave 4 OT long-tail | Tier 3 (IT interfaces) | Tier 1–2 per ceiling | OT realism |

Meridian published tier targets in the same steering pack as TRADE wave plan (Chapter 9) — board approved **one sequencing narrative**, not competing security and programme documents.

### 10.4.2 Self-assessment workshop (half-day)

Programme offices can run a structured workshop: (1) sample twenty CBOM rows stratified by domain; (2) classify tier using evidence rubric; (3) compare self-reported vs assessed tier; (4) identify top five **tier inflation** systems where documentation claims Tier 3 but code review finds literals. Apex discovered 40% tier inflation in commercial IT self-assessment — honest baseline before standards publication.

---

## 10.5 Crypto-Agility Non-Functional Requirements

Non-functional requirements (NFRs) translate policy into procurement and engineering obligations. GlobalSync's standard mandated the following NFR categories for all new platform services and Wave 1+ retrofits.

### 10.5.1 Master NFR template

| NFR ID | Requirement | Verification method | Gate |
|--------|-------------|---------------------|------|
| **AGL-01** | No hardcoded algorithm identifiers in application source | Static analysis rule; code review checklist | Design → Build |
| **AGL-02** | Cryptographic operations via approved enterprise provider or cloud KMS API | Dependency scan; architecture review | Design |
| **AGL-03** | Policy profile identifier referenced for every crypto operation class | Config manifest review | Build |
| **AGL-04** | Algorithm substitution completable within **S** days for system class | Tabletop exercise; test harness run | Pre-production |
| **AGL-05** | Negotiation failure degrades gracefully per documented fallback matrix | Integration test suite | Pre-production |
| **AGL-06** | CBOM row updated with `policy_profile_id` and `agility_tier` | CMDB integration | Production release |
| **AGL-07** | HLM phase attribute set; no production deploy below policy minimum | Policy compliance scan | Production |
| **AGL-08** | Telemetry: algorithm used, negotiation outcome, provider version | Observability dashboard | Production (continuous) |

**Substitution window (S):** GlobalSync defined 30 days for stateless microservices, 90 days for data stores with encrypted columns, 180 days for partner-integrated services (contract amendment lead time), and **firmware cycle** for OT — not calendar days.

### 10.5.2 NFR annotation in architecture decision records

Meridian required ADRs for crypto-touching systems to cite NFR IDs explicitly:

```
ADR-2027-0142: Payment notification signing
  Satisfies: AGL-01, AGL-02, AGL-03, AGL-07
  Profile: meridian-audit-signing-h1
  HLM phase: H1 (hybrid ML-DSA-65 + ECDSA-P256)
  Exception: none
```

ADR discipline prevented oral waivers — audit findings in regulated programmes often trace to "we thought platform team approved it."

---

## 10.6 NFR Variants by System Class

One NFR template does not fit NSS enclaves, OT gateways, and multi-tenant SaaS. Derive variants from a common base.

| System class | Additional NFRs | Substitution window | Notes |
|--------------|-----------------|---------------------|-------|
| **General IT microservice** | Standard AGL-01–08 | 30 days | GlobalSync default |
| **Regulated financial (Meridian)** | FIPS 140-3 validated module path mandatory | 90 days | Payment HSM integration |
| **Multi-tenant SaaS (GlobalSync)** | Tenant-scoped profile override without code fork | 30 days platform; 90 days tenant notification | Isolation testing required |
| **NSS (Apex)** | CNSA parameter profile enforcement; no downgrade | NSS change control board | Separate policy namespace |
| **OT gateway (Northfield)** | Firmware-signed config only; no cloud policy pull | Vendor firmware cycle | Tier 0–2 realistic cap |
| **Firmware / embedded** | A/B partition config; dual-signature verify path | Manufacturing window | Chapter 6 schemes |

**Northfield realism:** OT gateways may never reach Tier 4 in a single refresh cycle. Northfield's programme office documents **agility ceiling** per device class — honest Tier 2 with dual-signature firmware beats fictional Tier 4 on paper.

---

## 10.7 GlobalSync: Platform Engineering Agility Standards

GlobalSync's case study illustrates Decide-phase architecture at scale — 200+ microservices, forty jurisdictions, partner mTLS blocking node from Chapter 8.

### 10.7.1 Standard structure

**Crypto-Agility Standard v1.0** comprised:

1. **Principles** — policy/implementation separation; no algorithm literals
2. **Provider registry** — approved crypto providers with validation status (Chapter 4 matrix)
3. **Policy profiles** — named bundles mapping operation types to algorithms and HLM phases
4. **Configuration contract** — Kubernetes ConfigMap / service mesh schema for `crypto_profile`
5. **Negotiation rules** — TLS, JWS, CMS defaults for partner and tenant channels
6. **Test harness specification** — mandatory CI job `crypto-agility-verify`
7. **SDLC gate integration** — architecture review checklist §4.8
8. **Exception process** — Tier 0 waiver with risk acceptance and sunset date

### 10.7.2 Policy profile example

| Profile ID | Operation | HLM phase | Algorithms | Validated module required |
|------------|-----------|-----------|------------|---------------------------|
| `gs-tenant-wrap-v2` | Key wrapping | H1 | ML-KEM-768 + RSA-OAEP-2048 hybrid | Production: yes |
| `gs-api-sign-v1` | Request signing | H1 | ML-DSA-65 + ECDSA-P256 | Production: yes |
| `gs-partner-mtls-v3` | TLS client auth | H0→H1 | Partner policy driven | Per partner register |
| `gs-audit-hash-v1` | Integrity hash | H3 target | SHA-384 | N/A (symmetric) |

Profiles reference the **algorithm standards matrix** from Chapter 4 — standards authors do not duplicate parameter decisions in agility documents.

### 10.7.3 Tenant-scoped rollout

GlobalSync's multi-tenant model required **profile inheritance**:

```
platform-default → region-overlay (EU/US) → tenant-tier (healthcare/logistics) → tenant-override (contract)
```

Marcus Chen's team refused tenant-specific algorithm forks in source code. Tenants received configuration overlays — the same binary, different `crypto_profile` ConfigMap. Healthcare tenants (GDPR Article 9, Chapter 9) inherited elevated profiles without engineering branches.

**Wave alignment:** Partner mTLS policy (Wave 0) migrated to `gs-partner-mtls-v3` at the blocking node. Microservices (Wave 3) consumed the profile — they did not negotiate partner algorithms independently. CDG fan-in reduction depended on this centralisation.

### 10.7.4 Engineering adoption metrics

| Metric | Q1 2027 baseline | Q3 2027 target |
|--------|------------------|----------------|
| Services passing AGL-01 static analysis | 34% | 85% |
| Services with policy profile config | 28% | 90% |
| CI jobs running agility test harness | 12% | 100% (Wave 1+ in scope) |
| Hardcoded algorithm violations in new PRs | blocked at merge | zero tolerance |

Platform engineering embedded checks in the **golden path** template repository — teams scaffolding from template inherited compliance; brownfield repos required explicit retrofit epics in wave plan.

### 10.7.5 Developer portal integration

GlobalSync's internal developer portal became the **single front door** for crypto configuration — engineers selected workload class from a dropdown; portal rendered approved profiles, validation module status, sample ConfigMap snippets, and links to harness documentation. Portal reduced architecture review loops: teams arrived with pre-approved profile selections rather than open-ended "which algorithm?" debates.

Portal backend read live data from policy service and validation coverage matrix (Chapter 4) — stale portal content was a compliance incident. Marcus assigned portal freshness to the same on-call rotation as production policy service.

### 10.7.6 Brownfield retrofit programme

GlobalSync allocated **15% of Wave 1 engineering capacity** to agility retrofits on systems not yet scheduled for PQC migration — paying down `hardcoded_algorithm_flag` debt before Wave 3 bulk. Retrofit epics linked to CBOM `asset_id`; programme office tracked story points burned per domain. Domains below retrofit velocity targets appeared on steering agenda — not as punishment, but as capacity planning signal.

> **Dependency Alert**
>
> **Agility standards without platform golden paths produce compliance theatre.** If the easy way to ship code violates AGL-01, teams will violate AGL-01. GlobalSync moved static analysis and profile stubs into the default service template — agility became the path of least resistance.

---

## 10.8 Provider Abstraction

Provider abstraction is the implementation mechanism for policy separation. The enterprise defines a **narrow crypto provider interface**; applications depend on the interface, not on OpenSSL, BouncyCastle, or a cloud KMS SDK directly.

### 10.8.1 Interface scope

| Operation category | Interface methods (illustrative) | Behind the interface |
|--------------------|----------------------------------|----------------------|
| Asymmetric encrypt/wrap | `wrapKey`, `unwrapKey` | ML-KEM, RSA-OAEP |
| Sign/verify | `sign`, `verify` | ML-DSA, ECDSA, hybrid constructions |
| Symmetric | `encrypt`, `decrypt` | AES-GCM — agility relevant for key derivation upstream |
| Digest | `hash` | SHA-2 family; agility for pre-hash in signatures |
| Key management | `getPublicKey`, `rotate` | KMS/HSM integration (Chapter 14) |

### 10.8.2 Provider registry

| Provider ID | Implementation | Validation | Allowed environments |
|-------------|----------------|------------|----------------------|
| `aws-kms-fips` | Cloud KMS | FIPS 140-3 L3 | Production EU/US |
| `globalsync-crypto-svc` | Internal gRPC service | FIPS modules via HSM | Production |
| `openssl-3.5-lab` | OpenSSL provider | Not validated | Non-production only |

Meridian banned direct provider imports in application `pom.xml` / `csproj` — dependency scan failed builds listing non-registry crypto libraries.

**Apex NSS constraint:** Classified enclaves use a **separate provider registry** with air-gapped distribution. Commercial and NSS programmes share interface specification — not binaries. Priya Nair's architecture board rejected "one registry for everything" — accreditation boundaries are non-negotiable.

---

## 10.9 Config-Driven Algorithm Selection

Configuration-driven selection implements policy without code change. Effective patterns:

### 10.9.1 Configuration schema (illustrative)

```yaml
crypto:
  policy_profile: gs-tenant-wrap-v2
  provider_id: globalsync-crypto-svc
  hlm_phase: H1
  negotiation:
    tls:
      min_version: "1.3"
      hybrid_required: true
    fallback_allowed: false
  observability:
    emit_algorithm_labels: true
```

### 10.9.2 Configuration delivery mechanisms

| Mechanism | Hot reload? | GlobalSync usage | Northfield OT usage |
|-----------|-------------|------------------|---------------------|
| Kubernetes ConfigMap | Yes (with sidecar) | Default for microservices | No — not on plant floor |
| Service mesh control plane | Yes | Partner-facing services | No |
| Feature flags | Yes | Canary algorithm rollout | Rare |
| Signed firmware config blob | No — reboot | N/A | **Primary pattern** |
| HSM policy slot | Ceremony required | Payment HSM | Safety PLC gateways |

### 10.9.3 Configuration governance

Configuration changes are **policy events**, not informal ops tweaks:

1. Change request cites algorithm matrix row and HLM phase
2. Security architecture approval
3. Test harness run against new profile
4. CBOM row `policy_profile_id` updated
5. Production rollout with canary tenant or service slice

GlobalSync linked configuration repos to GRC — auditors traced profile `gs-tenant-wrap-v2` from policy PDF to live ConfigMap hash.

---

## 10.10 Algorithm Negotiation

Negotiation is runtime selection among **permitted** algorithms — distinct from configuration that sets local defaults. Protocols with negotiation: TLS, SSH, IPsec IKE, JOSE/JWS, CMS, OIDC token signing.

### 10.10.1 Negotiation principles

| Principle | Rationale |
|-----------|-----------|
| **Offer only policy-permitted algorithms** | Never negotiate outside the matrix — downgrade attacks |
| **Prefer hybrid when HLM phase = H1** | Chapter 5 constructions |
| **Log peer offers and selected algorithm** | Partner debugging; regulatory evidence |
| **Fail closed or degrade per fallback matrix** | Documented per system class — not engineer judgment |
| **Centralise partner-facing negotiation** | API gateway / ingress — not per microservice |

### 10.10.2 Partner negotiation (GlobalSync)

Partner mTLS blocking node required **central negotiation policy**:

| Partner tier | Server cert profile | Client cert accepted | Pilot hybrid |
|--------------|--------------------|-----------------------|--------------|
| Tier 1 (top 20) | `gs-partner-mtls-v3` | ML-DSA + ECDSA dual chain | Complete |
| Tier 2 | Classical until Q4 2027 | ML-DSA-65 if partner ready | In progress |
| Tier 3 | Classical | Classical only | Scheduled 2028 |

Microservices terminated TLS at the mesh ingress — negotiation happened once, not two hundred times. Marcus Chen credited this with reducing partner test matrix from combinatorial explosion to **one gateway qualification per tier**.

### 10.10.3 Tenant negotiation

SaaS tenants occasionally mandated specific algorithms in contracts. GlobalSync's profile inheritance model mapped contract clauses to **profile IDs** — not to custom code paths. Legal reviewed profile definitions; engineering deployed configuration.

### 10.10.4 Downgrade resistance

Negotiation logic must resist **downgrade attacks** — peers offering classical-only when policy requires hybrid. Implementation pattern:

1. Policy service returns ordered offer list (hybrid first when H1)
2. Negotiation handler intersects peer offers with policy list
3. Empty intersection → fail closed (no silent classical fallback unless fallback matrix explicitly permits)
4. Log full offer/answer for forensic review

Meridian's penetration test team included downgrade scenarios in annual assessment — finding one microservice that accepted ECDSA when profile mandated hybrid triggered Sev-2 remediation and SDLC gate review of all services sharing that library version.

### 10.10.5 Message-layer negotiation (JOSE/CMS)

Application protocols carry algorithm identifiers in headers — `alg` in JWS, `AlgorithmIdentifier` in CMS. Agility standards require **profile-resolved algorithm lists** in signing middleware, not per-endpoint hardcoding. GlobalSync's API gateway validated outbound `alg` against active profile before release — misconfigured services failed in staging, not at partner production boundary.

---

## 10.11 Meridian: SDLC Gates for Agility

Meridian embedded agility in **SDLC stage gates** — architecture standards with teeth, not wiki guidance.

### 10.11.1 Gate map

| SDLC stage | Agility gate | Approver | Blocking? |
|------------|--------------|----------|-----------|
| **Concept** | Crypto touchpoint identified; workload class assigned | Business architect | Yes if missed → rework |
| **Design** | ADR with NFR IDs; profile selection; CDG impact | Security architecture | Yes |
| **Build** | AGL-01 static analysis clean; provider registry only | CI pipeline | Yes — merge blocked |
| **Test** | Agility test harness pass; negotiation integration tests | QA + crypto engineering | Yes |
| **Pre-prod** | CBOM row draft; HLM phase confirmed | Programme office | Yes for regulated |
| **Production** | CBOM row live; DORA evidence packet | Change advisory board | Yes |

### 10.11.2 Architecture review checklist (abridged)

- [ ] No algorithm string literals in application code (AGL-01)
- [ ] Policy profile ID documented in ADR
- [ ] Provider from registry only
- [ ] HLM phase ≥ policy minimum for workload class
- [ ] Substitution window exercise completed or scheduled
- [ ] CBOM `asset_id` reserved
- [ ] Exception register entry if Tier < 2

**Thomas Bergström's regulatory insight:** DORA examinations review **change management** for ICT systems supporting critical functions. SDLC gates producing signed evidence — ADR, test report, CBOM update — satisfy Article 6 encryption policy better than post-hoc compliance narratives.

> **Regulatory Lens**
>
> DORA RTS Article 6 requires encryption policies based on ICT risk assessment. Supervisory reviewers ask whether enterprises can **change** algorithms when risk changes — not merely whether today's algorithms are strong. Agility NFRs with verified substitution windows demonstrate **operational** policy, not static PDF compliance. Meridian's SDLC gate artefacts are examination-ready evidence.

### 10.11.3 Legacy exemption path

Meridian did not pretend legacy systems met Tier 3. Systems below Tier 2 entered the **exception register** (Chapter 5) with sunset dates and wave assignment — permanent exemption was unavailable for regulated workloads.

### 10.11.4 Internal audit sampling

Meridian internal audit sampled **five production releases per quarter** for agility gate evidence — ADR, harness artefact, CBOM update, change ticket cross-reference. Findings in 2027 Q2: 2/5 releases missing harness artefact attachment; CAB process strengthened to block closure without evidence link. Audit findings became **programme metrics**, not security team private shame — Thomas Bergström reported resolution rate to board risk committee.

### 10.11.5 Procurement gate alignment

Meridian procurement added agility clauses to **custom development SOWs**: deliverables must reference NFR IDs; acceptance testing includes harness profile coverage; vendor code subject to AGL-01 scan. Third-party vendors initially pushed back — Meridian provided profile catalogue and test harness container image as contract exhibit. Two vendors achieved compliance within one sprint once given concrete artefacts rather than abstract "PQC-ready" language.

---

## 10.12 Apex: NSS Agility Constraints

Apex Defense Technologies operates **dual tracks** (Chapter 5): NSS CNSA 2.0 floors for classified programmes; NIST IR 8547 for corporate IT. Agility standards must respect accreditation boundaries.

### 10.12.1 NSS agility rules

| Rule | NSS enclave | Corporate IT |
|------|-------------|--------------|
| Policy namespace | `apex-nss-*` profiles | `apex-corp-*` profiles |
| Parameter floor | ML-KEM-1024, ML-DSA-87 | ML-KEM-768 default; elevation criteria apply |
| Provider registry | Air-gapped; separate release cycle | Enterprise cloud + HSM |
| Negotiation | Restricted; pre-approved partner list | Standard partner tiers |
| Substitution window | NSS change control board approval | 30–90 days |
| Agility tier target | Tier 3+ new; Tier 2 retrofit minimum | Tier 3+ new development |

**Priya Nair's mandate collision resolution (Chapter 1):** NSS programmes cannot wait for corporate IT ecosystem readiness — but NSS **interfaces** with corporate systems at documented boundaries. Interface contracts specify algorithm profiles both sides implement; CDG edges carry `negotiation_profile` attributes.

### 10.12.2 Contingency algorithm activation

Apex policy (Chapter 4) requires contingency algorithms (FN-DSA, HQC) activatable through **policy amendment** without programme recharter. NSS implementation: pre-approved contingency profiles exist in policy service but remain **disabled** until CISO board activation — implementation separation ensures activation is configuration, not emergency coding.

> **Architect's Decision**
>
> **NSS and commercial programmes share interface specifications, not policy profiles.** Forcing one profile namespace across classification boundaries creates accreditation rework. Apex maintains parallel policy namespaces with **mapped equivalence** at integration gateways — the gateway translates profiles; applications do not span boundaries directly.

---

## 10.13 Northfield: OT Agility Limitations

Northfield Energy Systems illustrates **honest agility ceilings** — OT cannot adopt SaaS microservice patterns on eighteen-month timelines.

### 10.13.1 OT constraints

| Constraint | Impact on agility | Mitigation |
|------------|-------------------|------------|
| Firmware-signed config only | No hot reload; Tier 2 maximum per cycle | Dual-signature firmware (Chapter 6) |
| Fixed cipher suites on legacy fieldbus | Gateway translation layer | Blocking node qualification |
| Vendor roadmap dependency | Substitution window = vendor release | Contractual algorithm timeline clauses |
| Plant downtime windows | Testing limited to maintenance | Pre-staged firmware in lab harness |
| Safety certification | Re-cert per crypto change | Batch crypto changes per refresh |

### 10.13.2 Northfield gateway pattern

Northfield's OT gateway (Chapter 8 CDG) implements **Tier 2 agility within firmware**:

- **Policy**: algorithm matrix row `northfield-ot-gateway-v1` in enterprise policy
- **Configuration**: signed config blob in firmware partition B
- **Implementation**: verified bootloader loads config; crypto module reads allowed cipher table

James Whitfield's team rejected cloud policy-pull — air-gapped plants cannot phone home for algorithm updates. Configuration changes ride **firmware releases** with nine-month lead times — wave plan accounts for this (Chapter 9 Wave 4 OT long-tail).

### 10.13.3 WAN concentrator exception

Northfield's WAN VPN concentrators (Wave 1) achieved **Tier 3** — enterprise-owned Linux appliances with config-driven IKE negotiation. OT field devices remained Tier 0–1. **Do not conflate OT agility tiers** within one programme narrative; CDG nodes carry per-device-class tiers.

> **Dependency Alert**
>
> **Applying IT agility NFRs verbatim to OT produces false compliance.** Northfield's programme office tags OT CBOM rows with `agility_ceiling` — maximum achievable tier per device class. Steering committee reviews ceilings annually as vendor roadmaps evolve — not as punishment for "low scores."

---

## 10.14 The Enterprise Crypto Agility Test Harness

A test harness proves substitution works — agility NFRs without automated verification decay into checkbox compliance.

### 10.14.1 Harness components

| Component | Purpose | GlobalSync implementation |
|-----------|---------|---------------------------|
| **Profile matrix runner** | Execute crypto operations for every approved profile | CI job `crypto-agility-verify` |
| **Round-trip tests** | Encrypt/sign → decrypt/verify across algorithms | JUnit / pytest parametrisation |
| **Negotiation simulator** | TLS/JWS handshake with peer profile variants | Containerised test peers |
| **Performance baseline** | Regression on latency/CPU for PQC sizes | Benchmark gate (warning, not block) |
| **Validation module check** | Confirm FIPS module path in production profile | CMVP certificate lookup |
| **Failure injection** | Unsupported algorithm, downgrade attempt, expired cert | Resilience verification |

### 10.14.2 Harness execution model

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│ Policy service  │────>│ Profile manifest │────>│ Test runner     │
│ (profiles)      │     │ (all active)     │     │ (parametrised)  │
└─────────────────┘     └──────────────────┘     └────────┬────────┘
                                                            │
                    ┌───────────────────────────────────────┘
                    v
           ┌────────────────┐     ┌────────────────┐
           │ Pass → artefact│     │ Fail → block   │
           │ stored in GRC  │     │ SDLC gate      │
           └────────────────┘     └────────────────┘
```

**Meridian** required harness artefacts for DORA change records — PDF test summary attached to production change tickets. **GlobalSync** stored artefacts in object storage with SHA-256 integrity for auditor retrieval.

### 10.14.3 Harness data sets and key material

Test harnesses require **non-production key material** — never copy production HSM keys into CI. Patterns:

| Key source | Usage | Risk control |
|------------|-------|--------------|
| CI-generated ephemeral keys | Unit round-trips | Destroyed post-job |
| Lab HSM partition | Integration tests | Network isolated |
| Vendor test vectors | Algorithm correctness | Public NIST/KAT vectors |
| Anonymised prod-shaped certs | Size/parse testing | Strip identifying metadata |

Apex NSS harnesses ran in classified lab enclaves — results summarised for commercial programme office without exporting key material. Summary artefacts satisfied gate evidence; raw logs remained in enclave.

### 10.14.4 Performance regression gates

GlobalSync set **warning thresholds** at 25% latency increase for signing operations when moving H0→H1 profiles — not merge-blocking, but mandatory performance ADR if exceeded. Two services triggered ADR; one adopted batch signing, one requested hardware acceleration budget. Agility standards must accommodate PQC size realities without silent production degradation.

### 10.14.5 Substitution drill

Annual **substitution tabletop**: security architecture selects a profile; engineering performs config-only change in staging; harness reruns; operations measures downtime. Drill duration must complete within NFR substitution window **S**. Failed drills trigger architecture review — not blame assignment.

---

## 10.15 CBOM Integration for Agility

Chapter 7 established CBOM schema; Chapter 10 adds agility attributes linking inventory to architecture standards.

### 10.15.1 Agility CBOM fields

| Field | Type | Example | Purpose |
|-------|------|---------|---------|
| `agility_tier` | 0–5 | `3` | Maturity model classification |
| `policy_profile_id` | string | `gs-tenant-wrap-v2` | Live policy binding |
| `provider_id` | string | `globalsync-crypto-svc` | Implementation path |
| `hlm_phase` | H0–H3 | `H1` | Lifecycle state (Chapter 5) |
| `substitution_window_days` | integer | `30` | NFR compliance |
| `hardcoded_algorithm_flag` | boolean | `false` | AGL-01 status |
| `last_harness_run` | datetime | `2027-09-14` | Verification freshness |
| `agility_exception_id` | string | `EX-2027-0042` | Link to risk acceptance |
| `agility_ceiling` | 0–5 | `2` | OT maximum (Northfield) |

### 10.15.2 CBOM-driven dashboards

| Dashboard view | Consumer | Action trigger |
|----------------|----------|----------------|
| Tier 0–1 count by domain | Steering committee | Retrofit funding |
| Hardcoded algorithm violations | Engineering VP | Merge policy enforcement |
| Harness stale > 90 days | CISO | SDLC audit |
| Profile without matrix row | Security architecture | Policy drift |
| Wave N tier compliance % | Programme director | Wave exit gate |

GlobalSync automated dashboard from CBOM — steering committee stopped debating slide-deck percentages. **Wave exit criterion example:** Wave 1 requires 95% of in-scope services at Tier 2+ with zero `hardcoded_algorithm_flag=true` in production.

### 10.15.3 CDG edge annotations

CDG nodes (Chapter 8) inherit agility attributes from CBOM rows. Blocking nodes with `agility_tier < 2` flag **structural migration risk** — dependents cannot complete HLM transitions until blocker retrofits. Chapter 9's CDG override logic applies: low MPI but high agility debt on blocking nodes still elevates wave priority.

---

## 10.16 HLM and Agility Co-Design

The **Hybrid Lifecycle Model** (Chapter 5) governs *which* algorithms run in each phase; agility governs *how easily* phases change.

| HLM phase | Agility requirement | Configuration pattern |
|-----------|---------------------|----------------------|
| **H0** (classical) | Tier 2+ for new; profile IDs assigned even if classical-only | `hlm_phase: H0` in config |
| **H1** (hybrid) | Tier 3+; negotiation supports hybrid constructions | Dual algorithm in profile |
| **H2** (PQC-primary) | Tier 3+; classical fallback disabled per policy | Fallback matrix updated |
| **H3** (PQC-native) | Tier 3+; classical algorithms rejected at negotiation | Single-algorithm profile |

**H2 trigger enforcement:** H1 deployments without H2 trigger dates (Chapter 5) violate policy — agility enables H2 transition but programme governance must schedule it. Configuration carries `h2_trigger_date`; policy service warns at T-90 days.

**Meridian payment HSM path:** H0 classical signing until vendor module GA; profile pre-provisioned for H1 hybrid; substitution drill scheduled for module availability — agility prepared before ecosystem gate opened.

---

## 10.17 DORA, Operational Resilience, and Agility Evidence

Regulated EU financial institutions map agility to **Digital Operational Resilience Act** expectations:

| DORA theme | Agility evidence |
|------------|------------------|
| ICT risk management (Art. 6) | Algorithm matrix + risk-based profile selection |
| Change management | SDLC gates with harness artefacts |
| Encryption policies | Policy/implementation separation documented |
| Resilience testing | Annual substitution drill records |
| Third-party risk | Vendor provider registry with validation status |

Meridian's supervisory briefing positioned agility NFRs as **response capability** — when NIST deprecates an algorithm, Meridian demonstrates config-driven substitution within documented windows rather than emergency programmes.

**Assurance layer (Governance Stack, Chapter 3):** Internal audit tests random sample of production services — verifies live `policy_profile_id` matches CBOM, harness artefact current, no undeclared algorithm literals in deployed artefact (container image scan).

---

## 10.18 PQC Governance Stack — Architecture Layer

Chapter 3 introduced the five-layer Governance Stack. Chapter 10 populates the **Architecture** portion of the Programme and Policy layers:

| Governance layer | Chapter 10 artefacts |
|------------------|---------------------|
| **Strategic** | Agility tier targets in programme charter |
| **Programme** | Wave plan agility exit criteria; retrofit epics |
| **Policy** | Algorithm matrix (Ch. 4) + agility NFR template |
| **Operational** | CBOM agility fields; harness results; provider registry |
| **Assurance** | SDLC gate evidence; substitution drill records; exception register |

Architecture standards without Governance Stack placement become orphan documents — Meridian filed agility standards under Policy layer with Operational CBOM linkage, ensuring DORA evidence chain continuity.

---

## 10.18.1 Zero Trust and agility co-programming

Chapter 1 recommended embedding PQC agility in Zero Trust standards when both programmes run concurrently. Practical integration points:

| Zero Trust component | Agility requirement |
|---------------------|---------------------|
| Device identity certificates | Profile-driven issuance template; HLM phase on device cert CBOM row |
| Service mesh mTLS | Central negotiation; profile per namespace |
| API gateway | JWS/JWE profile validation |
| Secrets management | Wrap/unwrap via provider — no algorithm in app |
| Policy engine | Crypto policy service feeds authZ decisions where relevant |

Serial programme execution often fails — Zero Trust certificate renewal and PQC migration compete for PKI team capacity. **Unified profile catalogue** prevents duplicate policy definitions: Meridian's device identity and server TLS profiles share algorithm matrix rows, differing only in validity period and EKU extensions.

---

## 10.19 Anti-Patterns Catalogue

| Anti-pattern | Symptom | Remediation | Teaching org example |
|--------------|---------|-------------|----------------------|
| **Algorithm literals** | `ML-DSA-65` in source | AGL-01 static analysis; golden path templates | GlobalSync PR blocks |
| **Per-project crypto** | Teams choose libraries independently | Provider registry mandate | Meridian dependency scan |
| **Wiki-only standards** | No SDLC gate enforcement | Merge-blocking CI checks | GlobalSync Q1 baseline |
| **Config in code comments** | "Change ALGO constant to migrate" | Policy profile IDs | Apex commercial audit finding |
| **Negotiation everywhere** | Each microservice offers cipher suites | Centralise at ingress/gateway | GlobalSync partner tiers |
| **Agility without harness** | Claims Tier 3; no test proof | Mandatory `crypto-agility-verify` | Meridian pre-prod gate |
| **IT NFRs on OT** | False Tier 4 compliance | `agility_ceiling` per device class | Northfield OT review |
| **Permanent hybrid** | H1 with no H2 trigger | HLM enforcement in policy service | Chapter 5 §5.8 |
| **Single registry NSS/commercial** | Accreditation boundary violation | Parallel namespaces + gateway mapping | Apex architecture board |
| **CBOM afterthought** | Production deploy without row update | Pre-prod gate blocked | GlobalSync CMDB integration |

---

## 10.20 Retrofit Patterns for Existing Systems

New development adopts Tier 3–4; legacy estate requires **incremental retrofit** aligned to waves.

### 10.20.1 Retrofit strategies

| Strategy | When applicable | Effort | Resulting tier |
|----------|-----------------|--------|----------------|
| **Strangler facade** | Monolith with bounded crypto touchpoints | Medium | 3 |
| **Sidecar crypto proxy** | Cannot modify legacy binary | Medium-high | 2–3 |
| **KMS delegation** | Data encryption with local keys | Low-medium | 3 |
| **Ingress termination** | Protocol-layer only | Low | 2 (app layer still frozen) |
| **Replace-on-refresh** | Near end-of-life system | Low (defer) | 0 until replacement |
| **Dual-signature firmware** | OT embedded | High | 2 |

**GlobalSync strangler example:** Legacy billing service wrapped with gRPC crypto facade — application calls facade with profile ID; facade calls enterprise crypto service. Original RSA calls removed over three sprints; wave plan tracked retrofit completion per `asset_id`.

### 10.20.2 Retrofit prioritisation

Prioritise retrofits by:

1. CDG blocking node status (Chapter 8)
2. TRADE MPI (Chapter 9)
3. `hardcoded_algorithm_flag=true` in production
4. Wave assignment deadline

Do not retrofit alphabetically — **blocking leverage first**.

### 10.20.3 Cost estimation for retrofit epics

Programme offices should size retrofit work using **touchpoint counting**, not gut feel:

| Touchpoint type | Effort range (person-days, illustrative) |
|-----------------|------------------------------------------|
| Single signing call site | 2–5 |
| Entire microservice crypto layer | 10–20 |
| Monolith strangler facade | 30–60 |
| OT firmware resign + dual boot | 90–180 (vendor dependent) |

GlobalSync multiplied touchpoints by domain velocity to forecast Wave 3 capacity — steering committee approved contractor budget when internal velocity insufficient.

---

## 10.21 Cross-References and Prerequisites

| Topic | Location | Relationship to Chapter 10 |
|-------|----------|---------------------------|
| Algorithm standards matrix | Chapter 4 | Profiles reference matrix rows |
| HLM phases and H2 triggers | Chapter 5 | Configuration `hlm_phase`; substitution timing |
| Stateful signatures / firmware | Chapter 6 | OT agility ceilings; dual-signature |
| CBOM schema | Chapter 7 | Agility field extensions |
| CDG blocking nodes | Chapter 8 | Retrofit priority; negotiation centralisation |
| Wave planning | Chapter 9 | Agility tier exit criteria per wave |
| Hybrid deployment patterns | Chapter 11 | Implements profiles in protocols |
| Governance Stack | Chapter 3 | Layer placement for artefacts |

Readers entering Part IV without Part III artefacts should complete CBOM and wave plan before publishing agility standards — standards without inventory produce requirements detached from estate reality.

---

## 10.22 Platform Engineering Operating Model

Sustaining agility requires named ownership — not "everyone owns crypto."

| Role | Responsibility | GlobalSync example |
|------|----------------|-------------------|
| **Crypto governance board** | Policy profile approval; matrix updates | Monthly; CISO chair |
| **Enterprise crypto service team** | Provider registry; harness maintenance | Platform engineering squad |
| **Security architecture** | SDLC gate definition; ADR review | Marcus Chen's organisation |
| **CBOM custodian** | Agility field quality | Programme office |
| **Domain architects** | System-class NFR variants | EU/US region leads |

**Cadence:** Policy profiles change quarterly at most — churn destroys engineering trust. Emergency profile activation (contingency algorithm) follows CISO incident process.

### 10.22.1 Incident response when profiles fail

When production negotiation failure rates spike after profile change:

1. **Rollback configuration** via previous ConfigMap revision (GlobalSync) or firmware partition A (Northfield)
2. **Preserve logs** — peer offers, selected algorithms, error codes
3. **Freeze profile promotion** until harness and partner retest complete
4. **CBOM annotate** incident linkage on affected rows
5. **Post-incident review** — distinguish policy error vs implementation bug vs partner incompatibility

Marcus Chen's team ran one profile rollback in 2027 — partner tier misconfiguration, not algorithm weakness. Rollback completed in eleven minutes because configuration was version-controlled; services using algorithm literals would have required emergency release.

---

## 10.23 Agility Metrics for Steering Committee

| Metric | Definition | Target (illustrative) |
|--------|------------|----------------------|
| **Agility coverage** | % in-scope CBOM rows at Tier 2+ | 80% by Wave 2 exit |
| **Violation half-life** | Days to remediate hardcoded algorithm findings | < 30 days |
| **Harness freshness** | % production rows with harness < 90 days | 95% |
| **Profile drift** | Live config ≠ CBOM profile | 0 critical |
| **Substitution drill success** | Annual drill pass rate | 100% regulated systems |
| **Gate bypass count** | Production deploys without agility gate | 0 |

Meridian added agility coverage to PQ-ADAPT self-assessment — Level 3 requires demonstrable metrics, not standards PDF existence.

---

## 10.24 Editorial Consistency with Programme Artefacts

Architecture standards fail when published in isolation from Part III inventory. GlobalSync's agility rollout required:

| Programme artefact | Architecture response |
|--------------------|----------------------|
| CBOM `asset_id` | Every NFR cites inventory row |
| CDG blocking node | Retrofit priority; centralise partner negotiation |
| Wave plan membership | Level 3 checklist scoped to Wave 0–2 first |
| TRADE E score | Gates production profile activation |

Meridian linked agility SDLC gates to **DORA ICT risk register** — each gate produced evidence artefact Thomas Bergström's team could map to supervisory templates without re-authoring documentation per examination.

> **Regulatory Lens**
>
> DORA expects ICT risk management tools, methods, processes, and policies to support **technological resilience** — including the ability to adapt cryptography as threats evolve. Crypto-agility NFRs are not advanced engineering preferences; they are structural evidence that the enterprise can execute algorithm transition without uncontrolled outage. Agility without CBOM linkage fails the evidence test — supervisors ask *which systems* comply, not *whether a standard exists*.

---

## 10.25 Figure Production Brief — Agility Layer Model

**Figure 10.1** (§10.3): Three-layer stack diagram — Policy (governance board), Configuration (profiles/ConfigMaps), Implementation (provider interface → applications). Show HLM phase as horizontal band across policy layer. Annotate GlobalSync microservice calling provider with profile ID; contrast anti-pattern of algorithm literal in code sidebar.

**Figure 10.2** (§10.14): Test harness data flow from policy service through profile manifest to CI gate — pass/fail branches to GRC artefact store.

---

## 10.26 PQ-ADAPT Level 3 Exit Checklist

Before declaring Level 3 (*Architected*) for agility workstreams, programme office confirms:

- [ ] Crypto-agility NFR template published with system-class variants
- [ ] Provider registry operational with validation status
- [ ] Policy profile catalogue aligned to algorithm matrix (Chapter 4)
- [ ] SDLC gates active — not draft checklists
- [ ] Enterprise test harness integrated in CI for Wave 1+ systems
- [ ] CBOM agility fields populated for ≥ 80% in-scope rows
- [ ] Agility tier assessed per domain; ceilings documented for OT
- [ ] NSS/commercial namespace separation if applicable (Apex)
- [ ] Substitution drill scheduled within 12 months
- [ ] Steering committee agility metrics on dashboard

GlobalSync declared Level 3 agility workstream complete Q3 2027 — hybrid TLS production (Level 4 prep) proceeded under Chapter 11 patterns using profiles defined here.

---

## 10.27 Apply in Your Organisation

1. **Publish the three-layer model** (policy / configuration / implementation) as enterprise architecture principle — one page, board-visible.
2. **Adopt the master NFR template** (§10.5) with substitution windows per system class.
3. **Create policy profile catalogue** linked to Chapter 4 algorithm matrix — no duplicate parameter decisions.
4. **Mandate provider abstraction** — ban direct crypto library imports in application code.
5. **Build or procure config schema** for `policy_profile_id` and `hlm_phase` on all crypto-touching services.
6. **Centralise partner-facing negotiation** at gateway tier — microservices inherit, do not re-negotiate.
7. **Integrate static analysis** for algorithm literals (AGL-01) in CI merge gates.
8. **Deploy enterprise test harness** — parameterised profile matrix runner before production agility claims.
9. **Extend CBOM schema** with agility fields (§10.15); automate dashboard for steering committee.
10. **Document OT agility ceilings** honestly — Tier 2 with firmware path beats fictional Tier 4.
11. **Schedule annual substitution drill** — measure against NFR window **S**.
12. **Complete Level 3 exit checklist** (§10.26) before Chapter 11 hybrid deployment at scale.

---

## 10.28 Chapter Summary

- Cryptographic agility is **separation of policy from implementation** — the architectural foundation of migration-ready systems.
- **ARCS Decide** and **PQ-ADAPT Level 3** require agility NFRs embedded in SDLC, not wiki guidance.
- The **agility maturity model** (Tiers 0–5) classifies estate readiness; CBOM rows carry `agility_tier` and `agility_ceiling`.
- **Policy profiles** stabilise application configuration while algorithms change under HLM governance (Chapter 5).
- **GlobalSync** demonstrated platform-wide standards: provider registry, config-driven profiles, centralised negotiation, CI test harness.
- **Meridian** embedded agility in SDLC gates with DORA-aligned evidence artefacts.
- **Apex** maintained separate NSS/commercial policy namespaces with gateway equivalence mapping.
- **Northfield** documented honest OT agility ceilings — firmware-signed config, not cloud policy pull.
- **Anti-patterns** — especially algorithm literals and wiki-only standards — produce synchronisation failures Part I warned against.
- **CBOM integration** connects architecture standards to inventory, wave exit criteria, and CDG blocking analysis.

**Next:** Chapter 11 — Hybrid Deployment Patterns — implements HLM-governed constructions in TLS, VPN, code signing, and application-layer cryptography using the profiles and provider abstractions defined here.

---

*Chapter 10 — References*

- Barker, W., & Dang, Q. (2024). *NIST IR 8547 (Initial Public Draft)* — Transition to post-quantum cryptography standards. National Institute of Standards and Technology.
- National Institute of Standards and Technology. (2024). *FIPS 203* (ML-KEM), *FIPS 204* (ML-DSA), *FIPS 205* (SLH-DSA). U.S. Department of Commerce.
- National Institute of Standards and Technology. (2024). *SP 1800-38* — Migration to post-quantum cryptography (informative practice guide).
- European Parliament and Council. (2022). *Digital Operational Resilience Act (DORA)* — Regulation (EU) 2022/2554; RTS 2024/1532 on ICT risk management tools, methods, processes, and policies.
- CycloneDX Contributors. (2024). *CycloneDX Cryptographic Bill of Materials (CBOM) specification*. OWASP Foundation.
- McKay, K., & Cooper, D. (2023). *Cryptographic Agility and Post-Quantum Readiness*. NIST Computer Security Resource Center (presentation and guidance materials).
- Internet Engineering Task Force. (2024–2026). Post-quantum hybrid TLS and CMS drafts — monitor for negotiation profile updates.
- Campbell, P. (2025). Enterprise post-quantum migration timeline analysis. *Industry synthesis*.
- GlobalSync Logistics / Meridian Mutual Bank programme office. (2027). *Illustrative crypto-agility standards and SDLC gate evidence* (composite case study).
- OWASP. (2024). *Application Security Verification Standard* — cryptographic controls and configuration management (cross-reference for SDLC gate design).

---

*Proceed to Chapter 11: Hybrid Deployment Patterns.*
