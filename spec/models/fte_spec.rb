require 'rails_helper'

RSpec.describe Fte, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#fte_value' do
  	it 'add a new fte' do
      fte = Fte.new(FTE_value: '80', startdate: '11/11/2011', enddate: '11/11/2014',)
      expect(fte.FTE_value).to eq 80
      # expect(fte.startdate).to eq '11/11/2011'
      # expect(fte.enddate).to eq '11/11/2014'
  	end
  end
end
