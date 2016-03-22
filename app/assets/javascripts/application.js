// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  fetchIdeas()
})

function truncateBody(body) {
  if (body.length > 100){
    return body.substring(0, 100).split(" ").slice(0, -1).join(" ")
  } else {
    return body
  }
}

function renderIdea(idea) {
  $("#ideas-list").append(
    "<div class='idea' data-id='"
    + idea.id
    + "'><h3>"
    + idea.title
    + "</h3><p>"
    + truncateBody(idea.body)
    + "</p><p>Quality: "
    + idea.quality
    + "</p></div>"
    )
}

function fetchIdeas() {
  // var newestIdeaID = parseInt($(".idea").first().attr("data-id"))

  $.ajax({
    type:    "GET",
    url:     "/api/v1/ideas.json",
    success: function(ideas) {
      $.each(ideas.reverse(), function(index, idea) {
        // if (isNaN(newestIdeaID) || idea.id > newestIdeaID) {
          renderIdea(idea)
        // }
      })
    },
    error: function(xhr) {
      console.log(xhr.responseText)
    }
  })
}
