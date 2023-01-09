var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


$.widget.bridge('uibutton', $.ui.button);
$.widget.bridge('uitooltip', $.ui.tooltip);

var lineItem = [];

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = dd + '/' + mm + '/' + yyyy;
document.write(today);


$('#invoiceDate').datepicker({
	dateFormat: 'dd-mm-yy',
	changeMonth: true,
	changeYear: true,
	maxDate: today
});


$("#createLineItem").bind("click", function() {
	createLineItem();
});


$('#quantity').on('input', function(event) {
	this.value = this.value.replace(/[^0-9.]/g, '');
});
$('#rate').on('input', function(event) {
	this.value = this.value.replace(/[^0-9.]/g, '');
});
$('#vendorGst').on('change', function(event) {
	this.value = this.value.toUpperCase();
});
$('#conPerMobileNo').on('input', function(event) {
	this.value = this.value.replace(/[^0-9]/g, '');
});
$('#contectNo').on('input', function(event) {
	this.value = this.value.replace(/[^0-9]/g, '');
});
$('#hsn').on('input', function(event) {
	this.value = this.value.replace(/[^0-9]/g, '');
});

$('#vendorInvoiceNumber').on('input', function(event) {
	this.value = this.value.replace(/[^0-9-_A-Za-z]/g, '').replace(/(\..*)\./g, '$1'); this.value = this.value.toUpperCase();
});

$('#InvoiceUpload').on('change', function(event) {
	handleFileSelect(event, 'InvoiceFileText');
	onValidateFile('InvoiceUpload');
});


$("#saveInvoiceToServer").bind("click", function() {
	sendToServer()
});

$("#deleteInvoice").bind("click", function() {
	discardInvoice()
});

$("#closeWindow").bind("click", function() {
	window.close()
});
onclick = "savedraftinvoice();"

onclick = "window.close()"

function isNumberKey(evt) {
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode != 46 && charCode > 31
		&& (charCode < 48 || charCode > 57))
		return false;

	return true;
}

$('#value').on('input', function(event) {
	this.value = this.value.replace(/[^0-9.]/g, '');
});
$(document).ready(function() {
	$("#value").change(function() {
		var inputvalues = $(this).val();
		var regex = /^\s*(?=.*[1-9])\d*(?:\.\d{1,2})?\s*$/;
		if (!regex.test(inputvalues)) {
			$("#value").val("");

			alert("Please write down numeric value upto two decimal");
		}

	});
});

$(document).ready(function() {
	$("#valueEdit").change(function() {
		var inputvalues = $(this).val();
		var regex = /^\s*(?=.*[1-9])\d*(?:\.\d{1,2})?\s*$/;
		if (!regex.test(inputvalues)) {
			$("#valueEdit").val("");

			alert("Please write down numeric value upto two decimal");
		}

	});
});


$("#rateEdit").bind("input", function() {
	calculate();
});

$("#quantity").bind("input", function() {
	calculate();
});

$("#rate").bind("input", function() {
	calculate();
});

$("#quantityEdit").bind("input", function() {
	calculate();
});

$("#rateEdit").bind("input", function() {
	calculate();
});

function calculate() {
	var quantity = $("#quantity").val() || $("#quantityEdit").val();
	var rate = $("#rate").val() || $("#rateEdit").val();

	var totalValue = Number(quantity) * Number(rate);

	console.log(totalValue);

	$("#value").val(parseFloat(totalValue).toFixed(2));
	$("#valueEdit").val(parseFloat(totalValue).toFixed(2));

}

var tabledata = $('#tabledata').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": false

});

function createLineItem() {
	var materialDescription = $("#materialDescription").val();
	materialDescription = materialDescription.trim();
	if (materialDescription == "") {

		Toast.fire({
			type: 'error',
			title: 'Material Description is required.'
		});
		document.getElementById("materialDescription").focus();
		return;
	}
	var hsn = $("#hsn").val();
	if (hsn == "") {
		Toast.fire({
			type: 'error',
			title: 'HSN is required'
		});
		document.getElementById("hsn").focus();
		return;
	}

	var quantity = $("#quantity").val();
	quantity = quantity.trim();
	if (quantity == "") {
		Toast.fire({
			type: 'error',
			title: 'Quantity is required'
		});
		document.getElementById("quantity").focus();
		return;
	}
	var rate = $("#rate").val();
	quantity = quantity.trim();
	if (rate == "") {
		Toast.fire({
			type: 'error',
			title: 'Rate is required'
		});
		document.getElementById("rate").focus();
		return;
	}
	var value = $("#value").val();
	if (value == "") {
		Toast.fire({
			type: 'error',
			title: 'Value is required'
		});
		document.getElementById("value").focus();
		return;
	}
	if (value == "NaN") {
		Toast.fire({
			type: 'error',
			title: 'Please write down correct rate and quantity'
		});
		document.getElementById("value").focus();
		return;
	}
	var lineDetails = {
		"materialDescription": materialDescription,
		"hsn": hsn,
		"quantity": quantity,
		"rate": rate,
		"value": value
	}
	lineItem.push(lineDetails);
	$("#materialDescription").val("");
	$("#hsn").val("");
	$("#quantity").val("");
	$("#rate").val("");
	$("#value").val("");
	showTable();
}

function deleteee(index) {
	lineItem.splice(index, 1);
	showTable();
}

