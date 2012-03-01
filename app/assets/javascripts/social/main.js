if (undefined === SocialBuilder) {throw("SocialBuilder is not defined");}

SocialBuilder.init = function() {

  FB.Canvas.setAutoResize();

  FB.init({
    appId:  campaign.appId,
    status: true,
    cookie: true,
    xfbml:  false
  });

  FB.Event.subscribe("edge.create", function(response) {
    SocialBuilder.track({event_code: "liked"});
    campaign.liked = true;
  });

  FB.Event.subscribe("edge.remove", function(response) {
    SocialBuilder.track({event_code: "unliked"});
    campaign.liked = false;
  });

  $('.like-button-wrapper').each(function() {
    var likeButton = $('<fb:like id="like-button">');
    likeButton.attr("send", false);
    likeButton.attr("layout", "button_count");
    likeButton.attr("show_faces", false);
    $(this).prepend(likeButton);
  });

  $('html').one("friendLoaded", SocialBuilder.showReferrer);
  $('html').one("pageLoaded", SocialBuilder.setUpLikeButton);

  var page = new Page;
  page.initializeFromFacebook(context.pageId);

  var user = new User;

  FB.Event.subscribe("auth.statusChange", function(response) {
    if ("connected" === response.status) {
      user.initializeMe();
    }
  });

  user.initializeMe(function(self) {
    if (context.referrerUid && String(user.uid) !== String(context.referrerUid)) {
      self.referrer = new User;
      self.referrer.initializeFriend(context.referrerUid);
    }
  });

  var formWrapper = new FormWrapper(".registrations form.registration-form").setUp(campaign, user);

  $("a.post").click(function(event) {
    event.preventDefault();
    var options = {
      method:      'feed',
      link:        page.getReferralUrl(campaign, user),
      name:        campaign.caption,
      picture:     campaign.picture,
      caption:     "\n",
      description: campaign.description
    };
    FB.ui(options, function(response) {
      if (response && response.post_id) {
        // Note that we don't always have access to the number of friends,
        // because users can still share a link on their walls without having
        // granted permissions.
        var numFriends = user.friends ? user.friends.length : 0;
        SocialBuilder.track({event_code : "wall_post", payload : numFriends});
      }
    });
  });
};
