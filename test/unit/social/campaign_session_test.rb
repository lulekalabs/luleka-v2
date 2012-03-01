require "test_helper"
require "ostruct"

module Social
  class CampaignSessionTest < ActiveSupport::TestCase

    def setup
      Ambry.remove_adapter :cookie
      Ambry::Adapter.new :name => :cookie
      @campaign_session = Campaign.first.session
      @campaign_session.request = OpenStruct.new({
        :remote_ip => "127.0.0.1",
        :params => {
          :event => {
            :event_code => "foo"
          }
        }
      })
    end

    def teardown
      Ambry.remove_adapter :cookie
    end

    test "should create Event when like status changes" do
      @campaign_session.liked_value = true
      assert_difference "Social::Event.count" do
        @campaign_session.update liked: false
      end
    end

    test "should not create Event when like status is unchanged" do
      assert_no_difference "Social::Event.count" do
        @campaign_session.liked_value = false
        @campaign_session.update liked: false
        @campaign_session.liked_value = nil
        @campaign_session.update liked: nil
        @campaign_session.liked_value = true
        @campaign_session.update liked: true
      end
    end
  
  end
end