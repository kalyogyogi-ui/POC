# Chapter 12
# Protocol Transition — TLS, IPsec, SSH, and Messaging

---

James Whitfield's Northfield Energy team qualified hybrid IKE on two WAN concentrator models by August 2026. Vendor documentation promised ML-KEM hybrid support. Laboratory rekey tests completed without historian gaps. The programme office scheduled regional rollout for the Gulf Coast compressor corridor.

Then field operations opened the CPE inventory. Of **312** customer-premises routers terminating remote-site VPNs toward those concentrators, **241** ran firmware builds that rejected the hybrid IKE proposal before the first Child SA could form. The concentrators were ready. The path between concentrator and field device was not. James did not have a TLS problem — he had a **protocol ecosystem** problem identical in structure to Marcus Chen's partner mTLS blockage at GlobalSync, Meridian's middlebox truncation, and Priya Nair's NSS accreditation gates at Apex. Different protocols; same synchronisation logic.

Chapter 11 taught hybrid deployment patterns and HLM phase discipline. This chapter maps **protocol-by-protocol migration paths** — the engineering playbooks network, platform, and messaging teams execute when wave plans assign their workloads. Each protocol carries distinct readiness curves, client populations, inspection paths, and partner constraints. Enterprises that treat protocol transition as a single "enable PQC in TLS" programme discover, as Northfield did, that the slowest critical partner — or the slowest critical CPE firmware line — sets the pace for everyone downstream.

---

## 12.1 Protocol Transition as Ecosystem Synchronisation

Post-quantum protocol migration is not cipher-suite selection. It is **coordination across every node that negotiates, terminates, inspects, or trusts a cryptographic channel** — mapped in the Cryptographic Dependency Graph (Chapter 8) and sequenced in migration waves (Chapter 9).

### The protocol transition stack

| Layer | What changes | Typical owner | CDG edge types |
|-------|-------------|---------------|----------------|
| **Algorithm** | ML-KEM, ML-DSA, hybrid constructions | Crypto governance | `implements` |
| **Library / firmware** | OpenSSL, strongSwan, CPE builds, mesh proxies | Platform / vendor management | `implements` |
| **Protocol policy** | Named TLS groups, IKE transforms, SSH host key types | Network / security architecture | `terminates` |
| **Certificate / identity** | Server certs, client certs, SSH host keys, S/MIME profiles | PKI team | `trusts`, `signs` |
| **Partner / tenant policy** | External acceptance of new algorithms and cert profiles | Commercial / integration | `trusts` |
| **Inspection / middlebox** | Buffer limits, extension parsing, passive monitoring | Network operations | `terminates` (proxy) |

Hybrid patterns (Chapter 11) operate at the algorithm and protocol policy layers. Protocol transition programmes must address **all six layers** before production cutover — or document Tier C exception paths with compensating controls.

### Relationship to HLM phases

Protocol transition does not replace HLM; it **instantiates** HLM per protocol class:

| HLM phase | Protocol transition meaning |
|-----------|---------------------------|
| **H1** | Hybrid or dual-mode negotiation enabled; classical fallback or parallel endpoint for exceptions |
| **H2** | PQC-preferred; classical permitted only on documented exception paths |
| **H3** | Quantum-vulnerable PKC removed from negotiation policy for in-scope endpoints |

A single enterprise may run H2 on internal service mesh TLS while remaining H1 on WAN IPsec — **scope HLM per protocol class**, not per enterprise banner (Chapter 11 §11.1).

> **Migration Moment**
>
> *"Our TLS is hybrid. Protocol migration is done."*
>
> TLS is one protocol among dozens in a typical CBOM. SSH administrative access, Kafka broker channels, AMQP messaging, site-to-site IPsec, partner mTLS, and S/MIME email each carry independent readiness curves. Programme dashboards that report "TLS PQC enabled" without protocol-class breakdown recreate the SHA-1 retirement failure mode — green on the load balancer, red in the dependency graph.

### Prerequisites from Part III

Protocol playbooks assume:

- CBOM baseline with protocol attributes populated (Chapter 7)
- CDG with `terminates`, `trusts`, and blocking nodes identified (Chapter 8)
- Wave membership and TRADE Ecosystem (E) scores assigned (Chapter 9)
- Crypto-agility standards for configuration-driven policy (Chapter 10)
- Hybrid pattern catalog adopted (Chapter 11, Table 11.3)

Without CDG topology, protocol teams optimise locally and collide globally — Marcus Chen's nine-month production block on 200 microservices is the reference anti-pattern.

---

## 12.2 A Unified Protocol Transition Methodology

Regardless of protocol, governed transitions follow the same **five-phase methodology**. Programme offices embed this sequence in change management templates; individual protocol sections below specialise each phase.

**Figure 12.1 — Protocol Transition Methodology (All Protocols)**

```
Phase 1          Phase 2           Phase 3            Phase 4           Phase 5
DISCOVER    -->  MEASURE      -->  DESIGN        -->  PILOT        -->  PRODUCTION
CBOM + CDG       Production         Tiered policy      Soak +          Rollout by
inventory        telemetry          + library          partner         wave +
                 + partner          baseline           sync            telemetry
                 inventory
```

**Production brief — Figure 12.1:** Horizontal process flow with feedback arrows from Phase 4/5 to Phase 2 (telemetry refinement). Annotate entry gates: Phase 3 requires infrastructure buffer assessment; Phase 5 requires rollback test evidence.

| Phase | Activities | Exit criteria |
|-------|-----------|---------------|
| **1 — Discover** | Map protocol instances in CBOM; model CDG edges; identify blocking nodes | Protocol-class inventory complete; blocking nodes tagged |
| **2 — Measure** | Production or mirror telemetry; client/partner fingerprinting; middlebox path analysis | Compatibility cohorts defined (Tier A/B/C/D); handshake or negotiation failure modes classified |
| **3 — Design** | Select HLM phase; tiered endpoints; library minimum versions; certificate profile dependencies | Architecture review approved; `h2_trigger_value` populated; PKI dependencies scheduled (Chapter 13) |
| **4 — Pilot** | Staged cohort or region; partner notification; soak period | Zero Sev 1 in soak window; rollback tested |
| **5 — Production** | Wave-aligned rollout; continuous telemetry; exception governance | `hybrid_negotiation_rate` or protocol-equivalent metric meets H1 exit threshold |

### Protocol-class ownership

| Protocol class | Primary owner | Secondary stakeholders |
|----------------|---------------|------------------------|
| External TLS | Platform / API engineering | PKI, CDN, WAF, commercial (tenant comms) |
| Internal TLS / mesh | Service mesh / platform | PKI, application teams |
| IPsec / IKE | Network engineering | OT operations, vendor management |
| SSH | Systems administration / SecOps | PKI (if SSH certificates), bastion vendors |
| Messaging (Kafka, AMQP) | Data platform / integration | Security architecture, PKI |
| mTLS (API) | Integration / API platform | Partner programme, PKI |
| S/MIME | Collaboration / messaging | PKI, legal (archival) |

---

## 12.3 TLS 1.3 Migration

