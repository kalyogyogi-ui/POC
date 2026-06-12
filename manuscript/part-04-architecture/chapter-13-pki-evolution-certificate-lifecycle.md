# Chapter 13
# PKI Evolution and Certificate Lifecycle

---

Meridian Mutual Bank's PKI engineering lead, Sofia Andersson, presented a root CA migration plan in November 2026 that made the steering committee uncomfortable for the right reasons. The proposal did not ask permission to replace RSA-4096 with ML-DSA-87 in a single cutover weekend. It asked permission to operate **two root trust anchors in parallel for ten years** — classical and post-quantum — with explicit sunset criteria, trust store distribution logistics for twelve thousand retail terminals, and a €1.8 million budget line labelled *overlap operations*, not *migration completion*.

Elena Vasquez recognised the pattern from Chapter 1's synchronisation meeting: PKI is where programme timelines meet physical reality. Hybrid TLS pilots succeeded in the laboratory because they changed negotiated groups, not trust anchors. Every downstream verifier — load balancers, mobile apps with certificate pinning, partner webhook clients, manufacturing firmware stores — still trusted certificates chained to roots that could not sign ML-DSA profiles until Sofia's team completed Wave 0 work.

Meridian's hybrid TLS deployment (Chapter 11) remained blocked on twelve services until the issuing CA published ML-DSA server certificate templates. Marcus Chen's partner mTLS programme (Chapter 8) could not accept client certificates the partner gateway's trust policy rejected. Priya Nair's NSS deliverable signing track (Chapter 9) required a separate root hierarchy that must never inherit trust paths from Apex commercial PKI.

This chapter teaches readers to architect **PQC-capable PKI** — hierarchy design, certificate profiles, validity policy, automation, and trust store mechanics — as the structural foundation hybrid deployment patterns assume. PKI is not a certificate renewal project. It is the trust substrate whose migration gates every wave downstream.

---

## 13.1 PKI as the Dominant Wave 0 Blocking Domain

Chapter 8 identified enterprise PKI as the most common source of **edge explosion** in the cryptographic dependency graph. A single internal root CA may sign hundreds of server certificates, dozens of subordinate CAs, and thousands of indirect trust relationships through applications, devices, and partner integrations. Chapter 9 placed **internal root CA rotation plans** in Wave 0 alongside partner mTLS policy and HSM firmware signing — not because every certificate expires immediately, but because **no dependent workload can complete PQC transition until issuers and profiles exist**.

**Table 13.1 — PKI Blocking Patterns and Wave Placement**

| CDG pattern | Fan-in signal | Typical wave | Exit criterion |
|-------------|---------------|--------------|----------------|
| Enterprise root CA | 200+ `signs` edges; 50+ `inherits` | Wave 0 | PQC-capable issuing CA operational; dual-trust documented |
| Partner mTLS policy hub | 100+ client certs share template | Wave 0 | Partner acceptance threshold met (GlobalSync: 85%) |
| Service mesh internal CA | 100+ namespace workloads | Wave 0 | Mesh CA issues ML-DSA profiles |
| Manufacturing / code-signing CA | Firmware, CI, webhook verifiers | Wave 0 | Dual-signature or ML-DSA profile GA |
| Public Web PKI (commercial TLS) | External customer traffic | Wave 1–2 | CA/Browser Forum-aligned issuance available |
| Application pinning bundles | Mobile, embedded, partner SDKs | Wave 1–3 | App release + trust store update paired |

PKI blocking differs from application blocking in **lead time**. Rotating an API's TLS certificate takes hours if profiles exist. Establishing a PQC-capable root, cross-certifying subordinates, updating trust stores on field devices, and negotiating partner acceptance takes **months to years**. Meridian's manufacturing root rotation scenario (Chapter 8 §8.25) required nine-month terminal logistics after cryptographic readiness — the CDG edge attribute `logistics_refresh_months` applied to PKI outcomes, not only firmware.

> **Dependency Alert**
>
> **Issuing CA migration before root strategy is a common failure mode.** Teams re-issue end-entity certificates with ML-DSA keys while chaining to classical roots — valid transitional posture during H1, but not a substitute for root/subordinate architecture. Without root overlap planning, the enterprise repeats full trust migration at root retirement — paying the synchronisation cost twice.

### Relationship to HLM and hybrid patterns

Chapter 11's hybrid TLS patterns assume **certificate signatures** evolve on a distinct timeline from **key exchange**. H1 protective hybrid permits classical ECDSA end-entity certificates with hybrid ML-KEM key exchange while the PKI team migrates CA signatures to ML-DSA. H2 transitional hybrid requires ML-DSA end-entity certificates for new issuance in scope. H3 PQC-native removes quantum-vulnerable certificate signatures entirely.

PKI architecture must encode these phases in **certificate profile definitions** — not informal operator knowledge. Sofia's team tagged every Meridian template with `hlm_phase_minimum` and `pqc_signature_algorithm` attributes synced to CBOM (§13.18).

---

## 13.2 PQC-Capable PKI Hierarchy Architecture

A **PQC-capable PKI hierarchy** is a certificate authority structure where every tier — root, subordinate, issuing, end-entity — can issue and validate certificates signed with approved post-quantum signature algorithms, subject to profile constraints and HLM phase policy.

### Hierarchy tiers and roles

**Table 13.2 — PKI Tier Responsibilities (Enterprise Internal PKI)**

| Tier | Typical validity | Key algorithm (PQC target) | Custody | Primary function |
|------|------------------|---------------------------|---------|------------------|
| **Root CA** | 15–25 years | ML-DSA-87 (enterprise); ML-DSA-65 where risk assessment permits | Offline HSM; ceremony-controlled | Trust anchor; signs subordinate CA certificates only |
| **Policy / intermediate CA** | 10–15 years | ML-DSA-87 or ML-DSA-65 per policy | Offline or online HSM per policy | Name space separation; path length constraint |
| **Issuing CA** | 5–10 years | ML-DSA-65 (default) | Online HSM or cloud CA service | End-entity certificate issuance |
| **End-entity** | 90 days–2 years (profile-dependent) | ML-DSA-65 or ML-DSA-44 for constrained clients | Workload keystore, TPM, or HSM | Server TLS, client mTLS, code signing, email |

Roots sign few certificates — typically subordinates only — but anchor the largest fan-in in the CDG. Issuing CAs sign frequently and drive operational automation volume. Architecture decisions at root tier propagate to every dependent verifier.

### Single hierarchy vs parallel hierarchies

Enterprises choose between:

