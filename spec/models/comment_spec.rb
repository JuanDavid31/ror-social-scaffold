require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:comment_with_content) { Comment.new content: 'This is some serious content' }
  let(:comment_with_user) { Comment.new user: users(:juan) }
  let(:comment_with_post) { Comment.new post: posts(:post) }
  let(:comment) { Comment.new content: 'This is some serious content', post: posts(:post), user: users(:juan) }

  fixtures :all

  describe '#valid?' do
    it 'does validate the comment' do
      expect(Comment.new.valid?).to be false
    end

    it 'does validate the user reference' do
      expect(comment_with_content.valid?).to be false
    end

    it 'does validate the user reference' do
      expect(comment_with_user.valid?).to be false
    end

    it 'does validate the post reference' do
      expect(comment_with_post.valid?).to be false
    end

    it 'does validate user and post references' do
      expect(comment.valid?).to be true
    end
  end
end
