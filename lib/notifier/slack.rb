class Notifier::Slack
  def initialize(channel, username)
    @slack = Slack::Notifier.new(Settings.slack.webhook_url, channel: channel, username: username)
  end

  def send(message)
    @slack.ping(message)
  end
end
