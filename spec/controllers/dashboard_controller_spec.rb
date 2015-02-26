require 'rails_helper'

describe DashboardController, type: :controller do
  describe 'GET #index' do
    before :each do
      get :index
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'redirects to user page if signed in' do
      user = create(:user)
      sign_in user
      get :index

      expect(response).to redirect_to(user_path(user))
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
end
