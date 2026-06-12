# Chapter 14
# Key Management, HSMs, and Cloud Cryptography

---

Elena Vasquez's programme office declared Meridian Mutual Bank's Wave 0 **architecturally ready** in March 2027. The hybrid TLS pilot negotiated successfully. The root CA overlap strategy was approved. The CDG showed three blocking nodes resolved. Production migration stalled on a fourth dependency nobody had underestimated: **key custody**.

The payment HSM could not generate ML-DSA-87 signatures in production until a firmware module completed FIPS 140-3 revalidation. The cloud KMS wrapping keys for customer data encryption supported ML-KEM in the vendor's roadmap slide — but not in the FIPS boundary Meridian's DORA evidence required. Apex Defense Technologies' classified partition could not share ceremony procedures with corporate IT without accreditation rework. GlobalSync's multi-tenant platform needed tenant-scoped BYOK patterns that hybrid TLS configuration alone did not address.

Key management is where cryptographic policy meets **physical and contractual reality**. Algorithms selected in Chapter 4, hybrid patterns deployed in Chapter 11, and certificate profiles defined in Chapter 13 all assume keys exist in the right place, with the right ceremonies, under validated modules, at acceptable performance. This chapter teaches the KMS and HSM architecture patterns enterprises need to make those assumptions true — sequenced against CDG blocking nodes from Part III and governed by the agility standards from Chapter 10.

---

## 14.1 Key Management as the Migration Bottleneck

Post-quantum migration accelerates key management from background infrastructure to **programme-critical path**. Three factors drive the shift:

| Factor | Classical era assumption | PQC migration reality |
|--------|-------------------------|----------------------|
| Key and signature size | HSM buffers adequate for decades | ML-DSA-87 public keys and signatures stress partition storage and ceremony media |
| Module validation | Annual FIPS recertification cycle | New algorithm implementations require CMVP listing — vendor roadmaps gate Wave 0 |
| Ceremony complexity | M-of-N key generation well understood | Dual-algorithm H1 ceremonies; classified/unclassified separation; cloud BYOK import paths |
| Performance | Signing latency invisible at payment volumes | ML-DSA signing throughput affects HSM sizing and batch windows |
| Cloud custody | KMS "handles encryption" | Shared responsibility model; customer must verify PQC algorithm support inside FIPS boundary |

Chapter 8 established that Meridian's payment HSM firmware signing chain is a **blocking node** with nine-month terminal fleet lead time. Chapter 9 placed HSM and KMS dependencies in Wave 0. This chapter completes the architecture: how to assess vendors, partition HSMs, adapt ceremonies, and operate multi-cloud custody without treating cloud KMS as a black box.

> **Migration Moment**
>
> *"Our cloud provider said they're PQC-ready — isn't that enough for key management?"*
>
> Cloud provider readiness announcements rarely specify **which algorithms** sit inside the FIPS 140-3 validated boundary, **which regions** expose them, and **whether BYOK import** accepts ML-DSA key material. Meridian's procurement team learned to demand CMVP certificate numbers and algorithm implementation letters — not marketing slides. Readiness without validated module evidence is inventory optimism, not architecture.

---

## 14.2 KMS Migration Architecture

A **KMS migration architecture** describes how keys move from classical-only custody to PQC-capable custody across HSM appliances, cloud KMS, and application integrations — without breaking dependent systems mid-transition.

### 14.2.1 Architectural layers

| Layer | Responsibility | PQC migration concern |
|-------|----------------|----------------------|
| **Policy** | Algorithm matrix, HLM phase, workload-class key types | Which key types must be ML-KEM vs classical during H1 |
| **Custody** | HSM partition, cloud KMS, virtual HSM | FIPS module validation; partition capacity |
| **Wrapping** | Key encryption keys (KEKs), envelope encryption | Hybrid wrap during H1; PQC-only wrap at H2 |
| **Integration** | Applications, PKCS#11, KMIP, cloud SDK | Provider abstraction (Chapter 10); no algorithm literals |
| **Governance** | Ceremonies, access control, audit | Dual-custody for ML-DSA root ceremonies |
| **Evidence** | CBOM rows, CMVP certs, ceremony logs | DORA and NSS accreditation packages |

### 14.2.2 Migration topology patterns

Enterprises typically adopt one of three topologies — often concurrently across workload classes:

**Pattern A — In-place module upgrade.** Existing HSM fleet receives firmware or software module updates adding PQC algorithms. Keys remain in current partitions; ceremonies add PQC key generation steps. *Meridian payment HSM path.*

**Pattern B — Parallel partition or cluster.** New HSM partitions (or appliances) host PQC keys while classical partitions serve H1 hybrid operations. Cutover is deliberate; rollback retains classical partition. *Apex classified/unclassified split.*

**Pattern C — Cloud KMS with optional dedicated HSM.** Application wrapping moves to cloud KMS with PQC-capable customer master keys (CMKs). On-premises HSM retained for high-assurance signing only. *GlobalSync tenant encryption pattern.*

**Figure 14.1 — KMS Migration Topology (Multi-Pattern)**

```
                    ┌─────────────────────────────────────┐
                    │     Enterprise algorithm policy      │
                    │     (HLM phase, profile IDs)         │
                    └─────────────────┬───────────────────┘
                                      │
          ┌───────────────────────────┼───────────────────────────┐
          v                           v                           v
   ┌──────────────┐           ┌──────────────┐           ┌──────────────┐
   │ Pattern A    │           │ Pattern B    │           │ Pattern C    │
   │ In-place     │           │ Parallel     │           │ Cloud KMS    │
   │ module       │           │ partition    │           │ + HSM anchor │
   └──────┬───────┘           └──────┬───────┘           └──────┬───────┘
          │                          │                          │
          v                          v                          v
   [HSM firmware      [Partition A: classical]    [Cloud KMS CMK]
    upgrade path]      [Partition B: PQC-native]     [BYOK/HYOK path]
          │                          │                          │
          └──────────────────────────┴──────────────────────────┘
                                      │
                                      v
                         [Application provider layer]
                         (Chapter 10 — no direct HSM calls)
```

**Production brief — Figure 14.1:** Three-column diagram with policy layer on top; annotate each pattern with HLM phase suitability (A for H0→H1 transition; B for NSS separation; C for SaaS scale).

### 14.2.3 Migration phases aligned to HLM

| HLM phase | KMS posture | Typical actions |
|-----------|-------------|-----------------|
| **H0** | Classical keys only; PQC capability assessed | CMVP gap analysis; partition capacity plan; vendor contract amendment |
| **H1** | Hybrid: classical + PQC keys coexist | Dual signing keys; hybrid wrap; parallel partitions optional |
| **H2** | PQC-primary; classical keys deprecated | Rotate KEKs to PQC wrap; disable classical key generation |
| **H3** | PQC-native; classical keys destroyed | Ceremony-verified key destruction; CBOM scan |

