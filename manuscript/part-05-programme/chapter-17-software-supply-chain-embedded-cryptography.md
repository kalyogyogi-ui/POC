# Chapter 17
# Software Supply Chain and Embedded Cryptography

---

In March 2027, a GlobalSync Logistics platform engineer opened a pull request for a routine tenant notification service. Unit tests passed. Security scan reported zero critical CVEs. The merge request sat green for forty minutes until the **cryptographic verification gate** failed with a single line: `AGL-01 violation — hardcoded algorithm literal ECDSA-P256 in TenantAuditSigner.java:47`.

The engineer had copied a signing utility from a 2024 internal wiki example — before Marcus Chen's Crypto-Agility Standard v1.0 (Chapter 10) banned algorithm string literals. The service never reached staging. Marcus's team celebrated quietly: the gate had done what fourteen architecture review sessions could not — **reject non-agile cryptography at scale**, before it entered a two-hundred-microservice estate.

The incident was not a security breach. It was **programme machinery working**. Chapter 7 built the CBOM and SBOM merge discipline. Chapter 10 defined agility NFRs and SDLC gates. Chapter 11 required hybrid CBOM fields before hybrid deployments. Chapter 16 armed procurement with supplier obligations. Chapter 17 completes the loop: **automated supply chain enforcement** that keeps inventory honest and architecture standards non-optional — where most enterprise cryptography actually enters the estate.

Most enterprise cryptography does not live in security architecture slide decks. It lives in OpenSSL versions inside container base images, BouncyCastle transitive dependencies, firmware signing keys on engineering workstations, and vendor SDKs embedded in OT gateways. Post-quantum migration fails when programmes treat cryptography as an application concern while dependencies silently ship quantum-vulnerable algorithms at build time. This chapter teaches readers to integrate SBOM and CBOM generation, cryptographic policy gates, and verification discipline into CI/CD pipelines — for cloud-native microservices, regulated container estates, firmware supply chains, and classified build environments.

Readers should complete Chapter 17 with a pipeline gate design draft, a build-time versus runtime verification matrix for their estate, and SSDF-aligned secure software development practices mapped to PQC programme obligations.

---

## 17.1 The Supply Chain as Cryptographic Attack Surface

Part I established the synchronisation problem: cryptography fails when teams, vendors, and systems move at different speeds. The software supply chain is where those speeds **collide at volume**. A single platform team patches a base image; four hundred microservices inherit new OpenSSL behaviour without individual pull requests. A firmware vendor ships a bootloader update; twelve compressor sites inherit a new signing algorithm without the OT programme office noticing until audit sampling.

**Supply chain cryptography** encompasses:

| Layer | Examples | Programme visibility without gates |
|-------|----------|-----------------------------------|
| **Direct dependencies** | `org.bouncycastle:bcprov-jdk18on`, `aws-sdk-kms` | Partial — dependency scanners see packages |
| **Transitive dependencies** | OpenSSL in Alpine base image via `node:20-alpine` | Poor — requires SBOM merge |
| **Build tooling** | Code signing certificates for CI artefacts | Often absent from application CBOM |
| **Container images** | Golden images, sidecars, service mesh proxies | Fragmented across registries |
| **Firmware artefacts** | Signed blobs, bootloader keys, OTA packages | Manual surveys; stale quickly |
| **Vendor SDKs** | Payment HSM client libraries, OT protocol stacks | Contractual attestation only |
| **Infrastructure-as-code** | TLS policies in Terraform, cert-manager manifests | Separate repos from application CBOM |

The CBOM (Chapter 7) answers *what cryptography exists*. Supply chain gates answer *what cryptography may enter production* — and produce machine-readable evidence when supervisors or customers ask for proof.

> **Migration Moment**
>
> *"We fixed cryptography in our code — why does the CBOM still show RSA-2048 everywhere?"*
>
> Because your code calls `javax.crypto` and the JVM loads a provider configured by container defaults you never changed. Application-layer fixes without dependency and image governance produce **locally correct, globally vulnerable** estates. GlobalSync's gate rejected the wiki signing snippet not because the algorithm was wrong for 2024, but because the **pattern** violated 2027 agility policy.

---

## 17.2 From Discovery to Enforcement: CI/CD as Programme Layer

Parts III and IV produced inventory and architecture standards. Part V operationalises them through **programme authority** (Chapter 15) and **commercial enforcement** (Chapter 16). CI/CD integration is the engineering expression of that authority — where procurement clauses, agility NFRs, and hybrid policy become merge-blocking reality.

| Programme artefact | Without CI/CD integration | With CI/CD integration |
|--------------------|---------------------------|------------------------|
| CBOM baseline (Ch 7) | Quarterly stale snapshot | Per-build component emission |
| Agility NFRs (Ch 10) | Architecture review sampling | AGL-01 static analysis on every PR |
| Hybrid CBOM fields (Ch 11) | Manual steering review | Pipeline rejects missing `h2_trigger_value` |
| Vendor CBOM clauses (Ch 16) | Attestation PDF in procurement folder | Supplier SBOM ingested at artefact promotion |
| SSDF practices (§17.9) | Policy wiki | Automated evidence in pipeline audit trail |

**PQ-ADAPT positioning:** Enterprises at Level 3 (*Architected*) with wiki-only standards remain vulnerable to Level 2 inventory decay. Automated gates are the bridge from **Architected** to **Transitioning** (Level 4) — production systems demonstrably comply with policy at deploy time, not only at design review.

**ARCS — Synchronize:** Supply chain gates synchronise platform engineering, application teams, and vendor artefact producers on **one cryptographic truth per build**. When Marcus Chen's gate failed the tenant notification PR, the engineer received a link to the approved profile catalogue and the golden-path template — not a lecture about post-quantum threat models.

---

## 17.3 CycloneDX, SBOM, and CBOM in Build Pipelines

CycloneDX is the dominant machine-readable format for both Software Bills of Materials (SBOM) and Cryptographic Bills of Materials (CBOM). Chapter 7 established CBOM schema and the **SBOM merge strategy** (§7.18): correlate package components to cryptographic implementations, propagate library versions to algorithm support matrices, and elevate application-specific crypto that SBOM alone cannot infer.

Build pipeline integration extends that merge from **periodic discovery** to **continuous emission**:

### 17.3.1 Pipeline stages and artefact types

| Stage | CycloneDX output | Enrichment source | Consumer |
|-------|------------------|-------------------|----------|
| **Dependency resolve** | SBOM with library components | Package lockfiles, Maven/npm graphs | Transitive crypto detection |
| **Static analysis** | CBOM components for app-layer crypto | SAST rules (JWT `alg`, JWE `enc`) | Algorithm literal detection |
| **Container build** | Merged SBOM + base image scan | Registry base image attestations | OpenSSL/BoringSSL version |
| **Policy gate** | Validated CBOM subset | Enterprise policy service | Merge/deploy block |
| **Deploy** | Runtime-enriched CBOM | Cloud KMS APIs, cert-manager status | Inventory repository |
| **Post-deploy** | Verification delta report | TLS scan, runtime attestation | Drift detection |

