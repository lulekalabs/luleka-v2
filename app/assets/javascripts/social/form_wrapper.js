FormWrapper = function(css) {
  var that = this;
  this.form = $(css);
  this.campaign = null;

  this.setUpForm = function() {
    this.form.attr("accept-charset", "utf-8");
    this.form.append('<input type="hidden" id="user_data">');

    if (this.form.find("p.status").length === 0) {
      this.form.prepend("<p class='status error'>");
    }

    this.setStatus = function(text) {
      this.form.find("p.status").html(text);
    };

    this.clearStatus = function() {
      this.form.find("p.status").html("");
    };

    this.notLiked = function() {
      that.setStatus("You must like the page to continue");
      that.enable();
    };

    this.needPermissions = function() {
      that.setStatus("You need to grant permissions");
      that.enable();
    };
    
    this.formValid = function() {
      var valid = true;
      // This will cycle through all visible inputs and attempt to validate all of them.
      // See: https://github.com/bcardarella/client_side_validations/wiki/Validation-in-Multi-Step-Form
      $('[data-validate]:input:visible').each(function() {
        var settings = window[this.form.id];
        if (!$(this).isValid(settings.validators)) {
          valid = false
        }
      });
      return valid;
    };

    this.form.bind("validatedLike", function() {
      if (that.formValid()) {
        that.submitHandler();
      }
      else {
        that.enable();
      }
    });

    this.form.find("input[type=submit], input[type=image], input[type=button]").click(function(event) {
      event.preventDefault();
      that.disable();

      if (that.campaign.liked) {
        return that.form.trigger("validatedLike");
      }

      FB.getLoginStatus(function(response) {
        if (response.session) {
          that.checkLikes();
        }
        else {
          FB.login(function(response) {
            if (response.session) {
              that.checkLikes();
            }
            else {
              that.needPermissions();
            }
          }, {perms: that.campaign.permissions});
        }
      });
      return false;
    });
  };

  this.checkLikes = function() {
    FB.api("/me/likes", function(response) {
      if (response.data) {
        $.each(response.data, function(index, element) {
          if (element.id == context.pageId) {
            that.campaign.liked = true;
            return that.form.trigger("validatedLike");
          }
        });
        if (!that.campaign.liked) {that.notLiked();}
      }
    });
  };

  this.setUp = function(campaign, user) {
    this.campaign = campaign;
    this.user = user;
    this.setUpForm();
    return this;
  };

  this.disable = function() {
    this.form.find("input[type=button], input[type=submit]").each(function() {
      $(this).attr("disabled", true);
    });
  };

  this.enable = function() {
    this.form.find("input[type=button], input[type=submit]").each(function() {
      $(this).attr("disabled", false);
    });
  };

  this.loginHandler = function(response) {
    if (response.session) {
      SocialBuilder.track({event_code : "permissions_granted"});
      that.setUserInfoAndSubmit();
    }
    else {
      SocialBuilder.track({event_code : "permissions_denied"});
      $("#user_data").attr("value", "{}");
      that.form.submit();
    }
  };

  this.setUserInfoAndSubmit = function() {
    FB.api("/me", function(response) {
      $("#user_data").attr("value", JSON.stringify(response));
      that.form.submit();
    });
  };

  this.submitHandler = function() {
    if (!FB.getSession()) {
      SocialBuilder.track({event_code : "permissions_dialog"});
      FB.login(that.loginHandler, {perms: that.campaign.permissions});
    }
    else {
      that.setUserInfoAndSubmit();
    }
  };
};