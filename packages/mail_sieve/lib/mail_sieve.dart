/// Mail rules for Loupe: compiling the search language to Sieve, Loupe's
/// own Sieve script (generated from the rules and read back), the
/// ManageSieve client (RFC 5804) and the runner for device rules.
library;

export 'src/check.dart' show checkSieveScript;
export 'src/compile.dart' show SieveProblem, SieveTest, compileSieve, loupeSieveExtensions, posixIssue;
export 'src/include.dart' show IncludeEdit, includeComment, includesScript, planInclude;
export 'src/managesieve/channel.dart' show SieveChannel, SocketSieveChannel;
export 'src/managesieve/client.dart' show ManageSieveClient;
export 'src/managesieve/connector.dart' show ManageSieveConnector, manageSievePort;
export 'src/managesieve/session.dart'
    show SieveCapabilities, SieveConnector, SieveException, SieveScriptInfo, SieveSession;
export 'src/script.dart'
    show
        CompiledRule,
        LoupeScript,
        SieveTarget,
        compileRule,
        generateLoupeScript,
        isLoupeScript,
        loupeScriptName,
        parseLoupeScript;
export 'src/sieve_text.dart' show sieveFlag, sieveString;
export 'src/simulated.dart' show SimulatedSieveAccount, SimulatedSieveServers;
