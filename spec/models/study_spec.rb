# == Schema Information
#
# Table name: studies
#
#  id          :integer          not null, primary key
#  title       :string
#  startdate   :date
#  enddate     :date
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Study, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#study_title' do
  	it 'create a new study' do
      study = Study.new(id: 1, title: 'Testing', startdate: '11/11/2011', description: 'I love genesys')
      expect(study.id).to eq 1
      expect(study.title).to eq 'Testing'
      # expect(study.startdate).to eq 'Fri, 11 Nov 2011'
      expect(study.description).to eq 'I love genesys'
  	end
  end
end
