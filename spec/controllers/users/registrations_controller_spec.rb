require 'rails_helper'

module Users
  describe RegistrationsController, type: :controller do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    describe 'GET #new' do
      before :each do
        get :new
      end

      it 'responds successfully' do
        expect(response).to have_http_status(200)
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      context 'valid user' do
        let(:valid_user) { attributes_for :user }

        it 'creates user' do
          expect do
            post :create, user: valid_user
          end.to change { User.count }.by(1)
          expect(response).to redirect_to(user_path(User.last))
        end
      end

      context 'invalid user' do
        let(:invalid_user) { attributes_for :invalid_user }

        it 'does not create user' do
          expect do
            post :create, user: invalid_user
          end.to change { User.count }.by(0)
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #edit' do
      let(:user) { create :user }

      context 'signed in user' do
        it 'renders the edit template' do
          sign_in user
          get :edit

          expect(response).to render_template(:edit)
        end
      end

      context 'not signed in user' do
        it 'redirects to sign in page' do
          sign_out user
          get :edit

          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    describe 'PATCH #update' do
      let(:user) do
        create :user,
               first_name: 'Name1',
               email: 'user@mail.com',
               password: '123123',
               password_confirmation: '123123'
      end

      context 'signed in user' do
        before :each do
          sign_in user
        end

        it 'updates attributes' do
          patch :update, user: { first_name: 'Name2', last_name: 'Surname2', city: 'Kazan' }
          user.reload

          expect(user.first_name).to eq('Name2')
          expect(user.last_name).to eq('Surname2')
          expect(user.city).to eq('Kazan')
        end

        it 'redirects to edit page after successful updating' do
          patch :update

          expect(response).to redirect_to(edit_user_registration_path)
        end

        context 'updating email' do
          it 'updates email with current password' do
            patch :update, user: { email: 'user2@mail.com', current_password: '123123' }
            user.reload

            expect(user.email).to eq('user2@mail.com')
          end

          it 'does not update email without current password' do
            patch :update, user: { email: 'user2@mail.com' }
            user.reload

            expect(user.email).to eq('user@mail.com')
          end
        end

        context 'updating password' do
          it 'updates password only with current password and password confirmation' do
            patch :update, user: { current_password: '123123', password: '123456', password_confirmation: '123456' }
            user.reload

            expect(user.valid_password?('123456')).to eq(true)
          end

          it 'does not update password without current password' do
            patch :update, user: { password: '123456', password_confirmation: '123456' }
            user.reload

            expect(user.valid_password?('123456')).to eq(false)
          end

          it 'does not update password with incorrect password_confirmation' do
            patch :update, user: { current_password: '123123', password: '123456', password_confirmation: '1234567' }
            user.reload

            expect(user.valid_password?('123456')).to eq(false)
          end
        end
      end

      context 'not signed in user' do
        it 'does not update user' do
          sign_out user
          patch :update, user: { first_name: 'Name2' }

          expect(response).to redirect_to new_user_session_path
          expect(user.first_name).to eq('Name1')
        end
      end
    end
  end
end
