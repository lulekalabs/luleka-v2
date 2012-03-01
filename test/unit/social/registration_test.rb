require 'test_helper'

class Social::RegistrationTest < ActiveSupport::TestCase
  
  should "new" do
    assert Social::Registration.new
  end

end
