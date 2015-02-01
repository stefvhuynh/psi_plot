require 'rails_helper'

RSpec.describe Api::TwoWayPlotsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }

  describe 'POST #create' do
    def make_post_request_with_valid_attrs(project)
      post :create,
        two_way_plot: FactoryGirl.attributes_for(
          :two_way_plot,
          project_id: project.id
        ),
        format: :json
    end

    def make_post_request_with_invalid_attrs(project)
      post :create,
        two_way_plot: FactoryGirl.attributes_for(
          :invalid_two_way_plot,
          project_id: project.id
        ),
        format: :json
    end

    context 'signed out' do
      it 'responds with a 401 Unauthorized' do
        make_post_request_with_valid_attrs(project)
        expect(response.status).to eq 401
      end

      it 'does not create a two_way_plot in the database' do
        expect {
          make_post_request_with_valid_attrs(project)
        }.not_to change(TwoWayPlot, :count)
      end
    end

    context 'signed in' do
      before { sign_in(user) }
      after { sign_out }

      context 'with valid attributes' do
        before(run: true) { make_post_request_with_valid_attrs(project) }

        it 'responds with a 200 OK', run: true do
          expect(response.status).to eq 200
        end

        it 'creates a two_way_plot for the project' do
          expect {
            make_post_request_with_valid_attrs(project)
          }.to change(project.two_way_plots, :count).by 1
        end

        it 'only creates a two_way_plot for a project the user owns' do
          other_user = FactoryGirl.create(:user)
          other_project = FactoryGirl.create(:project, user: other_user)
          expect {
            make_post_request_with_valid_attrs(other_project)
          }.not_to change(other_project.two_way_plots, :count)
        end

        it 'responds with 404 Not Found if the user does not own the project' do
          other_user = FactoryGirl.create(:user)
          other_project = FactoryGirl.create(:project, user: other_user)
          make_post_request_with_valid_attrs(other_project)
          expect(response.status).to eq 404
        end

        it 'renders the show template', run: true do
          expect(response).to render_template :show
        end
      end

      context 'with invalid attributes' do
        before(run: true) { make_post_request_with_invalid_attrs(project) }

        it 'responds with a 422 Unprocessable Entity', run: true do
          expect(response.status).to eq 422
        end

        it 'does not create a two_way_plot in the database' do
          expect {
            make_post_request_with_invalid_attrs(project)
          }.not_to change(TwoWayPlot, :count)
        end

        it 'renders with error messages', run: true do
          expect(response.body).to include 'errors'
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:two_way_plot) { FactoryGirl.create(:two_way_plot, project: project) }

    def make_delete_request(two_way_plot)
      delete :destroy, id: two_way_plot, format: :json
    end

    context 'signed in' do
      before(run: true) do
        sign_in(user)
        make_delete_request(two_way_plot)
      end

      after { sign_out }

      it 'responds with a 200 OK status', run: true do
        expect(response.status).to eq 200
      end

      it 'deletes the record if the user owns the two_way_plot', run: true do
        expect(project.two_way_plots).to eq []
      end

      it 'does not delete the record if the user does not own the two_way_plot' do
        other_user = FactoryGirl.create(:user)
        other_project = FactoryGirl.create(:project, user: other_user)
        other_two_way_plot = FactoryGirl.create(
          :two_way_plot,
          project: other_project
        )
        sign_in(user)

        expect {
          make_delete_request(other_two_way_plot)
        }.not_to change(TwoWayPlot, :count)
        expect(response.status).to eq 403
      end
    end

    context 'signed out' do
      before do
        sign_out
        make_delete_request(two_way_plot)
      end

      it 'responds with a 401 Unauthorized' do
        expect(response.status).to eq 401
      end

      it 'does not delete the record' do
        expect(TwoWayPlot.all).to include two_way_plot
      end
    end
  end
end
