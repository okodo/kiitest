require 'rails_helper'

describe UserSerializer do
  subject { described_class.new(create(:user)) }

  describe 'attributes' do
    it 'has id' do
      expect(subject.id).to be_kind_of Integer
    end

    it 'has fullname' do
      expect(subject.fullname).to be_kind_of String
    end

    it 'has email' do
      expect(subject.email).to be_kind_of String
    end

    it 'has created_at' do
      expect(subject.created_at).to be_kind_of Time
    end

    it 'has updated_at' do
      expect(subject.updated_at).to be_kind_of Time
    end
  end
end
