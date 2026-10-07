-- The schema of version 7 (version 6 plus the Subscriptions cache made again with
-- what classifying lists reads, and list_kinds, as StoreDatabase created it), for the
-- migration tests. Statements are separated by lines holding only "--".
--
CREATE TABLE "accounts" ("id" TEXT NOT NULL, "email" TEXT NOT NULL, "display_name" TEXT NOT NULL, "json" TEXT NOT NULL, "sort_order" INTEGER NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
--
CREATE TABLE "mailboxes" ("id" TEXT NOT NULL, "account_id" TEXT NOT NULL REFERENCES accounts (id) ON DELETE CASCADE, "name" TEXT NOT NULL, "path" TEXT NOT NULL, "role" TEXT NOT NULL, "parent_id" TEXT NULL, "unread_count" INTEGER NOT NULL DEFAULT 0, "total_count" INTEGER NOT NULL DEFAULT 0, "is_selectable" INTEGER NOT NULL DEFAULT 1 CHECK ("is_selectable" IN (0, 1)), "is_subscribed" INTEGER NOT NULL DEFAULT 1 CHECK ("is_subscribed" IN (0, 1)), "sort_order" INTEGER NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
--
CREATE TABLE "sync_states" ("mailbox_id" TEXT NOT NULL REFERENCES mailboxes (id) ON DELETE CASCADE, "state" TEXT NOT NULL, "has_older" INTEGER NOT NULL DEFAULT 0 CHECK ("has_older" IN (0, 1)), "synced_at" INTEGER NOT NULL, "stale_headers" INTEGER NOT NULL DEFAULT 0 CHECK ("stale_headers" IN (0, 1)), "headers_done_at" INTEGER NULL, "headers_done_seq" INTEGER NULL, PRIMARY KEY ("mailbox_id"));
--
CREATE TABLE "emails" ("seq" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "id" TEXT NOT NULL UNIQUE, "account_id" TEXT NOT NULL, "mailbox_id" TEXT NOT NULL REFERENCES mailboxes (id) ON DELETE CASCADE, "thread_id" TEXT NOT NULL, "message_id_header" TEXT NULL, "in_reply_to" TEXT NULL, "references_json" TEXT NOT NULL DEFAULT '[]', "from_json" TEXT NOT NULL DEFAULT '[]', "to_json" TEXT NOT NULL DEFAULT '[]', "cc_json" TEXT NOT NULL DEFAULT '[]', "bcc_json" TEXT NOT NULL DEFAULT '[]', "reply_to_json" TEXT NOT NULL DEFAULT '[]', "from_email" TEXT NOT NULL DEFAULT '', "subject" TEXT NOT NULL DEFAULT '', "base_subject" TEXT NOT NULL DEFAULT '', "preview" TEXT NOT NULL DEFAULT '', "received_at" INTEGER NOT NULL, "sent_at" INTEGER NULL, "size" INTEGER NOT NULL DEFAULT 0, "keywords" TEXT NOT NULL DEFAULT '[]', "is_seen" INTEGER NOT NULL DEFAULT 0 CHECK ("is_seen" IN (0, 1)), "is_flagged" INTEGER NOT NULL DEFAULT 0 CHECK ("is_flagged" IN (0, 1)), "has_attachment" INTEGER NOT NULL DEFAULT 0 CHECK ("has_attachment" IN (0, 1)), "list_id" TEXT NULL, "list_name" TEXT NULL, "list_post" TEXT NULL, "list_unsubscribe" TEXT NULL, "list_unsubscribe_post" TEXT NULL, "is_encrypted" INTEGER NOT NULL DEFAULT 0 CHECK ("is_encrypted" IN (0, 1)), "protected_subject" TEXT NULL, sub_key TEXT GENERATED ALWAYS AS (CASE WHEN from_email <> '' AND ((list_id IS NOT NULL AND list_id <> '') OR list_unsubscribe IS NOT NULL OR message_id_header LIKE '%@mcsv.net' OR message_id_header LIKE '%.mcsv.net' OR message_id_header LIKE '%@mcdlv.net' OR message_id_header LIKE '%.mcdlv.net' OR message_id_header LIKE '%@rsgsv.net' OR message_id_header LIKE '%.rsgsv.net' OR message_id_header LIKE '%@mandrillapp.com' OR message_id_header LIKE '%.mandrillapp.com' OR message_id_header LIKE '%@sendgrid.net' OR message_id_header LIKE '%.sendgrid.net' OR message_id_header LIKE '%@amazonses.com' OR message_id_header LIKE '%.amazonses.com' OR message_id_header LIKE '%@sparkpostmail.com' OR message_id_header LIKE '%.sparkpostmail.com' OR message_id_header LIKE '%@mailgun.org' OR message_id_header LIKE '%.mailgun.org' OR message_id_header LIKE '%@mailgun.net' OR message_id_header LIKE '%.mailgun.net' OR message_id_header LIKE '%@createsend.com' OR message_id_header LIKE '%.createsend.com' OR message_id_header LIKE '%@exacttarget.com' OR message_id_header LIKE '%.exacttarget.com') THEN CASE WHEN list_id IS NOT NULL AND list_id <> '' THEN 'list:' || list_id ELSE 'from:' || from_email END END) VIRTUAL);
--
CREATE TABLE "email_keywords" ("email_id" TEXT NOT NULL REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE, "keyword" TEXT NOT NULL, PRIMARY KEY ("email_id", "keyword"));
--
CREATE TABLE "contents" ("email_id" TEXT NOT NULL REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE, "html" TEXT NULL, "plain_text" TEXT NULL, "is_flowed" INTEGER NOT NULL DEFAULT 0 CHECK ("is_flowed" IN (0, 1)), "headers_json" TEXT NOT NULL DEFAULT '[]', "attachments_json" TEXT NOT NULL DEFAULT '[]', "body_text" TEXT NOT NULL DEFAULT '', "fetched_at" INTEGER NOT NULL, PRIMARY KEY ("email_id"));
--
CREATE TABLE "decrypted_texts" ("email_id" TEXT NOT NULL REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE, "body" TEXT NOT NULL, PRIMARY KEY ("email_id"));
--
CREATE TABLE "inline_parts" ("email_id" TEXT NOT NULL REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE, "content_id" TEXT NOT NULL, "data" BLOB NOT NULL, PRIMARY KEY ("email_id", "content_id"));
--
CREATE TABLE "outbox_items" ("id" TEXT NOT NULL, "account_id" TEXT NOT NULL REFERENCES accounts (id) ON DELETE CASCADE, "message" TEXT NOT NULL, "send_after" INTEGER NOT NULL, "status" TEXT NOT NULL, "attempts" INTEGER NOT NULL DEFAULT 0, "last_error" TEXT NULL, "created_at" INTEGER NOT NULL, "held" INTEGER NOT NULL DEFAULT 0 CHECK ("held" IN (0, 1)), PRIMARY KEY ("id"));
--
CREATE TABLE "outbox_copies" ("outbox_id" TEXT NOT NULL REFERENCES outbox_items (id) ON DELETE CASCADE, "seq" INTEGER NOT NULL, "recipients" TEXT NOT NULL, "filed" INTEGER NOT NULL DEFAULT 0 CHECK ("filed" IN (0, 1)), "date" INTEGER NOT NULL, "data" BLOB NOT NULL, PRIMARY KEY ("outbox_id", "seq"));
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
CREATE TABLE "list_kinds" ("list_id" TEXT NOT NULL, "kind" TEXT NOT NULL, PRIMARY KEY ("list_id"));
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
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.seq = new.seq;
  INSERT OR IGNORE INTO email_keywords(email_id, keyword) SELECT new.id, value FROM json_each(new.keywords);
END;
--
CREATE TRIGGER emails_after_update_text AFTER UPDATE OF subject, from_json, to_json, cc_json, bcc_json, preview,
  protected_subject ON emails BEGIN
  DELETE FROM email_fts WHERE rowid = old.seq;
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.seq = new.seq;
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
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.id = new.email_id;
END;
--
CREATE TRIGGER contents_after_update AFTER UPDATE OF body_text, attachments_json ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = new.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.id = new.email_id;
END;
--
CREATE TRIGGER contents_after_delete AFTER DELETE ON contents BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = old.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.id = old.email_id;
END;
--
CREATE TRIGGER decrypted_texts_after_insert AFTER INSERT ON decrypted_texts BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = new.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.id = new.email_id;
END;
--
CREATE TRIGGER decrypted_texts_after_update AFTER UPDATE OF body ON decrypted_texts BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = new.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.id = new.email_id;
END;
--
CREATE TRIGGER decrypted_texts_after_delete AFTER DELETE ON decrypted_texts BEGIN
  DELETE FROM email_fts WHERE rowid = (SELECT seq FROM emails WHERE id = old.email_id);
  INSERT INTO email_fts(rowid, subject, from_addr, to_addr, cc_addr, bcc_addr, preview, body, attachments)
SELECT e.seq, coalesce(e.protected_subject, e.subject), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.from_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.to_json)), (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.cc_json)),
  (SELECT group_concat(coalesce(json_extract(value, '$.n'), '') || ' ' || json_extract(value, '$.e'), ' ') FROM json_each(e.bcc_json)), e.preview, coalesce(d.body, c.body_text, ''), coalesce((SELECT group_concat(coalesce(json_extract(value, '$.filename'), '') || ' ' || json_extract(value, '$.mimeType'), ' ') FROM json_each(c.attachments_json)), '')
