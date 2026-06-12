# Chapter 8
# The Cryptographic Dependency Graph

---

Marcus Chen's platform team shipped hybrid TLS in staging fourteen times in 2026. Each deployment passed security review. Each failed partner integration testing. The partner API gateway accepted hybrid server certificates — but **partner client certificates** remained chained to a classical root policy that rejected ML-DSA profiles. Marcus had a CBOM listing 200 client certificates. He did not have a graph showing they shared one policy node until enterprise architecture completed CDG Phase B.

The CDG made the failure pattern obvious: one blocking node, two hundred edges, zero production migrations until Wave 0 resolved partner trust. This chapter teaches readers to build that graph before spending engineering cycles on locally correct, globally blocked work.

---

## 8.1 Why a CBOM Is Not Enough

Chapter 7 produced a **Cryptographic Bill of Materials** — an inventory of components and attributes. Inventory answers *what exists*. It does not answer *what breaks if we change this*.

Meridian’s Phase 1 CBOM listed **14,200** cryptographic components. The programme office asked a simple question: *If we rotate the payment HSM’s firmware signing key to a hybrid scheme next quarter, what stops working?* The CBOM alone could not answer. The HSM appeared as one row. The dependency chain — manufacturing CA, code-signing policy, CI pipeline attestations, retail terminal trust stores, partner webhook verification — lived in engineers’ heads, wiki pages, and ticket comments.

**Cryptographic Dependency Graph (CDG)** is the structured model that connects inventory to consequence. It is the bridge between Register and Decide in ARCS: once you know *what* you have, you must know *how it connects* before you can prioritise waves.

> **Architect's Decision**  
> **Build the CDG from CBOM rows, not from architecture diagrams alone.** Diagrams show intent; CDG shows operational trust. Start with high-MPI CBOM entries and expand edges until blocking behaviour is visible.

---

## 8.2 CDG Definition

A **Cryptographic Dependency Graph** is a directed graph **G = (V, E)** where:

- **V (vertices / nodes)** represent cryptographic *roles* or *artefacts* — not always 1:1 with CBOM rows. A single CBOM component may map to multiple nodes (e.g., “TLS terminator” and “client cert issuer” are distinct roles).
- **E (edges)** represent *cryptographic relationships* with typed semantics.

### 8.2.1 Node types

| Node type | Description | Example |
|-----------|-------------|---------|
| **Key** | Symmetric or asymmetric key material | AES-256 data key; RSA-2048 signing key |
| **Certificate** | X.509 or CMS cert binding identity to key | Partner mTLS client cert |
| **Algorithm** | Named primitive + parameters | ECDSA P-256; ML-KEM-768 |
| **Protocol** | Negotiated crypto in a channel | TLS 1.2; SSH; IPsec IKEv2 |
| **Trust anchor** | Root or policy root accepted without further chain | Public Web PKI root; private manufacturing CA |
| **HSM / KMS** | Hardware or cloud key custody | Payment HSM; Cloud KMS CMK |
| **Firmware / image** | Signed artefact verified at boot or load | POS terminal firmware |
| **Policy** | Rule governing allowed algorithms or lifetimes | “TLS 1.2+ only”; FIPS mode |

Nodes carry **attributes** inherited from CBOM where applicable: `algorithm_family`, `key_size`, `hlm_phase`, `owner_team`, `environment`, `trade_mpi` (once scored in Chapter 9).

### 8.2.2 Edge types

| Edge type | Semantics | Example |
|-----------|-----------|---------|
| **implements** | Node realises algorithm or protocol | Key *implements* ECDSA P-256 |
| **trusts** | Node accepts another as authoritative | App *trusts* trust anchor |
| **terminates** | Protocol endpoint uses keys/certs | Load balancer *terminates* TLS with cert chain |
| **signs** | Parent cryptographically attests child | Manufacturing CA *signs* firmware image |
| **inherits** | Child derives policy or trust from parent | Subordinate CA *inherits* path length from root |
| **verifies** | Consumer checks signature or MAC | Bootloader *verifies* firmware signature |
| **wraps** | Key encrypts another key | KMS *wraps* data encryption key |

Edges may be **annotated** with: validity period, cipher suite set, criticality (`blocking` | `degradable` | `advisory`), and evidence pointer (scan ID, config path).

> **Dependency Alert**  
> **Transitive trust is the hidden risk.** Application A trusts anchor X. Partner B presents cert chained to X. Neither A nor B appears in a flat inventory link — but changing X breaks both. CDG makes transitivity explicit.