TLS 1.3 is the **reference protocol** for enterprise PQC transition — the most mature standards track, the broadest library support, and the highest volume of external exposure. Chapter 11 developed hybrid TLS patterns in depth; this section focuses on **protocol transition mechanics** that engineering teams execute after pattern selection.

### TLS 1.3 as the mandatory baseline

Enterprise policy should treat **TLS 1.3 as the minimum protocol version** for all new external and internal HTTPS endpoints before PQC group enablement. TLS 1.2 endpoints complicate hybrid deployment:

- TLS 1.2 lacks the 1.3 key schedule that hybrid specifications assume for combined shared secrets
- Legacy cipher suite negotiation reintroduces weak classical options
- Middlebox ecosystems differ materially between 1.2 and 1.3 inspection paths

| Policy posture | TLS 1.2 | TLS 1.3 classical | TLS 1.3 hybrid H1 |
|----------------|---------|-------------------|-------------------|
| New external endpoints | Prohibited | Permitted interim only | Target for H1 |
| Legacy partner APIs | Exception with sunset | Transitional | Preferred |
| Internal mesh | Phase out per wave | Transitional | H1 default |
| OT HTTPS (where used) | Vendor-dependent | Assess per device | Often blocked — parallel track |

Meridian completed TLS 1.2 retirement on customer-facing APIs **before** hybrid group enablement — reducing variables during Meridian's compatibility measurement phase (Chapter 11 §11.12).

### Named group policy

TLS transition requires **explicit named group allow-lists**, not generic "PQC enabled" flags:

| HLM phase | Approved key exchange groups (illustrative) | Prohibited |
|-----------|---------------------------------------------|------------|
| H1 | `X25519MLKEM768` (hybrid); `X25519` (exception tier only) | Ad hoc custom hybrids; export-grade DH |
| H2 | `X25519MLKEM768` preferred; `X25519` exception path only | New classical-only endpoints |
| H3 | `MLKEM768` or enterprise-selected PQC group | All quantum-vulnerable PKC |

Group identifiers follow IETF standards-track naming — assign a **standards watch owner** to track final RFC publication before audit evidence hardens (Chapter 22 preview).

### Certificate chain interaction

Hybrid key exchange does not resolve certificate signature migration. TLS protocol transition **depends on PKI transition** (Chapter 13):

| Component | H1 typical posture | Blocking risk |
|-----------|-------------------|---------------|
| Key exchange | Hybrid (X25519 + ML-KEM-768) | Library / middlebox |
| Server certificate signature | ECDSA-P256 or ML-DSA-65 per CA readiness | Issuing CA profile |
| Intermediate CA | Classical or hybrid chain | Root migration schedule |
| Client certificate (mTLS) | Classical or ML-DSA per partner policy | Partner trust store |

The CDG must model these as **separate nodes** — a hybrid-ready load balancer with classical-only server certificates is H1 on key exchange only, not full channel transition.

### TLS termination architectures

| Architecture | Transition consideration | Common pitfall |
|--------------|---------------------------|----------------|
| **Edge termination** (CDN, WAF) | CDN vendor hybrid support gates production | Origin ready; edge not |
| **Load balancer termination** | Hardware buffer limits; session ticket compatibility | Inspection buffer overflow |
| **Service mesh ingress** | Mesh CA and gateway API versions | North-south hybrid; east-west classical |
| **Pass-through** | End-service library version is bottleneck | False confidence from edge scan |
| **Mutual TLS at gateway** | Client and server cert profiles both required | Server hybrid; client classical-only partner |

GlobalSync required **end-to-end path validation** on mirror traffic — CDN hybrid success did not imply origin mesh compatibility until both paths were measured independently.

### Session resumption and 0-RTT

Protocol transition must account for **stateful TLS optimisations**:

- **Session tickets** issued under classical handshakes may not resume against hybrid-only endpoints after H2 — plan ticket invalidation or dual-mode resumption during H1
- **0-RTT** introduces replay considerations independent of PQC; disabling 0-RTT on payment-adjacent paths simplified Meridian's first production week
- **Connection coalescing** across HTTP/2 and HTTP/3 may cache negotiation outcomes — retest after policy change

---

## 12.4 Client Compatibility and Cohort Analysis

TLS client compatibility is the **primary H1 exit gate** for external services. Protocol transition programmes measure compatibility from **production traffic**, not laboratory clients.

### Tier classification model

Meridian's pilot established the reference cohort model (Chapter 11 §11.12), extended here for all TLS-facing protocols:

**Table 12.1 — Client Compatibility Tiers**

| Tier | Definition | Programme action | Endpoint strategy |
|------|------------|------------------|-------------------|
| **A — PQC-capable** | Negotiates approved hybrid group | Include in primary H1 endpoint | Unified production URL |
| **B — Classical, updatable** | Fails hybrid; patch or library upgrade available | Tenant notification; sunset date | Primary URL with migration comms |
| **C — Fixed embedded** | No update path within programme horizon | Risk acceptance; compensating controls | Dedicated exception hostname or mTLS policy |
| **D — Unknown / unclassified** | Insufficient telemetry | Instrumentation sprint; default to C until classified | No hybrid enablement until classified |

Tier C traffic must never silently fall back on a unified URL advertised as "quantum-safe" — supervisory and customer trust implications exceed the technical workaround.

### Fingerprinting methodology

| Signal source | Data captured | Limitation |
|---------------|---------------|------------|
| Load balancer access logs | ClientHello extensions, offered groups, TLS version | May not see full path through CDN |
| Service mesh telemetry | Negotiated cipher and group per connection | Internal clients only |
| API gateway analytics | Client SDK version correlation | Requires SDK version header discipline |
| Synthetic monitoring | Known client profiles | Does not represent long tail |
| Partner-declared inventory | Contractual client matrix | Often stale — verify with telemetry |

Meridian's security architecture team correlated **4.2 million** unique handshake fingerprints over thirty days — discovering that three legacy mobile integrations accounted for disproportionate Tier C share despite low connection count (high-value treasury workflows).

### Compatibility improvement levers

| Lever | Effectiveness | Cost |
|-------|---------------|------|
| Client SDK upgrade campaign | High for Tier B | Commercial / tenant management |
| Parallel endpoint with classical-only | Immediate Tier C service | Operational complexity; audit scrutiny |
| CDN/TLS policy routing by fingerprint | Surgical cohort routing | Requires advanced edge capability |
| Partner contractual migration clause | Medium; slow | Legal negotiation (Chapter 16) |
| Decommission legacy integration | Permanent | Business process change |

> **Architect's Decision**
>
> **Default: tiered endpoints over forced hybrid on fixed clients.** Forcing hybrid negotiation on Tier C clients produces connection failures — not protective cryptography. Meridian's `api-retail-pqc` and `api-retail` parallel hostnames cost operational overhead but preserved audit credibility. Silent classical fallback on a hybrid-advertised endpoint is worse than honest dual endpoints.

---

## 12.5 Middlebox Interference and Infrastructure Buffers

Middleboxes — SSL inspection proxies, legacy WAFs, DLP appliances, corporate transparent proxies — caused more production TLS incidents in early hybrid pilots than client incompatibility. Protocol transition must **map the inspection path** as thoroughly as the client population.

