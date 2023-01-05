var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$("#GSTFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'GSTFileText', 'GSTFile'), onValidateFile('GSTFile');
});

$("#PDFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'PDFileText', 'Proprietorship Declaration'), onValidateFile('GSTFile');
});

$("#PANFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'PANFileText', 'PAN Card'), onValidateFile('PANFile');
});

$("#CCFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'CCFileText', 'Cancelle Cheque'), onValidateFile('CCFile');
});

$("#ACFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ACFileText', 'Aadhar Card'), onValidateFile('ACFile');
});

$("#APLFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'APLFileText', 'Aadhar PAN Linking'), onValidateFile('APLFile');
});

$("#ITRFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText', 'ITR Declaratin'), onValidateFile('ITRFile');
});

$("#FUVFFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'FUVFFileText', 'VRF Form'), onValidateFile('FUVFFile');
});

$("#MSMECFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'MSMECFileText', 'MSME Certificate'), onValidateFile('MSMECFile');
});

$("#AMFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'AMFileText', 'Approval Mail'), onValidateFile('AMFile');
});

$("#NMISFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'NMISFileText', 'Name Mismatch Affidavit'), onValidateFile('NMISFile');
});

$("#ITRFile3").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText3'), onValidateFile('ITRFile3');
});

$("#ITRFile2").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText2'), onValidateFile('ITRFile2');
});

$("#ITRFile1").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText1'), onValidateFile('ITRFile1');
});

$("#businessClassification").bind("change", function() {
	MESMENumber();
});

$("#mesmeNumber").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#aadharNumber").bind("input", function() {
	this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
});

$("#aadharNumber").bind("blur", function() {
	AadharValidate();
});

$("#panNumber").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#tanNumber").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#region").bind("change", function() {
	region1();
});

$("#pinCode").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#states").bind("change", function() {
	select();
});

$("#compGstn").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#conPhone").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#ifscCode").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#accoutNumber").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#confirmedAccoutNumber").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#tdsApplication").bind("change", function() {
	changetextbox();
});

$("#tdsRate").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57 || event.charCode <= 46;
});


$("#closePopBtn").bind("click", function() {
	window.close()
});

function addValCss(controlName) {
	$('#' + controlName).css({
		'border': '1px solid red',
		'box-shadow': 'inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(249, 0, 0, 0.6)',
		'-webkit-box-shadow': 'inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(249, 0, 0, 0.6)',
		'outline-color': 'transparent'
	});
}

function removeValCss(controlName) {
	$('#' + controlName).css({
		'border': '1px solid #b7b7b7',
		'box-shadow': 'none',
		'-webkit-box-shadow': 'none'
	});
}

function removeValCssByID(controlName) {
	$('#' + controlName.id).css({
		'border': '1px solid #b7b7b7',
		'box-shadow': 'none',
		'-webkit-box-shadow': 'none'
	});
}

$("#smartwizard").on("leaveStep", function(e, anchorObject, stepNumber, stepDirection, stepPosition) {


	if (stepNumber === 3) {
		$('.btnfinish').attr('disabled', false);
	} else {
		$('.btnfinish').attr('disabled', true);
	}
	return checkMand(stepNumber);

});




function showHideRequiredClass() {
	if ($("#partnerType").val() == "Scheduled") {
		$(".required").css("visibility", "visible");
		$("#finishButton").attr("disabled", true);
	} else {
		$(".required").css("visibility", "hidden");
		$(".adHocRequired").css("visibility", "visible");
		$("#finishButton").attr("disabled", false);
	}
}

function checkMand(stepNo) {

	if (stepNo == 0) {
		var mandFields = "introducedByName,introducedByEmailID,suppName,eInvoiceApplicable";
		var mandFieldsArr = mandFields.split(",");
		for (i = 0; i < mandFieldsArr.length; i++) {
			if (document.getElementById(mandFieldsArr[i]).value == '') {
				notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
				return false;
			}
		}

	} else if (stepNo == 1) {
		var addBookGridCount = $("#addBookGrid tr").length;
		var contactDetailsGrid = $("#contactDetailsGrid tr").length;
		if (addBookGridCount == 1) {
			swal.fire("Alert", "Add Atleast One Address !", "warning")
				.then((value) => { });
			return false;
		}
		if (contactDetailsGrid == 1) {
			swal.fire("Alert", "Add Atleast One Conttact", "warning")
				.then((value) => { });
			return false;
		}
	} else if (stepNo == 2) {
		var addBankGrid = $("#addBankGrid tr").length;
		if (addBankGrid == 1) {
			swal.fire("Alert", "Add Atleast One Account Detail", "warning")
				.then((value) => {
				});
			return false;
		}

		var mandFields = "invoiceCurrency,paymentCurrency,creditTerms,paymentMethod";
		var mandFieldsArr = mandFields.split(",");
		for (i = 0; i < mandFieldsArr.length; i++) {
			if (document.getElementById(mandFieldsArr[i]).value == '') {
				notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
				return false;
			}
		}
	} else if (stepNo == 3) {

		if ($("#tdsApplication").val() == "Yes") {
			var mandFields = "tdsSection,tdsRate";
			var mandFieldsArr = mandFields.split(",");
			for (i = 0; i < mandFieldsArr.length; i++) {
				if (document.getElementById(mandFieldsArr[i]).value == '') {
					notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
					return false;
				}
			}
		}
	}
}




