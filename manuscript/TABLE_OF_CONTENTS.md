# Table of Contents

**Post-Quantum Cryptography: Enterprise Migration Handbook**

Complete section-level table of contents. Generated from manuscript source (June 2026).

---

## Front Matter

- Preface
- Conventions and How to Use This Book
- Framework Quick Reference (ARCS · PQ-ADAPT · TRADE · HLM · CDG · CBOM)

---

## Part I — The Migration Imperative
*ARCS: Awareness*

### Introduction
- Introduction
- What Part I Delivers
- Who Should Read Part I
- What This Book Is and Is Not
- The Teaching Organisations
- Conventions

### Chapter 1 — The Synchronization Problem
- 1.1 What Changed in August 2024
- 1.2 Why This Transition Is Not Like the Others
- 1.3 The Synchronization Problem
- 1.4 The Enterprise Dependency Iceberg
- 1.5 Programme Versus Project
- 1.6 Who Must Be in the Room
- 1.7 Lessons from Prior Migrations — and Their Limits
- 1.8 The ARCS Framework
- 1.9 Communicating With the Board
- 1.10 The Programme Horizon
- 1.11 Cryptography as Invisible Infrastructure
- 1.12 PQC Migration and Zero Trust Modernization
- 1.13 Common Failure Patterns
- 1.14 The Cost of Synchronization Failure
- 1.15 Apply in Your Organisation
- 1.16 Chapter Summary

### Chapter 2 — Threat Models That Drive Priorities
- 2.1 Separating Threat Categories
- 2.2 The Mathematics Enterprise Leaders Need — and Nothing More
- 2.3 The Confidentiality Horizon
- 2.4 Authentication and Integrity Horizons
- 2.5 The TRADE Threat Dimension
- 2.6 Sector-Specific Threat Calibration
- 2.7 Integrating Threat Intelligence and Red Team Findings
- 2.8 What the Threat Model Does Not Justify
- 2.9 Northfield Energy: Threat Analysis in Practice
- 2.10 Apex Defense and GlobalSync: Contrasting Threat Profiles
- 2.11 From Threat Analysis to Programme Justification
- 2.12 Conducting a Threat Assessment Workshop
- 2.13 Composite TRADE Scoring: A Worked Example
- 2.14 Communicating Threat to Non-Technical Stakeholders
- 2.15 M&A and Estate Changes
- 2.16 Symmetric Cryptography and Hash Functions: Scope Boundaries
- 2.17 Threat-Informed Control Selection
- 2.18 Documentation, ERM, and Cloud (Cross-References)
- 2.19 Apply in Your Organisation
- 2.20 Chapter Summary

### Chapter 3 — The Regulatory and Policy Landscape
- 3.1 The Regulatory Logic
- 3.2 United States Federal Framework
- 3.3 European Union Framework
- 3.4 GDPR and Data Protection Law
- 3.5 PCI DSS and Payment Industry Standards
- 3.6 United Kingdom, Australia, and Other National Frameworks
- 3.7 What Evidence Satisfies the Obligation
- 3.8 The PQC Governance Stack
- 3.9 Regulatory Convergence and Programme Design
- 3.10 Compliance Failure Modes
- 3.11 Northfield Energy: Regulatory Context for Critical Infrastructure
- 3.12 International Standards, Insurance, and Contractual Risk
- 3.13 Regulatory Timeline Overlay
- 3.14 Regulatory Engagement Strategy
- 3.15 GlobalSync Logistics: Multinational Regulatory Complexity
- 3.16 Auditor and Assessor Engagement
- 3.17 DORA Deep Dive: Article-by-Article PQC Relevance
- 3.18 Apply in Your Organisation
- 3.19 Chapter Summary

## Part II — Standards as Inputs
*Standards bridge (inputs to Capability)*

### Introduction
- Introduction
- What Part II Delivers
- PQ-ADAPT Level 2→3 Artefacts (Policy Foundation)
- Who Should Read Part II
- What Part II Is and Is Not
- The Teaching Organisations in Part II
- The Standards-as-Inputs Principle
- Conventions
- How Part II Connects to the Book Arc
- Suggested Reading Sequences

### Chapter 4 — From NIST Competition to FIPS 203–205
- 4.1 The Standards-as-Inputs Principle
- 4.2 The NIST PQC Project: From Competition to Standard
- 4.3 FIPS 203: ML-KEM (Module-Lattice-Based Key Encapsulation)
- 4.4 FIPS 204: ML-DSA (Module-Lattice-Based Digital Signatures)
- 4.5 FIPS 205: SLH-DSA (Stateless Hash-Based Signatures)
- 4.6 Security Categories and Enterprise Mapping
- 4.7 Contingency Algorithms: FN-DSA and HQC
- 4.8 Algorithm Selection Decision Logic
- 4.9 Northfield Energy: Parameter Size Constraints in OT
- 4.10 Performance, Size, and Protocol Interdependencies
- 4.11 International Alignment: ISO, ETSI, and IETF
- 4.12 Evaluating Vendor PQC Claims
- 4.13 GlobalSync Logistics: Platform-Wide Algorithm Consistency
- 4.14 Apex Defense: CNSA 2.0 vs. Commercial Availability
- 4.15 Meridian and GlobalSync: Standards in Policy Documents
- 4.16 FIPS 140-3 Validation and the Implementation Gap
- 4.17 Protocol and Library Readiness
- 4.18 Conducting an Algorithm Standards Workshop
- 4.19 Meridian Deep Dive: Payment HSM as Ecosystem Gate
- 4.20 Worked Example: Meridian Algorithm Standards Matrix
- 4.21 Common Algorithm Policy Mistakes
- 4.22 What This Chapter Deliberately Omits
- 4.23 Key Wrapping and Application-Layer Cryptography
- 4.24 Algorithm Agility Requirements in Policy
- 4.25 Apply in Your Organisation
- 4.26 Validation Coverage Matrix Example
- 4.27 Communicating Algorithm Standards to Engineering Teams
- 4.28 Standards Maintenance and Horizon Monitoring
- 4.29 Chapter Summary

