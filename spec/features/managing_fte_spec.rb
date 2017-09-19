require 'rails_helper'

describe "Add a new FTE" do

  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end

  context 'Set a Staff' do
    let!(:staff) {FactoryGirl.create :staff, name: 'Test Staff', grade: '7', startdate: '13/03/2017', enddate: '08/08/2017'}

      specify "I can add a new FTE to a Staff", js: true do
        visit '/staffs'
        click_link('', :href => '/ftes/new?staff_id=1')
        wait_for_ajax
        fill_in 'fte[FTE_value]', with: '90'
        fill_in 'fte[startdate]', with: '10/04/2016'
        fill_in 'fte[enddate]', with: '11/11/2017'
        find_button('ADD FTE').trigger('click')
        wait_for_ajax

        within(:css, '.flash-messages') do
        	expect(page).to have_content "FTE was successfully created."
        end

        click_link('', :href => '/staffs/1/edit')
        expect(page).to have_content "90"
      end
  end
end

describe "Delete a new FTE" do

  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end

  context 'Set a Staff' do
    let!(:staff) {FactoryGirl.create :staff, name: 'Test Staff', grade: '7', startdate: '13/03/2017', enddate: '08/08/2017'}

      specify "I can delete a FTE from a Staff's FTE history", js: true do
        visit '/staffs'
        click_link('', :href => '/ftes/new?staff_id=1')
        wait_for_ajax
        fill_in 'fte[FTE_value]', with: '90'
        fill_in 'fte[startdate]', with: '10/04/2016'
        fill_in 'fte[enddate]', with: '11/11/2017'
        find_button('ADD FTE').trigger('click')
        wait_for_ajax

        within(:css, '.flash-messages') do
        	expect(page).to have_content "FTE was successfully created."
        end

        click_link('', :href => '/staffs/1/edit')
        expect(page).to have_content "90"
        click_link('', :href => '/ftes/1')
        wait_for_ajax

        within(:css, '.flash-messages') do
          expect(page).to have_content "FTE was successfully destroyed."
        end

        click_link('', :href => '/staffs/1/edit')
        expect(page).not_to have_content "90"
      end
  end
end

describe "Show current FTE" do

  let(:admin) { FactoryGirl.create(:admin) }

  before do  
    login_as admin 
  end
  
  context 'Set a Staff' do
    let!(:staff) {FactoryGirl.create :staff, name: 'Test Staff', grade: '7', startdate: '13/03/2017', enddate: '08/08/2017'}

      specify "I can see the current FTE of a Staff", js: true do
        visit '/staffs'
        click_link('', :href => '/ftes/new?staff_id=1')
        wait_for_ajax
        fill_in 'fte[FTE_value]', with: '90'
        fill_in 'fte[startdate]', with: '10/04/2016'
        fill_in 'fte[enddate]', with: '11/11/2017'
        find_button('ADD FTE').trigger('click')
        wait_for_ajax

        visit '/staffs'
        click_link('', :href => '/ftes/new?staff_id=1')
        wait_for_ajax
        fill_in 'fte[FTE_value]', with: '80'
        fill_in 'fte[startdate]', with: '10/04/2014'
        fill_in 'fte[enddate]', with: '11/11/2015'
        find_button('ADD FTE').trigger('click')
        wait_for_ajax
   
        expect(page).to have_content "90"
        expect(page).not_to have_content "80"
      end
  end
end