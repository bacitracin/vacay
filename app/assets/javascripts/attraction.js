// Attraction Constructor
'use strict'
function Attraction(id, name, url, attraction_type, destination){
  this.id = id;
  this.name = name;
  this.url = url;
  this.attraction_type = attraction_type;
  this.destination = destination;
}

Attraction.prototype.formatUrl = function() {
  var origUrl = this.url;
  if (origUrl.includes("http") == true){
    return origUrl;
  }
  else if (origUrl.includes("www.") == true){
    return "http://" + origUrl; 
  }
  else {
    return "http://www." + origUrl; 
  }
}