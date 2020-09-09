class GithubChannel < ApplicationCable::Channel
  def subscribed
    stream_for "github_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
