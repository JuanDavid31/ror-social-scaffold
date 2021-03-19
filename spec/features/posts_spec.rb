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

    it 'does send friend requests' do
      sign_in users(:arnold2)
      visit user_path(id: users(:juandavid).id)
      click_button 'Send friend request'
      expect(page).to have_content 'Friend request sent'
    end

    it 'does see friend requests' do
      sign_in users(:juan)
      visit '/friend_requests'
      expect(page).to have_content 'Juan David'
      expect(page).to have_content 'Pending'
    end

    it 'does accept a friend request' do
      sign_in users(:juandavid)
      visit '/friend_responses'
      click_link 'Accept'
      expect(page).to_not have_content 'Pending'
    end

    it 'does reject a friend request' do
      sign_in users(:juandavid)
      visit '/friend_responses'
      click_link 'Reject'
      expect(page).to have_content 'Rejected'
    end
  end
end
