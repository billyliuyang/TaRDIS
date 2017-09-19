require 'rails_helper'

describe "Creating a new study" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end
  
  specify "I cannot create a new study if title is empty", js: true do
    visit '/'
    click_button 'ADD NEW STUDY'
    wait_for_ajax
    fill_in 'study[startdate]', with: '13/03/2018'
    fill_in 'study[enddate]', with: '08/08/2017'
    click_button 'CREATE'
    wait_for_ajax
    within(:css, '.flash-messages') do
      expect(page).to have_content "Failed to create study"
    end
  end

  specify "I cannot create a new study if startdate and enddate is unreasonable", js: true do
    visit '/'
    click_button "ADD NEW STUDY"
    wait_for_ajax
    fill_in 'Title', with: 'Testing Date'
    fill_in 'study[startdate]', with: '08/08/2017'
    fill_in 'study[enddate]', with: '13/03/2017'
    click_button 'CREATE'
    wait_for_ajax
    within(:css, '.flash-messages') do
      expect(page).to have_content "Failed to create study"
    end
  end
  
  specify "I can create a new study", js: true do
    visit '/'
    click_button 'ADD NEW STUDY'
    wait_for_ajax
    fill_in 'study[startdate]', with: '13/03/2017'
    fill_in 'study[enddate]', with: '08/08/2017'
    fill_in 'description', with: 'This is a testing case'
    fill_in 'Title', with: 'Testing'
    click_button 'CREATE'
    wait_for_ajax
    within(:css, '.flash-messages') do
      expect(page).to have_content "Study was successfully created."
    end
  end

end

describe "Viewing a list of study" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end
  
  specify "I can view the list of study", js: true do
    visit '/'
    click_button 'ADD NEW STUDY'
    wait_for_ajax
    fill_in 'Title', with: 'Testing1'
    fill_in 'description', with: 'This is a testing case'
    click_button 'CREATE'
    wait_for_ajax

    click_button 'ADD NEW STUDY'
    wait_for_ajax
    fill_in 'Title', with: 'Testing2'
    fill_in 'description', with: 'This is a testing case'
    click_button 'CREATE'
    wait_for_ajax

    expect(page).to have_content 'Testing1'
    expect(page).to have_content 'Testing2'

  end

end

describe describe "Editing study details" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end
  
  specify "I can edit study details", js: true do
    visit '/'
    click_button 'ADD NEW STUDY'
    wait_for_ajax
    fill_in 'Title', with: 'New Study'
    fill_in 'description', with: 'This is a testing case'
    click_button 'CREATE'
    wait_for_ajax

    click_link('', :href => '/studies/1/edit')
    wait_for_ajax
    fill_in 'Title', with: 'Modified Study'
    click_button 'DONE'
    wait_for_ajax

    expect(page).to have_content 'Modified Study'

  end

end

describe "Deleting a study" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end

  specify "I can delete a study", js: true do
    visit '/'
    click_button 'ADD NEW STUDY'
    wait_for_ajax
    fill_in 'Title', with: 'Study 1'
    fill_in 'escription', with: 'This is a testing case'
    click_button 'CREATE'
    wait_for_ajax

    click_link('', :href => '/studies/1/edit')
    wait_for_ajax
    click_link('', :href => '/studies/1')
    wait_for_ajax

    expect(page).not_to have_content 'Study 1'
  end
end
