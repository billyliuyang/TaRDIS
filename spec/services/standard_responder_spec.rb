require 'spec_helper'
require 'byebug'
require 'services/standard_responder'

describe StandardResponder do

  class MockController
    def current_resource; end
    def current_resource=(cr); end
    def resource_name; end
    def flash
      {}
    end
    def set_redirect_flash; end
    def respond_with(*args); end
    def url_for(*args); end
  end

  let(:controller) { MockController.new }
  let(:resource)   { double }

  subject { StandardResponder.new(controller) }
  describe "Respond" do

    describe "#success" do
      it "should set the current resource to the one from service class" do
        expect(controller).to receive(:current_resource=).with(resource)
        allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
        subject.success(resource)
      end

      it "should set the flash message" do
        expect(subject).to receive(:set_success_message)
        subject.success(resource)
      end

      it "should do the default redirect" do
        allow(controller).to receive_messages(url_for: '/')
        expect(controller).to receive(:respond_with).with(resource, { location: '/' })
        allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
        subject.success(resource)
      end

      it "should do the custom redirect" do
        allow(subject).to receive_messages(redirect_path: 'some location')
        expect(controller).to receive(:respond_with).with(resource, { location: 'some location' })
        allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
        subject.success(resource)
      end
    end

    describe "#failure" do
      it "should set the current resource to the one from service class" do
        expect(controller).to receive(:current_resource=).with(resource)
        allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
        subject.failure(resource)
      end

      it "should set the flash message" do
        expect(subject).to receive(:set_failure_message)
        subject.failure(resource)
      end

      it "should do the default render" do
        allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
        expect(controller).to receive(:respond_with).with(resource, { action: nil })
        subject.failure(resource)
      end

      it "should do the custom render" do
        allow(subject).to receive_messages(action_name: :edit)
        allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
        expect(controller).to receive(:respond_with).with(resource, { action: :edit })
        subject.failure(resource)
      end
    end
  end

  describe "#redirect_path" do
    it "should return the index location" do
      expect(controller).to receive(:url_for).with({ action: :index })
      subject.send :redirect_path
    end
  end

  describe "Messages" do
    before { allow(controller).to receive_messages(resource_name: 'study') }
    describe "#set_success_message" do
      it "should set the flash message" do
        allow(subject).to receive_messages(success_message: 'success message')
        allow(controller).to receive_messages(flash: {})
        subject.send :set_success_message
        expect(controller.flash[:notice]).to eq('success message')
      end
    end

    describe "#set_failure_message" do
      it "should set the flash message" do
        allow(subject).to receive_messages(failure_message: 'failure message')
        allow(controller).to receive_message_chain(:flash, now: {})
        subject.send :set_failure_message
        expect(controller.flash.now[:alert]).to eq('failure message')
      end
    end
  end

  describe '#initialize' do
    subject { StandardResponder.new(controller, success_text: 'success message',
      failure_text: 'failure message',
      redirect_path: 'some location', action_name: :edit) }

    it 'should flash the success text' do
      allow(controller).to receive_messages(flash: {})
      subject.success(resource)
      expect(controller.flash[:notice]).to eq('success message')
    end

    it 'should flash the failure text' do
      allow(controller).to receive_message_chain(:flash, now: {})
      subject.failure(resource)
      expect(controller.flash.now[:alert]).to eq('failure message')
    end

    it 'should redirect to the redirect path on success' do
      expect(controller).to receive(:respond_with).with(resource, { location: 'some location' })
      allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
      subject.success(resource)
    end

    it 'should render the given action on failure' do
      expect(controller).to receive(:respond_with).with(resource, { action: :edit })
      allow(subject).to receive_messages(set_success_message: nil, set_failure_message: nil)
      subject.failure(resource)
    end
  end

end
