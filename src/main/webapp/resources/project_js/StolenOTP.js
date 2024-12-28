let digitValidate = function(ele){
  console.log(ele.value);
  ele.value = ele.value.replace(/[^0-9]/g,'');
}

let tabChange = function(val){
    let ele = document.querySelectorAll('input');
    if(ele[val-1].value != ''){
      ele[val].focus()
    }else if(ele[val-1].value == ''){
      ele[val-2].focus()
    }
 }

  var elts = document.getElementsByClassName('otp');
/*Array.from(elts).forEach(function(elt){
  elt.addEventListener("keyup", function(event) {
    // Number 13 is the "Enter" key on the keyboard
    if (event.keyCode === 13 || elt.value.length == 1) {
      // Focus on the next sibling
      elt.nextElementSibling.focus();
    }
  });
})*/

	const inputs = document.getElementById("inputs");
inputs.addEventListener("input", function (e) {
const target = e.target;
const val = target.value;
if (isNaN(val)) {
target.value = "";
return;
}

if (val != "") {
const next = target.nextElementSibling;
if (next) {
next.focus();
}
}
});

const inputs1 = document.getElementById("inputs1");
inputs1.addEventListener("input", function (e) {
const target = e.target;
const val = target.value;
if (isNaN(val)) {
target.value = "";
return;
}

if (val != "") {
const next = target.nextElementSibling;
if (next) {
next.focus();
}
}
});


inputs.addEventListener("keyup", function (e) {
const target = e.target;
const key = e.key.toLowerCase();

if (key == "backspace" || key == "delete") {
target.value = "";
const prev = target.previousElementSibling;
if (prev) {
prev.focus();
}
return;
}
});

inputs1.addEventListener("keyup", function (e) {
const target = e.target;
const key = e.key.toLowerCase();

if (key == "backspace" || key == "delete") {
target.value = "";
const prev = target.previousElementSibling;
if (prev) {
prev.focus();
}
return;
}
});



