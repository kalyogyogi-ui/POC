# Chapter 19
# Financial Services Playbook

---

In November 2027, Meridian Mutual Bank's supervisory examination team requested the cryptographic governance evidence pack Thomas Bergström had rehearsed for eighteen months. Elena Vasquez's programme office delivered **fourteen indexed volumes** — not slide decks. Volume 3 contained the CBOM baseline with 12,847 cryptographic component rows at Level 2 maturity. Volume 7 mapped DORA Articles 6, 9, 25, and 28–30 to programme artefacts. Volume 9 held the payment HSM validation dependency timeline showing why Meridian's card-authorisation path could not reach Hybrid Lifecycle Model (HLM) phase H2 until Q2 2028, regardless of how quickly the retail mobile team deployed hybrid TLS.

The lead examiner's first question was not about algorithms. It was about **timelines**: *Why does your programme charter show retail API migration in Wave 1 while payment authorisation remains in Wave 0?*

Thomas answered with the Sector Overlay Matrix (SOM) financial services modifier and the validation dependency chain Elena had documented since the mock examination in Q3 2026. The examiner nodded — not because Meridian was finished, but because the institution could explain **which constraints dominated** and which evidence proved active management. Three findings followed: one observation on SaaS certificate register completeness (already remediated), one recommendation to accelerate SWIFT partner attestation cadence, and one matter requiring follow-up on hosted payment processor concentration risk. No finding challenged the programme's existence. The examination validated what this chapter argues: in financial services, **payment system constraints and HSM certification cycles dominate migration timelines** — and supervisors evaluate whether institutions understand that dominance, not whether every path has already deployed hybrids.

This chapter teaches readers to execute a DORA-aligned PQC programme in banking and payments — applying the universal model from Parts I–V through the financial services sector overlay, without treating regulatory systems as interchangeable with corporate IT.

---

## 19.1 Why Financial Services Differs from Universal Migration

Parts I through V built migration machinery that applies to any enterprise: threat framing, standards literacy, cryptographic inventory, architecture patterns, programme governance, procurement enforcement, supply-chain gates, and validation assurance. Financial institutions use that machinery — they do not replace it. What changes is **constraint ordering**.

Three sector-specific forces reorder priorities relative to the universal TRADE model:

**First, payment certification gates.** Card authorisation, PIN processing, and issuer cryptography run inside Hardware Security Module (HSM) boundaries subject to FIPS 140-3 validation, PCI Payment HSM (PCI PHSM) vendor assessment programmes, and card scheme security requirements. Application teams can deploy hybrid TLS in weeks. Payment HSM firmware transitions require **vendor lab cycles, CMVP listing, and scheme notification** measured in quarters or years. Chapter 18 established validation as a programme constraint; in banking, that constraint is often **binding** for revenue-critical paths.

**Second, supervisory evidence density.** DORA and EBA guidelines expect financial entities to demonstrate ICT risk management as an integrated discipline — encryption policy, third-party oversight, testing, and incident response — not isolated security projects. Chapter 3's regulatory logic applies with **higher evidentiary granularity**: supervisors ask for inventories, testing results, and third-party registers that map to specific articles, not generic "we are migrating" narratives.

**Third, market infrastructure dependency.** SWIFT customer security controls, TARGET2 and SEPA scheme requirements, card network trust policies, and central counterparty connectivity create **external trust edges** the enterprise does not control. Chapter 8's Cryptographic Dependency Graph (CDG) blocking nodes frequently sit at these boundaries. Wave planning must sequence around partner readiness, not internal enthusiasm alone.

| Universal programme element | Financial services modification |
|----------------------------|--------------------------------|
| TRADE scoring | SOM increases regulatory weight (wR +0.25) |
| Wave sequencing | Regulatory and payment paths earlier in Wave 1 |
| HLM timelines | Payment HSM paths lag corporate TLS by 12–24 months |
| Procurement emphasis | DORA Articles 28–30; PCI flow-down; scheme notification |
| Assurance packaging | DORA examination pack; PCI QSA reuse; CMVP traceability |
| Steering cadence | Regulatory affairs standing advisor (Chapter 15 pattern) |

> **Migration Moment**
>
> *"We will migrate payments when the HSM vendor ships PQC firmware — until then, corporate TLS is the programme."*
>
> That sequencing is correct — but only if documented as **constraint honesty**, not as programme scope reduction. Supervisors and internal audit distinguish institutions that understand payment HSM gates from institutions that claim enterprise migration while leaving cardholder data environments on classical cryptography indefinitely without risk acceptance. Meridian's steering committee published payment path lag explicitly in the charter — retail mobile acceleration did not obscure authorisation path dependency.

---

## 19.2 Sector Overlay Matrix — Financial Services

Chapter 9 previewed sector overlays as TRADE weight modifiers. Part VI operationalises the **Sector Overlay Matrix (SOM)** for financial services — a documented annotation to programme charter scoring methodology, not a replacement for TRADE.

### 19.2.1 Weight modifier: wR +0.25

Universal TRADE weights (Chapter 9 §9.3) assign wR = 1.25 to the Regulatory dimension. Financial services SOM increases effective regulatory weight:

**wR_financial = wR + 0.25 = 1.50**

Applied to MPI calculation:

**MPI = (wT×T + wR×R + wA×A + wD×D + wE×E) / (wT + wR + wA + wD + wE)**

With default weights (wT=1.0, wR=1.50, wA=1.0, wD=1.25, wE=1.0), the denominator increases from 5.50 to 5.75 — modest in formula, significant in outcomes. Systems with R ≥ 4 (DORA-subject payment processing, cardholder data environments, financial market infrastructure interfaces) **rise in MPI rank** relative to systems with lower regulatory scores but similar threat exposure.

**Table 19.1 — Sector Overlay — Financial Services**

| SOM parameter | Universal default | Financial services overlay | Programme implication |
|---------------|-------------------|---------------------------|----------------------|
| wR (Regulatory) | 1.25 | **1.50** (+0.25) | DORA/PCI-scoped systems rank higher in wave planning |
| wT (Threat) | 1.00 | 1.00 (unchanged) | HNDL remains material for retained transaction data |
| wA (Agility) | 1.00 | 1.00 (unchanged) | Agility gates apply; payment HSM agility is vendor-gated |
| wD (Dependency) | 1.25 | **1.35** (+0.10) | Scheme/SWIFT/CDG blocking edges weighted slightly higher |
| wE (Ecosystem) | 1.00 | **1.15** (+0.15) | Third-party processor concentration gains scoring emphasis |
| HLM timeline modifier | Standard | **Payment HSM: +12–24 months** | Authorisation paths behind corporate TLS |
| Evidence overlay | Universal assurance pack | **DORA examination index** | Article-mapped artefact structure |
| Procurement overlay | Chapter 16 clause library | **+ PCI PHSM flow-down** | Payment brand and scheme notification clauses |
| Wave 1 default bias | MPI-driven | **Regulatory MPI ≥ 3.8 prioritised** | Supervisory-visible paths before internal convenience |

