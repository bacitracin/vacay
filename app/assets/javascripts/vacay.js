// Click on get more info link on the user/trip index page, populates with trips?s

// Trip Constructor
function Trip(user_id, city, trip_nickname, start_date, end_date){
  this.user_id = user_id;
  this.city = city;
  this.trip_nickname = trip_nickname;
  this.start_date = start_date;
  this.end_date = end_date;

  // Lets you know if the trip is upcoming or past
  this.countdown = function(){
    var todayDate = new Date();
    if(start_date.getTime() > todayDate.getTime()){
      return "This trip is coming up";
    }
    else {
      return "This trip has already passed";
    }
  }
}

$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();
    // this is <a class="js-more" href="/trips/1">More Info</a>
    
    var tripUrl = (this.href += ".json");

    // AJAX call
    $.get(tripUrl).success(function(response){
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
      $(tripDiv).append(newTripInfo.trip_nickname 
        + " is in " + newTripInfo.city + " from " + newTripInfo.start_date
        + " to " + newTripInfo.end_date);
    })
  })
})