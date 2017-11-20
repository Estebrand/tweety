module TweetsHelper



	def get_tagged(tweet)
		message_arr = Array.new
		message_arr = tweet.message.split
	
		message_arr.each_with_index do |word, index|
			
			if word[0] =="#"
        #create new instance of Tag
        
        if Tag.pluck(:phrase).include?(word.downcase)
          #save that tage as a var (to  use in TweetTag creation)
          tag = Tag.find_by(phrase: word.downcase)
        else
          #create a new instance of the tag
          tag = Tag.create(phrase: word.downcase)
        end
        tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
      end
    end

    # PUT THE TWEET BACK TOGETHER
    tweet.message = message_arr.join(" ")	
    	puts'----------------'
			puts tweet.message
			puts'---------------'
    return tweet

	end

  def hot_tags
    tags = Tag.order(created_at: :desc).limit(4)
    return tags
  end

  def top_tweeter
    tweets = Tweet.all
    if tweets.length > 0
      user_id = Tweet.all.group_by { |h| h['user_id']}.to_a.max_by {|x| x[1].length}.first
    
      user = User.find(user_id)
      return user
    end
  end

  def top_tweets
    tweets = Tweet.all
      if tweets.length > 0
        user_id = Tweet.all.group_by { |h| h['user_id']}.to_a.max_by {|x| x[1].length}.first

        tweets = Tweet.where(user_id: user_id)
        return tweets.length
      end
  end


end
