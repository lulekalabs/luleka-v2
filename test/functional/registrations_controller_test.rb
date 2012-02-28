require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  
  should "post" do
    assert_difference "Registration.count" do
      post :create, :registration => {:email => "accepted@example.com", :ip_address => "172.45.3.21", 
        :language_code => "en", :country_code => "US"}
      assert_response :redirect
    end
  end

  should "xhr post" do
    assert_difference "Registration.count" do
      xhr :post, :create, :registration => {:email => "accepted@example.com", :ip_address => "172.45.3.21", 
        :language_code => "en", :country_code => "US"}
      assert_template "registrations/create"
    end
  end
  
end
