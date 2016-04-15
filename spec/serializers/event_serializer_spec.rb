require 'rails_helper'

describe EventSerializer do
  subject { described_class.new(create(:event, :with_comments, count_comments: 2)) }

  describe 'attributes' do
    it 'has id' do
      expect(subject.id).to be_kind_of Integer
    end

    it 'has title' do
      expect(subject.title).to be_kind_of String
    end

    it 'has recurs_on' do
      expect(subject.recurs_on).to be_kind_of String
    end

    it 'has starts_at' do
      expect(subject.starts_at).to be_kind_of Time
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

    it 'has comments' do
      expect(subject.comments.load).to be_present
    end
  end
end