$('#tabledata tbody').on('click', ".dltWithoutRefernce", function() {
	if (confirm("Are you shore want tp Delete this Item!") == true) {
		deleteee(this.value);
	}
});
$('#tabledata tbody').on('click', ".editWithoutRefernce", function() {

	arrayIndex = this.value;
	editData(this.value);
});


function showTable() {
	tabledata.clear();

	for (var i = 0; i < lineItem.length; i++) {
		var b = i + 1;
		var deletee = "<button type=\"button\"   class=\"dltWithoutRefernce btn btn-primary btn-xs \" data-placement=\"bottom\" value=\"" + i + "\"   data-original-title=\"Click To Edit\" style=\"width: 43px; \"><i class=\"nav-icon fas fa-trash\"> </i> </button>";
		//var edit = "<button type=\"button\"  value=\"" + i + "\"  class=\"editWithoutRefernce btn btn-primary btn-xs \" data-placement=\"bottom\"   data-original-title=\"Click To Edit\" style=\"width: 43px;\" ><i class=\"nav-icon fas fa-edit\"> </i> </button>";
		tabledata.row.add([b, lineItem[i].materialDescription, lineItem[i].hsn, lineItem[i].quantity, lineItem[i].rate, lineItem[i].value, deletee]);
	}
	tabledata.draw();
	$("tbody").show();
}

function deleteLineItem(index) {
	lineItem.splice(index, 1);
	showTable();
}

function handleFileSelect(evt, id) {
	var f = evt.target.files[0]; // FileList object
	var reader = new FileReader();
	// Closure to capture the file information.
	reader.onload = (function(theFile) {
		return function(e) {
			var binaryData = e.target.result;
			//Converting Binary Data to base 64
			var base64String = window.btoa(binaryData);
			//showing file converted to base64
			$("#" + id).val(base64String);
		};
	})(f);
	reader.readAsBinaryString(f);
}

function onValidateFile(id) {
	var fileInput3 = document.getElementById(id).value;
	var gst = document.getElementById(id);
	//var allowedExtensions = /(\.pdf)$/i;

	if (typeof (gst.files) != "undefined") {

		const fsize = gst.files.item(0).size;
		const file = Math.round((fsize / 1024));
		if (file > 5000) {
			swal.fire("", "File should less than 5 MB.", "warning");
			$("#" + id).val("");
		} else {
			var ext = fileInput3.split(".")[1];
			if (ext == "pdf" || ext == "PDF") { } else {
				swal.fire("", "Select Only PDF File.", "warning");
				$("#" + id).val("");
				return false;
			}
		}
	} else {
		alert("This browser does not support HTML5.");
	}
}



function sendToServer() {

	var invoiceNum = document.getElementById("vendorInvoiceNumber").value;
	if (invoiceNum === "" || invoiceNum === null || invoiceNum === '') {
		Toast.fire({
			type: 'error',
			title: 'Fill Invoice Number'
		});
		document.getElementById("vendorInvoiceNumber").focus();
		return "";
	}
	var invoiceDa = document.getElementById("invoiceDate").value;
	if (invoiceDa === "" || invoiceDa === null || invoiceDa === '') {
		Toast.fire({
			type: 'error',
			title: 'Select Date'
		});
		document.getElementById("invoiceDate").focus();
		return "";
	}

	var supplierSite = document.getElementById("supplierSite").value;
	if (supplierSite === "" || supplierSite === null || supplierSite === '') {
		Toast.fire({
			type: 'error',
			title: 'Select Site'
		});
		document.getElementById("supplierSite").focus();
		return "";
	}


	var hsnCode = document.getElementById("remitToBankAccountNumber").value;
	if (hsnCode === "" || hsnCode === null || hsnCode === '') {
		Toast.fire({
			type: 'error',
			title: 'Fill HSN Code'
		});
		document.getElementById("remitToBankAccountNumber").focus();
		return "";
	}

	//	var invoiceCheckStatus = checkForExistingInvoiceNumber();

	//if (invoiceCheckStatus == "false") {

	//return;
	//}

	var invoiceDoc = document.getElementById("InvoiceUpload").value;
	if (invoiceDoc === "" || invoiceDoc === null || invoiceDoc === '') {
		Toast.fire({
			type: 'error',
			title: 'Upload Invoice Document'
		});
		document.getElementById("InvoiceUpload").focus();
		return "";
	}


	/*if (tripLineArray.length === 0) {
		Toast.fire({
			type: 'error',
			title: 'Select More Then One Trips'
		});
		return "";
	}*/



	var stepOneObj = FormDataToJSON('stepOneForm');


	const finalObj = {
		...stepOneObj,
	};

	if (document.getElementById("InvoiceUpload").files.length > 0) {
		finalObj.invoiceFileName = document.getElementById("InvoiceUpload").files.item(0).name;
		finalObj.invoiceFileText = $("#InvoiceFileText").val();
	}

	finalObj.invoiceNumber = $("#ecomInvoiceNumber").val();

	/*tripLineArray.forEach((item) => {
		item.id = null;
	});*/

	//finalObj.eInvoiceApplibale = $("#enInvoiceApplibale").val();
	finalObj.invoiceLineItem = lineItem;

	console.log("----------------------------", finalObj);

	
	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "PoInvoiceContoller/savePoInvoice",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {

			if (response.msg == 'success') {
				swal.fire("Invoice Processed Sucessfully", "Process ID : " + response.data, "success", "OK").then(function() {
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




///lineItem.value