---

## 8.3 Blocking Nodes

A **blocking node** is a vertex whose migration or rotation *must complete* (or be explicitly dual-run) before dependent workloads can adopt post-quantum algorithms. Blocking is not merely “high MPI” — it is **structural**: many edges fan in.

### 8.3.1 Detection heuristics

| Signal | Interpretation |
|--------|----------------|
| In-degree ≥ N (e.g., 50) on `trusts` or `signs` edges | Hub anchor or signing authority |
| Single HSM node with `signs` to >10 firmware families | Firmware programme blocker |
| Partner API gateway with uniform client cert policy | Ecosystem blocker (GlobalSync pattern) |
| Enterprise root CA with 200+ issued server certs | PKI explosion node |
| OT protocol gateway translating legacy ciphers | Plant-floor blocker |

### 8.3.2 Blocking vs bottleneck

| Concept | Definition | Migration response |
|---------|------------|-------------------|
| **Blocking node** | No dependent may complete PQ transition until resolved | Plan early wave or parallel trust |
| **Bottleneck** | Slows programme but alternatives exist | Optimise scheduling; may defer |
| **Leaf node** | No dependents | Migrate when convenient subject to TRADE |

Chapter 9’s wave planner consumes blocking flags: **Wave 0** often addresses blocking nodes with long lead times (HSM firmware, root CA, partner standards).

---

## 8.4 GlobalSync: Partner API as Blocking Node

GlobalSync operates a **partner integration hub**: 200+ microservices consume outbound API calls authenticated via **mutual TLS** with certificates issued under a single **partner root policy**. The CBOM listed each microservice’s client cert as an independent row — 200 rows, 200 “owners,” false sense of distributed control.

CDG reconstruction revealed one **blocking node**: `partner-mtls-policy-v3` (trust anchor + issuance template). Every microservice node held a `trusts` edge to that policy node. Rotating to hybrid TLS or changing allowed signature algorithms without updating the policy node would cause **simultaneous partner outage**.

```
                    [partner-root-CA]
                           | signs
                    [partner-issuing-CA]
                           | signs
              +------------+------------+
              |            |            |
        [svc-A cert] [svc-B cert] ... [svc-N cert]
              |            |            |
         trusts       trusts       trusts
              +------------+------------+
                           |
                  [partner-mtls-policy-v3]  <-- BLOCKING NODE
                           ^
                           | terminates
                    [Partner API Gateway]
```

**Programme actions:**

1. **Elevate** policy node to Wave 0 with executive sponsor (already identified in Chapter 6 H2 trigger).
2. **Negotiate** partner acceptance of hybrid chains or parallel trust stores before microservice waves.
3. **Refactor** CBOM: tag all 200 certs with `depends_on: partner-mtls-policy-v3` to prevent spurious per-team migration projects.

**Partner negotiation timeline (illustrative):** GlobalSync spent nine months on partner outreach — 400 partners contacted, 200 actively integrated, 85 accepting pilot hybrid profiles by month nine. CDG node attribute `partner_acceptance_pct` tracked monthly for steering committee. Marcus refused engineering pressure to deploy hybrid client certs until acceptance exceeded 85% — ecosystem dimension (Chapter 9, E) gated production.

**Microservice team impact:** Teams with completed hybrid library upgrades remained in "do not migrate yet" for production toggle — local readiness without ecosystem readiness is insufficient (Chapter 9 §9.7).

> **Migration Moment**  
> GlobalSync’s architecture review had approved PQ-ready libraries in 14 services — but none could deploy until partner trust policy allowed ML-DSA or hybrid cert profiles. The CDG made the sequencing conflict visible in one diagram; the CBOM had hidden it in row count.

---

## 8.5 Meridian: HSM Firmware Signing Chain

Meridian’s payment HSM blocking node spans **manufacturing**, **crypto engineering**, and **retail operations**:

| Node | Role | Edge pattern |
|------|------|--------------|
| Manufacturing root CA | Trust anchor for device identity | `signs` → subordinate CA |
| Code-signing CA | Issues firmware signatures | `signs` → firmware images |
| Payment HSM | Stores signing key; audits operations | `implements` FIPS module |
| Retail terminals | Verify firmware at boot | `verifies` ← firmware; `trusts` manufacturing root |
| Partner webhooks | Verify Meridian-signed payloads | `trusts` webhook signing cert |

