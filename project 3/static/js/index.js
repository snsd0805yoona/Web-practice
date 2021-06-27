$(document).ready(function () {
    // click sign in to reveal login form
    $("#signinLink").on("click", function (e) {
        $("#Login-container").css("display", "block");
    });

    // click cancel to close login form
    $("#Login--cancel").on("click", function () {
        $("#Login-container").css("display", "none");
    });

    // click on anywhere outside the form to close the form
    $(".modal").on("click", function (e) {
        if (e.target !== this)
            return;
        $("#Login-container").css("display", "none");
    });
    //Get the button:
    
});
mybutton = document.getElementById("top");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0; // For Safari
  document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
}
