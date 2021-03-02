export default function cookie() {
  const s = document.createElement('script');
  s.type = 'text/javascript';
  s.async = true;
  s.src = 'https://app.termly.io/embed.min.js';
  s.id = '780e5677-086c-403b-bffc-0418efa73946';
  s.setAttribute("data-name", "termly-embed-banner");
  const x = document.getElementsByTagName('script')[0];
  if (document.querySelector('body').dataset.env != 'test') {
    x.parentNode.insertBefore(s, x);
  }
};
