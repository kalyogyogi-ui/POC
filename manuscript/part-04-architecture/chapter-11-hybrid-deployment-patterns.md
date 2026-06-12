# Chapter 11
# Hybrid Deployment Patterns

---

Thomas Bergström's team at Meridian Mutual Bank had a working hybrid TLS configuration in the laboratory by February 2026. OpenSSL negotiated X25519MLKEM768 successfully. The security architecture slide deck declared the pilot complete.

Production told a different story. Of **4.2 million** customer API handshakes analysed over thirty days, **11.3%** of unique client fingerprints failed to negotiate the hybrid group — not because the cryptography was wrong, but because three legacy mobile banking integrations, two corporate treasury middleware products, and a partner webhook platform sent ClientHello messages that middleboxes truncated before the hybrid extension could complete. The CDG showed those clients fanning into twelve downstream payment workflows. Thomas could not declare H1 exit at 90% compatibility without a tiered endpoint strategy, tenant outreach, and compensating controls for fixed embedded clients.

This chapter teaches the deployment patterns Meridian, GlobalSync, Northfield, and Apex used to move hybrid cryptography from laboratory success to governed production — each pattern bound to the Hybrid Lifecycle Model (HLM) from Chapter 5, sequenced against wave plans from Chapter 9, and gated by blocking nodes from Chapter 8.

---

## 11.1 The Hybrid Lifecycle Model: Full Deployment Specification

Chapter 5 introduced the Hybrid Lifecycle Model as **policy architecture**. Part IV requires the **deployment specification** — what engineers implement, what architects approve, and what programme offices measure. HLM is not a label applied after deployment; it is a lifecycle contract signed at change approval.

**Table 11.1 — HLM Phase Specification (Deployment View)**

| Phase | Name | Cryptographic posture | Entry gates | Exit criteria (measurable) | CBOM `hlm_phase` |
|-------|------|----------------------|-------------|--------------------------|------------------|
| **H1** | Protective Hybrid | Classical + PQC combined per approved construction | Algorithm matrix approval; hybrid policy signed; `h2_trigger_value` populated; infrastructure buffer assessment complete | Ecosystem threshold met **or** calendar/vendor trigger fired per policy | `H1` |
| **H2** | Transitional Hybrid | PQC-primary; classical permitted only for documented exceptions | H1 exit for scope; enterprise policy deprecates classical component for new deployments | Zero new classical-only deployments in scope without exception; classical sunset date reached | `H2` |
| **H3** | PQC-Native | Quantum-vulnerable PKC removed | H2 exit; validation complete; partner alignment confirmed | CBOM scan confirms zero disallowed algorithms; penetration test clean | `H3` |

### H1 deployment requirements

Every H1 production deployment must satisfy **seven mandatory controls** before change approval:

1. **Approved construction** — combination listed in enterprise hybrid policy (Chapter 5 §5.7); `hybrid_construction_ref` populated in CBOM.
2. **H2 trigger** — `h2_trigger_type` and `h2_trigger_value` non-empty; change management rejects approvals without them.
3. **Classical component identification** — `classical_component` attribute names algorithm subject to sunset (e.g. `ECDH_X25519`, `ECDSA_P256`).
4. **Infrastructure assessment** — handshake buffer, MTU, proxy, and middlebox limits documented for the deployment path.
5. **Rollback plan** — classical-only fallback tested; rollback does not require emergency CAB.
6. **Monitoring** — production telemetry distinguishes hybrid vs classical negotiation rates by client cohort.
7. **Exception linkage** — clients unable to negotiate hybrid classified Tier B or C (Chapter 5 §5.18) with documented remediation or risk acceptance.

H1 is the phase most enterprises occupy in 2026–2028. It is also the phase where **permanent hybrid** failure mode originates — when teams treat H1 as destination rather than protective interim.

### H2 deployment requirements

H2 begins when H1 exit criteria are met for a **defined scope** — not necessarily the entire estate. Scope may be: a service tier (`api-public-v2`), business unit, geographic region, or protocol class.

H2 operational rules:

- **New deployments** in scope use PQC-only where ecosystem readiness (TRADE E ≥ 4) permits.
- **Existing hybrids** remain until classical sunset date or per-system remediation plan completes.
- **SDLC gates** reject classical-only PKC in new code paths within H2 scope.
- **Quarterly CBOM review** identifies systems that should have transitioned but remain H1 — trigger breach metric (Chapter 5 §5.26).

GlobalSync declared H2 entry for its Tier A API cohort when measured hybrid negotiation exceeded **92%** of production handshakes — not when engineering declared pilot success.

### H3 deployment requirements

H3 is disallowance-aligned target state. Verification is **evidence-based**, not declarative:

- Automated CBOM scan with zero quantum-vulnerable PKC in scope (algorithm policy from Chapter 4).
- Sampled penetration test confirming no classical-only regression on in-scope endpoints.
- Partner and tenant notification archive for scopes that required contractual amendment.
- Regulatory evidence package updated where supervisory review applies (Meridian DORA pattern, Chapter 5 §5.11).

> **Architect's Decision**
>
> **Scope HLM phases per workload class, not per enterprise.** Apex maintains independent HLM tracks for NSS and corporate IT (Chapter 5 §5.13). Northfield tracks Gulf Coast compressor firmware separately from Midwest RTU rollout. A single enterprise-wide "we are in H2" claim obscures blocking nodes and produces audit findings.

### HLM phase transition diagram

**Figure 11.1 — HLM Phase Transitions with Programme Gates**

```
                    +------------------+
                    |  Policy + CBOM   |
                    |  baseline ready  |
                    +--------+---------+
                             |
                             v
              +------------------------------+
              |  H1: Protective Hybrid       |
              |  Classical + PQC combined      |
              +--------------+---------------+
                             |
            +----------------+----------------+
            | ecosystem      | calendar /     |
            | threshold met  | vendor trigger   |
            v                v                |
   +----------------+  +----------------+    |
   | H2: Transitional|  | Risk acceptance|    |
   | PQC-primary     |  | (bounded H1)   |    |
   +--------+--------+  +----------------+    |
            |                                  |
            | classical sunset + validation    |
            v                                  |
   +------------------+                        |
   | H3: PQC-Native   |<-----------------------+
   | Zero disallowed  |
   | quantum-vuln PKC |
   +------------------+
```

**Production brief — Figure 11.1:** Swim-lane diagram with solid arrows for normal transitions and dashed arrow for bounded H1 extension via risk acceptance. Annotate each gate with CBOM field names (`h2_trigger_value`, `exception_id`).

---

## 11.2 Pattern Selection: When Hybrid Is Mandatory, Optional, or Prohibited

Not every system requires hybrid deployment. Misapplied hybrids add operational cost without security benefit. Pattern selection follows a decision sequence:

