var ownerdNotepad, notepadreader;
document.onkeyup = function (data) {
  if (data.which == 27) {
    $.post("http://rsg-notes/escape", JSON.stringify({}));
    if (notepadreader == true) {
      let x = document.getElementById("p1").value;
      $.post("http://rsg-notes/updating", JSON.stringify({ text: x }));
      $("#main").fadeOut();
      $("#main").css("display", "none");
      notepadreader = false;
      document.getElementById("p1").value = "";
    } else {
      ownerdNotepad = document.getElementById("p1").value;
      $("#main").fadeOut();
      $("#main").css("display", "none");
    }
  }
};

function dropNotepad() {
  let x = document.getElementById("p1").value;
  if (x !== "") {
    $.post("http://rsg-notes/save", JSON.stringify({ text: x }));
    $("#main").fadeOut();
    document.getElementById("p1").value = "";
    $("#main").css("display", "none");
  }
}

window.addEventListener("message", function (e) {
  switch (event.data.action) {
    case "openNotepad":
      if (ownerdNotepad === undefined) {
        document.getElementById("p1").value = "";
        $("#main").fadeIn();
      } else {
        $("textarea").removeAttr("disabled", "disabled");
        $("button").fadeIn();
        document.getElementById("p1").value = ownerdNotepad;
        $("#main").fadeIn();
      }
      break;
    case "openNotepadRead":
      notepadreader = true;
      $("textarea").attr("disabled", "disabled");
      $("button").hide();
      $("#main").fadeIn();
      document.getElementById("p1").value = event.data.TextRead;
      break;
    case "closeNotepad":
      $("#main").fadeOut();
      $("#main").css("display", "none");
      break;
    case "cleanNotepad":
      document.getElementById("p1").value = "";
      break;
  }
});