### Failure modes

| Failure mode | Mechanism | Detection |
|--------------|-----------|-----------|
| **ClientHello truncation** | Proxy buffer smaller than extended ClientHello | Handshake timeout; partial extension capture in logs |
| **Extension stripping** | Middlebox removes unknown extensions | Server never receives hybrid group offer |
| **Re-encryption mismatch** | Proxy terminates classical; origin expects hybrid | Origin logs show classical-only from proxy |
| **Certificate chain overflow** | Combined hybrid + large ML-DSA chain exceeds buffer | Intermittent failures on high-security paths |
| **APM agent crash** | Observability agent parses ClientHello struct | Apparent application outage |

Meridian's production incident traced to a **4,096-byte handshake buffer** on a corporate SSL inspection appliance — sufficient for classical TLS with ECDSA-P256 chains but insufficient when hybrid extensions combined with treasury middleware's large certificate chains (Chapter 11 §11.5).

### Infrastructure buffer assessment

Before H1 TLS approval, architecture review must document limits on **every inspection hop**:

**Table 12.2 — Infrastructure Buffer Assessment Checklist**

| Hop | Maximum handshake size tested | Hybrid test date | Owner sign-off |
|-----|------------------------------|------------------|----------------|
| Internet CDN edge | | | |
| DDoS scrubbing service | | | |
| WAF / API gateway | | | |
| Corporate SSL inspection | | | |
| Load balancer | | | |
| Service mesh ingress | | | |
| Application server TLS library | | | |

Test with **maximum-size certificate chains** planned for H2 — not current classical chains. ML-DSA certificates and hybrid key shares both increase message size.

### Middlebox remediation options

| Option | When appropriate | Trade-off |
|--------|------------------|-----------|
| Firmware upgrade | Vendor patch available | Cost; change window |
| Bypass inspection for PQC path | Regulatory approval | Reduced visibility |
| Dedicated non-inspected VLAN for PQC tier | OT or high-security enclave | Segmentation complexity |
| Replace appliance | End-of-life product | Capital expenditure |
| Tier C endpoint outside inspection path | Fixed clients only | Split security posture |

Northfield applied **bypass for OT historian VPN paths** where inspection appliances could not be upgraded within NERC CIP maintenance windows — documented as compensating control with enhanced endpoint monitoring.

---

## 12.6 OpenSSL and Library Readiness

Protocol transition at scale is a **library and platform contract** — not a configuration change on a single server. Chapter 10 mandated provider abstraction; this section addresses the **runtime versions** that protocols consume.

### OpenSSL readiness baseline

OpenSSL 3.x provider architecture is the de facto enterprise baseline for Linux workloads. Minimum readiness posture (illustrative — verify against organisational FIPS requirements):

| Capability | OpenSSL indicator | Programme note |
|------------|-------------------|----------------|
| ML-KEM (FIPS 203) | OpenSSL 3.5+ with default or FIPS provider | Validate FIPS module separately |
| ML-DSA (FIPS 204) | OpenSSL 3.5+ | Certificate operations may lag KEM |
| Hybrid TLS groups | 3.5+ with standards-track group support | Custom builds often miss provider |
| TLS 1.3 | 1.1.1+ | Baseline before PQC |
| Legacy 1.0.2 / 1.1.0 | End of life | Block new deployments |

| Distribution pattern | Risk | Mitigation |
|---------------------|------|------------|
| Vendor appliance embedded OpenSSL | Version frozen until firmware upgrade | CDG `vendor_pq_ga_date` attribute |
| Container golden images | Stale at deploy time | CI gate on minimum image digest |
| Language bindings (Node, Python, Ruby) | Binding lags OpenSSL core | Binding version in CBOM `implements` edge |
| Hardware TLS offload | Separate firmware track | Lab test on exact ASIC revision |

GlobalSync embedded **minimum library versions** in platform engineering standards — microservices could not deploy until mesh ingress validated hybrid negotiation on the target image baseline (Chapter 10 case study). Marcus Chen treated library version as **Wave 0 infrastructure**.

### Multi-library estates

Enterprises rarely standardise on OpenSSL alone:

| Library / stack | Typical deployment | PQC transition note |
|-----------------|-------------------|---------------------|
| **BoringSSL / Chromium** | Custom clients, Android apps | Follows Chrome release cadence |
| **SChannel** (Windows) | .NET, IIS | OS build determines capability |
| **Java SunJSSE** | Enterprise Java | JVM version and policy files |
| **Go crypto/tls** | Cloud-native services | Go release notes per version |
| **Rust rustls** | Modern microservices | Feature flags per release |
| **WolfSSL / mbedTLS** | Embedded, IoT | Vendor roadmap critical |

CBOM must capture **per-component library identity** — a hybrid-ready API gateway with embedded Java trust stores may fail on client certificate verification even when edge TLS succeeds.

### FIPS mode interaction

Regulated environments requiring FIPS 140-validated modules face **additional gating**:

- Algorithm availability in validated module may lag community OpenSSL
- Hybrid constructions require explicit validation boundary analysis — which operations occur inside the cryptographic module boundary
- HSM-attached TLS termination shifts validation to HSM firmware (Chapter 14)

Meridian's payment-adjacent services could not enable hybrid groups until the payment HSM vendor's validated module release supported ML-KEM — a CDG blocking node independent of general-purpose OpenSSL readiness.

> **Dependency Alert**
>
> **Language binding version is a hidden blocking node.** GlobalSync discovered three Node.js services failed hybrid negotiation despite cluster ingress success — `node-openssl` binding compiled against OpenSSL 3.2, not the platform's 3.5 image. CBOM `implements` edges must reach the **effective** cryptographic library, not the container base image label.

---

## 12.7 IPsec and IKEv2 Hybrid Transition

IPsec/IKEv2 carries WAN, site-to-site, and remote-access traffic in enterprises and critical infrastructure — with constraints **materially different from TLS**. Chapter 11 introduced IKE hybrid patterns; this section develops the **protocol transition playbook** Northfield executed (and where it stalled).

### Why IPsec differs from TLS

**Table 12.3 — IPsec/IKEv2 vs TLS Transition Factors**

| Factor | TLS (HTTPS) | IPsec/IKEv2 |
|--------|-------------|---------------|
| Client diversity | Broad public internet | Often fixed CPE / concentrator pairs |
| Message size pressure | ClientHello extension growth | IKE_SA_INIT fragmentation on UDP 500/4500 |
| Rekey behaviour | Session resumption | Periodic IKE rekeys — CPU and historian timing |
| Firmware coupling | Application updates | CPE firmware may lag years |
| Inspection | Common SSL proxies | Rare inline inspection; MTU dominates |
| Identity binding | X.509 in TLS handshake | IKE CERT payloads; pre-shared key legacy |
| OT sensitivity | Lower in API contexts | Historian gap intolerance |

### IKE hybrid H1 construction

Enterprise WAN H1 typically deploys:

