# Device spike: Gemma 4 E2B on the S23 Ultra (prepared, not yet run)

Status 2026-10-30, 01:30: everything is in place to run the spike; nothing has
been downloaded to or installed on the phone yet. Picking this up is a
one-session job.

## What was established

- Phone: Samsung SM-S918B (S23 Ultra), **12 GB** variant (11.3 GB reported),
  Android 16, Snapdragon 8 Gen 2 (`kalama`), arm64-v8a, 84 GB free in
  `/data`, `curl` on board (`/system/bin/curl`), so the model can be
  downloaded straight to the phone over its own Wi-Fi.
- Model: `litert-community/gemma-4-E2B-it-litert-lm` on Hugging Face is **not
  gated**; `gemma-4-E2B-it.litertlm` is 2,588,147,712 bytes (2.41 GiB), direct
  URL `https://huggingface.co/litert-community/gemma-4-E2B-it-litert-lm/resolve/main/gemma-4-E2B-it.litertlm`.
  Variants `-gpu` and `-web` exist in the same repo.
- Runtime: LiteRT-LM is at v0.18.1. The plan is its CLI, not an app: push a
  prebuilt Android arm64 `litert_lm_main` (or build it) to
  `/data/local/tmp`, run the exact prompts below on `--backend=cpu` and
  `--backend=gpu`, and sample memory while it runs. The latest release's
  asset list did not show an Android binary by name; check the releases page
  or build from source before pushing anything.
- Prompts: the exact text the tasks generate (`SearchTranslationTask` for
  "unread from dana with attachments since september" and `BriefTask` for the
  synthetic mortgage message) is produced by `tool/spike/prompts.dart` below;
  the output must then be run back through the tasks' parsers on the Mac,
  which is the only quality check that counts.

## How to run it

1. `cd /data/local/tmp && curl -L -o gemma-4-E2B-it.litertlm <url above>` on
   the phone (`adb -s 100.65.182.120:5555 shell`). Keep it on USB power.
2. `adb push litert_lm_main /data/local/tmp/ && adb shell chmod +x /data/local/tmp/litert_lm_main`.
3. `tool/spike/run_phone.sh cpu` then `gpu`: times cold load, warm latency
   and tokens/s for both prompts, and records peak RSS from `/proc/<pid>/status`.
4. Feed each answer to `dart run tool/spike/check.dart <task> <answer-file>`
   to see whether the task's parser accepts it, and what it rejects.
5. Write the numbers into PLAN-combined.md's device table, which says
   "before measurement" for every row.

## Measure, in this order

cold load time; time to first token and tokens/s per backend; peak RSS and
whether the phone stays responsive; battery/thermal over ten runs; whether
the search answer parses first time and after one repair; whether the Brief
answer passes the fixture rules (five items, app-only channel kept, no
password, conditional timing not turned into a date).

## Phone settings touched tonight

To keep ADB over Tailscale reachable: Doze disabled (`dumpsys deviceidle
disable`), stay-awake-while-charging on, brightness set low with adaptive
brightness off. All of these were restored at the end of the session.
