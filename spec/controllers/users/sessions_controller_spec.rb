require 'rails_helper'

module Users
  describe SessionsController, type: :controller do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    describe 'GET #new' do
      it 'renders the new template' do
        get :new

        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      before :each do
        sign_out user
      end

      let(:user) { create :user }

      context 'correct email and password' do
        before :each do
          post :create, user: { email: user.email, password: user.password }
        end

        it 'signs in' do
          expect(subject.user_signed_in?).to eq(true)
        end

        it 'redirects to user page' do
          expect(response).to redirect_to(user_path(user))
        end
      end

      context 'incorrect combination of email and password' do
        before :each do
          post :create, user: { email: user.email, password: 'incorrect' }
        end

        it 'does not sign in' do
          expect(subject.user_signed_in?).to eq(false)
        end

        it 'renders new template' do
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #destroy' do
      before :each do
        get :destroy
      end

      it 'signs out' do
        expect(subject.user_signed_in?).to eq(false)
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
