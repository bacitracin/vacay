// Trip Constructor
function Trip(user, trip_id, destination, trip_nickname, start_date, end_date, attractions, array_index=""){
  this.user = user; // user object
  this.trip_id = trip_id;
  this.destination = destination; // destination object
  this.trip_nickname = trip_nickname;
  this.start_date = start_date;
  this.end_date = end_date;
  this.attractions = attractions; // array
  this.array_index = array_index;
}

// Countdown method lets you know if the trip is upcoming or past
Trip.prototype.countdown = function (){
  var today = new Date();
  var parsedToday = Date.parse(today);
  var parsedStartDate = Date.parse(this.start_date);
  var parsedEndDate = Date.parse(this.end_date);

  if (parsedStartDate > parsedToday) {
    return "This trip is coming up. Time to pack!";
  } 
  else if (parsedEndDate < parsedToday) {
    return "This trip has passed. That was fun.";
  } 
  else {
    return "This trip is in progress. Have fun!";
  }
}

// Click on "More info" ink on the trip index page, shows more trip details
$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();
    // this is <a class="js-more" href="/trips/1">More Info</a>

    // AJAX call
    $.get(this.href + ".json").success(function(response){
      var tripDiv = 'div.trip-info-' + response["trip"]["id"];

      // Use the Trip constructor
      var newTripInfo = new Trip(
        response["trip"]["user"],
        response["trip"]["id"],
        response["trip"]["destination"],
        response["trip"]["trip_nickname"],
        response["trip"]["start_date"],
        response["trip"]["end_date"],
        response["trip"]["attractions"]
        );

      // Show trip data in the div
      $(tripDiv).html("<ul>" + "<b>" + newTripInfo.countdown() + "</b>"
        + "<li>" + "City: " + newTripInfo.destination.city+ "</li>"
        + "<li>" + "Start Date: " + newTripInfo.start_date + "</li>"
        + "<li>" + "End Date: " + newTripInfo.end_date + "</li>" 
        + "</ul>"
        );
      $(tripDiv).toggle();
    })
  })
})

// Next button on the Show page
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
        tripList[nextTripIndex]["destination"],
        tripList[nextTripIndex]["trip_nickname"],
        tripList[nextTripIndex]["start_date"],
        tripList[nextTripIndex]["end_date"],
        tripList[nextTripIndex]["attractions"],
        nextTripIndex
        );   

      // Use jQuery to change the values on the page 
      $("#username").html("<a href='/users/" + nextTripInfo.user.id + "'>" + nextTripInfo.user.username) + "</a>";
      $("#trip-nickname").text(nextTripInfo.trip_nickname);
      $("#city").html("<a href='/destinations/" + nextTripInfo.destination.id + "'>" + nextTripInfo.destination.city) + "</a>";
      $("#city2").text(nextTripInfo.destination.city + " To Do List");
      $("#start-date").text(nextTripInfo.start_date);
      $("#end-date").text(nextTripInfo.end_date);
      $("#trip-id").text(nextTripInfo.trip_id);

      $("#attractions").html(""); // Clear out the div
      // Iterate over attractions & add to the page

      for(i=0; i< nextTripInfo.attractions.length; i++){
        var newAttraction = new Attraction(
          nextTripInfo.attractions[i]["id"],
          nextTripInfo.attractions[i]["name"],
          nextTripInfo.attractions[i]["url"],
          nextTripInfo.attractions[i]["attraction_type"],
          nextTripInfo.attractions[i]["destination"]
          );
        // Attraction append
        $("#attractions").append("<li>" 
          + "<a href='/attractions/" + newAttraction.id +  "'>" + newAttraction.name + "</a>   -   " 
          + newAttraction.attraction_type + "   -   " 
          + "<a href='" + newAttraction.url + "'> Website </a>" + "</li>");
      }
    })
  })
})