### Chapter 5 — Transition Timelines and Hybrid Policy
- 5.1 From Standards Timelines to Enterprise Policy
- 5.2 NIST IR 8547: Deprecation and Disallowance
- 5.3 CNSA 2.0 Milestones
- 5.4 Allied National Timelines
- 5.5 Deriving Internal Timelines
- 5.6 The Hybrid Lifecycle Model (HLM)
- 5.7 Enterprise Hybrid Policy Requirements
- 5.8 Exceptions and Risk Acceptance
- 5.9 Sunset Criteria and Deprecation Governance
- 5.10 GlobalSync: Multinational Policy Variants
- 5.11 Meridian: DORA-Aligned Timeline Evidence
- 5.12 PQ-ADAPT and HLM Integration
- 5.13 Apex Defense: NSS Timeline Floors
- 5.14 Northfield Energy: Wave 1 Capital and Timeline Anchors
- 5.15 Meridian: Risk Acceptance Worked Example
- 5.16 GlobalSync: Tenant Notification and Contractual Sunsets
- 5.17 Northfield Energy: VPN and IKE Hybrid Transition
- 5.18 Hybrid TLS: Operational Deep Dive
- 5.19 Board and Executive Reporting on Timelines
- 5.20 Integration with Zero Trust and Identity Programmes
- 5.21 Conducting a Timeline Alignment Workshop
- 5.22 Common Hybrid Policy Failures
- 5.23 Apply in Your Organisation
- 5.24 Procurement and Timeline Alignment
- 5.25 HLM Governance Cadence
- 5.26 HLM Metrics and Executive Dashboards
- 5.27 Exception Lifecycle Management
- 5.28 Five-Year Programme Phase Model
- 5.29 Deprecation and Disallowance: Board Narrative Templates
- 5.30 Auditor and Assessor Engagement on Hybrid Policy
- 5.31 Coordinating Timeline Policy with Part III Inventory
- 5.32 Hybrid Policy in M&A and Divestiture
- 5.33 Document Control and Policy Versioning
- 5.34 Chapter Summary

### Chapter 6 — Stateful Signatures, Firmware, and Special Cases
- 6.1 Why Firmware and Embedded Systems Are Special Cases
- 6.2 NIST SP 800-208: Stateful Hash-Based Signatures
- 6.3 CNSA 2.0 and Firmware Signing Requirements
- 6.4 Signature Scheme Selection Matrix
- 6.5 ML-DSA for Code and Firmware Signing
- 6.6 SLH-DSA in Constrained Environments
- 6.7 LMS and XMSS Operational Design
- 6.8 Northfield Energy: Three-Vendor Firmware Chain
- 6.9 Air-Gapped and Offline Signing Workflows
- 6.10 Sector Overlay: OT Firmware (SOM Preview)
- 6.11 Supply Chain and Vendor Contracting
- 6.12 Relationship to Part IV Architecture Chapters
- 6.13 Meridian Mutual Bank: Payment HSM Firmware Signing
- 6.14 Apex Defense: Classified and Unclassified Boundaries
- 6.15 LMS and XMSS Parameter Selection
- 6.16 Testing and Validation for Firmware Signing
- 6.17 GlobalSync: Container Image Signing
- 6.18 Smart Cards, Tokens, and Physical Form Factors
- 6.19 Compensating Controls When Migration Is Gated
- 6.20 Cloud-Native vs OT: Comparative Programme Patterns
- 6.21 Firmware Signing Programme Charter Elements
- 6.22 Apply in Your Organisation
- 6.23 Programme Anti-Patterns in Firmware Migration
- 6.24 Cross-Functional Stakeholder Map for Firmware Signing
- 6.25 Long-Term Trust Horizons for Firmware Certificates
- 6.26 Incident Response for Firmware Signing Failures
- 6.27 Five-Year Firmware Programme Roadmap (Northfield)
- 6.28 Training and Workforce Development
- 6.29 Integrating Firmware Programme with TRADE Rescoring
- 6.30 Warranty, Liability, and Vendor Indemnification
- 6.31 Warranty and Evidence Retention
- 6.32 Chapter Summary

## Part III — Knowing Your Cryptographic Estate
*ARCS: Register*