Changing the HSM’s signing algorithm without dual signatures would brick field terminals until trust stores updated — a **physical logistics** problem, not a CI/CD toggle. CDG edges to `retail-terminal-fleet` carried attribute `blocking: true, lead_time_months: 9`.

**Architect's Decision:** Meridian chose **dual-signature firmware** (legacy + hybrid) for one release cycle before retiring legacy — CDG edge annotations documented which terminal firmware versions accepted which signature types.

---

## 8.6 Northfield: OT Gateway as Protocol Translator

Northfield’s plant networks use **legacy OPC UA** and proprietary fieldbus crypto with **short key lengths** and **fixed cipher suites** on embedded gateways. The OT gateway node:

- `terminates` modern TLS from enterprise IT
- `implements` legacy field protocols toward PLCs
- `trusts` a single internal CA for both sides

PQ migration cannot start at the PLC. The **blocking node** is the gateway firmware and its trust bundle. CDG showed **18 production lines** fanning into one gateway model — matching the “18 identical gateways” inventory pattern from Chapter 7.

Wave plan implication: **one gateway qualification** unlocks 18 lines — high leverage, but firmware vendor roadmap gates the node (TRADE dependency dimension).

---

## 8.7 Apex: Classified Boundaries and NSS Isolation

Apex maintains **NSS-aligned** enclaves where CDG construction follows different rules:

- **Air-gapped segments** do not share trust anchors with corporate CDG — separate graph component `G_apex_nss`.
- **Cross-domain guards** appear as nodes with `terminates` edges on both sides; changing algorithms requires **accreditation artefact** updates, not only config.
- **Blocking nodes** include **STIG-validated modules** where FIPS 140-3 and NSM policy intersect.

Corporate CBOM rows must not automatically merge into NSS CDG without **classification review**. Apex uses `boundary_tag: nss` on nodes; automated graph merge tools are disabled for those components.

> **Regulatory Lens**  
> For NSS-bound systems, CDG edges may need to reference **authorisation packages** (ATO, interim authorisation) as evidence attachments — the graph is audit evidence, not only engineering documentation.

---

## 8.8 PKI Dependency Explosion

Enterprise PKI is the most common source of **edge explosion**. A single root CA node may have:

- 500+ `signs` edges to server certificates
- 50+ `inherits` edges to subordinate CAs
- Thousands of indirect `trusts` edges via applications

**Compression strategies** for human-readable CDG views:

| Strategy | When to use |
|----------|-------------|
| **Roll-up by template** | Certs issued from same profile collapse to one meta-node |
| **Roll-up by workload** | All certs on `cluster-prod-payments` as one consumer node |
| **Hop-limited view** | Show depth-1 and depth-2 only; lazy-expand on click |
| **Blocking-only filter** | Executive dashboard: nodes with `blocking: true` |

Meridian’s uncompressed CDG export reached **1.2 million edges** after automated cert discovery — unusable for workshops. Roll-up by template reduced to **4,800** edges while preserving blocking nodes.

---

## 8.9 Building the CDG: Methodology

CDG construction is a **programme workstream**, not a one-off architecture diagram. Meridian allocated three parallel domain teams — payments, corporate IT, OT — each producing subgraphs merged at programme office.

### Roles and staffing

| Role | Responsibility | FTE (illustrative) |
|------|----------------|-------------------|
| CDG architect | Schema, merge rules, tool config | 1.0 |
| Domain enricher | Interviews, config harvest per domain | 0.5 per domain |
| PKI specialist | CA/signs edge validation | 0.25 |
| OT liaison | Site surveys, vendor workshops | 0.5 (Northfield) |
| Programme integrator | TRADE/wave feed, dashboard | 0.25 |

### Phase A — Seed from CBOM

1. Import all CBOM components with `crypto_relevant: true`.
2. Create nodes for keys, certs, HSMs, trust stores referenced in attributes.
3. Infer initial edges from: `issuer`, `subject`, `parent_component_id`, `trust_store_ref`.

### Phase B — Enrich via interviews and config

| Source | Edge types discovered |
|--------|----------------------|
| TLS config dumps | `terminates`, cipher suite `implements` |
| Code signing pipelines | `signs`, `verifies` |
| IaC (cert-manager, ACM ARNs) | `trusts`, `inherits` |
| Partner integration docs | `trusts` to partner anchors |

### Phase C — Validate

- **Blast-radius exercise:** For each candidate blocking node, list dependents via reverse BFS.
- **Orphan detection:** Nodes with no edges — likely inventory gap.
- **Cycle detection:** `trusts` cycles may indicate mis-modelled bi-directional trust.

