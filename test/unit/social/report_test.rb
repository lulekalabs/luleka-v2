require 'test_helper'

module Social
  class ReportTest < ActiveSupport::TestCase

    test "should get viral and non-viral summary reports" do
      with_report_fixtures do
        assert_equal 2, Report.summary.length
      end
    end

  end
end