import 'mdb-ui-kit';

/** ***** Tabs ***** **/
const initTabs = () => {
  const tabs = document.getElementById('our-company-tabs');
  const navLinks = tabs.querySelectorAll('.nav-link');

  function disableTabs() {
    navLinks.forEach((link) => {
      link.removeAttribute('data-mdb-toggle');
    });
  }

  function enableTabs() {
    navLinks.forEach((link) => {
      link.setAttribute('data-mdb-toggle', 'tab');
    });
  }

  window.addEventListener('load', () => {
    if (window.innerWidth < 480) {
      disableTabs();
    }
  });

  window.addEventListener('resize', () => {
    if (window.innerWidth < 480) {
      disableTabs();
    } else {
      enableTabs();
    }
  });
};

initTabs();
