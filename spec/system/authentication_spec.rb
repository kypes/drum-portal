require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'sign in' do
    let(:user) { create(:user, email: 'user@example.com', password: 'password123', name: 'Test User') }

    before do
      user # Create the user before each test
    end

    it 'allows user to sign in with valid credentials' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password123'
      click_button 'Sign in'
      expect(page).to have_content('Signed in successfully')
    end

    it 'shows error with invalid credentials' do
      visit new_user_session_path
      fill_in 'Email', with: 'wrong@example.com'
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Sign in'
      expect(page).to have_content('Invalid Email or password')
    end
  end
end
