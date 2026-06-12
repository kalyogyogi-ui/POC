# Appendix A
# CBOM and CDG Templates
## CycloneDX-Aligned Programme Artefacts

---

This appendix provides **copy-ready templates** for the Cryptographic Bill of Materials (CBOM) and Cryptographic Dependency Graph (CDG) introduced in Chapters 7–8. Templates align with CycloneDX cryptographic extensions and programme minimum attributes from Chapter 7 §7.10. Adapt field names to your GRC platform, CMDB, or graph database — preserve semantic meaning, not literal JSON keys.

**Usage:** Programme office owns template version control. Engineering tools consume CycloneDX exports; risk and wave planning consume normalised attributes and CDG blocking flags.

---

## A.1 CBOM Programme Minimum Schema

### A.1.1 Core attribute table

| Attribute | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `asset_id` | string | Yes | Stable enterprise identifier | `mer-cbom-2026-01482` |
| `algorithm_name` | string | Yes | FIPS-normalised algorithm ID | `ML-KEM-768`, `RSA-2048` |
| `quantum_vulnerable` | boolean | Yes | Shor-vulnerable public-key or symmetric-only where policy flags | `true` |
| `asset_type` | enum | Yes | Discovery category | `tls_endpoint`, `hsm_partition`, `firmware_signer` |
| `owner_team` | string | Yes | Accountable engineering or operations team | `payments-platform` |
| `data_classification` | enum | Yes | Enterprise classification | `restricted`, `internal`, `public` |
| `confidentiality_horizon_years` | integer | Conditional | Required for high-value / long-retention assets | `15` |
| `third_party_flag` | boolean | Yes | Cryptography managed outside enterprise boundary | `true` |
| `confidence` | enum | Yes | `verified`, `inferred`, `unknown` | `verified` |
| `hlm_phase` | enum | Conditional | If hybrid deployed: `H1`, `H2`, `H3` | `H1` |
| `h2_trigger_type` | enum | Conditional | Chapter 5 sunset trigger type | `ecosystem_threshold` |
| `h2_trigger_value` | string | Conditional | Trigger parameter | `>90% client ML-KEM` |
| `validation_module_id` | string | Conditional | CMVP certificate / module reference | `CMVP #4521` |
| `firmware_signing_scheme` | enum | OT/firmware | `ecdsa`, `lms`, `xmss`, `hybrid_h1` | `lms` |
| `last_verified_date` | date | Yes | ISO 8601 | `2026-09-15` |
| `scope_zone` | string | Recommended | Programme zone tag for maturity reporting | `cde_payment`, `ot_field`, `nss_enclave` |
| `wave_id` | string | Recommended | TRADE wave assignment | `W1` |
| `cdg_node_refs` | array | Recommended | Linked CDG node IDs | `["node-partner-mtls-v3"]` |

### A.1.2 OT extension attributes (Chapter 7)

| Attribute | Type | Required (OT) | Description |
|-----------|------|---------------|-------------|
| `device_class` | enum | Yes | `plc`, `rtu`, `gateway`, `historian`, `hmi` |
| `site_id` | string | Yes | Physical or logical site | `nf-gulf-coast-07` |
| `maintenance_window` | string | Yes | Next approved change window | `2027-Q3-harvest-hold` |
| `cert_store_bytes` | integer | Recommended | Certificate store capacity constraint | `8192` |

### A.1.3 Third-party and tenant attributes (Chapters 16–17, 21)

| Attribute | Type | Description |
|-----------|------|-------------|
| `provider_contract_id` | string | Procurement contract reference |
| `custody_model` | enum | `platform`, `tenant_byok`, `tenant_hyok`, `vendor_managed` |
| `tenant_profile_id` | string | SaaS tenant crypto profile (if applicable) |
| `attestation_date` | date | Supplier CBOM attestation freshness |
| `hlm_phase_vendor_committed` | enum | Vendor roadmap HLM commitment |

---

## A.2 CycloneDX CBOM Export Example (Illustrative)

The following JSON fragment illustrates programme minimum fields embedded in a CycloneDX 1.6+ cryptographic component entry. **Do not store private keys** in CBOM exports.

