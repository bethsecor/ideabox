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
  upQuality()
  downQuality()
  editTitle()
  editBody()
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
    + "'><h3 id='edit-title' contenteditable='true'>"
    + idea.title
    + "</h3><p id='edit-body' contenteditable='true'>"
    + truncateBody(idea.body)
    + "</p><p class='quality'>Quality: "
    + idea.quality
    + "</p>"
    + "<button id='up-quality' name='button-up-quality' class='btn'>up</button>"
    + "<button id='down-quality' name='button-down-quality' class='btn'>down</button>"
    + "</br>"
    + "<button id='delete-idea' name='button-delete' class='btn'>Delete</button>"
    + "</div>"
    )
}

function fetchIdeas() {
  $.ajax({
    type:    "GET",
    url:     "/api/v1/ideas.json",
    success: function(ideas) {
      $.each(ideas, function(index, idea) {
          renderIdea(idea)
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

function qualityUpped(quality) {
  if (quality === "swill") {
    return "plausible"
  } else if (quality === "plausible"){
    return "genius"
  }
}

function upQuality() {
  $("#ideas-list").delegate("#up-quality", 'click', function() {
    var $idea = $(this).closest(".idea")
    var quality = $idea.find(".quality").html().split(": ")[1]

    if (quality !== "genius"){
      var ideaQuality = {
        idea: {
          quality: qualityUpped(quality)
        }
      }

      $.ajax({
        type: "PUT",
        url: "/api/v1/ideas/" + $idea.attr('data-id') + ".json",
        data: ideaQuality,
        success: function(updateIdea) {
          $idea.find(".quality").text("Quality: " + ideaQuality['idea']['quality'])
        },
        error: function(xhr) {
          console.log(xhr.responseText)
        }
      })
    }
  })
}

function qualityDowned(quality) {
  if (quality === "genius") {
    return "plausible"
  } else if (quality === "plausible"){
    return "swill"
  }
}

function downQuality() {
  $("#ideas-list").delegate("#down-quality", 'click', function() {
    var $idea = $(this).closest(".idea")
    var quality = $idea.find(".quality").html().split(": ")[1]
    if (quality !== "swill"){
      var ideaQuality = {
        idea: {
          quality: qualityDowned(quality)
        }
      }

      $.ajax({
        type: "PUT",
        url: "/api/v1/ideas/" + $idea.attr('data-id') + ".json",
        data: ideaQuality,
        success: function(updateIdea) {
          $idea.find(".quality").text("Quality: " + ideaQuality['idea']['quality'])
        },
        error: function(xhr) {
          console.log(xhr.responseText)
        }
      })
    }
  })
}

function editTitle() {
  $("#ideas-list").delegate("#edit-title", 'focusout keydown', function(){

    var $idea = $(this).closest(".idea")

    if (event.which == 0 || event.which == 13){

      if (event.which == 13){
        event.preventDefault();
        $(this).blur();
      }

      var newIdeaTitle = { idea: { title: event.target.innerHTML } }

      $.ajax({
        type: "PUT",
        url: "/api/v1/ideas/" + $idea.attr('data-id') + ".json",
        data: newIdeaTitle,
        success: function(updateIdea) {
        },
        error: function(xhr) {
          document.execCommand('undo');
          console.log(xhr.responseText)
        }
      })

    } else if (event.keyCode == 27) {
      document.execCommand('undo');
      $(this).blur();
    }
  })
}

function editBody() {
  $("#ideas-list").delegate("#edit-body", 'focusout keydown', function(){

    var $idea = $(this).closest(".idea")

    if (event.which == 0 || event.which == 13){

      if (event.which == 13){
        event.preventDefault();
        $(this).blur();
      }

      var newIdeaBody = { idea: { body: event.target.innerHTML } }

      $.ajax({
        type: "PUT",
        url: "/api/v1/ideas/" + $idea.attr('data-id') + ".json",
        data: newIdeaBody,
        success: function(updateIdea) {
        },
        error: function(xhr) {
          document.execCommand('undo');
          console.log(xhr.responseText)
        }
      })

    } else if (event.keyCode == 27) {
      document.execCommand('undo');
      $(this).blur();
    }
  })
}
