import { hasStrings } from './index';
import { otherCodes } from './locales';

// getStaticPaths for /[lang]/… pages: every language that has a strings file.
export const localePaths = () => otherCodes.filter(hasStrings).map((lang) => ({ params: { lang } }));
