// Click on get more info link on the user/trip index page, populates with trips?s

// JSON
$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();
    // this is <a class="js-more" href="/trips/1">More Info</a>
    var tripUrl = (this.href += ".json");

    // AJAX call
    $.get(tripUrl).success(function(response){
      var tripDiv = 'div.trip-info-' + response["trip"]["id"];

      var newTripInfo = new Trip(
        response["trip"]["user_id"],
        response["trip"]["destination"]["city"],
        response["trip"]["trip_nickname"],
        response["trip"]["start_date"],
        response["trip"]["end_date"]
        );
      
      // Show data
      $(tripDiv).append(newTripInfo.trip_nickname 
        + " is in " + newTripInfo.city + " from " + newTripInfo.start_date
        + " to " + newTripInfo.end_date);
    })
  })
})

// Trip Constructor
function Trip(user_id, city, trip_nickname, start_date, end_date){
  this.user_id = user_id;
  this.city = city;
  this.trip_nickname = trip_nickname;
  this.start_date = start_date;
  this.end_date = end_date;
}

// Placeholder
Trip.prototype.capitalize = function(){

}