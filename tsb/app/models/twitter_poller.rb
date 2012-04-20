require 'twitter'

class TwitterPoller

  def self.timeline
    results = Array.new
    Twitter.user_timeline.last(10).each do |tweet|
      tweet_obj = Tweet.new(
        tweet[:text],
        tweet[:from_user],
        tweet[:profile_image_url],
        tweet[:created_at])

      results << tweet_obj
    end
    results
  end
end
