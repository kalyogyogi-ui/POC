# Chapter 7
# Cryptographic Discovery and the CBOM

---

Six months into Meridian Mutual Bank's post-quantum programme, Elena Vasquez received a slide from procurement claiming **94% PQC readiness** across the vendor application estate. The statistic measured vendors who had answered "yes" or "roadmap" on a questionnaire — not systems whose algorithms, keys, or dependencies were inventoried.

Elena forwarded the slide to the programme office with one question: *"Which 14,200 assets are these percentages based on?"*

Silence followed. The bank had certificates in a PKI database, applications in a CMDB, and contracts in procurement — but no **authoritative cryptographic inventory**. Phase 1's mission became explicit: build a Cryptographic Bill of Materials that could answer her question with evidence, not optimism.

The procurement slide incident became a programme origin story — Elena cited it in every Phase 1 steering meeting. The narrative was not embarrassment but **alignment**: security, procurement, and engineering needed one inventory language before debating algorithms or timelines. Fourteen months later, Meridian's CBOM contained **14,200 cryptographic assets** across applications, HSM partitions, API gateways, partner endpoints, and embedded payment modules. **38%** of assets touched third-party systems with incomplete visibility — SaaS platforms, hosted payment services, and vendor-managed HSM firmware. The CBOM did not make Meridian quantum-resilient. It made Meridian **honest** — the prerequisite for every subsequent decision in this book.

This chapter teaches how to build that honesty at enterprise scale.

The chapter progresses from CBOM purpose and PQ-ADAPT Level 2 criteria through discovery methods, schema, organisational case studies, governance, and maintenance — producing the inventory artefact that Parts IV and V consume. Readers should complete Chapter 7 with a Phase 1 discovery charter draft and minimum schema adoption plan.

---

## 7.1 The CBOM as System of Record

Part I argued that migration is a synchronisation problem. Part II defined algorithm standards and hybrid policy. Neither executes without knowing **what exists**. The Cryptographic Bill of Materials (CBOM) is the programme's cryptographic system of record — the artefact that answers:

- Which algorithms protect which data?
- Where are keys generated, stored, and used?
- Which assets are quantum-vulnerable today?
- Which third parties participate in cryptographic operations?
- What is unknown or estimated versus verified?

The CBOM is not a one-time spreadsheet. It is a **maintained dataset** with ownership, update cadence, quality metrics, and integration into change management — the Operational layer of the PQC Governance Stack (Chapter 3).

| Inventory type | What it captures | What it misses |
|----------------|------------------|----------------|
| Certificate inventory | X.509 certs, expiry, CA | APIs using non-TLS crypto; HSM keys; firmware signing |
| CMDB / asset register | Servers, apps, owners | Algorithms, key lengths, libraries |
| Network scan (SSL/TLS) | External ciphersuites | Internal east-west; app-layer wrapping; OT |
| Vendor questionnaires | Roadmap assertions | Production reality; version-level detail |
| **CBOM** | **Crypto implementations, keys, deps, algorithms** | **Requires discovery investment to populate** |

> **Migration Moment**
>
> *"We have a certificate inventory — isn't that enough?"*
>
> Certificates are one cryptographic artefact. Enterprises also operate application-layer RSA encryption, HSM key ceremonies, firmware signing chains, database field encryption, mutual TLS with partners, and JWT signing with embedded keys. Certificate inventory alone is the visible tip of Chapter 1's dependency iceberg.

---

## 7.2 PQ-ADAPT Level 2: Inventoried

Enterprises frequently overclaim inventory maturity. PQ-ADAPT Level 2 is deliberately **narrow** — visibility with documented limits, not migration execution. Steering committees should treat Level 2 as a **gate** before funding wave planning (Chapter 9), not as a programme completion milestone.

PQ-ADAPT Level 2 (*Inventoried*) requires:

- CBOM baseline covering defined scope (target ≥80% verified coverage of in-scope assets)
- Quantum-vulnerable assets flagged with algorithm and parameter set
- Data classification or confidentiality horizon mapped to high-value assets
- Discovery methodology documented — what was scanned, what was excluded, why
- Named CBOM owner and quarterly update cadence

Level 2 does **not** require migration execution, hybrid deployment, or architecture standards — only **visibility**. Many enterprises overclaim Level 3 because a policy names ML-KEM while the CBOM is empty. Level 2 is an honest inventory gate.

**Failure mode:** Perpetual discovery — endless scanning without baseline declaration. **Exit:** Steering committee accepts baseline with documented coverage gaps and unknown bucket.

---

## 7.3 Application-Layer and Non-TLS Cryptography

Enterprises over-index on TLS because network scanners are mature. CBOM must also capture **application-layer** cryptography:

| Pattern | Discovery method | Meridian gap found |
|---------|------------------|-------------------|
| JWT signing (RSA, ECDSA) | SAST; code review | 340 microservices |
| Field-level DB encryption | DBA interview; config | 89 production databases |
| Message queue signing | Architecture review | 12 payment topics |
| Backup encryption | Backup vendor API | 6 enterprise backup pools |
| API payload encryption (JWE) | Static analysis | 45 partner integrations |

Elena's procurement "94% ready" statistic excluded all application-layer rows — TLS-only discovery would have missed **41%** of quantum-vulnerable PKC in regulated workloads (*illustrative internal analysis*).

**JWT case:** Tokens signed with RSA-2048 do not appear in certificate inventory. Static analysis rules flagged `RS256` and `ES256` in Node.js and Java services. Each received CBOM row with `asset_type=application_signing` distinct from TLS cert rows.

**Database TDE:** Transparent data encryption keys often live in KMS — cloud API discovery captured AWS KMS and Azure Key Vault algorithms; on-premise Oracle TDE required DBA workshops.

> **Dependency Alert**
>
> **Application-layer crypto is the largest discovery gap in mature enterprises.** If your Phase 1 tranche is only network scan plus certificate export, plan a dedicated application tranche before declaring Level 2.

---

## 7.4 CycloneDX and CBOM Structure

CycloneDX is the dominant machine-readable standard for security bills of materials, with cryptographic extensions suitable for enterprise CBOM programmes. A CBOM component typically includes:

| Field category | Examples | Programme use |
|----------------|----------|---------------|
| Identity | `bom-ref`, name, version | Unique asset reference |
| Algorithm | ML-KEM-768, RSA-2048, ECDSA-P256 | Quantum-vulnerable flag |
| Asset type | application, library, hsm, certificate, firmware | Coverage reporting |
| Location | hostname, cloud region, OT site | Scope segmentation |
| Owner | team, business unit | Wave assignment |
| Data classification | PCI, PII, OT, public | TRADE Threat input |
| Third-party | vendor, SaaS, partner | Dependency risk |
| HLM phase | H1, H2, H3 (Chapter 5) | Transition tracking |
| Validation | FIPS 140-3 module ID | Ecosystem readiness |
| Confidence | verified, inferred, unknown | Quality metric |

