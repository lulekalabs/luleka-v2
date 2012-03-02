require 'test_helper'

class Splash::PagesControllerTest < ActionController::TestCase
  
  should "index" do
    get :index
    assert_response :ok
  end
end