Document SOM parameters in programme charter **before** year-over-year MPI comparison (Chapter 9 §9.22). Retroactive weight changes invalidate trend analysis and create examination inconsistencies.

### 19.2.2 When not to apply the overlay

Multinational financial groups should apply SOM **per entity and per jurisdiction**, not globally. Meridian applied financial services overlay to EU banking subsidiaries and UK ring-fenced bank operations; its asset management subsidiary used universal weights with selective DORA flow-down where ICT services were shared. GlobalSync Logistics (Chapter 21) demonstrates the inverse — platform operators serving financial tenants need **tenant-scoped overlays**, not enterprise-wide financial weights on logistics workloads.

### 19.2.3 SOM integration with PQ-ADAPT

PQ-ADAPT Level 4 (*Transitioning*) in financial services requires:

- Documented SOM in charter with board acknowledgement
- Production hybrids on at least one **regulatory-scoped** path (not only corporate intranet)
- DORA-mapped evidence pack under active maintenance
- Payment HSM validation timeline with honest gap status

Level 5 (*Quantum-Resilient*) additionally requires payment path H2 progress or documented scheme-mandated timeline alignment — not perpetual Wave 0 deferral.

---

## 19.3 DORA-Aligned PQC Programme Architecture

DORA does not mandate ML-KEM. It mandates **digital operational resilience** — including ICT risk management, incident reporting, resilience testing, and third-party oversight — with encryption policy explicitly tied to cryptanalytic developments including quantum threats (Chapter 3). A DORA-aligned PQC programme maps universal migration artefacts to DORA articles so supervisory reviewers encounter **familiar structure**, not a parallel security project.

### 19.3.1 Article mapping framework

| DORA article | Requirement (summary) | PQC programme artefact | Owner |
|--------------|------------------------|------------------------|-------|
| Art. 6 | ICT risk management framework | Programme charter; PQC Governance Stack (Ch 3) | CISO / programme director |
| Art. 8 | Identification of ICT risk | CBOM Level 2 baseline (Ch 7); TRADE worksheets (Ch 9) | Crypto engineering |
| Art. 9 | Protection and prevention | Algorithm policy (Ch 4); hybrid profiles (Ch 10–11) | Crypto governance board |
| Art. 10 | Detection | Runtime TLS monitoring; CBOM drift detection (Ch 17) | Security operations |
| Art. 11 | Response and recovery | Crypto incident playbooks; break-glass evidence (Ch 17) | Incident response |
| Art. 12–13 | Backup and learning | Key ceremony recovery; lessons learned register | PKI / HSM operations |
| Art. 25 | Testing | Validation programme (Ch 18); agility harness results | Assurance |
| Art. 28–30 | Third-party ICT risk | Vendor register; procurement clauses (Ch 16) | Third-party risk / procurement |

Meridian's Thomas Bergström insisted on **one-to-one artefact mapping** — no DORA appendix citing documents that steering committee had not approved. Examination Volume 7 contained only hyperlinked artefacts with version hashes, change logs, and accountable owners.

### 19.3.2 RTS 2024/1532 encryption policy requirements

Commission Delegated Regulation (EU) 2024/1532 supplements DORA with regulatory technical standards for ICT risk management tools, methods, processes, and policies. Encryption-relevant provisions require financial entities to:

- Maintain **encryption policies** proportionate to ICT risk
- Account for **cryptanalytic developments** in policy review
- Protect data confidentiality and integrity with **state-of-the-art** measures
- Document **key management** including lifecycle and custody

**PQC programme translation:** Encryption policy must reference post-quantum trajectory — not only current algorithms. Policy review cadence (Meridian: semi-annual crypto governance board) must include NIST, ETSI, and scheme publication monitoring. Key management documentation must extend to PQC key sizes, ceremony impacts, and HSM partition planning (Chapter 14).

> **Regulatory Lens**
>
> DORA supervisors evaluate **process maturity and evidence quality**, not deployment speed. An institution with hybrid TLS on retail APIs, honest CBOM coverage, documented payment HSM validation timeline, and active third-party assessment receives favourable review. An institution claiming "full PQC migration" with incomplete inventory and no payment path plan receives findings — regardless of laboratory pilots. Thomas Bergström's examination strategy prioritised **demonstrable governance** over algorithm breadth.

### 19.3.3 Integrating DORA with programme operating model

Chapter 15 established programme governance — charter, steering committee, RACI, KPI dashboard. Financial services overlay adds **regulatory affairs standing participation** without converting steering into compliance committee.

Meridian's integration pattern (Q2 2025 restructuring):

1. **Pre-steering crypto governance board** reviews policy and algorithm matrix changes
2. **Steering committee** approves wave execution, funding, and risk acceptance
3. **Thomas Bergström's regulatory affairs** advises on interpretation shifts; does not veto engineering
4. **Elena Vasquez's programme office** maintains examination pack as Assurance layer artefact
5. **Monthly procurement escalation slot** for DORA Art. 28–30 concentration triggers

Duplicate compliance workstreams fail. Meridian eliminated the 94% PQC readiness questionnaire (Chapter 7) when Elena merged DORA provider register fields into CBOM third-party rows — one dataset, two export views.

### 19.3.4 EBA guidelines and supervisory expectations

European Banking Authority guidelines on ICT and security risk management (EBA/GL/2019/04, as applicable under DORA) reinforce:

- **Governance** of ICT and security risk at board and senior management level
- **ICT and security risk assessment** including threat intelligence
- **Information asset classification** driving control proportionality
- **Encryption** as a standard protective measure for confidential data

EBA supervisory convergence in 2025–2027 examinations increasingly includes **cryptographic inventory sampling** and **third-party cryptographic posture** questions aligned with DORA RTS. Institutions prepared only with policy documents face findings; institutions with CBOM and vendor evidence packs do not.

### 19.3.5 Incident reporting and cryptographic failure modes

DORA Articles 17–23 establish ICT-related incident classification and reporting timelines. Cryptographic failures — certificate expiry cascades, HSM partition corruption, algorithm negotiation downgrade in production, compromised code-signing keys — may constitute **reportable ICT incidents** when they affect confidentiality, integrity, availability, or service continuity.

Meridian's incident response playbooks (Volume 12 of the examination pack) include **crypto-specific decision trees**:

| Event type | Reportable threshold (illustrative) | PQC programme link |
|------------|-------------------------------------|-------------------|
| Mass certificate expiry | Customer-facing service disruption > 2 hours | PKI overlap failure (Ch 13) |
| HSM cluster failure | Payment authorisation degraded | Validation timeline risk |
| Downgrade attack detected | Successful or attempted in CDE | Hybrid profile misconfiguration |
| Vendor crypto incident | Processor breach affecting keys | Art. 28 third-party escalation |

