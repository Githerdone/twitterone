$(document).ready(function() {

	setInterval(function() {
		var return_data = $.post('/update_tweets');
    return_data.done(function(tweets) {
     for (var i = 0; i < tweets.length; i++) {
      $('#tweet_list ol').prepend("<li style='background-color: #F8F8F8'><p>Added " + tweets[i].tweet.created_at + "minute(s) ago.</p>" + tweets[i].tweet.tweet + "</li>");
      remove_post();
    };
  });

  }, 1000 * 60 * .1);

  $('#create_tweet').submit(function(e) {
    e.preventDefault();
    var return_data = $.post('/post_tweet', $('textarea'));
    return_data.done(function(tweet) {
     if (tweet.key == "tweet_posted") {
      $('textarea[name="comments"]').val('');
    };
  });
  });
});

function remove_post() {
  var num_tweets = $('#tweet_list ol li').size();
  if(num_tweets > 10) {
    $('#tweet_list li:last-child').remove();
  };
};
