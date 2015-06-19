require 'rubygems'

unless ENV['RSPEC']
  require 'chef'
  require 'chef/handler'
end
require 'hipchat'
require 'slack-notifier'

class StatusNotifierHandler < Chef::Handler

  def initialize(slack_params, hipchat_params)
    initialize_hipchat(hipchat_params)
    initialize_slack(slack_params)
  end

  def initialize_hipchat(params)
    @hipchat_params = params
  end

  def initialize_slack(params)
    @slack_params = params
  end

  def report
    if run_status.failed?
      msg = "Failure on #{node.name}: #{run_status.formatted_exception}"
      status = :failed
      send_to_hipchat(msg)
    else
      msg = "Chef run succesfully on #{node.name}"
      status = :success
    end

    send_to_slack(node.name, status, msg)
    send_to_hipchat(msg)
  end

  private

  def send_to_hipchat(msg)
    return unless @hipchat_params[:enabled]
    hipchat[@hipchat_params[:room_name]].send(@hipchat_params[:username], msg, :notify => @hipchat_params[:notify])
  end

  def send_to_slack(node_name, status, msg)
    return unless @slack_params[:enabled]
    slack.channel = @slack_params[:channel]
    slack.username = @slack_params[:username]
    slack.ping '', attachments: [slack_attachment(node_name, status, msg)]
  end

  def hipchat
    @hipchat ||= HipChat::Client.new(@hipchat_params[:api_token])
  end

  def slack
    @slack ||= Slack::Notifier.new(@slack_params[:webhook_url])
  end

  def slack_attachment(node_name, status, msg)
    color = (status == :failed)? "#ff0000" : "#36a64f"
    {
      fallback: "Opsworks status, #{msg}",
      color: "#{color}",
      author_name: "OpsworksBot (#{node_name})",
      title: "status: #{status}",
      text: "#{msg}"
    }
  end
end
