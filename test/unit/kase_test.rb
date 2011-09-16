require 'test_helper'

class KaseTest < ActiveSupport::TestCase
  include Nl::Test::ValidAttributes
  
  test "should create unique id" do
    kase = Kase.new kase_attributes
    assert kase.valid?
    assert kase.uid.present?
  end
end
