$(document).ready(function() {

  refreshTweets();

  $('#create_tweet').submit(function(e) {
    e.preventDefault();
    console.log('hello')
    var request = $.post('/post_tweet', $('textarea'));
    request.done(function(tweet) {
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

function new_tweets(tweets) {
  for (var i = 0; i < tweets.length; i++) {
    $('#tweet_list ol').prepend("<li style='background-color: #F8F8F8'><p data-createdat =" + tweets[i].created_at + ">" + analyzetime(tweets[i].created_at) + "</p> " + tweets[i].tweet + "</li>");
    remove_post();
    date = new Date(tweets[i].created_at)
    console.log('this should be real date')
    console.log((Date.now() - date) / 60);
  };
}

function refreshTweets() {
  var request = $.post(location.pathname+'/tweets');
  request.done(function(tweets) {
    new_tweets(tweets);
    // setTimeout(refreshTweets, 10000);
    $('li p').each(function() {
       created = new Date($(this).context.dataset.createdat);
       seconds = (Date.now() - created)
       var numminutes = Math.floor(((seconds % 31536000) % 86400) % 3600);
       console.log(numminutes + " minutes ago")
    })
  });
}

function refreshTime(){

}

function analyzetime(created_at) {
  console.log('in the function')
  created = new Date(created_at)
  time_ago = (Date.now() - created) / 60

  if (time_ago < 60){
    return "Added less than 1 minute ago."
    console.log("<p>Added less than 1 minute ago.</p>")
  }else{
    return "Added " + time_ago / 60 + "minute(s) ago."
    console.log('else statement')
  }
}


// ((Time.now - i.created_at) / 60).ceil %> minute(s) ago.
