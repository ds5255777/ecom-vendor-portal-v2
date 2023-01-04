var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

var prTable1 = $("#prTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 15,
});

var prTable = $("#tabledataQuery").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 15,
});

$("#viewAttachment").bind("click", function() {
	displayAttachmentForPoDetails();
});

$("#closeWindow").bind("click", function() {
	window.close()
});

function closeWin() {
	window.close()
}

$("input[type=text]").prop('disabled', true);
var invoiceNumber = $("#ecomInvoiceNumber").val();
var status = $("#status").val();
var tripLineArray = [];
setInvoiceDetails();

function setInvoiceDetails() {

	var obj = {
		"invoiceNumber": invoiceNumber,
		"status": status
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "poController/getSelectInvoiceDetailsPo",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				var result = data.data;
				var tripLineArray = result[0].poInvoiceLine;
				var grossamt1 = result[0].grossTotalAmt;



				var myForm = "";
				myForm = document.getElementById("stepOneForm");
				setData(myForm, result[0]);


				if (tripLineArray.length > 0) {
					$("#lineItems").css("display", "block");

					$('#prTable').DataTable().clear();
					for (var i = 0; i < tripLineArray.length; i++) {
						if (!tripLineArray[i].hasOwnProperty("lineNumber")) {
							tripLineArray[i].lineNumber = "";
						}
						if (!tripLineArray[i].hasOwnProperty("lineType")) {
							tripLineArray[i].lineType = "";
						}
						if (!tripLineArray[i].hasOwnProperty("amount")) {
							tripLineArray[i].amount = "";
						}
						if (!tripLineArray[i].hasOwnProperty("poNumber")) {
							tripLineArray[i].poNumber = "";
						}
						if (!tripLineArray[i].hasOwnProperty("poline")) {
							tripLineArray[i].poline = "";
						}
						if (!tripLineArray[i].hasOwnProperty("receiptNumber")) {
							tripLineArray[i].receiptNumber = "";
						}
						if (!tripLineArray[i].hasOwnProperty("receiptline")) {
							tripLineArray[i].receiptline = "";
						}
						if (!tripLineArray[i].hasOwnProperty("quantityInvoiced")) {
							tripLineArray[i].quantityInvoiced = "";
						}
						if (!tripLineArray[i].hasOwnProperty("uom")) {
							tripLineArray[i].uom = "";
						}
						if (!tripLineArray[i].hasOwnProperty("unitPrice")) {
							tripLineArray[i].unitPrice = "";
						}
						if (!tripLineArray[i].hasOwnProperty("description")) {
							tripLineArray[i].description = "";
						}
						if (!tripLineArray[i].hasOwnProperty("gldate")) {
							tripLineArray[i].gldate = "";
						}//line item
						if (!tripLineArray[i].hasOwnProperty("taxper")) {
							tripLineArray[i].taxper = "";
						}
						if (!tripLineArray[i].hasOwnProperty("baseAmount")) {
							tripLineArray[i].baseAmount = "";
						}
						if (!tripLineArray[i].hasOwnProperty("taxAmount")) {
							tripLineArray[i].taxAmount = "";
						}
						if (!tripLineArray[i].hasOwnProperty("totalAmount")) {
							tripLineArray[i].totalAmount = "";
						}
						var gldate = tripLineArray[i].gldate.split(" ");
						tripLineArray[i].gldate = gldate[0];
						$('#prTable').DataTable().row.add([i + 1, tripLineArray[i].lineNumber, tripLineArray[i].description, tripLineArray[i].quantityInvoiced, tripLineArray[i].unitPrice, tripLineArray[i].uom, tripLineArray[i].taxper, tripLineArray[i].baseAmount, tripLineArray[i].taxAmount, tripLineArray[i].totalAmount]);
					}
					var grossamt = "<input disabled type=\"text\" value=\"" + result[0].grossTotalAmt + "\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"grossAmt\" >";
					prTable1.row.add(["", "", "", "", "", "", "", "", "<b>Gross Total</b>", grossamt, " "]);



					$('#prTable').DataTable().draw();
					$("tbody").show();
					$('#prTable1').DataTable().draw();
					$("tbody").show();
				}
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

var referenceid = '${invoiceNo}';
function raiseQueryModel() {
	var comment = document.getElementById("comment").value;

	if (comment === "" || comment === null || comment === '') {
		Toast.fire({
			type: 'error',
			title: 'Please Insert Remarks'
		});
		document.getElementById("comment").focus();
		return "";
	}

	var obj = {
		"comment": comment,
		"referenceid": referenceid
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "poController/savePoInvoiceQuery",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				document.getElementById("comment").value = '';
				$('.loader').hide();
				swal.fire("Thanks", "Sucessfully Submitted", "success", "OK")


				getData();
			} else {
				$("#submitBtn").prop("disabled", false);
				$('.loader').hide();

				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}

		},
		error: function(jqXHR, textStatue, errorThrown) {
			$("#submitBtn").prop("disabled", false);
			$('.loader').hide();
			alert("failed, please try again");
		}

	});


}


const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});


getData();
function getData() {

	var obj = {

		"referenceid": referenceid
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "poController/getPoQueryData",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {



			if (data.msg == 'success') {

				$('#tabledataQuery').DataTable().clear();
				var result = data.data;

				for (var i = 0; i < result.length; i++) {
					$('#tabledataQuery').DataTable().row.add([i + 1, result[i].raisedBy, result[i].raisedOn, result[i].comment]);
				}
				$('#tabledataQuery').DataTable().draw();
				$("tbody").show();

			} else {
				$("#submitBtn").prop("disabled", false);
				$('.loader').hide();

				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}

		},
		error: function(jqXHR, textStatue, errorThrown) {
			$("#submitBtn").prop("disabled", false);
			$('.loader').hide();
			alert("failed, please try again");
		}

	});


}

function displayAttachmentForPoDetails() {

	$('#multipleAttachment').empty();

	var obj = {
		"foreignKey": invoiceNumber,
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

	$('#pdfLink').attr('src', urlpath);
	$('#ifrmameHref').attr('href', urlpath);

});