GlobalSync's pipeline treated CycloneDX JSON as the **wire format** between tools — normalising SPDX inputs from legacy vendors into CycloneDX before merge. Meridian's GRC platform ingested CycloneDX exports; engineering gates operated on the same schema the programme office reported to supervisors.

### 17.3.2 Minimum build-time CBOM component fields

Extending Chapter 7 §7.10 and Chapter 10 §10.15, build-emitted components should include:

| Field | Required at gate | Source |
|-------|------------------|--------|
| `bom-ref` | Yes | Build system UUID |
| `type` | Yes | `library`, `application`, `container`, `firmware` |
| `name` / `version` | Yes | Package or image digest |
| `algorithm_name` | Yes | SAST or inherited from base image |
| `quantum_vulnerable` | Yes | Policy lookup table |
| `policy_profile_id` | Yes (Ch 10) | Config manifest |
| `agility_tier` | Yes (Ch 10) | Self-declared + gate verification |
| `hlm_phase` | If hybrid (Ch 11) | Config manifest |
| `hybrid_construction_ref` | If hybrid (Ch 11) | ADR linkage |
| `h2_trigger_type` / `h2_trigger_value` | If H1 (Ch 11) | Architecture metadata |
| `provider_id` | Yes | Provider registry |
| `confidence` | Yes | `verified` at build; `inferred` for transitive |

**Schema discipline:** Programmes fail when each pipeline stage invents ad hoc JSON. GlobalSync published a **CycloneDX gate profile** — a JSON Schema subset defining required fields per service class. Non-compliant BOMs failed before policy logic ran — reducing false positives from malformed metadata.

### 17.3.3 SBOM-to-CBOM merge in CI

Chapter 7 §7.18 described estate-level merge. CI/CD implements merge **per build**:

1. **Generate SBOM** from dependency graph (Syft, CycloneDX CLI, native build tools).
2. **Scan base image** — correlate `openssl`, `libssl`, `boringssl` components.
3. **Apply algorithm support matrix** — OpenSSL 3.2+ with ML-KEM provider enabled vs 3.0 without.
4. **Merge application CBOM** from SAST and config manifests.
5. **Deduplicate** by `bom-ref` and component hash.
6. **Annotate transitive flag** — components not directly declared but present in image.
7. **Emit merged CBOM** as build artefact stored alongside container digest.

Meridian's container gate blocked promotion when merged CBOM showed `quantum_vulnerable=true` on signing operations without approved `policy_profile_id` — connecting dependency reality to agility policy.

> **Architect's Decision**
>
> **Treat SBOM as input to CBOM, never as substitute.** A microservice with zero crypto libraries in SBOM may still invoke Cloud KMS, mutual TLS via service mesh, or JWT validation with keys from a sidecar. Build pipelines must **enrich** from config manifests and cloud API metadata — not declare "no crypto" from empty SBOM alone.

---

## 17.4 The CI/CD Cryptographic Verification Pipeline

**Figure 17.1 — CI/CD Cryptographic Verification Pipeline**

```
  Developer          CI Pipeline                    Policy / Inventory           Production
  ---------          -----------                    ------------------           ----------
      |                    |                                  |                      |
      |-- git push ------->|                                  |                      |
      |                    |-- SBOM generate                  |                      |
      |                    |-- SAST crypto rules              |                      |
      |                    |-- base image scan                |                      |
      |                    |-- merge SBOM -> CBOM             |                      |
      |                    |-- agility harness (Ch 10)        |                      |
      |                    |                                  |                      |
      |                    |-- policy gate ------------------>| policy service       |
      |                    |<-- pass/fail + violations -------|                      |
      |                    |                                  |                      |
      |                    | [fail] -> block merge            |                      |
      |                    | [pass] -> sign artefact          |                      |
      |                    |                                  |                      |
      |                    |-- publish CBOM artefact -------->| CBOM repository      |
      |                    |-- deploy ------------------------|--------------------->|
      |                    |                                  |-- KMS enrich         |
      |                    |                                  |-- TLS scan           |
      |                    |<-- runtime verify delta ---------|                      |
      |                    |                                  |                      |
      |                    | [drift] -> alert / block promote |                      |
```

**Production brief — Figure 17.1:** Horizontal swim-lane diagram with four lanes (Developer, CI Pipeline, Policy/Inventory, Production). Gate diamond after policy service call with red fail path to blocked merge and green pass path through artefact signing. Annotate data artefacts: CycloneDX JSON, harness report SHA-256, signed container digest. Include callout box for Chapter 10 `crypto-agility-verify` job and Chapter 11 hybrid field validation step. Runtime verify delta should show dashed feedback loop to CBOM repository with `confidence` downgrade on drift.

The pipeline is not a single tool — it is an **orchestrated control system**. GlobalSync implemented it in GitLab CI with OPA (Open Policy Agent) evaluating CycloneDX input against Rego policies versioned alongside algorithm matrix rows. Meridian used Azure DevOps with custom gate tasks writing evidence to the GRC evidence store. Tool choice matters less than **gate ordering, artefact integrity, and fail-closed semantics**.

### 17.4.1 Gate ordering principles

| Order | Gate | Rationale |
|-------|------|-----------|
| 1 | **Schema validation** | Malformed BOM wastes policy compute; confuses developers |
| 2 | **SBOM/CBOM merge completeness** | Missing base image scan leaves transitive blind spot |
| 3 | **AGL-01 static analysis** | Fast feedback on developer code |
| 4 | **Agility test harness** | Functional verification before policy evaluation |
| 5 | **Policy evaluation** | Algorithm matrix, HLM phase, profile registry |
| 6 | **Hybrid field validation** | Chapter 11 mandatory attributes for hybrid deploys |
| 7 | **Artefact signing** | Only signed builds promote |
| 8 | **Post-deploy runtime verify** | Catch config drift and infrastructure overrides |

Reordering gates for convenience — running policy before harness — produced false failures in GlobalSync's pilot when policy service lagged profile updates. Marcus Chen mandated harness-first ordering: functional truth before policy syntax.

### 17.4.2 Policy-as-code implementation

GlobalSync implemented cryptographic policy as **versioned Rego bundles** evaluated by Open Policy Agent. Each merge request uploaded CycloneDX JSON to the OPA sidecar; the sidecar returned structured violations with remediation links — not opaque "policy failed" messages. Example violation output:

```
violation: AGL-07
component: bom-ref:pkg:maven/com.globalsync/tenant-audit@2.1.0
detail: hlm_phase=H0 below minimum H1 for workload_class=payment-adjacent
remediation: https://developer.globalsync.internal/crypto/profiles/gs-api-sign-v1
```

