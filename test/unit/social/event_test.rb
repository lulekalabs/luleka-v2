require 'test_helper'

module Social
  class EventTest < ActiveSupport::TestCase
    test "should create campaign tracking event" do
      transaction do
        assert Event.create Event.sample
      end
    end

    test "should validate tracking code id is an index of CODES" do
      too_big   = Event::CODES.length
      too_small = -1

      Event::CODES.each_with_index do |index|
        event = Event.new Event.sample.merge code_id: index
        assert event.valid?, "#{index} should be a valid event code"
      end

      event = Event.new Event.sample.merge code_id: too_big
      refute event.valid?, "#{too_big} should not be a valid event code"
      event = Event.new Event.sample.merge code_id: -1
      refute event.valid?, "#{too_small} should not be a valid event code"
    end

    test "should create report after create if necessary" do
      transaction do
        assert_equal 0, Report.count
        Event.create! Event.sample
        assert_equal 1, Report.count
      end
    end

    test "should not create report after create when unnecessary" do
      transaction do
        Report.create! date: Date.today, :viral => false
        assert_equal 1, Report.count
        Event.create! Event.sample
        assert_equal 1, Report.count
      end
    end

    test "should increment report counters" do
      transaction do
        report = Report.create! date: Date.today, :viral => false
        Event.create! Event.sample
        report.reload
        assert_equal 1, report.liked
      end
    end

  end

  class EventCodeTest < ActiveSupport::TestCase
    test "[] should return an Event::Code id" do
      assert_equal 7, Event::Code["view_invite_page"]
      assert_equal 7, Event::Code[:view_invite_page]
    end
  end
end