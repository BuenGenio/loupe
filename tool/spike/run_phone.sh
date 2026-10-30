#!/usr/bin/env bash
# Runs the two spike prompts on the phone with the LiteRT-LM CLI and prints
# timings and peak memory. Usage: tool/spike/run_phone.sh cpu|gpu
# Expects /data/local/tmp/litert_lm_main and /data/local/tmp/gemma-4-E2B-it.litertlm
# on the device (see docs/plan/research/device-spike-2026-10-30.md), and the
# prompts in tool/spike/out/ (dart run tool/spike/prompts.dart tool/spike/out).
# The CLI's flag names should be confirmed against its --help before relying
# on this: they were not verified on a device when this was written.
set -euo pipefail
backend=${1:-cpu}
device=${ADB_DEVICE:-100.65.182.120:5555}
cd "$(dirname "$0")"
for name in search brief; do
  adb -s "$device" push "out/$name.prompt.txt" /data/local/tmp/prompt.txt >/dev/null
  echo "== $name on $backend"
  adb -s "$device" shell "cd /data/local/tmp && start=\$(date +%s%N); ./litert_lm_main --backend=$backend --model_path=gemma-4-E2B-it.litertlm --input_prompt=\"\$(cat prompt.txt)\" > answer.$name.$backend.txt 2> log.$name.$backend.txt & pid=\$!; peak=0; while kill -0 \$pid 2>/dev/null; do rss=\$(awk '/VmHWM/{print \$2}' /proc/\$pid/status 2>/dev/null || echo 0); [ \"\$rss\" -gt \"\$peak\" ] && peak=\$rss; sleep 0.5; done; end=\$(date +%s%N); echo \"wall \$(( (end-start)/1000000 )) ms, peak RSS \$((peak/1024)) MB\""
  adb -s "$device" pull "/data/local/tmp/answer.$name.$backend.txt" "out/" >/dev/null
done
