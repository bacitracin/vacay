// Click on get more info link on the user/trip index page, populates with trips?

$(function(){
  $("a.trip-info").on("click", function(event){
    $.ajax({
    method: "GET",
    url: this.href,
    }).done(function(response){
    $("div.trip-info")html(response)
    })
    event.preventDefault();
  })
})