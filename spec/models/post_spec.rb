require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post_with_user) { Post.new(user: users(:juan)) }
  let(:post_with_content_and_user) { Post.new(content: 'This is quality content', user: users(:juan)) }

  fixtures :all

  describe '#valid?' do
    it 'does validate the post' do
      expect(Post.new.valid?).to be false
    end

    it 'does validate the post author' do
      expect(post_with_user.valid?).to be false
    end

    it 'does validate the post content' do
      expect(post_with_content_and_user.valid?).to be true
    end
  end
end
