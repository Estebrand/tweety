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

end