### Introduction
- Introduction
- What Part III Delivers
- PQ-ADAPT and ARCS Positioning
- Part III Exit Artefacts
- Who Should Read Part III
- The Teaching Organisations in Part III
- What Part III Is and Is Not
- Prerequisites
- Conventions

### Chapter 7 — Cryptographic Discovery and the CBOM
- 7.1 The CBOM as System of Record
- 7.2 PQ-ADAPT Level 2: Inventoried
- 7.3 Application-Layer and Non-TLS Cryptography
- 7.4 CycloneDX and CBOM Structure
- 7.5 Discovery Methods
- 7.6 The Unknown Bucket
- 7.7 Third-Party and SaaS Obscurity
- 7.8 Transitive Library Dependencies
- 7.9 OT and Critical Infrastructure Discovery
- 7.10 CBOM Attribute Schema (Programme Minimum)
- 7.11 Algorithm Normalisation
- 7.12 Privacy, Classification, and CBOM Field Handling
- 7.13 Meridian Phase 1: Programme Execution
- 7.14 GlobalSync: Cloud-Native CBOM Pipeline
- 7.15 Apex Defense: Classified and Corporate Inventory Boundaries
- 7.16 Data Governance, RACI, and Evidence Quality
- 7.17 Integration with Change Management and CI/CD
- 7.18 SBOM and CBOM Convergence
- 7.19 DORA, NIS2, and Supervisory Evidence
- 7.20 Budget, Tooling, and Team Sizing
- 7.21 Lessons from Meridian Tranche Execution
- 7.22 CBOM Maintenance and Ownership
- 7.23 Conducting a Discovery Scoping Workshop
- 7.24 Common CBOM Failure Modes
- 7.25 Apply in Your Organisation
- 7.26 Executive Reporting and Board Narratives
- 7.27 CBOM and Zero Trust Programme Alignment
- 7.28 Discovery Tool Categories (Non-Endorsement)
- 7.29 Northfield Deep Dive: OT CBOM Extension
- 7.30 Coordinating CBOM with Part IV Architecture
- 7.31 Certificate Transparency and External Attack Surface
- 7.32 HSM and Key Ceremony Documentation
- 7.33 Sampling Verification Methodology
- 7.34 Programme Office CBOM Operating Rhythm
- 7.35 API Gateways and Cryptographic Aggregation
- 7.36 Mobile, IoT, and Edge Device Discovery
- 7.37 Worked Example: Single Payment Microservice CBOM Rows
- 7.38 M&A and Divestiture CBOM Handling
- 7.39 Communicating Discovery Results to Engineering
- 7.40 Shadow IT and Cryptographic Surprise
- 7.41 Baseline Declaration Ceremony
- 7.42 Auditor Questions and CBOM Evidence Mapping
- 7.43 Continuous Discovery vs Phase 1
- 7.44 Figure Production Brief — CBOM Discovery Architecture
- 7.45 Chapter Summary

### Chapter 8 — The Cryptographic Dependency Graph
- 8.1 Why a CBOM Is Not Enough
- 8.2 CDG Definition
- 8.3 Blocking Nodes
- 8.4 GlobalSync: Partner API as Blocking Node
- 8.5 Meridian: HSM Firmware Signing Chain
- 8.6 Northfield: OT Gateway as Protocol Translator
- 8.7 Apex: Classified Boundaries and NSS Isolation
- 8.8 PKI Dependency Explosion
- 8.9 Building the CDG: Methodology
- 8.10 Northfield: VPN Concentrators and WAN Trust
- 8.11 Meridian: Enterprise PKI Roll-Up Worked Example
- 8.12 Edge Validation and Evidence Attachments
- 8.13 Query Patterns for Programme Roles
- 8.14 CDG Maturity Model
- 8.15 Partner and Ecosystem Edges
- 8.16 Tooling and Storage
- 8.17 CDG and TRADE Integration
- 8.18 Failure Modes
- 8.19 Workshop: One Blocking Node Deep Dive
- 8.20 Apex: Contract Renewal and Cross-Domain Guards
- 8.21 Dual-Run and Parallel Trust Periods
- 8.22 CDG Anti-Patterns
- 8.23 Apply in Your Organisation
- 8.24 GlobalSync Microservices: Dependency Inversion
- 8.25 Meridian Payment Chain: Ceremony to Terminal
- 8.26 CDG Diff and Programme Health Metrics
- 8.27 Executive CDG Dashboard
- 8.28 Time-Boxing CDG Construction
- 8.29 CDG and Procurement
- 8.30 Trust Store and JVM Classpath Discovery
- 8.31 Mutual TLS Bidirectional Modelling
- 8.32 Firmware and Boot Chain CDG Patterns
- 8.33 CDG Versioning and Change Control
- 8.34 Multi-Organisation CDG Merge Patterns
- 8.35 CDG for Cloud Shared Responsibility
- 8.36 Facilitating CDG Enrichment Interviews
- 8.37 CDG Deliverables Checklist
- 8.38 Service Mesh and East-West Trust
- 8.39 Worked Blast-Radius Exercise: Manufacturing Root Rotation
- 8.40 Code Signing and CI/CD Pipeline CDG
- 8.41 Database and KMS Dependency Chains
- 8.42 CDN and Third-Party Edge Termination
- 8.43 CDG for Disaster Recovery and Standby Sites
- 8.44 Apex NSS: Cross-Domain Guard Edge Cases
- 8.45 CDG Maintenance Operating Rhythm
- 8.46 Common CDG Interview Questions
- 8.47 Identity Provider and SSO Federation CDG
- 8.48 Email, Document Signing, and S/MIME Chains
- 8.49 Wireless, IoT Radio, and Non-IP Cryptography
- 8.50 Blockchain and Ledger Dependencies (Meridian)
- 8.51 Quantifying Blocking Strength
- 8.52 CDG Tooling Comparison (Non-Endorsement)
- 8.53 Legal Hold and eDiscovery Trust Dependencies
- 8.54 Northfield OT Gateway Deep Dive
- 8.55 CDG Quality Assurance Before Wave Planning
- 8.56 Applying CDG in Regulated Assessments
- 8.57 Integrating CDG with Enterprise Architecture Repositories
- 8.58 References and Further Reading
- 8.59 Chapter Summary