Meridian normalised all discovery outputs to CycloneDX JSON — enabling merge from static analysis, cloud APIs, and manual OT surveys into a single repository. GlobalSync embedded CBOM generation in CI/CD — components emitted on each build.

This book does not reproduce the CycloneDX schema. Architects should reference the CycloneDX Authoritative Guide and cryptographic profile extensions. Programme success depends on **consistent fields**, not format religion — JSON, database tables, or GRC platform records work if attributes align.

**Figure 7.1 — CBOM Discovery Architecture**

```
  Sources                    Aggregation              Consumers
  -------                    -----------              ---------
  Static analysis (SAST) ----\
  Binary / container scan ------> CBOM repository ----> TRADE scoring
  Certificate transparency ----/        |               CDG construction
  Cloud KMS/HSM APIs -----------+       |               Regulatory evidence
  Network TLS scan -------------+       v               Board reporting
  Vendor attestations ----------+   Quality dashboard
  Manual OT surveys ------------/
```

---

## 7.5 Discovery Methods

No single discovery method covers an enterprise estate. Effective programmes combine methods with explicit coverage limits.

**Table 7.1 — Discovery Method × Asset Type Coverage**

| Asset type | Static / binary | Network scan | CMDB linkage | Cloud API | Manual survey | Vendor attestation |
|------------|----------------|--------------|--------------|-----------|---------------|-------------------|
| Web/TLS endpoints | Partial | **Strong** | Medium | Medium | Low | Low |
| Internal microservices | **Strong** | Medium | Medium | **Strong** | Low | Low |
| Third-party SaaS | Low | Partial | Medium | Low | Low | **Strong** |
| HSM / payment modules | Medium | Low | Medium | Partial | **Strong** | **Strong** |
| OT / embedded firmware | Low | Low | Low | Low | **Strong** | **Strong** |
| Mobile apps | **Strong** | Low | Medium | Low | Medium | Medium |
| Partner B2B endpoints | Low | Partial | Low | Low | **Strong** | **Strong** |
| Libraries (transitive) | **Strong** | None | Low | Medium | Low | Low |

### Static and binary analysis

Scans application source, containers, and binaries for cryptographic library usage — OpenSSL, BouncyCastle, Java crypto providers, .NET algorithms. Identifies **hardcoded algorithms** and dependency versions. Strength: finds application-layer crypto TLS scans miss. Weakness: cannot see runtime configuration or HSM offload without integration.

### Dynamic and network analysis

TLS handshakes, cipher enumeration, certificate chain inspection on live traffic. Strength: production truth for network-facing crypto. Weakness: blind to data at rest, internal app-layer wrapping, air-gapped OT.

### Cloud control plane

Cloud KMS, HSM-as-a-service, certificate manager APIs document keys and algorithms in managed services. Strength: authoritative for cloud-native estates. Weakness: customer-managed keys in VMs still need instance scanning.

### Manual and OT surveys

Engineering questionnaires, OT asset walks, vendor workshops. Strength: only path for firmware, legacy PLC, and air-gapped systems. Weakness: labour-intensive; stale quickly without process.

### Vendor and partner attestation

Contractual requirements for cryptographic disclosure — algorithms, key sizes, HSM validation. Strength: surfaces third-party obscurity. Weakness: attestation ≠ verification; requires audit sampling.

**Sample contractual language (informative, legal review required):**

> ICT provider shall supply, within ninety (90) days of contract execution and quarterly thereafter, a machine-readable cryptographic bill of materials (CycloneDX CBOM or equivalent) listing algorithms, key lengths, key custody model, and FIPS 140 validation identifiers for all cryptographic operations material to the service. Provider shall notify Customer within thirty (30) days of any algorithm deprecation affecting Customer data.

Meridian inserted this clause into renewal templates for payment and HR SaaS — reducing Tranche 4 unknown intake from 41% to 22% over six months.

### Discovery sequencing economics

Discovery tranches should follow **value of information**, not organisational convenience:

| Sequence priority | Rationale | Meridian example |
|-------------------|-----------|------------------|
| Regulated data paths first | Supervisory and TRADE Threat evidence | Payment HSM tranche |
| High fan-out third parties | Reduces obscurity multiplier | Card network, hosted payments |
| External attack surface | Visible risk; often easier scan | Tranche 1 TLS |
| Internal application estate | Volume; requires automation | Tranche 2 |
| OT and embedded | Labour-intensive; schedule early | Parallel to Tranche 3 |

Starting with easy external TLS builds momentum but can mislead executives if harder tranches are deferred. Elena insisted Tranche 3 (HSM) run parallel to Tranche 2 — blocking nodes surfaced before Wave planning.

### Coverage segmentation by workload class

Enterprises should report coverage **per segment**, not estate-wide averages:

| Segment | Meridian verified coverage (Phase 1 end) | Unknown % |
|---------|----------------------------------------|-----------|
| Retail payments | 91% | 6% |
| Corporate IT | 84% | 12% |
| Third-party SaaS | 72% | 22% |
| OT / embedded | 68% | 18% |

Aggregate 82% verified masked OT gap until segmented reporting exposed it — steering committee approved OT survey budget increase.

> **Architect's Decision**
>
> **Declare discovery scope boundaries in writing before Phase 1 begins.** Exclusions (personal devices, dormant subsidiaries, lab environments) are acceptable with documented rationale. Unscoped exclusions are how 38% third-party obscurity becomes 80% false confidence.

---

## 7.6 The Unknown Bucket

Every honest CBOM includes **unknown** — assets believed to exist but not yet verified. Meridian's Phase 1 target: ≤20% unknown by volume in regulated workloads; ≤35% in non-critical workloads.

Unknown is not failure. **Unacknowledged** unknown is failure. Unknown assets carry:

- Estimated asset class and business function
- Reason for unknown (vendor opacity, OT access, legacy documentation gap)
- Owner assigned to resolve
- Target resolution date
- Interim TRADE assumption (conservative — score Threat and Regulatory high until verified)

Elena refused to remove unknown rows from board slides — supervisors respected honesty more than false completeness.

---

## 7.7 Third-Party and SaaS Obscurity

Meridian's 38% third-party obscurity broke down as:

| Category | % of CBOM | Challenge |
|----------|-----------|-----------|
| Hosted payment processing | 14% | Vendor-managed HSM; partial attestation |
| SaaS HR and CRM | 9% | Shared tenancy; encryption whitepaper only |
| Card network integrations | 8% | Partner-controlled trust stores |
| Cloud marketplace apps | 7% | Shadow IT procurement |

