import { list } from './list';

export default function iban_to_bank(iban, locale) {
  const cib = parseInt(iban.replace(/[^A-Z0-9]/ig, '').substring(4, 9));
  if (list[cib]) {
    return list[cib]
  } else {
    return locale === 'fr' ? 'Autre' : 'Other';
  }
}