| Condition | Recommendation |
|-----------|----------------|
| External-facing protocol with heterogeneous clients | H1 hybrid (TLS, partner APIs) |
| Closed ecosystem; all endpoints controlled | Evaluate PQC-native skip of H1 |
| Long-lived embedded clients; no update path | Classical with risk acceptance **or** parallel endpoint tier — not forced hybrid on fixed clients |
| NSS / CNSA workloads | CNSA parameter profile; accelerated H2/H3 per contract |
| Internal east-west with uniform fleet | PQC-native when TRADE E ≥ 4 |
| Firmware / code signing | Dual signature H1 (Chapter 6); distinct from TLS combiner logic |

**TRADE Ecosystem readiness (E)** gates **production date**, not **pattern selection**. Low E means start architecture and vendor escalation now; deploy hybrid when modules validate — not defer design until vendors ship.

> **Dependency Alert**
>
> **CDG blocking nodes override pattern enthusiasm.** GlobalSync could not deploy hybrid client certificates until partner mTLS policy allowed ML-DSA profiles (Chapter 8). Local hybrid TLS on the server succeeded fourteen times in staging; ecosystem blocking prevented production until Wave 0 resolved partner trust.

---

## 11.3 Hybrid TLS: X25519 + ML-KEM-768

TLS 1.3 hybrid key exchange is the reference H1 pattern for enterprise external services. The construction combines:

- **Classical component:** X25519 (Elliptic Curve Diffie-Hellman on Curve25519)
- **PQC component:** ML-KEM-768 (FIPS 203, security category 3)
- **Combiner:** Concatenation of shared secrets per IETF hybrid specification — both secrets contribute to the TLS 1.3 key schedule

Security intuition: confidentiality holds if **either** component remains unbroken. An adversary capable of solving ECDH on Curve25519 but not ML-KEM — or vice versa — cannot derive the session key. This is the **OR combiner** model appropriate for transitional deployment.

### Handshake sequence

**Figure 11.2 — Hybrid TLS 1.3 Handshake (Conceptual)**

```
Client                                    Server
  |                                         |
  |------ ClientHello (hybrid groups) ----->|
  |<----- ServerHello (selected group) -----|
  |<----- Certificate chain ----------------|
  |<----- CertificateVerify ----------------|
  |<----- Finished -------------------------|
  |                                         |
  |  Key share: X25519 pubkey + ML-KEM      |
  |             ciphertext                  |
  |                                         |
  |------ Client key share --------------->|
  |<----- Server key share -----------------|
  |                                         |
  |  Combined shared secret -> HKDF ->      |
  |  traffic keys                           |
  |------ Finished ------------------------>|
  |<----- Finished -------------------------|
  |                                         |
  |====== Encrypted application data =======|
```

**Production brief — Figure 11.2:** Sequence diagram with byte-size annotations on key share messages. Highlight ClientHello extension size growth vs classical-only.

### Cipher suite and group policy

Enterprise TLS policy must name **specific groups**, not vague "PQC-enabled TLS 1.3":

| Policy element | H1 approved example | H2 transition example | H3 target |
|----------------|--------------------|-----------------------|-----------|
| Key exchange group | `X25519MLKEM768` (standards-track identifier) | PQC-preferred; classical fallback for exception clients only | ML-KEM-768 only (or enterprise-selected PQC group) |
| Certificate signature | ML-DSA-65 or transitional ECDSA per PKI roadmap (Chapter 13) | ML-DSA required for new certs | ML-DSA only |
| Protocol version | TLS 1.3 minimum | TLS 1.3 minimum | TLS 1.3 minimum |
| Prohibited | Ad hoc hybrid combinations; export-grade classical fallbacks | New ECDSA end-entity certs in H2 scope | All quantum-vulnerable PKC |

Monitor IETF and CA/Browser Forum publications before production — identifier strings finalise with specifications. Policy owners assign a **standards watch owner** with quarterly review cadence (Chapter 22 preview).

### Certificate chain considerations

Hybrid key exchange does not eliminate classical certificate signatures during early H1. Meridian's pilot used **hybrid key exchange with classical ECDSA-P256 end-entity certificates** while the issuing CA migrated to ML-DSA profiles — a common staged posture. The CDG flagged the manufacturing CA as a blocking node: twelve services could not advertise ML-DSA server certificates until the CA issued compatible profiles.

### Library and platform selection

Hybrid TLS is not a cipher string alone — it is a **stack contract** across library, operating system, hardware offload, and observability agents.

| Layer | Selection criterion | Common pitfall |
|-------|--------------------|----------------|
| TLS library | Standards-track hybrid group support; FIPS mode if required | Custom OpenSSL build missing ML-KEM provider |
| Language bindings | JVM, Go, Rust wrappers expose group negotiation | Binding lags core library — Node.js services blocked |
| Hardware offload | SmartNIC / load balancer terminates hybrid | Offload firmware version caps extension parsing |
| Observability | APM agents parse ClientHello | Agent crash on unknown extensions — false outage |
| Container base image | Image refresh cadence vs library patch | Golden image six months stale at deployment |

GlobalSync embedded **minimum library versions** in platform engineering standards (Chapter 10) — microservices could not deploy to production clusters until the mesh ingress controller validated hybrid negotiation on the target image baseline. Marcus Chen treated library version as **Wave 0 infrastructure**, not per-team choice.

### Session resumption and operational continuity

TLS 1.3 session tickets and zero-round-trip (0-RTT) modes interact with hybrid deployment in ways pilots often ignore:

- **Session tickets** issued under classical-only handshakes may not resume against hybrid-only endpoints after H2 transition — plan ticket rotation and dual-mode resumption during H1.
- **0-RTT data** carries replay risk independent of hybrid posture; enterprises disabling 0-RTT for other reasons may simplify hybrid cutover by eliminating a parallel code path.
- **Connection coalescing** on HTTP/2 and HTTP/3 multiplexes sessions across origins with different crypto policies — CDN configuration must align per-origin HLM phase.

Meridian disabled 0-RTT on payment-adjacent API paths before hybrid cutover — reducing variables during the first production week. GlobalSync retained 0-RTT on read-only Tier A endpoints after soak testing confirmed hybrid resumption compatibility on its CDN vendor's Q2 2026 release.

> **Dependency Alert**
>
> **Certificate renewal cycles trigger hybrid regressions.** A renewed ECDSA certificate with an expanded intermediate chain can push combined ClientHello size over middlebox limits that hybrid key shares already approached. Integrate PKI renewal (Chapter 13) with hybrid buffer assessment — not only initial deployment.

---

## 11.4 Combiner Security and Construction Requirements

Hybrid constructions live or die on **combiner correctness**. Enterprise policy must prohibit engineer-assembled combinations not on the approved list.

### Combiner models

