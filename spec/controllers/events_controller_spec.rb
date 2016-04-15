require 'rails_helper'

describe EventsController do
  describe '#authorize' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, user: user) }

    it '#index' do
      get :index, format: :json
      expect(response.status).to eql(401)
      expect(response.message).to eql('Unauthorized')
    end

    it '#show' do
      get :show, { id: event.id, format: :json }
      expect(response.status).to eql(401)
      expect(response.message).to eql('Unauthorized')
    end

    it '#create' do
      post :create, { event: {}, format: :json }
      expect(response.status).to eql(401)
      expect(response.message).to eql('Unauthorized')
    end

    it '#update' do
      put :update, { id: event.id, event: {}, format: :json }
      expect(response.status).to eql(401)
      expect(response.message).to eql('Unauthorized')
    end

    it '#destroy' do
      delete :destroy, { id: event.id, format: :json }
      expect(response.status).to eql(401)
      expect(response.message).to eql('Unauthorized')
    end
  end

  describe '#index' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event) }
    let!(:my_events) { create_list(:event, 2, :with_comments, user: user, count_comments: 2) }

    before { sign_in(user) }

    it 'should return my events' do
      get :index, { format: :json }
      expect(JSON.parse(response.body).is_a?(Array)).to be_truthy
      expect(JSON.parse(response.body).size).to eql(2)
    end
  end

  describe '#show' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, :with_comments, user: user, count_comments: 2) }

    before { sign_in(user) }

    it 'should return event' do
      get :show, { id: event.id, format: :json }
      expect(JSON.parse(response.body).is_a?(Hash)).to be_truthy
    end
  end

  describe '#create' do
    let!(:user) { create(:user) }
    let(:event_data) { { 'title' => 'Some title', 'starts_at' => '12.12.2015', 'recurs_on' => 'month' } }

    before { sign_in(user) }

    it 'should create event' do
      post :create, { event: event_data, format: :json }
      expect(Event.count).to eql(1)
      expect(Event.first.title).to eql('Some title')
      expect(JSON.parse(response.body).is_a?(Hash)).to be_truthy
    end

    it 'should not create event cause validation error' do
      post :create, { event: event_data.except('title'), format: :json }
      expect(JSON.parse(response.body).dig('event', 'errors')).to be_present
    end
  end

  describe '#update' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, user: user) }
    let(:event_data) { { 'title' => 'Some title', 'starts_at' => '12.12.2015', 'recurs_on' => 'month' } }

    before { sign_in(user) }

    it 'should update event' do
      put :update, { id: event.id, event: event_data, format: :json }
      expect(event.reload.title).to eql('Some title')
      expect(JSON.parse(response.body).is_a?(Hash)).to be_truthy
    end

    it 'should not update event cause validation error' do
      put :update, { id: event.id, event: event_data.merge('title' => ''), format: :json }
      expect(JSON.parse(response.body).dig('event', 'errors')).to be_present
    end
  end

  describe '#destroy' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, user: user) }

    before { sign_in(user) }

    it 'should destroy event' do
      delete :destroy, { id: event.id, format: :json }
      expect(Event.count).to eql(0)
      expect(response.body).to be_blank
    end
  end
end
