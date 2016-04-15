require 'rails_helper'

describe CommentSerializer do
  subject { described_class.new(create(:comment)) }

  describe 'attributes' do
    it 'has id' do
      expect(subject.id).to be_kind_of Integer
    end

    it 'has body' do
      expect(subject.body).to be_kind_of String
    end

    it 'has created_at' do
      expect(subject.created_at).to be_kind_of Time
    end

    it 'has updated_at' do
      expect(subject.updated_at).to be_kind_of Time
    end

    it 'has user' do
      expect(subject.user).to be_present
    end
  end
end