Elena Vasquez aligned incident classification training with Thomas Bergström's regulatory reporting calendar — security operations cannot classify crypto incidents in isolation from DORA reporting obligations. Post-quantum migration introduces **new failure modes** during hybrid transition: negotiation mismatch between ML-KEM-enabled clients and classical-only load balancers, oversized signatures breaking legacy API gateways, and ceremony errors with unfamiliar key formats. Each belongs in test plans (Chapter 18) before production promotion.

### 19.3.6 Resilience testing and threat-led penetration testing

DORA Article 25 requires advanced testing including threat-led penetration testing (TLPT) for significant institutions on a periodic cycle. TLPT scenarios increasingly probe **cryptographic control effectiveness** — not novel cryptanalysis, but operational failures: stolen credentials reaching KMS APIs, TLS downgrade on partner connections, expired intermediate certificates in payment chains.

Meridian's 2027 TLPT exercise included a **hybrid TLS downgrade scenario** on staging infrastructure mirroring retail API topology. Findings fed steering committee as Wave 1 remediation — two load balancer rules lacked hybrid profile enforcement. TLPT evidence occupied Volume 11 alongside agility harness results — supervisors treated operational crypto testing as complementary, not duplicative.

---

## 19.4 Payment HSM Certification Cycles

Payment HSMs — whether Thales payShield, Entrust nShield payment modules, or vendor-hosted payment cryptography platforms — sit at the centre of financial PQC timeline dominance. Understanding certification cycles separates realistic programmes from slide-deck fiction.

### 19.4.1 Certification stack

| Layer | Standard / programme | What it governs | PQC relevance |
|-------|---------------------|-----------------|---------------|
| Module validation | FIPS 140-3 / CMVP | Algorithm implementations inside HSM boundary | ML-KEM, ML-DSA listing per firmware version |
| Payment HSM | PCI PHSM | Payment cryptography device security | Vendor assessment; PQC roadmap scrutiny |
| Scheme certification | Visa, Mastercard, domestic schemes | Network security requirements | Scheme notification before production change |
| Operational approval | Acquirer, issuer internal risk | Production authorisation | Enterprise change management |

Each layer has **independent timelines**. CMVP listing of ML-KEM in payShield 10K firmware does not automatically satisfy scheme notification, enterprise change advisory board approval, or PCI assessor sign-off.

### 19.4.2 Typical certification cycle (illustrative)

```
  Vendor dev ──► Lab FIPS 140-3 ──► CMVP listing ──► PCI PHSM update
       │              │                  │                  │
     6–12 mo        3–6 mo             1–3 mo             2–4 mo
       │              │                  │                  │
       └──────────────┴──────────────────┴──────────────────┘
                                    │
                                    v
              Scheme notification ──► Enterprise pilot ──► Production
                    1–3 mo              2–3 mo            CAB window
```

**Total elapsed time** from vendor GA announcement to production authorisation: **18–36 months** in regulated paths — consistent with Meridian's payment authorisation H2 target of Q2 2028 despite 2027 retail API H1 completion.

### 19.4.3 Programme implications

**Wave 0 must include payment HSM unblocking** even when application teams are ready for Wave 1. Chapter 9 procurement gates tie Wave 0 funding to vendor SOWs referencing CDG `blocking_node_id`. Meridian's payment HSM vendor contract amendment (Chapter 16) linked milestone payments to:

- CMVP certificate publication with ML-DSA-65 listed
- PCI PHSM assessment letter update
- Enterprise interoperability test harness pass (Chapter 10)
- Scheme pre-notification acceptance letter

> **Dependency Alert**
>
> **Hosted payment processors** concentrate certification dependency. Meridian's hosted payment processor escalation (Chapter 16) blocked Level 2 baseline declaration because the processor's HSM attestation showed classical-only PIN verification with no binding PQC roadmap date. Internal hybrid TLS progress did not compensate — cardholder data environment cryptography remained vendor-gated. Procurement concentration risk review (DORA Art. 29) ran in parallel with CDG blocking analysis.

### 19.4.4 HSM partition and ceremony impacts

PQC key sizes increase storage and bandwidth requirements inside HSM partitions. Chapter 14's HSM assessment matrix (Table 14.1) scores partition capacity, algorithm support, and ceremony tooling. Meridian's payment HSM assessment identified:

- ML-DSA-65 issuer signing required **partition resize** — scheduled maintenance window
- PIN translation paths needed **hybrid key block formats** — vendor firmware dependency
- Key ceremony tooling required update for larger seed handling — operations training gate

These operational gates belong on the **validation dependency timeline** (Chapter 18 Figure 18.1 pattern) — not as afterthoughts during production cutover.

### 19.4.5 Dual-vendor and concentration mitigation

Where Art. 29 concentration risk review identifies single-vendor payment HSM dependency, programme options include:

| Option | Cost | Timeline impact | When appropriate |
|--------|------|-----------------|------------------|
| Contractual roadmap with penalties | Low | Uncertain | Vendor credible; substitutability low |
| Secondary vendor qualification | High | +12–18 months parallel qual | High transaction volume; board risk appetite |
| Hybrid classical continuation with risk acceptance | Medium | Buys time | Time-bound; max 12 months (Meridian pattern) |
| Architecture shift to hosted model | Variable | Depends on provider | Greenfield; divestiture of data centre HSM |

Meridian chose contractual roadmap with **twelve-month maximum risk acceptance** for classical continuation on authorisation path while retail API proceeded — steering minutes documented DORA Art. 9 risk mitigation framing (Chapter 15 §15.16).

### 19.4.6 Enterprise change management integration

Payment HSM firmware installation requires **coordinated change windows** spanning operations, acquirer notification, scheme pre-certification where applicable, and rollback planning. Meridian mapped HSM maintenance to:

- **Annual CAB calendar** — two four-hour windows reserved for cryptographic infrastructure
- **DR test alignment** — HSM failover exercises include post-firmware validation harness
- **Rollback criteria** — classical firmware image retained until 30-day stability proven
- **Communications** — acquirer and scheme notification templates pre-approved by legal

Chapter 15's operating rhythm calendar integrated payment HSM windows as **non-negotiable programme milestones** — application teams could not claim Wave 2 readiness if CAB slots were unbooked eighteen months forward.

### 19.4.7 Issuer versus acquirer asymmetry

Issuers and acquirers face **different CDG topologies**. Issuer programmes emphasise card authentication, tokenisation vaults, and 3-D Secure cryptography. Acquirer programmes emphasise terminal encryption, merchant gateway TLS, and settlement message signing. Meridian operated as **issuer and acquirer** in different subsidiaries — SOM overlay applied to both, but CDG blocking nodes differed:

| Role | Dominant blocking node | Typical certification gate |
|------|------------------------|---------------------------|
| Issuer | Issuer HSM; token service | Scheme issuer security bulletin |
| Acquirer | Terminal E2EE; gateway HSM | PCI PTS; acquirer processor |
| Processor (third party) | Hosted PIN | PCI PHSM; Art. 29 concentration |

Programme charters should name **which payment roles** are in scope — universal "payments migration" language obscures asymmetric dependencies.