function changetextbox() {
	if (document.getElementById("tdsApplication").value === "No") {
		document.getElementById("tdsSection").disabled = 'true';
		document.getElementById("tdsRate").disabled = 'true';
		$("#tdsSection").val("");
		$("#tdsRate").val("");

	} else {
		document.getElementById("tdsSection").disabled = '';
		document.getElementById("tdsRate").disabled = '';
	}
}

$(document).ready(function() {
	$(".email").change(function() {
		var inputvalues = $(this).val();
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (!regex.test(inputvalues)) {
			$("#compEmail").val("");

			swal.fire("Alert", "Invalid Email Id", "warning");
			return regex.test(inputvalues);
		}
	});
});

$(document).ready(function() {
	$("#conEmail").change(function() {
		var inputvalues = $(this).val();
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (!regex.test(inputvalues)) {
			$("#conEmail").val("");

			swal.fire("Alert", "Invalid Email Id", "warning");
			return regex.test(inputvalues);
		}
	});
});

function validatephone(phone) {

	phone = phone.replace(/[^0-9]/g, '');
	$("#phoneNumber").val(phone);
	if (phone == '' || !phone.match(/^0[0-9]{9}$/)) {
		return false;
	} else {
		return true;
	}
}

function onValidateFile(id) {
	var fileInput3 = document.getElementById(id).value;
	var gst = document.getElementById(id);
	var allowedExtensions = /(\.docx|\.pdf)$/i;
	if (typeof (gst.files) != "undefined") {

		const fsize = gst.files.item(0).size;

		const file = Math.round((fsize / 1024));
		if (file > 5500) {
			swal.fire("Alert", "Please select File size less than 5 MB....", "warning");
			$("#" + id).val("");
		} else {
			var ext = fileInput3.split(".")[1];

			if (ext == "pdf" || ext == "PDF" || ext == "DOCX" || ext == "docx") {
			} else {
				swal.fire("Alert", "Invalid File Type, Select Only Word & PDF File....", "warning");

				$("#" + id).val("");
				return false;
			}
		}
	} else {
		alert("This browser does not support HTML5.");
	}
}

function disableScrolling() {
	setTimeout(function() {
		document.body.style.overflow = 'hidden';
	}, 1000);
}

function enableScrolling() {
	document.body.style.overflow = '';
}

$(document).ready(function() {

});





const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: true,
	timer: 3000
});
$(document).ready(function() {
	$('.js-example-basic-multiple').select2({
		zplaceholder: "Select Partner Type",
		allowClear: true,
		maximumSelectionLength: 1
	});

});
$(document).ready(function() {
	$('.js-example-basic-multiple1').select2({
		zplaceholder: "Select Region",
		allowClear: true

	});

});
$(document).ready(function() {
	$('.js-example-basic-multiple2').select2({
		zplaceholder: "Select Flag",
		allowClear: true

	});

});

function AadharValidate() {
	var aadhar = document.getElementById("aadharNumber").value;
	var adharcardTwelveDigit = /^\d{12}$/;
	var adharSixteenDigit = /^\d{16}$/;
	if (aadhar != '') {
		if (aadhar.match(adharcardTwelveDigit)) {
			return true;
		} else if (aadhar.match(adharSixteenDigit)) {
			return true;
		} else {
			swal.fire("", " Invalid Aadhar Number", "warning");
			$("#aadharNumber").val('');
			$("#aadharNumber").focus();
			//return false;
		}
	}
}

