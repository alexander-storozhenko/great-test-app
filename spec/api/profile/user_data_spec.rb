require 'rails_helper'
require 'shared/access_token'

describe API::Profile::UserData do
  context 'when admin' do
    include_context 'admin'
    let(:path) {'/api/v1/profile/user_data'}
    it 'test' do
        get path,
            headers: { 'Access-Token': access_token}
            p response.body
      expect(response.status).to eq 200
    end
  end
end