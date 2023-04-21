var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

var suppDetails = null;


$("#GSTFile").bind("change", function() {
	handleFileSelect(event, 'GSTFileText', 'GSTFile'), onValidateFile('GSTFile');
});

$("#PDFile").bind("change", function() {
	handleFileSelect(event, 'PDFileText', 'Proprietorship Declaration'), onValidateFile('GSTFile');
});

$("#PANFile").bind("change", function() {
	handleFileSelect(event, 'PANFileText', 'PAN Card'), onValidateFile('PANFile');
});

$("#CCFile").bind("change", function() {
	handleFileSelect(event, 'CCFileText', 'Cancelle Cheque'), onValidateFile('CCFile');
});

$("#ACFile").bind("change", function() {
	handleFileSelect(event, 'ACFileText', 'Aadhar Card'), onValidateFile('ACFile');
});

$("#APLFile").bind("change", function() {
	handleFileSelect(event, 'APLFileText', 'Aadhar PAN Linking'), onValidateFile('APLFile');
});

$("#ITRFile").bind("change", function() {
	handleFileSelect(event, 'ITRFileText', 'ITR Declaratin'), onValidateFile('ITRFile');
});

$("#FUVFFile").bind("change", function() {
	handleFileSelect(event, 'FUVFFileText', 'VRF Form'), onValidateFile('FUVFFile');
});

$("#MSMECFile").bind("change", function() {
	handleFileSelect(event, 'MSMECFileText', 'MSME Certificate'), onValidateFile('MSMECFile');
});

$("#AMFile").bind("change", function() {
	handleFileSelect(event, 'AMFileText', 'Approval Mail'), onValidateFile('AMFile');
});

$("#NMISFile").bind("change", function() {
	handleFileSelect(event, 'NMISFileText', 'Name Mismatch Affidavit'), onValidateFile('NMISFile');
});

$("#ITRFile3").bind("change", function() {
	handleFileSelect(event, 'ITRFileText3'), onValidateFile('ITRFile3');
});

$("#ITRFile2").bind("change", function() {
	handleFileSelect(event, 'ITRFileText2'), onValidateFile('ITRFile2');
});

$("#ITRFile1").bind("change", function() {
	handleFileSelect(event, 'ITRFileText1'), onValidateFile('ITRFile1');
});

var addTable = $("#addTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": false
});

var contactTable = $("#contactTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": false
});

var bankTable = $("#bankTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": false
});
var suppNames = $("#suppNames").val();


$("#viewAttachment").bind("click", function() {
	displayAttachmentForPoDetails();
});

$("#updateProfile").bind("click", function() {
	editUserData(suppDetails);
	$("#userModal").modal('show');
});

$(document).ready(function() {
	getUserData();
});

$(document).ready(function() {
	$('.js-example-basic-multiple1').select2({
		zplaceholder: "Select Region",
		allowClear: true

	});

});

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

$(document).ready(function() {
	$('.js-example-basic-multiple').select2({
		zplaceholder: "Select Partner Type",
		allowClear: true,
		maximumSelectionLength: 1
	});

});



