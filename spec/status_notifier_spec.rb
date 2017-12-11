require 'spec_helper'

describe StatusNotifierHandler do

  let(:slack_params) do
    {
      enabled: true,
      webhook_url: "https://hooks.slack.com/services/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",
      channel: "#test",
      username: "FaiNow-Test"
    }
  end

  let(:hipchat_params) do
    {
      enabled: true
    }
  end

  context 'without custom message' do
    it 'should run without error' do
      allow_any_instance_of(StatusNotifierHandler).to receive(:send_to_slack).and_return(true)
      allow_any_instance_of(StatusNotifierHandler).to receive(:send_to_hipchat).and_return(true)
      expect{StatusNotifierHandler.new(slack_params, hipchat_params).report}.to_not raise_error
    end
  end

  context 'with custom message' do
    let(:custom_message_params) do
      {
        success_message: '"Success on #{node.name}"',
        failed_message: '"Failed on #{node.name}"'
      }
    end

    it 'should run without error' do
      allow_any_instance_of(StatusNotifierHandler).to receive(:send_to_slack).and_return(true)
      allow_any_instance_of(StatusNotifierHandler).to receive(:send_to_hipchat).and_return(true)
      expect{StatusNotifierHandler.new(slack_params, hipchat_params, custom_message_params).report}.to_not raise_error
    end
  end
end