KMS migration is not a single cutover event. Meridian's architecture document specified **fourteen-month** payment HSM migration: three months vendor module integration, four months dual-signature production, four months terminal trust propagation, three months classical signing key destruction — aligned to H1→H2, not "flip on module GA day."

> **Architect's Decision**
>
> **Define KMS migration as a phased topology, not a vendor upgrade ticket.** Pattern selection follows workload class, classification boundary, and CDG fan-in — not procurement convenience. A payment HSM blocking node with nine-month terminal lead time requires Pattern A or B with dual-signature H1 regardless of whether cloud KMS already supports ML-KEM for unrelated workloads.

---

## 14.3 Key Lifecycle: Generate, Wrap, Rotate, Destroy

The key lifecycle is the operational contract between crypto engineering, operations, and audit. PQC migration adds steps; it does not replace lifecycle discipline.

### 14.3.1 Generate

**Generation** must occur inside the validated cryptographic module boundary for regulated workloads — software-generated ML-DSA keys exported to an HSM fail FIPS path requirements.

| Key type | Generation location | PQC notes |
|----------|--------------------|-----------|
| Data encryption key (DEK) | Application or KMS | DEK often symmetric; PQC affects wrapping KEK, not DEK algorithm |
| Key encryption key (KEK) | HSM or cloud KMS CMK | ML-KEM or ML-DSA key pairs per policy profile |
| Signing key | HSM partition | ML-DSA-65/87; size affects ceremony quorum media |
| TLS key | Ephemeral; often software | Hybrid TLS combines X25519 + ML-KEM — ephemeral generation path |
| Root CA key | Offline HSM or ceremony | ML-DSA-87 for long-trust anchors (Chapter 13) |

**Ceremony requirements for generation:**

1. Quorum of custodians per M-of-N policy
2. Witnessed randomness verification (where policy mandates)
3. Dual-control physical access to HSM or ceremony room
4. Audit log entry with key handle, algorithm, partition, custodian IDs
5. CBOM row created **before** key use in production — not after audit finding

Meridian's ML-DSA firmware signing key generation required **expanding the ceremony room** — smart card and USB ceremony media could not accommodate ML-DSA-87 key component sizes on legacy laptops. Procurement added ceremony workstation refresh to Wave 0 budget (*illustrative: €180,000*).

### 14.3.2 Wrap

**Wrapping** protects keys at rest and in transit between systems. Envelope encryption pattern: DEK encrypts data; KEK encrypts DEK.

| Wrap construction | HLM phase | Security model |
|-------------------|-----------|----------------|
| RSA-OAEP wrap | H0 | Classical only |
| Hybrid wrap (RSA + ML-KEM) | H1 | OR combiner at wrap layer — either survives |
| ML-KEM wrap | H2/H3 | PQC-native |
| AES-KWP with PQC-derived KEK | H2/H3 | Symmetric wrap; KEK establishment PQC |

GlobalSync's tenant data encryption used **ML-KEM-768 KEKs** in cloud KMS after H2 transition — H1 retained RSA-OAEP wrap for tenants not yet notified per contract clause.

**Wrap migration rule:** Never unwrap production DEKs outside audited tooling. Migration tools that decrypt with classical KEK and re-encrypt with PQC KEK must run in **controlled batch windows** with rollback KEK retained until verification completes.

### 14.3.3 Rotate

**Rotation** limits cryptoperiod exposure and enables algorithm transition. PQC migration often conflates **scheduled rotation** with **algorithm substitution** — treat them as linked but distinct events.

| Rotation trigger | Action | Evidence |
|------------------|--------|----------|
| Cryptoperiod expiry | New key same algorithm | Standard change record |
| Algorithm policy change (H1→H2) | New key new algorithm; re-wrap dependents | Substitution drill artefact (Chapter 10) |
| Compromise suspicion | Emergency rotation; incident record | Forensic preservation |
| Vendor module upgrade | Validate key handles survive upgrade | Pre-production harness |
| Partition migration | Export-wrap-import under dual ceremony | Apex cross-partition pattern |

Meridian rotated payment HSM firmware signing keys on **annual cadence** classically. ML-DSA introduction extended rotation window to **eighteen months** for first PQC cycle — vendor recommendation plus operational caution — documented in risk acceptance with supervisory notification.

**Rotation dependency graph:** CDG `depends_on` edges from applications to KEK handles mean KEK rotation is a **blocking event** for dependents. Chapter 8 blast-radius exercise applies: rotate KEK in staging with full dependent restart before production.

### 14.3.4 Destroy

**Destruction** is the most audit-sensitive lifecycle phase — especially when classical keys must be eliminated for H3 verification.

| Destruction class | Method | Verification |
|-------------------|--------|--------------|
| Logical destroy | HSM `DestroyObject` or KMS schedule | Audit log; key handle invalid |
| Cryptographic erase | Overwrite ceremony media | Witness sign-off |
| Physical destroy | HSM tamper event or media shredding | Certificate of destruction |
| Cloud key | KMS pending deletion window + manual confirm | Cloud audit trail export |

**H3 destroy gate:** CBOM scan confirms zero production references to classical key handles before destroy ceremony. Meridian's destroy checklist required **terminal fleet signature verification** on ML-DSA-only firmware before ECDSA signing key destruction — CDG edge to retail terminals enforced sequencing.

> **Dependency Alert**
>
> **Destroying classical signing keys before dependents verify PQC signatures bricks production.** Northfield's OT programme parallels Meridian's terminal pattern: dual-signature firmware H1 must complete field deployment before classical verification keys are removed from signing HSM partitions. Destroy is the last lifecycle step, not the first migration action.

### 14.3.5 Lifecycle integration with CBOM

Extend Chapter 7 CBOM schema for key custody:

| Field | Example | Purpose |
|-------|---------|---------|
| `key_handle_id` | `hsm-partition-3-fw-sign` | Unique custody reference |
| `key_algorithm` | `ML-DSA-87` | Algorithm binding |
| `hlm_phase` | `H1` | Lifecycle alignment |
| `custody_tier` | `FIPS-L3-HSM` | Validation class |
| `ceremony_id` | `CER-2027-0088` | Link to ceremony record |
| `rotation_due` | `2028-06-01` | Operations calendar |
| `wrap_algorithm` | `ML-KEM-768` | Envelope layer |
| `cdg_blocking_ref` | `BN-MER-HSM-001` | Wave sequencing |

---

## 14.4 HSM Partitioning and Logical Isolation

**HSM partitioning** divides physical appliances into logically isolated domains — separate key material, policies, and administrative roles. PQC migration stress-tests partition design built for smaller classical keys.

### 14.4.1 Partition design principles

