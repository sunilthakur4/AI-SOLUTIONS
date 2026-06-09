(function () {
  const STORAGE_KEY = 'aiSolutionsTheme';
  const savedTheme = localStorage.getItem(STORAGE_KEY);
  const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
  const initialTheme = savedTheme || (prefersDark ? 'dark' : 'light');

  document.documentElement.dataset.theme = initialTheme;

  function updateButton(button) {
    const isDark = document.documentElement.dataset.theme === 'dark';
    button.innerHTML = isDark
      ? '<span class="theme-icon" aria-hidden="true">&#9790;</span><span class="theme-label">NIGHT MODE</span>'
      : '<span class="theme-label">DAY MODE</span><span class="theme-icon" aria-hidden="true">&#9737;</span>';
    button.title = isDark ? 'Dark mode active. Switch to day mode' : 'Day mode active. Switch to night mode';
    button.setAttribute('aria-label', button.title);
    button.setAttribute('aria-pressed', String(isDark));
  }

  function setupMobileMenus() {
    document.querySelectorAll('.nav-toggle').forEach(function (button) {
      const nav = button.closest('nav');
      if (!nav) return;

      function setOpen(isOpen) {
        nav.classList.toggle('menu-open', isOpen);
        button.setAttribute('aria-expanded', String(isOpen));
        button.setAttribute('aria-label', isOpen ? 'Close menu' : 'Open menu');
      }

      button.addEventListener('click', function () {
        setOpen(!nav.classList.contains('menu-open'));
      });

      nav.querySelectorAll('ul a').forEach(function (link) {
        link.addEventListener('click', function () {
          setOpen(false);
        });
      });
    });

    document.addEventListener('keydown', function (event) {
      if (event.key !== 'Escape') return;
      document.querySelectorAll('nav.menu-open').forEach(function (nav) {
        const button = nav.querySelector('.nav-toggle');
        nav.classList.remove('menu-open');
        if (button) {
          button.setAttribute('aria-expanded', 'false');
          button.setAttribute('aria-label', 'Open menu');
        }
      });
    });
  }

  window.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('[data-theme-toggle]').forEach(function (button) {
      updateButton(button);
      button.addEventListener('click', function () {
        const nextTheme = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark';
        document.documentElement.dataset.theme = nextTheme;
        localStorage.setItem(STORAGE_KEY, nextTheme);
        document.querySelectorAll('[data-theme-toggle]').forEach(updateButton);
      });
    });

    setupMobileMenus();
  });
})();
