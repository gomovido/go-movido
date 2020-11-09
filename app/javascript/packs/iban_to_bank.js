import { list } from './list';

export default function iban_to_bank(iban) {
  const cib = parseInt(iban.replace(/[^A-Z0-9]/ig, '').substring(4, 9));
  return list[cib] ? list[cib] : 'Other';
}