### Chapter 9 — Risk Tiering and Migration Wave Planning
- 9.1 From Inventory to Action
- 9.2 The TRADE Decision Engine (Full Specification)
- 9.3 Dimension Scoring Rubrics
- 9.4 Worked MPI Examples
- 9.5 Wave Taxonomy
- 9.6 Sequencing Rules
- 9.7 "Do Not Migrate Yet" Conditions
- 9.8 Wave Sizing and Capacity
- 9.9 Table 9.1 — TRADE Scoring Worksheet
- 9.10 Table 9.2 — Wave Definition Template
- 9.11 Apex Defense: Contract-Aligned Waves
- 9.12 Meridian Mutual Bank: Wave Plan Summary
- 9.13 GlobalSync Logistics: Partner-First Sequencing
- 9.14 Northfield Energy Systems: OT and Threat Waves
- 9.15 Board Approval Package
- 9.16 Wave Reassessment
- 9.17 TRADE and HLM Interaction
- 9.18 Common Wave Planning Failure Modes
- 9.19 Workshop: Building Wave 0
- 9.20 Apply in Your Organisation
- 9.21 Reconciling TRADE with Business Priority
- 9.22 Sector Overlay Preview (Part VI)
- 9.23 Five-Year Programme Phase Model Integration
- 9.24 Procurement and Wave Funding Gates
- 9.25 Wave Governance Cadence
- 9.26 Executive MPI Dashboard
- 9.27 Risk Acceptance Integration
- 9.28 Communicating Waves to Engineering
- 9.29 Auditor and Assessor Engagement
- 9.30 Conducting a TRADE Scoring Workshop
- 9.31 Wave Plan Document Structure
- 9.32 Decommission vs Migrate Decision Tree
- 9.33 Hybrid Quick Wins vs Structural Waves
- 9.34 MPI Sensitivity Analysis
- 9.35 Regulatory Dimension Deep Dive
- 9.36 Architectural Dependency Deep Dive
- 9.37 Ecosystem Readiness Deep Dive
- 9.38 Wave Exit Criteria and Completion Gates
- 9.39 Threat and Data Longevity Dimension Deep Dives
- 9.40 Worked Example: Northfield VPN Concentrator Wave 0
- 9.41 Worked Example: Apex NSS Deliverable Signing
- 9.42 Board and Executive Narrative Templates
- 9.43 Wave Capacity and Portfolio Management
- 9.44 TRADE Score Decay and Re-Scoring Triggers
- 9.45 Integrating Waves with HLM and CBOM Attributes
- 9.46 GlobalSync Tenant Segmentation for TRADE
- 9.47 Meridian Wave 2–4 Sketch
- 9.48 Measuring Programme Success Beyond MPI
- 9.49 What Wave Planning Deliberately Omits
- 9.50 Part III Exit Checklist
- 9.51 Escalation Paths When Waves Stall
- 9.52 Wave Plan Anti-Patterns Catalogue
- 9.53 Figure Production Brief — Migration Wave Gantt
- 9.54 Cross-Functional Wave Ownership
- 9.55 Chapter Summary

## Part IV — Architecting for Transition
*ARCS: Capability*

### Introduction
- Introduction
- What Part IV Delivers
- ARCS and PQ-ADAPT Positioning
- Part IV Exit Artefacts
- Prerequisites
- Who Should Read Part IV
- The Teaching Organisations in Part IV
- What Part IV Is and Is Not
- How Part IV Connects to the Book Arc
- Suggested Reading Sequences
- Conventions

