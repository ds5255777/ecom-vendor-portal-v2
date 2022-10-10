var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

function disableF5(e) {
	if ((e.which || e.keyCode) == 116) e.preventDefault();
};
$(document).on("keydown", disableF5);

$("#closeWindow").bind("click", function() {
	window.close()
});

$("#deleteInvoice").bind("click", function() {
	discardInvoice()
});

$("#saveInvoiceToServer").bind("click", function() {
	sendToServer()
});

$("#invoiceNumber").bind("input", function() {
	this.value = this.value.replace(/[^0-9-_A-Za-z/]/g, '').replace(/(\..*)\./g, '$1'); this.value = this.value.toUpperCase();
});

$("#irnNumber").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#hsnCode").bind("input", function() {
	this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
});

$("#greenTax").bind("input", function() {
	this.value = this.value.replace(/[^0-9-.]/g, '').replace(/(\..*)\./g, '$1');
});

$("#greenTax").bind("blur", function() {
	calculateInvoice();
});

$("#exteraKM").bind("input", function() {
	this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
});

$("#exteraKM").bind("blur", function() {
	calculateRateKm(); calculateInvoice();
});

$("#miscellaneous").bind("input", function() {
	this.value = this.value.replace(/[^0-9-.]/g, '').replace(/(\..*)\./g, '$1');
});

$("#miscellaneous").bind("blur", function() {
	calculateInvoice();
});

$("#docBtn").bind("click", function() {
	AddDocCheck();
});
const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var currentDate = '${currentDate}';

var prTable = $("#prTable").DataTable({
	"paging": true,
	"lengthChange": false,
	"searching": false,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 100,
});

function closeWin() {
	window.opener.refereshList();
	window.close()
}

$("#InvoiceUpload").bind("change", function() {
	handleFileSelect(event, 'InvoiceFileText', 'Invoice'), onValidateFile(event, 'InvoiceUpload');
});

$("#DocumentFileOne").bind("change", function() {
	handleFileSelect(event, 'DocumentFileOneText', 'Summary Sheet'), onValidateFileOne(event, 'DocumentFileOne');
});

$("#DocumentFileTwo").bind("change", function() {
	handleFileSelect(event, 'DocumentFileTwoText', 'FS Calculation Sheet'), onValidateFileOne(event, 'DocumentFileTwo');
});


function onValidateFile(evt, id) {
	var fileInput3 = document.getElementById(id).value;
	var gst = document.getElementById(id);

	if (typeof (gst.files) != "undefined") {

		const fsize = gst.files.item(0).size;
		const file = Math.round((fsize / 1024));
		if (file > 5500) {
			swal.fire("", "File should less than 5 MB.", "warning");
			$("#" + id).val("");
		} else {
			var f = evt.target.files[0];
			var fileName = f.name;
			var ext = fileName.substring(fileName.lastIndexOf("."), fileName.length);
			if (ext == ".pdf" || ext == ".PDF") { } else {
				swal.fire("", "Select Only PDF File.", "warning");
				$("#" + id).val("");
				return false;
			}
		}
	} else {
		alert("This browser does not support HTML5.");
	}
}

function onValidateFileOne(evt, id) {
	var fileInput3 = document.getElementById(id).value;
	var gst = document.getElementById(id);

	if (typeof (gst.files) != "undefined") {

		const fsize = gst.files.item(0).size;
		const file = Math.round((fsize / 1024));
		if (file > 5500) {
			swal.fire("", "File should less than 5 MB.", "warning");
			$("#" + id).val("");
		} else {
			var f = evt.target.files[0];
			var fileName = f.name;
			var ext = fileName.substring(fileName.lastIndexOf("."), fileName.length);
			if (ext == ".pdf" || ext == ".PDF" || ext == ".docx" || ext == ".DOCX" || ext == ".doc" || ext == ".DOC" || ext == ".xls" || ext == ".XLS" || ext == ".xlsx" || ext == ".XLSX") { } else {
				swal.fire("", "Select Only DOC, XLSX & PDF File.", "warning");
				$("#" + id).val("");
				return false;
			}
		}
	} else {
		alert("This browser does not support HTML5.");
	}
}

