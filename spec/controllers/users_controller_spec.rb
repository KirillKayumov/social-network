require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { create :user }

    context 'signed in user' do
      before :each do
        sign_in user
        get :show, id: user.id
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'not signed in user' do
      before :each do
        sign_out user
        get :show, id: user.id
      end

      it 'redirects to' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
