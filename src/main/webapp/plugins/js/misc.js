(function($) {
  'use strict';
  $(function() {
     $('#sidebar .nav').perfectScrollbar();
    $('.container-scroller').perfectScrollbar( {suppressScrollX: true});
    $('[data-toggle="minimize"]').on("click", function () {
      $('body').toggleClass('sidebar-icon-only');
    });
  });

  $(".form-check label,.form-radio label").append('<i class="input-helper"></i>');
})(jQuery);

var myArray = [ "Jack", "Sawyer", "John", "Desmond" ];
$("#exampleInputEmail1").autocomplete({
  source: myArray
});