Resolution paths:

1. **Contractual CBOM clauses** — supplier provides machine-readable component list or attestation quarterly
2. **DORA/third-party risk integration** — cryptographic inventory as ICT provider assessment criterion (Chapter 3)
3. **Sampling verification** — penetration test or independent cryptographic review of critical suppliers
4. **Risk acceptance** — documented unknown with compensating controls

GlobalSync inverted the problem as **provider**: published customer-facing CBOM summaries for platform cryptography — reducing customer unknown bucket for shared responsibility boundaries.

---

## 7.8 Transitive Library Dependencies

Applications import cryptography through dependency chains — `log4j` moment taught security teams that transitive dependencies matter. PQC adds the same lesson: a container base image ships OpenSSL 3.x without ML-KEM enabled; application code calls default provider; CBOM must capture **transitive** crypto stacks.

Discovery approach:

1. Container image scan at build time (CI/CD gate)
2. SBOM merge with CBOM — correlate `openssl 3.0.x` across estate
3. Flag quantum-vulnerable versions even if application team unaware
4. Assign remediation to platform engineering when base image is root cause

GlobalSync's pipeline blocked production deploy if CBOM component lacked `algorithm_family` attribute — forcing developers to classify or inherit from base image scan.

---

## 7.9 OT and Critical Infrastructure Discovery

Northfield Energy's IT discovery tools could not reach air-gapped compressor sites. OT CBOM required:

- **Asset walk** — model, firmware version, cert store size, signing vendor
- **Vendor workshops** — cryptographic architecture per device class
- **Network segmentation map** — which OT zones terminate TLS or VPN
- **Engineering workstation inventory** — signing tools and HSM attachments

James Whitfield's team added **OT extension schema** to enterprise CBOM: `device_class`, `cert_store_bytes`, `firmware_signing_scheme`, `maintenance_window`, `site_id`.

OT assets entered CBOM with `confidence=verified` only after site survey — not after CMDB inference from IT asset record.

> **Dependency Alert**
>
> **Inferring OT cryptography from IT CMDB produces false negatives.** A server record for "compressor gateway" does not reveal firmware signing algorithm, certificate store size, or LMS state management. OT requires deliberate survey investment.

---

## 7.10 CBOM Attribute Schema (Programme Minimum)

Extending Part II HLM attributes, programme CBOM minimum fields:

| Attribute | Required | Used by |
|-----------|----------|---------|
| `asset_id` | Yes | All |
| `algorithm_name` (FIPS normalised) | Yes | Policy, TRADE |
| `quantum_vulnerable` (boolean) | Yes | Reporting |
| `asset_type` | Yes | Discovery coverage |
| `owner_team` | Yes | Waves |
| `data_classification` | Yes | TRADE T, D |
| `confidentiality_horizon_years` | High-value assets | TRADE T |
| `third_party_flag` | Yes | Risk |
| `confidence` | Yes | Quality |
| `hlm_phase` | If deployed/hybrid | Chapter 5 |
| `h2_trigger_type` | If H1 hybrid | Chapter 5 |
| `h2_trigger_value` | If H1 hybrid | Chapter 5 |
| `validation_module_id` | If HSM/KMS | Chapter 4 |
| `firmware_signing_scheme` | OT/firmware | Chapter 6 |
| `last_verified_date` | Yes | Maintenance |

Meridian implemented schema in GRC platform with CycloneDX export for engineering tools.

---

## 7.11 Algorithm Normalisation

CBOM discovery outputs pre-standard names — Kyber, Dilithium, ECDSA. Enterprise reporting requires FIPS normalisation (Chapter 4):

| Discovery label | Normalised CBOM value |
|-----------------|----------------------|
| CRYSTALS-Kyber-768 | ML-KEM-768 |
| Dilithium3 | ML-DSA-65 |
| RSA-2048 | RSA-2048 (quantum_vulnerable=true) |
| ECDSA P-256 | ECDSA-P256 (quantum_vulnerable=true) |
| unknown | unknown (trigger survey) |

Automated normalisation rules reduced manual cleanup by **60%** in Meridian Phase 1 (*illustrative*). Rules require maintenance when NIST publishes updates.

---

## 7.12 Privacy, Classification, and CBOM Field Handling

CBOM rows describe sensitive infrastructure. Programme policy must address:

| Concern | Control |
|---------|---------|
| Key material in exports | Never store private keys in CBOM — reference handles only |
| Classified attributes | `boundary_tag` segregates export filters |
| Personal data in cert SANs | Redact or hash in non-PKI consumer views |
| Partner confidential algorithms | Contractual NDA before graph merge |

Apex's NSS CBOM repository ran on classified infrastructure with **no automated export** to corporate GRC — aggregate metrics only. Corporate CBOM included commercial product signing details without NSS deliverable specifics.

GlobalSync applied **tenant-scoped views** — European tenant CBOM segments filterable for GDPR data residency evidence without exposing US tenant key metadata to EU DPO review.

Meridian classified CBOM as **Internal — Confidential** — broader than typical CMDB because rows reveal security architecture. Access limited to crypto engineering, risk, audit, and programme office.

---

## 7.13 Meridian Phase 1: Programme Execution

Elena Vasquez opened each steering committee with the same framing: Phase 1 measured **honesty velocity** — how fast unknown rows converted to verified or explicitly owned gaps — not vanity coverage percentages. That discipline prevented the procurement questionnaire incident in the chapter opening from recurring in a different guise.

Meridian's Phase 1 CBOM executed in four tranches:

**Tranche 1 (months 1–3):** External TLS and public certificates — network scan + certificate inventory merge. 2,100 assets; high confidence.

**Tranche 2 (months 2–6):** Application and data-centre estate — static analysis, container scan, CMDB linkage. 7,400 assets; mixed confidence.

**Tranche 3 (months 4–9):** Payment and HSM — vendor workshops, manual ceremony documentation. 1,800 assets; included blocking HSM firmware chain.

**Tranche 4 (months 6–14):** Third-party and SaaS — contractual attestation, DORA provider assessment integration. 2,900 assets; 41% unknown at intake, reduced to 22% by phase end.

Phase 1 budget: **€2.8 million** (*illustrative*) — tooling, contractor OT support, vendor assessment programme. Elena presented coverage curve monthly — unknown bucket shrinking, not hidden.

**Figure 7.2 — Inventory Maturity Progression**

```
PQ-ADAPT
Level 0 ──> Level 1 ──> Level 2 baseline ──> Level 2 maintained ──> Level 3 prep
Unaware    Alerted      80% verified        Quarterly updates      CDG + TRADE
           ad hoc       unknown documented   automated gates        waves approved
```