$("#addBookGridButt").click(function() {
	var abc = document.getElementById('city').value;
	var abc2 = document.getElementById('pinCode').value;
	var abc3 = document.getElementById('addDetails').value;
	var abc4 = document.getElementById('states').value;

	if (abc == null || abc == "") {
		swal.fire("Alert", "District is mandatory", "warning");
		return false;
	} else if (abc2 == null || abc2 == "") {
		swal.fire("Alert", "Pin Code is mandatory", "warning");
		return false;
	} else if (abc4 == null || abc4 == "") {
		swal.fire("Alert", "Business Partner Type is mandatory", "warning");
		return false;
	} else if (abc3 == null || abc3 == "") {
		swal.fire("Alert", "Address is mandatory", "warning");
		return false;
	} else {

		$("#addBookGrid").append(' <tr class=""><td>' +
			document.getElementById('addCountry').value + '</td><td>' +
			document.getElementById('state').value + '</td><td>' +
			document.getElementById('city').value + '</td><td>' +
			document.getElementById('pinCode').value + '</td><td>' +
			document.getElementById('states').value + '</td><td>' +
			document.getElementById('partnerType').value + '</td><td>' +
			document.getElementById('compGstn').value + '</td><td>' +
			document.getElementById('addDetails').value + '</td><td> <a href="#" class="us btn btn-danger btn-sm" value="12">Remove</a></td></tr>');

		document.getElementById('city').value = "";
		document.getElementById('pinCode').value = "";
		document.getElementById('states').value = "";
		$("#states").val('').trigger('change');
		document.getElementById('addDetails').value = "";
		document.getElementById('compGstn').value = "";
	}

});


$(document).on("click", ".us", function() {
	$(this).closest("tr").remove();
});


$("#addDocTypeButt").click(function() {
	$("#addDocTypeGrid").append('<tr class=""><td>' + document.getElementById('docType').value + '</td><td>' + document.getElementById('myfile').value + '</td><td><a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');
	document.getElementById('docType').value = "";
	document.getElementById('myfile').value = "";
});

$("#contactDetailsButt").click(function() {
	var abc = document.getElementById('conFname').value;
	var abc2 = document.getElementById('conLname').value;
	var abc3 = document.getElementById('conPhone').value;
	var abc4 = document.getElementById('conEmail').value;
	if (abc == null || abc == "") {
		swal.fire("Alert", "First Name is mandatory !", "warning");
		return false;
	} else if (abc3 == null || abc3 == "") {
		swal.fire("Alert", "Phone Number is mandatory !", "warning");
		return false;
	} else if (abc4 == null || abc4 == "") {
		swal.fire("Alert", "Email Id is mandatory !", "warning");
		return false;
	} else {
		$("#contactDetailsGrid").append('<tr class=""><td>' +
			document.getElementById('conFname').value + '</td><td>' +
			document.getElementById('conLname').value + '</td><td>' +
			document.getElementById('conPhone').value + '</td><td>' +
			document.getElementById('conEmail').value + '</td><td> <a href="#" class="removeContact btn btn-danger btn-sm" value="abc">Remove</a></td></tr>');

		document.getElementById('conFname').value = "";
		document.getElementById('conLname').value = "";
		document.getElementById('conPhone').value = "";
		document.getElementById('conEmail').value = "";
	}
});

$(document).on("click", ".removeContact", function() {
	$(this).closest("tr").remove();
});

$("#addBankGridButt").click(function() {
	var abc = document.getElementById('bankName').value;
	var abc5 = document.getElementById('beneficiaryName').value;
	var abc2 = document.getElementById('ifscCode').value;
	var abc3 = document.getElementById('accoutNumber').value;
	var abc4 = document.getElementById('confirmedAccoutNumber').value;
	if (abc == null || abc == "") {
		swal.fire("Alert", "Bank Name is mandatory", "warning");
		return false;
	} else if (abc5 == null || abc5 == "") {
		swal.fire("Alert", "Beneficiary Name is mandatory", "warning");
		return false;
	} else if (abc2 == null || abc2 == "") {
		swal.fire("Alert", "IFSC Code is mandatory", "warning");
		return false;
	} else if (abc3 == null || abc3 == "") {
		swal.fire("Alert", " Account Number is mandatory", "warning");
		return false;
	} else if (abc4 == null || abc4 == "") {
		swal.fire("Alert", " Confirm Account Number is mandatory", "warning");
		return false;

	} else {
		$("#addBankGrid").append('<tr class=""><td>' +
			document.getElementById('bankName').value + '</td><td>' +
			document.getElementById('beneficiaryName').value + '</td><td>' +
			document.getElementById('ifscCode').value + '</td><td>' +
			document.getElementById('accoutCurrency').value + '</td><td>' +
			document.getElementById('accoutNumber').value + '</td><td>' + '</td><td>  <a href="#" class="removeBank btn btn-danger btn-sm" value="xyz">Remove</a></td></tr>');

		document.getElementById('bankName').value = "";
		document.getElementById('beneficiaryName').value = "";
		document.getElementById('ifscCode').value = "";
		document.getElementById('accoutNumber').value = "";
		document.getElementById('confirmedAccoutNumber').value = "";
		document.getElementById('divCheckPasswordMatch').innerHTML = "";
	}

	var suppName = $("#suppName").val();

	if (suppName != abc5) {
		$(".pdDocClass").css("visibility", "visible");
	} else {
		$(".pdDocClass").css("visibility", "hidden");
	}
});

$(document).on("click", ".removeBank", function() {
	$(this).closest("tr").remove();
});

$body = $("body");

