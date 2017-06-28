FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "abcd1234"
    password_confirmation "abcd1234"
    factory :super_admin do
      super_admin true
    end
  end
end
