
let n1=0;
let n2=99;
let ANS = Math.floor(Math.random()*100);

while(true){
    let x = prompt("Please enter the number between "+n1+" ~ "+n2);
    if(x < n1 || x > n2){
        alert("Please enter the valid number between "+n1+" ~ " +n2);
        continue;
    }
    if(x<ANS){
        n1=x;
    }
    else if(x>ANS){
        n2=x;
    }
    else{
        alert("You get the number ! ");
        alert("You win the game ! ");
        break;
    }
}