$('#invoiceDate').datepicker({
	dateFormat: 'dd-mm-yy',
	changeMonth: true,
	changeYear: true,
	maxDate: currentDate
});

function AddDocCheck() {
	var invoiceNumber = $("#ecomInvoiceNumber").val();
	var tripID = document.getElementById("tripList").value;
	if (tripID != '') {
		var json = {
			"tripID": tripID,
			"invoiceNumber": invoiceNumber
		}

		$.ajax({
			type: "POST",
			data: JSON.stringify(json),
			url: "tripControllers/findByTripDetailUsingTripID",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",
			async: false,
			success: function(data) {

				if (data.msg == 'success') {
					Toast.fire({
						type: 'success',
						title: 'Added Successfully.'
					})
					getTripDetails();
					getSelectTripList();
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
}

var allTripId = $("#listOfSelectTrips").val();
var tripLineArray = [];
var totalFreight = 0;
var lumpsomeamount = parseFloat(0);

function sendToServer() {

	debugger
	var invoiceDa = document.getElementById("invoiceDate").value;
	if (invoiceDa === "" || invoiceDa === null || invoiceDa === '') {
		Toast.fire({
			type: 'error',
			title: 'Select Date'
		});
		document.getElementById("invoiceDate").focus();
		return "";
	}

	var invoiceNu = document.getElementById("invoiceNumber").value;
	if (invoiceNu === "" || invoiceNu === null || invoiceNu === '') {
		Toast.fire({
			type: 'error',
			title: 'Fill Invoice Number'
		});
		document.getElementById("invoiceNumber").focus();
		return "";
	}

	var eInvoice = $("#eInvoice").val();

	if (eInvoice == "YES") {

		var irnNumber = document.getElementById("irnNumber").value;
		if (irnNumber === "" || irnNumber === null || irnNumber === '') {
			Toast.fire({
				type: 'error',
				title: 'Fill IRN Number'
			});
			document.getElementById("irnNumber").focus();
			return "";
		}
	}

	var hsnCode = document.getElementById("hsnCode").value;
	if (hsnCode === "" || hsnCode === null || hsnCode === '') {
		Toast.fire({
			type: 'error',
			title: 'Fill HSN Code'
		});
		document.getElementById("hsnCode").focus();
		return "";
	}

	var invoiceCheckStatus = checkForExistingInvoiceNumber();

	if (invoiceCheckStatus == "false") {

		return;
	}

	var invoiceDoc = document.getElementById("InvoiceUpload").value;
	if (invoiceDoc === "" || invoiceDoc === null || invoiceDoc === '') {
		Toast.fire({
			type: 'error',
			title: 'Upload Invoice Document'
		});
		document.getElementById("InvoiceUpload").focus();
		return "";
	}

	var docOne = document.getElementById("DocumentFileOne").value;
	if (docOne === "" || docOne === null || docOne === '') {
		Toast.fire({
			type: 'error',
			title: 'Upload Summary Sheet'
		});
		document.getElementById("docOne").focus();
		return "";
	}

	var docTwo = document.getElementById("DocumentFileTwo").value;
	if (docTwo === "" || docTwo === null || docTwo === '') {
		Toast.fire({
			type: 'error',
			title: 'Upload FS Calculation Sheet'
		});
		document.getElementById("docTwo").focus();
		return "";
	}
	if (tripLineArray.length === 0) {
		Toast.fire({
			type: 'error',
			title: 'Select More Then One Trips'
		});
		return "";
	}



	var stepOneObj = FormDataToJSON('stepOneForm');


	const finalObj = {
		...stepOneObj,
	};

	if (document.getElementById("InvoiceUpload").files.length > 0) {
		finalObj.invoiceFileName = document.getElementById("InvoiceUpload").files.item(0).name;
		finalObj.invoiceFileText = $("#InvoiceFileText").val();
	}
	if (document.getElementById("DocumentFileOne").files.length > 0) {
		finalObj.documentFileOneName = document.getElementById("DocumentFileOne").files.item(0).name;
		finalObj.documentFileOneText = $("#DocumentFileOneText").val();
	}
	if (document.getElementById("DocumentFileTwo").files.length > 0) {
		finalObj.documentFileTwoName = document.getElementById("DocumentFileTwo").files.item(0).name;
		finalObj.documentFileTwoText = $("#DocumentFileTwoText").val();
	}
	tripLineArray.forEach((item) => {
		item.id = null;
	});
	
	finalObj.eInvoiceApplibale = $("#eInvoiceApplibale").val();
	
	console.log(finalObj);

	finalObj.invoiceLineItem = tripLineArray;

	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "invoiceController/saveInvoice",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {

			if (response.msg == 'success') {
				swal.fire("", "Invoice Processed Sucessfully", "success", "OK").then(function() {
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


function handleFileSelect(evt, id, hardCodedName) {

	var f = evt.target.files[0]; // FileList object
	var reader = new FileReader();
	// Closure to capture the file information.
	reader.onload = (function(theFile) {
		return function(e) {
			var binaryData = e.target.result;
			var base64String = window.btoa(binaryData);

			var fileName = f.name;
			var extension = fileName.substring(fileName.lastIndexOf("."), fileName.length);
			fileName = fileName.substring(0, fileName.lastIndexOf("."));
			fileName = hardCodedName + extension;
			$("#" + id).val(base64String);


		};
	})(f);
	reader.readAsBinaryString(f);
}

getTripDetails();

function updateTextData(index, textValue) {
	tripLineArray[index].lineLevelDescription = textValue.trim();
}

var globalratePerKm = "";

function getTripDetails() {
	var invoiceNumber = $("#ecomInvoiceNumber").val();

	var obj = {
		"invoiceNumber": invoiceNumber
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "tripControllers/getDraftLineTripDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {

			if (response.msg == 'success') {
				var result = response.data;
				var action = "";
				var textBox = "";
				var taxableAmount = 0;
				tripLineArray = result;

				$('#prTable').DataTable().clear();

				for (var i = 0; i < result.length; i++) {

					if (!result[i].hasOwnProperty("tripID")) {
						result[i].tripID = "";
					}
					if (!result[i].hasOwnProperty("runType")) {
						result[i].runType = "";
					}
					if (!result[i].hasOwnProperty("route")) {
						result[i].route = "";
					}
					if (!result[i].hasOwnProperty("standardKM")) {
						result[i].standardKM = "";
					}
					if (!result[i].hasOwnProperty("ratePerKm")) {
						result[i].ratePerKm = "";
					}
					if (!result[i].hasOwnProperty("currentFuelRate")) {
						result[i].currentFuelRate = "";
					}
					if (!result[i].hasOwnProperty("fsBaseRate")) {
						result[i].fsBaseRate = "";
					}
					if (!result[i].hasOwnProperty("standardVechicleType")) {
						result[i].standardVechicleType = "";
					}
					if (!result[i].hasOwnProperty("fsDiff")) {
						result[i].fsDiff = "";
					}
					if (!result[i].hasOwnProperty("basicFreight")) {
						result[i].basicFreight = "";
					}
					if (!result[i].hasOwnProperty("fs")) {
						result[i].fs = "";
					}
					if (!result[i].hasOwnProperty("mileage")) {
						result[i].mileage = "";
					}
					if (!result[i].hasOwnProperty("actualKM")) {
						result[i].actualKM = "";
					}
					if (!result[i].hasOwnProperty("totalFreight")) {
						result[i].totalFreight = "0";
					}
					if (!result[i].hasOwnProperty("lumpsomeamount")) {
						result[i].lumpsomeamount = "0";
					}

					textBox = "<input type=\"text\" class=\"form-control\" id=\"inputField\" placeholder=\"Fill Description\" maxlength=\"100\" style=\" height: 25px;padding: 5px 5px 5px 1.5rem; \">";
					action = "<button type=\"button\"  class=\"deleteTrip btn btn-primary btn-xs \" data-placement=\"bottom\" value=\"" + result[i].tripID + "\"  data-original-title=\"Click To Delete\" > <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
					$('#prTable').DataTable().row.add(
						[i + 1,
						result[i].tripID,
						result[i].runType,
						result[i].route,
						result[i].standardKM,
						result[i].ratePerKm,
						result[i].currentFuelRate,
						result[i].fsBaseRate,
						result[i].standardVechicleType,
						result[i].fsDiff,
						result[i].basicFreight,
						result[i].fs,
						result[i].mileage,
						result[i].totalFreight,
						result[i].lumpsomeamount,
							textBox,
							action]);
					id = (result[i].id);
					taxableAmount += parseFloat(result[i].totalFreight) + parseFloat(result[i].lumpsomeamount);
				}

				globalratePerKm = result[0].ratePerKm;
				$("#ratePerKm").val(globalratePerKm);

				$("#taxableAmount").val(parseFloat(taxableAmount).toFixed(2));
				$('#prTable').DataTable().draw();
				$("tbody").show();
				calculateInvoice();

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

$('#prTable tbody').on('click', ".deleteTrip", function() {
	deleteRow(this.value);
});

$("#inputField").bind("input", function() {
	updateTextData('" + i + "', this.value);
});

function discardInvoice() {
	var invoiceNumber = $("#ecomInvoiceNumber").val();
	var obj = {
		"ecomInvoiceNumber": invoiceNumber
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "invoiceController/discardDraftInvoice",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				swal.fire("", "Invoice Cancelled Successfully.", "success", "OK").then(function() {
					window.opener.refereshList();
					window.close();
				});
				setTimeout(function(response) { }, 2000);
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

function deleteRow(tripID) {
	prTable
		.row($(tripID).parents('tr'))
		.remove()
		.draw();
	deleteThisTrip(tripID);
	getTripDetails();
}

function deleteThisTrip(tripID) {
	var json = {
		"tripID": tripID
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "invoiceController/deleteLineItem",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				Toast.fire({
					type: 'success',
					title: 'Deleted Successfully.'
				})
				getSelectTripList();
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

getSelectTripList();
var bpname = $("#vendorCode").val();


function getSelectTripList() {

	$("#tripList ").empty();
	$('#tripList').append($('<option/>').attr("value", "").text("Select Trip Id"));


	$.ajax({
		type: "POST",
		data: "",
		url: "tripControllers/getTripDetailByTripId",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				var result = data.data;

				if (result.length !== 0) {
					for (var i = 0; i < result.length; i++) {
						$('#tripList').append($('<option/>').attr("value", result[i]).text(result[i]));
					}
				}
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

function calculateInvoice() {
	var taxAmount = $("#taxAmount").val(); /* 18 */
	var greenTax = $("#greenTax").val();  /* Green tax */
	var taxableAmount = $("#taxableAmount").val(); /* TripCost */
	var miscellaneous = $("#miscellaneous").val(); /* externalCharge */
	var extraKmRate = $("#extraKmRate").val();  /* exterKm * ratePerKm */

	var totalAmount = Number(taxableAmount) + Number(miscellaneous) + Number(extraKmRate);
	var totalFinalAmount = (parseFloat(totalAmount) * parseFloat(taxAmount)) / 100;
	var finalInvoiceAmount = parseFloat(totalFinalAmount) + Number(greenTax) + parseFloat(totalAmount);
	$("#invoiceAmount").val(parseFloat(finalInvoiceAmount).toFixed(2));

}

function calculateRateKm() {
	var exteraKM = $("#exteraKM").val(); /* Exter Km */
	var ratePerKm = $("#ratePerKm").val(); /* rate Per KM */

	var extraKmRate = Number(exteraKM) * Number(ratePerKm);
	$("#extraKmRate").val(parseFloat(extraKmRate).toFixed(2));
}

$("#invoiceNumber").focusout(function() {

	checkForExistingInvoiceNumber();

});

function checkForExistingInvoiceNumber() {
	var invoiceCheckStatus = "false";

	var bpname = $("#vendorCode").val();


	if ($("#invoiceNumber").val() != "") {

		var json = {
			"invoiceNumber": $("#invoiceNumber").val(),
			"vendorCode": bpname

		}

		$.ajax({
			type: "POST",
			data: JSON.stringify(json),
			url: "invoiceController/checkForExistingInvoiceNumber",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",
			async: false,
			success: function(data) {

				if (data.msg == 'exist') {

					Toast.fire({
						type: 'warning',
						title: 'Invoice Number Already Exists.'
					})
					$("#invoiceNumber").val('');

				} else if (data.msg == 'success') {
					invoiceCheckStatus = "true";
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
	return invoiceCheckStatus;
}