- **Classical component:** ECDH (P-256 or Curve25519 per vendor profile)
- **PQC component:** ML-KEM-768 (or ML-KEM-1024 for elevated security postures)
- **Combiner:** Concatenation OR model per vendor-validated profile
- **Certificate posture:** Classical X.509 on IKE CERT payloads during early H1; ML-DSA when PKI profile available (Chapter 13)

Northfield's approved construction referenced vendor profile `NF-IKE-HYBRID-MLKEM768-v2` — not an in-house IKE transform combination.

### Northfield case study: concentrator ready, CPE blocked

James Whitfield's programme illustrates CDG-gated protocol transition in OT-heavy environments.

**Context:** Gulf Coast compressor corridor; **312** CPE devices; **2** concentrator models (Model A qualified, Model B pending hardware refresh); historian traffic with zero-gap rekey requirement; TRADE TES 5 on thirty-year archive confidentiality.

| Phase | Planned | Actual outcome |
|-------|---------|----------------|
| Laboratory IKE hybrid | Model A pass | Pass — rekey under 800 ms |
| Concentrator staging | Regional pilot | Pass — concentrator-to-concentrator hybrid |
| CPE rollout wave 1 | 80 devices | **Fail** — firmware 7.2.x rejected hybrid proposal |
| CDG review | Parallel cloud TLS migration | **Rejected** — cloud traffic transits concentrator trust domain |
| Revised plan | CPE firmware programme | Vendor GA Q3 2027; **241** devices on blocked builds |

**Programme decision:** Northfield **paused** WAN hybrid production rollout; maintained classical IKE on affected CPE paths; continued concentrator qualification for post-firmware wave. CDG node `cpe-gulf-firmware-7.2` marked `blocking: true` with `vendor_pq_ga_date: 2027-Q3`.

> **Dependency Alert**
>
> **CPE firmware blocks IKE hybrid more often than concentrator upgrades.** Northfield's concentrators supported hybrid IKE six months before remote CPE devices accepted the profile. CDG edges on CPE nodes gate rollout **per region** — not per enterprise calendar. Cloud-first TLS migration proposals failed CDG review when WAN remained classical-only on the data path.

### IKE-specific transition tasks

| Task | Owner | Evidence |
|------|-------|----------|
| Concentrator firmware qualification | Network engineering | Lab rekey timing report |
| CPE firmware inventory by build | OT operations | CBOM `firmware_version` attribute |
| Vendor roadmap alignment | Vendor management | `vendor_pq_ga_date` on CDG nodes |
| MTU and fragmentation test | Network engineering | PCAP analysis on constrained WAN links |
| Historian gap test during rekey | OT engineering | 30-day pilot with replay validation |
| Rollback runbook | Operations | Staged failover — Northfield measured 45 minutes acceptable for OT |

### Site-to-site vs remote-access

| Mode | Transition characteristic | Northfield note |
|------|--------------------------|-----------------|
| **Site-to-site** | Concentrator pairs upgrade symmetrically | Model A regions first |
| **Remote access** | Client software diversity | Field engineer laptops — separate track |
| **Hub-and-spoke** | Spoke CPE is bottleneck | Gulf Coast blockage pattern |
| **Mesh** | All nodes must upgrade before PQC-only | Deferred to post-H1 |

### IPsec certificate and PKI dependencies

IKE identity often binds to **internal PKI certificates** on concentrators and CPE:

- ML-DSA certificate size increases IKE CERT payload — interacts with fragmentation
- CRL/OCSP reachability during rekey must be verified under hybrid load
- Multi-vendor PKI trust — one partner's CA migration may block site-to-site tunnel

Chapter 13 develops certificate profile migration; protocol teams must **schedule IKE cutover after issuing CA supports required profiles** — or maintain classical certs on IKE while upgrading key exchange only (staged H1).

---

## 12.8 SSH Host Keys and Certificates

SSH secures administrative access, CI/CD deployment pipes, file transfer, and tunnelled application traffic — often overlooked in TLS-centric programmes. SSH protocol transition spans **host keys**, **client keys**, and increasingly **SSH certificates** in certificate-authority mode.

### SSH key algorithm transition

| Component | Classical typical | H1 target | H3 target |
|-----------|------------------|-----------|-----------|
| Host key | RSA 2048, ECDSA P-256 | Hybrid or parallel host keys; ML-DSA where supported | ML-DSA or enterprise PQC choice |
| Client key | RSA, ECDSA | ML-DSA client keys for automation | PQC-only |
| Key exchange | curve25519-sha256, ecdh-sha2-nistp256 | Hybrid KEX per OpenSSH release | PQC KEX |
| Host certificate (CA mode) | RSA/ECDSA CA | ML-DSA signing CA | PQC CA |

OpenSSH's release cadence drives much of enterprise SSH PQC readiness — track **OpenSSH release notes** and Linux distribution backport policies as CDG `implements` attributes on bastion and jump hosts.

### Parallel host keys versus in-place rotation

SSH clients cache host key fingerprints — **in-place algorithm change breaks automation**:

| Strategy | Description | Use when |
|----------|-------------|----------|
| **Parallel host keys** | Server offers classical and PQC host keys simultaneously | Large automation estate; H1 default |
| **Staged rotation** | `ssh-keygen -R` campaign; updated known_hosts | Small controlled fleet |
| **SSH certificates** | CA-signed host certs reduce known_hosts dependency | Mature SSH CA programme |
| **ProxyCommand tunnel** | Bastion terminates SSH — inner algorithm isolated | Legacy clients on outer hop only |

Apex maintained **parallel host keys** on administrative bastions — classical Ed25519 and ML-DSA host keys during NSS accreditation review of PQC administrative channels. Corporate IT adopted SSH certificate mode to reduce known_hosts churn across **14,000** ephemeral build agents.

### SSH certificate authority transition

Organisations using SSH-CA (Vault, step-ca, commercial PaaS) must migrate **CA signing key** before host certificates:

```
Migration sequence (SSH-CA mode):
1. Deploy PQC-capable SSH-CA signing key (H1 dual-CA or hybrid)
2. Issue host certs with PQC-capable signature algorithm
3. Update client trust anchor to PQC CA
4. Retire classical CA after automation estate migration
```

Skipping step 1 and issuing ML-DSA host certs from a classical CA produces **valid certificates with a quantum-vulnerable trust anchor** — CDG `trusts` edge remains classical.

### SSH operational controls

| Control | Purpose |
|---------|---------|
| `CASignatureAlgorithms` allow-list | Enforce approved host cert algorithms |
| `HostKeyAlgorithms` ordering | Prefer PQC without breaking legacy |
| Centralised known_hosts distribution | Ansible/Chef-managed fingerprint updates |
| Session logging during transition | Detect algorithm downgrade attacks |
| Bastion inventory in CBOM | Jump hosts are high fan-in blocking nodes |

Meridian restricted PQC SSH host keys to **Tier A administrative hosts** until security operations validated SIEM parsing of enlarged host key material — an observability gate easy to overlook.

---

## 12.9 Messaging Protocols: Kafka, AMQP, and Event Backbones

Event backbones and message queues carry **authentication credentials, personally identifiable information, and financial events** — often with TLS termination configurations distinct from public APIs.

