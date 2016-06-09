// Trip Constructor
function Trip(user_id, city, trip_nickname, start_date, end_date){
  this.user_id = user_id
  this.city = city;
  this.trip_nickname = trip_nickname;
  this.start_date = start_date;
  this.end_date = end_date;

  // Finish this method - Lets you know if the trip is upcoming or past
  this.countdown = function(){
    var today = new Date();
    var parsedToday = Date.parse(today);
    var parsedStartDate = Date.parse(start_date);
    var parsedEndDate = Date.parse(end_date);
    if(parsedStartDate > parsedToday) {
      return "This trip is coming up. Time to pack!";
    }
    else if(parsedEndDate < parsedToday) {
      return "This trip has passed. That was fun.";
    } else {
      return "This trip is in progress. Have fun!";
    }
  };
}

// Click on get more info link on the user/trip index page, shows more trip details
$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();
    // this is <a class="js-more" href="/trips/1">More Info</a>

    // AJAX call
    $.get(this.href + ".json").success(function(response){
      var tripDiv = 'div.trip-info-' + response["trip"]["id"];

      // Use the trip constructor
      var newTripInfo = new Trip(
        response["trip"]["user_id"],
        response["trip"]["destination"]["city"],
        response["trip"]["trip_nickname"],
        response["trip"]["start_date"],
        response["trip"]["end_date"]
        );
      
      // Show data in the div
      $(tripDiv).html("<ul>" + "<b>" + newTripInfo.countdown() + "</b>"
        + "<li>" + "City: " + newTripInfo.city+ "</li>"
        + "<li>" + "Start Date: " + newTripInfo.start_date + "</li>"
        + "<li>" + "End Date: " + newTripInfo.end_date + "</li>" 
        + "</ul>"
        );
    })
  })
})