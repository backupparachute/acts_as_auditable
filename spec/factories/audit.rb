FactoryGirl.define do

  factory :audit, class: 'ActsAsAuditable::Audit' do
    audited_changes "MyText"
    remote_address  { Faker::Internet.ip_v4_address }
  end

end
