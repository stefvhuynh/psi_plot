require 'rails_helper'

RSpec.describe Api::ProjectSharesController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:project_share) do
    FactoryGirl.create(:project_share, project_id: project.id)
  end

  describe 'POST #create' do

    def make_post_request(project_id)
      post :create,
        project_share: build_attributes(
          :project_share,
          project_id: project_id
        ),
        format: :json
    end

    context 'signed in' do
      before { sign_in(user) }
      after { sign_out }

      context 'with valid attributes' do
        before(run: true) do
          make_post_request(project.id)
        end

        it 'responds with a 200 OK status', run: true do
          expect(response.status).to eq 200
        end

        it 'creates and saves a project_share in the database' do
          expect {
            make_post_request(project.id)
          }.to change(ProjectShare, :count).by 1
        end

        it 'only creates a project_share for a project that exists' do
          new_project = FactoryGirl.create(:project)
          expect {
            make_post_request(new_project.id + 1)
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
            make_post_request(other_project.id)
          }.not_to change(ProjectShare, :count)
        end

        it 'responds with a 404 Not Found if the user does not own the project' do
          other_project = FactoryGirl.create(:project, user_id: user.id + 1)
          make_post_request(other_project.id)
          expect(response.status).to eq 404
        end

        it 'renders the project_share show template', run: true do
          expect(response).to render_template :show
        end
      end

      context 'with invalid attributes' do
        before(run: true) do
          post :create,
            project_share: FactoryGirl.attributes_for(
              :invalid_project_share,
              project_id: project.id
            ),
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
      before { sign_out }

      it 'responds with a 401 Unauthorized' do
        make_post_request(project.id)
        expect(response.status).to eq 401
      end

      it 'does not create a project_share in the database' do
        expect {
          make_post_request(project.id)
        }.not_to change(ProjectShare, :count)
      end
    end
  end

  describe 'DELETE #destory' do
    context 'signed in' do
      before(run: true) do
        sign_in(user)
        delete :destroy, id: project_share, format: :json
      end

      after { sign_out }

      it 'responds with a 200 OK status', run: true do
        expect(response.status).to eq 200
      end

      it 'deletes the record if the user owns the project', run: true do
        expect(project.project_shares).to eq []
      end

      it 'does not delete the record if the user does not own the project' do
        sign_in(user)
        other_user = FactoryGirl.create(:user)
        other_project = FactoryGirl.create(:project, user_id: other_user.id)
        other_project_share = FactoryGirl.create(
          :project_share,
          project_id: other_project.id
        )

        expect {
          delete :destroy, id: other_project_share, format: :json
        }.not_to change(ProjectShare, :count)
        expect(response.status).to eq 403
      end
    end

    context 'signed out' do
      before do
        sign_out
        delete :destroy, id: project_share, format: :json
      end

      it 'responds with a 401 Unauthorized' do
        expect(response.status).to eq 401
      end

      it 'does not delete the record' do
        expect(ProjectShare.all).to include project_share
      end
    end
  end

end
