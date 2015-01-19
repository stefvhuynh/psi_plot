require 'rails_helper'

RSpec.describe Api::TwoWayPlotsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }
  let(:two_way_plots) { FactoryGirl.create_list(:two_way_plot, 5, project: project) }

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
    end
  end
end
