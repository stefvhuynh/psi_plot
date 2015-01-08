require 'rails_helper'

RSpec.describe Api::UsersController, :type => :controller do
  describe 'POST #create' do
    def make_post_request_with_valid_attrs
      post :create, user: FactoryGirl.attributes_for(:user), format: :json
    end

    def make_post_request_with_invalid_attrs
      post :create,
        user: FactoryGirl.attributes_for(:invalid_user),
        format: :json
    end

    context 'with valid attributes' do
      before(run: true) { make_post_request_with_valid_attrs }

      it 'responds with a 200 OK status', run: true do
        expect(response.status).to eq 200
      end

      it 'creates and saves a user in the database' do
        expect {
          make_post_request_with_valid_attrs
        }.to change(User, :count).by 1
      end

      it 'renders user show template', run: true do
        expect(response).to render_template :show
      end
    end

    context 'with invalid attributes' do
      before(run: true) { make_post_request_with_invalid_attrs }

      it 'responds with a 422 Unprocessable Entity', run: true do
        expect(response.status).to eq 422
      end

      it 'does not create a user in the database' do
        expect {
          make_post_request_with_invalid_attrs
        }.not_to change(User, :count)
      end

      it 'renders with error messages', run: true do
        expect(response.body).to include 'errors'
      end
    end
  end
end
