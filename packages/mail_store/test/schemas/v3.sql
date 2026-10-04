-- The schema of version 3 (version 2 plus the mailing-list columns and index,
-- muted threads and stale headers, as StoreDatabase created it), for the
-- migration tests. Statements are separated by lines holding only "--".
--
CREATE TABLE "accounts" ("id" TEXT NOT NULL, "email" TEXT NOT NULL, "display_name" TEXT NOT NULL, "json" TEXT NOT NULL, "sort_order" INTEGER NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
--
CREATE TABLE "mailboxes" ("id" TEXT NOT NULL, "account_id" TEXT NOT NULL REFERENCES accounts (id) ON DELETE CASCADE, "name" TEXT NOT NULL, "path" TEXT NOT NULL, "role" TEXT NOT NULL, "parent_id" TEXT NULL, "unread_count" INTEGER NOT NULL DEFAULT 0, "total_count" INTEGER NOT NULL DEFAULT 0, "is_selectable" INTEGER NOT NULL DEFAULT 1 CHECK ("is_selectable" IN (0, 1)), "is_subscribed" INTEGER NOT NULL DEFAULT 1 CHECK ("is_subscribed" IN (0, 1)), "sort_order" INTEGER NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
--
CREATE TABLE "sync_states" ("mailbox_id" TEXT NOT NULL REFERENCES mailboxes (id) ON DELETE CASCADE, "state" TEXT NOT NULL, "has_older" INTEGER NOT NULL DEFAULT 0 CHECK ("has_older" IN (0, 1)), "synced_at" INTEGER NOT NULL, "stale_headers" INTEGER NOT NULL DEFAULT 0 CHECK ("stale_headers" IN (0, 1)), PRIMARY KEY ("mailbox_id"));
--
CREATE TABLE "emails" ("seq" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "id" TEXT NOT NULL UNIQUE, "account_id" TEXT NOT NULL, "mailbox_id" TEXT NOT NULL REFERENCES mailboxes (id) ON DELETE CASCADE, "thread_id" TEXT NOT NULL, "message_id_header" TEXT NULL, "in_reply_to" TEXT NULL, "references_json" TEXT NOT NULL DEFAULT '[]', "from_json" TEXT NOT NULL DEFAULT '[]', "to_json" TEXT NOT NULL DEFAULT '[]', "cc_json" TEXT NOT NULL DEFAULT '[]', "bcc_json" TEXT NOT NULL DEFAULT '[]', "reply_to_json" TEXT NOT NULL DEFAULT '[]', "from_email" TEXT NOT NULL DEFAULT '', "subject" TEXT NOT NULL DEFAULT '', "base_subject" TEXT NOT NULL DEFAULT '', "preview" TEXT NOT NULL DEFAULT '', "received_at" INTEGER NOT NULL, "sent_at" INTEGER NULL, "size" INTEGER NOT NULL DEFAULT 0, "keywords" TEXT NOT NULL DEFAULT '[]', "is_seen" INTEGER NOT NULL DEFAULT 0 CHECK ("is_seen" IN (0, 1)), "is_flagged" INTEGER NOT NULL DEFAULT 0 CHECK ("is_flagged" IN (0, 1)), "has_attachment" INTEGER NOT NULL DEFAULT 0 CHECK ("has_attachment" IN (0, 1)), "list_id" TEXT NULL, "list_name" TEXT NULL, "list_post" TEXT NULL, "list_unsubscribe" TEXT NULL, "list_unsubscribe_post" TEXT NULL);
--
CREATE TABLE "email_keywords" ("email_id" TEXT NOT NULL REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE, "keyword" TEXT NOT NULL, PRIMARY KEY ("email_id", "keyword"));
--
CREATE TABLE "contents" ("email_id" TEXT NOT NULL REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE, "html" TEXT NULL, "plain_text" TEXT NULL, "is_flowed" INTEGER NOT NULL DEFAULT 0 CHECK ("is_flowed" IN (0, 1)), "headers_json" TEXT NOT NULL DEFAULT '[]', "attachments_json" TEXT NOT NULL DEFAULT '[]', "body_text" TEXT NOT NULL DEFAULT '', "fetched_at" INTEGER NOT NULL, PRIMARY KEY ("email_id"));
--
CREATE TABLE "inline_parts" ("email_id" TEXT NOT NULL REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE, "content_id" TEXT NOT NULL, "data" BLOB NOT NULL, PRIMARY KEY ("email_id", "content_id"));
--
CREATE TABLE "outbox_items" ("id" TEXT NOT NULL, "account_id" TEXT NOT NULL REFERENCES accounts (id) ON DELETE CASCADE, "message" TEXT NOT NULL, "send_after" INTEGER NOT NULL, "status" TEXT NOT NULL, "attempts" INTEGER NOT NULL DEFAULT 0, "last_error" TEXT NULL, "created_at" INTEGER NOT NULL, PRIMARY KEY ("id"));
--
CREATE TABLE "pending_ops" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "account_id" TEXT NOT NULL REFERENCES accounts (id) ON DELETE CASCADE, "type" TEXT NOT NULL, "payload" TEXT NOT NULL, "attempts" INTEGER NOT NULL DEFAULT 0, "next_attempt_at" INTEGER NOT NULL, "created_at" INTEGER NOT NULL, "last_error" TEXT NULL);
--
CREATE TABLE "vip_addresses" ("email" TEXT NOT NULL, PRIMARY KEY ("email"));
--
CREATE TABLE "address_book" ("email" TEXT NOT NULL, "name" TEXT NULL, "seen_count" INTEGER NOT NULL DEFAULT 0, "sent_count" INTEGER NOT NULL DEFAULT 0, "last_used_at" INTEGER NOT NULL, PRIMARY KEY ("email"));
--
CREATE TABLE "thread_refs" ("account_id" TEXT NOT NULL REFERENCES accounts (id) ON DELETE CASCADE, "message_id" TEXT NOT NULL, "thread_id" TEXT NOT NULL, PRIMARY KEY ("account_id", "message_id"));
--
CREATE TABLE "id_aliases" ("old_id" TEXT NOT NULL, "new_id" TEXT NOT NULL, PRIMARY KEY ("old_id"));
--
CREATE TABLE "rules" ("id" TEXT NOT NULL, "json" TEXT NOT NULL, "sort_order" INTEGER NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
--
CREATE TABLE "rule_watermarks" ("mailbox_id" TEXT NOT NULL REFERENCES mailboxes (id) ON DELETE CASCADE, "seq" INTEGER NOT NULL, "uid_validity" INTEGER NULL, "uid" INTEGER NULL, PRIMARY KEY ("mailbox_id"));
--
CREATE TABLE "muted_threads" ("account_id" TEXT NOT NULL REFERENCES accounts (id) ON DELETE CASCADE, "thread_id" TEXT NOT NULL, "muted_at" INTEGER NOT NULL, PRIMARY KEY ("account_id", "thread_id"));
--
CREATE INDEX emails_mailbox_received ON emails (mailbox_id, received_at);
--
CREATE INDEX emails_received ON emails (received_at);
--
CREATE INDEX emails_thread ON emails (account_id, thread_id);
--
CREATE INDEX emails_message_id ON emails (account_id, message_id_header);
--
CREATE INDEX emails_base_subject ON emails (account_id, base_subject, received_at);
--
CREATE INDEX emails_from ON emails (from_email);
--
CREATE INDEX emails_list ON emails (list_id, received_at);
--
CREATE INDEX email_keywords_keyword ON email_keywords (keyword);
--
CREATE VIRTUAL TABLE email_fts USING fts5(subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments, content='', contentless_delete=1,
  tokenize='unicode61 remove_diacritics 2', prefix='2 3');
--
CREATE TRIGGER emails_after_insert AFTER INSERT ON emails BEGIN
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, e.subject, (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id WHERE e.seq = new.seq;
  INSERT OR IGNORE INTO email_keywords(email_id, keyword) SELECT new.id, value FROM json_each(new.keywords);
END;
--
CREATE TRIGGER emails_after_update_text AFTER UPDATE OF subject, from_json, to_json, cc_json, bcc_json, preview
ON emails BEGIN
  DELETE FROM email_fts WHERE rowid = old.seq;
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, e.subject, (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id WHERE e.seq = new.seq;
END;
--
CREATE TRIGGER emails_after_update_keywords AFTER UPDATE OF keywords ON emails BEGIN
  DELETE FROM email_keywords WHERE email_id = new.id;
  INSERT OR IGNORE INTO email_keywords(email_id, keyword) SELECT new.id, value FROM json_each(new.keywords);
END;
--
CREATE TRIGGER emails_after_delete AFTER DELETE ON emails BEGIN
  DELETE FROM email_fts WHERE rowid = old.seq;
END;
--
CREATE TRIGGER contents_after_insert AFTER INSERT ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = new.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, e.subject, (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id WHERE e.id = new.email_id;
END;
--
CREATE TRIGGER contents_after_update AFTER UPDATE OF body_text, attachments_json ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = new.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, e.subject, (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id WHERE e.id = new.email_id;
END;
--
CREATE TRIGGER contents_after_delete AFTER DELETE ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = old.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, e.subject, (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id WHERE e.id = old.email_id;
END;
--