### Kafka TLS transition

Apache Kafka and managed equivalents (Confluent Cloud, MSK, Event Hubs) typically use **TLS for broker and client channels**, sometimes with mutual TLS for client authentication.

| Layer | Transition consideration |
|-------|-------------------------|
| **Broker listener TLS** | Hybrid groups on `SSL` listeners; inter-broker protocol version alignment |
| **Client library** | librdkafka, Java client, .NET client — each binds cryptographic stack |
| **ZooKeeper / KRaft** | Metadata channel encryption separate from broker listener |
| **Schema Registry** | HTTPS with independent TLS policy |
| **Connect workers** | Distributed worker TLS and plugin isolation |

**GlobalSync Kafka programme:**

- **Wave 2** scope — after Wave 0 PKI and Wave 1 public API TLS H1
- Inter-broker traffic: classical TLS until all brokers on OpenSSL 3.5+ image (**homogeneous fleet rule**)
- Client-facing listeners: hybrid H1 on `kafka-tenant-pqc` listener; classical listener retained for Tier C connectors
- CBOM row per cluster with `protocol_class: kafka-tls` and `hlm_phase` independent of API tier

Homogeneous broker fleet requirement prevented partial hybrid — one classical-only broker in a three-broker cluster forced cluster-wide classical until remediated.

### AMQP and RabbitMQ

AMQP 1.0 implementations (RabbitMQ, Qpid, Azure Service Bus) use TLS similarly to HTTPS but with **long-lived connections** and **less middlebox interference**:

| Factor | Kafka | AMQP (RabbitMQ) |
|--------|-------|-----------------|
| Connection pattern | Long-lived TCP | Long-lived TCP |
| Client diversity | Internal microservices | Internal + some partner integrations |
| Certificate rotation | Rolling broker restart | Queue depth during restart |
| Policy enforcement | ACLs + TLS | SASL + TLS |

Meridian's payment notification bus (RabbitMQ) migrated in **lockstep with internal mesh CA** — AMQP TLS policy inherited `trusts` edge from mesh root migration; attempting AMQP-first migration failed CDG review because client certs chained to unreleased ML-DSA intermediate.

### MQTT and IoT messaging (brief)

MQTT over TLS appears in IoT and OT gateways — often on **constrained libraries** (mbedTLS, WolfSSL). Northfield's OT gateway nodes carry `protocol_class: mqtt-tls` with **vendor-gated** PQC timelines separate from WAN IPsec. Do not assume Kafka playbooks transfer to embedded MQTT without per-device CDG assessment.

---

## 12.10 API Mutual TLS: Recap and Integration

Mutual TLS is TLS with **client certificate authentication** — doubling the certificate migration problem. Chapter 8 established partner mTLS policy as a canonical blocking node; this section consolidates **mTLS protocol transition** for readers executing Wave 0–2.

### Bidirectional dependency model

CDG must represent mTLS as **two trust chains**:

```
[Client] --presents--> [Client cert] --chains-to--> [Partner or tenant CA]
[Client] --verifies--> [Server cert] --chains-to--> [Enterprise issuing CA]
[Server] --verifies--> [Client cert]
[Server] --presents--> [Server cert]
```

Either chain blocking prevents mTLS transition — GlobalSync's nine-month production block occurred because **partner client certificate policy** rejected ML-DSA while server-side hybrid TLS succeeded.

### Meridian mTLS transition

Meridian's retail API pilot was **server-authenticated TLS** only. Meridian's **corporate treasury mTLS** programme — higher TRADE Regulatory score — required:

| Workstream | Dependency | Timeline |
|------------|------------|----------|
| Server hybrid TLS | Load balancer + OpenSSL 3.5 | Completed H1 Q2 2026 |
| Server ML-DSA certificate | Issuing CA profile (Chapter 13) | Blocked until CA migration wave |
| Client cert issuance (corporate) | Internal PKI ML-DSA profiles | Parallel to server |
| Partner bank mTLS | External trust policy | **Slowest partner: 14-month negotiation** |

Meridian's CDG showed **one partner bank** with fourteen downstream workflows — that partner's migration timeline set the programme pace for treasury mTLS, not Meridian's internal readiness.

### GlobalSync partner mTLS synchronisation

Marcus Chen's partner programme contacted **400 partners**; **200** actively integrated; **85** accepted pilot hybrid profiles by month nine. Production policy:

- No hybrid **client** certificates until `partner_acceptance_pct` exceeded **85%** on CDG node `partner-mtls-policy-v3`
- Parallel policy profiles: `gs-partner-mtls-v2` (classical) and `gs-partner-mtls-v3` (hybrid-capable)
- Microservices consumed **central negotiation policy** — not per-service algorithm choice (Chapter 10)

### mTLS transition checklist

| Step | Verification |
|------|--------------|
| Server hybrid TLS operational | Telemetry on `hybrid_negotiation_rate` |
| Server ML-DSA cert deployed | Chain validation from partner network |
| Partner trust store accepts ML-DSA issuers | Partner-signed test report |
| Client ML-DSA certs issued | Provisioning pipeline updated |
| Partner client cert verification policy updated | Mutual test environment pass |
| Rollback to v2 policy tested | < change window recovery |

> **Regulatory Lens**
>
> **DORA third-party ICT risk (Articles 28–30)** applies to partner mTLS cryptography. Meridian documented partner migration timelines in the third-party risk register with CDG node references — supervisors evaluated **process and evidence**, not per-partner algorithm speed. GlobalSync's `partner_acceptance_pct` metric appeared in quarterly ICT risk reporting.

---

## 12.11 Email: S/MIME and PKI Implications

Email encryption and signing lag TLS in ecosystem readiness but carry **long archival verification horizons** — legal hold and regulatory archive requirements extend certificate trust decades.

### S/MIME transition posture (brief)

| Element | H1 approach | Programme note |
|---------|-------------|----------------|
| Signing | Dual signature (classical + ML-DSA) or parallel signing keys | Mail gateway support gates production |
| Encryption | Classical encryption with ML-KEM key agreement when gateway ready | Often blocked on gateway vendor |
| Certificate profile | ML-DSA user certificates | Larger cert size — mail system limits |
| Archival verification | Retain classical CA trust for historical messages | CDG `verifies` edges to retired CAs |
| Gateway appliances | Proofpoint, Mimecast, Microsoft 365 | Vendor roadmap is blocking node |

Meridian legal hold archives required verifying **ten-year-old S/MIME signatures** — CDG `verifies` edges from archive systems to retired CA nodes informed Wave 2 PKI planning (Chapter 8 §8.48). S/MIME transition is **Wave 2–3** for most enterprises — not because email is unimportant, but because gateway ecosystem readiness trails TLS by years.

### Practical recommendation

- Inventory S/MIME usage in CBOM — often discovered only through mail gateway logs
- Coordinate with Chapter 13 PKI user certificate profiles before gateway cutover
- Do not retire classical CA trust anchors until archival verification horizon expires
- Executive communications may justify earlier H1 dual-sign — scope narrowly, not enterprise-wide

---

## 12.12 Apex Defense: NSS Protocol Requirements

