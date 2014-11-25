require 'rails_helper'

RSpec.describe Api::ProjectsController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }
  let!(:projects) { FactoryGirl.create_list(:project, 5, user_id: user.id) }

  describe 'GET #index' do
    context 'when signed out' do
      it 'responds with a 401 unauthorized' do
        sign_out
        get :index, format: :json
        expect(response.status).to eq 401
      end
    end

    context 'when signed in' do
      before do
        sign_in(user)
        get :index, format: :json
      end

      after { sign_out }

      it 'responds with a 200 OK status' do
        expect(response.status).to eq 200
      end

      it 'fetches all the projects for a user' do
        expect(assigns(:projects)).to match_array projects
      end

      it 'does not fetch the projects for other users' do
        user2 = FactoryGirl.create(:user)
        user2_projects = FactoryGirl.create_list(:project, 5, user_id: user2.id)
        get :index, format: :json
        expect(assigns(:projects)).not_to include user2_projects
      end
    end
  end

  describe 'GET #show' do
    context 'when signed out' do
      it 'responds with a 401 unauthorized' do
        get :show, id: projects.first, format: :json
        expect(response.status).to eq 401
      end
    end

    context 'when signed in' do
      before do
        sign_in(user)
        get :show, id: projects.first, format: :json
      end

      after { sign_out }

      it 'responds with a 200 OK status' do
        expect(response.status).to eq 200
      end

      it 'fetches the correct project' do
        expect(assigns(:project)).to eq projects.first
      end

      it 'does not fetch projects from other users' do
        user2 = FactoryGirl.create(:user)
        user2_project = FactoryGirl.create(:project, user_id: user2.id)
        get :show, id: user2_project, format: :json
        expect(response.status).to eq 403
        expect(assigns(:project)).not_to eq user2_project
      end
    end
  end

  describe 'POST #create' do

  end

  describe 'PUT #update' do

  end

  describe 'DELETE #destroy' do

  end

end
