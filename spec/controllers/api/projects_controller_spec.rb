require 'rails_helper'

RSpec.describe Api::ProjectsController, :type => :controller do

  describe 'GET #index' do
    before do
      FactoryGirl.build_list(:project)
    end

    it 'responds with a 200 OK status' do

    end

    it 'fetches all the projects for a user' do

    end

    it 'does not fetch the projects for other users' do

    end
  end

  describe 'GET #show' do

  end

  describe 'POST #create' do

  end

  describe 'PUT #update' do

  end

  describe 'DELETE #destroy' do

  end

end