| Principle | Rationale |
|-----------|-----------|
| **Separation of duties** | Signing partitions distinct from encryption/wrap partitions |
| **Blast-radius containment** | Compromise of one partition does not expose all keys |
| **Algorithm isolation** | H1 classical and PQC signing keys in separate partitions simplifies rollback |
| **Performance isolation** | High-volume wrap partition separate from low-frequency root ceremonies |
| **Classification isolation** | NSS and unclassified keys never share partition (Apex mandate) |
| **Capacity headroom** | PQC keys consume more storage; plan 40–60% buffer (*illustrative planning factor*) |

### 14.4.2 Partition taxonomy

| Partition class | Typical keys | PQC migration pattern |
|-----------------|-------------|----------------------|
| **Payment / transaction** | PIN encryption, MAC keys, payment signing | Vendor module upgrade; strict PCI + FIPS |
| **Code / firmware signing** | ML-DSA firmware signing; LMS state (Chapter 6) | Dual partition for classical + PQC during H1 |
| **PKI ceremony** | Root and issuing CA keys | ML-DSA-87 generation; offline ceremony |
| **General wrap** | KEKs for application encryption | ML-KEM KEK rotation |
| **Tenant isolation** | Per-tenant CMK equivalents on dedicated HSM | SaaS rare; GlobalSync evaluated, selected cloud KMS |

Meridian's payment HSM hosted **three logical key domains** on two physical partitions (Chapter 7): firmware signing, PIN encryption, and key wrapping shared a physical appliance but **administrative policy slots** prevented cross-domain key export. PQC migration touched only the firmware signing domain initially — PIN and wrap domains remained classical through H1 to reduce blast radius.

### 14.4.3 Partition migration without key exposure

When Pattern B (parallel partition) applies:

1. Provision new partition with PQC-capable module
2. Generate PQC keys in new partition under ceremony
3. Dual-operate: applications sign with both keys during H1 (firmware dual-signature pattern, Chapter 6)
4. Migrate wrap paths: re-encrypt DEKs under new KEK
5. Deprecate classical partition after H2 exit criteria
6. Archive or destroy classical partition keys at H3

**Rollback requirement:** Classical partition remains **read-only operational** until H2 exit — not immediately decommissioned at PQC key generation.

---

## 14.5 FIPS 140-3 Validation and Module Selection

Regulated enterprises and NSS operators require **FIPS 140-3 validated cryptographic modules** — not implementations that merely use approved algorithms in software.

### 14.5.1 Validation concepts

| Term | Meaning | Procurement implication |
|------|---------|------------------------|
| **FIPS 140-3** | Current validation standard for crypto modules | Require FIPS 140-3, not 140-2, for new procurements |
| **CMVP certificate** | NIST/CSE listing of validated module | Demand certificate number and security level |
| **Security Level** | L1 (software) through L4 (tamper-responsive) | Payment HSM typically L3; NSS may require L3+ |
| **Algorithm implementation** | Specific algorithm listed on certificate | "FIPS-validated HSM" insufficient — need ML-DSA on cert |
| **Operational environment** | OS/firmware versions covered by validation | Upgrade outside boundary voids compliance |

### 14.5.2 Module selection workflow

1. Map CBOM key custody rows to required algorithms and security level
2. Download CMVP certificate for candidate module version
3. Verify each required algorithm appears in **Approved Security Functions** list
4. Confirm operational environment matches deployment firmware
5. Record `cmvp_cert_number` and `module_version` on CBOM row
6. Re-verify on any firmware upgrade before production promotion

Meridian's gap analysis in 2025 found payment HSM firmware **FIPS 140-2 validated** with ECDSA only — compliant for classical operations, **non-compliant path** for ML-DSA production signing. Wave 0 contract amendment tied deliverables to **FIPS 140-3 certificate listing ML-DSA-87** — echoing Chapter 4 procurement rubric.

### 14.5.3 Software vs hardware modules

| Module type | Use case | PQC consideration |
|-------------|----------|-------------------|
| Hardware HSM | Payment, root CA, high-value signing | Partition capacity; throughput |
| Cloud HSM (dedicated appliance) | BYOK anchor; regulated cloud | Regional availability; multi-cloud portability |
| Cloud KMS (shared) | Application DEK wrap at scale | Shared tenancy; algorithm inside boundary |
| Software module (L1) | Development, non-regulated | Not for Meridian production paths |

> **Regulatory Lens**
>
> EU DORA and PCI DSS do not name ML-DSA — they require **effective cryptographic controls** and validated implementations where standards mandate. Supervisory reviewers increasingly ask whether institutions can demonstrate **module validation evidence** for production keys, not merely algorithm selection policy. Meridian's examination pack includes CMVP certificate PDFs linked from CBOM `key_handle_id` rows — custody traceability from policy to validated module.

---

## 14.6 Performance with Larger PQC Keys

PQC keys and signatures are larger than classical equivalents (Chapter 4). HSM performance impacts are **measurable and plannable** — not a reason to defer migration, but a reason to size infrastructure before production.

### 14.6.1 Performance dimensions

| Dimension | Classical baseline (illustrative) | PQC impact | Planning action |
|-----------|--------------------------------|------------|-----------------|
| Signing throughput | 10,000 RSA-2048 signs/sec (HSM spec) | ML-DSA-65 may reduce 30–50% on same appliance | Batch window extension; HSM sizing |
| Signature size | ECDSA ~64 bytes | ML-DSA-65 ~3.3 KB | Firmware storage (Chapter 6); audit log storage |
| Key generation time | Sub-second RSA-2048 | ML-DSA-87 generation seconds to minutes | Ceremony schedule lengthening |
| Wrap/unwrap latency | Low ms RSA-OAEP | ML-KEM encapsulation moderate | API latency budget in NFR |
| HSM memory per key | Small ECC keys | ML-DSA keys larger | Partition object count limits |
| Network transfer | Negligible | Larger public keys in ceremonies | Media and bandwidth |

### 14.6.2 Benchmark methodology

Enterprises should require **vendor benchmarks on target firmware** — not datasheet peaks from different algorithm mixes.

**Meridian payment HSM benchmark (illustrative results, lab environment):**

| Operation | ECDSA-P256 | ML-DSA-65 | ML-DSA-87 | Threshold |
|-----------|------------|-----------|-----------|-----------|
| Firmware image sign | 1.2 s | 1.6 s | 2.1 s | <3.0 s (manufacturing line) |
| Signs per minute (sustained) | 480 | 310 | 220 | ≥200 (batch window) |
| Partition key slots used | 12% | 28% | 41% | <70% headroom |

ML-DSA-87 fit within manufacturing line budget; sustained throughput required **staggered signing windows** during dual-signature H1 — classical and PQC signs serialised, not parallel, on single partition.