---

## 19.5 PCI DSS 4.0 and Card Data Environments

PCI DSS version 4.0 introduces phased requirements through March 2025 and beyond, emphasising **targeted risk analysis**, cryptographic architecture documentation, and third-party service provider oversight. PCI SSC has not mandated specific PQC algorithms — but QSAs increasingly question quantum-vulnerable public-key cryptography in cardholder data environments (CDE) during assessments.

### 19.5.1 Documentation surfaces (Chapter 3 cross-reference)

| PCI DSS 4.0 area | Requirement theme | PQC programme response |
|------------------|-------------------|-------------------------|
| Req. 2 | Configuration standards | HSM and terminal crypto configs in CBOM |
| Req. 3 | Protect stored account data | Encryption algorithm inventory; key sizes |
| Req. 4 | Protect data in transit | TLS profiles; hybrid negotiation evidence |
| Req. 12 | Organisational policies | PQC policy; roles and responsibilities |
| Appendix A2 | SSL/TLS for POS | Legacy terminal constraints documented |

Meridian's PCI QSA received **examination pack Volume 9 subset** — payment HSM timeline, CBOM CDE-filtered export, and hosted processor assessment score — avoiding duplicate evidence collection across DORA and PCI audits.

### 19.5.2 PCI PHSM and payment brand programmes

Payment brands operate security programmes (Visa PSCP, Mastercard SDP) referencing PCI standards. PQC transitions will eventually flow through **brand security bulletins** — enterprises should monitor scheme publications alongside NIST IR 8547.

**Programme action:** Add scheme security bulletin review to Thomas Bergström's quarterly regulatory horizon report (Chapter 15). Link bulletin triggers to crypto governance board agenda — policy updates precede engineering tickets.

### 19.5.3 CDE scope discipline

CBOM must distinguish **CDE-scoped** rows from corporate IT. Meridian tagged CBOM `scope_zone` values:

- `cde_payment` — authorisation, clearing, PIN
- `cde_retention` — encrypted storage with retention obligations
- `corporate` — workforce, facilities
- `shared_service` — split custody document per row

TRADE scoring applies per zone. SOM overlay applies most aggressively to `cde_payment` and `cde_retention` zones — R dimension typically 4–5.

> **Architect's Decision**
>
> **Do not conflate retail mobile TLS success with CDE migration completeness.** Meridian's retail banking app reached H1 hybrid TLS in Wave 1 (Chapter 11 §11.14) — customer-visible progress. CDE authorisation remained H0 classical with documented validation dependency. Architecture diagrams show **two swim lanes** with explicit dependency arrows — supervisors and QSAs receive honest topology, not a single "bank migrated" narrative.

---

## 19.6 SWIFT and Market Infrastructure Dependencies

Financial institutions connect to market infrastructure — SWIFT FIN messaging, domestic real-time gross settlement (RTGS) systems, central securities depositories, and card network hubs — through **partner-controlled cryptography**. Internal migration cannot outpace infrastructure readiness without breaking production connectivity.

### 19.6.1 SWIFT Customer Security Programme (CSP)

SWIFT's Customer Security Programme mandates attestation against security controls including cryptography for messaging and connectivity. Control domains relevant to PQC:

- **Restrict Internet access** — often via managed network and HSM-protected channels
- **Cryptographic key management** — PKI for SWIFT connectivity, signing keys
- **Operator session confidentiality** — TLS and token cryptography

SWIFT infrastructure PQC transition will follow **network-wide coordination** — individual banks cannot unilaterally deploy PQC on FIN messaging before SWIFT and counterparty readiness. Programme implication:

| Phase | Enterprise action | Dependency |
|-------|-------------------|------------|
| Now | Inventory SWIFT crypto; CBOM rows for PKI and HSM | Internal |
| Wave 0–1 | Hybrid readiness on API channels not SWIFT-gated | Internal |
| Wave 2+ | SWIFT-guided transition per security bulletin | SWIFT / counterparties |
| Sustain | Attestation evidence refresh | Annual CSP cycle |

Meridian's examination **recommendation** to accelerate SWIFT partner attestation cadence reflected a gap: partner bank mTLS hubs in CDG had Ecosystem scores of 2 — below Chapter 9 Wave 1 gate (E ≥ 3).

### 19.6.2 Card scheme and domestic payment infrastructure

Card schemes publish security requirements affecting issuer authentication, tokenisation, and point-of-sale encryption. Domestic schemes (SEPA, Faster Payments, Nordic instant payment rails) maintain **scheme security policies** independent of enterprise architecture standards.

**CDG modelling:** Create trust edges for each scheme hub with attributes:

- `scheme_id` — VISA, MC, domestic RTGS identifier
- `partner_readiness` — unknown / roadmap / pilot / production
- `notification_required` — boolean
- `blocking_fan_in` — count of dependent systems

Wave planning sequences internal work **up to** scheme notification gates — not beyond without acceptance of operational risk.

### 19.6.3 Financial market infrastructure (NIS2 overlap)

NIS2 designates financial market infrastructures as essential entities. Institutions connecting to CCPs, CSDs, and trading venues face **bidirectional dependency**: you depend on their crypto; they depend on yours for settlement messages.

Meridian mapped three CCP connectivity paths as CDG blocking nodes with `wD` SOM boost — dependency dimension elevated 0.10 in financial overlay increases MPI for settlement cryptography relative to universal scoring.

### 19.6.4 PSD2, open banking, and API regulatory visibility

Payment Services Directive 2 (PSD2) and open banking regulatory frameworks in the UK and EU create **supervisor-visible API channels** — strong customer authentication (SCA), qualified certificates for eIDAS connections, and third-party provider (TPP) integration. These channels often reach **Wave 1 early** because:

- Regulatory scrutiny is direct — APIs are how supervisors observe modernisation
- CDG blocking is frequently lower than payment HSM paths — TLS termination under enterprise control
- Customer and TPP experience impact is immediate — business case aligns with SOM regulatory weighting

Meridian's open banking API gateway reached H1 hybrid TLS in Q1 2027 — same wave as retail mobile. Thomas Bergström cited PSD2 operational resilience expectations in examination opening narrative: **regulatory-visible channels demonstrate programme velocity** while payment HSM timeline documents constraint honesty.

**eIDAS and QTSP considerations:** Qualified trust service providers will eventually offer PQC-capable qualified certificates — enterprises should monitor ETSI and eIDAS expert group publications. Until QTSP PQC certificates are available, **hybrid TLS on API channels** and classical qualified certificates on parallel paths may coexist — document dual-path architecture in CBOM with sunset criteria.

### 19.6.5 Correspondent banking and counterparty attestation

Correspondent banking relationships introduce **counterparty cryptographic posture** as ecosystem risk (TRADE E dimension). Meridian required **annual cryptographic attestation** from twelve correspondent banks above transaction volume threshold — lightweight questionnaire derived from Table 16.2 subset. Three correspondents scored E = 2 — steering documented acceptance with concentration limits on transaction types, not programme delay.