| Model | Construction | Security property | Enterprise use |
|-------|-------------|-------------------|----------------|
| **Concatenation (OR)** | `K = K_classical || K_pqc` fed to KDF | Secure if either component secure | TLS hybrid key exchange; IKE hybrids |
| **Dual signature (AND for verification)** | Both signatures must verify | Secure if either signature scheme unforgeable under respective assumptions | Code signing, firmware, CMS |
| **Nested / encrypted** | PQC wraps classical key | Varies by construction | Application-layer hybrids; use with crypto review |

**Prohibited without cryptanalysis review:**

- XOR of shared secrets without domain separation
- Optional PQC — clients that skip PQC when server allows classical-only on same endpoint
- Same algorithm family twice (ML-KEM-768 + ML-KEM-1024) mistaken for hybrid diversity

### Dual signature semantics (code signing)

Dual signature hybrids use different logic than key-exchange combiners. For firmware and code signing, **both** signatures must verify. Security holds if **either** signature scheme remains unforgeable — an attacker must break **both** to forge convincingly under a policy requiring dual verification.

Apex's NSS firmware pipeline required:

```
image_hash = SHA-384(firmware_binary)
signature_classical = ECDSA_P384.sign(image_hash, key_classical)
signature_pqc = ML_DSA_87.sign(image_hash, key_pqc)
cms_structure = DualSignedCMS(signature_classical, signature_pqc)
```

Bootloader verification policy: `verify(signature_classical) AND verify(signature_pqc)`. Transition to ML-DSA-only occurs when H2 exit criteria remove classical verification support from the bootloader policy table.

### Apex manufacturing and supply chain integration

Dual-signature deployment spans **signing ceremony**, **distribution**, and **verification** — each a CDG node:

```
[Manufacturing HSM partition]
        | signs (dual)
        v
[Firmware image in artifact repo] ---- verifies ----> [Device bootloader]
        |                                                    ^
        | signs                                              | trusts
        v                                                    |
[Update server manifest] ---------------------------- [Field tech USB path]
```

Priya Nair's Wave 0 included **bootloader policy table update** — without verifier support for ML-DSA, dual-signed images would not boot regardless of signing ceremony success. CDG node `bootloader-policy-v4` blocked H1 for six subsystem product lines until vendor delivered signed bootloader update packages.

Manufacturing lines could not pause for crypto migration. Apex staged **parallel signing keys**:

| Key role | H1 posture | Custody |
|----------|-----------|---------|
| `fw-sign-classical` | ECDSA-P384 | FIPS 140-3 L3 partition A |
| `fw-sign-pqc` | ML-DSA-87 | FIPS 140-3 L3 partition B |
| `fw-sign-dual-policy` | CMS profile requiring both | Ceremony: dual control both partitions |

Ceremony duration increased from **12 minutes to 19 minutes** per signing batch (*illustrative*) — key management team adapted shift scheduling before NSS programme board noticed throughput impact.

Supply chain verification extended to **subcontractor integrator acquisition** (Chapter 5 §5.32): inherited firmware without `hlm_phase` metadata received 100-day assessment before merging into Apex overlay — preventing false H3 claims from acquired marketing materials.

> **Architect's Decision**
>
> **Never mix combiner models in one policy sentence.** TLS key exchange uses concatenation OR-security. Code signing uses dual-signature AND-verification. Application-layer hybrids may use envelope encryption — a third pattern. Separate policy annexes per use case prevent engineers from applying TLS combiner logic to firmware.

### Combiner security assumptions for architecture review

Architecture boards need not prove reductionist security — they must **verify constructions are standards-backed** and **assumptions match use case**.

| Question | TLS concatenation | Dual signature |
|----------|-------------------|----------------|
| What breaks if classical fails? | PQC component must hold | Forgery if PQC broken |
| What breaks if PQC fails? | Classical component must hold | Forgery if classical broken |
| Domain separation | KDF extracts independent keys from combined input | Distinct signature containers |
| Downgrade risk | Server must not accept classical-only from clients requiring hybrid | Verifier must require both signatures |
| Known attacks to monitor | Side-channel on either component | Padding oracle on CMS parsers — separate from combiner |

NIST IR 8547 treats hybrids as **transitional**, not as a permanent alternative to PQC-native deployment. Enterprise policy should cite **standards-track constructions** — IETF hybrid TLS, vendor-validated IKE profiles, CMS dual-signature profiles — rather than in-house combinations justified by expedience.

### Downgrade attack prevention

Hybrid deployment introduces **negotiation downgrade** as an operational attack surface distinct from cryptanalysis:

1. **Server misconfiguration** — hybrid group listed but classical-only preferred by sort order; telemetry shows hybrid rate near zero while policy claims H1.
2. **Strip attack on path** — middlebox removes PQC extensions; client falls back to classical if server permits — *unless* policy enforces hybrid-only for in-scope clients.
3. **Client impersonation** — legacy client population on exception endpoint becomes attractor for fraud — Tier C endpoints require compensating controls (Meridian pattern).

Mitigations:

- Enforce **hybrid-only** on primary H1 endpoints for Tier A/B clients after migration window.
- Log `negotiated_group` per request with alert on classical-only to primary hostname.
- Separate hostname or mTLS policy for Tier C — never silent downgrade on unified URL.

Basescu et al. (2024) document production deployment friction including client fragmentation and middlebox interference — enterprise programmes should treat their findings as **validation requirements**, not as reasons to defer hybrid indefinitely.

---

## 11.5 Performance, Bandwidth, and Handshake Size

Hybrid deployment is not free. Programme offices that ignore operational impact encounter production incidents unrelated to cryptanalysis.

### Illustrative size and timing impacts

*Figures are planning estimates for architecture assessment; measure on target infrastructure before production approval.*

| Element | Classical baseline (X25519) | Hybrid (X25519 + ML-KEM-768) | Delta |
|---------|------------------------------|-------------------------------|-------|
| Client key share | ~32 bytes | ~1,216 bytes (32 + 1,184 ML-KEM) | ~+1,184 bytes |
| Server key share | ~32 bytes | ~1,184 bytes (ML-KEM ciphertext) | ~+1,152 bytes |
| ClientHello size | ~200–400 bytes typical | + extension overhead | +200–500 bytes typical |
| Handshake CPU (server) | Baseline 1× | 1.3–2.5× (*platform dependent*) | Measure in validation |
| Session establishment latency | Baseline | +0.5–3 ms LAN; +5–15 ms high-latency mobile | Monitor P95/P99 |

### Infrastructure impact checklist

| Component | Assessment question | Failure symptom |
|-----------|--------------------|-----------------|
| Load balancer | Maximum ClientHello / ServerHello buffer? | Silent connection drop; no TLS alert |
| IDS/IPS | Reassembly limit for fragmented ClientHello? | Intermittent failures on mobile networks |
| SSL inspection proxy | Hybrid extension awareness? | Corporate users fail; external users succeed |
| CDN edge | Origin handshake pass-through limits? | Geographic inconsistency |
| API gateway | HTTP/2 + TLS buffer interaction? | Spurious `GOAWAY` under load |
| VPN concentrator | Different limits than HTTPS path? | Northfield IKE fragmentation (§11.7) |

