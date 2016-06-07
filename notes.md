REQUIREMENTS

1. Must render one show page and one index page via jQuery and an Active Model Serialization JSON Backend.
  SINGLE PAGE -show page for a single trip - be able to expand each attraction. should that be a 
  INDEX PAGE - user's trip page - blow out a little bit more information about each trip

2. Must use your Rails api to create a resource and render the response without a page refresh.
  Attraction_API
  Trip_API

  $("a[href='posts/1/comments']").on("click", function(event){event.preventDefault(); showComments();}) 
  1. The ability to load the trips for a user index page via AJAX
    -hijack the click even of the trip link to fire an ajax request   # bind to the event, prevent default
    -fire an ajax request to get the data for the user's trips
    -place the data in the DOM



3. The rails API must reveal at least one has-many relationship in the JSON that is then rendered to the page.
  A trip HAS_MANY attractions
  A user HAS_MANY trips

4. Must have at least one link that loads, or updates a resource without reloading the page.
  See #1

5. Must translate the JSON responses into Javascript Model Objects. The Model Objects must have at least one method on the prototype. Formatters work really well for this.
  ??????