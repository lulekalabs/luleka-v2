// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require rails.validations
//= require_self

$(function() {
  window.scrollTo(0, 1);
  
  var updateLayout = function() {
    var currentWidth;
    if (window.innerWidth != currentWidth) {
      currentWidth = window.innerWidth;
      var orient = (currentWidth == 320) ? "profile" : "landscape";
      document.body.setAttribute("orient", orient);
      window.scrollTo(0, 1);
    }
  };

  if(!(typeof(iPhone) === "undefined")) {
    iPhone.DomLoad(updateLayout);
  }
  setInterval(updateLayout, 400);
  
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
  
  $("form#change-locale-form a").click(function(event) {
    $(this).closest("form").find("input[name='locale']").val($(this).attr("data-locale"));
    $(this).closest("form").submit();
    event.preventDefault();
  });
});

clientSideValidations.validators.local["email_format"] = function(element, options) {
  if (!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
    return options.message;
  }
}