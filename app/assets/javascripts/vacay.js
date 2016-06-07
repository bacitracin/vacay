// Click on get more info link on the user/trip index page, populates with trips?s

$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();
    $.get(this.href).success(function(response){
      $("div.trip-info").html(response)
    })
  })
})