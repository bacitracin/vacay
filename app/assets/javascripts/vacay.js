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

// Attraction Constructor
function Attraction(name, url, city, attraction_type){
  this.name = name,
  this.url = url,
  this.city = city,
  this.attraction_type = attraction_type
}

// Click to get more info on Attraction on Trip show page
$(function(){
  $(".js-more-attraction").on("click", function(event){
    event.preventDefault();

    var attractionUrl = (this.href += ".json");

    // AJAX call
    $.get(attractionUrl).success(function(response){
      console.log(response);
      var attractionDiv = 'div.attraction-info-' + response["attraction"]["id"];

      var newAttractionInfo = new Attraction(
        response["attraction"]["name"],
        response["attraction"]["url"],
        response["attraction"]["city"],
        response["attraction"]["attraction_type"]
        );

      $(attractionDiv).append(
        "Type: " + newAttractionInfo.attraction_type);
    })
  })
})

// Click on get more info link on the user/trip index page, shows more trip details
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