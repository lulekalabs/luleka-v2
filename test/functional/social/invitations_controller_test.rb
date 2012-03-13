require 'test_helper'

class Social::InvitationsControllerTest < ActionController::TestCase
  should "new" do
    get :new
    assert_template "new"
  end
end
