path = File.expand_path("../../facebook.yml", __FILE__)
facebook_config = YAML.load(File.read(path))[Rails.env]

if Rails.env.production?
  Social::Campaign.create! \
    :uuid                    => "f7daf30c-8bc0-42a5-8125-f31665d755a4",
    :client_name             => "Luleka",
    :name                    => 'Sweepstakes',
    :recomendation_image_url => "http://www.luleka.com/assets/fb/sweepstakes-50x50.png",
    :recommendation_body     => "Enter our sweepstakes and you could win the new iPad or the new Apple TV!",
    :recommendation_title    => "You could win the new iPad or Apple TV!",
    :require_unique_email    => true,
    :require_unique_uid      => true,
    :permissions             => "user_likes",
    :start_date              => 100.days.from_now,
    :end_date                => 190.days.from_now,
    :api_key                 => facebook_config["api_key"],
    :secret_key              => facebook_config["secret_key"],
    :page_id                 => facebook_config["page_id"]
else
  Social::Campaign.create! \
    :uuid                    => "f7daf30c-8bc0-42a5-8125-f31665d755a4",
    :client_name             => "Luleka",
    :name                    => 'Sweepstakes',
    :recomendation_image_url => "http://localhost:3000/assets/fb/sweepstakes-50x50.png",
    :recommendation_body     => "Enter our sweepstakes and you could win the new iPad or the new Apple TV!",
    :recommendation_title    => "You could win the new iPad or Apple TV!",
    :require_unique_email    => true,
    :require_unique_uid      => true,
    :permissions             => "user_likes",
    :start_date              => 1.second.ago,
    :end_date                => 90.days.from_now,
    :api_key                 => facebook_config["api_key"],
    :secret_key              => facebook_config["secret_key"],
    :page_id                 => facebook_config["page_id"]
end