1. **In-place evolution** — existing root cross-signs new PQC subordinate chain; classical chain retires on schedule
2. **Parallel hierarchy** — new PQC root operates alongside legacy root during overlap; dependents migrate trust explicitly
3. **Greenfield hierarchy** — new PQC-only PKI for new workloads; legacy PKI sunsets with estate decommission

Meridian selected **parallel hierarchy with ten-year overlap** for manufacturing and corporate roots (§13.4). GlobalSync selected **in-place evolution** for internal mesh CA with six-month dual-trust on consumer nodes. Apex maintains **permanently separated** NSS and commercial hierarchies (§13.16) — parallel by classification boundary, not by algorithm generation alone.

> **Architect's Decision**
>
> **Default to parallel hierarchy with documented overlap for internal enterprise PKI** unless CDG analysis proves greenfield separation for new workloads only. In-place evolution without overlap period forces simultaneous trust store updates across all dependents — the synchronisation failure mode Chapter 1 described for SHA-1 root retirement, amplified by ML-DSA chain size and partner lead times.

### Path length, name constraints, and profile binding

PQC migration is an opportunity to correct historical PKI sprawl — not merely to swap algorithms.

| Control | Purpose | PQC consideration |
|---------|---------|-------------------|
| `pathLenConstraint` | Limit chain depth | Shorter paths reduce ML-DSA chain byte size on constrained devices |
| `nameConstraints` | Restrict permitted DNS, IP, email | Unchanged semantics; critical for multi-tenant SaaS (GlobalSync) |
| Separate issuing CAs per profile class | Blast radius containment | Code-signing CA distinct from TLS CA — different ML-DSA parameter sets |
| `cRLDistributionPoints` / OCSP URLs | Revocation infrastructure | Larger CRLs with ML-DSA signatures; plan bandwidth (§13.5) |

Northfield's OT PKI team collapsed a four-tier classical hierarchy to **root + issuing** for field devices — accepting shorter policy CA lifetime in exchange for chains that fit 8 KB certificate stores (Chapter 6).

---

## 13.3 Root and Subordinate CA Strategy

Root CA strategy answers three programme questions the board should see without algorithm jargon:

1. **How long will two trust anchors coexist?**
2. **Who must update trust stores, and on what schedule?**
3. **What measurable criterion ends overlap?**

### Root key ceremony and custody

PQC root keys are larger than RSA-4096 or ECDSA P-384 keys but remain within HSM storage capacity for modern FIPS 140-3 Level 3 modules. Ceremony procedures adapt:

| Ceremony element | Classical practice | PQC adaptation |
|------------------|-------------------|----------------|
| Key generation | RSA 4096 / ECDSA P-384 in HSM | ML-DSA-87 keygen in HSM; validate FIPS 204 module path |
| Activation quorum | M-of-N smart cards | Same; ensure ceremony software displays ML-DSA OIDs correctly |
| Cross-certification signing | RSA root signs ECDSA subordinate | ML-DSA root signs ML-DSA subordinate; **dual cross-sign** during overlap |
| Audit evidence | Ceremony log, HSM attestation | Add algorithm policy version, FIPS 204 module certificate ID |
| Backup and recovery | Split key backup | Verify backup restore procedures with larger key blobs |

Meridian's payment HSM root ceremony added **algorithm policy attestation** — ceremony officers sign a document naming approved ML-DSA parameter sets, preventing well-intentioned operators from issuing ML-DSA-44 certificates where policy mandates ML-DSA-65 minimum.

### Subordinate CA issuance sequence

**Figure 13.1 — Root/Subordinate Issuance Sequence with Overlap**

```
Phase A (overlap start):
  [Root-RSA] ----cross-sign----> [Sub-PQC-int]
  [Root-PQC] ----signs---------> [Sub-PQC-int]
  [Sub-RSA-int] ---signs--------> [Issuing-RSA] ---> EE certs (classical)
  [Sub-PQC-int] ---signs--------> [Issuing-PQC] ---> EE certs (ML-DSA)

Phase B (migration mid-point):
  New EE issuance from [Issuing-PQC] only in scope
  [Issuing-RSA] in maintenance mode — renewals exceptions only

Phase C (overlap end):
  [Root-RSA] trust removed from enterprise trust stores
  [Root-PQC] sole anchor
```

**Production brief — Figure 13.1:** Gantt overlay showing Phase A–C against calendar years; annotate CDG nodes transitioning `trusts` edges.

### Cross-signing vs re-issuance

**Cross-signing** — existing classical root signs new PQC subordinate certificate — minimises immediate trust store churn. Dependents trusting classical root accept PQC chain during transition. **Re-issuance** — distribute new PQC root to all trust stores — forces big-bang or staged trust update.

| Approach | Advantage | Risk |
|----------|-----------|------|
| Cross-sign | Slower trust store churn; partner-friendly | Complex path building; dual paths in validation logic |
| Parallel root distribution | Clear trust separation | All dependents must install new anchor |
| Bridge CA | Contained cross-trust | Additional node; audit scrutiny |

Meridian used **cross-sign plus parallel root distribution** for manufacturing — terminals received both roots in staged firmware updates; partners received cross-signed chain documentation first, parallel root second.

---

## 13.4 Meridian: Ten-Year Root Overlap Strategy

Sofia Andersson's ten-year overlap proposal responded to a CDG analysis Meridian completed after Chapter 8's methodology rollout. The manufacturing root CA node showed:

- **Fan-in:** 12,400 retail terminals, 890 partner webhook verifiers, 2,400 firmware image verification paths
- **Lead time:** nine-month terminal logistics refresh capacity
- **Contractual:** card-scheme trust policy notification windows of eighteen to thirty-six months
- **Regulatory:** DORA ICT risk management evidence requiring documented transition, not point-in-time replacement

A three-year overlap — common in classical PKI refresh projects — would force terminal trust store updates, webhook verifier updates, and partner notifications into a compressed window overlapping payment HSM firmware migration and hybrid TLS rollout. Programme office Monte Carlo scheduling showed **42% probability of missing Wave 0 exit** with three-year overlap versus **11%** with ten-year overlap, given shared PKI team capacity.

### Overlap period structure

**Table 13.3 — Meridian Root Overlap Timeline (Illustrative)**

| Period | Calendar (illustrative) | Trust posture | Issuance policy |
|--------|-------------------------|---------------|-----------------|
| **Overlap start** | 2027 Q1 | Classical + PQC roots both trusted | New subordinates from PQC root; cross-sign from classical |
| **Migration mid** | 2029–2032 | PQC-primary; classical root maintenance | ML-DSA EE certs default; classical renewals by exception |
| **Deprecation notice** | 2033 | Classical root flagged `deprecated` in trust bundles | No new classical chain issuance |
| **Overlap end** | 2037 Q1 | PQC root sole anchor | Classical root removed from enterprise trust stores |

