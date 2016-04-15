require 'rails_helper'

describe Comment do
  subject { build(:comment) }

  it { should validate_presence_of(:body) }
  it { should belong_to(:user) }
  it { should belong_to(:event) }
end
