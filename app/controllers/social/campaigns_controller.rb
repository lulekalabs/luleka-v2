class Social::CampaignsController < Social::SocialApplicationController
  skip_before_filter :verify_authenticity_token, :only => :show
  before_filter :like_gate

  protected

  def like_gate
    if !inside_facebook? || @campaign.session.liked?
      redirect_to new_registration_path
    end
  end
  
  def inside_facebook?
    params[:signed_request].present?
  end
  helper_method :inside_facebook?

  def inside_standalone_app?
    false
  end
  helper_method :inside_standalone_app?
  
end
