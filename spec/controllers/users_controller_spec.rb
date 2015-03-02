require 'rails_helper'

describe UsersController, type: :controller do
  before :each do
    sign_in user
  end

  let(:user) { create :user }

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, id: user.id
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #index' do
    context 'html request' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'ajax request' do
      it 'renders index.js' do
        xhr :get, :index, format: :js
        expect(response).to render_template(:index)
      end
    end

    it 'exposes users' do
      user1 = create :user
      Friendship.create(user_id: user.id, friend_id: user1.id, status: 'accepted')
      Friendship.create(user_id: user1.id, friend_id: user.id, status: 'accepted')
      user2 = create :user, first_name: 'A', last_name: 'A'
      Friendship.create(user_id: user.id, friend_id: user2.id, status: 'pending')
      user3 = create :user, first_name: 'A', last_name: 'B'
      Friendship.create(user_id: user3.id, friend_id: user.id, status: 'pending')
      user4 = create :user, first_name: 'B', last_name: 'A'

      get :index
      expect(controller.users).to eq([user2, user3, user4])
    end
  end
end