### Phase D — Publish views

| Audience | View |
|----------|------|
| Executive | Top 10 blocking nodes + MPI |
| Domain architect | Full subgraph per application |
| Auditor | Evidence links on edges |
| Wave planner | Blocking flags + lead times (feeds Chapter 9) |

---

## 8.10 Northfield: VPN Concentrators and WAN Trust

Northfield's enterprise WAN connects compressor stations, regional control centres, and cloud analytics through **IPsec VPN concentrators** terminating on shared internal PKI. CDG analysis showed:

- One **internal root CA** node with `signs` edges to 14 concentrator certificates
- Each concentrator `terminates` IPsec toward 40–120 field devices per site
- Field devices `trust` the same root via burned-in trust stores on gateway firmware

The VPN concentrator is not the highest MPI asset in TRADE scoring — individual historian archives score higher on Threat. But concentrator migration is **Wave 0 structural**: until concentrators accept hybrid IKE or PQC-only profiles validated against field gateway firmware, WAN encryption migrations stall.

James Whitfield's programme mapped **firmware vendor roadmaps** to concentrator nodes — edge attribute `vendor_pq_ga_date` — feeding Chapter 9's "do not migrate yet" conditions. Northfield rejected a proposal to migrate cloud analytics TLS first while WAN remained classical-only; CDG showed cloud data transited the concentrator trust domain.

> **Architect's Decision**
>
> **Do not let threat-priority waves override CDG blocking without explicit risk acceptance.** High-TES archives matter — but if WAN trust cannot deliver keys to re-encrypted archives, migration order inverts. CDG and TRADE interact; neither alone sequences the programme.

---

## 8.11 Meridian: Enterprise PKI Roll-Up Worked Example

Meridian's uncompressed PKI CDG contained **847,000** `signs` edges from automated certificate discovery. Executive workshops were unusable. Roll-up methodology:

**Step 1 — Template classification:** Group server certs by issuance template (`web-tls-prod`, `api-mtls-internal`, `partner-b2b`).

**Step 2 — Consumer clustering:** Map certs to consuming workload (Kubernetes ingress class, API gateway pool).

**Step 3 — Meta-node creation:** Replace 200 certs on `payments-ingress` with single consumer node `payments-ingress-tls` linked to issuing CA.

**Step 4 — Blocking preservation:** Never roll up manufacturing root CA, payment HSM signing key, or partner policy nodes — always expand.

Result: **4,800** edges in executive view; full graph retained for engineering queries. Blocking node `payment-hsm-firmware-signer` showed in-degree 0 on `signs` but out-degree 2,400 on `verifies` through firmware image nodes — revealing retail terminal dependency.

**Table 8.1 — PKI CDG Roll-Up Rules**

| Node type | Roll-up allowed? | Rationale |
|-----------|------------------|-----------|
| End-entity server cert | Yes, by template + consumer | Reduces noise |
| Partner client cert | Partial — keep partner dimension | Partner negotiation granularity |
| Subordinate CA | No | Path length and policy inheritance |
| Root / policy CA | No | Blocking hub |
| HSM signing key | No | Ceremony and audit sensitivity |
| Firmware image | No | OT and terminal blast radius |

---

## 8.12 Edge Validation and Evidence Attachments

CDG edges are claims requiring evidence — especially for audit and regulatory dialogue.

| Edge type | Minimum evidence | Validation method |
|-----------|------------------|-------------------|
| `terminates` | TLS config export or live scan | Automated + annual sample |
| `signs` | CA audit log, ceremony record | PKI team attestation |
| `trusts` | Trust store file hash, JVM cacerts | Config management drift detection |
| `verifies` | Boot policy, code signing CI log | Firmware team review |
| `inherits` | CA certificate policy document | PKI governance |

Meridian attached `evidence_ref` URIs to edges — GRC platform links, not embedded documents. Apex NSS edges required classification labels on evidence pointers.

**Stale edge detection:** Certificate expiry jobs trigger CDG edge review — if cert renewed with new issuer, `signs` edges update automatically where PKI integration exists.

---

## 8.13 Query Patterns for Programme Roles

Graph queries translate CDG value into role-specific outputs:

**Programme director — blocking fan-in:**
```
MATCH (n)<-[r:trusts|signs|verifies]-(dependent)
WHERE n.blocking = true
RETURN n.label, count(dependent) AS fan_in
ORDER BY fan_in DESC LIMIT 20
```

