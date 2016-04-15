require 'rails_helper'

describe CommentsController do
  describe 'create' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, user: user) }
    let(:comment_data) { { 'body' => 'Some comment' } }

    it 'only for authorized users' do
      post :create, event_id: event.id, format: :json
      expect(response.status).to eql(401)
      expect(response.message).to eql('Unauthorized')
    end

    it 'should create a new comment' do
      sign_in(user)
      post :create, { event_id: event.id, comment: comment_data, format: :json }
      expect(JSON.parse(response.body).is_a?(Hash)).to be_truthy
    end

    it 'should not create a new comment cause validation errors' do
      sign_in(user)
      post :create, { event_id: event.id, comment: { 'body' => '' }, format: :json }
      expect(JSON.parse(response.body).dig('comment', 'errors')).to be_present
    end
  end
end
