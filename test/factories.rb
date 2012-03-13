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
    region_code "PA"
    metrocode "Paris"
  end

  factory :social_registration do
    email "test@facebook.com"
    locale 'en'
    country_code 'US'
    ip_address "127.0.0.1"
    time_zone "Buenos Aires"
    lat 31.952162
    lng 85.078125
    city "GCBA"
    postal_code "1640"
    region_code "AR"
    metrocode "Buenos Aires"
    first_name "Hans"
    last_name "Zimmer"
    opt_in false
    type "social_registration"
    uid "1234567890"
    referrer_uid "0123456789"
  end

end