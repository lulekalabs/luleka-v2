require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  should "validate email formatting" do
    registration = Registration.new :email => "test@example.com"
    assert_no_error_on registration, :email
  end

  should "not validate email formatting" do
    registration = Registration.new :email => "test@com"
    assert_error_on registration, :email
  end
  
  should "locale" do
    registration = FactoryGirl.create :registration
    assert_equal :"en-US", registration.locale
  end
end
