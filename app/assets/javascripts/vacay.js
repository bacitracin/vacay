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


// JSON return
$(function(){
  $(".js-more").on("click", function(event){
    event.preventDefault();

    alert("this is working");
  })
})