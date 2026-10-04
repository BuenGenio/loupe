// Short constructors for expected expressions in tests.
import 'package:mail_model/mail_model.dart';

/// The anchor for relative dates in tests: Sunday 4 October 2026, noon.
final testNow = DateTime(2026, 10, 4, 12);

TextTerm any(String v) => TextTerm(TextField.any, v);
TextTerm from(String v) => TextTerm(TextField.from, v);
TextTerm toOnly(String v) => TextTerm(TextField.to, v);
TextTerm cc(String v) => TextTerm(TextField.cc, v);
TextTerm bcc(String v) => TextTerm(TextField.bcc, v);
TextTerm subject(String v) => TextTerm(TextField.subject, v);
TextTerm body(String v) => TextTerm(TextField.body, v);
TextTerm attachment(String v) => TextTerm(TextField.attachment, v);
TextTerm participants(String v) => TextTerm(TextField.participants, v);
TextTerm recipients(String v) => TextTerm(TextField.recipients, v);

/// What `to:v` means: To or Cc.
SearchOr toOrCc(String v) => SearchOr([toOnly(v), cc(v)]);

RegexTerm re(TextField f, String p, {bool cs = false}) => RegexTerm(f, p, caseSensitive: cs);

SearchAnd and(List<SearchExpr> c) => SearchAnd(c);
SearchOr or(List<SearchExpr> c) => SearchOr(c);
SearchNot not(SearchExpr e) => SearchNot(e);

KeywordTerm kw(String k) => KeywordTerm(k);
const unread = SearchNot(KeywordTerm(Keywords.seen));
const read = KeywordTerm(Keywords.seen);
const flagged = KeywordTerm(Keywords.flagged);
const hasAttachment = HasAttachmentTerm();

DateTerm before(int y, int m, int d) => DateTerm(DateComparison.before, DateTime(y, m, d));
DateTerm since(int y, int m, int d) => DateTerm(DateComparison.onOrAfter, DateTime(y, m, d));
DateTerm on(int y, int m, int d) => DateTerm(DateComparison.on, DateTime(y, m, d));

SizeTerm larger(int b) => SizeTerm(SizeComparison.larger, b);
SizeTerm smaller(int b) => SizeTerm(SizeComparison.smaller, b);

const kb = 1024;
const mb = 1024 * 1024;