---

## 7.14 GlobalSync: Cloud-Native CBOM Pipeline

GlobalSync built CBOM generation into platform engineering:

1. **Build** — container scan emits crypto components
2. **Deploy** — cloud API enriches KMS key algorithms
3. **Run** — periodic TLS scan of production endpoints
4. **Merge** — central CBOM service deduplicates by `bom-ref`
5. **Annotate** — tenant and region tags for multinational overlay

Marcus Chen's team measured **CBOM freshness** — percentage of production services with CBOM updated within 30 days of last deploy. Target: 95%. Stale CBOM triggered change-management warning.

### GlobalSync multinational overlay

Marcus Chen's team tagged every CBOM row with `jurisdiction` and `regulatory_overlay` — enabling filtered exports for EU DORA review without re-scanning infrastructure. Overlay tags drove TRADE Regulatory dimension inputs in Chapter 9: EU tenant workloads received R score modifiers when DORA ICT provider dependencies were involved.

**Tenant isolation cryptography** received distinct CBOM rows per isolation partition — preventing false consolidation that would hide cross-tenant KMS dependencies. Platform engineering owned partition CBOM accuracy; tenant customers received summary attestations, not raw rows.

Partner mutual-TLS endpoints discovered in Tranche 3 — only 200 of 400 expected partners initially documented — foreshadowing Chapter 8's blocking node analysis. Partner endpoint discovery required **legal-approved scanning** of production B2B traffic metadata — not payload inspection.

---

## 7.15 Apex Defense: Classified and Corporate Inventory Boundaries

Apex maintained **separate CBOM repositories** for NSS and corporate IT — not for secrecy theatre, but because classification boundaries prohibit merge. Programme office reported **aggregate metrics** to board: total quantum-vulnerable asset counts per enclave, unknown percentages, wave status — without cross-classification data leakage.

Corporate CBOM fed commercial product roadmaps. NSS CBOM fed CNSA compliance evidence. **Cross-reference indices** linked shared vendors without linking asset details — enabling procurement negotiation without classification violation.

Priya Nair's architecture board rejected a proposal to "use corporate CBOM as proxy for NSS" — proxy inventory fails audit.

---

## 7.16 Data Governance, RACI, and Evidence Quality

A CBOM without governance becomes a snapshot — useful for one board meeting, useless for migration execution. Meridian assigned explicit **RACI** for CBOM operations:

| Activity | Responsible | Accountable | Consulted | Informed |
|----------|-------------|-------------|-----------|----------|
| Schema definition | Enterprise architecture | CISO | Crypto engineering, compliance | Programme office |
| Automated discovery pipelines | Platform engineering | VP Engineering | Security | App owners |
| Manual OT surveys | OT security | OT director | Vendors | Programme office |
| Third-party attestation | Vendor management | Procurement | Legal, security | Business owners |
| Quality reporting | Programme office | Programme director | Steering committee | Board risk committee |
| TRADE/CDG consumption | Risk / EA | Programme director | Security | Auditors |

**Evidence quality tiers** map to `confidence` attribute:

| Tier | Definition | Auditor treatment |
|------|------------|-----------------|
| **Verified** | Direct observation — scan, API, ceremony log | Primary evidence |
| **Inferred** | Derived from CMDB, architecture diagram, or template | Supporting evidence; requires sampling |
| **Attested** | Vendor or partner declaration without independent test | Contractual evidence; audit sampling required |
| **Unknown** | Placeholder with resolution plan | Gap disclosure; risk acceptance may apply |

> **Regulatory Lens**
>
> DORA Article 28 ICT third-party risk management expects enterprises to understand ICT service supply chains. A CBOM row for a hosted payment processor — algorithm family, key custody model, validation module — is stronger supervisory evidence than a vendor's marketing whitepaper claiming "AES-256 encryption." Thomas Bergström's team linked Meridian's CBOM exports to DORA provider assessment templates, reducing duplicate questionnaire burden.

### Conflict resolution when sources disagree

Discovery sources frequently conflict: network scan reports TLS 1.2 with ECDHE-RSA; static analysis reports BoringCastle TLS 1.3 with ML-KEM in test branch; CMDB lists deprecated server. Programme rule: **production traffic wins for runtime behaviour; source repository wins for deployable intent.**

Meridian's conflict workflow:

1. Flag row `confidence=conflicted`
2. Assign owner to reconcile within 30 days
3. If unresolved, score TRADE conservatively (Threat +1, Ecosystem −1)
4. Log resolution in CBOM audit trail

GlobalSync automated conflict detection when build-time CBOM algorithm differed from runtime TLS scan — blocking deploy until developer acknowledged drift or fixed configuration.

### CBOM quality dashboard metrics

Steering committees need trend metrics, not row counts:

| Metric | Definition | Meridian Phase 1 target |
|--------|------------|-------------------------|
| Verified coverage | % in-scope assets with `confidence=verified` | ≥80% regulated workloads |
| Unknown trend | Unknown count month-over-month | Decreasing |
| Staleness | % assets with `last_verified_date` > 90 days | <15% |
| Third-party obscurity | % assets with `third_party_flag=true` and incomplete algorithm | <25% by phase end |
| Quantum-vulnerable density | % verified assets with `quantum_vulnerable=true` | Baseline metric (not a target) |
| Schema compliance | % rows with all required attributes populated | ≥95% |

Elena presented **verified coverage curve** and **unknown resolution velocity** — supervisors responded to trajectory more than absolute percentages.

---

## 7.17 Integration with Change Management and CI/CD

CBOM maintenance succeeds when embedded in existing gates, not when assigned to a quarterly heroics exercise.

**Change ticket integration:** New systems require CBOM row creation before production approval. Meridian's ITSM workflow added mandatory fields: `cbom_asset_id`, `algorithm_name`, `quantum_vulnerable`, `hlm_phase` (if hybrid). Tickets without CBOM linkage failed CAB approval for regulated workloads.

**CI/CD gates (GlobalSync pattern):**

1. Build emits SBOM + crypto component list
2. Merge with base image CBOM
3. Policy gate: prohibited algorithms fail build
4. Deploy enriches with cloud KMS metadata
5. Post-deploy TLS scan validates runtime alignment

**Decommission hygiene:** Assets removed from production must be **archived**, not deleted — auditors ask what cryptography protected retired systems. CBOM status field: `active`, `decommissioned`, `archived`.

Northfield added OT-specific gate: firmware updates require CBOM row for signing key and algorithm before maintenance window approval — connecting inventory to James Whitfield's change control board.

---

## 7.18 SBOM and CBOM Convergence

Software Bill of Materials (SBOM) and CBOM overlap but are not identical. SBOM lists components; CBOM lists **cryptographic implementations** with algorithm parameters and key custody.

