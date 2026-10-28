#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_answer_shaper info
PYTHONPATH=src python -m gbt_answer_shaper check --payload '{}'
PYTHONPATH=src python -m gbt_answer_shaper run   --payload '{}'