Ten years aligns with **longest-lived dependent trust** — retail terminals with ten-year firmware support horizons and partner integrations with multi-year contractual notice periods — not with cryptographic necessity alone. ML-DSA-87 roots do not require ten-year keys for security margin; the overlap period is a **programme synchronisation instrument**.

> **Migration Moment**
>
> *"Ten years of dual roots doubles our PKI operational cost."*
>
> Sofia's response to the CFO: dual-root cost is **budgeted synchronisation insurance**. Compressed overlap externalises cost to payment operations as terminal truck rolls, partner outage credits, and Wave 0 extension — Meridian extended Wave 0 one quarter when terminal trust store updates reached 78% not 95% (Chapter 9 §9.38). The overlap line item is cheaper than programme slip.

### Overlap exit criteria

Meridian defined **measurable overlap termination** — steering committee cannot defer classical root removal indefinitely:

| Criterion | Threshold | Data source |
|-----------|-----------|-------------|
| Active classical EE certificates | < 0.5% of estate | CBOM cert inventory scan |
| Terminal fleet trust store | ≥ 99% PQC root installed | Retail operations telemetry |
| Partner webhook verifiers | 100% PQC chain validation in production | Integration test archive |
| Card-scheme notification | Completed per scheme rules | Compliance attestation |
| CDG classical `trusts` edges | Zero production `blocking: true` | CDG quarterly export |

Failure to meet criteria at 2037 triggers **board-level extension** with documented risk acceptance — not silent continuation.

### DORA evidence mapping

Elena linked overlap milestones to ICT risk register entries — supervisors receive **progress evidence**, not a single "PKI migrated" boolean. Each overlap phase produces: ceremony records, trust store distribution logs, CBOM profile adoption metrics, and exception register entries for classical renewals during migration mid-period.

---

## 13.5 ML-DSA Certificate Sizes, Chain Length, and Trust Store Updates

ML-DSA signatures and public keys are substantially larger than RSA-2048 or ECDSA P-256 equivalents (Chapter 4, Table 4.2). PKI architects must engineer **chain byte budgets** before profile rollout — not discover limits during first production issuance.

### Approximate size comparison

**Table 13.4 — Certificate and Chain Size Estimates (Single EE, Three-Tier Chain, Illustrative)**

| Component | RSA-2048 / SHA-256 | ECDSA P-256 | ML-DSA-65 | ML-DSA-87 |
|-----------|-------------------|-------------|-----------|-----------|
| End-entity public key | ~270 B | ~65 B | ~1.9 KB | ~2.6 KB |
| End-entity certificate (DER) | ~1.4 KB | ~0.8 KB | ~3.5–4.5 KB | ~4.5–5.5 KB |
| Intermediate CA certificate | ~1.5 KB | ~0.9 KB | ~4.0–5.0 KB | ~5.0–6.0 KB |
| Root CA certificate | ~1.6 KB | ~1.0 KB | ~4.5–5.5 KB | ~5.5–6.5 KB |
| **Three-tier chain (total, DER)** | **~4.5 KB** | **~2.7 KB** | **~12–15 KB** | **~15–18 KB** |
| TLS handshake cert message (approx.) | Chain + keys | Chain + keys | **+8–12 KB vs ECDSA** | **+12–16 KB vs ECDSA** |

Sizes vary by extension set, Subject Alternative Name count, and CRL distribution point URLs. Treat Table 13.4 as **planning estimates** — benchmark with your CA software and profile templates before promising device compatibility.

### Chain length engineering

| Technique | Byte savings | Trade-off |
|-----------|--------------|-----------|
| Reduce path to two tiers | One intermediate eliminated | Less policy separation |
| Shorten SAN lists | Variable | May require split certificates |
| Minimise custom extensions | Variable | Loss of proprietary metadata |
| Issue flatter hierarchy from PQC root | One intermediate | Root ceremony frequency increases if issuing CA compromised |
| Separate short-chain profile for IoT/OT | Profile proliferation | Operational complexity |

Northfield's RTU profile achieved ML-DSA-65 fit in 8 KB stores by **two-tier chain** and **single SAN** — engineering workstations retained three-tier corporate chain on separate profile.

### Trust store update mechanics

A **trust store** is any collection of trust anchors and intermediate certificates used to validate chains — operating system stores, JVM `cacerts`, container base images, mobile app bundles, firmware trust partitions, partner SDK configurations.

**Table 13.5 — Trust Store Categories and Update Mechanisms**

| Trust store type | Discovery method (CDG) | Update mechanism | Typical lead time |
|------------------|------------------------|------------------|-------------------|
| Linux OS (`ca-certificates`) | Config management | Package update; config management push | Days–weeks |
| Windows Group Policy | AD GPO inventory | GPO deployment | Weeks |
| JVM `cacerts` | Image scan; build pipeline | Base image rebuild | Sprint cycle |
| Container base images | Registry scan | Image refresh cadence | Variable — golden image debt |
| Mobile app pinning bundle | Mobile CBOM row | App store release | Weeks–months |
| Firmware trust partition | OT asset inventory | Firmware update / truck roll | Months |
| Partner-controlled store | Contract + integration test | Partner change request | Months–years |
| HSM trust module | HSM audit | HSM vendor update | Months |

Chapter 8 §8.27 documented Meridian's discovery of **23 custom trust stores** in payment microservices — PKI migration plans that assumed single corporate trust bundle failed CDG review. Trust store updates are **per-node CDG edges**, not one enterprise-wide operation.

### Infrastructure buffer interaction

Larger certificate chains compound Chapter 11's hybrid TLS handshake size concerns:

- Load balancers and API gateways may enforce maximum handshake message sizes
- IDS/IPS appliances may truncate or reject large ClientHello / Certificate messages
- VPN concentrators may fragment tunneled TLS

Sofia's team required **infrastructure buffer assessment** (Chapter 11 §11.1 control 4) on every profile before production — PKI publishes chain size; platform engineering certifies path clearance.

> **Architect's Decision**
>
> **Publish maximum chain byte size per certificate profile in the PKI architecture document.** Application teams, mobile developers, and OT engineers validate against published budgets before requesting issuance — not after failed deployment. Meridian profiles include `max_chain_bytes` as mandatory metadata.

---

## 13.6 Certificate Profiles: Server TLS, Client mTLS, Code Signing, Email

