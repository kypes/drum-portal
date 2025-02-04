require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user, :student) }

  describe 'sign in' do
    it 'allows user to sign in with valid credentials' do
      visit new_user_session_path
      
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password123'
      click_button 'Log in'

      expect(page).to have_content('Signed in successfully')
    end

    it 'shows error with invalid credentials' do
      visit new_user_session_path
      
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrong_password'
      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password')
    end
  end
end 