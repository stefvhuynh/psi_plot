require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe 'GET #main' do
    it 'renders the main template' do
      get :main, format: :html
      expect(response).to render_template :main
    end
  end

end