**Apex NSS firmware dual-sign** increased signing time **18%** on existing HSM (Chapter 11) — within NSS change window. Corporate IT on softer SLAs might have deferred without measurement.

### 14.6.3 Mitigation strategies

| Strategy | When to apply |
|----------|---------------|
| HSM appliance upgrade | Throughput below SLA after benchmark |
| Partition split | Signing contention between workloads |
| Batch signing pipeline | Firmware and code signing |
| Hardware acceleration (vendor-specific) | Ultra-high-volume payment MAC |
| Algorithm parameter tiering | ML-DSA-65 where Category 5 not required |
| Async signing with queue | Non-interactive workloads |

Northfield's OT signing volumes were **low frequency** — performance was not the gating factor; certificate store size was (Chapter 6). Do not apply payment HSM performance playbooks to OT without workload assessment.

---

## 14.7 HSM/KMS Capability Assessment Matrix

Use **Table 14.1** during Wave 0 vendor assessment, contract renewal, and annual custody review. Score each row 0–2: **0** = not met, **1** = roadmap with binding date, **2** = evidenced in production or CMVP.

**Table 14.1 — HSM/KMS Capability Assessment Matrix**

| Capability | Evidence required | Score 0 | Score 1 | Score 2 |
|------------|-------------------|---------|---------|---------|
| **ML-KEM support in FIPS boundary** | CMVP cert or lab demo on target firmware | Not listed | Roadmap + contract date | CMVP listed; production |
| **ML-DSA support in FIPS boundary** | CMVP cert listing parameter set | Not listed | Roadmap + contract date | CMVP listed; production |
| **SLH-DSA / LMS (if required)** | SP 800-208 stateful support | Not supported | Roadmap | CMVP + state management |
| **Hybrid wrap (H1)** | Vendor documentation + test | Not available | Beta | Production validated |
| **Partition capacity for PQC keys** | Object count and storage spec | Unknown | Sized with order-of-magnitude | Benchmark on appliance |
| **Signing throughput at target parameter** | Vendor benchmark letter | Below SLA | Meets SLA in lab | Production measured |
| **Key ceremony tooling** | M-of-N smart card / USB support | Legacy media insufficient | Media refresh ordered | Ceremony completed |
| **KMIP / PKCS#11 PQC extensions** | Integration guide | Not available | Preview SDK | Production SDK |
| **Cloud BYOK import for PQC keys** | Import API documentation | Not supported | Preview | Production |
| **Multi-cloud portability** | Key export policy under customer control | Locked to vendor | Export with ceremony | Standardised export |
| **Dual-signature operation** | Same partition or coordinated partitions | Not supported | Manual workaround | Native support |
| **Audit log integrity** | Tamper-evident logs; SIEM integration | Partial | Available | Contractual SLA |
| **Disaster recovery key restore** | DR test report with PQC keys | Untested | Tested classical only | PQC DR tested |
| **Zeroisation / destroy** | Documented destroy procedure | Manual unclear | Documented | Ceremony-tested |
| **Operational environment match** | Firmware version = CMVP version | Drift detected | Aligned in staging | Aligned in production |

**Minimum passing score:** For regulated payment HSM, require score **2** on ML-DSA, FIPS boundary, throughput, ceremony tooling, and operational environment rows before production H1. Score **1** acceptable on SLH-DSA only if policy mandates contingency.

Meridian embedded Table 14.1 in HSM renewal RFP — vendor responses below threshold rejected without executive risk acceptance. GlobalSync used a **cloud-weighted variant** emphasising BYOK and regional FIPS endpoints.

### 14.7.1 Assessment process

1. **Inventory** — export CBOM custody rows; group by HSM/KMS platform
2. **Gap scan** — score matrix per platform against target HLM phase
3. **Vendor engagement** — binding delivery dates for score-1 rows
4. **Lab validation** — benchmark on target firmware before contract close
5. **CDG update** — attach assessment artefact to blocking node
6. **Annual re-score** — CMVP and firmware drift review

---

## 14.8 Apex: HSM Partition Strategy for Classified and Unclassified Zones

Apex Defense Technologies operates **National Security Systems** alongside corporate IT. Key custody architecture must enforce **classification boundaries** while enabling controlled interfaces — the CDG `G_apex_nss` component from Chapter 8.

### 14.8.1 Dual-zone partition model

| Zone | Partition policy | Algorithms | Administrative access |
|------|------------------|------------|----------------------|
| **NSS classified** | Dedicated HSM appliances; no key export to corporate | CNSA 2.0: ML-KEM-1024, ML-DSA-87 | Cleared custodians; SCIF ceremony |
| **NSS unclassified** | Separate appliances; network segmented | CNSA floors; same parameter minimums | Cleared + corporate crypto ops |
| **Corporate IT** | Enterprise HSM pool; cloud KMS permitted | ML-KEM-768 / ML-DSA-65 default | Standard M-of-N |
| **Cross-domain gateway** | No key storage; protocol translation only | Profile mapping (Chapter 10) | Interface accreditation |

**Priya Nair's partition rule:** Keys never cross zones via export — **re-encryption and re-signing at gateway** with zone-local keys. Attempting to clone ML-DSA signing keys from classified to corporate partitions would violate accreditation; Apex rejected vendor proposals offering "key synchronisation" across zones.

### 14.8.2 Ceremony differences

| Ceremony element | Classified NSS | Corporate IT |
|------------------|----------------|--------------|
| Location | SCIF or approved facility | Standard datacentre ceremony room |
| Custodian clearance | Per programme | Corporate crypto officers |
| Media | Controlled government-furnished equipment | Enterprise ceremony laptops |
| Witness | Government security representative | Internal audit optional |
| Documentation | Authorisation package update | DORA/change record |
| Duration | Extended — ML-DSA-87 generation + accreditation review | Standard with ML-DSA media refresh |

Apex's first ML-DSA-87 **classified root ceremony** required **four hours** versus ninety minutes for prior ECDSA-P384 roots — schedule compression was unavailable; programme plan adjusted Wave 0 milestones accordingly.

### 14.8.3 STIG and NSM intersection

NSS HSM configurations follow **STIG hardening** and NSA Cryptographic Modernisation guidance. PQC module enablement requires:

1. STIG-compliant firmware version
2. CMVP certificate matching STIG-approved module list
3. Accreditor review of partition policy changes
4. Updated authorisation package evidence

Corporate HSM upgrades proceed faster — **do not assume NSS partition migration tracks corporate timeline.** Apex steering committee reports separate RAG status per zone.

> **Architect's Decision**
>
> **Classified and unclassified NSS zones require physically or logically separate HSM partitions with independent ceremonies — not role-based access on one partition.** Role separation on a shared partition fails accreditation when classification levels differ. Apex uses appliance-level separation for classified; logical partitions only within the same classification level.