Apex Defense Technologies operates **dual-track protocol policy** — NSS workloads under CNSA 2.0; corporate IT under NIST IR 8547 (Chapter 5 §5.13). Protocol transition adds **accreditation and classification boundaries** absent from commercial programmes.

### NSS protocol overlays

| Protocol | CNSA 2.0 posture (illustrative) | Apex programme note |
|----------|--------------------------------|---------------------|
| TLS | ML-KEM-1024 / ML-DSA-87 profiles for NSS | Accelerated H2 vs corporate |
| IPsec | NSA-approved IKE profiles when published | Separate from Northfield commercial vendor path |
| SSH | NSS bastion requirements | Parallel host keys during accreditation |
| Code signing | Dual signature H1 mandatory | Chapter 6; distinct from channel protocols |
| Cross-domain guards | Fixed crypto modules | `accreditation_id` on CDG nodes |

Priya Nair's wave plan **sequenced NSS protocol transitions against contract renewal cycles** — a $4.2M renewal linked to vendor firmware signing milestone on CDG node `nss-fw-sign-v4` (Chapter 8 §8.20).

### Classified boundary constraints

Corporate CBOM rows do not automatically merge into NSS CDG — `boundary_tag: nss` prevents unreviewed algorithm policy leakage across classification levels. Protocol transition playbooks exist in **two versions**: unclassified reference architecture and controlled NSS variant with CNSA parameter profiles.

> **Architect's Decision**
>
> **Do not unify NSS and corporate protocol timelines in executive reporting.** Apex's corporate TLS may reach H2 while NSS SSH remains H1 pending accreditation — accurate per-track reporting prevents false enterprise-wide claims and audit findings.

---

## 12.13 Partner Synchronisation: The Slowest Critical Partner Sets Pace

Protocol transition across organisational boundaries follows **synchronisation logic**, not internal project velocity. Chapter 1 introduced the synchronisation problem; protocol transition is where it becomes measurable weekly.

### The GlobalSync principle

Marcus Chen articulated the operating rule GlobalSync adopted enterprise-wide:

> **Production protocol policy advances to the slowest critical partner — or the slowest critical tenant cohort — not to engineering completion date.**

| Metric | Definition | GlobalSync threshold |
|--------|------------|---------------------|
| `partner_acceptance_pct` | Partners accepting target profile / integrated partners | 85% for client cert hybrid |
| `tenant_cohort_pqc_pct` | Tenants on PQC-capable integration tier | 90% for default endpoint switch |
| `slowest_partner_id` | Partner with latest contractual migration date | Drives Wave 0 exit |
| `blocking_partner_fan_in` | CDG fan-in count of slowest partner node | Executive visibility |

### Partner programme structure

| Workstream | Activity | Output |
|------------|----------|--------|
| **Inventory** | Partner cryptographic contact; integration type | Partner CDG subgraph |
| **Outreach** | Migration guide; test environment access | Partner test report template |
| **Pilot** | Limited production traffic on hybrid profile | Signed partner acceptance |
| **Production** | Policy version bump (`v2` → `v3`) | CBOM policy node update |
| **Exception** | Tier C partner risk acceptance | `exception_id` linked |

GlobalSync held **200 microservices** in "engineering complete / production blocked" for nine months — correct posture when CDG blocking node remained classical-only. Engineering velocity without partner synchronisation produces **rework**, not progress.

### Tenant cohort routing

GlobalSync extended Meridian's tiered endpoint pattern with **tenant cohort routing**:

| Cohort | Routing | HLM phase |
|--------|---------|-----------|
| **Early adopters** | `api-pqc.globalsync.example` default | H2 eligible |
| **Standard** | Hybrid default after 90% tenant notification | H1 |
| **Legacy SLA** | Classical endpoint until contract amendment | H1 exception |
| **Embedded logistics terminals** | Fixed firmware — classical until hardware refresh | Tier C |

**Table 12.4 — GlobalSync Tenant Cohort Strategy (Illustrative)**

| Cohort | Tenant count | Integration type | PQC endpoint | Notification status |
|--------|-------------|------------------|--------------|---------------------|
| A — Cloud-native | 1,240 | REST / webhooks | Hybrid default | Complete |
| B — EDI partners | 380 | AS2 / custom mTLS | Hybrid opt-in | 78% complete |
| C — Legacy SLA | 45 | Fixed client | Classical exception | Contract renegotiation |
| D — Terminal fleet | 12,000 devices | Embedded | Hardware refresh 2028 | Capital programme |

### Internal synchronisation mirrors external

Partner synchronisation logic applies **internally** across business units:

- Slowest business unit's OT gateway firmware sets WAN IPsec pace (Northfield)
- Slowest issuing CA profile sets mTLS server certificate pace (Meridian)
- Slowest HSM validation sets payment channel pace (Meridian)

CDG fan-in analysis identifies which slowest node is **actually critical** — not which is loudest in steering committee.

---

## 12.14 Protocol × Algorithm × Readiness Matrix

**Table 12.5 — Protocol × Algorithm × Readiness Matrix (June 2026 Enterprise View)**

| Protocol | Algorithm component | H1 construction | Library / platform readiness | Ecosystem readiness (TRADE E) | Typical blocking node | Teaching org example |
|----------|--------------------|-----------------|-----------------------------|--------------------------------|----------------------|---------------------|
| TLS 1.3 (external) | Key exchange | X25519 + ML-KEM-768 | OpenSSL 3.5+, CDN 2026 releases | 4 — production viable with tiers | SSL inspection buffers | Meridian |
| TLS 1.3 (external) | Server cert signature | ML-DSA-65 | OpenSSL 3.5+; CA platforms 2026–27 | 3 — CA-dependent | Issuing CA profile | Meridian |
| TLS 1.3 (mTLS) | Client cert | ML-DSA-65 | Same as server | 2–3 — partner-dependent | Partner mTLS policy | GlobalSync |
| TLS 1.3 (mesh) | Full stack | Hybrid + ML-DSA certs | Mesh proxy 2026+ | 3 — mesh CA migration | Mesh root CA | GlobalSync |
| IKEv2 / IPsec | Key exchange | ECDH + ML-KEM-768 | strongSwan, vendor concentrator | 2–3 — CPE firmware | CPE firmware build | Northfield |
| IKEv2 / IPsec | IKE CERT | ML-DSA or ECDSA | PKI + vendor | 3 — cert size / fragmentation | Internal CA + MTU | Northfield |
| SSH | Host key + KEX | Parallel keys; hybrid KEX | OpenSSH 9.x+ (track releases) | 3 — automation estate | known_hosts / SSH CA | Apex |
| SSH | SSH-CA signature | ML-DSA CA | step-ca, Vault roadmap | 3 — CA first | SSH CA signing key | Apex |
| Kafka TLS | Broker listener | Same as TLS hybrid | librdkafka + broker image | 4 — internal homogeneous | Broker image version | GlobalSync |
| AMQP TLS | Broker listener | Inherit mesh policy | RabbitMQ 3.13+ | 4 — internal | Mesh CA dependency | Meridian |
| gRPC mTLS | Channel + creds | TLS hybrid + ML-DSA certs | Mesh + protobuf stacks | 3 — mesh + partner | Service mesh CA | GlobalSync |
| S/MIME | Sign + encrypt | Dual sign; classical encrypt interim | Mail gateway 2027+ | 2 — gateway vendor | Mail security appliance | Meridian |
| HTTPS webhooks | Payload signature | HMAC + ML-DSA (dual verify) | Application-layer | 3 — partner verification | Partner webhook SDK | GlobalSync |

