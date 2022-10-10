var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$("#raiseQuery").bind("click", function() {
	raiseQueryModel();
});

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var prTable = $("#prTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 15,
});

var tabledataQuery = $('#tabledataQuery').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": []
});

var invoiceNumber = $("#ecomInvoiceNumber").val();

console.log(invoiceNumber);

var type = $("#type").val();
var tripLineArray = [];
$("input[type=text]").prop('disabled', true);
setInvoiceDetails();

showHideButton();

function showHideButton() {

	if (type == "Invoice Queue" || type == "Pending Queue" || type == "Approved Queue") {
		$("#prosInvBtn").css("display", "block");
		$("#viewAttachmentDiv").css("display", "block");
		$("#raiseQueryDiv").css("display", "block");
	}
	else if (type == "Query Queue" || type == "InvoiceQuery Queue") {
		$("#queryWindow").css("display", "block");
		$("#viewAttachmentDiv").css("display", "block");
	}
}



function setInvoiceDetails() {


	var obj = {
		"ecomInvoiceNumber": invoiceNumber
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "invoiceController/getSelectInvoiceDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				var result = data.data;

				tripLineArray = data.data.invoiceLineItem;
				var myForm = "";
				myForm = document.getElementById("stepOneForm");
				setData(myForm, result);
				$('#prTable').DataTable().clear();
				for (var i = 0; i < tripLineArray.length; i++) {
					if (!tripLineArray[i].hasOwnProperty("tripID")) {
						tripLineArray[i].tripID = "";
					}
					if (!tripLineArray[i].hasOwnProperty("runType")) {
						tripLineArray[i].runType = "";
					}
					if (!tripLineArray[i].hasOwnProperty("route")) {
						tripLineArray[i].route = "";
					}
					if (!tripLineArray[i].hasOwnProperty("standardKM")) {
						tripLineArray[i].standardKM = "";
					}
					if (!tripLineArray[i].hasOwnProperty("ratePerKm")) {
						tripLineArray[i].ratePerKm = "";
					}
					if (!tripLineArray[i].hasOwnProperty("currentFuelRate")) {
						tripLineArray[i].currentFuelRate = "";
					}
					if (!tripLineArray[i].hasOwnProperty("fsBaseRate")) {
						tripLineArray[i].fsBaseRate = "";
					}
					if (!tripLineArray[i].hasOwnProperty("standardVechicleType")) {
						tripLineArray[i].standardVechicleType = "";
					}
					if (!tripLineArray[i].hasOwnProperty("fsDiff")) {
						tripLineArray[i].fsDiff = "";
					}
					if (!tripLineArray[i].hasOwnProperty("basicFreight")) {
						tripLineArray[i].basicFreight = "";
					}
					if (!tripLineArray[i].hasOwnProperty("fs")) {
						tripLineArray[i].fs = "";
					}
					if (!tripLineArray[i].hasOwnProperty("mileage")) {
						tripLineArray[i].mileage = "";
					}
					if (!tripLineArray[i].hasOwnProperty("totalFreight")) {
						tripLineArray[i].totalFreight = "";
					}
					if (!tripLineArray[i].hasOwnProperty("lumpsomeamount")) {
						tripLineArray[i].lumpsomeamount = "";
					}
					if (!tripLineArray[i].hasOwnProperty("lineLevelDescription")) {
						tripLineArray[i].lineLevelDescription = "-";
					}
					$('#prTable').DataTable().row.add([tripLineArray[i].tripID, tripLineArray[i].runType, tripLineArray[i].route,
					tripLineArray[i].standardKM, tripLineArray[i].ratePerKm, tripLineArray[i].currentFuelRate,
					tripLineArray[i].fsBaseRate, tripLineArray[i].standardVechicleType, tripLineArray[i].fsDiff, tripLineArray[i].basicFreight,
					tripLineArray[i].fs, tripLineArray[i].mileage, tripLineArray[i].totalFreight, tripLineArray[i].lumpsomeamount,
					tripLineArray[i].lineLevelDescription]);
				}
				$("#invoiceNumber").val(result.invoiceNumber);
				$("#ecomInvoiceNumber").val(result.ecomInvoiceNumber);
				$('#prTable').DataTable().draw();
				$("tbody").show();
				getQueryData();
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
		"referenceid": $('#invoiceNumber').val(),
		"type": "Invoice"
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
		"raisedAgainQuery": $("#invoiceNumber").val(),
		"id": $("#id").val(),
		"type": "Invoice"
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "financeController/saveQuery",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {

			if (response.msg == 'success') {
				swal.fire("", "Remarks Sucessfully Submitted", "success", "OK").then(function() {
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

/* Document Modal code */


$("#viewAttachment").bind("click", function() {
	displayAttachmentForPoDetails();
});

$("#closeWindow").bind("click", function() {
	window.close()
});


function displayAttachmentForPoDetails() {

	$('#multipleAttachment').empty();

	var obj = {
		"foreignKey": $('#ecomInvoiceNumber').val(),
		"type": "Invoice"
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