**Domain architect — blast radius:**
```
MATCH path = (anchor {id: $node})<-[:trusts|signs*1..3]-(dep)
RETURN dep.label, length(path)
```

**Auditor — evidence completeness:**
```
MATCH ()-[e]->() WHERE e.evidence_ref IS NULL
RETURN count(e) AS undocumented_edges
```

GlobalSync embedded queries in programme dashboard — Marcus Chen's team reviewed top five blocking nodes weekly during Wave 0.

---

## 8.14 CDG Maturity Model

| Level | Characteristics | Programme implication |
|-------|-----------------|----------------------|
| **CDG-0** | No graph; dependencies in wiki | Cannot defensibly sequence waves |
| **CDG-1** | Seed from CBOM; sparse edges | Identify candidate blocking nodes |
| **CDG-2** | Enriched via interviews; blocking flagged | Wave 0 draft credible |
| **CDG-3** | Automated refresh; evidence on edges | Steering committee operational view |
| **CDG-4** | Integrated TRADE + change management | Continuous reassessment |

Meridian reached CDG-2 at Phase 1 exit; CDG-3 target by end of Wave 0 execution. Programmes claiming CDG-4 without CI/CD integration typically overstate maturity.

---

## 8.15 Partner and Ecosystem Edges

B2B integrations introduce **external trust anchors** — partner roots, industry hubs, card network PKI. Modelling rules:

1. Partner root is distinct node — not merged with enterprise root
2. `trusts` edge from enterprise service to partner anchor carries `mutual_tls: true`
3. Blocking when partner policy uniform across many internal consumers (GlobalSync pattern)
4. Edge attribute `partner_sla_pq_date` when contractually obtained

**Card network integration (Meridian):** Single `card-scheme-trust-policy` node blocked 340 merchant endpoint configs — procurement negotiated scheme-level PQ roadmap before per-merchant projects.

---

## 8.16 Tooling and Storage

CDG may be stored as:

- **Graph database** (Neo4j, Neptune) — natural fit for queries
- **JSON-LD / RDF** — semantic interoperability
- **Relational** (nodes + edges tables) — sufficient for many enterprises

Minimum viable schema:

```
Node: { id, type, label, attributes{}, cbom_ref?, blocking, lead_time_months? }
Edge: { id, from, to, type, attributes{}, evidence_ref? }
```

**Versioning:** CDG snapshots align with CBOM versions. Diff tools highlight new edges after each discovery tranche — edge *growth* is a programme health metric.

**Illustrative budget (planning example):** Graph platform licence + 0.5 FTE graph curator for year one — **$180k–$320k** depending on existing CMDB integration.

---

## 8.17 CDG and TRADE Integration

Chapter 9 scores workloads using TRADE. The **Dependency (D)** dimension draws directly from CDG:

| CDG signal | TRADE D score input |
|------------|---------------------|
| Blocking node with no alternate path | D = 5 (highest friction) |
| Multiple dependents, single anchor | D ≥ 4 |
| Leaf cert with isolated trust | D = 1–2 |
| Cross-vendor edge (no SLA on PQ) | D +1 modifier |

**Migration Propensity Index (MPI)** combines T, R, A, D, E — but **blocking nodes** can override MPI ordering: a low-MPI service that trusts a high-blocker root must wait regardless of its own score.

---

## 8.18 Failure Modes

| Failure | Symptom | Mitigation |
|---------|---------|------------|
| **Flat graph** | Every node connects to “corporate root” only | Enrich with terminates/signs from configs |
| **False leaves** | Missing partner trust edges | Partner integration tranche |
| **Stale edges** | Certs renewed but graph not updated | Tie CDG refresh to cert expiry jobs |
| **Over-blocking** | Everything marked blocking | Use in-degree thresholds + business review |
| **Tool obsession** | Months building graph, no waves | Time-box Phase A–C to 8–12 weeks per domain |

---

## 8.19 Workshop: One Blocking Node Deep Dive

**Exercise (90 minutes):** Select one anchor from your inventory (internal CA, HSM, partner policy). Facilitator guides:

1. Reverse BFS: list all nodes within 3 hops.
2. Classify each dependent: production / non-prod / unknown.
3. Estimate minimum lead time to change anchor algorithm.
4. Decide: Wave 0, dual-trust period, or defer with documented risk.

**Deliverable:** One-page **blocking node brief** for steering committee.

---

