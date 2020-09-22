require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  before :each do
    @user = User.create!(
      :first_name => 'Jones', 
      :last_name => 'Smith', 
      :email => 'jjs@mail.com', 
      :password => "123abc", 
      :password_confirmation => "123abc")
    @user.save
  end

  scenario "a registered user should be able to log in" do
    visit '/'
    
    find_link('Login').click
    
    fill_in('email', with: 'jjs@mail.com')
    fill_in('password', with: '123abc')

    find_button('Submit').click
    expect(page).to have_content "Products"
    expect(page).to have_content "Signed in as Jones"
    
    page.save_screenshot

  end

end