function getUserData() {

	suppDetails = "";


	var json = {

		"bpCode": suppNames
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/getVendorById",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			if (data.msg == 'success') {
				var result = data.data;
				suppDetails = result;
				var accountDetail = result.accountDetails;
				var addressDetails = result.addressDetails;
				var contactDetails = result.contactDetails;
				var myForm = "";
				var myFormOne = "";
				var myFormTwo = "";
				var myFormThree = "";


				myForm = document.getElementById("stepOneForm");
				myFormOne = document.getElementById("stepTwoForm");
				myFormTwo = document.getElementById("stepThreeForm");
				myFormThree = document.getElementById("stepFourForm");

				setData(myForm, result);
				setData(myFormOne, result);
				setData(myFormTwo, result);
				setData(myFormThree, result);

				$("#tanNumber").val(result.tanNumber);
				$("#pid").val(result.pid);
				$("#acknowledgementNumber1").val(result.acknowledgementNumber1);

				var ero = result.ero;
				var wro = result.wro;
				var nro = result.nro;
				var sro = result.sro;
				var ihq = result.ihq;
				var rsgionValue = "";
				if (ero == 'Y') {
					rsgionValue = "ERO";
				}
				if (wro == 'Y') {
					rsgionValue = rsgionValue + ", WRO";
				} if (nro == 'Y') {
					rsgionValue = rsgionValue + ", NRO";
				} if (sro == 'Y') {
					rsgionValue = rsgionValue + ", SRO";
				} if (ihq == 'Y') {
					rsgionValue = rsgionValue + ", IHQ";
				}

				$('#region').val(rsgionValue);

				addTable.clear();
				for (var i = 0; i < addressDetails.length; i++) {

					if (!addressDetails[i].hasOwnProperty("vendorType")) {
						addressDetails[i].vendorType = "-";
					}
					if (!addressDetails[i].hasOwnProperty("partnerType")) {
						addressDetails[i].partnerType = "-";
					}
					if (!addressDetails[i].hasOwnProperty("addCountry")) {
						addressDetails[i].addCountry = "-";
					}
					if (!addressDetails[i].hasOwnProperty("state")) {
						addressDetails[i].state = "-";
					}
					if (!addressDetails[i].hasOwnProperty("city")) {
						addressDetails[i].city = "-";
					}
					if (!addressDetails[i].hasOwnProperty("pinCode")) {
						addressDetails[i].pinCode = "-";
					}
					if (!addressDetails[i].hasOwnProperty("addDetails")) {
						addressDetails[i].addDetails = "-";
					}
					if (!addressDetails[i].hasOwnProperty("compGstn")) {
						addressDetails[i].compGstn = "-";
					}
					if (!addressDetails[i].hasOwnProperty("supplierSiteCode")) {
						addressDetails[i].supplierSiteCode = "-";
					}
					if (!addressDetails[i].hasOwnProperty("glCode")) {
						addressDetails[i].glCode = "-";
					}

					addTable.row.add([
						addressDetails[i].vendorType,
						addressDetails[i].partnerType,
						addressDetails[i].addCountry,
						addressDetails[i].state,
						addressDetails[i].city,
						addressDetails[i].pinCode,
						addressDetails[i].addDetails,
						addressDetails[i].compGstn,
						addressDetails[i].supplierSiteCode,
						addressDetails[i].glCode
					]);
				}
				addTable.draw();
				$("tbody").show();

				bankTable.clear();
				for (var i = 0; i < accountDetail.length; i++) {

					if (!accountDetail[i].hasOwnProperty("bankName")) {
						accountDetail[i].bankName = "-";
					}
					if (!accountDetail[i].hasOwnProperty("accoutNumber")) {
						accountDetail[i].accoutNumber = "-";
					}
					if (!accountDetail[i].hasOwnProperty("beneficiaryName")) {
						accountDetail[i].beneficiaryName = "-";
					}
					if (!accountDetail[i].hasOwnProperty("ifscCode")) {
						accountDetail[i].ifscCode = "-";
					}
					if (!accountDetail[i].hasOwnProperty("accoutCurrency")) {
						accountDetail[i].accoutCurrency = "-";
					}

					bankTable.row.add([
						accountDetail[i].bankName,
						accountDetail[i].accoutNumber,
						accountDetail[i].beneficiaryName,
						accountDetail[i].ifscCode,
						accountDetail[i].accoutCurrency
					]);
				}
				bankTable.draw();
				$("tbody").show();

				contactTable.clear();
				for (var i = 0; i < contactDetails.length; i++) {

					if (!contactDetails[i].hasOwnProperty("conFname")) {
						contactDetails[i].conFname = "-";
					}
					if (!contactDetails[i].hasOwnProperty("conLname")) {
						contactDetails[i].conLname = "-";
					}
					if (!contactDetails[i].hasOwnProperty("conPhone")) {
						contactDetails[i].conPhone = "-";
					}
					if (!contactDetails[i].hasOwnProperty("conEmail")) {
						contactDetails[i].conEmail = "-";
					}

					contactTable.row.add([
						contactDetails[i].conFname,
						contactDetails[i].conLname,
						contactDetails[i].conPhone,
						contactDetails[i].conEmail]);

					vandorMailId = contactDetails[0].conEmail;

				}

				contactTable.draw();
				$("tbody").show();
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


function select() {

	var element = document.getElementById('states');
	var element = [...element.options].filter(ele => ele.selected).map(ele => ele.text);
	var selectedValues = [];
	$("#states :selected").each(function() {
		selectedValues.push($(this).val());
	});
	// alert(selectedValues);

	let values = selectedValues.toString();

	document.getElementById("roleId").value = values;
	//alert("roleId111: "+num);


	var val = document.getElementById("states").value
	if (val == "Network") {
		document.getElementById("partnerType").disabled = false;
		document.getElementById("partnerType").value = "Scheduled";
	} else {
		document.getElementById("partnerType").disabled = true;
		document.getElementById("partnerType").value = "";

	}

}


function displayAttachmentForPoDetails() {

	$('#multipleAttachment').empty();

	var obj = {
		"foreignKey": $('#pid').val(),
		"type": "Registration"
	}

	$.ajax({
		type: "POST",
		url: "financeController/getDocumentByTypeAndForeignKey",
		data: JSON.stringify(obj),
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			if (response.msg == "success") {

				if ("data" in response) {

					var result = response.data;

					$('#multipleAttachment').append($('<option/>').attr("value", '').text("Select"));

					for (var i = 0; i < result.length; i++) {
						$('#multipleAttachment').append($('<option/>').attr("value", result[i].docPath).text(result[i].docName));
					}
					$("#viewAttachmentPopUp").modal('show');

				} else {
					Toast.fire({
						type: 'error',
						title: 'Attachment Not Available..'
					})
				}
			} else {
				Toast.fire({
					type: 'error',
					title: 'Failed ..'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {

			Toast.fire({
				type: 'error',
				title: 'Failed Added try again..'
			})

		}
	});
}

$("#multipleAttachment").change(function() {

	$("#pdfLink").contents().find("body").html(" ");
	var fileName = $("#multipleAttachment option:selected").text();

	console.log("fileName from drop down >> " + fileName);
	var filePath = $("#multipleAttachment").val();

	fileName = encodeURIComponent(fileName);
	filePath = encodeURIComponent(filePath);
	var urlpath = "getDoc" + "?name=" + fileName + "&path=" + filePath;
	console.log(urlpath);
	$('#pdfLink').attr('src', urlpath);
	$('#ifrmameHref').attr('href', urlpath);

});

function editUserData(suppDetails) {

	$("#suppNameEdit").val(suppDetails.suppName);
	$("#businessClassificationEdit").val(suppDetails.businessClassification);
	$("#mesmeNumberEdit").val(suppDetails.mesmeNumber);
	$("#aadharNumberEdit").val(suppDetails.aadharNumber);
	$("#adharLinkStatusEdit").val(suppDetails.adharLinkStatus);
	$("#sectionTypeEdit").val(suppDetails.sectionType);
	$("#panNumberEdit").val(suppDetails.panNumber);
	$("#tanNumberEdit").val(suppDetails.tanNumber);
	$("#enInvApplicableEdit").val(suppDetails.enInvApplicable);
	//$("#regionEdit").val(suppDetails.region);
	$("#bpCodeEdit").val(suppDetails.bpCode);

	$("#invoiceCurrencyEdit").val(suppDetails.invoiceCurrency);
	$("#paymentCurrencyEdit").val(suppDetails.paymentCurrency);
	$("#creditTermsEdit").val(suppDetails.creditTerms);
	$("#paymentMethodEdit").val(suppDetails.paymentMethod);
	$("#dateBasisEdit").val(suppDetails.dateBasis);
	$("#deliveryTermsEdit").val(suppDetails.deliveryTerms);
	$("#tdsApplicationEdit").val(suppDetails.tdsApplication);
	$("#tdsSectionEdit").val(suppDetails.tdsSection);
	$("#tdsRateEdit").val(suppDetails.tdsRate);
	$("#fyYear1Edit").val(suppDetails.fyYear1);
	$("#fyYear2Edit").val(suppDetails.fyYear2);
	$("#fyYear3Edit").val(suppDetails.fyYear3);
	$("#acknowledgementNumber1Edit").val(suppDetails.acknowledgementNumber1);
	$("#acknowledgementNumber2Edit").val(suppDetails.acknowledgementNumber2);
	$("#acknowledgementNumber3Edit").val(suppDetails.acknowledgementNumber3);

	var ero = suppDetails.ero;
	var wro = suppDetails.wro;
	var nro = suppDetails.nro;
	var sro = suppDetails.sro;
	var ihq = suppDetails.ihq;

	var rsgionValue = "";
	if (ero == 'Y') {
		rsgionValue = "ERO";
	}
	if (wro == 'Y') {
		rsgionValue = rsgionValue + " WRO";
	} if (nro == 'Y') {
		rsgionValue = rsgionValue + " NRO";
	} if (sro == 'Y') {
		rsgionValue = rsgionValue + " SRO";
	} if (ihq == 'Y') {
		rsgionValue = rsgionValue + " IHQ";
	}

	$('#regionEdit').val(rsgionValue);


	$("#contactDetailsGridTbody").html("");
	for (var i = 0; i < suppDetails.contactDetails.length; i++) {
		$("#contactDetailsGridTbody").append('<tr class=""><td>' +
			suppDetails.contactDetails[i].conFname + '</td><td>' +
			suppDetails.contactDetails[i].conLname + '</td><td>' +
			suppDetails.contactDetails[i].conPhone + '</td><td>' +
			suppDetails.contactDetails[i].conEmail + '</td><td> <a href="#" class="removeContact btn btn-danger btn-sm" abc="xyz">Remove</a></td></tr>');
	}

	$("#addBookGridTbody").html("");
	for (var i = 0; i < suppDetails.addressDetails.length; i++) {
		$("#addBookGridTbody").append(' <tr class=""><td>' +
			suppDetails.addressDetails[i].addCountry + '</td><td>' +
			suppDetails.addressDetails[i].state + '</td><td>' +
			suppDetails.addressDetails[i].city + '</td><td>' +
			suppDetails.addressDetails[i].pinCode + '</td><td>' +
			suppDetails.addressDetails[i].vendorType + '</td><td>' +
			suppDetails.addressDetails[i].partnerType + '</td><td>' +
			suppDetails.addressDetails[i].compGstn + '</td><td>' +
			suppDetails.addressDetails[i].addDetails + '</td><td> <a href="#" class="removeAddress btn btn-danger btn-sm" value="abc">Remove</a></td></tr>');
	}

	$("#addBankGridTbody").html("");
	for (var i = 0; i < suppDetails.accountDetails.length; i++) {
		$("#addBankGridTbody").append('<tr class=""><td>' +
			suppDetails.accountDetails[i].bankName + '</td><td>' +
			suppDetails.accountDetails[i].beneficiaryName + '</td><td>' +
			suppDetails.accountDetails[i].ifscCode + '</td><td>' +
			suppDetails.accountDetails[i].accoutCurrency + '</td><td>' +
			suppDetails.accountDetails[i].accoutNumber + '</td><td>' + '</td><td>  <a href="#" class="removeBank btn btn-danger btn-sm" value="dgg">Remove</a></td></tr>');
	}
}


$(document).on("click", ".removeContact", function() {
	$(this).closest("tr").remove();
});

$(document).on("click", ".removeBank", function() {
	$(this).closest("tr").remove();
});

$(document).on("click", ".removeAddress", function() {
	$(this).closest("tr").remove();
});


$("#updateBtn").bind("click", function() {
	submitUserDetails();
});

function submitUserDetails() {
	var suppName = $("#suppNameEdit").val();
	var businessClassification = $("#businessClassificationEdit").val();
	var mesmeNumber = $("#mesmeNumberEdit").val();
	var aadharNumber = $("#aadharNumberEdit").val();
	var adharLinkStatus = $("#adharLinkStatusEdit").val();
	var sectionType = $("#sectionTypeEdit").val();
	var panNumber = $("#panNumberEdit").val();
	var tanNumber = $("#tanNumberEdit").val();
	var enInvApplicable = $("#enInvApplicableEdit").val();
	//var region = $("#regionEdit").val();
	var bpCode = $("#bpCodeEdit").val();

	var invoiceCurrency = $("#invoiceCurrencyEdit").val();
	var paymentCurrency = $("#paymentCurrencyEdit").val();
	var creditTerms = $("#creditTermsEdit").val();
	var paymentMethod = $("#paymentMethodEdit").val();
	var dateBasis = $("#dateBasisEdit").val();
	var deliveryTerms = $("#deliveryTermsEdit").val();
	var tdsApplication = $("#tdsApplicationEdit").val();
	var tdsSection = $("#tdsSectionEdit").val();
	var tdsRate = $("#tdsRateEdit").val();
	var fyYear1 = $("#fyYear1Edit").val();
	var fyYear2 = $("#fyYear2Edit").val();
	var fyYear3 = $("#fyYear3Edit").val();
	var acknowledgementNumber1 = $("#acknowledgementNumber1Edit").val();
	var acknowledgementNumber2 = $("#acknowledgementNumber2Edit").val();
	var acknowledgementNumber3 = $("#acknowledgementNumber3Edit").val();

	var json = {
		"suppName": suppName,
		"businessClassification": businessClassification,
		"mesmeNumber": mesmeNumber,
		"aadharNumber": aadharNumber,
		"adharLinkStatus": adharLinkStatus,
		"sectionType": sectionType,
		"panNumber": panNumber,
		"bpCode": bpCode,
		"creditTerms": creditTerms,
		"tanNumber": tanNumber,
		"enInvApplicable": enInvApplicable,
		"invoiceCurrency": invoiceCurrency,
		"paymentCurrency": paymentCurrency,
		"paymentMethod": paymentMethod,
		"dateBasis": dateBasis,
		"deliveryTerms": deliveryTerms,
		"tdsApplication": tdsApplication,
		"tdsSection": tdsSection,
		"tdsRate": tdsRate,
		"fyYear1": fyYear1,
		"fyYear2": fyYear2,
		"fyYear3": fyYear3,
		"acknowledgementNumber1": acknowledgementNumber1,
		"acknowledgementNumber2": acknowledgementNumber2,
		"acknowledgementNumber3": acknowledgementNumber3
	}

	var addressDetailsArray = [];
	var vendorType = [];
	var table = document.getElementById('addBookGrid');
	var rowLength = table.rows.length;

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

	var paymentMethod = $("#paymentMethod").val();
	if (paymentMethod == "NEFT") {
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
				"accoutName": row.cells[5].innerHTML,
			}
			accountDetailsArray.push(pushObj);
		}

		if (accountDetailsArray.length == 0 && partnerType != "Ad-Hoc") {


			swal.fire("Alert", "please add accountDetails", "warning")
			return regex.test(inputvalues);
		}
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


	if (contactDetailsArray.length == 0 && partnerType != "Ad-Hoc") {
		swal.fire("Alert", "please add contactDetails....", "warning")

		return regex.test(inputvalues);
	}
	json.accountDetails = accountDetailsArray;
	json.addressDetails = addressDetailsArray;
	json.contactDetails = contactDetailsArray;

	if (document.getElementById("GSTFile").files.length > 0) {
		json.gstFileName = document.getElementById("GSTFile").files.item(0).name;
		json.gstFileText = $("#GSTFileText").val();
	}
	if (document.getElementById("PDFile").files.length > 0) {
		json.pdFileName = document.getElementById("PDFile").files.item(0).name;
		json.pdFileText = $("#PDFileText").val();
	}
	if (document.getElementById("PANFile").files.length > 0) {
		json.panFileName = document.getElementById("PANFile").files.item(0).name;
		json.panFileText = $("#PANFileText").val();
	}
	if (document.getElementById("CCFile").files.length > 0) {
		json.ccFileName = document.getElementById("CCFile").files.item(0).name;
		json.ccFileText = $("#CCFileText").val();
	}
	if (document.getElementById("ACFile").files.length > 0) {
		json.acFileName = document.getElementById("ACFile").files.item(0).name;
		json.acFileText = $("#ACFileText").val();
	}
	if (document.getElementById("APLFile").files.length > 0) {
		json.aplFileName = document.getElementById("APLFile").files.item(0).name;
		json.aplFileText = $("#APLFileText").val();
	}
	if (document.getElementById("ITRFile").files.length > 0) {
		json.itrFileName = document.getElementById("ITRFile").files.item(0).name;
		json.itrFileText = $("#ITRFileText").val();
	}
	if (document.getElementById("FUVFFile").files.length > 0) {
		json.fuvfFileName = document.getElementById("FUVFFile").files.item(0).name;
		json.fuvfFileText = $("#FUVFFileText").val();
	}
	if (document.getElementById("MSMECFile").files.length > 0) {
		json.msmecFileName = document.getElementById("MSMECFile").files.item(0).name;
		json.msmecFileText = $("#MSMECFileText").val();
	}
	if (document.getElementById("AMFile").files.length > 0) {
		json.amFileName = document.getElementById("AMFile").files.item(0).name;
		json.amFileText = $("#AMFileText").val();
	}
	// last three year ITR file upload
	if (document.getElementById("ITRFile1").files.length > 0) {
		json.itraFileName1 = document.getElementById("ITRFile1").files.item(0).name;
		json.itraFileText1 = $("#ITRFileText1").val();
	}
	if (document.getElementById("ITRFile2").files.length > 0) {
		json.itraFileName2 = document.getElementById("ITRFile2").files.item(0).name;
		json.itraFileText2 = $("#ITRFileText2").val();
	}
	if (document.getElementById("ITRFile3").files.length > 0) {
		json.itraFileName3 = document.getElementById("ITRFile3").files.item(0).name;
		json.itraFileText3 = $("#ITRFileText3").val();
	}
	if (document.getElementById("NMISFile").files.length > 0) {
		json.nmisFileName = document.getElementById("NMISFile").files.item(0).name;
		json.nmisFileText = $("#NMISFileText").val();
	}

	console.log(json);

	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "registrationController/updateVendor",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			//return;
			$('.loader').hide();
			//$('userModal').hide();
			if (response.msg == 'success') {

				swal.fire("Thanks", "Your details successfully submitted.", "success", "OK").then(function() {
					window.location = "vendorProfile";
				});


				setTimeout(function(response) {
					//location.href = "login";
				}, 1000000);
			} else if (response.msg == 'Duplicate Record') {
				swal.fire("Alert", "Your profile waiting for approval ! Please Wait.", "warning", "OK").then(function() {
					window.location = "vendorProfile";
				});


				setTimeout(function(response) {
					//location.href = "login";
				}, 1000000);
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
			document.getElementById('addDetails').value + '</td><td> <a href="#" class="removeAddress btn btn-danger btn-sm" value="abc">Remove</a></td></tr>');

		/*  document.getElementById('addCountry').value = "";
		 document.getElementById('state').value = ""; */
		document.getElementById('city').value = "";
		document.getElementById('pinCode').value = "";
		document.getElementById('states').value = "";
		$("#states").val('').trigger('change');
		document.getElementById('addDetails').value = "";
		document.getElementById('compGstn').value = "";

	}

});

$("#contactDetailsButt").click(function() {
	var abc = document.getElementById('conFname').value;
	var abc2 = document.getElementById('conLname').value;
	var abc3 = document.getElementById('conPhone').value;
	var abc4 = document.getElementById('conEmail').value;
	console.log("abc =>" + abc);
	if (abc == null || abc == "") {
		swal.fire("Alert", "First Name is mandatory !", "warning");
		return false;
	} else if (abc2 == null || abc2 == "") {
		swal.fire("Alert", "Last Name is mandatory !", "warning");
		return false;
	} else if (abc3 == null || abc3 == "") {
		swal.fire("Alert", "Phone Number is mandatory !", "warning");
		return false;
	} else if (abc4 == null || abc4 == "") {
		swal.fire("Alert", "Email Id is mandatory !", "warning");
		return false;
	} else {
		console.log("Coming Here");
		$("#contactDetailsGrid").append('<tr class=""><td>' +
			document.getElementById('conFname').value + '</td><td>' +
			document.getElementById('conLname').value + '</td><td>' +
			document.getElementById('conPhone').value + '</td><td>' +
			document.getElementById('conEmail').value + '</td><td> <a href="#" class="removeContact btn btn-danger btn-sm" >Remove</a></td></tr>');

		document.getElementById('conFname').value = "";
		document.getElementById('conLname').value = "";
		document.getElementById('conPhone').value = "";
		document.getElementById('conEmail').value = "";
	}
});

$("#addBankGridButt").click(function() {
	var abc = document.getElementById('bankName').value;
	var abc5 = document.getElementById('beneficiaryName').value;
	var abc2 = document.getElementById('ifscCode').value;
	var abc3 = document.getElementById('accoutNumber').value;
	var abc4 = document.getElementById('confirmedAccoutNumber').value;
	console.log("abc =>" + abc);
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
			document.getElementById('accoutNumber').value + '</td><td>' + '</td><td>  <a href="#" class="removeBank btn btn-danger btn-sm" value="abc">Remove</a></td></tr>');

		document.getElementById('bankName').value = "";
		document.getElementById('beneficiaryName').value = "";
		document.getElementById('ifscCode').value = "";
		document.getElementById('accoutNumber').value = "";
		document.getElementById('confirmedAccoutNumber').value = "";
		document.getElementById('divCheckPasswordMatch').innerHTML = "";
	}
});