**Readiness legend:** TRADE E 1–2 = architect now, deploy later; 3 = pilot viable; 4 = production with exceptions; 5 = broad production. Scores are **organisation-specific** — populate from your CBOM and vendor evidence, not this illustrative table.

Programme architects **copy Table 12.5 into the enterprise architecture repository** and refresh quarterly — tied to standards watch cadence and vendor roadmap reviews.

---

## 12.15 Protocol Readiness Radar

**Figure 12.2 — Protocol Readiness Radar (Illustrative Enterprise)**

```
                    TLS external (3.8)
                         /\
                        /  \
           Kafka (4.2) /    \ S/MIME (2.1)
                      /      \
                     /        \
        AMQP (3.9) ---+-------- SSH (3.2)
                     \        /
                      \      /
           gRPC mTLS (3.5) \  / IKEv2 WAN (2.4)
                        \  /
                         \/
                  Partner mTLS (2.0)
```

**Production brief — Figure 12.2:** Radar chart with six to eight protocol axes; plot TRADE E ecosystem score per axis; overlay target threshold line at E=4 for H2 eligibility; colour-code H1/H2/H3 phase per axis. Northfield example shows IKEv2 depressed due to CPE firmware; GlobalSync shows partner mTLS as lowest axis despite high Kafka score.

### Using the radar in governance

| Audience | Radar use |
|----------|-----------|
| Steering committee | Visualise imbalance — high TLS, low partner mTLS |
| Engineering | Prioritise blocking node workstreams |
| Board | Counter "we enabled PQC TLS" narrative with full protocol picture |
| Audit | Demonstrate scope-aware transition, not checkbox compliance |

Meridian presented protocol radar quarterly — replacing single-metric TLS dashboards that obscured treasury mTLS blockage.

---

## 12.16 Phased Protocol Rollout

**Figure 12.3 — Phased Protocol Rollout (CDG-Aligned)**

```
Timeline -->
Q1-Q2        Q3-Q4        Y2 Q1-Q2       Y2 Q3+
─────────────────────────────────────────────────────
Wave 0       Wave 1       Wave 2         Wave 3
PKI + partner API TLS    Kafka +       S/MIME +
policy       hybrid H1    mesh mTLS     OT gateways
blocking     Northfield   AMQP          (vendor GA)
resolved     IPsec pilot  inherit       Northfield
             (lab)        mesh CA       IPsec prod
```

**Production brief — Figure 12.3:** Gantt-style diagram with dependency arrows from Wave 0 PKI to all subsequent protocol bars; dashed bar for Northfield IPsec production contingent on `vendor_pq_ga_date`; critical path highlighted in red.

### Rollout sequencing rules

1. **Resolve CDG blocking nodes** (Wave 0) before protocol-class production at scale
2. **External TLS H1** may parallel Wave 0 only on tiered endpoints with documented exceptions — not default production URL
3. **Internal messaging** follows mesh / internal PKI — not public API schedule
4. **OT IPsec** follows CPE firmware — not cloud TLS schedule
5. **S/MIME and email** follow mail gateway — typically Wave 2–3
6. **Partner mTLS** follows slowest critical partner — may delay Wave 3 microservices indefinitely without tiered policy

### Regional and cohort phasing

GlobalSync rolled out hybrid TLS **by geographic CDN PoP** — APAC last due to partner concentration. Northfield phased IPsec by **concentrator model** — Model A regions before Model B hardware refresh. Apex phased NSS SSH separately from corporate — accreditation windows, not calendar quarters.

---

## 12.17 Observability and CBOM Integration

Protocol transition without telemetry reproduces pilot-production divergence — Meridian's security architecture team's laboratory success versus 11.3% handshake failure in production.

### Protocol-specific metrics

| Protocol | Metric | Collection point | H1 exit example |
|----------|--------|------------------|-----------------|
| TLS | `hybrid_negotiation_rate` | Load balancer / mesh | ≥ 92% GlobalSync |
| TLS | `tier_c_traffic_share` | Fingerprint routing | < 2% on primary URL |
| IKE | `ike_hybrid_establishment_rate` | Concentrator syslog | ≥ 95% post-firmware |
| IKE | `rekey_duration_p99` | Concentrator metrics | < 2× baseline |
| SSH | `pqc_host_key_negotiation_rate` | Bastion auth logs | ≥ 90% automation estate |
| Kafka | `broker_tls_hybrid_rate` | Broker JMX / metrics | 100% homogeneous cluster |
| mTLS | `partner_profile_v3_adoption` | API gateway | ≥ 85% GlobalSync |

### CBOM protocol attributes

Extend Chapter 11 Table 11.4 with protocol-class fields:

| Attribute | Values | Consumer |
|-----------|--------|----------|
| `protocol_class` | tls-external, ikev2-wan, ssh-admin, kafka-tls, … | Wave planner |
| `negotiation_policy_id` | Enterprise policy reference | Change management |
| `client_tier_distribution` | JSON: A/B/C/D percentages | Architecture review |
| `middlebox_assessment_ref` | Link to buffer test evidence | Assurance |
| `partner_sync_status` | blocked / pilot / production | Partner programme |
| `library_min_version` | Semver | CI/CD gate |

Marcus Chen's GlobalSync platform team rejected change tickets where `protocol_class` was populated but `library_min_version` failed platform baseline — linking protocol transition to Chapter 17 CI/CD gates.

---

## 12.18 Testing Protocol Transitions

Chapter 11 §11.15 defined hybrid testing categories; protocol transition adds **cross-protocol integration** requirements.

### Test categories

| Category | Scope | Pass criteria |
|----------|-------|---------------|
| **Functional** | Negotiation succeeds end-to-end | 100% test case pass |
| **Compatibility** | Tier A/B/C/D client matrix | Documented per-tier outcome |
| **Infrastructure** | Full inspection path | No truncation at max chain size |
| **Performance** | Handshake / rekey latency | Within SLA budget |
| **Failover** | Rollback to classical policy | < change window |
| **Partner** | Mutual test with top fan-in partners | Signed acceptance |
| **Observability** | Metrics populate dashboards | All protocol metrics live |
| **CBOM** | Attributes complete | Automated scan pass |

### Northfield OT soak requirements

Northfield required **30-day OT pilot** with historian replay validation before regional IKE hybrid production — zero data gap during rekey events. OT protocol testing budgets **longer soak periods** than cloud API tiers.

### GlobalSync partner test harness

Marcus Chen's team operated a **partner test environment** mirroring production mTLS policy versions — partners received self-service validation without production traffic risk. Environment policy version tracked CDG node `partner-mtls-policy-v3` exactly — drift between test and production invalidated partner sign-off.