| Artefact | Primary question | Typical format |
|----------|------------------|----------------|
| SBOM | What packages are in this build? | CycloneDX, SPDX |
| CBOM | What cryptography does this system use? | CycloneDX crypto profile |

**Merge strategy:**

1. Correlate SBOM library components (`openssl`, `boringssl`, `javax.crypto`) to CBOM algorithm entries
2. Propagate version → known algorithm support (e.g., OpenSSL 3.2+ ML-KEM availability)
3. Elevate application-specific crypto (custom JWT signing) to distinct CBOM rows not inferable from SBOM alone

GlobalSync's pipeline treated SBOM as **input** to CBOM generation — not substitute. A microservice with no crypto libraries but calling Cloud KMS still received CBOM row from cloud API enrichment.

**Transitive risk aggregation:** Platform engineering owned remediation when base image `openssl 1.1.1` appeared in >40% of container CBOMs — single patch event, estate-wide impact. Without transitive visibility, each application team would have scored Ecosystem readiness independently and underestimated blocking leverage.

---

## 7.19 DORA, NIS2, and Supervisory Evidence

Part I established regulatory forcing functions. Part III operationalises them: supervisors ask *show us the inventory*.

**DORA evidence package (Meridian):**

- CBOM export filtered to ICT third-party providers
- Unknown bucket report with resolution owners
- Quarterly quality dashboard
- Mapping from CBOM `asset_id` to provider contract reference

**US critical infrastructure (Northfield):** NERC CIP and TSA expectations elevated OT inventory from "engineering documentation" to **supervisory evidence**. James presented CBOM segments by site and safety classification — linking cryptographic assets to CIP evidence requirements without claiming false precision on air-gapped devices.

**NSS / classified (Apex):** Aggregate reporting only — board saw enclave-level metrics; NSS CBOM detail remained in classified programme office. Priya's team rejected merging corporate and NSS inventories; **cross-reference index** listed shared vendors (HSM manufacturer, firmware signer) without exposing classified asset attributes.

> **Migration Moment**
>
> *"Our auditor asked for a list of quantum-vulnerable algorithms. We sent the CBOM export and the meeting ended in twenty minutes."*
>
> The CBOM ended the meeting because Meridian had spent fourteen months building it — not because inventory is easy. Organisations attempting to generate first-time CBOM exports under audit pressure produce incomplete lists that extend audit scope.

---

## 7.20 Budget, Tooling, and Team Sizing

Phase 1 discovery is a **programme investment**, not a security tool purchase. Illustrative Meridian Phase 1 breakdown (*planning example, not benchmark*):

| Category | % of €2.8M | Activities |
|----------|------------|------------|
| Tooling licences | 28% | SAST, container scan, TLS discovery, GRC integration |
| Professional services | 35% | OT surveys, integration engineering, data normalisation |
| Vendor assessment programme | 18% | Attestation templates, audit sampling, legal review |
| Internal FTE (allocated) | 14% | CBOM custodian, tranche owners, programme office |
| Contingency | 5% | Scope expansion, conflict resolution backlog |

**Team sizing heuristic:** One CBOM custodian per 8,000–15,000 assets (0.5–1.0 FTE); add 0.25 FTE OT curator per 10 major sites; platform engineering owns automation — not the programme office.

Tool selection criteria:

- CycloneDX or equivalent export
- API for merge and deduplication
- Attribute extensibility for `hlm_phase`, `confidence`, OT fields
- Integration with CMDB, ITSM, and CI/CD — not standalone spreadsheet export

---

## 7.21 Lessons from Meridian Tranche Execution

**Tranche 1 lesson:** Certificate inventory merge over-counted duplicate SANs — normalisation rules collapsed 2,800 cert rows to 2,100 unique cryptographic endpoints.

**Tranche 2 lesson:** CMDB linkage produced 1,200 `inferred` rows — sampling verification reduced false positives by 34% (*illustrative*).

**Tranche 3 lesson:** HSM vendor workshop revealed firmware signing chain undocumented in IT systems — three CBOM rows became twelve after ceremony mapping. This tranche fed Chapter 8's blocking node identification.

**Tranche 4 lesson:** Vendor questionnaires without machine-readable follow-up produced attestation theatre — contractual clause requiring CycloneDX or structured CSV within 90 days improved usable rows from 41% to 78% of third-party intake.

Elena's monthly coverage slides showed **tranche burn-down** and **unknown owners** — steering committee held tranche owners accountable when velocity stalled.

---

## 7.22 CBOM Maintenance and Ownership

| Activity | Cadence | Owner |
|----------|---------|-------|
| New system onboarding | Per change ticket | DevOps / app team |
| Automated rescan | Weekly (cloud), per build (CI) | Platform engineering |
| Third-party attestation refresh | Quarterly | Vendor management |
| OT site reverification | Annual | OT security |
| Unknown bucket review | Monthly | Programme office |
| CBOM quality report | Quarterly | Steering committee |

Without named ownership, CBOM decays within two quarters of Phase 1 completion — Meridian assigned **CBOM custodian** role (0.5 FTE) in programme office.

---

## 7.23 Conducting a Discovery Scoping Workshop

**Duration:** Full day. **Participants:** Enterprise architecture, security, PKI, OT (if applicable), cloud platform, procurement, compliance, programme office.

**Pre-work (distributed one week prior):** Draft estate boundary map; current certificate inventory export; top 20 third-party providers by criticality; known OT sites; regulatory scope summary (DORA entities, NSS enclaves, etc.).

**Agenda:**

| Block | Duration | Activity | Output |
|-------|----------|----------|--------|
| 1 | 90 min | Define in-scope boundaries and explicit exclusions (§7.4) | Scope document draft |
| 2 | 60 min | Assign discovery methods per asset class (Table 7.1) | Method × asset matrix |
| 3 | 45 min | Set coverage targets, unknown thresholds, quality metrics (§7.14) | Metric targets |
| 4 | 60 min | Agree CBOM schema minimum fields (§7.9); RACI (§7.14) | Schema + RACI sign-off |
| 5 | 45 min | Third-party attestation and contractual clauses (§7.6) | Procurement action list |
| 6 | 60 min | Draft Phase 1 tranche sequence, budget ranges (§7.18) | Tranche plan |
| 7 | 30 min | Assign tranche owners, reporting cadence, steering inputs | Named owners |

**Facilitation notes:** Procurement must attend block 5 — third-party obscurity is a contractual problem, not a scanning problem. OT representation is non-optional for energy, manufacturing, and utilities. Compliance should challenge coverage targets that sound impressive but exclude regulated workloads.

**Output:** Discovery charter — appendix to programme charter (Part V). Charter includes signed scope exclusions, tranche schedule, and baseline declaration criteria (80% verified with unknown plan).

