require 'test_helper'

class SitemapsControllerTest < ActionController::TestCase     
  test "show with txt format" do
    get :show, :format => "txt"
    assert_response :success
  end

  test "show with xml format" do
    get :show, :format => "xml"
    assert_response :success
  end

  test "show with html format shoud redirect" do
    get :show
    assert_redirected_to root_url
  end
end