A **certificate profile** is a specification binding key algorithm, signature algorithm, validity period, extension set, issuance workflow, and HLM phase requirements to a workload class. PQC migration converts informal CA operator practice into **versioned profile documents** referenced by CBOM and CDG.

### Server TLS profile

| Attribute | Meridian corporate (H1) | Meridian corporate (H2 target) | GlobalSync multi-tenant |
|-----------|---------------------------|-------------------------------|-------------------------|
| Key algorithm | ECDSA P-256 → ML-DSA-65 transition | ML-DSA-65 | ML-DSA-65 |
| Signature algorithm | Issuing CA ML-DSA; EE transitional ECDSA permitted H1 | ML-DSA-65 throughout chain | ML-DSA-65 |
| Validity | 90 days (public); 397 days max per Web PKI norms where applicable | 90 days | 90 days; tenant override prohibited |
| SAN | FQDN; optional wildcard per policy | Same | Per-tenant FQDN; no shared wildcard |
| Key usage | `digitalSignature`, `keyEncipherment` (if needed) | `digitalSignature` preferred | `digitalSignature` |
| EKU | `serverAuth` | `serverAuth` | `serverAuth` |
| Automation | ACME internal / public CA | ACME | ACME + GitOps manifest |

Server TLS profiles interact with hybrid key exchange (Chapter 11) — certificate signature algorithm and negotiated key exchange group are independent attributes.

### Client mTLS profile

Client certificates power B2B APIs, service mesh identity, and Zero Trust device authentication. PQC migration complexity exceeds server TLS because **client ecosystem readiness** lags server readiness (GlobalSync Chapter 8 pattern).

| Attribute | Enterprise default | Partner-facing (strict) | IoT / device |
|-----------|-------------------|----------------------|--------------|
| Key algorithm | ML-DSA-65 | ML-DSA-65 | ML-DSA-44 or ECDSA transitional if constrained |
| Validity | 1 year | 90 days–1 year | Device lifetime capped |
| EKU | `clientAuth` | `clientAuth` | `clientAuth` |
| Subject | Service identity CN + SPIFFE URI where used | Partner-assigned DN structure | Device serial |
| Revocation | OCSP stapling; CRL for offline | OCSP mandatory | CRL push to gateway |
| Dual certificate | Transitional classical + PQC parallel certs during H1 | Partner acceptance dependent | Rare — prefer profile compression |

GlobalSync's partner mTLS policy (Chapter 8) blocked 200 microservices until **Tier 1 partners** accepted ML-DSA client certificate profiles — server hybrid TLS succeeded without client profile migration.

### Code signing profile

Code signing profiles span enterprise software release, container images, firmware, and mobile app distribution. Size constraints are most acute here (Chapter 6).

| Attribute | Corporate IT release | NSS / Apex deliverable | Northfield OT firmware |
|-----------|---------------------|------------------------|------------------------|
| Signature algorithm | ML-DSA-65 dual-sign H1 | ML-DSA-87 dual-sign H1 | LMS or ML-DSA-65 per device class |
| Validity | 3 years max | 5 years per policy | Align to firmware support horizon |
| EKU | `codeSigning` | `codeSigning` | `codeSigning` |
| Timestamp | RFC 3161 TSA required | TSA + long-term archive | TSA |
| Key custody | HSM online | NSS HSM partition | Manufacturing HSM |

Dual-signature H1 (classical + ML-DSA) requires profile documentation of **verification policy** — both signatures valid, or either — matching Chapter 11 combiner semantics.

### Email (S/MIME) profile

Email signing and encryption certificates often carry the longest operational tail — legal hold archives must verify decades-old signatures (Chapter 8 §8 archival trust).

| Attribute | Meridian executive comms | General staff |
|-----------|-------------------------|---------------|
| Signature algorithm | ML-DSA-65 | ML-DSA-65 |
| Validity | 2 years | 1 year |
| EKU | `emailProtection` | `emailProtection` |
| Archival | Hybrid classical + PQC dual-sign during H1 | PQC-native target H2 |
| Gateway | Email security appliance validates chain | Same |

S/MIME ecosystem readiness trails TLS — Meridian deferred executive rollout until mail gateway vendor validated ML-DSA chains in production release.

> **Regulatory Lens**
>
> Financial and health-sector supervisors evaluate **email non-repudiation** and **archive verification** during thematic reviews. PKI profiles for S/MIME must link to records retention policy — retiring classical roots before archive verification horizon expires creates compliance exposure independent of TLS migration status.

---

## 13.7 Table 13.6 — Certificate Profile Comparison: RSA vs ML-DSA

**Table 13.6 — Certificate Profile Comparison (RSA-2048 vs ML-DSA-65 Enterprise Default)**

| Profile dimension | RSA-2048 (classical) | ML-DSA-65 (PQC) | Migration impact |
|-------------------|---------------------|-----------------|------------------|
| **Security basis** | Integer factorisation | Module-lattice (FIPS 204) | Algorithm policy update |
| **EE cert size (typical)** | ~1.4 KB | ~3.5–4.5 KB | Trust store, TLS buffer, firmware store |
| **EE public key size** | 256 B | ~1.9 KB | HSM storage; TPM import limits |
| **Signature size (standalone)** | 256 B | ~3.3 KB | Log storage; document signing containers |
| **Three-tier chain size** | ~4.5 KB | ~12–15 KB | **Primary OT/embedded blocker** |
| **Issuance CPU cost** | Low | Moderate | CA HSM throughput planning |
| **Verification CPU cost** | Low | Moderate–high | High-volume API mTLS paths |
| **HSM support maturity (2026)** | Universal | FIPS 140-3 modules shipping | Procurement gate |
| **TLS 1.3 compatibility** | Universal | Universal with supported stacks | Library version dependency |
| **Smart card fit** | Tight at 2 KB stores | Often requires card refresh | Hardware procurement |
| **CRL size per 10K certs** | Smaller | ~2–3× larger | Bandwidth; OCSP preferred |
| **Web PKI public trust** | Mature | CA/Browser Forum alignment in progress (§13.11) | External-facing timeline |
| **Hybrid H1 posture** | Baseline | Dual-sign or dual cert with classical | Chapter 5 HLM governance |
| **Typical validity (server TLS)** | 90–397 days | 90 days (internal); align to CA/B Forum for public | Automation cadence unchanged |
| **Typical validity (root)** | 20–25 years | 15–20 years (same policy rationale) | Overlap planning critical |
| **CBOM `algorithm_family`** | `RSA` | `ML-DSA` | Inventory rescan |
| **CDG edge impact** | Baseline | All `trusts` / `verifies` edges need PQC path | Wave 0 blocking |

