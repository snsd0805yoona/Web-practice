

const lastword = document.querySelector("#eighth");
const animation = document.querySelector("div.animation");
lastword.addEventListener("animationend", () =>{
    animation.style = "transition: all 2s ease; opacity: 0; pointer-events: none;"
}
)