### Chapter 10 — Cryptographic Agility as Architecture
- 10.1 ARCS Decide Phase and PQ-ADAPT Level 3
- 10.2 What Cryptographic Agility Is — and Is Not
- 10.3 The Core Principle: Policy Separated from Implementation
- 10.4 The Cryptographic Agility Maturity Model
- 10.5 Crypto-Agility Non-Functional Requirements
- 10.6 NFR Variants by System Class
- 10.7 GlobalSync: Platform Engineering Agility Standards
- 10.8 Provider Abstraction
- 10.9 Config-Driven Algorithm Selection
- 10.10 Algorithm Negotiation
- 10.11 Meridian: SDLC Gates for Agility
- 10.12 Apex: NSS Agility Constraints
- 10.13 Northfield: OT Agility Limitations
- 10.14 The Enterprise Crypto Agility Test Harness
- 10.15 CBOM Integration for Agility
- 10.16 HLM and Agility Co-Design
- 10.17 DORA, Operational Resilience, and Agility Evidence
- 10.18 PQC Governance Stack — Architecture Layer
- 10.18.1 Zero Trust and agility co-programming
- 10.19 Anti-Patterns Catalogue
- 10.20 Retrofit Patterns for Existing Systems
- 10.21 Cross-References and Prerequisites
- 10.22 Platform Engineering Operating Model
- 10.23 Agility Metrics for Steering Committee
- 10.24 Editorial Consistency with Programme Artefacts
- 10.25 Figure Production Brief — Agility Layer Model
- 10.26 PQ-ADAPT Level 3 Exit Checklist
- 10.27 Apply in Your Organisation
- 10.28 Chapter Summary

### Chapter 11 — Hybrid Deployment Patterns
- 11.1 The Hybrid Lifecycle Model: Full Deployment Specification
- 11.2 Pattern Selection: When Hybrid Is Mandatory, Optional, or Prohibited
- 11.3 Hybrid TLS: X25519 + ML-KEM-768
- 11.4 Combiner Security and Construction Requirements
- 11.5 Performance, Bandwidth, and Handshake Size
- 11.6 VPN Hybrid IKE
- 11.7 Dual Code Signing and Firmware Hybrids
- 11.8 Application-Layer Hybrids
- 11.9 Hybrid Pattern Catalog
- 11.10 CBOM Attributes and HLM Tracking
- 11.11 CDG Blocking, Waves, and Hybrid Sequencing
- 11.12 Case Study: Meridian Hybrid TLS Pilot
- 11.13 GlobalSync: Tiered Endpoints and Tenant Cohorts
- 11.14 HLM and Hybrid Failure Modes
- 11.15 Validation and Interoperability Testing
- 11.16 Governance Integration
- 11.17 Cross-Reference Map
- 11.18 Apply in Your Organisation
- 11.19 Chapter Summary

### Chapter 12 — Protocol Transition — TLS, IPsec, SSH, and Messaging
- 12.1 Protocol Transition as Ecosystem Synchronisation
- 12.2 A Unified Protocol Transition Methodology
- 12.3 TLS 1.3 Migration
- 12.4 Client Compatibility and Cohort Analysis
- 12.5 Middlebox Interference and Infrastructure Buffers
- 12.6 OpenSSL and Library Readiness
- 12.7 IPsec and IKEv2 Hybrid Transition
- 12.8 SSH Host Keys and Certificates
- 12.9 Messaging Protocols: Kafka, AMQP, and Event Backbones
- 12.10 API Mutual TLS: Recap and Integration
- 12.11 Email: S/MIME and PKI Implications
- 12.12 Apex Defense: NSS Protocol Requirements
- 12.13 Partner Synchronisation: The Slowest Critical Partner Sets Pace
- 12.14 Protocol × Algorithm × Readiness Matrix
- 12.15 Protocol Readiness Radar
- 12.16 Phased Protocol Rollout
- 12.17 Observability and CBOM Integration
- 12.18 Testing Protocol Transitions
- 12.19 Failure Modes and Recovery
- 12.20 Cross-Reference Map
- 12.21 Apply in Your Organisation
- 12.22 Chapter Summary

### Chapter 13 — PKI Evolution and Certificate Lifecycle
- 13.1 PKI as the Dominant Wave 0 Blocking Domain
- 13.2 PQC-Capable PKI Hierarchy Architecture
- 13.3 Root and Subordinate CA Strategy
- 13.4 Meridian: Ten-Year Root Overlap Strategy
- 13.5 ML-DSA Certificate Sizes, Chain Length, and Trust Store Updates
- 13.6 Certificate Profiles: Server TLS, Client mTLS, Code Signing, Email
- 13.7 Table 13.6 — Certificate Profile Comparison: RSA vs ML-DSA
- 13.8 Validity Period Policy
- 13.9 ACME Automation and Certificate Lifecycle Operations
- 13.10 Cross-Certification and Federation
- 13.11 CA/Browser Forum Context (Not Reproduced)
- 13.12 Trust Store Mechanics: Distribution, Verification, and Rollback
- 13.13 Mobile Pinning and Application Trust Bundles
- 13.14 Partner Chains and Ecosystem Trust
- 13.15 GlobalSync: Service Mesh CA and Tenant Trust Boundaries
- 13.16 Apex: NSS vs Commercial PKI Separation
- 13.17 Northfield: OT PKI and Long-Validity Constraints
- 13.18 CDG Integration: PKI as Blocking Hub
- 13.19 CBOM Certificate Attributes
- 13.20 Governance, Audit, and Steering Metrics
- 13.21 Cross-Reference Map
- 13.22 Apply in Your Organisation
- 13.23 Chapter Summary

