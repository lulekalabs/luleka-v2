class Social::CampaignsController < Social::SocialApplicationController
  skip_before_filter :verify_authenticity_token, :only => :show
  before_filter :ensure_rules, :only => :show
  before_filter :like_gate, :only => :show

  def show
  end
  
  def over
  end
  
  def rules
  end

  protected

  def like_gate
    if inside_facebook? && @campaign.session.liked?
      redirect_to new_social_registration_path
    end
  end
  
  def ensure_rules
    if @campaign.over? || @campaign.hasnt_started_yet?
      redirect_to social_campaign_over_path
      return
    end
  end
  
end
