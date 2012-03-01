require 'test_helper'

class Social::EventTest < ActiveSupport::TestCase
  should "new" do
    assert Social::Event.new
  end
end
