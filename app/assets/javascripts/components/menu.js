"use strict";

$(document).on('turbolinks:load', function() {
  $('[data-js-hook=menu-dropdown]').each(function() {
    var el = $(this);
    el.find('[data-js-hook=menu-dropdown-link]').on('click', function() {
      el.toggleClass('open');
      return false;
    });
  });
});
