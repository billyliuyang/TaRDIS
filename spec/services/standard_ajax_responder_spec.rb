require 'spec_helper'
require 'services/standard_ajax_responder'

describe StandardAjaxResponder do
  class MockFormat
    def js; yield end
  end
  
  let(:resource) { double errors: [] }
  subject { StandardAjaxResponder.new(controller) }
  
  describe "success and failure" do
    let(:controller) { double :current_resource= => nil }
    
    describe "#success" do
      it "should set the current resource to the decorated one from service class" do
        allow(subject).to receive_messages(render_success: nil, decorated_resource: (decorated_resource = double))
        expect(controller).to receive(:current_resource=).with(decorated_resource)
        subject.success(resource)
      end
      
      it "should render the success template" do
        allow(subject).to receive_messages(decorated_resource: nil)
        expect(subject).to receive(:render_success).with(resource)
        subject.success(resource)
      end
    end
    
    describe "#failure" do
      it "should set the current resource to the decorated one from service class" do
        allow(subject).to receive_messages(render_failure: nil, decorated_resource: (decorated_resource = double))
        expect(controller).to receive(:current_resource=).with(decorated_resource)
        subject.failure(resource)
      end
      
      it "should render the success template" do
        allow(subject).to receive_messages(decorated_resource: nil)
        expect(subject).to receive(:render_failure).with(resource)
        subject.failure(resource)
      end
    end
    
    describe "rendering" do
      let(:format) { MockFormat.new }
      let(:controller) { double(action_name: 'test_action').tap { |controller| allow(controller).to receive(:respond_with).and_yield(format) } }
      describe "#render_success" do
        it "should render the action_name_success template" do
          expect(controller).to receive(:render).with('test_action_success')
          subject.send(:render_success, resource)
        end
      end
      
      describe "#render_failure" do
        it "should render the action_name_failure template for js" do
          expect(controller).to receive(:render).with('test_action_failure').once
          subject.send(:render_failure, resource)
        end
      end
    end
    
    describe "#decorated_resource" do
      it "should decorate the given resource" do
        expect(resource).to receive(:decorate)
        subject.send(:decorated_resource, resource)
      end
    end
  end
end