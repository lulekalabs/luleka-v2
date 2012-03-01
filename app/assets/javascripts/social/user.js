User = function(attributes) {

  var that = this;

  this.facebookSession = null;
  this.firstName       = null;
  this.friends         = null;
  this.lastName        = null;
  this.likes           = null;
  this.name            = null;
  this.pic             = null;
  this.referrer        = null;
  this.uid             = null;

  if (attributes) {
    $.each(attributes, function(key, value) {
      if (that.hasOwnProperty(key)) {
        that[key] = value;
      }
    });
  }

  this.handlers = {};

  this.handlers.loadFriends = function(response) {
    that.friends = response.data;
  };

  this.handlers.loadLikes = function(response) {
    that.likes = response.data;
  };

  this.handlers.initializeMe = function(response) {
    if (response.session) {
      that.facebookSession = response.session;
      that.uid = response.session.uid;
      that.loadFriends();
      that.loadLikes();
    }
  };

  this.handlers.initializeFriend = function(response) {
    that.pic       = response[0].pic_small;
    that.firstName = response[0].first_name;
  };
};

User.prototype.loadFriends = function() {
  var that = this;
  FB.api("/" + that.uid + "/friends", this.handlers.loadFriends);
};

User.prototype.loadLikes = function() {
  var that = this;
  FB.api("/" + that.uid + "/likes", this.handlers.loadLikes);
};


User.prototype.initializeMe = function(callback) {
  var that = this;
  FB.getLoginStatus(function(response) {
    that.handlers.initializeMe(response);
    if (callback) { callback(that); }
  });
};

User.prototype.initializeFriend = function(uid, callback) {
  var that = this;
  var query = 'SELECT first_name, pic_small FROM user WHERE uid=' + uid;
  FB.api({method: 'fql.query', query: query}, function(response) {
    that.handlers.initializeFriend(response);
    if (callback) {
      callback(that);
    }
    $('html').trigger("friendLoaded", that);
  });
};

User.prototype.likesPage = function(pageId) {
  var value = false;
  if (this.likes) {
    $.each(this.likes, function(i, elem) {
      if (pageId === elem.id) { value = true; }
    });
  }
  return value;
};