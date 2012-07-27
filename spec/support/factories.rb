FactoryGirl.define do

  factory :user do
    sequence(:name)                 { |n| "John Doe#{n}" }
    sequence(:email)                { |n| "user#{n}@example.com" }
    role                            "user"
    password                        "password"
    password_confirmation           "password"
    invitation_accepted_at          { Time.now }
  end

  trait :chief do
    role                             "chief"
  end

  factory :editor_in_chief, traits: [:chief]

end