---

## 19.7 Banking PQC Architecture Reference

Financial PQC architecture spans channels customers see, systems supervisors examine, and infrastructure partners control. The reference figure below is a **planning topology** — not a vendor diagram — showing custody zones and typical HLM phase progression.

### 19.7.1 Reference architecture (ASCII)

```
                    ┌──────────────────────────────────────────────────────────┐
                    │              CUSTOMER & CHANNEL LAYER                     │
                    │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐  │
                    │  │ Mobile app  │  │ Web banking │  │ Open banking API  │  │
                    │  │ TLS H1 ✓    │  │ TLS H1 ✓    │  │ TLS H1 ✓          │  │
                    │  └──────┬──────┘  └──────┬──────┘  └────────┬──────────┘  │
                    └─────────┼────────────────┼──────────────────┼────────────┘
                              │                │                  │
                    ┌─────────▼────────────────▼──────────────────▼────────────┐
                    │              API GATEWAY / WAF LAYER                      │
                    │         Hybrid TLS termination (ML-KEM + ECDHE)           │
                    │              FIPS boundary: cloud LB module               │
                    └─────────────────────────┬────────────────────────────────┘
                                              │
          ┌───────────────────────────────────┼───────────────────────────────────┐
          │                                   │                                   │
          ▼                                   ▼                                   ▼
┌─────────────────┐              ┌─────────────────────────┐          ┌──────────────────┐
│ CORPORATE PKI   │              │   PAYMENT PROCESSING     │          │ SWIFT / SCHEME   │
│ Issuing CA      │              │   ZONE (CDE)             │          │ CONNECTIVITY     │
│ H2 overlap      │──────────────│   ┌─────────────────┐   │          │ Partner mTLS     │
│ (Ch 13)         │              │   │ Payment HSM      │   │          │ E=2–3 (partner)  │
└─────────────────┘              │   │ H0 classical     │   │          │ SWIFT-guided W2+ │
                                 │   │ CMVP gate Q2'28  │   │          └────────┬─────────┘
                                 │   └────────┬────────┘   │                   │
                                 │            │            │                   │
                                 │   ┌────────▼────────┐   │                   │
                                 │   │ Hosted processor │   │                   │
                                 │   │ (3rd party)      │   │                   │
                                 │   │ E=2 → escalation │   │                   │
                                 │   └─────────────────┘   │                   │
                                 └─────────────────────────┘                   │
                                              │                                   │
                    ┌─────────────────────────▼───────────────────────────────────▼──┐
                    │              KEY CUSTODY & VALIDATION LAYER                       │
                    │  ┌──────────────┐  ┌──────────────┐  ┌────────────────────────┐  │
                    │  │ Enterprise   │  │ Cloud KMS    │  │ HSM ceremony &         │  │
                    │  │ HSM (corporate)│ │ FIPS endpoints│  │ partition management   │  │
                    │  │ ML-KEM pilot │  │ wrap ops     │  │ (Ch 14)                │  │
                    │  └──────────────┘  └──────────────┘  └────────────────────────┘  │
                    └────────────────────────────────────────────────────────────────────┘
                                              │
                    ┌─────────────────────────▼────────────────────────────────────┐
                    │         GOVERNANCE & EVIDENCE (Ch 3, 15, 16, 18)              │
                    │  CBOM ── CDG ── TRADE/SOM ── DORA pack ── PCI subset ── CMVP   │
                    └────────────────────────────────────────────────────────────────┘
```

### 19.7.2 Zone-specific HLM expectations

| Zone | Typical HLM 2027 | Typical HLM 2028 | Binding constraint |
|------|------------------|------------------|-------------------|
| Customer TLS | H1 hybrid | H2 prefer hybrid | Cloud LB FIPS module |
| Open banking APIs | H1 hybrid | H2 | Regulatory visibility (PSD2) |
| Corporate PKI | H1–H2 overlap | H2 | Ceremony capacity (Ch 13) |
| Payment authorisation | H0 classical | H2 target | Payment HSM CMVP |
| PIN translation | H0 classical | H2 target | PCI PHSM + scheme |
| SWIFT connectivity | H0–H1 | SWIFT-guided | Partner infrastructure |

### 19.7.3 Cloud KMS and multi-region FIPS boundaries

Retail and API channels frequently terminate TLS on **cloud load balancers** while payment cryptography remains on-premises HSM — two module boundaries, one architecture diagram. Meridian discovered its primary cloud region offered FIPS endpoints covering KMS wrap operations but **not** application-server default TLS stacks (Chapter 18 §18.2.2). Financial services programmes must score each region independently using Chapter 14 Table 14.1 — procurement slides claiming "FIPS-compliant cloud" are insufficient without per-region CMVP evidence.

| Workload | Typical custody | FIPS boundary pitfall |
|----------|-----------------|----------------------|
| Retail API TLS | Cloud LB + ingress | LB module listed; pod TLS unvalidated |
| Payment HSM | On-premises | Correct boundary; lags cloud channels |
| Token vault SaaS | Vendor-hosted | Third-party CMVP; Art. 28 scrutiny |
| Backup encryption | Cloud KMS | Regional listing variance |

> **Dependency Alert**
>
> **Multi-region active-active banking** multiplies validation evidence requirements. Meridian operated active-active retail APIs in two EU regions — one region's FIPS endpoint included ML-KEM; the other did not until Q3 2027. Traffic routing without region-aware crypto profiles would have advertised hybrid in one geography and classical-only in another — CBOM `region_id` tagging and health-check probes per region prevented silent split posture.

### 19.7.4 Architecture decision records

Each zone boundary crossing requires **Architecture Decision Record (ADR)** linking:

- Selected hybrid profile (Chapter 10)
- FIPS module boundary (Chapter 18 §18.2)
- CBOM component IDs affected
- CDG trust edges created or modified
- DORA/PCI article mapping

Meridian's architecture board refused ADR approval without CMVP certificate number field populated for regulated paths — empty field meant "lab only."

---

## 19.8 TRADE Rescoring and Wave Sequencing with SOM

Chapter 9 established wave planning mechanics. Financial services SOM modifies inputs and interpretation — not the wave gate structure itself.

### 19.8.1 Rescoring example

**System:** Card authorisation service

| Dimension | Universal score | SOM-adjusted weighting effect | Notes |
|-----------|-----------------|----------------------------|-------|
| T (Threat) | 4 | Unchanged | Transaction data; HNDL relevant |
| R (Regulatory) | 5 | **wR 1.50 amplifies** | DORA + PCI CDE |
| A (Agility) | 2 | Unchanged | HSM-gated |
| D (Dependency) | 5 | **wD 1.35 amplifies** | Payment HSM blocking |
| E (Ecosystem) | 2 | **wE 1.15 amplifies** | Hosted processor |