Meridian's production incident traced to a **corporate SSL inspection appliance** with a 4,096-byte handshake buffer — sufficient for classical TLS but insufficient when hybrid extensions and large certificate chains combined on treasury middleware paths. Infrastructure assessment before H1 approval would have caught the limit.

### Bandwidth at scale

GlobalSync modelled API tier handshake overhead for board investment review:

| Metric | Value (*illustrative*) |
|--------|------------------------|
| New TLS sessions per day (public API) | 38 million |
| Additional bytes per hybrid handshake (round trip key shares) | ~2,336 bytes |
| Incremental daily bandwidth | ~89 GB |
| CDN egress cost impact | <0.4% of monthly egress budget |

Bandwidth rarely blocks hybrid TLS at enterprise scale; **buffer limits and CPU on inspection paths** dominate. OT and SCADA environments with constrained WAN links require per-site modelling — Northfield's historian VPN paths used dedicated MTU tuning.

---

## 11.6 VPN Hybrid IKE

TLS lessons do not transfer directly to IPsec. IKEv2 hybrid key exchange introduces fragmentation behaviour, rekey timing interactions, and hardware accelerator limitations distinct from HTTPS load balancers.

Northfield Energy Systems' Wave 1 programme (Chapter 5 §5.17; Chapter 9) targeted WAN VPN concentrators protecting SCADA historian traffic — TES 5 HNDL exposure on archives with thirty-year confidentiality horizons.

### Northfield IKE hybrid programme

| Phase | Activity | Outcome |
|-------|----------|---------|
| Assessment | Two concentrator models tested with vendor ML-KEM hybrid IKE profiles | Model A passed validation; Model B lacked hardware offload — refresh required |
| Capital | $2.8M hardware refresh (*illustrative*) | Model B replaced in Wave 1 budget |
| Pilot | Single non-production site; 30-day monitoring | Fragmentation on one microwave backhaul path — MTU reduced 1,432 → 1,400 |
| H1 production | Regional staging; classical + ML-KEM hybrid IKE | H2 trigger: 2030-01-01 calendar + Model A fleet 100% |
| Exception | Legacy site refresh deferred to 2029 | Six-month risk acceptance; network segmentation compensating control |

**Table 11.2 — IKE Hybrid vs TLS Hybrid Differences**

| Factor | TLS hybrid | IKE hybrid |
|--------|-----------|------------|
| Framing | TCP — fragmentation less common on LAN | UDP — fragmentation common on WAN |
| Middleboxes | HTTP proxies, CDNs | ISP NAT, OT WAN optimisers |
| Rekey impact | Session resumption varies | Periodic IKE rekeys — CPU spike |
| Client uniformity | Highly heterogeneous | Often controlled CPE — but OT exceptions |
| CDG node type | `terminates` on load balancer | `terminates` on concentrator; `implements` on CPE |

James Whitfield reported VPN migration to the board as **threat reduction on historian archives** — not compliance checkbox. Regulatory evidence (NERC CIP) attached test reports demonstrating integrity controls remained effective post-migration.

> **Dependency Alert**
>
> **CPE firmware blocks IKE hybrid more often than concentrator upgrades.** Northfield's concentrator supported hybrid IKE six months before remote RTU VPN clients accepted the profile. CDG edge `implements` on CPE nodes gated rollout per region — not per enterprise calendar.

---

## 11.7 Dual Code Signing and Firmware Hybrids

Apex Defense Technologies operates dual-track architecture: NSS workloads under CNSA 2.0; corporate IT under NIST IR 8547. Firmware signing is the convergence point where **dual signature H1** is mandatory for NSS before single-algorithm H3.

### Apex dual-signature firmware architecture

| Component | H1 posture | H2 trigger | H3 target |
|-----------|-----------|------------|-----------|
| NSS weapon system firmware | ECDSA-P384 + ML-DSA-87 dual | CNSA 2030 firmware milestone | ML-DSA-87 only |
| Corporate IT device firmware | ECDSA-P256 + ML-DSA-65 dual | 2030 deprecation anchor | ML-DSA-65 only |
| Third-party subsystem integrator (acquired) | Assessment required — no CBOM | 100-day inherited estate review | Per parent overlay |

Priya Nair's programme office maintained **separate HLM swim lanes** in board reporting — corporate IT at H1 for VPN while NSS firmware reached H2 on selected platforms. Forced synchronisation across classification boundaries would have delayed NSS compliance or relaxed corporate ecosystem gates inappropriately.

### Stateful hash signatures in OT

Northfield's compressor firmware programme used **LMS** (SP 800-208) for H1 on devices that could not accommodate ML-DSA signature sizes — a distinct pattern from dual signature but still H1-governed. Chapter 6 develops stateful signature operational constraints; this chapter records the HLM binding:

- `hybrid_construction_ref`: `SP800-208-LMS-SHA256-M24`
- `classical_component`: `ECDSA_P256` (legacy verification during transition)
- `h2_trigger_type`: `vendor`
- `h2_trigger_value`: `compressor_vendor_lms_GA + 180d integration`

---

## 11.8 Application-Layer Hybrids

Application-layer cryptography — JWT signing, JWE key encryption, database field encryption, message queue authentication — is the largest CBOM discovery gap (Chapter 7 §7.3). Hybrids at this layer lack the standardisation maturity of TLS; enterprise policy must be more prescriptive.

### Approved application-layer H1 patterns

| Pattern | H1 construction | Standards / review basis | Sunset trigger |
|---------|----------------|--------------------------|----------------|
| JWT signing | Dual `alg` headers unacceptable — use `x5c` chain with ML-DSA cert **or** parallel token issuers | OIDC profile update; parallel issuers preferred | IdP ecosystem threshold |
| JWE key encryption | RSA-OAEP-2048 wrapped ML-KEM shared secret | NIST-approved combiner review | KMS PQC-native |
| Field-level encryption | Envelope: classical KEK wraps ML-KEM-derived DEK | Crypto board review required | KMS H3 |
| gRPC mTLS | Same as TLS hybrid on channel | Service mesh policy | Mesh fleet upgrade |
| Webhook HMAC + signature | HMAC-SHA256 + ML-DSA body signature (dual verify) | Organisation-defined CMS profile | Partner notification |

Meridian's payment topic signing migrated through **parallel issuers**: classical JWT issuer (`issuer-classical.meridian.internal`) and hybrid issuer (`issuer-pqc.meridian.internal`) behind API gateway routing — avoiding non-standard JWT `alg` duplication that broke legacy validators.

### Application-layer discovery and CBOM linkage

Chapter 7 established that application-layer crypto is the largest inventory gap. Hybrid deployment **amplifies** the gap — two algorithms per workflow instead of one.