## 8.20 Apex: Contract Renewal and Cross-Domain Guards

Apex's commercial division serves defence primes under **contract flow-down** requiring CNSA-aligned cryptography on deliverables. CDG separated:

- **Corporate product signing** — commercial root CA, NIST IR 8547 timeline
- **NSS deliverable signing** — CNSA root, accelerated milestones
- **Cross-domain guard** nodes — data diode and guard appliance crypto policies

A proposal to unify signing under corporate PKI for cost savings failed CDG review: NSS deliverable nodes held `boundary_tag: nss` with no `trusts` path to corporate root. Unification would have created **cross-classification edge** violating accreditation boundaries.

Contract renewal cycles (Chapter 9) aligned with CDG node `contract_renewal_date` — Priya Nair's team sequenced Wave 0 NSS firmware signing before commercial TLS because CDG showed three active contracts with 2027 renewal gates referencing signing algorithm clauses.

---

## 8.21 Dual-Run and Parallel Trust Periods

Blocking nodes often require **parallel trust** — accepting both legacy and hybrid signatures during transition. CDG models parallel trust as:

- Additional `trusts` edge from consumer to hybrid anchor
- Edge attribute `parallel_trust_until: 2028-12-31`
- `signs` edges from two CAs to same firmware image during dual-signature period

Meridian's retail terminal fleet required six-month parallel trust after hybrid firmware release — CDG edge annotations prevented premature retirement of legacy anchor.

**Failure mode:** Parallel trust without sunset — terminals accept classical signatures indefinitely. *Remediation:* `parallel_trust_until` mandatory on CDG edges; CBOM `hlm_phase` tracks H1/H2.

---

## 8.22 CDG Anti-Patterns

| Anti-pattern | Description | Consequence |
|--------------|-------------|-------------|
| **Spaghetti trust** | Every app trusts corporate root only | Hides partner and OT subgraphs |
| **Frozen graph** | Built once in Phase 1 | Misses new microservices |
| **Over-graphing** | Modelling every cert separately | Analysis paralysis |
| **Under-graphing blocking** | Roll-up includes roots | Misses Wave 0 nodes |
| **Tool-first** | Months configuring Neo4j, no workshops | No executive buy-in |
| **CMDB mirroring** | Nodes = servers, not crypto roles | Wrong abstraction |

---

## 8.23 Apply in Your Organisation

- [ ] Define CDG node and edge type enums aligned to your CMDB/CBOM schema
- [ ] Import CBOM Phase 1 as seed nodes; run automated edge inference
- [ ] Identify nodes with in-degree > threshold; candidate blocking set
- [ ] Produce executive “top 10 blocking nodes” view with owners
- [ ] Document GlobalSync-style partner policy nodes if applicable
- [ ] Separate NSS/classified CDG components if applicable (Apex pattern)
- [ ] Set CDG refresh cadence tied to CBOM maintenance (Chapter 7)
- [ ] Feed blocking flags and lead times into wave planning (Chapter 9)

---

## 8.24 GlobalSync Microservices: Dependency Inversion

Before CDG analysis, GlobalSync's microservice teams believed migration order should follow **customer visibility** — public APIs first, internal services second. CDG inverted the sequence:

| Assumed order | CDG-revealed order |
|---------------|-------------------|
| 1. Public API TLS | 1. Partner mTLS policy (blocking) |
| 2. Customer portal | 2. Service mesh root CA |
| 3. Internal batch jobs | 3. Tenant KMS partition policy |
| 4. Partner integrations | 4. Public API TLS (after partner gate) |

Marcus presented the inversion to engineering VPs with fan-in counts — 200 services trusting one policy node. Resistance faded when teams realised local hybrid TLS work would be **reverted** if partner policy rejected client cert profiles.

**Service mesh root** emerged as second blocking node — Istio control plane issued certs under internal CA consumed by 180 namespaces. Mesh migration became Wave 0 item 2 with shared timeline to partner policy.

---

## 8.25 Meridian Payment Chain: Ceremony to Terminal

Deep CDG expansion of Meridian's payment HSM blocking chain:

```
[Manufacturing Root CA]
        | signs
[Manufacturing Issuing CA]
        | signs
[Payment HSM FW Signing Key]  <-- ceremony-controlled
        | signs
[POS Terminal Firmware v4.x]
        | verified by
[Retail Terminal Fleet ~12,400 devices]
        | trusts
[Manufacturing Root in terminal trust store]
```

