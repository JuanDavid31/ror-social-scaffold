require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) { User.new(name: 'Johndoe', email: 'johndoe123@sample.com', password: '12345678') }

  fixtures :all

  describe '#valid?' do
    it 'does validate all the user variables' do
      expect(User.new.valid?).to be false
    end

    it 'does validate the user name' do
      expect(valid_user.valid?).to be true
    end
  end

  context 'When the user has friends, pending friend requests and/or pending friend responses' do
    describe '#friends' do
      it 'does return the current friends' do
        user = users(:juan)
        expect(user.friends.length).to be 1
      end
    end

    describe '#pending_friend_requests' do
      it 'does return the pending friend requests that the user made' do
        user = users(:juan)
        expect(user.pending_friend_requests.length).to be 1
      end
    end

    describe '#pending_friend_responses' do
      it 'does return the pending friend responses that the user has' do
        user = users(:juandavid)
        expect(user.pending_friend_responses.length).to be 1
      end
    end
  end
end