### Chapter 14 — Key Management, HSMs, and Cloud Cryptography
- 14.1 Key Management as the Migration Bottleneck
- 14.2 KMS Migration Architecture
- 14.3 Key Lifecycle: Generate, Wrap, Rotate, Destroy
- 14.4 HSM Partitioning and Logical Isolation
- 14.5 FIPS 140-3 Validation and Module Selection
- 14.6 Performance with Larger PQC Keys
- 14.7 HSM/KMS Capability Assessment Matrix
- 14.8 Apex: HSM Partition Strategy for Classified and Unclassified Zones
- 14.9 Meridian: Payment HSM and ML-DSA Ceremony Adaptation
- 14.10 Multi-Cloud KMS Patterns
- 14.11 Shared Responsibility, BYOK, and HYOK
- 14.12 CNSA Parameter Profiles for NSS
- 14.13 GlobalSync: Tenant-Scoped KMS and Crypto Service Integration
- 14.14 Integration with PKI and Firmware Signing
- 14.15 CDG Blocking Nodes and Wave Sequencing
- 14.16 Confidential Computing and Key Custody
- 14.17 Ceremony Governance, DR, and Assurance
- 14.18 Northfield: OT Custody Realism
- 14.19 Cross-Reference Map
- 14.20 Apply in Your Organisation
- 14.21 Chapter Summary

## Part V — Running the Migration Programme
*ARCS: Synchronize*

### Introduction
- Introduction
- What Part V Delivers
- ARCS and PQ-ADAPT Positioning
- Part V Exit Artefacts
- Prerequisites
- Who Should Read Part V
- The Teaching Organisations in Part V
- What Part V Is and Is Not
- How Part V Connects to the Book Arc
- Suggested Reading Sequences
- Conventions

### Chapter 15 — Programme Governance and Operating Model
- 15.1 ARCS Synchronize and PQ-ADAPT Level 4 Entry
- 15.2 From Governance Stack to Operating Model
- 15.3 Strategic Layer: Board Integration and Risk Appetite
- 15.4 Programme Layer: Charter, Authority, and Scope
- 15.5 Migration Authority and Decision Rights
- 15.6 Steering Committee Design
- 15.7 RACI Matrix — Programme Functions
- 15.8 Policy Layer Operations
- 15.9 Operational Layer Cadence
- 15.10 Assurance Layer Integration
- 15.11 KPI Dashboard Template
- 15.12 Board Reporting
- 15.13 Funding Model
- 15.14 Operating Rhythm Calendar
- 15.15 Case Study: GlobalSync Three-Region Programme Office
- 15.16 Meridian Mutual Bank: DORA-Aligned Steering
- 15.17 Apex Defense Technologies: NSS Governance Separation
- 15.18 Northfield Energy Systems: Essential Entity Reporting
- 15.19 Programme Office Functions and Staffing
- 15.20 Cross-References and Prerequisites
- 15.21 PQ-ADAPT Level 4 Entry Checklist
- 15.22 Figure Production Briefs
- 15.23 Apply in Your Organisation
- 15.24 Chapter Summary

### Chapter 16 — Procurement, Contracts, and Third-Party Risk
- 16.1 Why Procurement Owns Cryptographic Outcomes
- 16.2 DORA Articles 28–30: Third-Party ICT Risk
- 16.3 CBOM Supplier Requirements
- 16.4 Contract Clause Library
- 16.5 Vendor Evidence Checklist
- 16.6 SLA Audit Rights and Roadmap Verification
- 16.7 Procurement Gates and Wave Funding (Chapter 9 Cross-Reference)
- 16.8 HSM and KMS Vendor Assessment (Chapter 14 Cross-Reference)
- 16.9 Case Study: Meridian — 40 Critical Supplier Assessment
- 16.10 GlobalSync: Multinational Procurement Overlay
- 16.11 Apex Defense Technologies: Flow-Down and NSS Separation
- 16.12 Northfield Energy Systems: OT Vendor Management
- 16.13 Vendor Readiness Assessment Flow
- 16.14 Integrating Vendor Assessment with Programme Office Rhythm
- 16.15 Concentration Risk Escalation Playbook
- 16.16 SaaS, Shadow IT, and Marketplace Procurement
- 16.17 RFP and Renewal Playbooks
- 16.18 Auditor and Supervisory Questions
- 16.19 Cross-Reference Map
- 16.20 Apply in Your Organisation
- 16.21 Chapter Summary

### Chapter 17 — Software Supply Chain and Embedded Cryptography
- 17.1 The Supply Chain as Cryptographic Attack Surface
- 17.2 From Discovery to Enforcement: CI/CD as Programme Layer
- 17.3 CycloneDX, SBOM, and CBOM in Build Pipelines
- 17.4 The CI/CD Cryptographic Verification Pipeline
- 17.5 Build-Time versus Runtime Verification
- 17.6 Static Analysis: Capabilities and Limits
- 17.7 Transitive Dependencies and Base Image Governance
- 17.8 Firmware BOM and Embedded Cryptography
- 17.9 NIST SSDF Alignment
- 17.10 Agility Gates in CI/CD
- 17.11 Hybrid CBOM Fields in Pipeline Gates
- 17.12 GlobalSync: Container Gates and Multinational Overlay
- 17.13 Meridian: Container Gates in Regulated Banking
- 17.14 Northfield: Firmware Supply Chain Integration
- 17.15 Apex: Classified Build Pipelines
- 17.16 Supplier Artefacts and Third-Party Ingestion
- 17.17 Pipeline Metrics and Steering Committee
- 17.18 Common Failure Modes
- 17.19 Integration with Programme Governance
- 17.20 Figure Production Brief
- 17.21 Apply in Your Organisation
- 17.22 Chapter Summary

