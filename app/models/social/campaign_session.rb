require "koala"

module Social
  class CampaignSession
    extend Ambry::Model
    field :id, :campaign_id, :liked, :page_id, :referrer, :registration_id, :parsed_signed_request, :country, :locale

    attr_accessor :request

    def self.find_or_create_by_id(id, &block)
      session = nil
      begin
        session = CampaignSession.get id
      rescue Ambry::NotFoundError
        session = CampaignSession.create id: id
      end
      if block_given?
        yield session
        session.save
      end
      session
    end

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
      self.parsed_signed_request ||= parsed
      self.page_id = parsed["page"]["id"]
      self.liked   = parsed["page"]["liked"]
      self.country = parsed["user"]["country"]
      self.locale  = parsed["user"]["locale"].blank? ? nil : parsed["user"]["locale"].gsub(/_/, "-")
      save
    end
    
    def signed_request?
      !!parsed_signed_request
    end

    private

    def fbclient
      @fbclient ||= Koala::Facebook::OAuth.new campaign.api_key, campaign.secret_key
    end

  end
end