Meridian adopted equivalent logic in Azure Policy for Kubernetes manifests — `crypto_profile` ConfigMap keys validated against approved profile catalogue before admission controller allowed pod schedule. Both organisations stored **policy bundle version** in deploy evidence — enabling auditors to answer "which rule set applied to build 2027-03-14.087?" without archaeologising Git history.

Policy-as-code does not replace crypto governance board authority — it **implements** board-approved matrix rows. When NIST publishes errata or enterprise elevates ML-KEM parameter set, governance approves matrix change; platform engineering ships policy bundle within five business days; regression fixtures verify known-good builds still pass.

### 17.4.3 Infrastructure-as-code cryptographic scanning

Application repositories are half the supply chain. **Infrastructure-as-code** repos declare TLS versions on load balancers, cert-manager `ClusterIssuer` profiles, API gateway cipher policies, and service mesh `PeerAuthentication` modes. These declarations require the same gate discipline as application code.

| IaC resource | Cryptographic content | Scan approach |
|------------|----------------------|---------------|
| `aws_lb_listener` | TLS policy string | Terraform static analysis |
| `cert-manager.io/Certificate` | Key algorithm, issuer | Kubernetes manifest lint |
| `istio` DestinationRule | mTLS mode | Mesh config policy |
| `cloudflare` spectrum | Edge cipher suite | Provider-specific rules |
| Ansible `openssl_*` tasks | Cipher configuration | Task content scan |

GlobalSync's platform team ran **IaC crypto lint** on separate pipeline from application CI — weekly schedule on infrastructure repos with same policy service API. Meridian discovered hybrid TLS enabled in microservice ConfigMaps but **disabled at load balancer** — IaC scan caught mismatch before production deploy; application-only gates would have missed it.

Northfield applied IaC scanning to **WAN concentrator** Terraform modules — not plant-floor PLCs. Scope discipline prevented false confidence: OT device configs in vendor binary formats remain firmware BOM workflow.

### 17.4.4 Artefact integrity and provenance

CBOM artefacts attached to builds must be **tamper-evident**:

- Store CycloneDX JSON in artefact repository with build ID linkage.
- Sign CBOM with CI code-signing key — separate from application signing key.
- Record SHA-256 in change ticket and GRC evidence store.
- Reject deploy if registry digest does not match signed CBOM component hash.

Apex classified pipelines extended provenance with **dual-signature** on build manifests — corporate IT and NSS enclave signing keys on separate hardware. Unclassified CI could not sign artefacts destined for classified runtime — boundary enforced at promotion gate, not discovered at deployment.

---

## 17.5 Build-Time versus Runtime Verification

No single verification method covers cryptographic posture. Effective programmes combine build-time gates (shift-left) with runtime verification (production truth). Chapter 7 Table 7.1 mapped discovery methods to asset types; this table maps **verification timing** to assurance claims.

**Table 17.1 — Build-Time versus Runtime Verification Methods**

| Verification method | Build-time | Runtime | Detects | Misses | GlobalSync usage |
|---------------------|------------|---------|---------|--------|------------------|
| **SAST algorithm literals** | **Strong** | None | Hardcoded `ECDSA`, `RSA` strings | Runtime-loaded providers; reflection | AGL-01 merge gate |
| **Dependency / SBOM scan** | **Strong** | None | Transitive OpenSSL, BouncyCastle versions | Custom native libs; vendored blobs | Base image merge |
| **Config manifest lint** | **Strong** | Partial | `policy_profile_id`, `hlm_phase` declaration | Live config override by ops | Pre-deploy gate |
| **Agility test harness** | **Strong** | None | Profile round-trips, negotiation logic | Production traffic edge cases | `crypto-agility-verify` |
| **Container image scan** | **Strong** | None | Image digest crypto stack | Running container drift | Registry promotion |
| **TLS / network scan** | None | **Strong** | Production ciphersuites, cert chains | App-layer JWE/JWT | Weekly cron + post-deploy |
| **Cloud KMS API** | Partial | **Strong** | Live key algorithm, HSM module | Customer-managed keys in VM | Deploy enrichment |
| **Binary / firmware hash** | **Strong** | **Strong** | Firmware version, signature scheme | Supply chain before build | Northfield OTA |
| **RASP / runtime agent** | None | Medium | Dynamic algorithm calls | Performance overhead; coverage gaps | Pilot only |
| **Penetration test** | None | **Strong** | Downgrade, misconfiguration | Point-in-time; not continuous | Quarterly sample |
| **Partner negotiation logs** | None | **Strong** | Hybrid handshake rates | Internal east-west if not logged | Ingress telemetry |

**Drift detection:** GlobalSync automated comparison when build-time CBOM `algorithm_name` differed from runtime TLS scan — flagging `confidence=conflicted` per Chapter 7 §7.16 conflict workflow. Drift triggered PagerDuty to platform engineering, not blame assignment to the developer who merged three weeks prior.

> **Dependency Alert**
>
> **Build-time green does not mean runtime green.** Meridian discovered six services passing container gates but negotiating classical-only TLS in production — ops had overridden service mesh policy during an incident and never restored hybrid profile. Runtime verification caught drift; build-time gates alone would have certified a false posture until annual pen test.

---

## 17.6 Static Analysis: Capabilities and Limits

Static analysis is the highest-ROI build-time control for **application-layer agility** (Chapter 10 AGL-01). It is also the most misunderstood — teams assume SAST equals cryptographic compliance.

### 17.6.1 What static analysis detects well

| Pattern | Example | Tool approach |
|---------|---------|---------------|
| Algorithm string literals | `Signature.getInstance("SHA256withECDSA")` | Regex + AST rules |
| Banned imports | `import org.bouncycastle.jce.provider` | Allow-list diff |
| JWT algorithm claims | `algorithm: "RS256"` in code | Semgrep-style rules |
| Hardcoded key material | PEM blocks in source | Secret scanners (adjacent) |
| Deprecated API usage | `RSA/ECB/PKCS1Padding` | Rule catalogue |
| Missing profile reference | Direct `Cipher.getInstance` without wrapper | Custom enterprise rules |

GlobalSync published **AGL-01 rule packs** for Java, Go, Python, and TypeScript — engineering teams extended rules for internal frameworks. Rules versioned in Git; changes followed crypto governance board approval.

### 17.6.2 What static analysis cannot detect

| Blind spot | Why | Compensating control |
|------------|-----|----------------------|
| **Runtime configuration** | Ops changes ConfigMap without code change | Runtime config audit; drift scan |
| **HSM / KMS offload** | Crypto happens outside process | Cloud API enrichment |
| **Reflection and dynamic loading** | `Class.forName(providerClass)` | Runtime instrumentation; code review |
| **Transitive native libraries** | JNI, bundled `.so` files | Container SBOM + binary scan |
| **Firmware crypto** | Source not in application repo | Firmware BOM (§17.8) |
| **Vendor closed-source SDKs** | Binary-only distribution | Vendor attestation + sampling |
| **Protocol downgrade at peer** | Client offers weak algorithms | Negotiation telemetry |
| **Infrastructure TLS termination** | Load balancer config external to repo | IaC scan + runtime TLS probe |

