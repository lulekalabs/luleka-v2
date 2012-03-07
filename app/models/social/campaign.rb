require "core_ext/hash/camelize"
require "ambry/active_model"

module Social
  class Campaign
    extend Ambry::Model
    extend Ambry::ActiveModel

    field :uuid,
      :api_key,
      :client_name,
      :end_date,
      :name,
      :page_id,
      :recomendation_image_url,
      :recommendation_body,
      :recommendation_title,
      :require_unique_email,
      :require_unique_uid,
      :permissions,
      :secret_key,
      :start_date

    validates_presence_of :api_key,
      :client_name,
      :end_date,
      :name,
      :page_id,
      :recomendation_image_url,
      :recommendation_body,
      :recommendation_title,
      :require_unique_email,
      :require_unique_uid,
      :permissions,
      :secret_key,
      :start_date

    def page_data
      {
        :app_id             => self.api_key,
        :permissions        => self.permissions,
        :name               => self.name,
        :caption            => self.recommendation_title,
        :picture            => self.recomendation_image_url,
        :description        => self.recommendation_body,
        :require_unique_uid => self.require_unique_uid
      }
    end

    def session
      CampaignSession.get to_param
    rescue Ambry::NotFoundError
      CampaignSession.create campaign_id: to_param
    end

    def videos
      scoped = Video.scoped
      scoped = scoped.where("videos.campaign_id = ?", self.uuid)
      scoped
    end

    def over?
      Time.zone.now > end_date
    end

    def started?
      Time.zone.now > start_date
    end

    def hasnt_started_yet?
      !started?
    end

    unless Rails.env.production?
      def test_user_api
        @test_user_api or begin
          @test_user_api = Koala::Facebook::TestUsers.new(:app_id => self.api_key, :secret => self.secret_key)
        end
      end
    end

  end
end