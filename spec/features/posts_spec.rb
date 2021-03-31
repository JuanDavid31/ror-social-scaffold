require 'rails_helper'

RSpec.describe Post, type: :feature do
  fixtures :all

  context 'When a user signs in' do
    it 'does sign in' do
      sign_in users(:juan)
      visit root_url
      expect(page).to have_content 'Recent posts'
    end
  end

  context 'When a user is logged in' do
    it 'does see every friends posts and owning posts ' do
      sign_in users(:juan)
      visit root_url
      expect(page).to have_content 'This is quality content'
      expect(page).to have_content 'More quality content'
    end
  end
end