Meridian's security architecture documented **SAST coverage limits** in the agility standard — preventing procurement and audit from treating AGL-01 clean scan as full cryptographic assurance.

### 17.6.3 False positives and developer trust

Aggressive SAST rules erode compliance culture. GlobalSync tuned rules through **three pilot sprints**:

1. **Week 1–2:** Report-only mode — measure violation volume.
2. **Week 3–4:** Block new violations only — grandfather existing debt with CBOM `hardcoded_algorithm_flag=true`.
3. **Week 5+:** Block all violations in Wave 1+ repos; retrofit epics for grandfathered debt.

Violation half-life became a steering metric (Chapter 10 §10.23) — target under thirty days for new findings.

> **Regulatory Lens**
>
> DORA ICT risk management expects **documented control effectiveness**, not merely control existence. Meridian's examination pack included SAST coverage matrix with explicit blind spots and compensating controls — supervisors accepted honest limits more readily than claims that "automated scanning covers all cryptography."

---

## 17.7 Transitive Dependencies and Base Image Governance

Chapter 7 §7.8 established transitive dependency risk. CI/CD gates operationalise **platform accountability** — when forty percent of container CBOMs inherit vulnerable OpenSSL from one golden image, remediation is a **single platform patch**, not four hundred application epics.

### 17.7.1 Base image as cryptographic policy object

| Control | Owner | Gate behaviour |
|---------|-------|----------------|
| **Golden image catalogue** | Platform engineering | Deploy fails if image not in catalogue |
| **Minimum library versions** | Platform engineering | ML-KEM-capable OpenSSL in production images |
| **Image signing** | Platform engineering | Unsigned images rejected at admission |
| **SBOM attestation** | Platform engineering | Missing SBOM blocks catalogue promotion |
| **Vulnerability SLA** | Security operations | CVE gates adjacent to crypto gates |

Marcus Chen elevated base image refresh to **Wave 0 infrastructure** (Chapter 11 §11.3) — microservices could not deploy hybrid TLS until ingress and base images supported ML-KEM. Application teams were blocked by platform dependency — intentionally. CDG analysis showed base image as fan-in node to 180 services.

### 17.7.2 Transitive remediation workflow

1. **Detect** — merged CBOM flags `transitive=true` on `openssl 1.1.1`.
2. **Aggregate** — platform dashboard groups by base image digest.
3. **Assign** — remediation ticket to platform engineering, not app team.
4. **Patch** — golden image rebuild with updated library.
5. **Cascade** — dependent services rebuild on new base; CBOM auto-updates.
6. **Verify** — runtime TLS scan confirms estate-wide negotiation improvement.

GlobalSync reduced mean time to remediate transitive OpenSSL findings from **47 days** (app-team model) to **9 days** (platform model) — illustrative internal metric cited in Q3 2027 steering.

### 17.7.3 Dependency confusion and typosquatting

PQC migration increases **new package adoption** — ML-KEM wrappers, experimental provider bindings. Supply chain attacks target confusion between similarly named packages. Gates should include:

- Internal package registry proxy with approval workflow.
- Typosquat detection on crypto-related package names.
- SBOM component hash comparison against known-good publisher signatures.

Meridian blocked external PyPI direct access for production builds — all packages through Artifactory with cryptographic library allow-list.

---

## 17.8 Firmware BOM and Embedded Cryptography

Cloud-native CI/CD patterns do not transplant cleanly to OT and embedded systems. Northfield Energy Systems illustrates **firmware bill of materials** governance — where cryptography lives in signed blobs, bootloader keys, and vendor toolchains rather than Maven dependencies.

### 17.8.1 Firmware BOM contents

| Component | Firmware BOM field | Northfield example |
|-----------|-------------------|-------------------|
| Bootloader | `signature_algorithm`, `public_key_id` | ECDSA-P256 → ML-DSA transition |
| Application firmware | `firmware_version`, `signing_key_id` | Compressor controller v4.2.1 |
| OTA package | `dual_signature_flag`, `lms_state` | LMS M=24 stateful hash (Ch 6) |
| Engineering workstation | `signing_tool_version` | Vendor IDE 3.1.4 |
| Secure element | `key_slot_map` | TPM 2.0 EK certificate |
| Communication module | `tls_library`, `cert_store_bytes` | 8 KB cert store limit |

James Whitfield's OT security team extended enterprise CycloneDX schema with Chapter 7 OT fields — `device_class`, `site_id`, `maintenance_window`, `firmware_signing_scheme`.

### 17.8.2 Firmware supply chain gates

Northfield could not run GitLab CI on air-gapped plant floors. Gates adapted to **artefact promotion workflow**:

1. **Vendor delivers** signed firmware + vendor SBOM/CBOM attestation.
2. **Lab harness** verifies dual-signature path and LMS state continuity (Chapter 6).
3. **Enterprise firmware registry** ingests artefact with CycloneDX metadata.
4. **Change control board** reviews CBOM row — algorithm, key ID, HLM phase.
5. **Maintenance window** deploys with rollback partition validated.
6. **Post-deploy survey** confirms version and cert store on device.

Gate failure example: vendor firmware used **classical-only code signing** without approved dual-signature construction — CCB rejected promotion until vendor delivered H1-compliant package per Chapter 6 stateful signature policy.

### 17.8.3 Engineering workstation integrity

Firmware supply chain attacks often target **signing workstations** rather than devices. Northfield gates included:

- Workstation CBOM row with signing tool versions.
- Hardware security module requirement for production signing keys.
- Quarterly workstation re-imaging with verified golden image.
- Separation of development signing keys from production keys.

> **Dependency Alert**
>
> **Firmware BOM without workstation governance is theatre.** A perfect device CBOM does not prevent compromise if engineering laptops sign production firmware with exportable keys stored in plaintext. Northfield's CCB treats workstation rows as **blocking dependencies** for production firmware promotion — same rigour as device rows.

---

## 17.9 NIST SSDF Alignment

NIST SP 800-218 (*Secure Software Development Framework*, SSDF) provides vocabulary for mapping PQC supply chain gates to **recognised secure development practices** — valuable for federal contractors, FedRAMP operators, and enterprises aligning with NIST CSF software supply chain guidance.

**Table 17.2 — SSDF Practice Groups Mapped to PQC CI/CD Controls**

