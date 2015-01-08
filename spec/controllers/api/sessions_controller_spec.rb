require 'rails_helper'

RSpec.describe Api::SessionsController, :type => :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let(:user_credentials) do
        {
          first_name: 'Charlie',
          last_name: 'Brown',
          email: 'charliebrown@peanuts.com',
          password: '123abc'
        }
      end

      let!(:user) do
        FactoryGirl.create(:user, user_credentials)
      end

      before(run: true) do
        post :create, session: user_credentials, format: :json
      end

      it 'responds with a 200 OK', run: true do
        expect(response.status).to eq 200
      end

      it 'fetches the correct user', run: true do
        expect(assigns(:user)).to eq user
      end

      it 'signs in the user' do
        expect(subject).to receive(:sign_in!).with(user)
        post :create, session: user_credentials, format: :json
      end

      it 'renders the session show template', run: true do
        expect(response).to render_template :show
      end
    end

    context 'with invalid attributes' do
      before do
        post :create, session: { email: nil, password: nil }, format: :json
      end

      it 'responds with a 401 Unauthorized' do
        expect(response.status).to eq 401
      end

      it 'responds with error messages' do
        expect(response.body).to include 'errors'
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'responds with a 200 OK status' do
      allow(subject).to receive(:sign_out!).and_return nil
      delete :destroy
      expect(response.status).to eq 200
    end

    it 'signs the user out' do
      expect(subject).to receive(:sign_out!)
      delete :destroy
    end
  end
end