---

## 7.24 Common CBOM Failure Modes

**Spreadsheet programme.** CBOM in Excel without automation — stale on arrival. *Remediation:* repository with API and CI integration.

**TLS-only discovery.** External scan declared complete inventory. *Remediation:* Table 7.1 gap analysis.

**Perpetual Phase 1.** No baseline declaration because coverage never reaches 100%. *Remediation:* declare baseline at 80% with unknown plan.

**Vendor questionnaire substitution.** Procurement slides replace CBOM. *Remediation:* attestation feeds CBOM rows with confidence flag.

**CMDB equality fallacy.** CMDB record equals cryptographic verification. *Remediation:* confidence field distinguishes inferred vs verified.

**Executive metric gaming.** Verified coverage calculated over easy-to-scan external TLS only. *Remediation:* segment metrics by workload class; regulated workloads separate denominator.

**Discovery without consumption.** CBOM built but never fed to TRADE or CDG. *Remediation:* Chapter 8–9 dependencies; steering committee reviews consumption artefacts.

---

## 7.25 Apply in Your Organisation

1. **Charter Phase 1 discovery** with written scope, exclusions, and coverage targets — not ad hoc scanning.
2. **Adopt minimum CBOM schema** aligned to CycloneDX or equivalent — normalise FIPS algorithm names (§7.10).
3. **Combine discovery methods** per Table 7.1 — no single method suffices.
4. **Maintain an unknown bucket** with owners and resolution dates — do not hide gaps (§7.5).
5. **Integrate third-party attestation** into DORA/vendor risk processes (§7.6, §7.17).
6. **Assign CBOM custodian**, RACI, and quarterly quality dashboard (§7.14, §7.20).
7. **Embed CBOM in change management and CI/CD** — not quarterly manual refresh alone (§7.15).
8. **Merge SBOM inputs** with application-specific crypto rows (§7.16).
9. **Declare PQ-ADAPT Level 2** only when baseline criteria in §7.2 are met.
10. **Schedule discovery scoping workshop** with procurement and OT represented (§7.21).

---

## 7.26 Executive Reporting and Board Narratives

Steering committees and boards do not need 14,200-row CBOM exports. They need **trend narratives**:

| Slide element | Content | Meridian example |
|---------------|---------|------------------|
| Coverage trend | Verified % over time by segment | 62% → 82% over 14 months |
| Unknown trajectory | Count and owner accountability | 3,200 → 1,100 unknown rows |
| Third-party obscurity | % incomplete vendor crypto | 38% → 22% |
| Quantum-vulnerable baseline | % verified QV assets | 94% of verified rows |
| Blocking preview | Top 3 CDG nodes (forward reference) | HSM, card scheme, manufacturing root |
| PQ-ADAPT level | Honest self-assessment | Level 2 achieved Q4 2026 |

Elena refused vanity metrics — "PQC readiness questionnaire %" excluded from board pack after procurement slide incident in chapter opening.

**Northfield board narrative** emphasised OT segment separately — James presented OT verified coverage (68%) without blending into IT aggregate that would have shown 81%.

---

## 7.27 CBOM and Zero Trust Programme Alignment

Zero trust initiatives often inventory identity and device posture but omit **cryptographic implementation detail**. CBOM complements zero trust:

| Zero trust pillar | CBOM contribution |
|-------------------|-------------------|
| Device trust | Firmware signing algorithms; secure boot chains |
| Identity | Token signing keys; certificate templates |
| Network | TLS versions; mTLS policies |
| Data | Field-level encryption algorithms; KMS keys |

Meridian linked CBOM `asset_id` to zero trust policy engine — device non-compliance triggered when firmware `quantum_vulnerable=true` and past policy threshold. Integration prevented parallel inventories diverging.

---

## 7.28 Discovery Tool Categories (Non-Endorsement)

| Category | Function | Coverage contribution |
|----------|----------|----------------------|
| SAST / SCA crypto rules | Source and dependency crypto | Application-layer |
| Container / binary scanners | Image crypto libraries | Transitive stacks |
| TLS / network discovery | Live protocol enumeration | Network-facing |
| Certificate lifecycle tools | PKI inventory | Certs, not app-layer |
| Cloud CSP APIs | KMS, HSM, cert manager | Cloud-native |
| GRC / CBOM platforms | Aggregation, workflow | Governance |
| Manual survey tooling | OT walks, ceremonies | Air-gapped, HSM |

Tool selection matters less than **merge discipline** and **schema consistency**. GlobalSync built merge in-house; Meridian bought GRC integration — both succeeded with CycloneDX normalisation.

---

## 7.29 Northfield Deep Dive: OT CBOM Extension

Northfield's OT extension schema became enterprise standard for field devices:

| Attribute | Example | Discovery source |
|-----------|---------|------------------|
| `device_class` | `compressor_gateway_v3` | Asset walk |
| `firmware_version` | `4.2.1` | Vendor portal |
| `cert_store_bytes` | `64` | Engineering survey |
| `firmware_signing_scheme` | `RSA-2048-PKCS` | Vendor workshop |
| `maintenance_window` | `Q3-2026` | Operations |
| `site_id` | `NORTH-PIPE-07` | OT CMDB |

James required **site_id** on every OT row — enabling wave planning by geographic maintenance crew capacity (Chapter 9). Devices with identical `device_class` rolled into CDG meta-nodes (Chapter 8) while retaining site granularity in CBOM.

**Compressor gateway lesson:** 18 sites reported identical firmware signing in vendor workshop — one CBOM template instantiated 18 times with site-specific `last_verified_date` from annual walk.

---

## 7.30 Coordinating CBOM with Part IV Architecture

Part IV implements hybrid TLS, PKI migration, and application patterns. CBOM feeds Part IV gates:

- Architecture standards reference CBOM `algorithm_name` fields — not ad hoc discovery during implementation
- Hybrid deployments update `hlm_phase` before production (Chapter 5)
- PKI migration targets issuers identified in CDG blocking analysis (Chapter 8)

Programmes attempting Part IV without Part III CBOM repeat discovery during every implementation project — multiplying cost.

---

## 7.31 Certificate Transparency and External Attack Surface

Certificate transparency logs and external attack surface management tools contribute CBOM rows for **internet-facing** cryptography — high value, incomplete alone. Meridian Tranche 1 merged CT log queries with active TLS scan:

| Source | Value | Limitation |
|--------|-------|------------|
| CT logs | Historical cert issuance visibility | May include decommissioned hosts |
| Active scan | Current cipher suites | Misses internal-only certs |
| Subdomain enumeration | Shadow IT discovery | False positives require validation |

