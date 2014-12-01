require 'rails_helper'

RSpec.describe Api::ProjectSharesController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }

  describe 'POST #create' do
    context 'signed in' do
      before { sign_in(user) }

      context 'with valid attributes' do
        before(run: true) do
          post :create,
            project_share: build_attributes(
              :project_share,
              project_id: project.id
            ),
            format: :json
        end

        it 'responds with a 200 OK status', run: true do
          expect(response.status).to eq 200
        end

        it 'creates and saves a project_share in the database' do
          expect {
            post :create,
              project_share: build_attributes(
                :project_share,
                project_id: project.id
              ),
              format: :json
          }.to change(ProjectShare, :count).by 1
        end

        it 'only creates a project_share for a project that exists' do
          new_project = FactoryGirl.create(:project)
          expect {
            post :create,
              project_share: build_attributes(
                :project_share,
                project_id: new_project.id + 1
              ),
              format: :json
          }.not_to change(ProjectShare, :count)
        end

        it 'only creates a project_share for a user that exists' do
          new_user = FactoryGirl.create(:user)
          expect {
            post :create,
              project_share: build_attributes(
                :project_share,
                user_id: new_user.id + 1
              ),
              format: :json
          }.not_to change(ProjectShare, :count)
        end

        it 'only creates a project_share for a project the user owns' do
          other_project = FactoryGirl.create(:project, user_id: user.id + 1)
          expect {
            post :create,
              project_share: build_attributes(
                :project_share,
                project_id: other_project.id
              ),
              format: :json
          }.not_to change(ProjectShare, :count)
        end

        it 'responds with a 404 Not Found if the user does not own the project' do
          other_project = FactoryGirl.create(:project, user_id: user.id + 1)
          post :create,
            project_share: build_attributes(
              :project_share,
              project_id: other_project.id
            ),
            format: :json
          expect(response.status).to eq 404
        end

        it 'renders the project_share show template', run: true do
          expect(response).to render_template :show
        end
      end

      context 'with invalid attributes' do
        before(run: true) do
          post :create,
            project_share: FactoryGirl.attributes_for(:invalid_project_share),
            format: :json
        end

        it 'responds with a 422 Unprocessable Entity', run: true do
          expect(response.status).to eq 422
        end

        it 'does not create a project_share in the database' do
          expect {
            post :create,
              project_share: FactoryGirl.attributes_for(:invalid_project_share),
              format: :json
          }.not_to change(ProjectShare, :count)
        end

        it 'renders with error messages', run: true do
          expect(response.body).to include 'errors'
        end
      end
    end

    context 'signed out' do
      before do
        sign_out
        post :create,
          project_share: build_attributes(
            :project_share,
            project: project.id
          ),
          format: :json
      end

      it 'responds with a 401 Unauthorized'
      it 'does not create a project_share in the database'
    end
  end

  describe 'DELETE #destory' do
    context 'signed in' do

    end

    context 'signed out' do

    end
  end

end
