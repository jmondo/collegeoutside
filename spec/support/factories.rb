FactoryGirl.define do

  factory :user do
    sequence(:name)                 { |n| "John Doe#{n}" }
    sequence(:email)                { |n| "user#{n}@example.com" }
    role                            "user"
    password                        "password"
    password_confirmation           "password"
    invitation_accepted_at          { Time.now }

    trait :chief do
      role                             "chief"
    end

    factory :editor_in_chief, traits: [:chief]

  end

  factory :article do
    user
    body                    "Here is the body of my post!"
    sequence(:title)        { |n| "##{n} Article!" }
    region
    state
    school
    activities              { [FactoryGirl.build(:activity)] }
    cover_photo             { File.open(Rails.root.join('spec/support/attachment_fixtures/article.png')) }
    cover_photo_caption     "Article caption!"
    seasons                 { [FactoryGirl.build(:season)] }

    trait :published do
      published_at          { Time.now }
    end
    factory :published_article, traits: [:published]
  end

  factory :region do
    sequence(:name)        { |n| "Region#{n}" }
  end

  factory :state do
    sequence(:name)        { |n| "State#{n}" }
    sequence(:abbreviation){ |n| "S#{n}" }
  end

  factory :school do
    sequence(:name)        { |n| "Some School #{n}" }
  end

  factory :activity do
    sequence(:name)        { |n| "Activity #{n}" }
  end

  factory :season do
    sequence(:name)        { |n| "Season #{n}" }
  end
end