| SSDF practice | SSDF activity (abridged) | PQC CI/CD control | Evidence artefact |
|---------------|--------------------------|-------------------|-------------------|
| **PO.1** | Define security requirements | Crypto-agility NFRs in backlog templates | ADR with AGL IDs |
| **PO.3** | Communicate requirements | Developer portal profile catalogue | Portal version hash |
| **PW.1** | Secure design | Policy profile selection at design gate | Design review sign-off |
| **PW.4** | Reuse vetted components | Provider registry + base image catalogue | Registry export |
| **PW.5** | Harden build environment | Signed CI artefacts; segregated signing keys | Build attestation log |
| **PW.6** | Secure software warehouse | Container registry admission control | Promotion audit trail |
| **PW.7** | Tamper-resistant packaging | Dual-signature firmware; signed CycloneDX | Manifest signatures |
| **RV.1** | Vulnerability identification | SBOM CVE scan + crypto policy scan | Scan report |
| **RV.2** | Vulnerability assessment | Quantum-vulnerable algorithm flag review | CBOM dashboard |
| **RV.3** | Vulnerability mitigation | Platform transitive remediation workflow | Ticket + CBOM update |
| **PS.1** | Defect review | Gate failure root cause analysis | Post-incident record |
| **PS.2** | Defect remediation | AGL-01 violation half-life metric | Steering dashboard |

Apex Defense mapped SSDF practices to **CMMC Level 2** evidence for commercial IT pipelines — PQC gates listed as supplementary controls atop existing SSDF implementation. Classified NSS pipelines maintained separate SSDF workbook with enclave-specific evidence — aggregate metrics reported to programme office without cross-boundary artefact merge.

**PO.1 extension for PQC:** Security requirements must include **algorithm lifecycle** obligations — not only vulnerability SLAs. GlobalSync's backlog template added mandatory fields: `policy_profile_id`, `hlm_phase`, `substitution_window_days`.

> **Architect's Decision**
>
> **Map PQC gates to SSDF activities already in your secure SDLC — do not create a parallel "PQC SDLC."** Apex's CMMC assessors reviewed PQC controls as extensions of PW.5 and PW.7 — familiar evidence formats, new policy rules. Programmes inventing bespoke PQC-only audit trails duplicate effort and confuse assessors.

---

## 17.10 Agility Gates in CI/CD

Chapter 10 defined agility NFRs and SDLC stage gates. Chapter 17 implements **AGL-01 through AGL-08** in pipeline automation — the enforcement layer Marcus Chen's programme required.

### 17.10.1 Gate-to-NFR mapping

| NFR | CI/CD implementation | Block merge? | Block deploy? |
|-----|------------------------|--------------|---------------|
| **AGL-01** | SAST algorithm literal rules | Yes | Yes |
| **AGL-02** | Dependency allow-list vs provider registry | Yes | Yes |
| **AGL-03** | Config manifest lint for `policy_profile_id` | Yes | Yes |
| **AGL-04** | Substitution drill artefact freshness | No | Yes (if stale > 365d) |
| **AGL-05** | Harness negotiation failure injection tests | Yes | Yes |
| **AGL-06** | CBOM row ID linkage in deploy manifest | No | Yes |
| **AGL-07** | HLM phase ≥ policy minimum | Yes | Yes |
| **AGL-08** | Telemetry schema validation | No | Warning → ticket |

### 17.10.2 The GlobalSync non-agile crypto rejection

The chapter-opening incident exemplified **AGL-01 enforcement at scale**. Before gates, GlobalSync found:

| Metric | Pre-gate (Q4 2026) | Post-gate (Q2 2027) |
|--------|--------------------|---------------------|
| New PRs with algorithm literals | 23% | < 1% |
| Services with `hardcoded_algorithm_flag=true` | 61% | 28% (retrofit in progress) |
| Architecture review crypto findings per sprint | 8.4 average | 1.2 average |
| Time-to-merge for compliant PRs | +4 min (gate overhead) | Accepted |

The four-minute overhead — SBOM generation, harness, policy evaluation — was **programme ROI**: one avoided retrofit epic pays for years of CI compute.

Marcus Chen refused **gate bypass** except through CISO-approved break-glass with 72-hour remediation ticket — bypass events reported to steering committee as KPI (target: zero).

### 17.10.3 Break-glass and emergency deploy protocol

Break-glass exists because production incidents outpace policy bundle updates — but ungoverned break-glass destroys programme credibility. GlobalSync's protocol:

1. **Incident commander** declares crypto gate bypass request with ticket ID.
2. **CISO delegate** approves within 30 minutes — algorithm matrix exception logged.
3. **Deploy proceeds** with `gate_bypass=true` metadata on artefact.
4. **Automated report** to steering committee within 24 hours — no silent bypass.
5. **Remediation sprint** opens within 72 hours — bypass expires; redeploy without bypass or service quarantined.

One break-glass event in 2027 Q1 — payment reconciliation hotfix during profile service outage — remediated in 41 hours. Steering committee accepted incident narrative because **evidence trail was complete**. Meridian adopted identical protocol with CAB post-mortem integration for DORA operational resilience documentation.

### 17.10.4 Grandfathering and retrofit linkage

Brownfield services with existing violations received CBOM `hardcoded_algorithm_flag=true` and wave plan retrofit epic linkage. Gates blocked **new** violations immediately; grandfathered debt burned down through Wave 1 15% capacity allocation (Chapter 10 §10.7.6). PRs touching grandfathered files triggered **ratchet rule** — modified lines must comply even if file not fully retrofitted.

---

## 17.11 Hybrid CBOM Fields in Pipeline Gates

Chapter 11 §11.10 defined extended HLM CBOM attributes — `hybrid_construction_ref`, `h2_trigger_type`, `h2_trigger_value`, `hybrid_negotiation_rate_threshold`. Pipeline gates enforce these fields **before hybrid deployments promote** — preventing "hybrid in production, undocumented in inventory."

### 17.11.1 Validation rules (illustrative)

```
IF deployment declares hlm_phase IN ('H1', 'H2') AND hybrid_construction_ref IS NULL:
    FAIL "Hybrid deployment requires approved construction reference"

IF hlm_phase == 'H1' AND (h2_trigger_type IS NULL OR h2_trigger_value IS NULL):
    FAIL "H1 requires H2 trigger per Chapter 5 / 11"

IF hybrid_construction_ref NOT IN approved_constructions_policy:
    FAIL "Construction not in enterprise hybrid policy"

IF policy_profile_id NOT MATCHES hybrid_construction_ref.profile_binding:
    FAIL "Profile/construction mismatch"
```

GlobalSync embedded rules in OPA policies versioned with hybrid policy PDF hash — auditors traced gate logic to signed policy document.

### 17.11.2 Meridian architecture-review-to-pipeline handoff

Elena Vasquez's programme required **hybrid intent filing** at architecture review before merge approval. Meridian's pipeline validated:

- ADR attachment with hybrid construction citation.
- CBOM draft row in pre-production repository.
- `h2_trigger_value` populated with measurable exit criterion.