### Chapter 18 — FIPS Validation, Testing, and Assurance
- 18.1 Assurance as a Programme Constraint
- 18.2 FIPS 140-3 Module Validation versus Algorithm Validation
- 18.3 The Validation Coverage Matrix
- 18.4 The Test Category Matrix
- 18.5 Building the Validation Programme Plan
- 18.6 CMMC Cryptographic Assurance Context
- 18.7 FedRAMP Cryptographic Assurance Context
- 18.8 DORA, NIS2, and EU Assurance Expectations
- 18.9 Enterprise Test Harness Integration
- 18.10 HSM and KMS Validation Assessment
- 18.11 Interoperability Testing Programme
- 18.12 Performance Testing and Capacity Evidence
- 18.13 Security Testing: Red Team and Penetration Testing for Cryptography
- 18.14 Validation Dependency Timeline
- 18.15 Case Study: Apex Defense CMMC Assessment Evidence Package
- 18.16 Case Study: Meridian DORA Testing Evidence
- 18.17 Case Study: GlobalSync Tenant Assurance
- 18.18 Assembling Evidence Packages
- 18.19 Common Assurance Failures
- 18.20 Cross-Reference Map
- 18.21 Apply in Your Organisation
- 18.22 Chapter Summary

## Part VI — Sector Playbooks and Proof
*ARCS: Proof*

### Introduction
- Introduction
- What Part VI Delivers
- ARCS and PQ-ADAPT Positioning
- Part VI Exit Artefacts
- Prerequisites
- Who Should Read Part VI
- The Teaching Organisations in Part VI
- What Part VI Is and Is Not
- How Part VI Connects to the Book Arc
- Suggested Reading Sequences
- Conventions

### Chapter 19 — Financial Services Playbook
- 19.1 Why Financial Services Differs from Universal Migration
- 19.2 Sector Overlay Matrix — Financial Services
- 19.3 DORA-Aligned PQC Programme Architecture
- 19.4 Payment HSM Certification Cycles
- 19.5 PCI DSS 4.0 and Card Data Environments
- 19.6 SWIFT and Market Infrastructure Dependencies
- 19.7 Banking PQC Architecture Reference
- 19.8 TRADE Rescoring and Wave Sequencing with SOM
- 19.9 Third-Party and Payment Ecosystem Risk
- 19.10 Assurance Integration for Financial Services
- 19.11 Meridian Mutual Bank: Programme Arc Years 1–2
- 19.12 DORA Examination Evidence Pack Structure
- 19.13 Cross-Reference Index
- 19.14 Apply in Your Organisation
- 19.15 Chapter Summary

### Chapter 20 — Defense, Government, and Critical Infrastructure
- 20.1 Sector Context and the Central Argument
- 20.2 CNSA 2.0: The Defence Cryptographic Floor
- 20.3 National Security Systems versus the Defence Industrial Base
- 20.4 Classified and Unclassified Cryptographic Boundaries
- 20.5 CMMC, FedRAMP, and Dual Compliance Architecture
- 20.6 Sector Overlay Matrix — Defense, Government, and Critical Infrastructure
- 20.7 TRADE Weight Modifications and Wave Sequencing
- 20.8 Critical Infrastructure: OT Continuity Constraints
- 20.9 OT/IT Convergence and Cryptographic Divergence
- 20.10 NERC CIP, TSA, and CISA for US Critical Infrastructure
- 20.11 Air-Gapped Signing and Long-Lived Asset Protection
- 20.12 Firmware and Protocol Transition in OT Context
- 20.13 HSM Partition Strategy (Chapter 14 Cross-Reference)
- 20.14 Assurance and Evidence Packages (Chapter 18 Cross-Reference)
- 20.15 Case Study: Apex Defense Technologies — Year 2 Arc
- 20.16 Case Study: Northfield Energy Systems — Year 2 Arc
- 20.17 Unifying Defence and CII Programmes Without Duplication
- 20.18 Common Sector Failure Modes
- 20.19 Cross-Reference Map
- 20.20 Apply in Your Organisation
- 20.21 Chapter Summary

### Chapter 21 — Cloud, SaaS, and Multinational Compliance
- 21.1 Sector Overlay: SaaS and Platform Economics
- 21.2 ARCS Proof and PQ-ADAPT Positioning
- 21.3 Multi-Tenant PQC Architecture
- 21.4 Shared Responsibility Model
- 21.5 BYOK, HYOK, and Tenant Key Custody
- 21.6 Cloud Provider Capability Comparison Framework
- 21.7 Three-Region Programme Design
- 21.8 GDPR Cross-Border Evidence
- 21.9 CI/CD Gates and Platform Engineering Integration
- 21.10 Procurement, Tenant Contracts, and Cloud Concentration
- 21.11 TRADE, Wave Planning, and Partner Ecosystem
- 21.12 Tenant Assurance Packs and Year 2–3 Programme Arc
- 21.13 Sector Overlay Summary Table
- 21.14 Integration with Prior Chapters
- 21.15 Figure Production Briefs
- 21.16 Apply in Your Organisation
- 21.17 Chapter Summary