MPI with universal weights: ~4.1. MPI with financial SOM: ~4.3. Rank rises relative to corporate systems with R=2–3 — **Wave 1 prioritisation** even when agility score is low, because regulatory and dependency dimensions dominate.

### 19.8.2 Wave sequencing pattern

| Wave | Financial services typical content | Exit criteria emphasis |
|------|-----------------------------------|------------------------|
| Wave 0 | Payment HSM contracts; SWIFT partner CBOM; scheme notifications initiated | Blocking fan-in reduction; vendor SOW signed |
| Wave 1 | Retail/mobile TLS; open banking APIs; corporate PKI overlap start | Regulatory-visible hybrids; DORA testing evidence |
| Wave 2 | Payment authorisation H2; issuer signing; SWIFT transition per bulletin | CMVP-listed production paths |
| Wave 3 | Legacy mainframe crypto; branch systems | Agility debt clearance |
| Wave 4 | Sustain; HLM H3 verification | Disallowance readiness (NIST 2035 horizon) |

Chapter 9's Meridian example accelerated retail mobile TLS in Wave 1 despite MPI 3.4 — **business commitment** plus CDG clearance. Payment authorisation remained Wave 0 — **constraint honesty**. Both decisions are defensible with SOM-documented rationale.

### 19.8.3 Production gates with financial overlay

Chapter 9 production gates (E ≥ 3 for Wave 1+) apply strictly in CDE paths. Meridian waived no gates — it **sequenced work** so Wave 1 systems had E ≥ 4 (internal control) while payment paths remained in Wave 0 until processor evidence improved.

### 19.8.4 Funding gate interaction (Chapter 9 cross-reference)

Chapter 9 §9.24 ties wave funding release to procurement and CDG gates. Financial services overlay adds **regulatory funding scrutiny** — board packs should show:

| Gate | Financial services additional evidence |
|------|----------------------------------------|
| Wave 0 | Payment HSM vendor SOW; scheme pre-notification initiated |
| Wave 1 | DORA testing sample complete; CDE scope TRADE worksheets |
| Wave 2 | CMVP listing for payment path; PCI PHSM letter |
| Wave 3+ | Prior wave CDE exit ≥ 80%; exception register current |

Meridian's board risk committee deferred **Wave 2 funding request** in Q2 2027 when payment HSM CMVP milestone slipped — Elena presented risk acceptance rather than false Wave 2 scope. Board approved continued Wave 1 work with explicit **Wave 2 gate criteria** restated — funding discipline matched constraint honesty.

### 19.8.5 MPI comparison worked example

Two systems illustrate SOM impact:

**System A — Corporate HR portal:** T=2, R=2, A=4, D=2, E=4. Universal MPI ≈ 2.7. Financial SOM MPI ≈ 2.6. Rank: Wave 3.

**System B — Issuer 3-D Secure gateway:** T=4, R=5, A=3, D=4, E=3. Universal MPI ≈ 3.9. Financial SOM MPI ≈ 4.1. Rank: Wave 1.

Without SOM, System B might compete with high-agility corporate systems. With SOM, **regulatory and dependency weighting** elevates payment-adjacent paths appropriately — even when agility is moderate.

---

## 19.9 Third-Party and Payment Ecosystem Risk

Chapter 16 established procurement as cryptographic enforcement. Financial services intensifies third-party concentration — **40 critical ICT suppliers** in Meridian's 2027 assessment, with payment ecosystem providers scoring highest examination scrutiny.

### 19.9.1 Financial provider categories

| Category | Examples | PQC evidence priority | DORA article |
|----------|----------|----------------------|--------------|
| Payment HSM vendor | Hardware/firmware custodian | CMVP per algorithm; roadmap | Art. 28–30 |
| Hosted payment processor | PIN, tokenisation | CBOM Tier A; concentration risk | Art. 29 |
| Card scheme connectivity | Network hub | Scheme bulletin alignment | Art. 28 |
| Core banking SaaS | Ledger, accounts | JWT/signing CBOM; tenant isolation | Art. 28 |
| Cloud infrastructure | IaaS/PaaS | FIPS endpoint regional evidence | Art. 28 |
| SWIFT bureau / connector | Messaging | Partner attestation | Art. 28 |

### 19.9.2 Evidence reuse across examinations

Single vendor evidence repository exports:

- **DORA examination** — Article 28 register extract
- **PCI QSA** — Appendix D third-party template
- **Internal audit** — TRADE Ecosystem dimension input
- **Steering committee** — concentration escalation dashboard

Duplicating questionnaires across teams recreated Meridian's 94% readiness fiction (Chapter 7). Elena merged registers in Q2 2025.

### 19.9.3 Contractual milestone linkage

Chapter 16's payment HSM contract amendment pattern applies broadly:

- Milestone payments tied to CMVP listing dates
- SLA credits for missed CBOM delivery
- Audit rights exercised annually (light tier minimum)
- Exit assistance clauses for substitutability planning

---

## 19.10 Assurance Integration for Financial Services

Chapter 18's assurance programme — validation coverage matrix, test category matrix, dependency timeline — provides the **testing backbone** DORA Article 25 expects. Financial services packaging adds supervisory index structure.

### 19.10.1 Test category mapping to DORA

| Test category (Ch 18) | DORA Art. 25 evidence | Financial example |
|-----------------------|----------------------|-------------------|
| Functional | Harness pass records | ML-KEM handshake on retail API |
| Interoperability | Partner matrix results | SWIFT bureau mTLS (staging) |
| Performance | Latency baselines | Payment authorisation SLA under hybrid |
| Security | Pen test; red team | Downgrade resistance on CDE paths |

Meridian's Volume 11 contained **test evidence index** — not raw logs — with hyperlinks to harness artefacts, pen test reports, and DR exercise crypto recovery results.

### 19.10.2 Validation coverage honesty

Payment HSM ML-DSA gap remained **open** in examination pack with:

- POA&M entry with target Q2 2028
- Compensating controls: classical continuation within risk acceptance
- Vendor contractual milestone dates
- Steering committee minutes approving interim posture

Chapter 18's principle — honest gaps beat false claims — applied directly. Examiners accepted open gap with credible plan; they would have issued finding for undisclosed classical-only authorisation masked as hybrid.

> **Migration Moment**
>
> *"We passed the agility harness — we are production-ready for payments."*
>
> Harness pass proves **functional correctness in test environment**. Production authorisation requires **CMVP-listed module, PCI PHSM alignment, scheme notification, and change advisory approval**. Meridian's assurance team tags harness results with `environment=ci` vs `environment=production_hsm` — examination reviewers see the distinction immediately.

---

## 19.11 Meridian Mutual Bank: Programme Arc Years 1–2

Meridian's financial services arc provides a **composite teaching narrative** synthesising patterns from multiple EU banking programmes — illustrative, not a specific institution.

### 19.11.1 Year 0–1 (2024–2025): Foundation and DORA restructuring

