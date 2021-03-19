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
    it 'its possible to see every friends posts and owning posts ' do
      sign_in users(:juan)
      visit root_url
      expect(page).to have_content 'This is quality content'
      expect(page).to have_content 'More quality content'
    end

    it 'does send friend requests' do # See sent friend requests
      sign_in users(:arnold2)
      visit user_path(id: users(:juandavid).id)
      click_button 'Send friend request'
      expect(page).to have_content 'Friend request sent'
    end
  end




    # See received friend requests

    # Send friend request

    # Accept friend request

    # Reject friend request
end
