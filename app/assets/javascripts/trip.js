// Trip Constructor
function Trip(user_id, city, trip_nickname, start_date, end_date){
  this.user_id = user_id
  this.city = city;
  this.trip_nickname = trip_nickname;
  this.start_date = start_date;
  this.end_date = end_date;

  // Finish this method - Lets you know if the trip is upcoming or past
  this.countdown = function(){
    var todayDate = new Date();
    if(start_date.getTime() > todayDate.getTime()){
      return "This trip is coming up";
    }
    else {
      return "This trip has already passed";
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
      $(tripDiv).html("<ul>" + "<li>" + "City: " + newTripInfo.city+ "</li>"
        + "<li>" + "Start Date: " + newTripInfo.start_date + "</li>"
        + "<li>" + "End Date: " + newTripInfo.end_date + "</li>" 
        + "</ul>"
        );
    })
  })
})