**Ceremony nodes** — HSM signing key — require manual edge validation annually. PKI automation cannot discover ceremony access controls; interview-based enrichment mandatory.

**Terminal fleet** node carried attribute `logistics_refresh_months: 9` — physical device update capacity constrained Wave 0 exit. Elena escalated to COO for retail operations coordination — CDG made organisational dependency visible, not only technical.

**Webhook signing** branch from same HSM connected 890 partner webhook verifiers — dual blast radius: firmware and API integrity.

---

## 8.26 CDG Diff and Programme Health Metrics

| Metric | Healthy trend | Warning signal |
|--------|---------------|----------------|
| Edge count growth | Stable after initial enrichment | Explosive growth without new systems |
| Undocumented edges % | Decreasing toward <5% | Flat above 20% |
| Blocking node count | Stable or decreasing | Increasing — new hubs discovered late |
| Orphan nodes | Decreasing | Flat — discovery gap |
| Evidence attachment % | Increasing | Flat — audit risk |

Meridian published CDG health quarterly alongside CBOM quality dashboard. **Edge growth spike** in Q2 2027 revealed shadow IT API gateway — 40 new microservices trusting ad hoc self-signed CA — caught before Wave 2 PKI migration.

---

## 8.27 Executive CDG Dashboard

Board and steering views require **top-N blocking nodes** only:

| Rank | Node | Fan-in | Owner | Wave | Lead time |
|------|------|--------|-------|------|-----------|
| 1 | partner-mtls-policy-v3 | 203 | Platform security | W0 | 14 mo |
| 2 | payment-hsm-fw-signer | 2,400 verify | Crypto ops | W0 | 18 mo |
| 3 | manufacturing-root-ca | 340 | PKI | W0 | 12 mo |

Drill-down available for architects; executives see trend in fan-in reduction quarter-over-quarter.

---

## 8.28 Time-Boxing CDG Construction

Chapter 8 failure mode "tool obsession" warrants explicit time boxes:

| Phase | Duration | Exit criterion |
|-------|----------|----------------|
| A — CBOM seed | 4 weeks | Nodes for all verified CBOM rows |
| B — Interview enrich | 6 weeks | Top 20 blocking candidates validated |
| C — Validate | 2 weeks | Blast-radius worksheets complete |
| D — Publish | 2 weeks | Executive dashboard live |

**Total:** 14 weeks per major domain (payments, corporate IT, OT). Meridian ran three parallel domain streams — 14 weeks calendar, not sequential 42 weeks.

---

## 8.29 CDG and Procurement

Vendor roadmaps attach to **blocking nodes**, not individual servers. Procurement clauses:

> HSM vendor shall deliver PQC-capable firmware signing module supporting ML-DSA-65 dual-signature by [date]. Failure impacts CDG node [id] blocking 2,400 downstream verifiers.

Apex linked **$4.2M renewal** to vendor delivery milestone on NSS firmware signing node — contract language referenced CDG node ID from programme repository.

---

## 8.30 Trust Store and JVM Classpath Discovery

Many enterprises discover TLS certs but miss **trust stores** — JVM `cacerts`, Linux `/etc/ssl/certs`, Windows root stores, mobile pinning bundles. CDG requires explicit **trusts** edges from applications to trust store nodes.

Meridian discovered 23 custom trust stores in payment microservices — each trusting different partner root subsets. Roll-up to single "corporate trust" would have hidden partner-specific blocking.

**Discovery approach:**

1. Configuration management export of trust store paths
2. Container image layer inspection for bundled `.pem` files
3. Runtime attachment tracing (staging only) for JVM trust loaders

---

## 8.31 Mutual TLS Bidirectional Modelling

Mutual TLS creates **bidirectional** cryptographic dependencies — client cert and server cert may chain to different roots. Model as two `terminates` nodes plus two `trusts` edges, not one "mTLS" blob.

GlobalSync partner API:

- Server presents `api.globalsync.com` cert → partner trusts GlobalSync issuing CA
- Client presents partner cert → GlobalSync trusts partner root policy node

Blocking node was **partner root policy** on client side — not server TLS cert visible in external scan.

---

## 8.32 Firmware and Boot Chain CDG Patterns

Firmware CDG chains follow repeating pattern:

```
[Root of trust] → signs → [Bootloader] → verifies → [Kernel] → verifies → [App]
```

OT devices may embed root in ROM — **non-rotatable** without hardware refresh. Northfield flagged ROM-root devices as `blocking: true, refresh_only: true` — wave planning tied to capital refresh, not software migration alone.

