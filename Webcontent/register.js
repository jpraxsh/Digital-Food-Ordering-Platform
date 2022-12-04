let mail =document.getElementById("email_id");
let name = document.getElementById("name");
let conno = document.getElementById("con_no");
let pw = document.getElementById("password");
let pw1 =document.getElementById("con_pass");
let msg = document.getElementById("msg_1");
let msg2 = document.getElementById("msg_2");
let msg3 = document.getElementById("msg_3");
let msg4 = document.getElementById("msg_4");

let name_ = /^[a-z A-Z]+$/;
let email=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
let contno =/^[0-9]{10}$/;
    
const mailVerify = (input, msg) => {
	let a = email.test(input.value);
	if(!a){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}

const conVerify = (input, msg) => {
	let a = contno.test(input.value);
	if(!a){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}

const nameVerify = (input, msg) => {
	let a = name_.test(input.value);
	if(!a){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}
const passVerify = (input, input2, msg) => {
	if(input!=input2){
		msg.classList.remove("js-hidden");
	} else {
		msg.classList.add("js-hidden");
	}
}
  
mail.addEventListener("input",() => {
	mailVerify(mail, msg);
})
conno.addEventListener("input",() => {
	conVerify(conno, msg2);
})
name.addEventListener("input",() => {
	nameVerify(name, msg3);
})
pw1.addEventListener("input", () => {
	passVerify(pw1.value, pw.value, msg4);
})