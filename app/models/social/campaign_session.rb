require "koala"

module Social
  class CampaignSession
    extend Ambry::Model
    # use :cookie
    field :campaign_id, :liked, :page_id, :referrer, :registration_id

    attr_accessor :request

    def campaign
      @campaign ||= Campaign.get campaign_id
    end

    def liked?
      !! liked
    end

    alias liked_value= liked=

    def liked=(value)
      # TODO: set code_id directly
      code = value ? "liked" : "unliked"
      Event.create_from!(request, viral: !!referrer, event_code: code) if value != liked
      self.liked_value = value
    end

    def process_signed_request
      return unless data = request.params["signed_request"]
      parsed = fbclient.parse_signed_request data
      return unless parsed["page"]
      self.page_id = parsed["page"]["id"]
      self.liked = parsed["page"]["liked"]
      save
    end

    private

    def fbclient
      @fbclient ||= Koala::Facebook::OAuth.new campaign.api_key, campaign.secret_key
    end

  end
end