---

## 8.33 CDG Versioning and Change Control

CDG snapshots versioned `cdg-2026-Q1`, aligned to CBOM `bom-version`. Change control rules:

- Automated edge additions from cert renewal — no CAB
- New trust edge to external root — security CAB
- Blocking flag change — programme steering approval

Diff report highlighted **47 new trust edges** in Q1 2027 — shadow API gateway discovery triggering Wave 2 reprioritisation.

---

## 8.34 Multi-Organisation CDG Merge Patterns

Conglomerates and shared service models require **federated CDG** — subgraphs per business unit merged at programme office with consistent node IDs.

| Pattern | When | Risk |
|---------|------|------|
| Federated merge | Autonomous BUs | ID collision — use namespace prefix |
| Hub-and-spoke | Shared services BU | Spoke omission |
| Acquisition integration | M&A | Duplicate roots |

Meridian subsidiary acquisition added 2,100 CBOM rows — CDG merge discovered duplicate trust to same card network root already modelled — consolidation reduced blocking node duplication in board reporting.

---

## 8.35 CDG for Cloud Shared Responsibility

Cloud models split cryptographic responsibility — CDG must tag `custody: customer|provider|shared`:

| Service | Typical customer CDG nodes | Provider opaque |
|---------|---------------------------|-----------------|
| IaaS VM TLS | Customer cert, customer keys | Hypervisor |
| Managed KMS | Key policy, CMK | HSM hardware |
| SaaS app | Integration certs | Application crypto |

GlobalSync as **provider** published customer-visible CDG excerpt for platform crypto — customers merged provider excerpt with their tenant config CBOM for complete tenant subgraph.

---

## 8.36 Facilitating CDG Enrichment Interviews

CDG Phase B interviews fail when treated as security audits. Facilitation guidance:

**Prepare:** Send interviewees their CBOM rows 48 hours ahead — no surprise interrogations.

**Open with blast radius:** *"If we change this CA, what stops working?"* — not *"List your algorithms."*

**Capture edge language:** Interviewee says "we trust corporate root" — facilitator translates to `trusts` edge with evidence request.

**Time-box:** 60 minutes per team; escalate complex PKI chains to dedicated PKI session.

**Document unknowns:** "I don't know" becomes orphan node with owner — not omitted edge.

Meridian ran **120 interviews** over eight weeks — payments domain alone required 35 sessions including retail operations representatives who understood terminal trust stores but not TLS.

---

## 8.37 CDG Deliverables Checklist

| Deliverable | Audience | Format |
|-------------|----------|--------|
| Full graph export | Engineering | Graph DB or JSON |
| Executive top-10 blocking | Board, steering | Table + trend |
| Domain subgraphs | Architects | Filtered views |
| Blocking node briefs | Wave 0 planners | One-pager each |
| Evidence gap report | Audit | Undocumented edges |
| CDG health metrics | Programme office | Dashboard |

---

## 8.38 Chapter Summary

- CDG extends CBOM from inventory to consequence — *what breaks if we change this*.
- Node types (key, cert, anchor, HSM, firmware, policy) and edge types (`trusts`, `signs`, `terminates`, `verifies`, `inherits`) form the modelling vocabulary.
- Blocking nodes have structural fan-in — GlobalSync partner mTLS policy, Meridian HSM firmware chain, Northfield VPN concentrators.
- PKI roll-up compresses noise while preserving blocking hubs; 847,000 edges became 4,800 in Meridian executive view.
- Evidence attachments on edges support audit; stale edge detection ties to cert lifecycle.
- CDG maturity CDG-0 through CDG-4 sets programme expectations.
- Parallel trust periods must carry sunset annotations on graph edges.
- Chapter 9 consumes blocking flags and TRADE scores into migration waves.

**Next:** Chapter 9 converts CDG topology and TRADE scoring into board-approved migration waves.

---

## 8.25 References and Further Reading

- CycloneDX CBOM linkage to dependency concepts — [CycloneDX CBOM](https://cyclonedx.org/capabilities/cbom/)
- NIST SP 1800-38B — migration planning and asset dependency themes
- IETF ARCHITECTURE FOR POST-QUANTUM PKI (drafts) — trust anchor evolution
- MERGE programme dependency management patterns (informative)

---

*Next: [Chapter 9 — Risk Tiering and Migration Wave Planning](chapter-09-risk-tiering-wave-planning.md)*
