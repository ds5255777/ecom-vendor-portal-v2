var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');



createCaptcha2();

$( "#captchaClick" ).bind( "click", function() {
 createCaptcha2();
});

$( "#click" ).bind( "click", function() {
 validateOnsubit();
});

$( document ).ready(function() {
     const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });
});


function createCaptcha2() {
	//clear the contents of captcha div first 
	document.getElementById('captcha2').innerHTML = "";
	var charsArray = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@!#$%^&*";
	var lengthOtp = 6;
	var captcha = [];
	for (var i = 0; i < lengthOtp; i++) {
		//below code will not allow Repetition of Characters
		var index = Math.floor(Math.random() * charsArray.length + 1); //get the next character from the array
		if (captcha.indexOf(charsArray[index]) == -1)
			captcha.push(charsArray[index]);
		else
			i--;
	}
	var canv = document.createElement("canvas");
	canv.id = "captcha2";
	canv.width = 120;
	canv.height = 50;
	var ctx = canv.getContext("2d");
	ctx.font = "25px Georgia";
	ctx.strokeText(captcha.join(""), 0, 30);
	//storing captcha so that can validate you can save it somewhere else according to your specific requirements
	code = captcha.join("");
	document.getElementById("captcha2").appendChild(canv); // adds the canvas to the body element
}
function validateCaptcha2() {

	var check = false;

	if (document.getElementById("captchaInput").value == code) {
		check = true;
	} else {
		Swal.fire("Invalid Captcha. try Again");
		$("#captchaInput").val('');
		check = false;
		createCaptcha2();
	}
	return check;
}

function validateOnsubit() {

	var username = document.getElementById("username").value;
	if (username === "" || username === null || username === '') {
		swal.fire("", "Enter a Username", "warning");
		document.getElementById("username").focus();
		return "";
	}

	var password = document.getElementById("password").value;
	if (password === "" || password === null || password === '') {
		swal.fire("", "Enter Password", "warning");
		document.getElementById("password").focus();
		return "";
	}

	var captchaInput = document.getElementById("captchaInput").value;
	if (captchaInput === "" || captchaInput === null || captchaInput === '') {
		swal.fire("", "Enter a Captcha Code", "warning");
		document.getElementById("captchaInput").focus();
		return "";
	}

	var captchaReturnType = validateCaptcha2();
	//validateOnClick();
	if (captchaReturnType) {

		$("#target").submit();
	}

}



function validateOnClick() {

	var username = document.getElementById("username").value;
	if (localStorage.clickcount) {
		window.localStorage.setItem('username', username);
		var val1 = window.localStorage.getItem("username");
		console.log(val1);
		localStorage.clickcount = Number(localStorage.clickcount) + 1;
	} else {
		localStorage.clickcount = 1;
	}

	document.getElementById("demo").innerHTML = localStorage.clickcount;
}