var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$("#updateBtnBtn").bind("click", function() {
	approveInvoice();
});

$("#raiseQuery").bind("click", function() {
	raiseQueryModel();
});

$("#searchallinvfin").bind("click", function() {

});
const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

$("#closewin").bind("click", function() {
	window.close()
});

var prTable = $("#prTable").DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,

	dom: 'Bfrtip',
	//buttons: ['excel','pdf','print'],
	buttons: [

		{
			extend: 'excelHtml5',

			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A3',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
			},
			customize: function(doc) {

				var tblBody = doc.content[1].table.body;
				for (var i = 0; i < tblBody[0].length; i++) {
					//	 console.log(tblBody[0]);
					//	 console.log(tblBody[0][i]);
					tblBody[0][i].fillColor = '#FFFFFF';
					tblBody[0][i].color = 'black';
				}

				var objLayout = {};
				objLayout['hLineWidth'] = function(i) {
					return .5;
				};
				objLayout['vLineWidth'] = function(i) {
					return .5;
				};
				objLayout['hLineColor'] = function(i) {
					return '#aaa';
				};
				objLayout['vLineColor'] = function(i) {
					return '#aaa';
				};
				objLayout['paddingLeft'] = function(i) {
					return 4;
				};
				objLayout['paddingRight'] = function(i) {
					return 4;
				};
				doc.content[1].layout = objLayout;
				var obj = {};
				obj['hLineWidth'] = function(i) {
					return .5;
				};
				obj['hLineColor'] = function(i) {
					return '#aaa';
				};
				//   doc.content[1].margin = [ 150, 0, 150, 0 ];

			}
		}
	],
	initComplete: function() {
		var $buttons = $('.dt-buttons').hide();
		$('#exportLink').on('click', function() {
			var btnClass = "excel" ?
				'.buttons-' + "excel" :
				null;
			if (btnClass) $buttons.find(btnClass).click();
		})

		$('#exportLinkPdf').on('click', function() {
			var btnClass = "pdf" ?
				'.buttons-' + "pdf" :
				null;
			if (btnClass) $buttons.find(btnClass).click();
		})
	}
});




var tabledataQuery = $('#tabledataQuery').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": []
});

$("input[type=text]").prop('disabled', true);

var ecomInvoiceNumber = $("#ecomInvoiceNumber").val();
var type = $("#invoiceType").val();
var role = $("#vendorRole").val();

showHideButton();

function showHideButton() {

	if (type == "In-Processed Invoice" || type == "Query Invoice") {
		if (role == "Finance") {
			$("#prosInvBtn").css("display", "block");
			$("#viewAttachmentDiv").css("display", "block");
			$("#raiseQueryDiv").css("display", "block");
			$("#queryWindow").css("display", "block");
			$("#remarkWindow").css("display", "block");
		} else {
			$("#prosInvBtn").css("display", "none");
			$("#viewAttachmentDiv").css("display", "block");
			$("#raiseQueryDiv").css("display", "none");
			$("#queryWindow").css("display", "none");
		}
	} else if (type == "Pending For Approval") {
		if (role == "Finance Head") {
			$("#prosInvBtn").css("display", "block");
			$("#viewAttachmentDiv").css("display", "block");
			$("#raiseQueryDiv").css("display", "block");
			$("#queryWindow").css("display", "block");
			$("#remarkWindow").css("display", "block");
		} else {
			$("#prosInvBtn").css("display", "none");
			$("#viewAttachmentDiv").css("display", "block");
			$("#raiseQueryDiv").css("display", "none");
			$("#queryWindow").css("display", "none");
			$("#remarkWindow").css("display", "block");
		}
	} else if (type == "All Invoices" || type == "Processed Invoice") {
		$("#prosInvBtn").css("display", "none");
		$("#viewAttachmentDiv").css("display", "block");
		$("#raiseQueryDiv").css("display", "none");
		$("#queryWindow").css("display", "none");
		$("#remarkWindow").css("display", "block");
	}
}

