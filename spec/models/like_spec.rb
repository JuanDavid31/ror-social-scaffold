require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like_with_user) { Like.new user: users(:juan) }
  let(:like_with_post) { Like.new post: posts(:post) }
  let(:like) { Like.new post: posts(:post), user: users(:juan) }

  fixtures :all

  describe '#valid?' do
    it 'does validate the like' do
      expect(Like.new.valid?).to be false
    end

    it 'does validate the user reference' do
      expect(like_with_user.valid?).to be false
    end

    it 'does validate the post reference' do
      expect(like_with_post.valid?).to be false
    end

    it 'does validate user and post references' do
      expect(like.valid?).to be true
    end
  end
end