**Shadow IT finding:** CT discovery identified 140 subdomains issuing certs outside corporate PKI — shadow SaaS integrations added to CBOM with `confidence=inferred` until vendor attestation.

Northfield used CT only for corporate IT — OT sites air-gapped from internet CT visibility. OT remained manual survey authoritative.

---

## 7.32 HSM and Key Ceremony Documentation

HSM keys rarely appear in network scans. CBOM population requires **ceremony documentation**:

| Ceremony element | CBOM field | Owner |
|------------------|------------|-------|
| Key generation date | `key_origin_date` | Crypto ops |
| Algorithm and size | `algorithm_name` | Crypto ops |
| HSM partition ID | `hsm_partition` | Crypto ops |
| Dual control policy | `ceremony_policy_ref` | Security |
| Quantum vulnerability | `quantum_vulnerable` | Programme office |

Meridian Tranche 3 workshops produced **ceremony binders** scanned to evidence repository — CBOM row links to binder URI, not key material. Apex NSS ceremonies classified — NSS CBOM rows reference classified evidence index.

**Payment HSM partition** contained three logical keys — firmware signing, PIN encryption, key wrapping — each distinct CBOM row sharing physical HSM asset parent. Parent-child CBOM linking prevented treating HSM as monolithic "secure box."

---

## 7.33 Sampling Verification Methodology

Inferred rows require **statistical sampling** before steering committee accepts verified coverage metrics:

| Population | Sample size (illustrative) | Pass criterion |
|------------|---------------------------|----------------|
| < 100 inferred rows | 20% | 95% algorithm match |
| 100–1000 | 10% | 95% match |
| > 1000 | 5% min 50 | 95% match |

Failed sample triggers tranche re-scan for asset class. Meridian's Tranche 2 sample failure on container crypto — 12% algorithm mismatch — led to upgraded SAST rules before baseline declaration.

---

## 7.34 Programme Office CBOM Operating Rhythm

Meridian programme office ran **monthly CBOM cadence**:

| Week | Activity |
|------|----------|
| 1 | Unknown bucket review — owners report resolution progress |
| 2 | Quality metrics refresh — dashboard to steering inputs |
| 3 | Third-party attestation chase — procurement escalation |
| 4 | Tranche burn-down — coverage vs plan |

Quarterly steering committee received **one decision request** — approve baseline revision, approve OT survey budget, or accept unknown risk — not informational-only review.

Elena credited operating rhythm with sustaining Level 2 past Phase 1 — programmes that treat CBOM as project deliverable decay; programmes that treat CBOM as operational metric persist.

---

## 7.35 API Gateways and Cryptographic Aggregation

API gateways terminate TLS, validate JWTs, and re-encrypt toward backends — one gateway row in CMDB can represent **dozens of cryptographic roles**. CBOM programmes must decide aggregation rules:

| Modelling choice | When appropriate | Risk |
|------------------|------------------|------|
| One row per gateway instance | Capacity planning | Hides per-route algorithms |
| One row per route/backend | Fine-grained TRADE | CBOM explosion |
| One row per crypto function on gateway | Balance | Requires gateway config export |

Meridian chose **function-level** rows for payment API gateways — separate rows for `tls_termination`, `jwt_validation`, `request_signing` on the same hardware cluster. Discovery sourced from gateway policy export plus network scan cross-check.

GlobalSync service mesh sidecars received **one CBOM row per mesh identity** — sidecar cert algorithm captured; backend application crypto captured separately. Aggregation would have double-counted TLS (sidecar + ingress) without `crypto_layer` attribute distinguishing edge vs service.

**JWT at gateway:** Gateways validating RSA-signed JWTs while backends use ECDSA created CBOM conflict — resolved by treating gateway as **verification consumer** with `trusts` edge to issuer key (feeds Chapter 8), not as signing implementation.

---

## 7.36 Mobile, IoT, and Edge Device Discovery

Mobile applications and IoT devices carry cryptography outside data-centre discovery reach:

| Asset class | Discovery approach | CBOM confidence |
|-------------|-------------------|-----------------|
| iOS/Android apps | Binary analysis; app store build pipeline | Verified at release |
| MDM-managed devices | MDM cert profiles API | Inferred until sample |
| IoT fleet | Vendor model catalogue + site survey | Verified per site |
| CDN edge | Provider attestation + config API | Attested |

Meridian retail banking app — static analysis of release binaries found **certificate pinning** to corporate root plus backup pin to legacy root scheduled for removal. Pinning configuration became CBOM row `asset_type=mobile_pinning` — migration required app release, not server TLS change alone.

Northfield IoT **did not** use mobile patterns — embedded devices documented per `device_class` template. Template covered 18 compressor gateway sites with identical firmware crypto profile — efficient CBOM without 18 separate engineering interviews for identical stacks.

> **Architect's Decision**
>
> **Separate mobile CBOM lifecycle from server CBOM.** App release trains differ from server deploy cadence. Force mobile rows into server change tickets and updates stall — assign mobile product owner as CBOM responsible party.

---

## 7.37 Worked Example: Single Payment Microservice CBOM Rows

Illustrative decomposition for `payments-authorization-svc` — one microservice, multiple CBOM rows:

| bom-ref | asset_type | algorithm_name | quantum_vulnerable | confidence |
|---------|------------|----------------|-------------------|------------|
| pay-auth-001 | tls_termination | ECDSA-P256 / TLS1.3 | true | verified |
| pay-auth-002 | jwt_signing | RSA-2048 | true | verified |
| pay-auth-003 | db_field_encrypt | AES-256-GCM | false | verified |
| pay-auth-004 | kms_wrap | RSA-2048-OAEP | true | inferred |
| pay-auth-005 | partner_mtls | ECDSA-P256 | true | verified |

Roll-up for executive reporting: one workload. TRADE scoring and CDG construction use **fine-grained rows** — jwt_signing row linked to enterprise JWT issuer CDG node; partner_mtls row linked to `partner-mtls-policy-v3` blocking hub.

This pattern prevented Meridian from declaring the microservice "TLS migrated" when only `pay-auth-001` upgraded — partial migration visible in CBOM, not hidden in green dashboard status.

---

## 7.38 M&A and Divestiture CBOM Handling

Acquisitions inject cryptographic inventory faster than integration teams can verify. Meridian subsidiary acquisition (*illustrative*):

**Day 0:** Inherited 2,100 CBOM rows from seller questionnaire — `confidence=attested`, 62% `quantum_vulnerable`.

**Day 30:** Sample verification on payment paths — 18% algorithm mismatch vs attestation.

**Day 90:** Integrated tranche — seller rows merged with namespace prefix `sub-acq-`; duplicates deduplicated against existing card network rows.