FROM emails e LEFT JOIN contents c ON c.email_id = e.id LEFT JOIN decrypted_texts d ON d.email_id = e.id WHERE e.id = old.email_id;
END;
--
CREATE INDEX emails_unread ON emails (mailbox_id, account_id, message_id_header) WHERE is_seen = 0;
--
CREATE INDEX emails_flagged ON emails (mailbox_id, account_id, message_id_header) WHERE is_flagged = 1;
--
CREATE INDEX emails_subscription ON emails (sub_key) WHERE sub_key IS NOT NULL;
--
CREATE TABLE subscription_messages (account_id TEXT NOT NULL, mid TEXT NOT NULL, key TEXT NOT NULL, received_at INTEGER NOT NULL, seen INTEGER NOT NULL, inbox INTEGER NOT NULL, trash INTEGER NOT NULL, PRIMARY KEY (account_id, mid)) WITHOUT ROWID;
--
CREATE INDEX subscription_messages_key ON subscription_messages (key, received_at, seen, inbox, trash);
--
CREATE TABLE subscription_details (key TEXT NOT NULL PRIMARY KEY, boxes TEXT, accounts TEXT, senders INTEGER NOT NULL, posters INTEGER NOT NULL, replies INTEGER NOT NULL, has_headers INTEGER NOT NULL, sender TEXT, list_name TEXT, from_name TEXT, post TEXT, unsubscribe TEXT, auto_kind TEXT, nkey TEXT, human_phrase TEXT, human_name TEXT) WITHOUT ROWID;
--
CREATE TRIGGER emails_subscription_update AFTER UPDATE OF id, account_id, mailbox_id, message_id_header, in_reply_to,
  references_json, from_json, from_email, received_at, is_seen, list_id, list_name, list_post, list_unsubscribe,
  list_unsubscribe_post ON emails
