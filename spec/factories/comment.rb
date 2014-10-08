FactoryGirl.define do

  factory :comment do
    content     { Faker::Lorem.paragraph(2) }
    association :user
    association :recipe
  end

end
