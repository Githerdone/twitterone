$(document).ready(function() {

	setInterval(function() {
		var return_data = $.post('/update_tweets');
    return_data.done(function(tweets) {
			for (var i = 0; i < tweets.length - 1; i++) {
      $('#tweet_list ol').prepend("<li><p>Added " + tweets[i].created + "minute(s) ago.</p>" + tweets[i].tweet + "</li>" ).fadeIn(3000);
      } 
      var num_tweets = $('#tweet_list ol li').size();
      console.log(num_tweets)
      if(num_tweets >= 10) {
      $('#tweet_list li:last-child').remove();
      };
		});
	},1000 * 60 * 15);

});










