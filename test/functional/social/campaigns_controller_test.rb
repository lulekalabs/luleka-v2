require 'test_helper'

class Social::CampaignsControllerTest < ActionController::TestCase
  
  should "show" do
    get :show
    assert_template "show"
  end

  should "over" do
    get :over
    assert_template "over"
  end

  should "rules" do
    get :rules
    assert_template "rules"
  end
  
end