### 14.8.4 Interface gateway key model

```
[Corporate application]          [Cross-domain gateway]          [NSS application]
        |                                  |                              |
        |-- TLS / API (ML-KEM-768) ------>|                              |
        |                                  |-- TLS (ML-KEM-1024) -------->|
        |                                  |                              |
   Corp signing key                   No stored keys                 NSS signing key
   (ML-DSA-65)                       Translate profiles              (ML-DSA-87)
```

Gateway validates, re-encrypts, or re-signs — it does not hold long-lived private keys spanning zones.

---

## 14.9 Meridian: Payment HSM and ML-DSA Ceremony Adaptation

Meridian's payment HSM blocking node is the book's recurring **custody case study** — connecting firmware signing (Chapter 6), PKI trust (Chapter 13), and Wave 0 sequencing (Chapter 9).

### 14.9.1 Pre-migration state

| Attribute | Value |
|-----------|-------|
| HSM model | Thales payShield-class (*vendor anonymised*) |
| Validation | FIPS 140-2 Level 3 (classical algorithms) |
| Signing key use | Payment terminal firmware images |
| Ceremony | 3-of-5 custodians; annual rotation |
| CDG fan-in | Manufacturing CA, retail terminal fleet, partner attestation |
| Blocking reason | ML-DSA-87 module not in FIPS 140-3 boundary |

### 14.9.2 Ceremony adaptation for ML-DSA

Meridian's crypto operations team revised ceremony procedures across **seven workstreams**:

1. **Media refresh** — ceremony laptops and smart card readers validated for ML-DSA key component handling
2. **Quorum training** — custodians practised extended generation window; no shift changes mid-ceremony
3. **Dual-signature workflow** — H1 ceremonies generate PQC key while classical key remains operational
4. **Audit log expansion** — log storage sized for 3.3 KB+ signatures per firmware sign event
5. **Manufacturing integration** — CI pipeline calls HSM sign API twice per image (ECDSA + ML-DSA)
6. **Terminal trust propagation** — trust store update campaign before classical key destroy
7. **Supervisory notification** — DORA change record with ceremony minutes attached

**Ceremony checklist excerpt (ML-DSA firmware signing key generation):**

- [ ] CMVP certificate confirms ML-DSA-87 on target firmware build
- [ ] Ceremony room physical access log complete
- [ ] Custodian quorum 3-of-5 present; identities verified
- [ ] Randomness health check passed per HSM policy
- [ ] Key handle recorded in CBOM `key_handle_id`
- [ ] Test sign on non-production firmware image verified on lab terminal
- [ ] Manufacturing CA issued ML-DSA cert chained to overlap root (Chapter 13)
- [ ] CDG blocking node `BN-MER-HSM-001` status updated to `H1-active`

### 14.9.3 H1 dual-signature production

Meridian's firmware signing pipeline during H1:

```
[Firmware build] --> [Hash image]
                         |
            +------------+------------+
            v                         v
    [HSM sign ECDSA]           [HSM sign ML-DSA-87]
            |                         |
            +------------+------------+
                         v
              [Dual-signed firmware package]
                         |
                         v
              [Terminal fleet verification]
```

Terminals refreshed after 2028 accepted ML-DSA-only; legacy terminals verified ECDSA signature until decommission. CDG edge attribute `signature_types_accepted` tracked fleet capability.

### 14.9.4 Vendor dependency management

Meridian's contract amendment (Chapter 5) linked **€2.4 million** remaining contract value to ML-DSA module delivery — commercial leverage Elena's team applied after CDG made blocking status visible to the board. Thomas Bergström's supervisory dialogue cited **vendor correspondence** as timeline evidence, not engineering optimism.

> **Migration Moment**
>
> *"We'll run the ML-DSA ceremony the same day the vendor ships firmware."*
>
> Ceremonies require trained custodians, refreshed media, manufacturing CA coordination, and lab terminal verification — none of which compress to zero. Meridian scheduled **dress rehearsal** on vendor beta firmware sixty days before production module GA. Dress rehearsal failed twice on audit log formatting; production ceremony succeeded on first attempt because rehearsal absorbed learning.

---

## 14.10 Multi-Cloud KMS Patterns

GlobalSync Logistics operates across **AWS, Azure, and GCP** — not as endorsement of any provider, but as architectural reality for multi-cloud enterprises. Patterns below describe **categories** of capability; verify current algorithm support and FIPS status in target regions before design lock.

### 14.10.1 Pattern comparison

| Pattern | Description | PQC migration consideration |
|---------|-------------|----------------------------|
| **Native cloud KMS** | Provider-managed CMKs; envelope encryption | Confirm ML-KEM/ML-DSA inside FIPS boundary per region |
| **Cloud HSM-backed KMS** | CMKs backed by dedicated HSM appliance | Stronger custody; higher cost; BYOK anchor |
| **Multi-cloud key federation** | Each cloud holds zone-local CMKs; app-level identity | No single key spans clouds — by design |
| **Centralised enterprise KMS** | On-prem HSM as root of trust; cloud holds derived keys | Ceremony-heavy; strong for regulated |
| **Tenant-scoped CMK** | Per-tenant keys in SaaS | Contractual BYOK; rotation notification |

### 14.10.2 AWS patterns (category)

| Capability | Typical use | Migration note |
|------------|-------------|----------------|
| KMS CMK | Application data encryption | Check FIPS endpoint + key spec for PQC when available |
| CloudHSM cluster | BYOK root of trust | PKCS#11 integration; partition design mirrors on-prem |
| KMS multi-Region keys | DR without manual re-wrap | DR drill must include PQC CMK failover |
| IAM + key policy | Access control | Policy versioned with algorithm change |

GlobalSync used **FIPS endpoints** in production regions; non-FIPS endpoints disabled by organisation policy.

### 14.10.3 Azure patterns (category)

| Capability | Typical use | Migration note |
|------------|-------------|----------------|
| Key Vault keys | Wrap secrets; signing | Managed HSM pool for higher assurance |
| Managed HSM | FIPS 140-3 Level 3 | BYOK import ceremonies |
| Key Vault multi-tenant | SaaS isolation | Tenant CMK mapping in profile service |

### 14.10.4 GCP patterns (category)

| Capability | Typical use | Migration note |
|------------|-------------|----------------|
| Cloud KMS | Symmetric and asymmetric keys | Key version rotation for algorithm migration |
| Cloud HSM | Dedicated HSM backing | Regional availability planning |
| EKM (External Key Manager) | HYOK — keys never leave enterprise HSM | Strongest customer custody; latency trade-off |

### 14.10.5 Multi-cloud architecture (GlobalSync)

