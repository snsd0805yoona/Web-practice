let section = document.querySelector("section");
let add = document.querySelector("#addButton");
add.addEventListener("click", e => {
    e.preventDefault();

    //get the input values
    let form = e.target.parentElement;
    
    let todoText = form.children[0].value;
    let todoMonth = form.children[1].value;
    let todoDay = form.children[2].value;

    if(todoText ===""){
        alert("Please enter the value!")
        return;
    }

    // create an todo

    let todo = document.createElement("div");
    todo.classList.add("todo");
    let text = document.createElement("p");
    text.classList.add("todo-text");
    text.innerText = todoText;

    let time = document.createElement("p");
    time.classList.add("todo-item");
    time.innerText = todoMonth + " / "+ todoDay;

    todo.append(text);
    todo.appendChild(time);

    //create green check and red trash can
    let completeButton = document.createElement("button");
    completeButton.classList.add("complete");
    completeButton.innerHTML = '<i class="fas fa-check"></i>';


    completeButton.addEventListener("click", e =>{
        let todoItem = e.target.parentElement;
        todoItem.classList.toggle("done");
    })


    let trashButton = document.createElement("button");
    trashButton.classList.add("trash");
    trashButton.innerHTML = '<i class="fas fa-trash"></i>';

    trashButton.addEventListener("click", e =>{
        let todoItem = e.target.parentElement;

        todoItem.addEventListener("animationEnd", () => {
            todoItem.remove();
        })

        todoItem.style.animation = "scaleDown 0.5s forwards";
        
    })

    todo.appendChild(completeButton);
    todo.appendChild(trashButton);



    todo.style.animation = "scaleUp 0.5s forwards";
    
    for(let i = 0; i<form.children.length; i++){
        form.children[i].value = "";
    }

    section.appendChild(todo);

})