Thomas Bergström's DORA examination reviewers traced retail API H1 exit (Chapter 11 §11.14) to CBOM exports with per-endpoint `hlm_phase` — pipeline enforcement prevented declarative-only hybrid claims.

### 17.11.3 Negotiation telemetry feed

Chapter 11 hybrid exit criteria depend on **measured negotiation rates**. GlobalSync ingress telemetry tagged `tenant_id` × `negotiated_group` — weekly ETL refreshed CBOM `hybrid_negotiation_rate` field. Pipeline deploy gate for H2-scoped services checked rolling four-week rate against policy threshold — blocking H2 promotion if rate insufficient without exception register entry.

---

## 17.12 GlobalSync: Container Gates and Multinational Overlay

GlobalSync's full pipeline architecture demonstrates **enterprise-scale supply chain cryptography** — forty jurisdictions, two hundred microservices, multi-tenant isolation.

### 17.12.1 Registry admission control

| Control | Implementation |
|---------|----------------|
| **Signed images only** | Notary v2 + internal CA |
| **CBOM artefact required** | CycloneDX JSON attached to image manifest |
| **Policy evaluation** | OPA at admission webhook |
| **Tenant tag validation** | `jurisdiction`, `regulatory_overlay` present |
| **Base image digest pin** | Floating tags rejected in production namespaces |

### 17.12.2 Multinational policy evaluation

EU tenant workloads evaluated against **DORA overlay** — additional gate rules for ICT third-party crypto dependencies. US tenants evaluated against **FedRAMP-oriented** controls for federal logistics contracts. Policy service returned **jurisdiction-scoped rule set** — not one global rule that over-constrained or under-protected either region.

Marcus Chen's team measured **gate rejection rate by jurisdiction** — EU rejections initially 3× US due to stricter third-party dependency rules. Programme response: EU-specific golden images with pre-approved vendor SDK versions — reducing rejection without weakening controls.

### 17.12.3 Customer-visible attestation

GlobalSync published **customer-facing CBOM summaries** (Chapter 7 §7.14) generated from same pipeline artefacts — customers merged provider summary with tenant CBOM for complete trust boundary picture. Pipeline integrity directly supported **commercial trust** — sales engineering cited signed CBOM artefacts in eleven tenant security reviews (Chapter 11 §11.14).

---

## 17.13 Meridian: Container Gates in Regulated Banking

Meridian Mutual Bank adapted GlobalSync patterns to **DORA-regulated change management** — gates produced examination evidence, not only merge blocking.

### 17.13.1 Gate evidence package

Each production deploy attached:

1. CycloneDX CBOM JSON (SHA-256 in ticket).
2. AGL-01 SAST report (clean or waived with exception ID).
3. Agility harness summary PDF.
4. Policy evaluation log with algorithm matrix version.
5. ADR reference linking `policy_profile_id`.

CAB approval workflow rejected closure if evidence package incomplete — internal audit finding from 2027 Q2 (Chapter 10 §10.11.4) strengthened this linkage.

### 17.13.2 Payment workload enhanced gates

Payment HSM-touching services encountered **additional rules**:

- FIPS 140-3 `validation_module_id` required in CBOM.
- Production profiles must reference validated module path — lab-only providers blocked.
- HSM firmware version correlated against vendor attestation quarterly.

Elena's steering committee treated payment gate failures as **Wave 0 blockers** — same priority as HSM firmware chain in CDG.

### 17.13.3 Container gate rejection case

Meridian blocked promotion of a corporate banking microservice when merged CBOM showed `bouncycastle 1.70` transitive dependency with quantum-vulnerable default provider for JWT signing — application code used enterprise crypto service, but **fallback path** in error handler invoked direct BouncyCastle. SAST missed fallback — harness caught it. Gate failure drove refactor to fail-closed without classical fallback — aligning with Chapter 10 downgrade resistance principles.

---

## 17.14 Northfield: Firmware Supply Chain Integration

Northfield's firmware supply chain connects Chapter 6 stateful signatures, Chapter 7 OT discovery, and Chapter 10 agility ceilings into **maintenance-window governance**.

### 17.14.1 Vendor contractual gates

Northfield procurement (Chapter 16 pattern) required firmware vendors to supply:

- CycloneDX firmware BOM or structured equivalent within 30 days of release.
- Algorithm deprecation notice ≥ 180 days before signing key change.
- Dual-signature support per enterprise construction reference.
- LMS state management documentation for hash-based schemes.

Vendor non-compliance blocked **artefact registry promotion** — not negotiable at maintenance window.

### 17.14.2 OTA pipeline controls

```
Vendor blob -> lab verify (signature + LMS state) -> registry ingest ->
CCB approval (CBOM row review) -> staged partition B -> maintenance deploy ->
site survey confirmation -> CBOM confidence=verified
```

James Whitfield rejected **"flash first, document later"** — OT culture clash resolved when NIS2 essential-entity reporting made firmware CBOM **supervisory evidence**, not engineering paperwork.

### 17.14.3 WAN versus field device separation

Northfield's WAN concentrators (Tier 3 agility) ran standard container gates. Field devices (Tier 0–2 ceiling) used firmware BOM workflow — **do not apply container gates to PLC firmware** without adaptation. Programme dashboard segmented gate metrics by `device_class` — preventing false confidence from IT pipeline success while OT remained classical.

---

## 17.15 Apex: Classified Build Pipelines

Apex Defense Technologies operates **parallel build pipelines** — commercial IT, defense industrial base, and NSS enclaves — with cryptographic boundary enforcement at promotion, not documentation pretence.

### 17.15.1 Pipeline separation model

| Pipeline | Network | Signing key | CBOM repository | Policy namespace |
|----------|---------|-------------|-----------------|------------------|
| **Commercial IT** | Corporate | Corporate CI key | Corporate GRC | `apex-corp-*` |
| **DIB programmes** | Segmented | Program-specific HSM | Program vault | `apex-dib-*` |
| **NSS enclave** | Air-gapped | NSS CI HSM | Classified repository | `apex-nss-*` |

Cross-enclave **artefact promotion is forbidden** — corporate pipeline success does not authorize NSS deployment. Priya Nair's architecture board rejected "build once, classify later" — classification boundary is a **compile-time and sign-time** property.

### 17.15.2 NSS gate enhancements

- CNSA 2.0 parameter floor validation (ML-KEM-1024, ML-DSA-87 minimum).
- Contingency profile presence check without activation.
- Dual-person rule on signing key use — procedural control outside automation.
- Harness execution in classified lab — summary artefact exported; logs remain enclave.

### 17.15.3 CMMC evidence linkage

Apex's CMMC assessment package mapped pipeline controls to **SC.L2-3.13.11** (cryptographic protection) and supply chain practices — PQC gates listed as compensating enhancements during NIST IR 8547 transition. Assessors reviewed corporate pipeline evidence; NSS evidence reviewed in classified facility — **no merge**, aggregate compliance metrics only.

