require 'rails_helper'

describe FriendsController, type: :controller do
  before :each do
    sign_in user
  end

  let(:user) { create :user }
  let(:friend) { create :user }

  describe 'GET #index' do
    context 'html request' do
      it 'renders the index template' do
        get :index, user_id: user.id
        expect(response).to render_template(:index)
      end
    end

    context 'ajax request' do
      it 'renders index.js' do
        xhr :get, :index, format: :js, user_id: user.id
        expect(response).to render_template(:index)
      end
    end

    it 'exposes people' do
      Friendship.create(user_id: user.id, friend_id: friend.id, status: 'accepted')
      Friendship.create(user_id: friend.id, friend_id: user.id, status: 'accepted')
      user2 = create :user, first_name: 'A', last_name: 'A'
      Friendship.create(user_id: user.id, friend_id: user2.id, status: 'pending')
      user3 = create :user, first_name: 'A', last_name: 'B'
      Friendship.create(user_id: user3.id, friend_id: user.id, status: 'pending')
      user4 = create :user, first_name: 'B', last_name: 'A'

      get :index, user_id: user.id
      expect(controller.people).to eq([user2, user3, user4])
    end
  end

  describe 'POST #create' do
    context 'ajax request' do
      let(:request) do
        -> { xhr :post, :create, format: :js, user_id: user.id, friend: { id: friend.id } }
      end

      it 'creates friendship' do
        expect(request).to change { Friendship.count }.by(1)
        expect(Friendship.last.user_id).to eq(user.id)
        expect(Friendship.last.friend_id).to eq(friend.id)
        expect(Friendship.last.status).to eq('pending')
      end

      it 'renders create.js' do
        request.call
        expect(response).to render_template(:create)
      end
    end
  end

  describe 'POST #accept' do
    context 'ajax request' do
      let!(:friendship) { Friendship.create(user_id: friend.id, friend_id: user.id) }
      let(:request) do
        -> { xhr :post, :accept, format: :js, user_id: user.id, id: friend.id }
      end

      it 'accepts request' do
        request.call
        expect(friendship.reload).to be_accepted
      end

      it 'creates reversed friendship' do
        expect(request).to change { Friendship.count }.by(1)
        expect(Friendship.last.user_id).to eq(user.id)
        expect(Friendship.last.friend_id).to eq(friend.id)
        expect(Friendship.last).to be_accepted
      end

      it 'renders accept.js' do
        request.call
        expect(response).to render_template(:accept)
      end
    end
  end

  describe 'POST #reject' do
    context 'ajax request' do
      let!(:friendship) { Friendship.create(user_id: friend.id, friend_id: user.id) }
      let(:request) do
        -> { xhr :delete, :reject, format: :js, user_id: user.id, id: friend.id }
      end

      it 'rejects request' do
        expect(request).to change { Friendship.count }.by(-1)
      end

      it 'renders reject.js' do
        request.call
        expect(response).to render_template(:reject)
      end
    end
  end

  describe 'POST #destroy' do
    context 'ajax request' do
      let!(:friendship) { Friendship.create(user_id: friend.id, friend_id: user.id, status: 'accepted') }
      let!(:reversed_friendship) { Friendship.create(user_id: user.id, friend_id: friend.id, status: 'accepted') }
      let(:request) do
        -> { xhr :delete, :destroy, format: :js, user_id: user.id, id: friend.id }
      end

      it 'destroys friendships between users' do
        expect(request).to change { Friendship.count }.by(-2)
      end

      it 'renders destroy.js' do
        request.call
        expect(response).to render_template(:destroy)
      end
    end
  end
end
