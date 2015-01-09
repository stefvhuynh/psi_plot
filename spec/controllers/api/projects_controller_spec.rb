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
      before(run: true) do
        sign_in(user)
        get :index, format: :json
      end

      after { sign_out }

      it 'responds with a 200 OK status', run: true do
        expect(response.status).to eq 200
      end

      it 'fetches all the projects for a user', run: true do
        expect(assigns(:projects)).to match_array projects
      end

      it 'does not fetch the projects for other users' do
        user2 = FactoryGirl.create(:user)
        user2_projects = FactoryGirl.create_list(:project, 5, user_id: user2.id)

        sign_in(user)
        get :index, format: :json

        expect(assigns(:projects)).not_to include user2_projects
      end

      it 'renders the index template', run: true do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    def make_get_request(project)
      get :show, id: project, format: :json
    end

    context 'when signed out' do
      it 'responds with a 401 unauthorized' do
        sign_out
        make_get_request(projects.first)
        expect(response.status).to eq 401
      end
    end

    context 'when signed in' do
      before(run: true) do
        sign_in(user)
        make_get_request(projects.first)
      end

      after { sign_out }

      it 'responds with a 200 OK status', run: true do
        expect(response.status).to eq 200
      end

      it 'fetches the correct project', run: true do
        expect(assigns(:project)).to eq projects.first
      end

      it 'does not fetch projects from other users' do
        user2 = FactoryGirl.create(:user)
        user2_project = FactoryGirl.create(:project, user_id: user2.id)

        sign_in(user)
        make_get_request(user2_project)

        expect(response.status).to eq 403
        expect(assigns(:project)).not_to eq user2_project
      end

      it 'renders the show template', run: true do
        expect(response).to render_template :show
      end
    end
  end

  describe 'POST #create' do
    def make_post_request_with_valid_attrs(user_id)
      post :create,
        project: FactoryGirl.attributes_for(:project, user_id: user_id),
        format: :json
    end

    def make_post_request_with_invalid_attrs
      post :create,
        project: FactoryGirl.attributes_for(:invalid_project),
        format: :json
    end

    context 'signed out' do
      it 'responds with a 401 unauthorized' do
        make_post_request_with_valid_attrs(user.id)
        expect(response.status).to eq 401
      end

      it 'does not create a project in the database' do
        expect {
          make_post_request_with_valid_attrs(user.id)
        }.not_to change(Project, :count)
      end
    end

    context 'signed in' do
      before { sign_in(user) }
      after { sign_out }

      context 'with valid attributes' do
        before(run: true) { make_post_request_with_valid_attrs(user.id) }

        it 'responds with a 200 OK', run: true do
          expect(response.status).to eq 200
        end

        it 'creates a project for the signed in user' do
          expect {
            make_post_request_with_valid_attrs(user.id)
          }.to change(user.projects, :count).by 1
        end

        it 'does not create a project for a different user' do
          user2 = FactoryGirl.create(:user)
          expect {
            make_post_request_with_valid_attrs(user2.id)
          }.not_to change(user2.projects, :count)
        end

        it 'renders the show template', run: true do
          expect(response).to render_template :show
        end
      end

      context 'with invalid attributes' do
        before(run: true) { make_post_request_with_invalid_attrs }

        it 'responds with a 422 unprocessable entity', run: true do
          expect(response.status).to eq 422
        end

        it 'does not create a new item' do
          expect {
            make_post_request_with_invalid_attrs
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

    def make_put_request_with_valid_attrs(project_id, attrs)
      put :update,
        id: project_id,
        project: attrs,
        format: :json
    end

    def make_put_request_with_invalid_attrs
      put :update,
        id: project.id,
        project: FactoryGirl.attributes_for(
          :invalid_project, user_id: user.id
        ),
        format: :json
    end

    before { project.update(name: old_project_name) }

    context 'signed out' do
      before do
        sign_out
        make_put_request_with_valid_attrs(project.id, name: new_project_name)
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
      after { sign_out }

      context 'with valid attributes' do
        before(run: true) do
          make_put_request_with_valid_attrs(project.id, name: new_project_name)
        end

        it 'responds with a 200 ok', run: true do
          expect(response.status).to eq 200
        end

        it 'updates the project', run: true do
          expect(project.reload.name).to eq new_project_name
        end

        it 'does not allow the updating of the user_id' do
          make_put_request_with_valid_attrs(project.id, user_id: user.id + 1)
          expect(project.reload.user_id).to eq user.id
        end

        it 'does not allow the updating of a non-owned project' do
          user2 = FactoryGirl.create(:project)
          project2 = FactoryGirl.create(:project, user_id: user2.id)

          make_put_request_with_valid_attrs(project2.id, name: "#{project2.name} v.2.0")

          expect(response.status).to eq 404
          expect(project2.reload.name).to eq project2.name
        end
      end

      context 'with invalid attributes' do
        before { make_put_request_with_invalid_attrs }

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
    def make_delete_request(project)
      delete :destroy, id: project, format: :json
    end

    context 'signed out' do
      before do
        sign_out
        make_delete_request(projects.first)
      end

      it 'responds with a 401 unauthorized' do
        expect(response.status).to eq 401
      end

      it 'does not delete the record' do
        expect(Project.all).to include projects.first
      end
    end

    context 'signed in' do
      before(run: true) do
        sign_in(user)
        make_delete_request(projects.first)
      end

      after { sign_out }

      it 'responds with a 200 OK', run: true do
        expect(response.status).to eq 200
      end

      it 'deletes the record if the user owns it', run: true do
        expect(Project.all).not_to include projects.first
      end

      it 'does not delete the record if the user does not own it' do
        user2 = FactoryGirl.create(:user)
        user2_project = FactoryGirl.create(:project, user_id: user2.id)

        sign_in(user)
        make_delete_request(user2_project)

        expect(response.status).to eq 404
        expect(Project.all).to include user2_project
      end
    end
  end
end
