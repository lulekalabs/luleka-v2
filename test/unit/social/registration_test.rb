require 'test_helper'

module Social
  class RegistrationTest < ActiveSupport::TestCase
    test "should serialize user data" do
      transaction do
        assert reg = Registration.create!(Registration.sample)
        reg.reload
        assert_equal reg.user_data,
          ActiveSupport::JSON.decode(Registration.sample[:user_data])
      end
    end

    test "should create registration tracking event on creation" do
      transaction do
        scope = Event.where(:code_id => Event::Code["registration"])
        assert_equal 0, scope.count
        reg = Registration.create!(Registration.sample)
        assert_equal 1, scope.count
        assert_equal reg.id.to_s, scope.first.payload
      end
    end

    test "should create unique email tracking event on creation" do
      transaction do
        scope = Event.where(:code_id => Event::Code["unique_email"])
        assert_equal 0, scope.count
        reg = Registration.create!(Registration.sample)
        assert_equal 1, scope.count
        assert_equal reg.email, scope.first.payload
      end
    end

    test "should only record unique email tracking event once" do
      transaction do
        scope = Event.where(:code_id => Event::Code["unique_email"])
        assert_equal 0, scope.count
        2.times {Registration.create(Registration.sample)}
        assert_equal 1, scope.count
      end
    end
  end
end