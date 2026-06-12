#!/usr/bin/env bash
# Build per-chapter and combined Word (.docx) exports from manuscript markdown.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="$ROOT/docx"
CHAPTERS_DIR="$OUT_DIR/chapters"
COMBINED="$OUT_DIR/Post-Quantum-Cryptography-Enterprise-Migration-Handbook-COMPLETE.docx"
TOC_DOC="$OUT_DIR/Table-of-Contents.docx"

mkdir -p "$CHAPTERS_DIR"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "Error: pandoc is required. Install with: apt-get install pandoc" >&2
  exit 1
fi

# Book order: part intro, then chapters, per part; then appendices.
FILES=(
  "TABLE_OF_CONTENTS.md"
  "part-01-imperative/part-01-introduction.md"
  "part-01-imperative/chapter-01-synchronization-problem.md"
  "part-01-imperative/chapter-02-threat-models.md"
  "part-01-imperative/chapter-03-regulatory-landscape.md"
  "part-02-standards/part-02-introduction.md"
  "part-02-standards/chapter-04-nist-competition-to-fips.md"
  "part-02-standards/chapter-05-transition-timelines-hybrid-policy.md"
  "part-02-standards/chapter-06-stateful-signatures-firmware.md"
  "part-03-estate/part-03-introduction.md"
  "part-03-estate/chapter-07-cryptographic-discovery-cbom.md"
  "part-03-estate/chapter-08-cryptographic-dependency-graph.md"
  "part-03-estate/chapter-09-risk-tiering-wave-planning.md"
  "part-04-architecture/part-04-introduction.md"
  "part-04-architecture/chapter-10-cryptographic-agility.md"
  "part-04-architecture/chapter-11-hybrid-deployment-patterns.md"
  "part-04-architecture/chapter-12-protocol-transition.md"
  "part-04-architecture/chapter-13-pki-evolution-certificate-lifecycle.md"
  "part-04-architecture/chapter-14-key-management-hsm-cloud.md"
  "part-05-programme/part-05-introduction.md"
  "part-05-programme/chapter-15-programme-governance-operating-model.md"
  "part-05-programme/chapter-16-procurement-contracts-third-party-risk.md"
  "part-05-programme/chapter-17-software-supply-chain-embedded-cryptography.md"
  "part-05-programme/chapter-18-fips-validation-testing-assurance.md"
  "part-06-sector/part-06-introduction.md"
  "part-06-sector/chapter-19-financial-services-playbook.md"
  "part-06-sector/chapter-20-defense-government-critical-infrastructure.md"
  "part-06-sector/chapter-21-cloud-saas-multinational-compliance.md"
  "part-06-sector/chapter-22-sustaining-quantum-resilience.md"
  "appendices/appendix-a-cbom-cdg-templates.md"
  "appendices/appendix-b-pq-adapt-self-assessment.md"
  "appendices/appendix-c-regulatory-mapping-matrix.md"
  "appendices/appendix-d-migration-programme-charter-template.md"
  "appendices/appendix-e-glossary-standards-reference.md"
)

PANDOC_OPTS=(
  --from markdown
  --to docx
  --standalone
)

echo "Building individual chapter .docx files..."
for rel in "${FILES[@]}"; do
  src="$ROOT/$rel"
  if [[ ! -f "$src" ]]; then
    echo "  SKIP (missing): $rel" >&2
    continue
  fi
  base="$(basename "$rel" .md)"
  dest="$CHAPTERS_DIR/${base}.docx"
  pandoc "${PANDOC_OPTS[@]}" "$src" -o "$dest"
  echo "  $dest"
done

echo ""
echo "Building Table of Contents..."
pandoc "${PANDOC_OPTS[@]}" "$ROOT/TABLE_OF_CONTENTS.md" -o "$TOC_DOC"

echo ""
echo "Building combined handbook..."
COMBINED_INPUTS=()
for rel in "${FILES[@]}"; do
  src="$ROOT/$rel"
  [[ -f "$src" ]] && COMBINED_INPUTS+=("$src")
done
pandoc "${PANDOC_OPTS[@]}" "${COMBINED_INPUTS[@]}" -o "$COMBINED"

echo ""
echo "Done."
echo "  Chapters:  $CHAPTERS_DIR/ ($(ls -1 "$CHAPTERS_DIR" | wc -l) files)"
echo "  Combined:  $COMBINED ($(du -h "$COMBINED" | cut -f1))"
echo "  TOC only:  $TOC_DOC"
