FactoryGirl.define do

  factory :registration do
    # sequence(:email) {|n| "user#{n}@example.com" }
    email "test@example.com"
    locale 'en'
    country_code 'US'
    ip_address "127.0.0.1"
    time_zone "Paris"
    lat 48.864715
    lng 2.373047
    city "Paris"
    postal_code "1456"
    region_code "01"
    region_name "Paris City"
  end

  factory :social_registration do
    email "test@facebook.com"
    locale 'en'
    country_code 'US'
    ip_address "127.0.0.1"
    time_zone "Buenos Aires"
    lat -34.5875
    lng -58.6725
    city "Buenos Aires"
    postal_code "1640"
    region_code "07"
    region_name "Distrito Federal"
    first_name "Hans"
    last_name "Zimmer"
    opt_in false
    type "social_registration"
    uid "1234567890"
    referrer_uid "0123456789"
  end

end