```json
{
  "bomFormat": "CycloneDX",
  "specVersion": "1.6",
  "version": 1,
  "metadata": {
    "component": {
      "name": "meridian-payment-hsm-partition-2",
      "type": "cryptographic-asset"
    },
    "properties": [
      { "name": "cbom:programme_id", "value": "mer-pqc-2026" },
      { "name": "cbom:baseline_version", "value": "2026-Q3-certified" }
    ]
  },
  "components": [
    {
      "type": "cryptographic-asset",
      "name": "payment-auth-signing-partition",
      "cryptoProperties": {
        "assetType": "related-crypto-material",
        "algorithmProperties": {
          "primitive": "signature",
          "parameterSetIdentifier": "ML-DSA-65",
          "executionEnvironment": "hsm",
          "implementationPlatform": "vendor-hsm-firmware-4.2"
        }
      },
      "properties": [
        { "name": "asset_id", "value": "mer-cbom-2026-00891" },
        { "name": "quantum_vulnerable", "value": "false" },
        { "name": "owner_team", "value": "payments-crypto" },
        { "name": "data_classification", "value": "restricted" },
        { "name": "third_party_flag", "value": "true" },
        { "name": "confidence", "value": "verified" },
        { "name": "hlm_phase", "value": "H1" },
        { "name": "validation_module_id", "value": "CMVP-4521" },
        { "name": "scope_zone", "value": "cde_payment" },
        { "name": "wave_id", "value": "W0" },
        { "name": "last_verified_date", "value": "2026-11-01" },
        { "name": "cdg_node_refs", "value": "node-payment-hsm-sign" }
      ]
    }
  ]
}
```

---

## A.3 CBOM Quality Scorecard Template

Programme office publishes weekly quality metrics (Chapter 15 §15.7).

| Metric | Target | Formula / source | Action if below target |
|--------|--------|------------------|------------------------|
| Coverage (% in-scope systems with ≥1 row) | ≥ 95% | Systems with CBOM / systems in scope | Discovery sprint |
| Verified confidence % | ≥ 70% | Rows `confidence=verified` / total | Survey tranche |
| Unknown algorithm % | ≤ 5% | Rows `algorithm_name=unknown` / total | Owner escalation |
| Stale rows (>90 days) | ≤ 10% | `last_verified_date` threshold | Custodian review |
| Third-party attestation current | ≥ 85% critical vendors | Chapter 16 checklist | Procurement escalation |
| HLM metadata completeness (hybrids) | 100% | Hybrids without `hlm_phase` | CAB block |
| Wave linkage | 100% Wave 0–2 rows | Missing `wave_id` | Programme office |

**Baseline certification ceremony (quarterly):** CBOM custodian signs attestation that metrics meet targets or documents compensating plan with steering committee approval.

---

## A.4 CDG Node and Edge Schema

### A.4.1 Node record template

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `node_id` | string | Yes | Stable graph identifier | `node-partner-mtls-v3` |
| `node_type` | enum | Yes | `key`, `certificate`, `algorithm`, `protocol`, `trust_anchor`, `hsm`, `firmware`, `policy` |
| `label` | string | Yes | Human-readable name | Partner mTLS issuance policy |
| `cbom_asset_refs` | array | No | Linked CBOM `asset_id` values | |
| `algorithm_family` | string | No | Normalised algorithm | `ML-DSA-65` |
| `hlm_phase` | enum | No | `H1`, `H2`, `H3` | |
| `owner_team` | string | Yes | | `platform-security` |
| `environment` | enum | Yes | `production`, `staging`, `lab`, `ot_field` | |
| `blocking` | boolean | Yes | Structural blocker flag | `true` |
| `fan_in` | integer | Yes | In-degree count (recomputed on export) | `203` |
| `trade_mpi` | number | No | Post-scoring (Chapter 9) | `3.13` |
| `scope_zone` | string | No | Zone tag | `partner_ecosystem` |

### A.4.2 Edge record template

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `edge_id` | string | Yes | Unique edge identifier | |
| `source_node_id` | string | Yes | Directed edge source | |
| `target_node_id` | string | Yes | Directed edge target | |
| `edge_type` | enum | Yes | `implements`, `trusts`, `terminates`, `signs`, `inherits`, `verifies`, `wraps` |
| `criticality` | enum | Yes | `blocking`, `degradable`, `advisory` | |
| `validity_end` | date | No | Cert or policy expiry | |
| `evidence_pointer` | string | No | Scan ID, config path, ticket | |

---

## A.5 CDG JSON Graph Export Example (Illustrative)

