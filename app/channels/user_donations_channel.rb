class ChatChannel < ApplicationCable::Channel
  def follow(data)
    unfollow
    stream_from "user_donations_#{data['user_id']}"
  end

  def unfollow
    stop_all_streams
  end
end
