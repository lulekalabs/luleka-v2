FactoryGirl.define do

  factory :registration do
    # sequence(:email) {|n| "user#{n}@example.com" }
    email "test@example.com"
    language_code 'en'
    country_code 'us'
  end

end