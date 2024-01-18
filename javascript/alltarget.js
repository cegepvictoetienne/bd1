const allLinks = document.querySelectorAll('a');

allLinks.forEach((link) => {
  const href = link.getAttribute('href');
  if (href && (href.startsWith('http://') || href.startsWith('https://'))) {
    link.setAttribute('target', '_blank');
  }
});
