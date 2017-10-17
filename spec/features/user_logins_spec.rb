require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js:true do
  before :each do
    @user = User.create!(
      first_name: 'a',
      last_name: 'b',
      email: 'p@p.p',
      password: 'qqq222',
      password_confirmation: 'qqq222'
    )
  end

  scenario 'user can go to login in page from home page and log themselves in' do
    visit login_path

    fill_in id: 'email', with: 'p@p.p'
    fill_in id: 'password', with: 'qqq222'
    click_button('Submit')
   
    sleep 2
    save_screenshot 'user_login.png'
  end
end

