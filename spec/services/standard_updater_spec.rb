require 'spec_helper'
require 'services/standard_updater'

describe StandardUpdater do
  let(:listener) { double success: nil, failure: nil }
  subject { StandardUpdater.new(listener) }
  
  describe "#update" do
    let(:record) { double save: true, assign_attributes: nil }
    it "should assign the attributes" do
      expect(record).to receive(:assign_attributes).with({ bear: :silly })
      subject.update(record, { bear: :silly })
    end
    
    it "should save the record" do
      expect(record).to receive(:save)
      subject.update(record, {})
    end
    
    it "should called the save_successful method on listener when successfully saved the record" do
      allow(record).to receive_messages(save: true)
      expect(listener).to receive(:success).with(record)
      subject.update(record, {})
    end
    
    it "should called the save_failed method on listener when failed saved the record" do
      allow(record).to receive_messages(save: false)
      expect(listener).to receive(:failure).with(record)
      subject.update(record, {})
    end
    
  end
end