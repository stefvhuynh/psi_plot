require 'rails_helper'

RSpec.describe Api::UsersController, :type => :controller do

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        post :create, user: FactoryGirl.attributes_for(:user), format: :json
      end

      it 'responds with a 200 OK status' do
        expect(response.status).to eq 200
      end

      it 'creates and saves a user in the database' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user), format: :json
        }.to change(User, :count).by 1
      end

      it 'renders user show template' do
        expect(response).to render_template :show
      end
    end

    context 'with invalid attributes' do
      before do
        post :create,
          user: FactoryGirl.attributes_for(:invalid_user),
          format: :json
      end

      it 'responds with a 422 Unprocessable Entity' do
        expect(response.status).to eq 422
      end

      it 'does not create a user in the database' do
        expect {
          post :create,
            user: FactoryGirl.attributes_for(:invalid_user),
            format: :json
        }.not_to change(User, :count)
      end

      it 'renders with error messages' do
        expect(response.body).to include 'errors'
      end
    end
  end

end
