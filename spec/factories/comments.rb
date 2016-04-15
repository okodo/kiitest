FactoryGirl.define do
  factory :comment do
    sequence(:body) {|n| "Comment #{n}" }

    after(:build) do |comment, _|
      comment.event_id = create(:event).id if comment.event_id.blank?
      comment.user_id = create(:user).id if comment.user_id.blank?
    end
  end
end
