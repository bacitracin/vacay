// Trip Constructor
function Trip(user, trip_id, city, trip_nickname, start_date, end_date, attractions, array_index=""){
  this.user = user;
  this.trip_id = trip_id;
  this.city = city;
  this.trip_nickname = trip_nickname;
  this.start_date = start_date;
  this.end_date = end_date;
  this.attractions = attractions; // array
  this.array_index = array_index;

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

// Attraction Constructor
function Attraction(attraction_id, name, url, attraction_type){
  this.attraction_id = attraction_id;
  this.name = name;
  this.url = url;
  this.attraction_type = attraction_type;
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
        response["trip"]["user"],
        response["trip"]["id"],
        response["trip"]["destination"]["city"],
        response["trip"]["trip_nickname"],
        response["trip"]["start_date"],
        response["trip"]["end_date"],
        response["trip"]["attractions"]
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

// Next button
$(function(){
  $(".js-next").on("click", function(event){
    event.preventDefault();
    var thisTripId= $('#trip-id').text();

    $.get("/trips.json").success(function(response){
      // List of trip objects
      var tripList = response["trips"];

      // Find the index of the current trip by comparing with trip id
      var tripIndex;
      for(i = 0; i < tripList.length; i++){
        if (tripList[i]["id"] == thisTripId){
          tripIndex = i;
        }
      }
      // This will be the index for the next trip in the list
      var nextTripIndex = tripIndex + 1;
      if (nextTripIndex == tripList.length){ //if you get to the end of the line reset the tripindex
        nextTripIndex = 0;
      }

      // Find & create the next trip in the list, then use jquery to show it on the page
      // Should only be able to cycle between your trips, so no need to change user name
      var nextTripInfo = new Trip(
        tripList[nextTripIndex]["user"],
        tripList[nextTripIndex]["id"],
        tripList[nextTripIndex]["destination"]["city"],
        tripList[nextTripIndex]["trip_nickname"],
        tripList[nextTripIndex]["start_date"],
        tripList[nextTripIndex]["end_date"],
        tripList[nextTripIndex]["attractions"],
        nextTripIndex
        );   

      // Use jQuery to change the values on the page 
      // add change username
      $("#username").text(nextTripInfo.user.username);
      $("#trip-nickname").text(nextTripInfo.trip_nickname);
      $("#city").text(nextTripInfo.city);
      $("#city2").text(nextTripInfo.city + " To Do List");
      $("#start-date").text(nextTripInfo.start_date);
      $("#end-date").text(nextTripInfo.end_date);
      $("#trip-id").text(nextTripInfo.trip_id);
      $("#attractions").text(nextTripInfo.attractions);// not sure if this is right

    })
  })
})




