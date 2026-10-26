#!/usr/bin/env bash

set -uo pipefail

cd "$(dirname "$0")/.." || exit 1

QUESTION="Physical AIとは何ですか？"
LOG="lectures/01/basic_log.txt"
MODELS=(
  gemini-3.1-flash-lite
  gemini-3.5-flash-lite
  gemini-3.6-flash
  gemini-3.8-flash
)

for model in "${MODELS[@]}"; do
  for run in 1 2 3; do
    printf "\n===== %s / run %s =====\n" "$model" "$run" | tee -a "$LOG"
    if ! AIE_MODEL="$model" uv run python -m app.ask "$QUESTION" 2>&1 | tee -a "$LOG"; then
      printf "[実行失敗] %s / run %s\n" "$model" "$run" | tee -a "$LOG"
    fi
    sleep 15
  done
done