$(document).on({
	ajaxStart: function() {
		$body.addClass("loading");
	},
	ajaxStop: function() {
		$body.removeClass("loading");
	}
});

$("#panNumber").change(function() {
	var inputvalues = $(this).val();
	var regex = /[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
	if (!regex.test(inputvalues)) {
		$("#panNumber").val("");
		swal.fire("", "Invalid PAN Number", "warning");
		return regex.test(inputvalues);
	}
});
$("#tanNumber").change(function() {
	var inputvalues = $(this).val();
	var regex = /[A-Za-z]{4}[0-9]{5}[A-Za-z]{1}/;
	if (!regex.test(inputvalues)) {
		$("#tanNumber").val("");
		swal.fire("", "Invalid TAN Number", "warning");
		return regex.test(inputvalues);
	}
});
$("#phoneNumber").change(function() {
	var inputvalues = $(this).val();
	var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
	if (!regex.test(inputvalues)) {
		$("#phoneNumber").val("");
		swal.fire("", "Invalid Phone Number", "warning");
		return regex.test(inputvalues);
	}
});

$("#conPhone").change(function() {
	var inputvalues = $(this).val();
	var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
	if (!regex.test(inputvalues)) {
		$("#conPhone").val("");
		swal.fire("", "Invalid Phone Number", "warning");
		return regex.test(inputvalues);
	}
});




function changetextbox() {
	if (document.getElementById("tdsApplication").value === "No") {
		document.getElementById("tdsSection").disabled = 'true';
		document.getElementById("tdsRate").disabled = 'true';
		$("#tdsSection").val("");
		$("#tdsRate").val("");

	} else {
		document.getElementById("tdsSection").disabled = '';
		document.getElementById("tdsRate").disabled = '';
	}
}

$(document).ready(function() {
	$(".email").change(function() {
		var inputvalues = $(this).val();
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (!regex.test(inputvalues)) {
			$("#compEmail").val("");

			swal.fire("Alert", "Invalid Email Id", "warning");
			return regex.test(inputvalues);
		}
	});

	$("#introducedByEmailID").change(function() {
		var inputvalues = $(this).val();
		var regex = /^[a-zA-Z0-9+_.-]*@ecomexpress.in$/;

		if (!regex.test(inputvalues)) {
			$("#introducedByEmailID").val("");
			document.getElementById("introducedByEmailID").focus();
			swal.fire("Alert", "Invalid Email ID", "warning");
			document.getElementById("introducedByEmailID").focus();
			return regex.test(inputvalues);
		}
	});
});

$(document).ready(function() {
	$("#conEmail").change(function() {
		var inputvalues = $(this).val();
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (!regex.test(inputvalues)) {
			$("#conEmail").val("");

			swal.fire("Alert", "Invalid Email Id", "warning");
			return regex.test(inputvalues);
		}
	});
});
$("#updateBtn").bind("click", function() {
	sendToServer();
});

function sendToServer() {


	var mandFields = "introducedByName,introducedByEmailID,suppName,businessClassification";
	var mandFieldsArr = mandFields.split(",");
	for (i = 0; i < mandFieldsArr.length; i++) {
		if (document.getElementById(mandFieldsArr[i]).value == '') {
			notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
			return false;
		}
	}

	var businessClass = $("#businessClassification").val();
	if (businessClass == "Micro Enterprise" || businessClass == "Medium Enterprise" || businessClass == "Small Enterprise") {
		var mandFields = "mesmeNumber";
		var mandFieldsArr = mandFields.split(",");
		for (i = 0; i < mandFieldsArr.length; i++) {
			if (document.getElementById(mandFieldsArr[i]).value == '') {
				notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
				return false;
			}
		}
	}
	var mandFields = "enInvApplicable";
	var mandFieldsArr = mandFields.split(",");
	for (i = 0; i < mandFieldsArr.length; i++) {
		if (document.getElementById(mandFieldsArr[i]).value == '') {
			notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
			return false;
		}
	}

	var addressDetailsArray = [];
	var table = document.getElementById('addBookGrid');
	var rowLength = table.rows.length;
	var vendorType = [];
	for (var i = 1; i < rowLength; i += 1) {
		var row = table.rows[i];
		var objs = {
			"addCountry": row.cells[0].innerHTML,
			"state": row.cells[1].innerHTML,
			"city": row.cells[2].innerHTML,
			"pinCode": row.cells[3].innerHTML,
			"vendorType": row.cells[4].innerHTML,
			"partnerType": row.cells[5].innerHTML,
			"compGstn": row.cells[6].innerHTML,
			"addDetails": row.cells[7].innerHTML
		};
		addressDetailsArray.push(objs);
		vendorType.push(row.cells[4].innerHTML);
	}

	var vendorTypeString = vendorType.join(",");
	//var partnerType = document.getElementById("partnerType").value

	if (addressDetailsArray.length == 0) {

		swal.fire("Alert", "Please Add Address Details", "warning")
		return false;
	}
	var contactDetailsArray = [];
	table = document.getElementById('contactDetailsGrid');
	rowLength = table.rows.length;

	for (var i = 1; i < rowLength; i += 1) {
		var row = table.rows[i];

		var pushContactObj = {
			"conFname": row.cells[0].innerHTML,
			"conLname": row.cells[1].innerHTML,
			"conPhone": row.cells[2].innerHTML,
			"conEmail": row.cells[3].innerHTML
		}
		contactDetailsArray.push(pushContactObj);
	}

	if (contactDetailsArray.length == 0) {

		swal.fire("Alert", "Please Add Contact Details", "warning")
		return false;
	}

	var accountDetailsArray = [];
	table = document.getElementById('addBankGrid');
	rowLength = table.rows.length;

	for (var i = 1; i < rowLength; i += 1) {
		var row = table.rows[i];

		var pushObj = {
			"bankName": row.cells[0].innerHTML,
			"beneficiaryName": row.cells[1].innerHTML,
			"ifscCode": row.cells[2].innerHTML,
			"accoutCurrency": row.cells[3].innerHTML,
			"accoutNumber": row.cells[4].innerHTML,
			"accoutName": row.cells[5].innerHTML
		}
		accountDetailsArray.push(pushObj);
	}

	if (accountDetailsArray.length == 0) {

		swal.fire("Alert", "Please Add Account Details", "warning")
		return false;
	}



	var itrDetailsArray = [];
	table = document.getElementById('addITRGrid');
	rowLength = table.rows.length;

	for (var i = 1; i < rowLength; i += 1) {
		var row = table.rows[i];

		var pushItrObj = {
			"fyYear": row.cells[0].innerHTML,
			"acknowledgementNumber": row.cells[1].innerHTML
		}
		itrDetailsArray.push(pushItrObj);
	}

	var mandFields = "invoiceCurrency,paymentCurrency,creditTerms,paymentMethod";
	var mandFieldsArr = mandFields.split(",");
	for (i = 0; i < mandFieldsArr.length; i++) {
		if (document.getElementById(mandFieldsArr[i]).value == '') {
			notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
			return false;
		}
	}
	if ($("#tdsApplication").val() == "Yes") {
		var mandFields = "tdsSection,tdsRate";
		var mandFieldsArr = mandFields.split(",");
		for (i = 0; i < mandFieldsArr.length; i++) {
			if (document.getElementById(mandFieldsArr[i]).value == '') {
				notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
				return false;
			}
		}
	}

	var mandFields = "CCFile,ITRFile,MSMECFile";
	var mandFieldsArr = mandFields.split(",");

	for (i = 0; i < mandFieldsArr.length; i++) {
		if (document.getElementById(mandFieldsArr[i]).value == '') {
			notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
			return false;
		}
	}

	var bankTable = document.getElementById('addBankGrid');
	var rowLengthBank = bankTable.rows.length;
	var beneficiaryName;

	for (var i = 1; i < rowLengthBank; i += 1) {
		var row = bankTable.rows[i];
		beneficiaryName = row.cells[1].innerHTML;
	}

	var suppNameReg = $("#suppName").val();
	//var beneficiaryName = $("#beneficiaryName").val();

	if (suppNameReg != beneficiaryName) {

		var mandFields = "NMISFile";
		var mandFieldsArr = mandFields.split(",");
		for (i = 0; i < mandFieldsArr.length; i++) {
			if (document.getElementById(mandFieldsArr[i]).value == '') {
				notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
				return false;
			}
		}

	}



	$body.addClass("loading");

	var step1Obj = FormDataToJSON('stepOneForm');
	var step6Obj = FormDataToJSON('stepSixForm');
	var step7Obj = FormDataToJSON('stepSevenForm');

	const finalObj = {
		...step1Obj,
		...step6Obj,
		...step7Obj
	};

	finalObj.accountDetails = accountDetailsArray;
	finalObj.addressDetails = addressDetailsArray;
	finalObj.contactDetails = contactDetailsArray;
	finalObj.itrDetails = itrDetailsArray;

	if (document.getElementById("GSTFile").files.length > 0) {
		finalObj.gstFileName = document.getElementById("GSTFile").files.item(0).name;
		finalObj.gstFileText = $("#GSTFileText").val();
	}
	if (document.getElementById("PDFile").files.length > 0) {
		finalObj.pdFileName = document.getElementById("PDFile").files.item(0).name;
		finalObj.pdFileText = $("#PDFileText").val();
	}
	if (document.getElementById("PANFile").files.length > 0) {
		finalObj.panFileName = document.getElementById("PANFile").files.item(0).name;
		finalObj.panFileText = $("#PANFileText").val();
	}
	if (document.getElementById("CCFile").files.length > 0) {
		finalObj.ccFileName = document.getElementById("CCFile").files.item(0).name;
		finalObj.ccFileText = $("#CCFileText").val();
	}
	if (document.getElementById("ACFile").files.length > 0) {
		finalObj.acFileName = document.getElementById("ACFile").files.item(0).name;
		finalObj.acFileText = $("#ACFileText").val();
	}
	if (document.getElementById("APLFile").files.length > 0) {
		finalObj.aplFileName = document.getElementById("APLFile").files.item(0).name;
		finalObj.aplFileText = $("#APLFileText").val();
	}
	if (document.getElementById("ITRFile").files.length > 0) {
		finalObj.itrFileName = document.getElementById("ITRFile").files.item(0).name;
		finalObj.itrFileText = $("#ITRFileText").val();
	}
	if (document.getElementById("FUVFFile").files.length > 0) {
		finalObj.fuvfFileName = document.getElementById("FUVFFile").files.item(0).name;
		finalObj.fuvfFileText = $("#FUVFFileText").val();
	}
	if (document.getElementById("MSMECFile").files.length > 0) {
		finalObj.msmecFileName = document.getElementById("MSMECFile").files.item(0).name;
		finalObj.msmecFileText = $("#MSMECFileText").val();
	}
	if (document.getElementById("AMFile").files.length > 0) {
		finalObj.amFileName = document.getElementById("AMFile").files.item(0).name;
		finalObj.amFileText = $("#AMFileText").val();
	}

	if (document.getElementById("NMISFile").files.length > 0) {
		finalObj.nmisFileName = document.getElementById("NMISFile").files.item(0).name;
		finalObj.nmisFileText = $("#NMISFileText").val();
	}

	if (document.getElementById("ITRFile1").files.length > 0) {
		finalObj.itraFileName1 = document.getElementById("ITRFile1").files.item(0).name;
		finalObj.itraFileText1 = $("#ITRFileText1").val();
	}
	if (document.getElementById("ITRFile2").files.length > 0) {
		finalObj.itraFileName2 = document.getElementById("ITRFile2").files.item(0).name;
		finalObj.itraFileText2 = $("#ITRFileText2").val();
	}
	if (document.getElementById("ITRFile3").files.length > 0) {
		finalObj.itraFileName3 = document.getElementById("ITRFile3").files.item(0).name;
		finalObj.itraFileText3 = $("#ITRFileText3").val();
	}


	var values = document.getElementById("roleId").value;

	finalObj.vendorType = values;

	var value = [];
	$("#region :selected").each(function() {
		value.push($(this).val());
	});
	if (value.includes("CRO") || value.includes("ERO")) {//ERO
		finalObj.ero = "Y";

	} if (value.includes("WRO")) {
		finalObj.wro = "Y";
	} if (value.includes("NRO")) {
		finalObj.nro = "Y";
	} if (value.includes("SRO1") || value.includes("SRO2")) {//SRO
		finalObj.sro = "Y";
	} if (value.includes("IHQ")) {
		finalObj.ihq = "Y";
	}


	var value1 = [];
	$("#flag :selected").each(function() {
		value.push($(this).val());
	});
	if (value.includes("ADDRESS_PURCHASING")) {
		finalObj.addressPurchasingFlag = "Y";

	} if (value.includes("ADDRESS_PAYMENT")) {
		finalObj.addressPaymentFlag = "Y";
	} if (value.includes("INVOICE_PREVALIDATED")) {
		finalObj.invoicePrevalidatedFlag = "Y";
	}


	var val = document.getElementById("states").value
	if (val.toLowerCase() == "network") {
		finalObj.glCode = "203101";
	} else if (val.toLowerCase() == "other expenses") {
		finalObj.glCode = "203104";
	} else if (val.toLowerCase() == "rent") {
		finalObj.glCode = "203102";
	} else if (val.toLowerCase() == "fixed assets") {
		finalObj.glCode = "203105";
	} else if (val.toLowerCase() == "courier") {
		finalObj.glCode = "203103";
	} else if (val.toLowerCase() == "employee nominee") {
		finalObj.glCode = "203108";
	}


	var acknowledgementNumber1 = $('#acknowledgementNumber1').val();
	var acknowledgementNumber2 = $('#acknowledgementNumber2').val();
	var acknowledgementNumber3 = $('#acknowledgementNumber3').val();

	var fyYear1 = $('#fyYear1').val();
	var fyYear2 = $('#fyYear2').val();
	var fyYear3 = $('#fyYear3').val();

	finalObj.fyYear1 = fyYear1;
	finalObj.fyYear2 = fyYear2;
	finalObj.fyYear3 = fyYear3;

	finalObj.acknowledgementNumber1 = acknowledgementNumber1;
	finalObj.acknowledgementNumber2 = acknowledgementNumber2;
	finalObj.acknowledgementNumber3 = acknowledgementNumber3;
	finalObj.vendorType = vendorTypeString;
	console.log(finalObj);
	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "ajaxController/SaveRegistration",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			$('.loader').hide();

			if (response.msg == 'success') {

				swal.fire("Vendor onboarding request sucessfully register", "Process ID : " + response.data, "success", "OK").then(function() {


					window.close();
				});



			} else {
				alert("failed");
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			Swal.fire({
				icon: 'error',
				title: 'Oops...',
				text: 'Something went wrong!',
			})
		}
	});
}

