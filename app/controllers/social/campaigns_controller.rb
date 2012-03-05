class Social::CampaignsController < Social::SocialApplicationController
  skip_before_filter :verify_authenticity_token, :only => :show
  before_filter :like_gate, :only => :show

  def show
  end

  protected

  def like_gate
    if inside_facebook? && @campaign.session.liked?
      redirect_to new_social_registration_path
    end
  end
  
end
