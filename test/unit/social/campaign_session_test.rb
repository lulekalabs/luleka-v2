require "test_helper"
require "ostruct"

module Social
  class CampaignSessionTest < ActiveSupport::TestCase

    def setup
      Ambry.remove_adapter :cookie
      Ambry::Adapter.new :name => :cookie
      @campaign = Campaign.first
      @campaign_session = CampaignSession.create campaign_id: @campaign.to_param
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
    
    should "find or create by id" do
      session = CampaignSession.find_or_create_by_id("f7daf30c-8bc0-42a5-8125-f31665d755a4") do |session|
        session.campaign_id = @campaign.to_param
      end
      assert_equal "f7daf30c-8bc0-42a5-8125-f31665d755a4", session.id
      assert_equal @campaign.to_param, session.campaign_id
      assert_equal @campaign, session.campaign

      session = CampaignSession.find_or_create_by_id("f7daf30c-8bc0-42a5-8125-f31665d755a4")
      assert_equal "f7daf30c-8bc0-42a5-8125-f31665d755a4", session.id
      
      session = CampaignSession.get "f7daf30c-8bc0-42a5-8125-f31665d755a4"
      assert_equal @campaign.to_param, session.campaign_id
    end
    
  end
end