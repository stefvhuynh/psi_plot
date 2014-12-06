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

      it 'renders the index template' do
        expect(response).to render_template :index
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

      it 'renders the show template' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'POST #create' do
    context 'signed out' do
      it 'responds with a 401 unauthorized' do
        post :create,
          project: FactoryGirl.attributes_for(:project),
          format: :json
        expect(response.status).to eq 401
      end

      it 'does not create a project in the database' do
        expect {
          post :create,
            project: FactoryGirl.attributes_for(:project),
            format: :json
        }.not_to change(Project, :count)
      end
    end

    context 'signed in' do
      before { sign_in(user) }
      after { sign_out }

      context 'with valid attributes' do
        before do
          post :create,
            project: FactoryGirl.attributes_for(:project, user_id: user.id),
            format: :json
        end

        it 'responds with a 200 OK' do
          expect(response.status).to eq 200
        end

        it 'creates a project for the signed in user' do
          expect {
            post :create,
              project: FactoryGirl.attributes_for(:project, user_id: user.id),
              format: :json
          }.to change(user.projects, :count).by 1
        end

        it 'does not create a project for a different user' do
          user2 = FactoryGirl.create(:user)
          expect {
            post :create,
              project: FactoryGirl.attributes_for(:project, user_id: user2.id),
              format: :json
          }.not_to change(user2.projects, :count)
        end

        it 'renders the show template' do
          expect(response).to render_template :show
        end
      end

      context 'with invalid attributes' do
        before(run: true) do
          post :create,
            project: FactoryGirl.attributes_for(:invalid_project),
            format: :json
        end

        it 'responds with a 422 unprocessable entity', run: true do
          expect(response.status).to eq 422
        end

        it 'does not create a new item' do
          expect {
            post :create,
              project: FactoryGirl.attributes_for(:invalid_project),
              format: :json
          }.not_to change(Project, :count)
        end

        it 'renders error messages', run: true do
          expect(response.body).to include 'errors'
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:old_project_name) { Faker::App.name }
    let(:new_project_name) { "#{old_project_name} v.2.0" }
    let(:project) do
      FactoryGirl.create(:project, name: old_project_name, user_id: user.id)
    end

    before { project.update(name: old_project_name) }

    context 'signed out' do
      before do
        sign_out
        put :update,
          id: project.id,
          project: { name: new_project_name },
          format: :json
      end

      it 'responds with a 401 unauthorized' do
        expect(response.status).to eq 401
      end

      it 'does not update the record' do
        expect(project.name).to eq old_project_name
      end
    end

    context 'signed in' do
      before { sign_in(user) }

      context 'with valid attributes' do
        before do
          put :update,
            id: project.id,
            project: { name: new_project_name },
            format: :json
        end

        it 'responds with a 200 ok' do
          expect(response.status).to eq 200
        end

        it 'updates the project' do
          expect(project.reload.name).to eq new_project_name
        end

        it 'does not allow the updating of the user_id' do
          put :update,
            id: project.id,
            project: { user_id: user.id + 1 },
            format: :json
          expect(project.reload.user_id).to eq user.id
        end

        it 'does not allow the updating of a non-owned project' do
          user2 = FactoryGirl.create(:project)
          project2 = FactoryGirl.create(:project, user_id: user2.id)
          put :update,
            id: project2.id,
            project: { name: "#{project2.name} v.2.0" },
            format: :json
          expect(response.status).to eq 404
          expect(project2.reload.name).to eq project2.name
        end
      end

      context 'with invalid attributes' do
        before do
          put :update,
            id: project.id,
            project: FactoryGirl.attributes_for(
              :invalid_project, user_id: user.id
            ),
            format: :json
        end

        it 'responds with a 422 unprocessable entity' do
          expect(response.status).to eq 422
        end

        it 'does not update the record' do
          expect(project.reload.name).to eq old_project_name
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'signed out' do
      before do
        sign_out
        delete :destroy, id: projects.first, format: :json
      end

      it 'responds with a 401 unauthorized' do
        expect(response.status).to eq 401
      end

      it 'does not delete the record' do
        expect(Project.all).to include projects.first
      end
    end

    context 'signed in' do
      before do
        sign_in(user)
        delete :destroy, id: projects.first, format: :json
      end

      it 'responds with a 200 OK' do
        expect(response.status).to eq 200
      end

      it 'deletes the record if the user owns it' do
        expect(Project.all).not_to include projects.first
      end

      it 'does not delete the record if the user does not own it' do
        user2 = FactoryGirl.create(:user)
        user2_project = FactoryGirl.create(:project, user_id: user2.id)
        delete :destroy, id: user2_project, format: :json
        expect(response.status).to eq 404
        expect(Project.all).to include user2_project
      end
    end
  end

end
