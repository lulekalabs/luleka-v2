class Social::ReferralsController < Social::SocialApplicationController

  def show
    @campaign.session.update referrer: params[:u]
    redirect_to params[:t]
  end

end
