FactoryGirl.define do
  factory :site_user do
    site { Site.first || association(:site, name: Faker::Lorem.word, domain: Faker::Internet.domain_name) }
    association :user
  end
end
