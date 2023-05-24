var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$("#closeWindow").bind("click", function() {
	window.close()
});

var vandorMailId = "";

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});
var addTable = $("#addTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true
});

var contactTable = $("#contactTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true
});

var bankTable = $("#bankTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true
});

var tabledataQuery = $('#tabledataQuery').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": []
});

var processId = $("#pid").val();

console.log(processId);

var vendorType = $("#vendorType").val();

console.log(vendorType);

$("input[type=text]").prop('disabled', true);

debugger
showHideButton();
function showHideButton() {
	if (vendorType == "Update Vendor" ) {
		$("#prosInvBtn").css("display", "block");
		$("#rejectInvBtn").css("display", "block");
		$("#viewAttachmentDiv").css("display", "block");

	}
}

function closeWin() {
	window.close()
}

loadDetails();
function loadDetails() {


	var obj = {
		"pid": processId,
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "registrationController/updateVendorProfileStatus",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			if (data.msg == 'success') {
				var result = data.data;
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
				getQueryData();
				displayAttachmentForPoDetails();
			} else {
				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			Toast.fire({
				type: 'error',
				title: 'Failed.. Try Again..'
			})
		}
	});
}



function getQueryData() {

	var obj = {
		"referenceid": processId,
		"type": "Registration"
	}

	$.ajax({
		type: "POST",
		url: "financeController/getQueryByTypeAndForeignKey",
		data: JSON.stringify(obj),
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			if (response.msg == "success") {
				if ("data" in response) {

					var result = response.data;

					if (result.length>0) {
						$("#queryTableView").css("display", "block");
						
						tabledataQuery.clear();
						var count = 0;
						for (var i = 0; i < result.length; i++) {
							if (!result[i].hasOwnProperty("raisedBy")) {
								result[i].raisedBy = "";
							}
							if (!result[i].hasOwnProperty("role")) {
								result[i].role = "";
							}
							if (!result[i].hasOwnProperty("raisedOn")) {
								result[i].raisedOn = "";
							}
							if (!result[i].hasOwnProperty("comment")) {
								result[i].comment = "";
							}
							count++;
							tabledataQuery.row.add([count, result[i].raisedBy, result[i].role, result[i].raisedOn, result[i].comment]);
						}
						tabledataQuery.draw();
						$("tbody").show();
					}
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

function raiseQueryModel() {
	var query = document.getElementById("comment").value;
	if (query === "" || query === null || query === '') {
		Toast.fire({
			type: 'error',
			title: 'Please Insert Remarks'
		});
		document.getElementById("comment").focus();
		return "";
	}

	var finalObj = {
		"comment": $("#comment").val(),
		"raisedAgainQuery": $("#pid").val(),
		"id": $("#id").val(),
		"type": "Registration"
	}

	console.log(finalObj);
	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "financeController/saveQuery",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {

			if (response.msg == 'success') {
				/*swal.fire("", "Remarks Sucessfully Submitted", "success", "OK").then(function() {
					window.opener.refereshList();
					window.close();
				});*/
				setTimeout(function(response) { }, 2000);
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

$("#approve").click(function() {
	var pid = $("#pid").val();
	Swal.fire({
		title: 'Are you sure to approve?',
		text: "" + pid,
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes'
	}).then((result) => {
		let test = [1];
		test[0] = result;
		var val = Object.values(test[0])
		if (val == "true") {
			approveVendor(pid);


		}
	})

});

$("#rejected").click(function() {

	var comment = $("#comment").val();

	if (comment === "" || comment === null || comment === '') {
		Toast.fire({
			type: 'error',
			title: 'Enter Remarks'
		});
		document.getElementById("comment").focus();
		return "";
	}

	var pid = $("#pid").val();
	Swal.fire({
		title: 'Are you sure to reject?',
		text: "" + pid,
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes'
	}).then((result) => {
		let test = [1];
		test[0] = result;
		var val = Object.values(test[0])
		if (val == "true") {
			rejectedVendor(pid, comment);


		}
	})

});

function approveVendor(pid) {

	var finalObj = {
		"pid": pid
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "registrationController/updateProfile",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {

			if (response.msg == 'success') {
				swal.fire("", "Approved Vendor Request", "success", "OK").then(function() {
					window.opener.refereshList();
					window.close();
				});
				setTimeout(function(response) { }, 2000);
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


function rejectedVendor(pid, comment) {
	var bpCode=$("#bpCode").val();
debugger
	var finalObj = {
		"pid": pid,
		"bpCode":bpCode,
		"comment": comment,
		"vandorMailId": vandorMailId,
		
	}
	console.log(finalObj);
	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "registrationController/rejectedProfile",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {

			if (response.msg == 'success') {
				raiseQueryModel();
				swal.fire("", "Rejected Vendor Request", "success", "OK").then(function() {
					window.opener.refereshList();
					window.close();
				});
				setTimeout(function(response) { }, 2000);
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


function displayAttachmentForPoDetails() {

	$('#multipleAttachment').empty();

	var obj = {
		"foreignKey": processId,
		"type": "Registration"
	}
	console.log("Document object : " + obj);
	$.ajax({
		type: "POST",
		url: "financeController/getDocumentByTypeAndForeignKey",
		data: JSON.stringify(obj),
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		async: false,
		contentType: "application/json",
		success: function(response) {
			if (response.msg == "success") {

				if ("data" in response) {

					var result = response.data;

					$('#multipleAttachment').append($('<option/>').attr("value", '').text("Select"));

					for (var i = 0; i < result.length; i++) {
						$('#multipleAttachment').append($('<option/>').attr("value", result[i].docPath).text(result[i].docName));
					}
					//$("#viewAttachmentPopUp").modal('show');

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

	$('#pdfLink').attr('src', urlpath);
	$('#ifrmameHref').attr('href', urlpath);

});