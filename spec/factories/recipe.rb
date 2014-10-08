FactoryGirl.define do

  factory :recipe do
    name        { Faker::Company.catch_phrase }
    description { Faker::Lorem.paragraph(2, true, 4) }
    image_url   { Faker::Internet.url }
    association :user
  end

end
