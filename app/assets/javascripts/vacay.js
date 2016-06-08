// Click on get more info link on the user/trip index page, populates with trips?s

// HTML works sort of, you can input the entire page
//$(function(){
//  $(".js-more").on("click", function(event){
//    event.preventDefault();
//    $.get(this.href).success(function(response){
//      $("div.trip-info").html(response)
//    })
//  })
//})


// JSON

$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();

    var tripUrl = (this.href);
    tripUrl += ".json";
    var tripInfo = $.get(tripUrl);
    
    console.log(tripInfo);
    alert("i'm working");

  })
})

function Trip (user_id, destination_id, trip_nickname, start_date, end_date){
  this.user_id = user_id
  this.destination_id = destination_id
  this.trip_nickname = trip_nickname
  this.start_date = start_date
  this.end_date = end_date
}

Trip.prototype.capitalize = function(){

}