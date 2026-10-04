// The demo's Kestrel developers list: git format-patch mail and review
// replies. Hunk headers match their lines; indentation uses real tabs.

/// The cover letter of the header cache series.
const kestrelCoverLetter = r'''
This series caches the parsed request headers per connection, so
keep-alive requests that repeat them skip the parser. On the
benchmark in tools/bench, keep-alive throughput goes up by 18%.

Changes in v2:
- LRU eviction instead of round robin
- the connection frees the cache, not the headers
- tests

v1: https://lists.example.org/archives/list/dev@lists.example.org/thread/K3STR3L/

Ines Duarte (3):
  cache: add a small LRU for parsed headers
  http: reuse cached headers on keep-alive connections
  tests: cover the header cache

 src/hdrcache.h        | 16 ++++++++++++++++
 src/hdrcache.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 Makefile              |  1 +
 src/http.c            | 13 +++++++++----
 tests/test_hdrcache.c | 26 ++++++++++++++++++++++++++
 tests/Makefile        |  1 +
 6 files changed, 95 insertions(+), 4 deletions(-)
 create mode 100644 src/hdrcache.c
 create mode 100644 src/hdrcache.h
 create mode 100644 tests/test_hdrcache.c

-- 
2.47.0
''';

/// Patch 1/3: two new files and a Makefile change.
const kestrelPatch1 = r'''
Parsing the request headers is a third of the time a keep-alive request
spends in kestrel, and most clients send the same block again and again.
Add a small per-connection cache keyed by a hash of the raw block.

Nothing uses it yet; the next patch does.

Signed-off-by: Ines Duarte <ines@kestrel.example>
---
v2:
 - least recently used eviction instead of round robin (Oskar)
 - compare lengths before trusting the hash

 src/hdrcache.h | 16 ++++++++++++++++
 src/hdrcache.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 Makefile       |  1 +
 3 files changed, 59 insertions(+)
 create mode 100644 src/hdrcache.c
 create mode 100644 src/hdrcache.h

diff --git a/src/hdrcache.h b/src/hdrcache.h
new file mode 100644
index 0000000..b3c41e2
--- /dev/null
+++ b/src/hdrcache.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+#ifndef KESTREL_HDRCACHE_H
+#define KESTREL_HDRCACHE_H
+
+#include <stddef.h>
+#include "http.h"
+
+/* A few parsed header blocks per connection, least recently used out. */
+struct hdrcache;
+
+struct hdrcache *hdrcache_new(size_t slots);
+void hdrcache_free(struct hdrcache *c);
+const struct http_headers *hdrcache_get(struct hdrcache *c, const char *raw, size_t len);
+void hdrcache_put(struct hdrcache *c, const char *raw, size_t len, struct http_headers *h);
+
+#endif
diff --git a/src/hdrcache.c b/src/hdrcache.c
new file mode 100644
index 0000000..5f0a9d7
--- /dev/null
+++ b/src/hdrcache.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: MIT
+#include <stdlib.h>
+#include <string.h>
+#include "hdrcache.h"
+#include "hash.h"
+
+struct slot {
+	uint64_t hash;
+	size_t len;
+	struct http_headers *headers;
+	unsigned long used;
+};
+
+struct hdrcache {
+	size_t nslots;
+	unsigned long clock;
+	struct slot slots[];
+};
+
+struct hdrcache *hdrcache_new(size_t slots)
+{
+	struct hdrcache *c = calloc(1, sizeof(*c) + slots * sizeof(c->slots[0]));
+
+	if (c)
+		c->nslots = slots;
+	return c;
+}
+
+const struct http_headers *hdrcache_get(struct hdrcache *c, const char *raw, size_t len)
+{
+	uint64_t h = hash64(raw, len);
+
+	for (size_t i = 0; i < c->nslots; i++) {
+		struct slot *s = &c->slots[i];
+
+		if (s->headers && s->hash == h && s->len == len) {
+			s->used = ++c->clock;
+			return s->headers;
+		}
+	}
+	return NULL;
+}
diff --git a/Makefile b/Makefile
index 8e21f0c..d94b7a1 100644
--- a/Makefile
+++ b/Makefile
@@ -12,4 +12,5 @@ CFLAGS += -Wall -Wextra
 SRCS = src/main.c \
 	src/http.c \
+	src/hdrcache.c \
 	src/log.c \
 	src/hash.c
-- 
2.47.0
''';

/// Patch 2/3: three hunks in one file.
const kestrelPatch2 = r'''
Look the raw header block up in the connection's cache before parsing
it, and keep what we parsed for the next request. The cache owns the
parsed headers now, so the connection frees the cache instead.

Signed-off-by: Ines Duarte <ines@kestrel.example>
---
v2: free the cache in conn_free() (Oskar)

 src/http.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/http.c b/src/http.c
index 4a7be01..c9e3d52 100644
--- a/src/http.c
+++ b/src/http.c
@@ -9,4 +9,5 @@
 #include "http.h"
 #include "log.h"
+#include "hdrcache.h"
 
 #define MAX_HEADER_BYTES (16 * 1024)
@@ -214,10 +215,14 @@ static void conn_reset(struct conn *conn)
 static int parse_request(struct conn *conn, struct request *req)
 {
 	struct http_headers *h;
 
-	h = http_parse_headers(conn->buf, conn->hdr_len);
-	if (!h)
-		return -EINVAL;
+	h = (struct http_headers *)hdrcache_get(conn->cache, conn->buf, conn->hdr_len);
+	if (!h) {
+		h = http_parse_headers(conn->buf, conn->hdr_len);
+		if (!h)
+			return -EINVAL;
+		hdrcache_put(conn->cache, conn->buf, conn->hdr_len, h);
+	}
 	req->headers = h;
 	return 0;
 }
@@ -301,7 +307,7 @@
 void conn_free(struct conn *conn)
 {
 	close(conn->fd);
-	http_free_headers(conn->req.headers);
+	hdrcache_free(conn->cache);
 	free(conn->buf);
 	free(conn);
 }
-- 
2.47.0
''';

