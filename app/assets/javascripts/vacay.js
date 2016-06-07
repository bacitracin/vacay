// Click on get more info link on the user/trip index page, populates with trips?s

$(function () {
  $(".js-more").on('click', function(event) {
    event.preventDefault();
    var id = $(this).data("id");
    $.get("/trips/" + id + ".json", function(data) {
      // Replace text of body-id div
      $("div.trip-info").html(data);
    });
  });
});