### 17.15.4 Cross-reference index for shared vendors

When HSM manufacturer shipped firmware affecting both corporate and NSS products, Apex maintained **cross-reference index** (Chapter 7 §7.15) — vendor CVE and algorithm notice linked to separate enclave remediation tickets without exposing NSS asset attributes to corporate CBOM.

> **Regulatory Lens**
>
> **Classified programmes cannot rely on corporate CI/CD evidence for NSS accreditation.** Apex's programme office reports aggregate gate pass rates to board — "NSS pipeline: 100% policy compliance, 0 bypass events" — without transferring CycloneDX rows across classification boundaries. Corporate supply chain success is necessary for enterprise efficiency; it is not sufficient for NSS assurance.

---

## 17.16 Supplier Artefacts and Third-Party Ingestion

Chapter 16 encodes supplier CBOM obligations contractually. Chapter 17 implements **technical ingestion** — supplier SBOM/CBOM enters enterprise gates as first-class input.

### 17.16.1 Supplier artefact promotion workflow

1. Vendor delivers CycloneDX + signature at release.
2. Enterprise virus scan and schema validation.
3. Algorithm normalisation (Chapter 7 §7.11).
4. Policy evaluation against supplier overlay rules.
5. Promotion to approved supplier artefact registry.
6. Application builds reference approved versions only.

Meridian blocked integration of a hosted payment SDK when vendor SBOM showed undeclared classical TLS dependency contradicting attestation — procurement escalation per Chapter 16 vendor evidence checklist.

### 17.16.2 SBOM merge across organisational boundaries

Mergers and acquisitions introduce **foreign SBOM formats** — Chapter 2 previewed M&A cryptographic due diligence. Pipeline gates should include:

- Format normalisation to CycloneDX.
- Confidence downgrade to `attested` until sampling verification.
- 100-day inherited estate review gate before production promotion.

GlobalSync acquired a regional warehouse automation vendor in 2027 — inherited firmware BOMs entered Northfield-style workflow despite corporate IT acquisition context.

### 17.16.3 Continuous supplier monitoring

Contractual SBOM delivery at release is necessary but not sufficient. GlobalSync implemented **continuous supplier monitoring** for critical SDKs:

- Subscribe to vendor security advisories mapped to SBOM component hashes.
- Re-evaluate supplier CycloneDX when vendor publishes new version — even if enterprise has not upgraded.
- Flag algorithm deprecation notices against in-production supplier components.
- Quarterly reconciliation: supplier attestation vs ingested SBOM hash match.

Meridian's hosted payment processor changed TLS termination certificate from ECDSA-P256 to ML-DSA-65 without enterprise application deploy — **supplier monitoring** detected change via weekly TLS probe of vendor endpoint; CBOM row updated; TRADE Ecosystem score improved without Meridian code change. Discovery lived in supply chain monitoring, not developer merge request.

> **Migration Moment**
>
> *"Our vendor said they're PQC-ready in the sales call — do we need pipeline gates?"*
>
> Sales readiness is not production readiness. Gates evaluate **artefacts** — CycloneDX rows, signed firmware, harness results — not roadmap slides. Meridian's vendor assessment (Chapter 16) feeds supplier registry; Chapter 17 gates consume registry status. A vendor without machine-readable SBOM may remain approved for non-crypto services; crypto-touching services fail promotion until artefacts arrive.

---

## 17.17 Pipeline Metrics and Steering Committee

Supply chain gates generate **programme KPIs** for Part V steering rhythm (Chapter 15).

**Table 17.3 — Supply Chain Cryptography KPIs**

| KPI | Definition | Target (illustrative) | Owner |
|-----|------------|----------------------|-------|
| **Gate pass rate** | % builds passing crypto gates first attempt | Trending up; baseline 70% | Platform engineering |
| **Bypass count** | Deployments with break-glass gate bypass | 0 | CISO |
| **CBOM freshness** | % production with build CBOM < 30 days old | 95% | Programme office |
| **Transitive MTTR** | Days to remediate platform transitive findings | < 14 days | Platform engineering |
| **Drift incidents** | Build/runtime algorithm mismatches per month | Decreasing | Security operations |
| **Supplier artefact lag** | Days vendor SBOM late vs release | < 30 days | Vendor management |
| **Firmware CBOM coverage** | % OT devices with verified firmware BOM | ≥ 80% critical sites | OT security |
| **AGL-01 violation half-life** | Days to clear new literal violations | < 30 days | Domain engineering |

Marcus Chen presented gate metrics monthly — rejection rate increases during policy upgrades expected and healthy; **bypass count** non-negotiable.

---

## 17.18 Common Failure Modes

| Failure mode | Symptom | Remediation |
|--------------|---------|-------------|
| **Gate theatre** | Gates exist; bypass default | Break-glass audit; steering KPI |
| **SBOM-only compliance** | No application-layer CBOM | Enrich per §17.3 |
| **Stale golden images** | Transitive findings recur | Image catalogue ownership |
| **Wiki standards** | Gates not linked to NFR IDs | Traceability matrix |
| **Runtime blindness** | Build green; production classical | Table 17.1 balance |
| **OT container pretence** | PLC gates copied from K8s | Firmware BOM workflow |
| **Classification leakage** | NSS artefacts in corporate repo | Pipeline separation |
| **Vendor PDF substitution** | No machine-readable ingest | Chapter 16 clauses + schema gate |
| **Policy lag** | Gate rules behind algorithm matrix | Version-linked policy bundles |
| **Developer circumvention** | Local builds skip CI | Registry admission only path to prod |

---

## 17.19 Integration with Programme Governance

Chapter 15 programme office owns **gate policy approval** — not individual rule authoring in platform teams. Crypto governance board approves algorithm matrix changes; platform engineering implements gate rules within 5 business days. Separation prevents **shadow policy** in unreviewed OPA bundles.

**Change control:** Gate rule changes follow same CAB discipline as production cryptography changes — with regression test suite against known-good and known-bad CycloneDX fixtures.

**Audit sampling:** Internal audit pulls five production deploys quarterly — verifies evidence package integrity, CBOM hash match, harness freshness. Meridian pattern (Chapter 10) extended to supply chain artefacts.

### 17.19.1 Developer experience and programme adoption

Gates fail programmes when developers experience them as **opaque obstruction**. GlobalSync invested in developer experience parallel to gate deployment:

- **Local pre-flight CLI** — engineers run `crypto-gate check` before push; same logic as CI.
- **Violation messages** with profile catalogue deep links — not generic "policy failed."
- **Golden-path templates** with pre-wired harness and CycloneDX emission — new services inherit compliance.
- **Office hours** — crypto engineering squad weekly; gate failures reviewed as learning, not discipline.
- **Latency budget** — gate overhead capped at 6 minutes p95; platform team optimises SBOM cache.