/// Patch 3/3: a new test file.
const kestrelPatch3 = r'''
Cover hits, misses and eviction of the header cache.

Signed-off-by: Ines Duarte <ines@kestrel.example>
---
 tests/test_hdrcache.c | 26 ++++++++++++++++++++++++++
 tests/Makefile        |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 tests/test_hdrcache.c

diff --git a/tests/test_hdrcache.c b/tests/test_hdrcache.c
new file mode 100644
index 0000000..1d2e3f4
--- /dev/null
+++ b/tests/test_hdrcache.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: MIT
+#include "test.h"
+#include "../src/hdrcache.h"
+
+static const char raw[] = "Host: example.org\r\nAccept: */*\r\n";
+
+TEST(hdrcache_hit_after_put)
+{
+	struct hdrcache *c = hdrcache_new(4);
+	struct http_headers *h = http_parse_headers(raw, sizeof(raw) - 1);
+
+	ASSERT_NULL(hdrcache_get(c, raw, sizeof(raw) - 1));
+	hdrcache_put(c, raw, sizeof(raw) - 1, h);
+	ASSERT_PTR_EQ(hdrcache_get(c, raw, sizeof(raw) - 1), h);
+	hdrcache_free(c);
+}
+
+TEST(hdrcache_evicts_least_recently_used)
+{
+	struct hdrcache *c = hdrcache_new(1);
+
+	hdrcache_put(c, "a", 1, http_parse_headers("a", 1));
+	hdrcache_put(c, "b", 1, http_parse_headers("b", 1));
+	ASSERT_NULL(hdrcache_get(c, "a", 1));
+	hdrcache_free(c);
+}
diff --git a/tests/Makefile b/tests/Makefile
index 0c1d2e3..4f5a6b7 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -3,2 +3,3 @@
 TESTS = test_http \
+	test_hdrcache \
 	test_log
-- 
2.47.0
''';

/// A review of patch 2/3 that quotes hunks between comments.
const kestrelReview = r'''
On Thu, Ines Duarte wrote:
> The cache owns the parsed headers now, so the connection frees the
> cache instead.
>
> diff --git a/src/http.c b/src/http.c
> index 4a7be01..c9e3d52 100644
> --- a/src/http.c
> +++ b/src/http.c
> @@ -214,10 +215,14 @@ static void conn_reset(struct conn *conn)
>  static int parse_request(struct conn *conn, struct request *req)
>  {
>  	struct http_headers *h;
>  
> -	h = http_parse_headers(conn->buf, conn->hdr_len);
> -	if (!h)
> -		return -EINVAL;
> +	h = (struct http_headers *)hdrcache_get(conn->cache, conn->buf, conn->hdr_len);
> +	if (!h) {
> +		h = http_parse_headers(conn->buf, conn->hdr_len);

The cast drops the const that hdrcache_get() promises. If a later
request modifies req->headers (we do, in rewrite_host()), every
connection sharing the slot sees it. Either return a copy or make
rewrite_host() copy on write.

> +		if (!h)
> +			return -EINVAL;
> +		hdrcache_put(conn->cache, conn->buf, conn->hdr_len, h);

What happens when hdrcache_put() fails to find a free slot while all
are in use by this very request? I think it evicts h itself.

> -	http_free_headers(conn->req.headers);
> +	hdrcache_free(conn->cache);

Nice, that also fixes the double free from #212.

Oskar
''';

/// The author answers, quoting the review that quotes the patch.
const kestrelReviewAnswer = r'''
On Fri, Oskar Lind wrote:
> On Thu, Ines Duarte wrote:
> > -	h = http_parse_headers(conn->buf, conn->hdr_len);
> > -	if (!h)
> > -		return -EINVAL;
>
> The cast drops the const that hdrcache_get() promises. If a later
> request modifies req->headers (we do, in rewrite_host()), every
> connection sharing the slot sees it.

Good catch. rewrite_host() will copy on write in v3, and the cast goes
away.

> What happens when hdrcache_put() fails to find a free slot while all
> are in use by this very request?

It evicts the oldest slot, never the one just returned: put() runs
after get() bumped its clock. I will add a test for it.

Ines
''';

/// A lone documentation patch.
const kestrelDocsPatch = r'''
The value is a plain number of seconds; "75s" fails to parse since the
config rewrite.

Signed-off-by: Yuki Tanabe <yuki.tanabe@example.net>
---
 docs/config.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/config.md b/docs/config.md
index 77aa1b2..88bb2c3 100644
--- a/docs/config.md
+++ b/docs/config.md
@@ -41,7 +41,7 @@ server.listen
 ## Keep-alive
 
 Idle connections close after `keepalive_timeout` seconds:
 
 ```
-keepalive_timeout = 75s
+keepalive_timeout = 75
 ```
-- 
2.47.0
''';