Use Table 13.6 in architecture review boards when teams claim "we just swap the algorithm." The migration impact column is the programme conversation.

---

## 13.8 Validity Period Policy

Validity period policy is a **risk management lever** distinct from algorithm choice. Shorter validity reduces compromise blast radius and aligns with automation — but increases operational volume and revocation traffic.

### Enterprise validity policy framework

**Table 13.7 — Validity Period Policy (Meridian Illustrative)**

| Certificate class | Maximum validity | Renewal automation | Rationale |
|-------------------|------------------|-------------------|-----------|
| TLS server (internal) | 90 days | ACME mandatory | Agility; incident response |
| TLS server (public Web PKI) | CA/Browser Forum maximum (context §13.11) | ACME / CA integrated | External policy compliance |
| Client mTLS (service) | 365 days | ACME or cert-manager | Identity rotation |
| Client mTLS (partner) | 90–365 days per contract | Semi-automated | Partner audit alignment |
| Code signing | 3 years | Manual ceremony + CI | Key ceremony cost balance |
| Email S/MIME | 2 years | Semi-automated | User experience |
| Root CA | 20 years | Manual ceremony | Trust anchor stability |
| Intermediate CA | 10 years | Manual ceremony | Policy CA separation |

### Validity vs overlap period

Long root validity does not eliminate overlap need — it defines **how often root ceremony repeats**, not how fast dependents migrate. Meridian's ten-year overlap exceeds intermediate validity periods — multiple intermediate renewals occur during overlap, each chaining to the appropriate root(s).

### Shorter validity as PQC transition tool

GlobalSync shortened internal TLS validity from one year to **90 days** during PQC transition — not for security margin alone, but to **force automation** before ML-DSA profiles deployed. Manual renewal processes that tolerated yearly RSA cycles would not scale to quarterly ML-DSA operations.

> **Migration Moment**
>
> *"Our two-year TLS certificates worked fine for a decade. Why shorten validity for PQC?"*
>
> Because PQC migration is when enterprises **break manual renewal habit**. Teams that defer automation until after algorithm change recreate the SHA-1 retirement fire drill with larger certificates and shorter supervisory patience.

---

## 13.9 ACME Automation and Certificate Lifecycle Operations

**ACME** (Automatic Certificate Management Environment) protocol automation is the operational backbone of PQC PKI at scale. Manual issuance fails when quarterly renewals multiply chain size and HSM queue depth.

### ACME architecture components

| Component | Function | PQC consideration |
|-----------|----------|-------------------|
| ACME server (internal or CA-hosted) | Protocol endpoint; authorisation | Must issue ML-DSA profiles per account policy |
| ACME client (cert-manager, Caddy, etc.) | Domain validation; CSR generation | Client must request ML-DSA keys in CSR |
| Policy engine | Maps account → profile | Profile ID encodes algorithm + HLM phase |
| HSM integration | Signs issuer response | ML-DSA signing throughput |
| Revocation service | OCSP responder; CRL publication | Larger responses |

Meridian deployed **internal ACME** for corporate TLS with mandatory `policy_profile_id` in account metadata — misconfigured accounts requesting ECDSA after H2 sunset date fail at policy engine, not at change advisory board.

### cert-manager and Kubernetes integration

GlobalSync's platform pattern:

1. `Certificate` resource specifies `policyProfile: gs-tls-server-h1`
2. cert-manager resolves profile → ML-DSA-65 CSR parameters
3. ACME issuer validates against allow-list of constructions
4. CBOM integration webhook updates `asset_id` on successful issuance

This implements Chapter 10's policy/implementation separation — developers reference profile IDs, not algorithm strings.

### Renewal failure modes

| Failure | Symptom | Prevention |
|---------|---------|------------|
| Profile algorithm mismatch | CSR rejected | Policy engine validation |
| HSM throughput exhaustion | Renewal timeouts | Queue monitoring; HSM scale |
| Domain validation failure | Expired cert outage | Staged renewal; early retry |
| Trust store not updated | Valid cert rejected by client | Trust store migration precedes EE migration |
| Shortened validity without automation | Mass expiry event | Automation gate before validity policy change |

### Revocation at scale

ML-DSA CRLs and OCSP responses grow. Meridian shifted internal PKI to **OCSP stapling mandatory** for TLS server profiles — reducing client-initiated OCSP volume. High-security client mTLS retained real-time OCSP for compromise response.

---

## 13.10 Cross-Certification and Federation

**Cross-certification** establishes mutual trust between PKI hierarchies — enterprise internal roots, partner roots, industry federation CAs, and public Web PKI bridges. PQC migration cross-certification must answer: *which roots cross-sign which, for how long, and with what path validation rules?*

### Cross-certification patterns

| Pattern | Use case | PQC note |
|---------|----------|----------|
| **Enterprise cross-sign (internal)** | Classical root signs PQC subordinate during overlap | Primary Meridian manufacturing pattern |
| **Partner bilateral cross-sign** | B2B mTLS trust | Negotiate ML-DSA chain acceptance; test harness (Chapter 8) |
| **Bridge CA** | Multi-organisation federation | Bridge CA ML-DSA-87; path length limits critical |
| **Qualified trust service (EU)** | eIDAS QTSP hierarchies | Monitor ETSI profile updates for PQC |
| **Public trust cross-sign** | Web PKI CA migration | CA/Browser Forum process (§13.11) |

### Path validation policy

Cross-certified environments require explicit **path validation policy** — which roots are trusted for which EKU, whether name constraints apply, maximum path length.

```
PATH POLICY EXAMPLE (illustrative):
  IF eku == serverAuth AND dns in corporate_zone:
    TRUST [Root-PQC-v2], [Root-RSA-legacy] until 2037-01-01
  IF eku == clientAuth AND partner_id in partner_registry:
    TRUST [Partner-Root-PQC] ONLY
  IF eku == codeSigning:
    TRUST [Manufacturing-Root-PQC]; REQUIRE dual_signature H1
```

Apex encodes path policy in **signed configuration artefacts** for cross-domain guards — NSS paths never include commercial roots (§13.16).

### Federation sunset

Cross-certificates require **sunset dates** — parallel to `parallel_trust_until` CDG edge attributes (Chapter 8 §8.21). Permanent cross-sign without sunset recreates classical-quantum-vulnerable trust paths indefinitely.

---

## 13.11 CA/Browser Forum Context (Not Reproduced)

Public-facing TLS certificates — customer websites, API endpoints on the public Web PKI — operate under **CA/Browser Forum** baseline requirements and root programme rules. This chapter does **not** reproduce CA/Browser Forum documents; they change frequently and belong in your compliance subscription, not in a migration handbook.

