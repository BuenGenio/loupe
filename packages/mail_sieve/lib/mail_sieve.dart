/// Mail rules for Loupe: compiling the search language to Sieve, Loupe's
/// own Sieve script (generated from the rules and read back), the
/// ManageSieve client (RFC 5804) and the runner for device rules.
library;

export 'src/compile.dart' show SieveProblem, SieveTest, compileSieve, loupeSieveExtensions, posixIssue;
export 'src/sieve_text.dart' show sieveFlag, sieveString;
