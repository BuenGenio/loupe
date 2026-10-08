import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import {
  displayUrl,
  graphemes,
  hashtags,
  mastodonLength,
  mentions,
  threadsLength,
  utf8Length,
  utf8Offset,
  xWeightedLength,
} from '../src/text.mjs';

describe('counting', () => {
  it('counts graphemes, not code units', () => {
    assert.equal(graphemes('héllo'), 5);
    assert.equal(graphemes('👍🏽'), 1); // skin tone modifier
    assert.equal(graphemes('👨‍👩‍👧‍👦'), 1); // ZWJ family
    assert.equal(graphemes('🇺🇦'), 1); // flag
    assert.equal('👨‍👩‍👧‍👦'.length, 11);
    assert.equal(utf8Length('👨‍👩‍👧‍👦'), 25);
  });

  it('Mastodon: URLs count as 23, remote mentions as @user, CW counts too', () => {
    const url = 'https://loupe.mx/?utm_source=mastodon&utm_medium=social&utm_campaign=launch';
    assert.equal(mastodonLength(`Try ${url}`), 4 + 23);
    assert.equal(mastodonLength('hi @loupe@mastodon.social!'), graphemes('hi @loupe!'));
    assert.equal(mastodonLength('body', 'CW'), 6);
    assert.equal(mastodonLength('a'.repeat(500)), 500);
  });

  it('X: weighted length, URLs 23, emoji 2, CJK 2', () => {
    assert.equal(xWeightedLength('hello'), 5);
    assert.equal(xWeightedLength('🔍'), 2);
    assert.equal(xWeightedLength('👨‍👩‍👧‍👦'), 2);
    assert.equal(xWeightedLength('日本'), 4);
    assert.equal(xWeightedLength('see https://loupe.mx/a/very/long/path?x=1'), 4 + 23);
  });

  it('Threads: emoji count as their UTF-8 bytes', () => {
    assert.equal(threadsLength('abc'), 3);
    assert.equal(threadsLength('🔍'), 4);
    assert.equal(threadsLength('é'), 1);
  });

  it('hashtags and mentions', () => {
    assert.deepEqual(hashtags('Loupe #Android #e_mail, not a#tag or #123 or &#39;'), ['Android', 'e_mail']);
    assert.deepEqual(mentions('cc @alice.example and me@example.com'), ['alice.example']);
  });

  it('UTF-8 offsets', () => {
    const s = '🔍 a';
    assert.equal(utf8Offset(s, 0), 0);
    assert.equal(utf8Offset(s, 2), 4); // after the 4-byte emoji (2 UTF-16 units)
    assert.equal(utf8Offset(s, 3), 5);
  });

  it('displayUrl', () => {
    assert.equal(displayUrl('https://loupe.mx/'), 'loupe.mx');
    assert.equal(displayUrl('https://www.loupe.mx/features/smime/?a=1#x'), 'loupe.mx/features/smime');
  });
});
