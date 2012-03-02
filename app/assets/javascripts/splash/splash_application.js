// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require rails.validations
//= require detect_timezone
//= require_self

$(function() {
  /* Hide address bar on iOS devices */ 
  window.scrollTo(0, 1);

  /* Taking care of inline text input labels */
  $(".holding input").focus(function(event) {
    if($(this).val().length == 0) {
      $(this).closest(".holding").find(".holder").fadeOut(25)
    }
  }).blur(function(event) {
    if($(this).val().length == 0) {
      $(this).closest(".holding").find(".holder").fadeIn(100);
    }
  });
  $(".holder").click(function(event) {
    if($(this).parent(".holding").find("input").val() == 0) {
      $(this).fadeOut(25);
      $(this).parent(".holding").find("input").focus();
    }
  });

  /* Locale settings submitted in a form */
  $("form#change-locale-form a").click(function(event) {
    $(this).closest("form").find("input[name='locale']").val($(this).attr("data-locale"));
    $(this).closest("form").submit();
    event.preventDefault();
  });
  
  /* Set browser time zone */
  $("form input[name='registration[time_zone]']").val(jstz.determine_timezone().name());
  
});

/* image preload */
(function($) {
  var imgList = [];
  $.extend({
    preload: function(imgArr, option) {
      var setting = $.extend({
        init: function(loaded, total) {},
        loaded: function(img, loaded, total) {},
        loaded_all: function(loaded, total) {}
      }, option);
      var total = imgArr.length;
      var loaded = 0;
      
      setting.init(0, total);
      for(var i in imgArr) {
        imgList.push($("<img />")
          .attr("src", imgArr[i])
          .load(function() {
            loaded++;
            setting.loaded(this, loaded, total);
            if(loaded == total) {
              setting.loaded_all(loaded, total);
            }
          })
        );
      }
      
    }
  });
})(jQuery);

/* For email format client side validations */
clientSideValidations.validators.local["email_format"] = function(element, options) {
  if (!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
    return options.message;
  }
}