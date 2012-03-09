class Social::CampaignsController < Social::SocialApplicationController
  skip_before_filter :verify_authenticity_token, :only => :show
  before_filter :like_gate, :only => :show

  def show
  end
  
  def over
  end
  
  def rules
    @body_id = "rules"
    I18n.locale = :"en"
  end

  protected

  def like_gate
    if !inside_facebook? && Rails.env.production?
      redirect_to social_campaign_over_path
    elsif inside_facebook? && @campaign.session.liked?
      redirect_to new_social_registration_path
    end
  end
  
end