Enterprise architects require **awareness**, not transcription:

| Topic | Programme implication |
|-------|----------------------|
| Maximum validity periods | External server TLS profile must track forum ballot outcomes — may differ from internal 90-day policy |
| Allowed signature algorithms | Publicly trusted ML-DSA issuance timelines gate customer-facing H2 |
| Root acceptance | New PQC roots require WebTrust audit and root programme inclusion — **multi-year lead time** |
| Certificate Transparency | Larger certificates increase SCT log volume — operational not cryptographic |
| Subscriber Agreement | May require algorithm disclosure to customers |

**Meridian** separated **internal PKI** (Wave 2, Sofia's overlap strategy) from **public Web PKI** (vendor-managed commercial CA, Wave 2–3) — different governance, same algorithm matrix. **GlobalSync** customer-facing TLS depended on commercial CA PQC roadmap — platform team tracked vendor attestation quarterly.

> **Regulatory Lens**
>
> Supervisory review of **internal PKI** does not substitute for CA/Browser Forum compliance on **public trust** certificates. DORA and PCI assess migration planning holistically — both tracks need roadmap entries. Conflating them produces audit findings when external-facing certs lag internal progress.

**Action:** Assign a **public trust PKI owner** to monitor CA/Browser Forum ballots and map outcomes to external certificate profile versions — reference URL in governance wiki, not reproduced text in architecture documents.

---

## 13.12 Trust Store Mechanics: Distribution, Verification, and Rollback

Trust store operations are where PKI architecture meets field operations. Sofia's team owned **trust anchor publication** — a dedicated artefact distinct from certificate issuance.

### Trust store publication pipeline

**Figure 13.2 — Trust Store Publication Pipeline**

```
[Root ceremony] --> [Trust anchor bundle build]
                           |
            +--------------+--------------+
            |              |              |
            v              v              v
     [GPO / MDM]    [Container base]  [Firmware build]
            |              |              |
            v              v              v
     [Workstations]  [K8s clusters]   [Terminal fleet]
            |              |              |
            +--------------+--------------+
                           |
                    [Verification telemetry]
```

**Production brief — Figure 13.2:** Add rollback path from verification failure to previous bundle version; annotate CDG `trusts` edge updates per distribution channel.

### Verification telemetry

Meridian measures trust store deployment by channel:

| Channel | Metric | Target |
|---------|--------|--------|
| Windows GPO | % domain systems with bundle vN | 99% in 30 days |
| Mobile MDM | % devices with updated pinning profile | 95% in 60 days |
| Retail terminals | % fleet with manufacturing root v2 | 99% before overlap phase C |
| Partner integrations | % partners passing chain validation test | 85% before client mTLS cutover |

Low telemetry triggers **rollback** to previous trust bundle — Sofia maintains `N-1` bundle for 180 days minimum.

### JVM and language runtime trust

Payment microservices using bundled `cacerts` overrides caused Meridian's **23 custom trust store** discovery. Standard remediation:

1. CBOM row per custom trust store with `owner_team`
2. Migrate to enterprise trust service or standard base image
3. Prohibit new custom stores via SDLC gate (Chapter 10 AGL-02)

---

## 13.13 Mobile Pinning and Application Trust Bundles

**Certificate pinning** — embedding expected public keys or SPKI hashes in mobile applications — creates a **hard CDG edge** from app release to trust anchor. Server certificate rotation without app update causes outage even when PKI is correct.

Chapter 7 documented Meridian retail banking app pinning to corporate root plus backup pin for legacy root scheduled for removal. PQC migration requires **coordinated app release + trust anchor update**:

| Phase | Pinning posture |
|-------|-----------------|
| H1 overlap | Pins include classical and PQC root SPKIs |
| H2 | New app version pins PQC root only; server presents PQC chain |
| Legacy app versions | Risk acceptance or forced upgrade campaign |

### Pinning strategies

| Strategy | PQC suitability | Risk |
|----------|-----------------|------|
| **Public key pin (SPKI)** | Preferred — pin ML-DSA-65 SPKI hash | Requires app update on root change |
| **Certificate pin** | Poor — cert rotates frequently | Operational fragility |
| **Pin set with backup pins** | Recommended during overlap | Backup pin sunset discipline |
| **Dynamic pinning (TACK-like)** | Rare in enterprise | Not assumed |

Meridian mobile team published **pin rotation calendar** synchronised to Sofia's overlap phases — product owner sign-off required for pin removal, not only PKI team decision.

> **Dependency Alert**
>
> **Server TLS migration without mobile pinning update is a production outage.** CDG must include `mobile_pinning` nodes with `trusts` edges to root CA nodes — Chapter 7 `asset_type=mobile_pinning`. Wave planning places pinning updates in the same wave as root distribution to affected user populations.

---

## 13.14 Partner Chains and Ecosystem Trust

Partner-controlled verifiers — acquirers, B2B integrators, cloud providers accepting customer-uploaded CAs — gate enterprise PKI migration regardless of internal readiness.

### Partner chain negotiation workflow

GlobalSync's partner programme (Chapter 8) adapted for PKI:

1. **Profile documentation** — publish ML-DSA client and server chain examples, byte sizes, test endpoints
2. **Pilot environment** — staging trust policy mirrors production with parallel PQC root
3. **Acceptance testing** — partner validates mTLS handshake and cert chain
4. **Contract amendment** — algorithm change clauses where required
5. **Production cutover** — policy node and consumer edges migrate same window
6. **CDG update** — `partner_acceptance_pct` attribute on blocking node

### Partner chain failure modes

| Failure | GlobalSync experience | Remediation |
|---------|----------------------|-------------|
| Partner validates CN but not EKU | 12% of early pilots | Explicit EKU test cases in harness |
| Partner max chain size limit | 8% rejected ML-DSA-65 chains | Short-chain profile; partner exception |
| Partner requires public Web PKI only | 15% of Tier 2 partners | Commercial CA PQC cert for those integrations |
| Partner software hard-codes RSA | 5% | Parallel classical endpoint tier (Chapter 11) |

Marcus Chen refused production client cert migration until **85% partner acceptance** — ecosystem dimension gating production despite internal PKI readiness.

---

## 13.15 GlobalSync: Service Mesh CA and Tenant Trust Boundaries

GlobalSync's second Wave 0 blocking node — **service mesh root CA** — issued identities to 180 Kubernetes namespaces. Istio control plane signed certificates consumed by sidecars system-wide; CDG fan-in second only to partner mTLS policy.

Platform engineering resolved mesh CA PQC migration as **in-place subordinate re-issuance**:

| Step | Action | Duration |
|------|--------|----------|
| 1 | Cross-sign new ML-DSA mesh intermediate from existing root | Week 1 |
| 2 | Deploy mesh CA issuing ML-DSA certs to staging namespaces | Weeks 2–4 |
| 3 | Parallel trust — sidecars accept both intermediates | Weeks 5–8 |
| 4 | Production namespace migration by tenant tier | Months 2–4 |
| 5 | Retire classical mesh intermediate | Month 5 |

**Tenant isolation:** GlobalSync prohibited tenants from uploading custom trust anchors without security review — tenant-scoped profiles reference platform `policy_profile_id`, not tenant-selected algorithms (Chapter 10 §10.6).

---

## 13.16 Apex: NSS vs Commercial PKI Separation

Apex Defense Technologies operates **two PKI programmes** that must not merge:

| Dimension | NSS PKI | Commercial IT PKI |
|-----------|---------|-------------------|
| Policy floor | CNSA 2.0 — ML-DSA-87, ML-KEM-1024 | NIST IR 8547 alignment — ML-DSA-65 default |
| Root custody | NSS HSM enclave; classified ceremony | Commercial HSM; corporate ceremony |
| CDG component | `G_apex_nss` subgraph | `G_apex_commercial` |
| Trust path to corporate | **None** without cross-domain guard | Standard corporate trust |
| Wave plan track | Wave 0 NSS firmware signing; Wave 1 NSS interfaces | Wave 2 corporate PKI |
| Accreditation | ATO / authorisation package update per change | SOC 2 / CMMC commercial flows |

A 2026 cost-reduction proposal to **unify signing under commercial PKI** failed CDG review (Chapter 8 §8.20): NSS deliverable nodes carried `boundary_tag: nss` with no `trusts` path to commercial root. Unification would create cross-classification edges violating accreditation boundaries.

Priya Nair's Wave 0 prioritised **NSS firmware signing module** and **deliverable signing HSM partition** — three defence contracts with 2027 renewal clauses referencing approved national security algorithms. Commercial TLS and product signing followed Wave 2 on NIST timeline.

### Cross-domain guard PKI role

Cross-domain guards terminate cryptographic sessions between NSS and corporate enclaves. Guard appliances maintain **distinct trust stores per side** — PQC migration updates each store independently with accreditation evidence. Guard firmware profiles appear as CDG blocking nodes with `lead_time_months` tied to vendor qualification.

> **Architect's Decision**
>
> **Never unify NSS and commercial PKI for operational convenience.** Shared HSM hardware may be acceptable with **logical partitioning**; shared root trust is not. Apex uses separate root ceremonies, separate CDG subgraphs, and separate wave plan tracks in one board document — dual timeline bars prevent mandate collision (Chapter 9 §9.11).

---

## 13.17 Northfield: OT PKI and Long-Validity Constraints

Northfield Energy's OT PKI carries **ten- to twenty-year validity** on field device certificates — common in utilities where truck-roll cost dominates. PQC migration intersects validity policy painfully: devices issued classical certificates in 2024 may remain in field until 2044, but quantum-vulnerable signatures on long-lived certs create HNDL exposure for **future forgery** of device identity (Chapter 2).

Northfield's programme:

1. **No new classical issuance** after 2028 for field devices — policy gate
2. **LMS/XMSS profiles** for compressor class where ML-DSA chains do not fit (Chapter 6)
3. **Shortened validity on new ML-DSA issues** — 5 years maximum where device software supports renewal
4. **Root overlap 15 years** — matching device support horizon, not Meridian's 10-year corporate choice

OT PKI team modelled root migration as **15-year programme** — ML-DSA-87 roots issued in 2027 validate firmware signed through 2042 under current policy.

---

## 13.18 CDG Integration: PKI as Blocking Hub

PKI nodes in the CDG require specific enrichment beyond automated certificate discovery.

### PKI CDG node template

| Attribute | Example | Purpose |
|-----------|---------|---------|
| `node_type` | `trust_anchor` / `certificate` / `policy` | Classification |
| `algorithm_family` | `ML-DSA` | Wave planning |
| `profile_id` | `meridian-tls-server-h2` | Profile linkage |
| `fan_in` | 12400 | Blocking detection |
| `blocking` | `true` | Wave 0 flag |
| `parallel_trust_until` | `2037-01-01` | Overlap sunset |
| `trust_store_channels` | `gpo,mdm,firmware` | Distribution |
| `max_chain_bytes` | 15360 | Device compatibility |

### Roll-up rules

Chapter 8 §8.8: roll up issued certificates by template for visualisation — **never roll up roots or blocking policy nodes**. Meridian's uncompressed PKI CDG export exceeded 1.2 million edges; template roll-up preserved four blocking nodes while reducing noise.

### Signing before verify rule

Chapter 9 Rule 6: **issuer migrates before verifiers accept new algorithms** — or dual-trust period explicit on CDG. PKI team issues ML-DSA chains only after trust store distribution reaches threshold; verifiers enable ML-DSA path validation only after trust anchor installation — order inversion causes false "PKI broken" incidents.

---

## 13.19 CBOM Certificate Attributes

Extend CBOM certificate rows for PKI lifecycle governance (Chapter 7 baseline):

**Table 13.8 — CBOM PKI Attribute Extensions**

| Attribute | Type | Example |
|-----------|------|---------|
| `cert_profile_id` | string | `meridian-mtls-client-h1` |
| `issuer_ca_node_id` | CDG ref | `issuing-ca-payments-02` |
| `trust_anchor_node_id` | CDG ref | `root-pqc-manufacturing-v2` |
| `pqc_signature_algorithm` | enum | `ML-DSA-65` |
| `hlm_phase_minimum` | enum | `H1` |
| `chain_bytes` | integer | 14208 |
| `validity_days` | integer | 90 |
| `automation_method` | enum | `acme` / `manual` / `ceremony` |
| `trust_store_dependencies` | list | `gpo-v4`, `mdm-profile-12` |
| `pinning_asset_id` | CBOM ref | `mobile-app-retail-ios` |
| `partner_scope` | boolean | true if partner must validate |

Automated discovery populates `chain_bytes` and `pqc_signature_algorithm`; manual enrichment adds `trust_store_dependencies` and `pinning_asset_id`.

---

## 13.20 Governance, Audit, and Steering Metrics

### PKI steering metrics

| Metric | Owner | Healthy signal |
|--------|-------|----------------|
| `% EE certs on ML-DSA profiles` | PKI team | Rising per wave |
| `% trust store channels at target bundle version` | Platform ops | ≥ 99% at phase gate |
| `classical_root_dependent_count` | CDG curator | Decreasing toward overlap end |
| `partner_acceptance_pct` | Partner programme | ≥ 85% at client mTLS cutover |
| `ACME renewal success rate` | Platform engineering | ≥ 99.5% |
| `mean_chain_bytes` by profile | PKI team | Stable within budget |
| `overlap_days_remaining` | Programme office | Tracked to sunset |

### Audit evidence package

Meridian DORA evidence includes: profile version history, ceremony logs, trust store distribution logs, exception register for classical renewals, CBOM scan exports showing algorithm adoption, and CDG snapshots showing `parallel_trust_until` compliance.

Internal audit walkthrough before production ML-DSA issuance identified missing `chain_bytes` in CBOM — same proactive pattern as Chapter 11 hybrid audit engagement.

---

## 13.21 Cross-Reference Map

| Topic | See |
|-------|-----|
| ML-DSA parameter sets and size baselines | Chapter 4 §4.4, Table 4.2 |
| HLM phase policy for certificate signatures | Chapter 5 §5.6–5.9 |
| Firmware signing where ML-DSA does not fit | Chapter 6 |
| CBOM certificate discovery | Chapter 7 |
| CDG blocking nodes, trust store edges, partner policy | Chapter 8 §8.3–8.4, §8.8, §8.27 |
| Wave 0 PKI placement, sequencing rules | Chapter 9 §9.5–9.6, Table 9.2 |
| Crypto-agility NFRs and profile identifiers | Chapter 10 |
| Hybrid TLS certificate posture during H1 | Chapter 11 §11.3 |
| Protocol-specific TLS migration | Chapter 12 |
| HSM ceremonies for root key generation | Chapter 14 |

---

## 13.22 Apply in Your Organisation

1. **Classify PKI blocking nodes** in CDG — roots, partner policy hubs, mesh CAs — before end-entity re-issuance projects.
2. **Define overlap period** with measurable exit criteria — not open-ended dual-root operations.
3. **Publish certificate profiles** (server TLS, client mTLS, code signing, email) with `max_chain_bytes`, HLM phase, and algorithm bindings.
4. **Benchmark ML-DSA chain sizes** with your CA software — replace Table 13.4 estimates with measured values.
5. **Inventory trust stores** — OS, JVM, container, mobile, firmware, partner — as CDG `trusts` edges.
6. **Coordinate mobile pinning releases** with root distribution calendar.
7. **Deploy ACME automation** before shortening validity periods — GlobalSync 90-day policy pattern.
8. **Separate public Web PKI track** from internal PKI — assign CA/Browser Forum monitor owner without reproducing forum text in internal docs.
9. **Maintain NSS/commercial PKI separation** if classified boundaries apply — Apex dual-track pattern.
10. **Extend CBOM** with Table 13.8 attributes; gate production on `cert_profile_id` population.
11. **Negotiate partner chain acceptance** with test harness before client mTLS migration — 85% threshold or documented alternative.
12. **Brief internal audit** with profile catalogue, overlap timeline, and sample trust store telemetry.

---

## 13.23 Chapter Summary

- **PKI is the dominant Wave 0 blocking domain** — root and issuing CA readiness gates hybrid TLS, mTLS, code signing, and firmware verification downstream.
- **PQC-capable hierarchy architecture** requires explicit root/subordinate strategy: parallel overlap, cross-signing, and path length engineering for ML-DSA chain sizes.
- **Meridian's ten-year overlap** synchronises terminal logistics, partner notification, and card-scheme trust cycles — overlap duration is programme design, not cryptographic mandate.
- **ML-DSA certificates are 2–4× larger** than ECDSA equivalents; three-tier chains may reach 12–18 KB — trust store and infrastructure buffer assessment mandatory.
- **Certificate profiles** must be versioned artefacts for server TLS, client mTLS, code signing, and email — each with HLM phase minimum and measured `max_chain_bytes`.
- **Table 13.6** contrasts RSA-2048 and ML-DSA-65 across operational dimensions — use in architecture review to counter "simple algorithm swap" assumptions.
- **Validity period policy** shortens during transition to force automation; root validity remains long with explicit overlap sunset.
- **ACME automation** scales ML-DSA renewal operations — policy engine enforces profile IDs, not developer algorithm choice.
- **Cross-certification and federation** require path validation policy and `parallel_trust_until` sunset — permanent cross-sign is H1 failure mode.
- **CA/Browser Forum context** governs public trust separately from internal PKI — monitor, do not reproduce, in architecture documents.
- **Trust store mechanics, mobile pinning, and partner chains** are CDG-first problems — issuance success without verifier update is outage.
- **Apex NSS vs commercial separation** prohibits unified root trust across classification boundaries — dual wave tracks in one board narrative.
- **CDG and CBOM integration** makes PKI migration measurable for steering committees and auditors.

**Closing note:** Every hybrid TLS pattern in Chapter 11 assumes someone like Sofia Andersson has already solved the trust anchor problem — or documented when it will be solved. PKI evolution is not the glamorous layer of post-quantum migration. It is the layer that determines whether everything else ships to production or stalls in staging forever.

**Next:** Chapter 14 adapts key management ceremonies, HSM partitioning, and cloud KMS architectures for larger PQC keys — the custody layer beneath the certificate profiles this chapter defined.

---

*Chapter 13 — References*

- CA/Browser Forum. (ongoing). *Baseline Requirements for the Issuance and Management of Publicly-Trusted Certificates*. https://cabforum.org/
- Internet Engineering Task Force. (2024–2026). ACME protocol and post-quantum certificate-related drafts. *IETF ACME Working Group*.
- Internet Engineering Task Force. (2024–2026). Post-quantum hybrid key exchange and certificate signature integration. *IETF TLS Working Group*.
- National Institute of Standards and Technology. (2024). FIPS 204: Module-Lattice-Based Digital Signature Standard. https://doi.org/10.6028/NIST.FIPS.204
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Institute of Standards and Technology. (2020). NIST SP 800-57 Part 1 Rev. 5: Recommendation for key management. https://doi.org/10.6028/NIST.SP.800-57pt1r5
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- European Telecommunications Standards Institute. (ongoing). Post-quantum cryptography in trust service profiles. *ETSI TC Cyber*.
- Aas, J., et al. (2019). RFC 8555: Automatic Certificate Management Environment (ACME). *IETF*.
- CycloneDX. (2024). *Authoritative Guide to CBOM*. OWASP Foundation.
- Thomas, S., et al. (2024). Post-quantum certificate size and chain validation considerations. *IETF Internet-Draft* (illustrative industry discussion).