```
                    ┌─────────────────────────────┐
                    │ Enterprise policy service    │
                    │ (profile → algorithm → KMS)  │
                    └──────────────┬──────────────┘
                                   │
         ┌─────────────────────────┼─────────────────────────┐
         v                         v                         v
  ┌─────────────┐          ┌─────────────┐          ┌─────────────┐
  │ AWS region  │          │ Azure region│          │ GCP region  │
  │ CMK per env │          │ Key Vault   │          │ Cloud KMS   │
  └─────────────┘          └─────────────┘          └─────────────┘
         │                         │                         │
         └─────────────────────────┴─────────────────────────┘
                                   │
                    No cross-cloud private key material
                    Identity federation at application layer
```

**Marcus Chen's rule:** Multi-cloud means **multiplied assessment** — Table 14.1 scored per cloud per region. A score-2 on AWS us-east-1 does not imply score-2 on Azure EU-West without separate evidence.

---

## 14.11 Shared Responsibility, BYOK, and HYOK

Cloud key management distributes obligations between provider and customer. PQC migration adds algorithm verification to an already misunderstood model.

### 14.11.1 Shared responsibility matrix

| Responsibility | Cloud provider | Customer |
|----------------|----------------|----------|
| Physical HSM security | Yes | No |
| Hypervisor / platform | Yes | No |
| KMS API availability | Yes | Monitor |
| Algorithm selection policy | No | Yes |
| Key rotation schedule | Configurable | Yes — must configure |
| FIPS endpoint usage | Offers | Must enable |
| CMVP evidence for module | Provides | Must archive |
| Application envelope encryption | No | Yes |
| IAM / key policies | Offers | Yes — must govern |
| PQC migration timeline | Roadmap communication | Programme execution |

**Failure mode:** Customer assumes provider handles PQC migration automatically. Provider enables new algorithm in region; customer never rotates CMKs — applications remain classical-wrapped indefinitely.

### 14.11.2 BYOK (Bring Your Own Key)

**BYOK** — customer generates key in enterprise HSM and imports into cloud KMS/HSM.

| Advantage | Risk |
|-----------|------|
| Ceremony control remains on-prem | Import format compatibility with PQC keys |
| Accreditor-familiar custody chain | Cloud provider sees key material at import |
| Portable across cloud accounts | Binding to provider import mechanisms |

Meridian evaluated BYOK for **disaster recovery CMKs** — imported classical keys successfully; ML-DSA BYOK import awaited vendor format specification. Architecture reserved import slots without production dependency.

### 14.11.3 HYOK (Hold Your Own Key)

**HYOK** — keys never leave customer-controlled HSM; cloud holds only key reference or EKM integration.

| Advantage | Risk |
|-----------|------|
| Maximum custody | Latency; availability coupling to on-prem HSM |
| Regulatory preference for some EU institutions | Multi-region DR complexity |
| Clear audit narrative | Operational burden |

GlobalSync offered **HYOK tier** for three regulated tenants — external key manager integration added **8–12 ms** p99 wrap latency (*illustrative production measurement*); tenants accepted in contract.

### 14.11.4 Selection guidance

| Workload | Recommended custody | Rationale |
|----------|---------------------|-----------|
| SaaS tenant encryption at scale | Native KMS + tenant CMK | Operational efficiency |
| Regulated payment wrap | Cloud HSM or on-prem HSM | FIPS evidence |
| Root CA / code signing | On-prem HSM; air-gap option | Ceremony control |
| DR without provider lock-in | BYOK with documented export | Portability |
| Maximum regulatory custody | HYOK / EKM | Keys never in provider boundary |

> **Architect's Decision**
>
> **BYOK and HYOK are custody architectures, not security badges.** BYOK without ceremony discipline exports the same weak practices to the cloud. HYOK without DR testing creates availability incidents. Select based on regulatory narrative, latency budget, and operational capacity — then score the implementation with Table 14.1.

---

## 14.12 CNSA Parameter Profiles for NSS

**Commercial National Security Algorithm Suite 2.0 (CNSA 2.0)** mandates Category 5 parameter sets for NSS key establishment and signing: **ML-KEM-1024** and **ML-DSA-87**, with SLH-DSA for diversity where required (Chapter 4).

### 14.12.1 NSS key management requirements

| Function | CNSA 2.0 algorithm | Custody typical |
|----------|-------------------|-----------------|
| Key establishment | ML-KEM-1024 | NSS HSM partition; classified zone |
| Digital signature | ML-DSA-87 | Signing partition; ceremony-controlled |
| Diversity signature | SLH-DSA (selected suites) | Separate partition recommended |
| Firmware signing | ML-DSA-87 and/or LMS (SP 800-208) | Aligned with Chapter 6 |
| Key wrap | ML-KEM-1024 or AES-KWP with PQC-derived keys | No RSA-OAEP at H3 |

### 14.12.2 Dual-track enterprise (Apex)

Apex maps workloads:

| Track | Key establishment | Signing | HSM zone |
|-------|-------------------|---------|----------|
| NSS programmes | ML-KEM-1024 | ML-DSA-87 | Classified / NSS unclassified |
| Corporate IT | ML-KEM-768 default | ML-DSA-65 default | Corporate pool |
| Flow-down contracts | Elevate to CNSA per contract | Per customer questionnaire | May require NSS partition |

**Interface rule:** Corporate IT services calling NSS APIs use **gateway profile translation** — not shared private keys. CDG edges at interface document `negotiation_profile` attributes (Chapter 10).

### 14.12.3 CNSA timeline alignment

CNSA 2.0 milestones (Chapter 5) drive NSS key ceremony scheduling:

- New NSS acquisitions: PQC algorithms required on accelerated timeline
- Firmware signing: ML-DSA-87 / LMS by 2030 milestone
- Key destruction: classical NSS keys removed per programme authorisation — not ad hoc

Apex's corporate IT cannot delay NSS partition migration because corporate cloud KMS lacks ML-KEM-1024 — **separate programme tracks** with separate funding (Chapter 1 mandate collision resolution).

---

## 14.13 GlobalSync: Tenant-Scoped KMS and Crypto Service Integration

GlobalSync's platform encrypts tenant data at rest using **profile-driven KMS selection** — agility architecture from Chapter 10 applied to custody.

### 14.13.1 Tenant encryption architecture

| Component | Implementation |
|-----------|----------------|
| Policy profile | `gs-tenant-wrap-v2` → ML-KEM-768 KEK |
| Provider | Enterprise crypto service abstracts AWS/Azure KMS |
| Tenant override | Contract clause maps to `tenant_cmek_arn` |
| HLM phase | Per-tenant `hlm_phase` in config — platform H2 does not force tenant H2 without notice |
| Rotation | Automated CMK rotation + tenant notification API |

### 14.13.2 Migration execution

