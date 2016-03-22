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
  createIdea()
  deleteIdea()
})

function truncateBody(body) {
  if (body.length > 100){
    return body.substring(0, 100).split(" ").slice(0, -1).join(" ")
  } else {
    return body
  }
}

function renderIdea(idea) {
  $("#ideas-list").prepend(
    "<div class='idea' data-id='"
    + idea.id
    + "'><h3>"
    + idea.title
    + "</h3><p>"
    + truncateBody(idea.body)
    + "</p><p>Quality: "
    + idea.quality
    + "</p>"
    + "<button id='delete-idea' name='button-delete' class='btn'>Delete</button>"
    + "</div>"
    )
}

function fetchIdeas() {
  // var newestIdeaID = parseInt($(".idea").first().attr("data-id"))

  $.ajax({
    type:    "GET",
    url:     "/api/v1/ideas.json",
    success: function(ideas) {
      $.each(ideas, function(index, idea) {
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

function createIdea() {
  $("#create-idea").on("click", function() {
    var ideaParams = {
      idea: {
        title: $("#idea-title").val(),
        body: $("#idea-body").val()
      }
    }

    $.ajax({
      type:    "POST",
      url:     "/api/v1/ideas.json",
      data:    ideaParams,
      success: function(newIdea) {
        renderIdea(newIdea)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })

    $("input[type='text']").val("");
  })
}

function deleteIdea() {
  $("#ideas-list").delegate("#delete-idea", 'click', function() {
    var $idea = $(this).closest(".idea")

    $.ajax({
      type: "DELETE",
      url: "/api/v1/ideas/" + $idea.attr('data-id') + ".json",
      success: function() {
        $idea.remove()
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })

}
