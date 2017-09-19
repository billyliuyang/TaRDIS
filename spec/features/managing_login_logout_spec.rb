require 'rails_helper'

describe 'As an Admin' do
  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end
  
  specify "I can do study management", js: true do
    visit '/'
    expect(page).to have_content "STUDY LIST"
  end

  specify "I can do staff management", js: true do
    visit '/staffs'
    expect(page).to have_content "ADD BY CICS ACCOUNT"
  end

  specify "I can do user management", js: true do
    visit '/users'
    expect(page).to have_content "CiCS Account"
  end

end

describe 'As a Manager' do
  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end
  
  specify "I can do study management", js: true do
    visit '/'
    expect(page).to have_content "STUDY LIST"
  end

  specify "I can do study management", js: true do
    visit '/staffs'
    expect(page).to have_content "Current FTE"
    expect(page).not_to have_content "ADD BY CICS ACCOUNT"
  end

  specify "I cannot do study management", js: true do
    visit '/users'
    expect(page).to have_content "Access Denied"
  end

end


describe 'Log out the system' do
  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end

  specify "I can Log Out from the system", js: true do
    visit '/'
    find('#user_givenname').click
    click_link('', :href => '/users/sign_out')
    within(:css, '.flash-messages') do
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end

end