```json
{
  "cdg_version": "1.0",
  "programme_id": "gsync-pqc-2026",
  "exported": "2026-10-15",
  "nodes": [
    {
      "node_id": "node-partner-mtls-v3",
      "node_type": "policy",
      "label": "Partner mutual TLS issuance policy v3",
      "owner_team": "platform-security",
      "environment": "production",
      "blocking": true,
      "fan_in": 203,
      "scope_zone": "partner_ecosystem"
    },
    {
      "node_id": "node-api-gateway-east",
      "node_type": "protocol",
      "label": "Americas API gateway TLS termination",
      "cbom_asset_refs": ["gs-cbom-2026-12004"],
      "hlm_phase": "H1",
      "owner_team": "platform-engineering",
      "environment": "production",
      "blocking": false,
      "fan_in": 1
    }
  ],
  "edges": [
    {
      "edge_id": "e-001",
      "source_node_id": "node-api-gateway-east",
      "target_node_id": "node-partner-mtls-v3",
      "edge_type": "trusts",
      "criticality": "blocking",
      "evidence_pointer": "config://gateway/mtls-policy-ref"
    }
  ]
}
```

---

## A.6 Blocking Node Register Template

Programme office maintains this register feeding wave planning (Chapter 8 §8.3, Chapter 9 Rule 1).

| `node_id` | `label` | `fan_in` | `owner` | `lead_time_months` | `wave_id` | `status` | `exit_criteria` | `risk_acceptance_id` | `last_updated` |
|-----------|---------|----------|---------|-------------------|-----------|----------|-----------------|---------------------|----------------|
| `node-partner-mtls-v3` | Partner mTLS policy | 203 | platform-security | 14 | W0 | in_progress | Single profile in production | — | 2026-09-01 |
| `node-payment-hsm-sign` | Payment HSM signing | 2400 | payments-crypto | 18 | W0 | blocked | CMVP ML-DSA listed | RA-2026-014 | 2026-11-01 |
| `node-ot-gateway-v3` | OT WAN gateway firmware | 18 | ot-security | 12 | W0 | in_progress | Hybrid IKE qualified | — | 2026-08-15 |

**Status values:** `identified`, `in_progress`, `resolved`, `blocked`, `risk_accepted`

---

## A.7 CDG Construction Worksheet (Phase A–D)

| Phase | Activity | Owner | Output | Duration (typical) |
|-------|----------|-------|--------|-------------------|
| **A — Seed** | Import top 50 MPI CBOM rows as nodes | Enterprise architect | Seed node list | 1 week |
| **B — Expand** | Workshop edge discovery with domain teams | Crypto engineering + domains | Edge inventory | 4–8 weeks |
| **C — Block** | Compute fan-in; flag blocking nodes | Programme office | Blocking register v1 | 1 week |
| **D — Maintain** | Update on CBOM delta, M&A, vendor change | CBOM custodian | Quarterly CDG refresh | Ongoing |

---

## A.8 Merge Rules: CBOM ↔ CDG

| Event | CBOM action | CDG action |
|-------|-------------|------------|
| New production hybrid | Update `hlm_phase`, `last_verified_date` | Update node `hlm_phase`; recompute blocking |
| HSM firmware upgrade | Update `validation_module_id` | Update HSM node; check `signs` edges |
| Partner policy change | Update partner CBOM rows | Update policy node; fan-in unchanged |
| M&A integration | Import acquired CBOM within 90 days | Merge graph; identify new blocking nodes |
| Vendor attestation drift | Flag `confidence=inferred` | Mark trust edges `advisory` until verified |

---

## A.9 Access Control and Classification

| Classification | Permitted roles | Export rules |
|----------------|-----------------|--------------|
| **Internal — Confidential** (default corporate CBOM) | Crypto engineering, programme office, risk, audit | No public export; redact partner SANs in summaries |
| **Restricted / CUI** | Authorised assessor list | FedRAMP/CMMC evidence zone only |
| **Classified** | NSS custodians | No merge with corporate graph; aggregate metrics only |

---

*Proceed to Appendix B: PQ-ADAPT Self-Assessment Questionnaire.*

---

*Appendix A — References*

- CycloneDX Contributors. (2024). *Authoritative Guide to CBOM* and CycloneDX specification v1.6+. OWASP Foundation.
- National Institute of Standards and Technology. (2024). FIPS 203–205 post-quantum cryptography standards. U.S. Department of Commerce.
- OWASP Foundation. (2024). CycloneDX CBOM guidance. https://cyclonedx.org/