Marcus Chen measured **developer satisfaction** on quarterly survey — gate acceptance rose from 34% to 71% after local pre-flight shipped. Programme adoption requires gates to be **predictable**, not merely correct.

### 17.19.2 Handoff to assurance programme

Supply chain gates establish **what cryptography entered production and under which policy profile**. Chapter 18 assurance programme validates **whether accredited modules and interoperability constraints** are satisfied — FIPS 140-3 transitions, penetration testing, red team scenarios. The handoff artefact is signed CycloneDX with `validation_module_id` populated — gates block production deploy when module ID missing for regulated workloads; assurance programme audits module ID against CMVP status quarterly.

---

## 17.20 Figure Production Brief

**Figure 17.1** (§17.4): Full-width CI/CD pipeline swim-lane — four lanes, seven gate diamonds, colour-coded pass/fail paths. Include inset showing CycloneDX component structure with hybrid fields highlighted.

**Figure 17.2 — Build-Time / Runtime Verification Coverage Map:** Venn diagram — build-time circle (SAST, SBOM, harness, config lint), runtime circle (TLS scan, KMS API, telemetry), intersection labelled "drift detection." Annotate blind spots from §17.6.2 outside both circles with compensating control callouts.

**Figure 17.3 — Organisational Gate Topology:** Hub-and-spoke — GlobalSync container registry at centre; spokes to Meridian payment enhanced gates, Northfield firmware registry, Apex NSS air-gapped pipeline. Shared: CycloneDX schema, policy service API. Separated: signing keys, repositories, namespaces.

---

## 17.21 Apply in Your Organisation

1. **Map current CI/CD stages** — identify where SBOM is generated today and where it is not.
2. **Adopt CycloneDX** as wire format between scan, gate, and CBOM repository — normalise SPDX inputs.
3. **Implement SBOM-to-CBOM merge** per Chapter 7 §7.18 in build pipeline, not only estate scan.
4. **Deploy AGL-01 SAST rules** in report-only mode; ratchet to blocking over 4–6 weeks.
5. **Integrate agility test harness** (Chapter 10) before policy gate — functional truth first.
6. **Publish build-time vs runtime matrix** (Table 17.1) with compensating controls for blind spots.
7. **Establish base image catalogue** with cryptographic minimum versions — platform-owned transitive remediation.
8. **Enforce Chapter 11 hybrid CBOM fields** in deploy gates for H1/H2 services.
9. **Map gates to NIST SSDF** practices for assessor-ready evidence (Table 17.2).
10. **Segment OT firmware BOM workflow** — do not copy container gates verbatim (Northfield pattern).
11. **Separate classified pipelines** if applicable — Apex boundary at signing, not documentation.
12. **Contract supplier machine-readable SBOM/CBOM** (Chapter 16) with schema validation at ingestion.
13. **Add supply chain KPIs** to steering dashboard — bypass count, CBOM freshness, drift rate.
14. **Run gate bypass drill** — verify break-glass produces visible steering committee report within 24 hours.
15. **Store signed CBOM artefacts** with deploy evidence — SHA-256 in change tickets for audit retrieval.

---

## 17.22 Chapter Summary

- Most enterprise cryptography lives in **dependencies, base images, firmware, and vendor SDKs** — not application code visible to architecture review alone.
- **CI/CD integration** transforms CBOM from periodic discovery into continuous enforcement — the operational bridge from Parts III–IV artefacts to Part V programme authority.
- **CycloneDX** unifies SBOM and CBOM in build pipelines; Chapter 7 merge strategy applies per-build with enrichment from config, cloud APIs, and SAST.
- **Build-time and runtime verification** are complementary — Table 17.1 defines assurance boundaries; drift detection catches ops overrides and infrastructure divergence.
- **Static analysis** delivers high ROI for agility (AGL-01) with documented blind spots — HSM offload, reflection, firmware, and peer downgrade require compensating controls.
- **Transitive dependency governance** is platform engineering accountability — golden images and catalogue promotion remediate at fan-in nodes.
- **Firmware BOM** extends supply chain gates to OT — Northfield's maintenance-window workflow with vendor attestation and LMS state verification.
- **NIST SSDF alignment** maps PQC gates to recognised practices — extending PO, PW, RV, PS activities rather than inventing parallel process.
- **GlobalSync** demonstrated CI/CD rejection of non-agile crypto — AGL-01 at merge scale with four-minute overhead and measurable violation reduction.
- **Meridian** linked container gates to DORA examination evidence — payment workloads with enhanced FIPS validation rules.
- **Apex** maintained separated classified build pipelines — CNSA floors, dual-person signing, aggregate reporting without cross-boundary artefact merge.
- **Chapter cross-references:** SBOM merge (Ch 7 §7.18), agility gates and NFRs (Ch 10), hybrid CBOM fields (Ch 11 §11.10), supplier clauses (Ch 16).

**Next:** Chapter 18 — FIPS Validation, Testing, and Assurance — defines the assurance programme for regulated environments where supply chain gates establish *what deployed* and validation programmes prove *what modules are accredited*.

---

*Chapter 17 — References*

- CycloneDX Contributors. (2024). *CycloneDX Cryptographic Bill of Materials (CBOM) specification* and *Authoritative Guide to SBOM*. OWASP Foundation.
- National Institute of Standards and Technology. (2022). *SP 800-218* — Secure Software Development Framework (SSDF) Version 1.1. U.S. Department of Commerce.
- National Institute of Standards and Technology. (2024). *SP 1800-38* — Migration to post-quantum cryptography (supply chain and inventory practices). NCCoE.
- National Institute of Standards and Technology. (2024). *FIPS 203* (ML-KEM), *FIPS 204* (ML-DSA), *FIPS 205* (SLH-DSA). U.S. Department of Commerce.
- OpenSSF. (2024). *SLSA* supply chain levels for software artefacts — provenance and build integrity framework.
- OWASP. (2024). *CycloneDX integration guide for CI/CD pipelines*. OWASP Foundation.
- European Parliament and Council. (2022). *Digital Operational Resilience Act (DORA)* — Regulation (EU) 2022/2554; ICT risk management tool requirements.
- Prado, M., et al. (2023). *NIST IR 8419* — Hardware and software supply chain risk management (cross-reference for firmware BOM).
- GlobalSync Logistics / Meridian Mutual Bank / Northfield Energy Systems / Apex Defense Technologies programme office. (2027). *Illustrative CI/CD gate and firmware supply chain evidence* (composite case study).
- Thomas, D., & Nystrom, R. (2020). *Enterprise integration patterns for policy-as-code in deployment pipelines* — OPA/Rego gate design (industry practice synthesis).

---

*Proceed to Chapter 18: FIPS Validation, Testing, and Assurance.*
