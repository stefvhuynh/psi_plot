require 'rails_helper'

RSpec.describe Api::ProjectShareController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe 'POST #create' do
    context 'signed in' do
      before { sign_in(user) }

      context 'with valid attributes' do
        before do
          post :create,
            project_share: FactoryGirl.attributes_for(:project_share),
            format: :json
        end

        it 'responds with a 200 OK status' do
          expect(response.status).to eq 200
        end

        it 'creates and saves a project_share in the database' do
          expect {
            post :create,
              project_share: FactoryGirl.attributes_for(:project_share),
              format: :json
          }.to change(ProjectShare, :count).by 1
        end

        it 'only creates a project_share for a project the user owns'

        it 'renders the project_share show template' do
          expect(response).to render_template :show
        end
      end

      context 'with invalid attributes' do
        it 'responds with a 422 Unprocessable Entity'
        it 'does not create a project_share in the database'
        it 'responds with error messages'
      end
    end

    context 'signed out' do
      before { sign_out }
    end
  end

  describe 'DELETE #destory' do
    context 'signed in' do

    end

    context 'signed out' do

    end
  end

end
