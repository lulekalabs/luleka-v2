path = File.expand_path("../../facebook.yml", __FILE__)
facebook_config = YAML.load(File.read(path))[Rails.env]

Social::Campaign.create! \
  :uuid                    => "f7daf30c-8bc0-42a5-8125-f31665d755a4",
  :client_name             => "Luleka",
  :name                    => 'Luleka Sweepstakes',
  :recomendation_image_url => "http://placekitten.com/g/50/50",
  :recommendation_body     => "Enter our sweepstakes and you could win cool stuff!",
  :recommendation_title    => "Enter our sweepstakes",
  :require_unique_email    => true,
  :require_unique_uid      => true,
  :permissions             => "user_likes",
  :start_date              => 1.second.ago,
  :end_date                => 90.days.from_now,
  :api_key                 => facebook_config["api_key"],
  :secret_key              => facebook_config["secret_key"],
  :page_id                 => facebook_config["page_id"]