| Workflow | CBOM rows required | HLM note |
|----------|-------------------|----------|
| JWT issuance | Signing key + cert chain + `hlm_phase` per issuer | Parallel issuers = two rows minimum |
| JWE decryption | KEK + DEK wrap algorithm | Classical KEK row sunsets at H2 |
| gRPC mTLS | Inherits mesh ingress row | Phase follows mesh policy |
| Webhook verification | Partner-specific row | May remain classical until partner migrates |

Elena Vasquez's CBOM team required **application teams to file hybrid intent** at architecture review — before merge request approval — populating `hybrid_construction_ref` and `h2_trigger_value` in the component metadata emitted to CycloneDX on build. Services deploying hybrid patterns without CBOM rows failed GlobalSync's CI/CD gate (Chapter 17 preview).

### Anti-patterns in application-layer hybrids

| Anti-pattern | Why it fails | Alternative |
|--------------|-------------|-------------|
| Dual `alg` in single JWT header | Legacy parsers reject; OIDC conformance breaks | Parallel issuers |
| Encrypt with RSA, decrypt with ML-KEM on same field | Non-interoperable rotation | Envelope with documented wrap |
| Hybrid only in test environment | Production path untested | Shadow issuer in production |
| Library default algorithm | Silent classical at scale | Explicit algorithm configuration NFR |

> **Regulatory Lens**
>
> **DORA does not prescribe hybrid application-layer patterns.** Supervisory reviewers evaluate whether encryption policies respond to cryptanalytic developments with **documented standards references and risk assessment**. Parallel token issuers with CBOM traceability satisfied Meridian's home-jurisdiction examination — ad hoc JWT extensions did not.

---

## 11.9 Hybrid Pattern Catalog

**Table 11.3 — Hybrid Pattern Catalog (Protocol × Phase × Sunset Trigger)**

| Protocol / use case | H1 construction | Typical H1 scope | H2 trigger type | H2 trigger value (examples) | H3 end state | Primary CDG node type |
|--------------------|-----------------|------------------|-----------------|----------------------------|--------------|----------------------|
| TLS 1.3 (external API) | X25519 + ML-KEM-768 | Public endpoints; partner APIs | ecosystem | `92%_client_hybrid_negotiation` | ML-KEM-only groups | `terminates` |
| TLS 1.3 (internal mesh) | X25519 + ML-KEM-768 | Service mesh ingress | vendor | `mesh_CA_ML-DSA_GA` | PQC-native mesh | `trusts` |
| IKEv2 VPN (WAN) | ECDH + ML-KEM hybrid | OT historian paths; remote site | calendar + vendor | `2030-01-01` + `CPE_firmware_100%` | PQC-only IKE | `terminates` |
| IPsec (site-to-site) | IKE hybrid + classical cert | Legacy datacentre links | dependency | `PKI_ML-DSA_profile_GA` | Full PQC IPsec | `trusts` |
| Code / firmware signing | Dual ECDSA + ML-DSA | NSS + OT firmware | calendar / CNSA | `CNSA_2030_firmware` | ML-DSA only | `signs` |
| S/MIME email | Classical + ML-DSA dual sign | Executive comms | ecosystem | `mail_gateway_PQC_GA` | ML-DSA only | `verifies` |
| JWT / OIDC | Parallel issuers (classical + PQC cert) | Customer auth | ecosystem | `95%_client_PQC_issuer` | Single PQC issuer | `signs` |
| Database field encrypt | Classical KEK wraps PQC DEK | PCI columns | dependency | `KMS_ML-KEM_native` | PQC-native envelope | `wraps` |
| HSM key wrap | Hybrid wrap per vendor profile | Payment HSM | vendor | `module_FIPS_validation` | PQC-only wrap | `implements` |
| Document signing (CMS) | Dual signature CMS | Legal contracts | calendar | `2030_deprecation` | ML-DSA only | `signs` |

Programme architects **copy this table into the enterprise architecture repository** and annotate with organisation-specific constructions — not every row applies to every estate. Rows with `dependency` triggers reference CDG blocking nodes explicitly.

---

## 11.10 CBOM Attributes and HLM Tracking

Chapter 5 defined minimum HLM CBOM attributes. Part IV adds **deployment-phase fields** consumed by change management and dashboards.

**Table 11.4 — Extended CBOM HLM Attributes**

| Attribute | Values / format | Populated at | Consumer |
|-----------|-----------------|--------------|----------|
| `hlm_phase` | H1, H2, H3 | Change approval | Dashboards; audit |
| `h2_trigger_type` | ecosystem, calendar, vendor, dependency | H1 approval | Steering committee |
| `h2_trigger_value` | Measurable string | H1 approval | Automated breach alerts |
| `classical_component` | Algorithm identifier | H1 approval | Sunset tracking |
| `pqc_component` | Algorithm identifier | H1 approval | Algorithm matrix |
| `hybrid_construction_ref` | RFC / FIPS / vendor profile ID | H1 approval | Standards traceability |
| `exception_id` | Risk acceptance link | If Tier C client or blocker | Assurance |
| `hybrid_negotiation_rate` | Percentage (telemetry) | Weekly refresh | Ecosystem gate |
| `h1_approved_date` | ISO date | Change approval | Ageing report |
| `h2_transition_date` | ISO date | H2 entry | Compliance evidence |
| `cdg_blocking_ref` | Node ID | If blocked | Wave planner |

GlobalSync automated pipeline rules:

```
IF deployment_type == 'hybrid' AND h2_trigger_value IS NULL:
    REJECT change ticket
IF hlm_phase == 'H1' AND hybrid_negotiation_rate < h2_trigger_threshold:
    FLAG 'trigger_not_met'  # informational until trigger date
IF hlm_phase == 'H1' AND today > h2_trigger_date AND h2_transition_date IS NULL:
    ESCALATE steering_committee
```

Meridian integrated `hlm_phase` distribution into the board dashboard introduced in Chapter 1 — replacing misleading "PQC pilot complete" counts with percentage of estate in H1/H2/H3 by TRADE tier.

---

## 11.11 CDG Blocking, Waves, and Hybrid Sequencing

Hybrid patterns do not deploy in CBOM sort order. Chapter 9 wave plans sequence work through **blocking nodes** (Chapter 8). Hybrid deployment follows wave membership and CDG fan-in analysis.

### Sequencing rules

1. **Wave 0** resolves blocking nodes — partner mTLS policy, root CA ML-DSA profiles, HSM firmware signing — before wide H1 TLS rollout.
2. **Wave 1** deploys H1 on TES 5 systems without unresolved upstream `trusts` or `signs` edges to classical-only anchors.
3. **Parallel tracks** permitted when CDG shows no shared blocking node — Apex NSS vs corporate IT pattern.
4. **Downstream cascade:** when a blocking node reaches H3, dependent systems inherit accelerated H2 eligibility — Meridian payment HSM chain pattern (Chapter 5 §5.9).

