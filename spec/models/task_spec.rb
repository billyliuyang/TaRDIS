require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#task_title' do
  	it 'create a new task' do
      task = Task.new(id: 1, title: 'Testing', startdate: '11/11/2011', lead_dm_time: '10', dm_time: '30', support_dm_time: '10', study_id: 2)
      expect(task.id).to eq 1
      expect(task.study_id).to eq 2
      expect(task.title).to eq 'Testing'
      # expect(study.startdate).to eq 'Fri, 11 Nov 2011'
      expect(task.lead_dm_time).to eq 10
      expect(task.dm_time).to eq 30
      expect(task.support_dm_time).to eq 10
  	end
  end
end
