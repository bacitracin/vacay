// Click on get more info link on the user/trip index page, populates with trips?s

// JSON
$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();
    // this is <a class="js-more" href="/trips/1">More Info</a>
    var tripUrl = (this.href += ".json");

    $.get(tripUrl).success(function(response){
      var tripDiv = response["trip"]["id"];
      console.log(tripDiv);

      var trip = response["trip"]["destination"]["city"];
      console.log(trip);


      $('div.trip-info-'+tripDiv).append(trip);
    })
  })
})

// Add Trip Info
function addTripInfoToPage(response){
  $("div.trip-info").append(response["trip"]["destination"]["city"]);
};

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