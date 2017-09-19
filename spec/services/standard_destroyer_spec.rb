require 'spec_helper'
require 'services/standard_destroyer'

describe StandardDestroyer do
  let(:listener) { double success: nil, failure: nil }
  subject { StandardDestroyer.new(listener) }
  
  describe "#update" do
    let(:record) { double }
    
    it "should save the record" do
      expect(record).to receive(:destroy)
      subject.destroy(record)
    end
    
    it "should called the save_successful method on listener when successfully saved the record" do
      allow(record).to receive_messages(destroy: true)
      expect(listener).to receive(:success).with(record)
      subject.destroy(record)
    end
    
    it "should called the save_failed method on listener when failed saved the record" do
      allow(record).to receive_messages(destroy: false)
      expect(listener).to receive(:failure).with(record)
      subject.destroy(record)
    end 
  end
end