### Chapter 22 — Sustaining Quantum Resilience
- 22.1 Migration Ends in Capability, Not Deployment
- 22.2 ARCS Synthesis: From Awareness to Sustained Proof
- 22.3 PQ-ADAPT Levels 4 and 5: Transitioning to Quantum-Resilient
- 22.4 PQ-ADAPT Full Maturity Model
- 22.5 The Continuous Quantum Resilience Loop
- 22.6 Organisational Learning Loops
- 22.7 Standards Watch and Horizon Management
- 22.8 FN-DSA and HQC Contingency Planning
- 22.9 Year 3 Retrospective: Four Organisations
- 22.10 Lessons Learned Synthesis Across Four Cases
- 22.11 Sustaining the Governance Stack at Level 5
- 22.12 CRQC Timeline Updates Without Panic or Complacency
- 22.13 Apply in Your Organisation
- 22.14 Chapter Summary

## Appendices

### Appendix A — CBOM and CDG Templates
- CycloneDX-Aligned Programme Artefacts
- A.1 CBOM Programme Minimum Schema
- A.2 CycloneDX CBOM Export Example (Illustrative)
- A.3 CBOM Quality Scorecard Template
- A.4 CDG Node and Edge Schema
- A.5 CDG JSON Graph Export Example (Illustrative)
- A.6 Blocking Node Register Template
- A.7 CDG Construction Worksheet (Phase A–D)
- A.8 Merge Rules: CBOM ↔ CDG
- A.9 Access Control and Classification

### Appendix B — PQ-ADAPT Self-Assessment Questionnaire
- Maturity Assessment with Evidence Index
- B.1 Assessment Metadata
- B.2 Level 0 → Level 1 (*Unaware* → *Alerted*)
- B.3 Level 1 → Level 2 (*Alerted* → *Inventoried*)
- B.4 Level 2 → Level 3 (*Inventoried* → *Architected*)
- B.5 Level 3 → Level 4 (*Architected* → *Transitioning*)
- B.6 Level 4 → Level 5 (*Transitioning* → *Quantum-Resilient*)
- B.7 Zone Aggregation Worksheet
- B.8 Evidence Index Template
- B.9 Assessor Attestation

### Appendix C — Regulatory Mapping Matrix
- DORA, NIS2, GDPR, PCI, and US Federal Overlays
- C.1 Matrix Structure
- C.2 Programme Artefact × Regulatory Instrument Matrix
- C.3 Jurisdiction Overlay Annotation Template
- C.4 Supervisory Examination Question Map (Financial Services)
- C.5 Regulatory Supplements
- C.6 Matrix Maintenance Cadence

### Appendix D — Migration Programme Charter Template
- Board-Approved Programme Authority Document
- D.1 Charter Cover Sheet
- D.2 Section 1 — Purpose and Scope
- D.3 Section 2 — Regulatory and Sector Overlay
- D.4 Section 3 — Organisational Authority
- D.5 Section 4 — Governance Structure
- D.6 Section 5 — Wave Plan and Dependencies
- D.7 Section 6 — Funding Envelope
- D.8 Section 7 — KPI Framework
- D.9 Section 8 — RACI and Accountability
- D.10 Section 9 — Assurance Integration
- D.11 Section 10 — Review and Amendment
- D.12 Annex D-3 — Third-Party Contract Exhibit Pointer
- D.13 Signatures

### Appendix E — Glossary and Standards Quick Reference
- E.1 Glossary
- E.2 Algorithm Quick Reference
- E.3 Standards and Documents Quick Reference
- E.4 HLM Phase Quick Reference
- E.5 PQ-ADAPT Level Quick Reference
- E.6 Programme Artefact Index

## Back Matter

- References
- Index

---

## Framework Index

| Framework | Introduced | Developed |
|-----------|------------|-----------|
| **ARCS** (Awareness → Register → Capability → Synchronize) | Ch 1 | All parts |
| **PQ-ADAPT** (Levels 0–5) | Ch 7 | Ch 5, 10, 15, 22, App B |
| **TRADE / MPI** | Ch 2 | Ch 9, Parts V–VI |
| **CBOM** | Ch 7 | Ch 8–18, App A |
| **CDG** | Ch 8 | Ch 11–14, App A |
| **HLM** (H1 → H2 → H3) | Ch 5 | Ch 11–12, App E |
| **PQC Governance Stack** | Ch 3 | Ch 10, 15, 22 |
| **SOM** (Sector Overlay Modifiers) | Ch 9 | Ch 19–21 |

## Manuscript Statistics

- **Total words (manuscript + appendices):** ~188,620
- **Numbered sections:** 684
- **Chapters:** 22 + 6 part introductions
- **Appendices:** 5 (A–E)
