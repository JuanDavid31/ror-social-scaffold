require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship_with_user_1) { Friendship.new user1: users(:juan) }
  let(:friendship_with_user_2) { Friendship.new user2: users(:arnold) }
  let(:friendship_with_status) { Friendship.new status: 'Pending' }
  let(:friendship) { Friendship.new user1: users(:juan), user2: users(:arnold), status: 'Pending' }

  fixtures :all

  describe '#valid?' do
    it 'does validate the friendship' do
      expect(Friendship.new.valid?).to be false
    end

    it 'does validate the user reference' do
      expect(friendship_with_user_1.valid?).to be false
    end

    it 'does validate the post reference' do
      expect(friendship_with_user_2.valid?).to be false
    end

    it 'does validate the status' do
      expect(friendship_with_status.valid?).to be false
    end

    it 'does validate both users and status' do
      expect(friendship.valid?).to be true
    end
  end

  describe '#save' do
    it 'does create a 2nd row with opposite users' do
      friendship.save
      expect(Friendship.all.length).to be 2
    end
  end
end