1. Platform reached H2 for default tenant profile — ML-KEM wrap mandatory for new tenants
2. Existing tenants received **90-day notification** per contract (substitution window, Chapter 10)
3. Re-wrap batch jobs ran per region with canary tenants first
4. CBOM rows updated per tenant `asset_id` — steering tracked percentage re-wrapped

**Lesson:** Multi-tenant KMS migration is a **customer communication programme** as much as a technical rotation — legal reviewed notification templates before engineering enabled batch jobs.

---

## 14.14 Integration with PKI and Firmware Signing

Key management does not operate in isolation. Three integration surfaces dominate enterprise migration.

### 14.14.1 PKI integration (Chapter 13)

| PKI event | KMS/HSM impact |
|-----------|----------------|
| Root CA ML-DSA-87 ceremony | Offline HSM partition; root key generation |
| Issuing CA migration | New signing key in CA partition |
| Certificate profile change | Larger certs — HSM sign buffer check |
| CRL/OCSP signing | OCSP responder HSM key rotation |
| Automated issuance (ACME, EST) | HSM throughput for high-volume ML-DSA certs |

Meridian's manufacturing CA and payment HSM signing key are **distinct CDG nodes** but **sequenced ceremonies** — root overlap strategy (Chapter 13) must complete before terminal trust stores accept ML-DSA firmware signatures.

### 14.14.2 Firmware signing integration (Chapter 6)

| Scheme | HSM requirement |
|--------|-----------------|
| ML-DSA dual-signature H1 | Two sign keys; audit log dual entries |
| LMS/XMSS stateful | State store in HSM or dedicated appliance (Chapter 6) |
| Air-gapped OT signing | Physical ceremony; state media transfer |

Northfield's compressor vendor used **offline HSM** for LMS state — separate from Meridian's payment path but same assessment matrix.

### 14.14.3 TLS termination

TLS ephemeral keys are typically **not** long-lived HSM keys — but **TLS server authentication certificates** are. PKI migration (Chapter 13) and KMS migration (this chapter) coordinate through CDG: CA signing key in HSM partition → issues server certs → load balancers terminate TLS.

---

## 14.15 CDG Blocking Nodes and Wave Sequencing

Part III established CDG methodology. Key custody nodes are among the highest fan-in blockers.

### 14.15.1 Common KMS/HSM blocking patterns

| Blocking node type | Example | Fan-in characteristic |
|--------------------|---------|----------------------|
| Payment HSM firmware signer | Meridian | Terminals, manufacturing, partners |
| Enterprise root CA HSM | GlobalSync | All issued certificates |
| Cloud KMS tenant master key | GlobalSync SaaS | Per-tenant data stores |
| NSS classified signing partition | Apex | Weapon system firmware |
| OT air-gapped signer | Northfield | Field device trust |

### 14.15.2 Sequencing rules

1. **Resolve blocking custody nodes in Wave 0** before dependent PKI or firmware waves
2. **Dual-signature H1** before classical key destroy — CDG `depends_on` edges to verifiers
3. **Vendor module validation** before ceremony — not parallel unless risk acceptance
4. **Downstream cascade** — when HSM blocking node reaches H3, dependents accelerate (Chapter 9)

Meridian Wave 0 exit required: manufacturing root dual-trust operational; payment HSM dual-signature in production; card-scheme policy memorandum — **three gates**, not single module install.

### 14.15.3 Blast-radius exercise (custody variant)

For each HSM blocking node:

1. List all `signs`, `wraps`, and `trusts` inbound edges
2. Simulate key rotation outage window
3. Measure maximum concurrent dependent failure
4. Document rollback key availability
5. Attach results to blocking node `evidence_ref`

---

## 14.16 Confidential Computing and Key Custody

**Confidential computing** (TEE-based execution: AMD SEV, Intel TDX, ARM CCA) extends key custody into **runtime attestation** — verifying that code processing decrypted data runs inside an approved enclave.

PQC migration intersection points:

| Topic | Relevance |
|-------|-----------|
| Enclave attestation certificates | Will migrate to ML-DSA chains (Chapter 13) |
| Sealed storage keys | KEK rotation must include enclave re-seal |
| Key provisioning into TEE | May use KMS wrap path — same ML-KEM assessment |
| Multi-party compute | Emerging; not production mainstream for most enterprises 2027 |

This handbook treats confidential computing as **adjacent architecture** — not a replacement for HSM root custody. Apex evaluates TEE for **edge NSS workloads**; Meridian defers pending regulatory guidance. Enterprises with active confidential computing programmes should extend Table 14.1 with **attestation chain algorithm** rows and include enclave KEK in rotation drills.

---

## 14.17 Ceremony Governance, DR, and Assurance

### 14.17.1 Ceremony governance

| Control | Purpose |
|---------|---------|
| M-of-N quorum | Prevent unilateral key generation |
| Dual control | Physical HSM access |
| Witness / audit | Non-repudiation of ceremony |
| Video recording | Disputed ceremony investigation (policy permitting) |
| Checklist versioning | Change control for procedure updates |
| Post-ceremony verification | Test sign/encrypt before production flag |

### 14.17.2 Disaster recovery

DR for HSM keys requires **proven restore**, not backup tape optimism:

| DR scenario | Test requirement |
|-------------|------------------|
| Primary HSM failure | Secondary accepts key handles or wrapped backup |
| Site loss | Geographic replica or ceremony re-creation plan |
| PQC key restore | Restore includes ML-DSA/ML-KEM material — not classical-only drill |
| Stateful signing (LMS) | Index monotonicity after failover (Chapter 6) |

Meridian quarterly DR tested **classical path** for years. 2027 DR added **PQC partition failover** — discovered secondary appliance firmware lag; remediation entered Wave 0 risk register.

### 14.17.3 Assurance integration

| Assurance activity | Custody evidence |
|--------------------|------------------|
| Internal audit | Sample ceremony logs; CMVP cert currency |
| Penetration test | KMS IAM misconfiguration; no key extraction |
| Regulatory examination | DORA change records with ceremony minutes |
| SOC 2 / ISO 27001 | Key management control mapping |

---

## 14.18 Northfield: OT Custody Realism

Northfield Energy Systems illustrates **custody patterns outside cloud and payment HSM** — relevant for OT readers.

| Asset | Custody model | PQC path |
|-------|---------------|----------|
| WAN VPN concentrator | Software keys in appliance; config-driven | Enterprise-owned; Tier 3 agility |
| OT gateway | Firmware-sealed keys | Tier 2; firmware release cycle |
| Vendor air-gapped signer | Vendor-controlled HSM | Contractual LMS/ML-DSA roadmap |
| Safety PLC | Fixed key storage | Long-tail Wave 4 |

James Whitfield's team **does not conflate** enterprise VPN key migration with PLC key migration — separate CDG nodes, separate wave assignments. Applying Table 14.1 to vendor air-gapped signers is a **procurement action**, not an internal ceremony project.

