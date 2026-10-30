import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';
import '../../shared/grouped_list.dart';
import '../ai/ai_providers.dart';
import '../ai/ai_settings.dart';
import '../ai/ai_usage.dart';
import 'private_ai_settings_screen.dart' show aiProviderName;

/// An amount in US dollars: cents, or hundredths of a cent below a dollar,
/// where one message's requests land.
String _dollars(double amount) =>
    NumberFormat.simpleCurrency(name: 'USD', decimalDigits: amount > 0 && amount < 1 ? 4 : 2).format(amount);

/// A price per million tokens, in dollars and cents.
String _price(double dollars) => NumberFormat.simpleCurrency(name: 'USD', decimalDigits: 2).format(dollars);

/// [cost] as Settings shows it: never a bare number for what isn't known.
String aiCostLabel(AppLocalizations l10n, AiCost cost) => switch (cost) {
  AiNoCost() => l10n.settingsAiCostNone,
  AiUnknownCost() => l10n.settingsAiCostUnknown,
  AiEstimatedCost(:final dollars, atLeast: true) => l10n.settingsAiCostAtLeast(_dollars(dollars)),
  AiEstimatedCost(:final dollars) => l10n.settingsAiCostEstimate(_dollars(dollars)),
};

/// The token counts of [usage]: a sum only of what was reported, and how
/// many requests reported nothing.
String _tokens(AppLocalizations l10n, AiUsage usage) {
  final number = NumberFormat.decimalPattern();
  if (!usage.anyReported) return l10n.settingsAiUsageTokensUnreported;
  final input = number.format(usage.inputTokens);
  final output = number.format(usage.outputTokens);
  return usage.unreportedRequests == 0
      ? l10n.settingsAiUsageTokens(input, output)
      : l10n.settingsAiUsageTokensPartly(usage.unreportedRequests, input, output);
}

/// Settings › Private AI › Usage & Estimated Cost: requests, tokens and an
/// estimated cost by provider and model for today, this month or every
/// record on this phone, and the prices the estimate uses, with their date.
class AiUsageScreen extends ConsumerStatefulWidget {
  const AiUsageScreen({super.key});

  @override
  ConsumerState<AiUsageScreen> createState() => _AiUsageScreenState();
}

class _AiUsageScreenState extends ConsumerState<AiUsageScreen> {
  var _period = AiUsagePeriod.thisMonth;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ledger = ref.watch(aiLedgerProvider);
    return ListenableBuilder(
      listenable: ledger,
      builder: (context, _) {
        final usage = usageIn(ledger.records, _period, now: clock.now());
        final byKind = <AiProviderKind, List<AiUsage>>{};
        for (final u in usage) {
          byKind.putIfAbsent(AiProviderKind.of(u.providerId), () => []).add(u);
        }
        return GroupedPage(
          title: l10n.settingsAiUsage,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: CupertinoSlidingSegmentedControl<AiUsagePeriod>(
                key: const Key('ai-usage-period'),
                groupValue: _period,
                onValueChanged: (v) {
                  if (v != null) setState(() => _period = v);
                },
                children: {
                  for (final (period, label) in [
                    (AiUsagePeriod.today, l10n.settingsAiUsageToday),
                    (AiUsagePeriod.thisMonth, l10n.settingsAiUsageThisMonth),
                    (AiUsagePeriod.all, l10n.settingsAiUsageAll),
                  ])
                    period: Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text(label)),
                },
              ),
            ),
            if (usage.isEmpty)
              InsetGroup(
                separatorIndent: 16,
                footer: l10n.settingsAiUsageFooter,
                children: [GroupedRow(title: l10n.settingsAiUsageNone, enabled: false, chevron: false)],
              )
            else ...[
              for (final MapEntry(key: kind, value: rows) in byKind.entries)
                InsetGroup(
                  header: aiProviderName(l10n, kind),
                  separatorIndent: 16,
                  children: [
                    for (final u in rows)
                      GroupedRow(
                        key: ValueKey('ai-usage-${u.providerId}-${u.model}'),
                        // A server's id names its host: worth showing.
                        title: kind == AiProviderKind.myServer ? u.providerId : u.model ?? u.providerId,
                        subtitle: '${l10n.settingsAiUsageRequests(u.requests)} · ${_tokens(l10n, u)}',
                        detail: aiCostLabel(l10n, u.cost),
                        chevron: false,
                      ),
                  ],
                ),
              InsetGroup(
                separatorIndent: 16,
                footer: l10n.settingsAiUsageFooter,
                children: [
                  GroupedRow(
                    key: const Key('ai-usage-total'),
                    title: l10n.settingsAiUsageTotal,
                    subtitle: l10n.settingsAiUsageRequests(usage.fold(0, (sum, u) => sum + u.requests)),
                    detail: aiCostLabel(l10n, totalCost(usage)),
                    chevron: false,
                  ),
                ],
              ),
            ],
            InsetGroup(
              header: l10n.settingsAiPricesHeader,
              separatorIndent: 16,
              footer: l10n.settingsAiPricesFooter(AiPrices.source, DateFormat.yMMMMd().format(AiPrices.asOf)),
              children: [
                for (final MapEntry(key: model, value: price) in AiPrices.anthropic.entries)
                  GroupedRow(
                    title: model,
                    subtitle: l10n.settingsAiPrice(_price(price.input), _price(price.output)),
                    chevron: false,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
