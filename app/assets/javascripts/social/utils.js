var SocialBuilder = {};

SocialBuilder.inIframe = function() {
  undefined === top.location.href;
};

SocialBuilder.inStandaloneApp = function() {
  if($(".topbar").size() == 0) return false; else return true;
}

SocialBuilder.track = function(trackingEvent) {
  $.post(campaign.trackingEventPath, {"event" : trackingEvent});
};

SocialBuilder.showReferrer = function(event, referrer) {
  var div    = $('<div>');
  var p      = $("<p>");
  var img    = $("<img>");
  var strong = $("<strong>");
  div.attr("class", "recommendation");
  img.attr("src", referrer.pic);
  strong.prepend(referrer.firstName + " thought you'd like this!");
  p.prepend(strong);
  p.prepend(img);
  div.prepend(p);
  $('#entry, #like').prepend(div);
};

SocialBuilder.setUpLikeButton = function(event, page) {
  var link = page.link;
  $("#like-button").each(function() {
    $(this).attr("href", link);
    FB.XFBML.parse(document.getElementById("#like-button"));
  });
  if (SocialBuilder.inIframe()) {
    FB.Event.subscribe('edge.create', function(response) {
      top.window.location.href = link;
    });
    FB.Event.subscribe('edge.remove', function(response) {
      top.window.location.href = link;
    });
  }
};

$(function(){
  // Redirect top-level frame from within an iframe
  $(".top").click(function(event) {
    event.preventDefault();
    top.location.href = $(this).attr("href");
  });

  // Open a.pop in a new window
  $('.pop').each(function() {
    var that = $(this);
    $(this).click(function(event) {
      if (that.attr("href") === "#") {
        event.preventDefault();
        alert("Please wait a moment for the correct URL to be fetched from Facebook.");
      }
    });
    $(this).attr("target", "_blank");
  });

});
