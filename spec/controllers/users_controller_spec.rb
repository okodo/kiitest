require 'rails_helper'

describe UsersController do
  describe 'update' do
    let!(:user) { create(:user) }

    it 'only for authorized users' do
      put :update, id: 666, format: :json
      expect(response.status).to eql(401)
      expect(response.message).to eql('Unauthorized')
    end

    it 'change fullname and email' do
      sign_in(user)
      put :update, { id: user.id, user: { 'fullname' => 'New origin fullname', 'email' => 'kii@email.com' }, format: :json }
      expect(JSON.parse(response.body).is_a?(Hash)).to be_truthy
    end

    it 'get validations errors' do
      sign_in(user)
      put :update, { id: user.id, user: { 'email' => 'kiiemail.com' }, format: :json }
      expect(JSON.parse(response.body).dig('user', 'errors')).to be_present
    end
  end
end
