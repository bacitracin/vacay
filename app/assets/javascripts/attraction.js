// Attraction Constructor
function Attraction(id, name, url, attraction_type, destination){
  this.id = id;
  this.name = name;
  this.url = url;
  this.attraction_type = attraction_type;
  this.destination = destination;
}

// Not currently working
// Attraction.prototype.formatUrl = function(){
//  if url.includes("http"){
//    return url;
//  }
//  else if url.includes("www."){
//    return "http://" + url; 
//  }
//  else {
//    return "http://www." + url;
//  }
//}

// Post attraction - id, url, name, attraction_type, destination, trip
