$(document).ready(function() {

	setInterval(function() {
		$.post('/update_tweets', function() {
			// console.log(data);
		}).done(funciton() {
			console.log(data[0].text)
		})
	}, 1000 * 60 * .2);

	



});