| Quarter | Milestone | Artefact |
|---------|-----------|----------|
| Q4 2024 | Programme charter approved; CBOM discovery starts | Charter; RACI draft |
| Q1 2025 | DORA entry into force; GC briefing (Chapter 3 vignette) | Regulatory gap analysis |
| Q2 2025 | Elena integrates DORA into operating model; SOM documented | Charter amendment wR +0.25 |
| Q3 2025 | Level 2 CBOM baseline; CDG blocking nodes identified | 12,400+ rows; payment HSM blocking |
| Q4 2025 | Wave 0 funding approved; HSM vendor contract amendment | Procurement SOW with node IDs |

Thomas Bergström's regulatory affairs function shifted from horizon monitoring to **programme integration** — standing steering advisor role.

### 19.11.2 Year 1–2 (2026–2027): Execution and examination

| Quarter | Milestone | Outcome |
|---------|-----------|---------|
| Q1 2026 | Board standing PQC agenda (Chapter 15) | Outcome metrics discipline |
| Q2 2026 | Retail mobile TLS Wave 1 pilot | H1 hybrid in staging |
| Q3 2026 | Mock examination; SaaS register gaps found | Procurement amendments triggered |
| Q4 2026 | 40-supplier assessment complete (Chapter 16) | 31 Tier A/B; 3 escalations |
| Q1 2027 | Retail API H1 production; container gates live (Ch 17) | DORA testing evidence |
| Q2 2027 | Payment HSM CMVP milestone slip | Risk acceptance max 12 months |
| Q3 2027 | Level 4 PQ-ADAPT declared | First hybrid payment-adjacent services |
| Q4 2027 | DORA supervisory examination | 3 findings; no programme existence challenge |

### 19.11.3 Key decisions and lessons

**Retail acceleration without payment fiction.** Meridian deployed customer-visible hybrids while documenting payment path lag — SOM made regulatory scoring honest, not optimistic.

**Vendor concentration escalation.** Hosted payment processor at E=2 blocked baseline narrative until roadmap binding — procurement and steering aligned on Art. 29 review.

**Examination pack as living document.** Elena refused annual PDF dump — quarterly refresh with version control satisfied Art. 25 testing currency expectation.

**Risk acceptance time limits.** Twelve-month maximum classical continuation on authorisation — board escalation trigger if vendor misses CMVP milestone.

### 19.11.4 Examination day narrative

Thomas Bergström opened the November 2027 on-site examination with a **thirty-minute programme overview** — not algorithm tutorial. He presented:

1. Governance stack with named owners (Chapter 3, 15)
2. SOM financial overlay in charter — wR +0.25 documented Q2 2025
3. CBOM maturity Level 2 with known third-party gaps
4. Payment HSM validation timeline with open CMVP gap and compensating controls
5. 40-supplier assessment summary — concentration escalations and remediation status

Elena Vasquez demonstrated **live CBOM export** — 12,847 rows, filtered to CDE scope, with `hlm_phase` fields populated from CI/CD gates (Chapter 17). Examiners sampled ten rows — nine matched production TLS scan results; one mismatch triggered same-day investigation (stale attestation on decommissioned load balancer — corrected within 48 hours).

The hosted payment processor finding required **90-day remediation plan** — processor delivered binding roadmap with Q1 2028 CMVP dependency date. Meridian's plan included substitutability analysis (Art. 29) and transaction volume caps on classical PIN path — examiner accepted plan without mandatory processor replacement.

**Year 2 results summary:**

| Metric | Target | Actual (Year 2) |
|--------|--------|-----------------|
| CBOM Level 2 coverage | 95% in-scope rows | 97% |
| Wave 1 regulatory-visible hybrids | ≥ 2 production paths | 3 (retail API, mobile, open banking) |
| Payment HSM CMVP ML-DSA | Q4 2027 | Q2 2028 (slip) |
| Supplier Tier A/B rate | 75% critical providers | 78% (31/40) |
| DORA examination findings | ≤ 5 minor | 3 (1 observation, 1 recommendation, 1 follow-up) |
| PQ-ADAPT level | Level 4 | Level 4 (Q3 2027) |

### 19.11.5 What Meridian would do differently

Honest retrospective for teaching value:

- **Earlier payment HSM contract amendment** — six-month delay cost Wave 2 slip; procurement should have engaged at charter approval, not CBOM completion.
- **SWIFT partner attestation sooner** — examination recommendation was preventable with Wave 0 partner CBOM chase.
- **Single evidence repository from day one** — partial merger in Q2 2025 wasted four months on duplicate questionnaires before Elena eliminated the 94% readiness fiction.

---

## 19.12 DORA Examination Evidence Pack Structure

Meridian's fourteen-volume examination pack indexes universal artefacts for supervisory navigation. Structure below is **reusable template** — adapt volume count to institution size.

| Volume | Title | Primary chapters | DORA articles |
|--------|-------|------------------|---------------|
| 1 | Programme governance | 15 | Art. 6 |
| 2 | Encryption and crypto policy | 3, 4, 10 | Art. 9 |
| 3 | Cryptographic inventory (CBOM) | 7 | Art. 8 |
| 4 | Dependency graph and blocking analysis | 8 | Art. 8 |
| 5 | Risk prioritisation (TRADE/SOM) | 9, 19 | Art. 8–9 |
| 6 | Architecture standards and patterns | 10–14 | Art. 9 |
| 7 | Regulatory mapping index | 3, 19 | All |
| 8 | Third-party ICT risk | 16 | Art. 28–30 |
| 9 | Payment and CDE validation timeline | 18, 19 | Art. 9, 25 |
| 10 | Supply chain and CI/CD evidence | 17 | Art. 9–10 |
| 11 | Testing and assurance results | 18 | Art. 25 |
| 12 | Incident and break-glass records | 17 | Art. 11 |
| 13 | Exception and risk acceptance register | 15 | Art. 9 |
| 14 | Board and steering decision log | 15 | Art. 6 (governance) |

**Pack maintenance rules:**

- Quarterly refresh minimum; monthly during examination window
- Version hash on every exported CBOM
- Named owner per volume — accountable individual, not team alias
- Cross-reference `blocking_node_id` and `third_party_id` in all volumes
- **No duplicate narratives** — volumes hyperlink; they do not restate

Thomas Bergström's examination rehearsal used Chapter 3's six supervisory questions as **oral exam script** — programme leadership practised answers with evidence pointers, not memorised compliance language.

### 19.12.1 Six supervisory questions — financial services answers

Chapter 3 defines six questions supervisory reviewers ask. Financial services answer patterns:

| Question | Meridian answer pattern | Evidence pointer |
|----------|------------------------|------------------|
| 1. Do you have a documented programme? | Yes — charter, SOM, five-year phases | Volume 1 |
| 2. Is inventory complete and current? | Level 2 CBOM; quarterly refresh | Volume 3; KPI dashboard |
| 3. Are third parties managed? | 40-supplier assessment; Art. 28–30 mapping | Volume 8 |
| 4. Is encryption policy current? | Semi-annual crypto board; NIST/ETSI monitoring | Volume 2 |
| 5. Are you testing controls? | Harness, TLPT, pen test index | Volume 11 |
| 6. What are open gaps and plans? | Payment HSM Q2 2028; processor roadmap | Volume 9, 13 |