WHEN old.sub_key IS NOT NULL OR new.sub_key IS NOT NULL BEGIN
  INSERT OR IGNORE INTO subscription_dirty
    SELECT old.account_id, coalesce(old.message_id_header, old.id) WHERE old.sub_key IS NOT NULL;
  INSERT OR IGNORE INTO subscription_dirty
    SELECT new.account_id, coalesce(new.message_id_header, new.id) WHERE new.sub_key IS NOT NULL;
END;
--
CREATE TABLE subscription_dirty (account_id TEXT NOT NULL, mid TEXT NOT NULL, PRIMARY KEY (account_id, mid)) WITHOUT ROWID;
--
CREATE TABLE subscription_dirty_keys (key TEXT NOT NULL PRIMARY KEY) WITHOUT ROWID;
--
CREATE TRIGGER emails_subscription_insert AFTER INSERT ON emails WHEN new.sub_key IS NOT NULL BEGIN INSERT OR IGNORE INTO subscription_dirty VALUES (new.account_id, coalesce(new.message_id_header, new.id)); END;
--
CREATE TRIGGER emails_subscription_delete AFTER DELETE ON emails WHEN old.sub_key IS NOT NULL BEGIN INSERT OR IGNORE INTO subscription_dirty VALUES (old.account_id, coalesce(old.message_id_header, old.id)); END;
--
CREATE TRIGGER mailboxes_subscription_role AFTER UPDATE OF role ON mailboxes WHEN old.role IS NOT new.role BEGIN
  INSERT OR IGNORE INTO subscription_dirty SELECT account_id, coalesce(message_id_header, id) FROM emails
    WHERE mailbox_id = new.id AND sub_key IS NOT NULL;
END;
--
CREATE TRIGGER accounts_subscription_insert AFTER INSERT ON accounts BEGIN INSERT OR IGNORE INTO subscription_dirty_keys (key) VALUES ('*'); END;
--
CREATE TRIGGER accounts_subscription_delete AFTER DELETE ON accounts BEGIN INSERT OR IGNORE INTO subscription_dirty_keys (key) VALUES ('*'); END;
--
CREATE TRIGGER accounts_subscription_update AFTER UPDATE OF email, json ON accounts
WHEN lower(old.email) IS NOT lower(new.email)
  OR (SELECT group_concat(lower(json_extract(value, '$.email'))) FROM json_each(old.json, '$.identities'))
  IS NOT (SELECT group_concat(lower(json_extract(value, '$.email'))) FROM json_each(new.json, '$.identities'))
BEGIN INSERT OR IGNORE INTO subscription_dirty_keys (key) VALUES ('*'); END;
--
