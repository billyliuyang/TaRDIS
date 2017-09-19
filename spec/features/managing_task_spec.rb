require 'rails_helper'

describe "Creating Task" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end
  
  context 'given that a Study exists' do
    let!(:study) {FactoryGirl.create :study, title: 'Study 1', startdate: '13/03/2017', enddate: '08/08/2017', description: 'Description'}

      specify "I can create a new Task within a Study", js: true do
      	visit '/'
      	click_link('', :href => '/tasks/new?study_id=1')
      	wait_for_ajax
      	fill_in 'Task Title', with: 'Task 1'
      	fill_in 'task[startdate]', with: '13/03/2017'
      	fill_in 'task[enddate]', with: '13/04/2017'
      	fill_in 'task[lead_dm_time]', with: 5
      	fill_in 'task[dm_time]', with: 10
      	fill_in 'task[support_dm_time]', with: 2
      	click_button 'DONE'
      	wait_for_ajax
      	within(:css, '.flash-messages') do
      	  expect(page).to have_content "Task was successfully created."
      	end
      	expect(page).to have_content "Task 1"
      end
  end
end

describe describe "Editing task details" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end

  context 'given that a Study exists' do
    let!(:study) {FactoryGirl.create :study, title: 'Study 1', startdate: '13/03/2017', enddate: '08/08/2017', description: 'Description'}
      
      specify "I can edit an existing Task within a Study", js: true do
        visit '/'
        click_link('', :href => '/tasks/new?study_id=1')
        wait_for_ajax
        fill_in 'Task Title', with: 'Task 1'
        fill_in 'task[startdate]', with: '13/03/2017'
        fill_in 'task[enddate]', with: '13/04/2017'
        fill_in 'task[lead_dm_time]', with: 5
        fill_in 'task[dm_time]', with: 10
        fill_in 'task[support_dm_time]', with: 2
        click_button 'DONE'
        wait_for_ajax

        click_link('', :href => '/tasks/1/edit')
        wait_for_ajax
        fill_in 'Task Title', with: 'Task 2'
        fill_in 'task[startdate]', with: '13/04/2017'
        fill_in 'task[enddate]', with: '13/05/2017'
        fill_in 'task[lead_dm_time]', with: 10
        fill_in 'task[dm_time]', with: 30
        fill_in 'task[support_dm_time]', with: 10
        click_button 'DONE'
        wait_for_ajax

        within(:css, '.flash-messages') do
          expect(page).to have_content "Task was successfully updated."
        end
        expect(page).to have_content "Task 2"

      end
    end
end

describe describe "Delete task" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end

  context 'given that a Study exists' do
    let!(:study) {FactoryGirl.create :study, title: 'Study 1', startdate: '13/03/2017', enddate: '08/08/2017', description: 'Description'}
      
      specify "I can edit an existing Task within a Study", js: true do
        visit '/'
        click_link('', :href => '/tasks/new?study_id=1')
        wait_for_ajax
        fill_in 'Task Title', with: 'Task 1'
        fill_in 'task[startdate]', with: '13/03/2017'
        fill_in 'task[enddate]', with: '13/04/2017'
        fill_in 'task[lead_dm_time]', with: 5
        fill_in 'task[dm_time]', with: 10
        fill_in 'task[support_dm_time]', with: 2
        click_button 'DONE'
        wait_for_ajax

        click_link('', :href => '/tasks/1/edit')
        wait_for_ajax
        click_link('', :href => '/tasks/1')
        wait_for_ajax

        within(:css, '.flash-messages') do
          expect(page).to have_content "Task was successfully destroyed."
        end
        expect(page).not_to have_content "Task 1"

      end
    end
end
