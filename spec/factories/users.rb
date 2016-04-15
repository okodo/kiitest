FactoryGirl.define do
  factory :user do
    fullname { FFaker::Name.name.delete("'") }
    email { FFaker::Internet.email }
    password 'qwertz123'
    password_confirmation 'qwertz123'
  end
end
