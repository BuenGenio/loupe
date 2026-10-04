#!/usr/bin/env bash
# Runs GreenMail standalone with plain Java (no Docker needed).
# Usage: tool/test-servers/greenmail.sh start|stop|status|env
# All files (jar, pid, log) stay in tool/test-servers/data/greenmail/ (gitignored).
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
data="$here/data/greenmail"
version="${GREENMAIL_VERSION:-2.1.14}"
jar="$data/greenmail-standalone-$version.jar"
pidfile="$data/greenmail.pid"
log="$data/greenmail.log"
url="https://repo1.maven.org/maven2/com/icegreen/greenmail-standalone/$version/greenmail-standalone-$version.jar"

running() { [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; }

case "${1:-}" in
  start)
    if running; then echo "GreenMail already running (pid $(cat "$pidfile"))"; exit 0; fi
    mkdir -p "$data"
    if [ ! -f "$jar" ]; then
      echo "Downloading GreenMail $version"
      curl -sSfL -o "$jar.part" "$url"
      expected="$(curl -sSfL "$url.sha1" | cut -c1-40)"
      actual="$(sha1sum "$jar.part" | cut -c1-40)"
      [ "$expected" = "$actual" ] || { echo "Checksum mismatch for $jar" >&2; rm -f "$jar.part"; exit 1; }
      mv "$jar.part" "$jar"
    fi
    # Ports: SMTP 3025, SMTPS 3465, IMAP 3143, IMAPS 3993 (self-signed certificate).
    nohup java -Xmx128m \
      -Dgreenmail.setup.test.smtp -Dgreenmail.setup.test.smtps \
      -Dgreenmail.setup.test.imap -Dgreenmail.setup.test.imaps \
      -Dgreenmail.hostname=127.0.0.1 \
      -Dgreenmail.users=alice:secret@example.test,bob:secret@example.test \
      -Dgreenmail.users.login=email \
      -jar "$jar" >"$log" 2>&1 &
    echo $! >"$pidfile"
    for _ in $(seq 1 60); do
      if (exec 3<>/dev/tcp/127.0.0.1/3143) 2>/dev/null; then echo "GreenMail running (pid $(cat "$pidfile"))"; exit 0; fi
      sleep 0.5
    done
    echo "GreenMail did not start; see $log" >&2
    exit 1
    ;;
  stop)
    if running; then kill "$(cat "$pidfile")"; echo "GreenMail stopped"; fi
    rm -f "$pidfile"
    ;;
  status)
    if running; then echo "running (pid $(cat "$pidfile"))"; else echo "stopped"; fi
    ;;
  env)
    cat <<'EOF'
export LOUPE_TEST_IMAP_HOST=127.0.0.1
export LOUPE_TEST_IMAP_PORT=3143
export LOUPE_TEST_IMAP_SECURITY=none
export LOUPE_TEST_SMTP_PORT=3025
export LOUPE_TEST_SMTP_SECURITY=none
export LOUPE_TEST_IMAPS_PORT=3993
export LOUPE_TEST_SMTPS_PORT=3465
EOF
    ;;
  *)
    echo "usage: $0 start|stop|status|env" >&2
    exit 2
    ;;
esac