---

## 14.19 Cross-Reference Map

| Topic | See |
|-------|-----|
| Algorithm parameters and sizes | Chapter 4 §4.3–4.5 |
| HLM phase policy | Chapter 5 §5.6–5.9 |
| Firmware signing, LMS state | Chapter 6 |
| CBOM custody attributes | Chapter 7 §7.4 |
| CDG blocking nodes, blast radius | Chapter 8 §8.3–8.5 |
| Wave 0 HSM sequencing | Chapter 9 §9.4 |
| Crypto-agility NFRs, provider abstraction | Chapter 10 |
| Hybrid wrap, dual signing patterns | Chapter 11 |
| TLS and protocol key establishment | Chapter 12 |
| PKI ceremonies, root overlap | Chapter 13 |
| Programme office operating rhythm | Chapter 15 |
| Sector-specific custody (healthcare, energy) | Chapters 19–21 |

---

## 14.20 Apply in Your Organisation

1. **Inventory all key custody platforms** — HSM partitions, cloud KMS accounts, vendor-held keys — as CBOM rows with `key_handle_id`.
2. **Score each platform with Table 14.1** — reject "PQC-ready" without CMVP evidence for in-scope algorithms.
3. **Define KMS migration topology** (Pattern A/B/C) per workload class — align to HLM phase and CDG blocking nodes.
4. **Document full key lifecycle** — generate, wrap, rotate, destroy — with PQC-specific ceremony adaptations.
5. **Benchmark signing and wrap latency** on target firmware before production H1 — size HSM partitions for PQC object storage.
6. **Plan dual-signature H1** for firmware and code signing before classical key destruction — sequence CDG dependents.
7. **Separate classified and unclassified HSM zones** (Apex pattern) — no key export across classification boundaries.
8. **Adapt payment or high-value ceremonies** — media refresh, extended quorum windows, dress rehearsal on beta firmware.
9. **Score multi-cloud KMS per region** — shared responsibility matrix signed by security and platform engineering.
10. **Evaluate BYOK/HYOK** against regulatory narrative, latency, and DR capacity — not marketing preference.
11. **Apply CNSA ML-KEM-1024 / ML-DSA-87** to NSS workloads with separate programme track from corporate IT.
12. **Extend DR drills** to PQC key restore and LMS state continuity (Chapter 6).
13. **Link ceremony logs and CMVP certs** to DORA or accreditation evidence packages.
14. **Update CDG blocking nodes** with assessment artefacts and Wave 0 exit criteria before declaring architecture complete.

---

## 14.21 Chapter Summary

- **Key management governs migration velocity** — algorithm policy is necessary but insufficient without validated custody paths.
- **KMS migration architecture** spans policy, custody, wrapping, integration, governance, and evidence — typically Pattern A (in-place), B (parallel partition), or C (cloud KMS) per workload.
- **Key lifecycle phases** — generate, wrap, rotate, destroy — each gain PQC-specific steps; destroy is last, not first.
- **HSM partitioning** contains blast radius, separates algorithms during H1, and enforces classification boundaries for NSS.
- **FIPS 140-3 validation** requires CMVP certificate verification per algorithm — not generic vendor claims.
- **PQC performance** affects signing throughput, partition capacity, and ceremony duration — benchmark before approval.
- **Table 14.1 capability matrix** is the Wave 0 procurement and annual review artefact for HSM/KMS platforms.
- **Apex dual-zone partition strategy** separates classified NSS, unclassified NSS, and corporate IT with gateway translation — never key export across zones.
- **Meridian payment HSM** demonstrates ML-DSA ceremony adaptation, dual-signature H1, and vendor contract leverage tied to CDG blocking status.
- **Multi-cloud KMS patterns** (AWS, Azure, GCP categories) require per-region assessment — multi-cloud multiplies evidence work.
- **BYOK/HYOK and shared responsibility** clarify customer obligations — providers do not rotate customer keys by default.
- **CNSA ML-KEM-1024 and ML-DSA-87** apply to NSS key establishment and signing with accelerated timelines distinct from corporate IT.
- **PKI (Chapter 13) and firmware signing (Chapter 6)** integrate with HSM ceremonies — CDG sequencing prevents bricking dependents.
- **Confidential computing** extends custody to runtime attestation — adjacent to, not replacement for, HSM roots.

**Closing note:** Hybrid TLS success in the laboratory does not imply key management readiness. The enterprises in this book that avoided production stalls treated HSM and KMS migration as **Wave 0 architecture** — assessed with the same rigour as protocol configuration — because keys are where policy becomes physical.

**Next:** Chapter 15 shifts from architecture to programme execution — chartering, procurement operations, and steering committee rhythm that sustains migration beyond initial wave approval.

---

*Chapter 14 — References*

- Amazon Web Services. (2024–2026). *AWS Key Management Service* and *AWS CloudHSM* documentation (FIPS endpoints, BYOK). https://docs.aws.amazon.com/kms/
- Google Cloud. (2024–2026). *Cloud Key Management* and *Cloud External Key Manager* documentation. https://cloud.google.com/kms/docs
- Microsoft. (2024–2026). *Azure Key Vault* and *Azure Managed HSM* documentation. https://learn.microsoft.com/azure/key-vault/
- National Institute of Standards and Technology. (2019). FIPS 140-3: Security Requirements for Cryptographic Modules. https://doi.org/10.6028/NIST.FIPS.140-3
- National Institute of Standards and Technology. (2024). FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard. https://doi.org/10.6028/NIST.FIPS.203
- National Institute of Standards and Technology. (2024). FIPS 204: Module-Lattice-Based Digital Signature Standard. https://doi.org/10.6028/NIST.FIPS.204
- National Institute of Standards and Technology. (2020). NIST SP 800-208: Recommendation for Stateful Hash-Based Signature Schemes. https://doi.org/10.6028/NIST.SP.800-208
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- National Security Agency. (2022–2023). *Commercial National Security Algorithm Suite 2.0*. Cybersecurity Advisories.
- PCI Security Standards Council. (2022). *PCI HSM* and payment cryptography guidance. https://www.pcisecuritystandards.org/
- OASIS. (2024). *Key Management Interoperability Protocol (KMIP)* specification. https://www.oasis-open.org/committees/kmip/
- Confidential Computing Consortium. (2024). *Technical Whitepaper: Confidential Computing*. https://confidentialcomputing.io/
- CycloneDX. (2024). *Authoritative Guide to CBOM*. OWASP Foundation.
- Merkle, R. C. (1989). A certified digital signature. *CRYPTO '89*. (Foundational hash-signature context for stateful schemes.)

---

*End of Part IV. Proceed to Part V: Running the Migration Programme.*
