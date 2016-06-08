// Click on get more info link on the user/trip index page, populates with trips?s

// JSON
$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();

    var tripUrl = (this.href += ".json");
    $.get(tripUrl).success(function(response){
      $("div.trip-info").append(response["trip"]["destination"]["city"]);
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