// Attraction Constructor
function Attraction(name, url, city, attraction_type){
  this.name = name,
  this.url = url,
  this.city = city,
  this.attraction_type = attraction_type
  
  // Add a method here
  }
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