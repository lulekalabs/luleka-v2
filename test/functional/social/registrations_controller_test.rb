require 'test_helper'

class Social::RegistrationsControllerTest < ActionController::TestCase
  should "new" do
    get :new
    assert_template "new"
  end
  
  should "post" do
    assert_difference "Social::Registration.count" do
      post :create, :social_registration => {:first_name => "Hans", :last_name => "Zimmer", :email => "accepted@example.com",
         :ip_address => "172.45.3.21", :locale => "en", :country_code => "US", :time_zone => "America/Argentina/Buenos_Aires"}
      assert_response :redirect
    end
  end
end