**Divestiture:** Carve-out requires **CBOM export slice** by business unit tag — rows without `business_unit` attribute could not be separated. Post-acquisition lesson: mandatory `business_unit` on all new rows.

---

## 7.39 Communicating Discovery Results to Engineering

Engineering teams resist CBOM when perceived as audit overhead. Effective communication:

1. **Lead with blocking insight** — "Your service trusts partner policy X; here is the fan-in" — not "fill algorithm field."
2. **Provide remediation path** — link row to Wave plan and architecture standard (Part IV preview).
3. **Automate first** — CI/CD gates before manual surveys.
4. **Celebrate coverage** — domain leaderboard on verified % — GlobalSync internal hackathon on CBOM freshness.

Marcus Chen tied CBOM schema compliance to **deployment velocity** — compliant repos deployed faster through expedited CAB — incentive alignment reducing friction.

---

## 7.40 Shadow IT and Cryptographic Surprise

Shadow IT produces **cryptographic surprise** — systems processing regulated data with algorithms unknown to security. Meridian CT and DNS log analysis identified:

- **14 shadow SaaS integrations** with OAuth and embedded RSA JWT signing
- **6 engineering teams** running self-signed mTLS internal tools in production
- **3 acquired-skill shadow APIs** bypassing corporate API gateway

Each shadow system received CBOM row with `confidence=inferred`, `owner=unknown` until procurement or HR identity linkage resolved business owner. Shadow rows **counted against unknown bucket** — incentivising business units to claim systems.

GlobalSync reduced shadow incidence by **mandatory service mesh enrollment** — unregistered services could not receive production network policy. Mesh enrollment auto-emitted CBOM sidecar row — prevention over detection.

---

## 7.41 Baseline Declaration Ceremony

PQ-ADAPT Level 2 baseline declaration is a **steering committee decision**, not a project milestone email:

**Agenda (60 minutes):**

1. Present verified coverage by segment (§7.26)
2. Present unknown bucket — owners, dates, interim risk posture
3. Present methodology and exclusions document
4. Present quality metric trends
5. Vote: declare baseline / extend Phase 1 / accept risk on gaps

Meridian baseline declared October 2026 — 82% verified regulated, 22% unknown with owners. Elena read unknown list aloud — including hosted payment processor with incomplete HSM attestation — steering accepted with procurement escalation deadline.

**Failure mode:** Declaring baseline without vote — auditors question governance. **Failure mode:** Waiting for 100% — perpetual Phase 1.

---

## 7.42 Auditor Questions and CBOM Evidence Mapping

Auditors and assessors ask predictable questions — map CBOM exports to answers:

| Question | CBOM evidence |
|----------|---------------|
| What quantum-vulnerable algorithms exist? | Filter `quantum_vulnerable=true` |
| How do you know? | `confidence` distribution |
| What is unknown? | Unknown bucket report |
| How do third parties participate? | `third_party_flag=true` rows |
| When last verified? | `last_verified_date` histogram |
| Who owns inventory? | RACI + `owner_team` |

Thomas Bergström rehearsed supervisory dialogue with **filtered CBOM exports** — not narrative slides. DORA ICT provider register matched CBOM third-party rows one-to-one — supervisor accepted mapping as state-of-the-art evidence.

---

## 7.43 Continuous Discovery vs Phase 1

Phase 1 establishes baseline; **continuous discovery** maintains it. Minimum continuous activities:

- CI/CD CBOM emission on every production deploy
- Weekly cloud KMS API sync
- Quarterly third-party attestation chase
- Annual OT site reverification sample (20% sites per year, full cycle in five years)

Meridian transitioned from Phase 1 tranche mentality to **continuous mode** at baseline declaration — tranche owners became **domain custodians** with ongoing quotas for unknown resolution.

---

## 7.44 Figure Production Brief — CBOM Discovery Architecture

**Figure 7.1** (§7.4): Three-column diagram — Sources (SAST, scan, cloud API, manual), Aggregation (CBOM repository with quality dashboard), Consumers (TRADE, CDG, regulatory evidence, board reporting). Use solid arrows for automated flows, dashed for manual/attestation. Include legend for `confidence` tiers.

**Figure 7.2** (§7.13): PQ-ADAPT maturity progression horizontal timeline with Level 0–3 and "maintained" state — annotate Meridian Phase 1 exit at Level 2 baseline.

---

## 7.45 Chapter Summary

- The CBOM is the cryptographic system of record — not certificate inventory, not vendor questionnaires alone.
- PQ-ADAPT Level 2 requires maintained baseline with documented unknowns and methodology.
- Discovery combines static, network, cloud, manual OT, and vendor methods — each with coverage limits.
- Third-party obscurity is typical (Meridian 38%) — contractual and risk-process resolution required.
- Algorithm normalisation to FIPS names enables policy and TRADE alignment.
- Governance — RACI, evidence tiers, quality metrics — determines whether inventory persists.
- CBOM maintenance requires named ownership and integration with change management.
- OT and classified environments need deliberate survey and boundary separation.
- SBOM/CBOM convergence and CI/CD gates sustain freshness between discovery tranches.

**Next:** Chapter 8 extends the CBOM into a Cryptographic Dependency Graph — revealing blocking nodes that determine migration sequence.

---

*Chapter 7 — References*

- Basescu, C., et al. (2024). Deployment considerations for secure post-quantum cryptography in practice. *USENIX Security Symposium*.
- CycloneDX. (2024). *Authoritative guide to CBOM and cryptographic bill of materials*. OWASP Foundation.
- European Parliament and Council. (2022). Digital Operational Resilience Act (DORA). *Official Journal of the European Union*.
- National Institute of Standards and Technology. (2024). *Migration to post-quantum cryptography* (NCCoE project). https://www.nccoe.nist.gov/projects/pqc-migration
- National Institute of Standards and Technology. (2024). *Automated discovery tools for cryptographic asset inventory* (SP 1800-38 series, informative).
- Cybersecurity and Infrastructure Security Agency. (2024). Post-quantum cryptography initiative. https://www.cisa.gov/quantum
- IBM Research. (2023). Cryptographic bill of materials and dependency typing for enterprise migration planning (industry reference).
- World Economic Forum. (2024). *Quantum security: Preparing for the post-quantum era*.
- OWASP. (2024). Software and cryptographic bill of materials guidance. https://owasp.org
- National Institute of Standards and Technology. (2023). *Hardware security modules for key management* (informative for HSM CBOM fields).
- European Union Agency for Cybersecurity. (2024). Post-quantum cryptography — current state and quantum mitigation efforts.
- Payment Card Industry Security Standards Council. (2024). PCI DSS cryptographic requirements (informative mapping).

---

*Proceed to Chapter 8: The Cryptographic Dependency Graph.*