if (window.File && window.FileReader && window.FileList && window.Blob) {
} else {
	alert('The File APIs are not fully supported in this browser.');
}

function handleFileSelect(evt, id) {
	var f = evt.target.files[0]; // FileList object
	var reader = new FileReader();
	reader.onload = (function(theFile) {
		return function(e) {
			var binaryData = e.target.result;
			var base64String = window.btoa(binaryData);

			$("#" + id).val(base64String);

		};
	})(f);
	reader.readAsBinaryString(f);
}

function notifyTooltip(controlName, tooltipMessage, tooltipPlacement) {
	try {
		if (controlName != null && controlName != '' && tooltipMessage != null && tooltipMessage != '' && tooltipPlacement != null && tooltipPlacement != '') {

			if (controlName == "introducedByName") {
				swal.fire("Alert", "Introducer Name is mandatory", "warning")
					.then((value) => { });

			}
			else if (controlName == "introducedByEmailID") {

				swal.fire("Alert", "Introducer Email Id is mandatory", "warning")
					.then((value) => { });
			}

			else if (controlName == "suppName") {

				swal.fire("Alert", "Business Partner Name is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "businessClassification") {

				swal.fire("Alert", "Business Classification is mandatory", "warning")
					.then((value) => { });
			}

			else if (controlName == "mesmeNumber") {

				swal.fire("Alert", "MESME Certificate Number is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "enInvApplicable") {

				swal.fire("Alert", "E-Invoice Applicable is mandatory", "warning")
					.then((value) => { });
			}

			else if (controlName == "panNumber") {

				swal.fire("Alert", "PAN Number is mandatory", "warning")
					.then((value) => { });
			}

			else if (controlName == "creditTerms") {

				swal.fire("Alert", "Payment / Credit Terms is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "paymentMethod") {

				swal.fire("Alert", "Payment Method is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "tdsSection") {

				swal.fire("Alert", "TDS Section is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "tdsRate") {

				swal.fire("Alert", "TDS Rate is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "CCFile") {

				swal.fire("Alert", "Cancelled Cheque/ Passbook/ Bank Statement  is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "ITRFile") {

				swal.fire("Alert", "ITR Filling Declaration is mandatory", "warning")
					.then((value) => { });
			}

			else if (controlName == "MSMECFile") {

				swal.fire("Alert", "MSME Certificate is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "AMFile") {

				swal.fire("Alert", "Approval Mail is mandatory", "warning")
					.then((value) => { });
			}
			else if (controlName == "NMISFile") {

				swal.fire("Alert", "Name Mismatch Affidavit is mandatory", "warning")
					.then((value) => { });
			}

			$("#" + controlName).focus();
		} else {
		}
	} catch (err) {

	}
}

var matchFlag = 0;
$(function() {
	$("#confirmedAccoutNumber").keyup(function() {
		var password = $("#accoutNumber").val();
		var passwordConfirm = $("#confirmedAccoutNumber").val();
		var passflag = $("#passflag").val();

		if (password != "" && passwordConfirm != "") {
			if ($('#accoutNumber').val() == $('#confirmedAccoutNumber').val() && passflag != "1") {
				$('#divCheckPasswordMatch').html('Account number match.').css('color', 'green');
				$("#addBankGridButt").prop("disabled", false)

			}
			else {

				$('#divCheckPasswordMatch').html('Account number do not match!').css('color', 'red');
				matchFlag = 1;

				$('#addBankGridButt').attr('disabled', true);

				return;

			}
		}

	});
});

$(function() {
	$("#accoutNumber").keyup(function() {
		var password = $("#accoutNumber").val();
		var passwordConfirm = $("#confirmedAccoutNumber").val();
		var passflag = $("#passflag").val();

		if (password != "" || passwordConfirm != "") {
			if ($('#accoutNumber').val() == $('#confirmedAccoutNumber').val() && passflag != "1") {
				$('#divCheckPasswordMatch').html('Account number match.').css('color', 'green');
				$("#addBankGridButt").prop("disabled", false)

			}
			else {
				if (matchFlag == 1) {
					$('#divCheckPasswordMatch').html('Account number does not match!').css('color', 'red');
					$('#addBankGridButt').attr('disabled', true);

					return;
				}
			}
		}
	});
});

$(document).ready(function() {
	$("#accoutNumber").change(function() {
		var accoutNumber = document.getElementById("accoutNumber").value;
		var a = /^\d{1}$/;
		var b = /^\d{2}$/;
		var c = /^\d{3}$/;
		if (accoutNumber != '') {
			if (accoutNumber.match(a) || accoutNumber.match(b) || accoutNumber.match(c)) {
				swal.fire("", " Invalid Account Number", "warning");
				$("#accoutNumber").val('');
				$("#confirmedAccoutNumber").val('');
				$("#accoutNumber").focus();
			} else {

				return true;
			}
		}
	});
});


$("#suppName").keypress(function(event) {
	var inputValue = event.which;
	if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0) && !(inputValue >= 37 && inputValue <= 47)) {
		event.preventDefault();
	}
});


$("#city").keypress(function(event) {
	var inputValue = event.which;
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});


$(document).ready(function() {
	$("#ifscCode").change(function() {
		var inputvalues = $(this).val();
		var regex = /^[A-Z]{4}0[A-Z0-9]{6}$/;
		if (!regex.test(inputvalues)) {
			$("#ifscCode").val("");

			swal.fire("Alert", "Invalid IFSC Code", "warning");
			return regex.test(inputvalues);
		}
	});
});



$("#conFname").keypress(function(event) {
	var inputValue = event.which;
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});


$(function() {
	$('#conLname').on('keypress', function(e) {
		if (e.which == 32) {
			return false;
		}
	});
});


$("#conLname").keypress(function(event) {
	var inputValue = event.which;
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});


$("#bankName").keypress(function(event) {
	var inputValue = event.which;
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});


$(document).ready(function() {
	$("#compGstn").change(function() {
		var inputvalues = $(this).val();
		var regex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;
		if (!regex.test(inputvalues)) {
			$("#compGstn").val("");

			swal.fire("Alert", "Invalid GSTIN Number", "warning");
			return regex.test(inputvalues);
		}
	});
});

$(document).ready(function() {
	$("#aadharNumber").change(function() {
		var aadhar = document.getElementById("aadharNumber").value;
		var adharcardTwelveDigit = /^\d{12}$/;
		var adharSixteenDigit = /^\d{16}$/;
		if (aadhar != '') {
			if (aadhar.match(adharcardTwelveDigit)) {
				return true;
			} else if (aadhar.match(adharSixteenDigit)) {
				return true;
			} else {
				swal.fire("", " Invalid Aadhar Number", "warning");
				$("#aadharNumber").val('');
				$("#aadharNumber").focus();
			}
		}
	});
});
function select() {

	var element = document.getElementById('states');
	var element = [...element.options].filter(ele => ele.selected).map(ele => ele.text);
	var selectedValues = [];
	$("#states :selected").each(function() {
		selectedValues.push($(this).val());
	});

	let values = selectedValues.toString();

	document.getElementById("roleId").value = values;


	var val = document.getElementById("states").value
	if (val == "Network") {
		document.getElementById("partnerType").disabled = false;
		document.getElementById("partnerType").value = "Scheduled";

		document.getElementById("selectSupplierType").style.visibility = "visible";
		document.getElementById("selectPartnerType").style.visibility = "visible";
	} else {
		document.getElementById("partnerType").disabled = true;
		document.getElementById("partnerType").value = "";

		document.getElementById("selectSupplierType").style.visibility = "hidden";
		document.getElementById("selectPartnerType").style.visibility = "hidden";

	}

}
function MESMENumber() {
	var busClassif = $("#businessClassification").val();


	if (busClassif !== "Other Enterprise") {
		document.getElementById("mesmeNumber").disabled = false;

	}
	else {
		document.getElementById("mesmeNumber").disabled = true;
		document.getElementById("mesmeNumber").value = "";

	} if (busClassif == "") {
		document.getElementById("mesmeNumber").disabled = true;
		document.getElementById("mesmeNumber").value = "";
	}

}


function region1() {


}

function checkForExistingUserName() {

	var usernameCheckStatus = "false";

	if ($("#bpCode").val() != "") {

		var json = {
			"username": $("#bpCode").val(),

		}
		$.ajax({
			type: "POST",
			data: JSON.stringify(json),
			url: "userController/checkForExistingUserName",
			dataType: "json",
			contentType: "application/json",
			async: false,
			success: function(data) {

				if (data.msg == 'exist') {

					Toast.fire({
						type: 'warning',
						title: 'UserName Already Exists..'
					})

					$("#bpCode").val('');
					return false;

				} else if (data.msg == 'success') {
					usernameCheckStatus = "true";
				} else {
					Toast.fire({
						type: 'error',
						title: 'Failed.. Try Again..'
					})
				}

			},
			error: function(jqXHR, textStatue, errorThrown) {
				alert("failed, please try again");
			}

		});

	}

	return usernameCheckStatus;
}