function closeWin() {
	window.close()
}

var tripLineArray = [];
setInvoiceDetails();

function setInvoiceDetails() {

	var obj = {
		"ecomInvoiceNumber": ecomInvoiceNumber,
	}
	console.log(obj);
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
				var myFormTwo = "";
				myForm = document.getElementById("stepOneForm");
				setData(myForm, result);
				$('#prTable').DataTable().clear();
				for (var i = 0; i < tripLineArray.length; i++) {
					if (!tripLineArray[i].hasOwnProperty("runType")) {
						tripLineArray[i].runType = "";
					}
					if (!tripLineArray[i].hasOwnProperty("tripID")) {
						tripLineArray[i].tripID = "";
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
						result[i].standardVechicleType = "";
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
						result[i].mileage = "";
					}
					if (!tripLineArray[i].hasOwnProperty("actualKM")) {
						tripLineArray[i].actualKM = "";
					}
					if (!tripLineArray[i].hasOwnProperty("totalFreight")) {
						tripLineArray[i].totalFreight = "";
					}
					if (!tripLineArray[i].hasOwnProperty("lumpsomeamount")) {
						tripLineArray[i].lumpsomeamount = "";
					}
					if (!tripLineArray[i].hasOwnProperty("lineLevelDescription")) {
						tripLineArray[i].lineLevelDescription = "";
					}
					$('#prTable').DataTable().row.add([tripLineArray[i].tripID, tripLineArray[i].runType, tripLineArray[i].route, tripLineArray[i].standardKM, tripLineArray[i].ratePerKm, tripLineArray[i].currentFuelRate, tripLineArray[i].fsBaseRate, tripLineArray[i].standardVechicleType, tripLineArray[i].fsDiff, tripLineArray[i].basicFreight, tripLineArray[i].fs, tripLineArray[i].mileage, tripLineArray[i].totalFreight, tripLineArray[i].lumpsomeamount, tripLineArray[i].lineLevelDescription]);
				}
				$("#invoiceNumber").val(result.invoiceNumber);
				$("#ecomInvoiceNumber").val(result.ecomInvoiceNumber);
				$('#prTable').DataTable().draw();
				$("tbody").show();
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

$("#viewAttachment").bind("click", function() {
	displayAttachmentForPoDetails();
});

function displayAttachment() {

	var invoiceNumber = $("#invoiceNumber").val();
	console.log("id >> " + id);

	var obj = {
		"invoiceNumber": invoiceNumber,
	}

	$.ajax({
		type: "POST",
		url: "financeController/getDocumentByInvoiceNumber",
		async: false,
		data: JSON.stringify(obj),
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			if (response.msg == "success") {


			} else {
				Toast.fire({
					type: 'error',
					title: 'Failed Added..'
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

function approveInvoice() {

	var ecomInvoiceNumber = $("#ecomInvoiceNumber").val();

	if (ecomInvoiceNumber == "") {
		return;
	}
	$('.loader').show();
	var obj = {
		"ecomInvoiceNumber": ecomInvoiceNumber
	}

	$.ajax({
		type: "POST",
		url: "financeController/approveInvoiceFinanceSide",
		data: JSON.stringify(obj),
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			$('.loader').hide();
			$("#myModal").modal('hide');
			if (response.msg == "success") {
				Swal.fire({
					type: 'success',
					title: 'Aproved Successfully..'
				}).then(function() {
					window.opener.refereshList();
					window.close();
				});

			} else {
				Toast.fire({
					type: 'error',
					title: 'Failed Added..'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			$('.loader').hide();
			Toast.fire({
				type: 'error',
				title: 'Failed Added..'
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
				swal.fire("", "Remarks Submitted Successfully ", "success", "OK").then(function() {
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

					console.log(result, "------");

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
getQueryData();

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


