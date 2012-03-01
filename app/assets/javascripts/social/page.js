Page = function() {
  var that = this;
  this.handlers = {};

  this.handlers.initializeFromFacebook = function(response) {
    $.each(response, function(key, value) { that[key] = value; });
    $('html').trigger("pageLoaded", that);
  };
};

Page.prototype.initializeFromFacebook = function(id, callback) {
  var that = this;
  $.getJSON("https://graph.facebook.com/" + id + "?callback=?", function(response) {
    that.handlers.initializeFromFacebook(response);
    if (callback) { callback(that); }
  });
};

// Returns a direct link to an app tab on this page.
Page.prototype.getTabUrl = function(appId) {
  return this.link + '?sk=app_' + appId;
};

Page.prototype.getReferralUrl = function(campaign, user) {
  var target = encodeURIComponent(this.getTabUrl(campaign.appId));
  var url    = campaign.referralUrl + '?t=' + target;
  if (user) { url = url + '&u=' + user.uid; }
  return url;
};

// This sets up any <a> with the class .page to redirect to the tab url, as long
// as it has a data-app-id and a data-page-id.
$(function() {
  $("a.page").each(function() {
    var appId  = $(this).attr("data-app-id");
    var pageId = $(this).attr("data-page-id");
    var page   = new Page;
    var a      = $(this);
    page.initializeFromFacebook(pageId, function(p) {
      a.attr("href", p.getTabUrl(appId));
    });
  });
});