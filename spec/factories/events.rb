FactoryGirl.define do
  factory :event do
    transient do
      count_comments 1
    end
    sequence(:title) {|n| "Event #{n}" }
    sequence(:starts_at) {|n| Time.now + n.days }

    after(:build) do |event, _|
      event.user_id = create(:user).id if event.user_id.blank?
    end

    trait :with_comments do
      after :create do |event, evaluator|
        create_list(:comment, evaluator.count_comments, event: event)
      end
    end
  end
end
