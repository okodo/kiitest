require 'rails_helper'

describe Event do
  subject { build(:event) }

  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }

  it '#validates format for starts_at' do
    should_not allow_value('').for(:starts_at)
    should_not allow_value('30-02-2015').for(:starts_at)
    should allow_value('2015-05-27 17:23').for(:starts_at)
    should allow_value('27.05.2015 17:23').for(:starts_at)
    should allow_value('27.05.15 17:23').for(:starts_at)
  end

  context '#enum recurs_on' do
    let(:event) { create(:event) }

    it 'default value' do
      expect(event.recurs_on).to be_eql('n_a')
    end

    it '.valid by number' do
      event.recurs_on = 1
      expect(event).to be_valid
      expect(event.recurs_on).to be_eql('day')
    end

    it '.valid by string' do
      event.recurs_on = 'month'
      expect(event).to be_valid
      expect(event.recurs_on).to be_eql('month')
    end

    it '.valid by symbol' do
      event.recurs_on = :year
      expect(event).to be_valid
      expect(event.recurs_on).to be_eql('year')
    end
  end
end
