require 'rails_helper'

describe "Add a new DM" do

  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end
  
  specify "I can add a new manager by CiCS Account", js: true do
    visit '/staffs'
    click_link 'ADD BY CICS ACCOUNT'
    wait_for_ajax
    fill_in 'account', with: 'acs16qd'
    select("5", from: "user[grade]")
    click_button 'CREATE STAFF'
    wait_for_ajax
    within(:css, '.flash-messages') do
      expect(page).to have_content "User was successfully created"
    end
    expect(page).to have_content "acs16qd"
    expect(page).to have_content "5"
  end

  specify "I cannot create a new manager if grade is empty", js: true do
    visit '/staffs'
    click_link 'ADD BY CICS ACCOUNT'
    wait_for_ajax
    fill_in 'account', with: 'acs16yt'
    click_button 'CREATE STAFF'
    wait_for_ajax

    expect(page).not_to have_content "acs16yt"
  end

  specify "I cannot add a new manager account is empty", js: true do
    visit '/staffs'
    click_link "ADD BY CICS ACCOUNT"
    wait_for_ajax
    select("5", from: "user[grade]")
    click_button 'CREATE STAFF'
    wait_for_ajax

    expect(page).not_to have_content "5"
  end

end

describe "Viewing a list of DM" do
  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end
  
  specify "I can view the list of DM", js: true do
    visit '/staffs'
    click_link 'ADD BY CICS ACCOUNT'
    wait_for_ajax
    fill_in 'account', with: 'acs16yt'
    select("5", from: "user[grade]")
    click_button 'CREATE STAFF'
    wait_for_ajax

    click_link 'ADD BY CICS ACCOUNT'
    wait_for_ajax
    fill_in 'account', with: 'acs16qd'
    select("4", from: "user[grade]")
    click_button 'CREATE STAFF'
    wait_for_ajax

    expect(page).to have_content 'acs16qd'
    expect(page).to have_content '4'
    expect(page).to have_content 'acs16yt'
    expect(page).to have_content '5'
  end
end

describe describe "Editing DM details" do
    
  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end
  
  specify "I can edit DM details", js: true do
    visit '/staffs'
    click_link 'ADD BY CICS ACCOUNT'
    wait_for_ajax
    fill_in 'account', with: 'acs16qd'
    select("5", from: "user[grade]")
    click_button 'CREATE STAFF'
    wait_for_ajax
    expect(page).to have_content '5'

    click_link('', :href => '/staffs/1/edit')
    wait_for_ajax
    fill_in 'staff[staffgivenname]', with: 'Test Name'
    select("6", from: "staff[grade]")
    click_button 'UPDATE'
    wait_for_ajax

    expect(page).to have_content 'Test Name'
    expect(page).to have_content '6'
    expect(page).not_to have_content '5'
  end
end

describe "Delete a DM" do

  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end

  specify "I can delete a DM", js: true do
    visit '/staffs'
    click_link 'ADD BY CICS ACCOUNT'
    wait_for_ajax
    fill_in 'account', with: 'acs16qd'
    select("5", from: "user[grade]")
    click_button 'CREATE STAFF'
    wait_for_ajax

    click_link('', :href => '/staffs/1/edit')
    wait_for_ajax
    click_link('', :href => '/staffs/1')
    wait_for_ajax

    expect(page).not_to have_content 'acs16qd'
  end
end