**Figure 11.3 — CDG Blocking and Hybrid Rollout Sequence**

```
Wave 0 (blocking)          Wave 1 (H1 deploy)         Wave 2 (H2 transition)
-----------------          --------------------         ---------------------
[Root CA ML-DSA] ---------> [API TLS hybrid] ----------> [PQC-only API tier]
       |                          ^
       | signs                    | terminates
[Partner mTLS policy] ------+-----+
       |
       +---> [200 microservice certs] --- (held until policy H1)
```

Marcus Chen's GlobalSync team held 200 microservice migrations in **"engineering complete / production blocked"** state for nine months — correct programme posture when CDG blocking node `partner-mtls-policy-v3` remained classical-only.

---

## 11.12 Case Study: Meridian Hybrid TLS Pilot

Meridian's pilot scope: **retail mobile API** (`api-retail.meridian.example`), **4.2 million** daily handshakes, DORA-regulated PII in transit, TRADE MPI 4.1, CDG fan-in to payment authorisation service.

### Phase 1 — Measurement (30 days production traffic)

| Client tier | Definition | Unique fingerprints | Handshake share | Programme action |
|-------------|------------|--------------------|-----------------|--------------------|
| A — PQC-capable | Negotiates X25519MLKEM768 | 847 | 88.7% | Include in H1 endpoint |
| B — Classical, updatable | Legacy app version; patch available | 23 | 7.2% | Tenant notification; 90-day sunset |
| C — Classical, fixed | Embedded integration; no patch | 8 | 4.1% | Risk acceptance; parallel endpoint |
| D — Unknown | Insufficient logging | 4 | <0.1% | Instrument; recategorise |

Thomas Bergström refused to average tiers — **4.1% fixed clients** on payment-adjacent workflows required compensating controls, not silent classical fallback on the primary endpoint.

### Phase 2 — Tiered endpoint architecture

| Endpoint | Construction | Clients | HLM phase |
|----------|-------------|---------|-----------|
| `api-retail.meridian.example` | Hybrid TLS H1 | Tier A + B (post-patch) | H1 |
| `api-retail-classical.meridian.example` | Classical-only (temporary) | Tier C | Exception-governed |
| `api-retail-pqc.meridian.example` | PQC-only (pilot) | Internal soak tests | H2 pilot |

Tier C endpoint carried **risk acceptance** with `exception_id` RA-2026-0147; compensating controls: IP allowlisting, enhanced fraud monitoring, six-month review; `h2_trigger_value`: `2030-01-01` or Tier C client decommission.

### Phase 3 — Middlebox remediation

Three production incidents during pilot:

1. Corporate SSL inspection buffer — appliance firmware upgrade
2. Legacy load balancer rule stripping unknown extensions — rule update
3. Partner webhook platform ClientHello truncation — partner upgraded SDK

Each incident reinforced Chapter 5's warning: **pilots on unconstrained endpoints mislead**.

### Operational runbook excerpt

Meridian published a **hybrid TLS runbook** consumed by operations centre staff — architecture patterns must survive 3 a.m. incidents:

| Symptom | Likely cause | First action | Escalation |
|---------|-------------|--------------|------------|
| Spike in classical-only to primary hostname | Client patch regression or fraud routing | Compare `client_fingerprint` to Tier registry | Security operations if unknown fingerprint |
| Sudden hybrid failure rate >5% | Middlebox or CDN change | Check change log for proxy/CDN deploy | Network team |
| Tier C endpoint traffic spike | Client misconfigured URL | Customer notification template | Customer success |
| Certificate renewal post-incident | Chain size exceeded buffer | Temporary classical endpoint **not** authorised — expand buffer | PKI team + infrastructure |

Thomas required runbook steps to reference **CBOM `asset_id`** — operators traced incidents to inventory rows without searching architecture slide decks.

### Supervisory evidence package

DORA examination readiness linked hybrid deployment to **artefacts**, not algorithms:

1. Approved hybrid policy excerpt (Chapter 5 §5.7 structure)
2. CBOM export for retail API endpoints with `hlm_phase`, `h2_trigger_value`, `exception_id`
3. Thirty-day production traffic analysis methodology
4. Tier C risk acceptance RA-2026-0147 with compensating controls
5. Middlebox remediation change tickets
6. H1 exit criteria checklist signed by CISO

Supervisory dialogue focused on **governance credibility** — whether Meridian could demonstrate measured transition, not whether ML-KEM-768 was the correct parameter set.

### Phase 4 — H1 exit assessment (month six)

| Metric | Target | Achieved |
|--------|--------|----------|
| Hybrid negotiation (primary endpoint) | 90% | 91.4% |
| Tier B migration | 100% patched or sunset | 96% — four clients in extension |
| Tier C exposure | Documented + compensating | 100% documented |
| Incidents (Sev 1/2) | 0 post-remediation | 0 |

Meridian declared **H1 exit for retail API scope** — entering H2 for Tier A/B traffic while Tier C remained on exception endpoint until decommission. Supervisory reviewers received CBOM export with `hlm_phase` per endpoint — not a single boolean "PQC enabled."

> **Migration Moment**
>
> *"We hit 91% hybrid negotiation — we're done."*
>
> H1 exit is **scope-specific** and **governance-complete**, not a single metric. Tier C clients on a classical exception endpoint, middlebox remediation evidence, and `h2_trigger_value` population are part of exit — not afterthoughts for audit.

---

## 11.13 GlobalSync: Tiered Endpoints and Tenant Cohorts

GlobalSync Logistics operates multi-tenant SaaS APIs across forty countries. Marcus Chen's team extended Meridian's tiered endpoint pattern with **tenant cohort routing** — aligning HLM phases to commercial reality.

**Table 11.5 — GlobalSync API Tier Strategy**

| Tier | Tenant profile | Endpoint policy | HLM phase (2026) | Sunset mechanism |
|------|---------------|-----------------|-------------------|------------------|
| Tier A | Cloud-native; rapid patch cycle | Single hybrid endpoint | H1 → H2 2028 | Contractual notice 90 days |
| Tier B | Updatable on-prem agents | Hybrid + migration guide | H1 | Tenant success programme |
| Tier C | Embedded fixed integrations | Dedicated classical endpoint + monitoring | H1 exception path | Contract amendment; 2.1% traffic (*illustrative*) |

GlobalSync's CDN configuration:

- **Default route:** hybrid TLS on `api.globalsync.example`
- **Tenant header route:** `X-GS-Crypto-Tier: C` → `api-classical.globalsync.example`
- **Telemetry tag:** `tenant_id` × `negotiated_group` → weekly CBOM refresh

Marcus sequenced tenant legal work **before** H1 production — two enterprise tenants required contract amendments averaging **74 days** legal cycle (*illustrative*). GDPR Article 32 documentation updated via customer security whitepaper referencing standards-track hybrid constructions.