---

## 12.19 Failure Modes and Recovery

| Failure mode | Symptom | Recovery | Prevention |
|--------------|---------|----------|------------|
| Middlebox truncation | Intermittent TLS failures on specific paths | Bypass or upgrade appliance | Buffer assessment Phase 3 |
| CPE firmware rejection | IKE SA_INIT failures | Pause rollout; firmware programme | CDG `vendor_pq_ga_date` |
| Partner trust rejection | mTLS handshake alert unknown CA | Rollback to v2 policy | Partner programme gate |
| Library binding mismatch | Service fails while ingress succeeds | Pin image; rebuild binding | CBOM `implements` to effective lib |
| Certificate chain incompatibility | Handshake succeeds; app rejects cert | Parallel issuer / cert profile | PKI Wave 0 sequencing |
| SSH known_hosts storm | Automation widespread failure | Parallel host keys | SSH-CA or staged rotation |
| Heterogeneous Kafka cluster | Broker protocol mismatch | Cluster-wide rollback | Homogeneous fleet rule |

---

## 12.20 Cross-Reference Map

| Topic | See |
|-------|-----|
| Hybrid TLS patterns and HLM deployment specification | Chapter 11 |
| HLM policy and sunset governance | Chapter 5 §5.6–5.9 |
| CBOM discovery and protocol inventory | Chapter 7 §7.3–7.4 |
| CDG blocking nodes, partner mTLS, VPN concentrators | Chapter 8 §8.3–8.10, §8.48 |
| Wave sequencing and TRADE E gating | Chapter 9 §9.2, §9.7 |
| Crypto-agility standards and library baselines | Chapter 10 |
| PKI certificate profiles and CA migration | Chapter 13 |
| HSM and key management for TLS/IKE keys | Chapter 14 |
| Procurement and partner contractual clauses | Chapter 16 |
| CI/CD cryptographic verification gates | Chapter 17 |

---

## 12.21 Apply in Your Organisation

1. **Adopt the five-phase protocol methodology** (§12.2) in change management — Discover through Production with explicit exit criteria per phase.
2. **Classify TLS clients into Tiers A/B/C/D** from production telemetry before enabling hybrid groups on primary URLs (Meridian pattern).
3. **Complete infrastructure buffer assessment** (Table 12.2) on every inspection hop — include maximum planned ML-DSA chain sizes.
4. **Publish minimum library versions** as Wave 0 platform standards — enforce via CI/CD, not advisory documentation (GlobalSync pattern).
5. **Model mTLS as bidirectional CDG trust chains** — server hybrid success does not imply mTLS transition complete.
6. **Inventory CPE and OT firmware** before scheduling IKE hybrid production — concentrator readiness is necessary, not sufficient (Northfield pattern).
7. **Implement parallel SSH host keys or SSH-CA** before PQC-only host key cutover — protect automation estates.
8. **Sequence Kafka and AMQP TLS** after internal PKI and mesh CA — inherit `trusts` edges, do not precede blocking nodes.
9. **Operate partner synchronisation programme** with measurable `partner_acceptance_pct` — advance production policy to slowest critical partner (GlobalSync principle).
10. **Populate and quarterly refresh Table 12.5** for your estate — attach TRADE E scores from evidence, not defaults.
11. **Present protocol readiness radar** to steering committee — counter TLS-only progress narratives.
12. **Scope S/MIME transition to Wave 2–3** with archival trust planning — brief treatment until mail gateway readiness confirmed.
13. **Maintain separate NSS and corporate protocol tracks** where applicable — Apex dual-track reporting.
14. **Extend CBOM with protocol-class attributes** (§12.17) and link to negotiation policy IDs for audit traceability.

---

## 12.22 Chapter Summary

- Protocol transition is **ecosystem synchronisation** across algorithms, libraries, protocol policy, certificates, partners, and middleboxes — not cipher-suite enablement on a single tier.
- **TLS 1.3** is the reference external protocol: named hybrid groups, tiered client cohorts, infrastructure buffer assessment, and PKI dependencies modelled separately in the CDG.
- **Middlebox interference** caused more early TLS incidents than client incompatibility — map and test the full inspection path before H1 production.
- **OpenSSL and library readiness** is Wave 0 infrastructure — language bindings and hardware offload frequently block negotiation despite updated server images.
- **IPsec/IKEv2** transition differs materially from TLS — CPE firmware, fragmentation, rekey timing, and OT historian requirements gate Northfield-style rollouts.
- **SSH** requires parallel host keys or SSH-CA migration sequencing — in-place rotation breaks automation at scale.
- **Kafka and AMQP** inherit internal PKI and mesh trust; homogeneous broker fleets prevent partial cluster hybrid.
- **mTLS doubles the trust chain problem** — partner client certificate policy blocked GlobalSync for nine months despite server-side hybrid success.
- **S/MIME** trails TLS in ecosystem readiness; archival verification horizons extend CA trust requirements into Wave 2–3.
- **Apex NSS protocols** follow CNSA 2.0 and accreditation boundaries — separate from corporate IT timelines.
- **The slowest critical partner sets production pace** — GlobalSync's operating principle prevents costly engineering rework.
- **Table 12.5 and protocol readiness radar** provide governance artefacts for steering committee and audit audiences.
- **Phased rollout follows CDG wave sequencing** — Wave 0 blocking nodes before protocol-class production at scale.

**Closing note:** Chapter 11 taught how to deploy hybrids. This chapter teaches **where and when each protocol can accept them** — and who must move first. The dependency graph from Part III is the schedule; partner and firmware inventories are the critical path. Protocol transition completes the channel layer; certificate and key trust migration is Chapter 13's domain.

**Next:** Chapter 13 addresses PKI evolution and certificate lifecycle — the blocking domain most enterprises underestimated until CDG analysis made the dependency visible.

---

*Chapter 12 — References*

- Basescu, C., et al. (2024). Deployment considerations for post-quantum cryptography. *USENIX Security Symposium*. https://www.usenix.org/conference/usenixsecurity24
- Campbell, R. (2025). Enterprise migration to post-quantum cryptography: Timeline analysis and strategic frameworks. *Computers*, 15(1), 9. https://doi.org/10.3390/computers15010009
- Internet Engineering Task Force. (2024–2026). Post-quantum hybrid key exchange for TLS 1.3 (standards track). *IETF TLS Working Group*.
- Internet Engineering Task Force. (2024). *RFC 9180*: Hybrid Public Key Encryption. https://www.rfc-editor.org/rfc/rfc9180
- National Institute of Standards and Technology. (2024). FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard. https://doi.org/10.6028/NIST.FIPS.203
- National Institute of Standards and Technology. (2024). FIPS 204: Module-Lattice-Based Digital Signature Standard. https://doi.org/10.6028/NIST.FIPS.204
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- OpenSSL Software Foundation. (2025–2026). OpenSSL 3.5 release notes and provider documentation. https://www.openssl.org/
- CycloneDX. (2024). *Authoritative Guide to CBOM*. OWASP Foundation.
- European Union. (2022). Regulation (EU) 2022/2554 on digital operational resilience for the financial sector (DORA).