Question 6 separates **defensible institutions** from **theatre**. Meridian's open gap disclosure on payment authorisation received favourable comment in examination closing meeting — institution demonstrated constraint understanding.

### 19.12.2 Internal audit and external audit coordination

Internal audit at Meridian scoped cryptographic control testing to Wave 0–1 production systems in 2027 (Chapter 15). External statutory audit requested **CBOM subset** for IT general controls — same export as DORA Volume 3 with audit-specific filter. Three-audit reuse (DORA, PCI, statutory) reduced organisational fatigue — condition: **single owner** (Elena's programme office) maintains artefact currency.

---

## 19.13 Cross-Reference Index

| Topic | Chapter | Section reference |
|-------|---------|-------------------|
| Regulatory logic and DORA encryption policy | 3 | §3.4, §3.6 |
| CBOM baseline and third-party rows | 7 | §7.18, §7.43 |
| TRADE engine and wave gates | 9 | §9.3, §9.22, §9.24 |
| Programme charter and steering | 15 | §15.16 |
| Procurement and vendor assessment | 16 | §16.2, §16.16 |
| Validation and assurance programme | 18 | §18.2, §18.18 |
| Defence and OT sector overlay | 20 | Part VI continuation |

---

## 19.14 Apply in Your Organisation

1. **Document financial services SOM** in programme charter — wR +0.25, wD +0.10, wE +0.15; board acknowledgement before rescoring.
2. **Rescore TRADE worksheets** with SOM weights — identify regulatory systems rising into Wave 1.
3. **Map DORA articles** to existing programme artefacts — eliminate parallel compliance questionnaires.
4. **Publish payment HSM validation dependency timeline** — CMVP, PCI PHSM, scheme notification, enterprise CAB gates.
5. **Tag CBOM scope zones** — `cde_payment`, `cde_retention`, `corporate`, `shared_service`.
6. **Separate customer TLS and CDE swim lanes** in architecture diagrams — honest HLM phase per zone.
7. **Integrate regulatory affairs** as steering standing advisor — interpretation without engineering veto.
8. **Merge DORA provider register with PQC vendor assessment** — one dataset, multiple exports (Chapter 16).
9. **Add PCI DSS 4.0 documentation surfaces** to evidence pack — reuse for QSA assessment.
10. **Model SWIFT and scheme hubs** as CDG trust edges with `partner_readiness` attribute.
11. **Tie payment HSM vendor contracts** to CMVP milestone payments — Chapter 16 clause pattern.
12. **Build fourteen-volume examination pack index** — hyperlink artefacts; quarterly refresh.
13. **Exercise mock examination** using Chapter 3 supervisory questions — steering receives findings as decisions.
14. **Maintain risk acceptance time limits** on classical continuation — twelve-month maximum with board escalation trigger.
15. **Declare PQ-ADAPT Level 4** only with regulatory-scoped production hybrid — not corporate IT alone.

---

## 19.15 Chapter Summary

- Financial services applies the **universal migration model** with sector overlay — it does not replace Parts I–V machinery.
- **Payment system constraints and HSM certification cycles dominate timelines** — application agility does not transfer to cardholder data environments without validation gates.
- **SOM financial overlay** increases wR by 0.25 (to 1.50), with modest wD and wE boosts — document in charter before MPI comparison.
- **Table 19.1** summarises sector overlay parameters including HLM timeline modifier and evidence overlays.
- **DORA-aligned programmes** map Articles 6–30 to CBOM, CDG, TRADE, procurement, testing, and governance artefacts — one integrated evidence chain.
- **PCI DSS 4.0** documentation surfaces and PCI PHSM cycles add assessment obligations — reuse evidence across DORA and PCI audits.
- **SWIFT CSP and market infrastructure** create partner-gated trust edges — Wave 2+ typically follows infrastructure bulletins.
- **Banking PQC architecture reference figure** shows zone-specific HLM progression — customer TLS ahead of payment authorisation is normal and defensible when documented.
- **Chapter 16 third-party enforcement** and **Chapter 18 assurance integration** are intensified in financial services — concentration risk and validation honesty dominate examination outcomes.
- **Meridian's Year 1–2 arc** demonstrates DORA restructuring (2025), mock examination (2026), 40-supplier assessment, retail Wave 1 acceleration, payment HSM delay with bounded risk acceptance, and 2027 supervisory examination with process validation.
- **Examination evidence pack** fourteen-volume structure provides reusable supervisory index — living document, not annual PDF dump.

**Closing note:** Financial post-quantum migration succeeds when institutions treat **certification cycles as programme schedule drivers** — not as excuses for inventory neglect, and not as invisible blockers behind optimistic executive slides. Supervisors reward honesty with evidence; they penalise theatre without inventory.

**Next:** Chapter 20 — Defense, Government, and Critical Infrastructure — applies sector overlays where CNSA 2.0 floors, CMMC evidence separation, and OT maintenance windows dominate timelines instead of payment HSM certification.

---

*Chapter 19 — References*

- Commission Delegated Regulation (EU) 2024/1532 of 19 October 2024 supplementing Regulation (EU) 2022/2554 with regard to regulatory technical standards for ICT risk management. *Official Journal of the European Union*, L 2024/1532.
- European Banking Authority. (2024–2026). *Guidelines on ICT and security risk management* (EBA/GL/2019/04, as applicable under DORA). https://www.eba.europa.eu/
- European Parliament and Council. (2022). Regulation (EU) 2022/2554 on digital operational resilience for the financial sector (DORA). *Official Journal of the European Union*.
- National Institute of Standards and Technology. (2019). FIPS 140-3: Security Requirements for Cryptographic Modules. https://doi.org/10.6028/NIST.FIPS.140-3
- National Institute of Standards and Technology. (2024). NIST IR 8547 (Initial Public Draft): Transition to post-quantum cryptography standards. https://doi.org/10.6028/NIST.IR.8547.ipd
- Payment Card Industry Security Standards Council. (2024). *PCI DSS v4.0* and payment HSM security requirements. https://www.pcisecuritystandards.org/
- SWIFT. (2024–2026). *Customer Security Programme* — attestation framework and security controls guidance. https://www.swift.com/myswift/customer-security-programme-csp
- Cryptomathic A/S. (2024). *Post-quantum cryptography in financial services* — industry transition considerations (informative synthesis).
- Meridian Mutual Bank programme office. (2027). *Illustrative DORA examination evidence pack and payment HSM validation timeline* (composite case study).
- Thomas Bergström & Elena Vasquez. (2026). *Sector Overlay Matrix application in EU banking PQC programmes* — Meridian Mutual Bank internal methodology (composite teaching narrative).

---

*Proceed to Chapter 20: Defense, Government, and Critical Infrastructure.*