When Tier C traffic exceeded **5%** of API volume, customer success received programme escalation — hybrid negotiation rate alone masked concentrated legacy exposure.

### Multi-CDN and geographic variance

GlobalSync operated three CDN providers for resilience. Hybrid negotiation rates varied geographically:

| Region | Hybrid rate (Tier A) | Root cause | Remediation |
|--------|---------------------|------------|-------------|
| EU-West | 94.2% | Uniform edge firmware | Baseline |
| US-East | 91.8% | One CDN PoP on stale firmware | Provider escalation |
| APAC-South | 86.1% | Mobile carrier gateway truncation | Tier B extension; local PoP tuning |
| LATAM | 88.4% | Mixed — inspection + client age | Tenant outreach programme |

Marcus refused global H1 exit until **all regions exceeded 90% on Tier A** or documented region-specific exception registers — multinational enterprises cannot average geography into a single compliance narrative.

### Customer-facing cryptography statement

GlobalSync published **cryptography statement v2.3** with semantic versioning — tenants subscribed to notifications when API tiers advanced HLM phase. Statement contents:

- Active hybrid construction reference (IETF identifier)
- Per-tier endpoint hostnames and expected client behaviour
- Tier C sunset dates where contractually committed
- Data residency note: hybrid deployment does not alter processing locations (GDPR cross-border concern separation)

Customer trust teams reported **eleven tenant-initiated security reviews** in the first quarter post-H1 — all closed with whitepaper and CBOM-summary slide, none requiring algorithm tutorial.

---

## 11.14 HLM and Hybrid Failure Modes

Chapter 5 introduced HLM failure modes at policy level. Deployment adds engineering failure modes:

**Table 11.6 — Hybrid Deployment Failure Modes**

| Failure | Phase | Symptom | Root cause | Recovery |
|---------|-------|---------|------------|----------|
| Permanent hybrid | H1 | Years in H1; no H2 transition | Missing `h2_trigger_value` | Retroactive policy; audit finding likely |
| Pilot-as-production | H1 | One load balancer "complete" | No CBOM coverage | Expand inventory; honest dashboard |
| Silent classical fallback | H1 | Server offers hybrid; falls back without logging | Misconfigured cipher priority | Fix config; add telemetry |
| Buffer truncation | H1 | Intermittent mobile failures | Middlebox limits | Infrastructure assessment |
| Combiner confusion | H1 | Dual-sign policy applied to TLS KEX | Policy gap | Separate annexes |
| False H3 claim | H3 | Marketing "quantum-safe" | CBOM scan false negative | Expand discovery |
| Forced synchronisation | H2 | NSS H2 delays corporate H1 | Matrix row missing | Parallel phase tracking |
| Partner lag | H2/H3 | Enterprise H3; partner classical | CDG external node | Partner programme |
| Exception sprawl | H2 | Hundreds of classical systems | Weak SDLC gates | Steering cap |
| Tier C neglect | H1 | Primary endpoint hybrid; hidden classical route | Uninstrumented legacy URL | Discovery; risk acceptance |

Apex documented deployment failure modes in programme risk register with **RAG status per workload class** — corporate IT amber on VPN while NSS firmware green on dual-sign H2.

---

## 11.15 Validation and Interoperability Testing

Hybrid deployment requires **validation beyond functional test** — pattern catalogue entry is necessary, not sufficient.

### Minimum test matrix for H1 approval

| Test category | Scope | Pass criteria |
|---------------|-------|---------------|
| Functional | Client ↔ server handshake | 100% success on approved client matrix |
| Interoperability | Partner / tenant sample | Zero Sev 1 failures in 7-day soak |
| Performance | P95 latency under production load | Within SLA budget |
| Rollback | Disable hybrid group | Recovery < change window |
| Buffer stress | Maximum cert chain + hybrid | No truncation on inspection path |
| Monitoring | Telemetry dashboards | `hybrid_negotiation_rate` populated |
| CBOM | Attribute completeness | All HLM fields present |

Meridian required **production traffic shadowing** — hybrid enabled on mirror endpoint receiving 5% traffic clone — before primary cutover. Northfield required **30-day OT pilot** with historian replay validation.

Interoperability testing with **partners** precedes microservice waves when CDG shows `trusts` edges to external policy nodes — GlobalSync's nine-month partner programme pattern.

### Rollback and incident response

Hybrid deployments require **tested rollback** — not theoretical classical fallback.

| Scenario | Rollback posture | HLM impact |
|----------|-----------------|------------|
| Hybrid causes Sev 1 outage | Revert to classical-only on affected endpoint | Remains H1; incident review |
| Hybrid negotiation bug in library | Pin previous library; disable hybrid group | H1 extended; vendor ticket |
| Erroneous H2 transition | Re-enable hybrid on subset | H2 scope correction |
| Post-quantum component vulnerability (hypothetical) | Emergency classical-only per incident response plan | CISO + policy committee |

Meridian tested rollback in **scheduled change window** — classical-only restoration in four minutes via load balancer policy toggle; CBOM `hlm_phase` remained H1 with incident annotation. Rollback without governance update produces **false H3** claims in stale inventory.

Northfield OT rollback was **slower by design** — VPN hybrid rollback required staged concentrator failover with historian replication pause; runbook measured **45 minutes** acceptable for OT maintenance window. OT programmes must budget rollback differently from cloud API tiers.

### Performance regression testing

| Workload | Metric | Meridian threshold | Northfield threshold |
|----------|--------|-------------------|---------------------|
| API TLS | P99 handshake latency | <15 ms increase | N/A |
| API TLS | Throughput (RPS) | <3% decrease | N/A |
| VPN IKE | Rekey time | N/A | <2× baseline |
| VPN IKE | Historian gap during rekey | N/A | Zero data loss |
| Firmware dual-sign | Sign operation time | N/A | <30s per image (line rate) |

Apex NSS firmware dual-sign increased signing time **18%** on existing HSM — within budget; corporate IT on softer SLAs might have deferred without measurement.

---

## 11.16 Governance Integration

Hybrid patterns sit at the intersection of Policy, Operational, and Architecture layers (PQC Governance Stack, Chapter 3).

### Change management integration

| Gate | Check |
|------|-------|
| Architecture review | Approved construction in Table 11.3 |
| Security review | Combiner model correct for use case |
| Change advisory board | `h2_trigger_value` present |
| Operational readiness | Rollback tested; monitoring live |
| Procurement | Vendor profile matches `hybrid_construction_ref` |

### Steering committee metrics

Reuse Chapter 5 Table 5.6 with deployment additions:

| Metric | Deployment interpretation |
|--------|--------------------------|
| `hybrid_negotiation_rate` | Ecosystem gate progress |
| Tier C traffic share | Commercial risk concentration |
| Trigger breach count | H1 systems past trigger without H2 |
| Blocking node resolution | Wave 0 progress |

