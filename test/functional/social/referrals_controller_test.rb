require 'test_helper'

class Social::ReferralsControllerTest < ActionController::TestCase
  
  should "show" do
    get :show, :u => "1234567890", :t => "http://www.example.com"
    assert_response :redirect
  end
  
end
