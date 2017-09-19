require 'rails_helper'

describe "Checking Report" do

  let(:manager) { FactoryGirl.create(:manager) }

  before do  
    login_as manager 
  end
  
  context 'given that a Study and corresponding Tasks exist' do
    let!(:study) {FactoryGirl.create :study, title: 'Study 1', startdate: '13/03/2017', enddate: '08/08/2017', description: 'Description'}
  	let!(:task) {
  		FactoryGirl.create :task, 
  		title: 'Task 1', startdate: '13/03/2017', enddate: '08/08/2017', 
  		lead_dm_time: 6, dm_time: 6, support_dm_time: 6, study_id: 1

  		FactoryGirl.create :task, 
  		title: 'Task 2', startdate: '13/03/2017', enddate: '08/08/2017', 
  		lead_dm_time: 6, dm_time: 6, support_dm_time: 6, study_id: 1
  	}

  	specify "I can see report on staff allocated time", js: true do
  	  visit '/studies?selected_month=4'
      within(:css, '#report span.lead-hours') do
      	expect(page).to have_content "2.0 hours (allocated)"
      end
      within(:css, '#report span.dm-hours') do
      	expect(page).to have_content "2.0 hours (allocated)"
      end
      within(:css, '#report span.supp-hours') do
      	expect(page).to have_content "2.0 hours (allocated)"
      end
  	end

  	specify "I can only see blank report if no task available on the selected month", js: true do
  	  visit '/studies?selected_month=10'
      within(:css, '#report span.lead-hours') do
      	expect(page).to have_content "0.0 hours (allocated)"
      end
      within(:css, '#report span.dm-hours') do
      	expect(page).to have_content "0.0 hours (allocated)"
      end
      within(:css, '#report span.supp-hours') do
      	expect(page).to have_content "0.0 hours (allocated)"
      end
  	end

  end

  context 'given that 2 Studies and corresponding Tasks exist' do

    let!(:study) {
      FactoryGirl.create :study, 
      title: 'Study 1', startdate: '13/03/2017', enddate: '08/08/2017', description: 'This is Study 1'

      FactoryGirl.create :study, 
      title: 'Study 2', startdate: '09/08/2017', enddate: '09/08/2018', description: 'This is Study 2'
    }

    let!(:task) {
      FactoryGirl.create :task, 
      title: 'Task 1', startdate: '13/03/2017', enddate: '08/08/2017', 
      lead_dm_time: 6, dm_time: 6, support_dm_time: 6, study_id: 1

      FactoryGirl.create :task, 
      title: 'Task 2', startdate: '13/03/2017', enddate: '08/08/2017', 
      lead_dm_time: 6, dm_time: 6, support_dm_time: 6, study_id: 1

      FactoryGirl.create :task, 
      title: 'Task for Study 2', startdate: '09/08/2017', enddate: '08/02/2018', 
      lead_dm_time: 7, dm_time: 7, support_dm_time: 7, study_id: 2

      FactoryGirl.create :task, 
      title: 'Another Task for Study 2', startdate: '08/02/2018', enddate: '08/08/2018', 
      lead_dm_time: 7, dm_time: 7, support_dm_time: 7, study_id: 2
    }

    specify "I can see report on staff allocated time", js: true do
      visit '/studies?selected_month=8'
      within(:css, '#report span.lead-hours') do
        expect(page).to have_content "3.0 hours (allocated)"
      end
      within(:css, '#report span.dm-hours') do
        expect(page).to have_content "3.0 hours (allocated)"
      end
      within(:css, '#report span.supp-hours') do
        expect(page).to have_content "3.0 hours (allocated)"
      end
    end

  end
end