### Internal audit engagement

Meridian invited internal audit to hybrid pattern walkthrough **before** production H1 — identifying three missing CBOM fields (`hybrid_negotiation_rate`, `h1_approved_date`, `cdg_blocking_ref`). Proactive engagement avoided findings; it did not avoid work.

### SDLC and architecture review gates

Chapter 10 defines crypto-agility NFRs. Hybrid patterns add **phase-specific gates**:

| Gate | Trigger | Approver | Evidence |
|------|---------|----------|----------|
| H1 intent | New external endpoint or protocol change | Security architecture | Table 11.3 row selected |
| H1 production | Change ticket to production | CAB | Seven controls checklist |
| H2 scope declaration | H1 exit criteria met | Steering committee | Telemetry report |
| H3 verification | Classical sunset complete | CISO + internal audit | CBOM scan export |

GlobalSync's pull request template included checkbox: *`h2_trigger_value` populated in CBOM component metadata* — linking developer workflow to programme governance without separate security ticket for every microservice.

### Reference architecture repository

Enterprises should maintain a **hybrid reference architecture** package — not merely policy PDFs:

- Diagrams: tiered endpoints, CDN routing, parallel issuers
- Configuration exemplars (redacted): load balancer policy snippets, mesh Gateway API resources
- Test client matrix: approved libraries and versions
- Runbook templates: Meridian operations centre pattern
- Decision log: why constructions were selected over alternatives

Apex classified reference architectures **unclassified** for corporate IT; NSS variants lived in controlled repository with separate construction table — same HLM logic, different parameter profiles (ML-DSA-87, ML-KEM-1024 per CNSA 2.0).

> **Migration Moment**
>
> *"We'll document the hybrid design after production stabilises."*
>
> Undocumented hybrid deployments become untestable during incidents and unverifiable during audit. Reference architecture and runbook are **H1 entry gates**, not post-project documentation.

---

## 11.17 Cross-Reference Map

| Topic | See |
|-------|-----|
| HLM policy and sunset governance | Chapter 5 §5.6–5.9 |
| CBOM baseline and `hlm_phase` introduction | Chapter 7 §7.4 |
| CDG blocking nodes and fan-in | Chapter 8 §8.3–8.4 |
| Wave sequencing and TRADE E gating | Chapter 9 §9.2, §9.7 |
| Stateful firmware signatures | Chapter 6 |
| PKI and certificate profiles for hybrid TLS | Chapter 13 |
| HSM key ceremonies for dual signing | Chapter 14 |
| Programme office operating rhythm | Chapter 15 |

---

## 11.18 Apply in Your Organisation

1. **Adopt Table 11.3** as your hybrid pattern catalog — annotate with approved constructions and remove inapplicable rows.
2. **Mandate seven H1 controls** (§11.1) in change management — reject hybrid deployments without `h2_trigger_value`.
3. **Measure client compatibility from production traffic** — classify Tier A/B/C/D before endpoint design (Meridian pattern).
4. **Assess infrastructure buffers** before H1 approval — load balancers, proxies, IDS, CDN, VPN MTU.
5. **Separate combiner policy annexes** for TLS key exchange, dual signature, and application-layer hybrids.
6. **Map CDG blocking nodes** to Wave 0 before declaring engineering pilots complete.
7. **Implement tiered endpoints** for fixed clients — risk acceptance on exception paths, not silent fallback.
8. **Populate extended CBOM attributes** (Table 11.4) and automate breach alerts on trigger dates.
9. **Run shadow traffic** or OT pilot soak before primary hybrid cutover.
10. **Brief internal audit** with pattern catalog and sample CBOM export before production H1.

---

## 11.19 Chapter Summary

- The Hybrid Lifecycle Model requires **deployment specification**: H1 protective hybrid with seven mandatory controls; H2 transitional reduction of classical dependency; H3 PQC-native verified by CBOM scan.
- **Hybrid TLS (X25519 + ML-KEM-768)** is the reference external H1 pattern — governed by named groups, infrastructure buffer assessment, and production client telemetry.
- **Combiner security** differs by use case: concatenation OR for key exchange; dual-signature AND-verification for code signing; application-layer patterns require separate policy annexes.
- **Performance and handshake size** impacts are manageable at API scale but dominate in OT WAN and inspection paths — measure before approval.
- **IKE hybrid VPN** requires distinct assessment from TLS — fragmentation, CPE firmware, and concentrator hardware gate Northfield-style rollouts.
- **Dual code signing** governs Apex NSS and Northfield OT firmware H1 with CNSA- or vendor-driven H2 triggers.
- **Table 11.3 pattern catalog** links protocol, phase, and sunset trigger — the architecture artefact Part IV promises.
- **CBOM `hlm_phase` attributes** connect deployment to dashboards, audit, and steering committee metrics.
- **CDG blocking nodes** sequence hybrid rollout through waves — local pilot success does not imply production readiness.
- **Meridian, GlobalSync, Northfield, and Apex** demonstrate tiered endpoints, tenant cohorts, IKE qualification, and dual-track HLM — patterns reusable across sectors.

**Closing note:** Hybrid cryptography is how enterprises survive the decade of transition. Without HLM phase discipline, hybrids become permanent dual-algorithm debt — the SHA-1 equivalent failure mode for post-quantum migration. Deploy hybrids as governed interim states; measure exits; sequence through the dependency graph.

**Next:** Chapter 12 maps protocol-by-protocol migration paths for TLS, IPsec, SSH, and messaging — recognising distinct ecosystem readiness curves and partner constraints beyond hybrid H1 entry.

---

*Chapter 11 — References*

- Basescu, C., et al. (2024). Deployment considerations for post-quantum cryptography. *USENIX Security Symposium*. https://www.usenix.org/conference/usenixsecurity24
- Campbell, R. (2025). Enterprise migration to post-quantum cryptography: Timeline analysis and strategic frameworks. *Computers*, 15(1), 9. https://doi.org/10.3390/computers15010009
- Internet Engineering Task Force. (2024–2026). Post-quantum hybrid key exchange for TLS 1.3 (standards track). *IETF TLS Working Group*.
- National Institute of Standards and Technology. (2024). FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard. https://doi.org/10.6028/NIST.FIPS.203
- National Institute of Standards and Technology. (2024). FIPS 204: Module-Lattice-Based Digital Signature Standard. https://doi.org/10.6028/NIST.FIPS.204
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Institute of Standards and Technology. (2020). NIST SP 800-208: Recommendation for Stateful Hash-Based Signature Schemes. https://doi.org/10.6028/NIST.SP.800-208
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- OWASP Foundation. (2024). *Cryptographic Storage Cheat Sheet* (application-layer guidance). https://cheatsheetseries.owasp.org/
- CycloneDX. (2024). *Authoritative Guide to CBOM*. OWASP Foundation.
