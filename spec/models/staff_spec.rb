require 'rails_helper'

RSpec.describe Staff, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#staff_name' do
  	it 'add a new staff' do
      staff = Staff.new(name: 'Testing', grade: '5', FTE: '80%', staffgivenname: 'test')
      expect(staff.name).to eq 'Testing'
      expect(staff.grade).to eq 5
      expect(staff.FTE).to eq '80%'
      expect(staff.staffgivenname).to eq 'test'
  	end
  end
end
