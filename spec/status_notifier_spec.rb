require 'spec_helper'

describe StatusNotifierHandler do

  let(:slack_params) do
    {
      enabled: true,
      webhook_url: "https://slacktest.com",
      channel: "#test",
      username: "FaiNow-Test"
    }
  end

  let(:hipchat_params) do
    {
      enabled: true
    }
  end

  it 'should run without error' do
    allow_any_instance_of(StatusNotifierHandler).to receive(:send_to_slack).and_return(true)
    allow_any_instance_of(StatusNotifierHandler).to receive(:send_to_hipchat).and_return(true)
    expect{StatusNotifierHandler.new(slack_params, hipchat_params).report}.to_not raise_error
  end

end
