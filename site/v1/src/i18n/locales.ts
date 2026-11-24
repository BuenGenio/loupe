// The languages loupe.mx speaks. `code` is the URL prefix (/de/…) and the
// BCP 47 tag; English lives at the root. `flag` names a file in public/flags/
// (from flag-icons, MIT): a flag stands next to the language's own name,
// never alone, since languages aren't countries.
export interface Locale {
  code: string;
  name: string; // endonym, as the language calls itself
  english: string;
  flag: string;
  og: string; // og:locale
}

export const locales: Locale[] = [
  { code: 'en', name: 'English', english: 'English', flag: 'gb', og: 'en_GB' },
  { code: 'es', name: 'Español', english: 'Spanish', flag: 'es', og: 'es_ES' },
  { code: 'de', name: 'Deutsch', english: 'German', flag: 'de', og: 'de_DE' },
  { code: 'fr', name: 'Français', english: 'French', flag: 'fr', og: 'fr_FR' },
  { code: 'it', name: 'Italiano', english: 'Italian', flag: 'it', og: 'it_IT' },
  { code: 'uk', name: 'Українська', english: 'Ukrainian', flag: 'ua', og: 'uk_UA' },
  { code: 'sq', name: 'Shqip', english: 'Albanian', flag: 'al', og: 'sq_AL' },
  { code: 'bs', name: 'Bosanski', english: 'Bosnian', flag: 'ba', og: 'bs_BA' },
  { code: 'bg', name: 'Български', english: 'Bulgarian', flag: 'bg', og: 'bg_BG' },
  { code: 'ca', name: 'Català', english: 'Catalan', flag: 'es-ct', og: 'ca_ES' },
  { code: 'hr', name: 'Hrvatski', english: 'Croatian', flag: 'hr', og: 'hr_HR' },
  { code: 'cs', name: 'Čeština', english: 'Czech', flag: 'cz', og: 'cs_CZ' },
  { code: 'da', name: 'Dansk', english: 'Danish', flag: 'dk', og: 'da_DK' },
  { code: 'nl', name: 'Nederlands', english: 'Dutch', flag: 'nl', og: 'nl_NL' },
  { code: 'et', name: 'Eesti', english: 'Estonian', flag: 'ee', og: 'et_EE' },
  { code: 'fi', name: 'Suomi', english: 'Finnish', flag: 'fi', og: 'fi_FI' },
  { code: 'gl', name: 'Galego', english: 'Galician', flag: 'es-ga', og: 'gl_ES' },
  { code: 'el', name: 'Ελληνικά', english: 'Greek', flag: 'gr', og: 'el_GR' },
  { code: 'hu', name: 'Magyar', english: 'Hungarian', flag: 'hu', og: 'hu_HU' },
  { code: 'is', name: 'Íslenska', english: 'Icelandic', flag: 'is', og: 'is_IS' },
  { code: 'ga', name: 'Gaeilge', english: 'Irish', flag: 'ie', og: 'ga_IE' },
  { code: 'lv', name: 'Latviešu', english: 'Latvian', flag: 'lv', og: 'lv_LV' },
  { code: 'lt', name: 'Lietuvių', english: 'Lithuanian', flag: 'lt', og: 'lt_LT' },
  { code: 'lb', name: 'Lëtzebuergesch', english: 'Luxembourgish', flag: 'lu', og: 'lb_LU' },
  { code: 'mk', name: 'Македонски', english: 'Macedonian', flag: 'mk', og: 'mk_MK' },
  { code: 'mt', name: 'Malti', english: 'Maltese', flag: 'mt', og: 'mt_MT' },
  { code: 'nb', name: 'Norsk bokmål', english: 'Norwegian', flag: 'no', og: 'nb_NO' },
  { code: 'pl', name: 'Polski', english: 'Polish', flag: 'pl', og: 'pl_PL' },
  { code: 'pt', name: 'Português', english: 'Portuguese', flag: 'pt', og: 'pt_PT' },
  { code: 'ro', name: 'Română', english: 'Romanian', flag: 'ro', og: 'ro_RO' },
  { code: 'sr', name: 'Српски', english: 'Serbian', flag: 'rs', og: 'sr_RS' },
  { code: 'sk', name: 'Slovenčina', english: 'Slovak', flag: 'sk', og: 'sk_SK' },
  { code: 'sl', name: 'Slovenščina', english: 'Slovenian', flag: 'si', og: 'sl_SI' },
  { code: 'sv', name: 'Svenska', english: 'Swedish', flag: 'se', og: 'sv_SE' },
  { code: 'tr', name: 'Türkçe', english: 'Turkish', flag: 'tr', og: 'tr_TR' },
  { code: 'cy', name: 'Cymraeg', english: 'Welsh', flag: 'gb-wls', og: 'cy_GB' },
  { code: 'eu', name: 'Euskara', english: 'Basque', flag: 'es-pv', og: 'eu_ES' },
];

export const defaultLocale = 'en';
export const popular = ['en', 'es', 'de', 'fr', 'it', 'uk', 'sq'];
export const codes = locales.map((l) => l.code);
export const otherCodes = codes.filter((c) => c !== defaultLocale);
export const locale = (code: string) => locales.find((l) => l.code === code) ?? locales[0];

// Pages that exist in every language. Everything else (docs, blog, privacy,
// development) is English only, and the switcher sends other languages home.
export const translatedPaths = ['/', '/features/', '/screenshots/', '/download/', '/download/start/', '/thanks/', '/donate/', '/contact/', '/press/', '/roadmap/'];
