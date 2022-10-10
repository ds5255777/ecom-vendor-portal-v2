var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


var statusObject = {
	"In-Transit": {
		"Yet To Be Approved": ["NA"],
	},
	"Closed": {
		"Yet To Be Approved": ["NA"],
		"Yet To Be Approved By Network Team": ["NA"],
		"Query": ["NA"],
		"Approved": ["Pending"],
		"Draft-Invoicing": ["NA"],
		"Invoicing": ["Pending", "Approved"],
	}
}
window.onload = function() {
	var tripStatus = document.getElementById("selectTripStatus");
	var status = document.getElementById("selectStatus");
	var paymentStatus = document.getElementById("selectPaymentStatus");
	for (var x in statusObject) {
		tripStatus.options[tripStatus.options.length] = new Option(x, x);
	}
	tripStatus.onchange = function() {
		paymentStatus.length = 1;
		status.length = 1;
		for (var y in statusObject[this.value]) {
			status.options[status.options.length] = new Option(y, y);
		}
		GetSelectedTextValue();
	}
	status.onchange = function() {
		paymentStatus.length = 1;
		var z = statusObject[tripStatus.value][this.value];
		for (var i = 0; i < z.length; i++) {
			paymentStatus.options[paymentStatus.options.length] = new Option(
				z[i], z[i]);
		}
		GetSelectedTextValue();
	}
}



const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var currentDate = '${currentDate}';
var dataLimit = '${dataLimit}';
dataLimit = parseInt(dataLimit);

var tabledata = $('#tabledata').DataTable({

	"paging": true,
	"lengthChange": false,
	"searching": true,
	"info": true,
	"autoWidth": true,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 100,
	dom: 'Bfrtip',
	buttons: [

		{
			extend: 'excelHtml5',

			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
			},
			customize: function(doc) {

				var tblBody = doc.content[1].table.body;
				for (var i = 0; i < tblBody[0].length; i++) {
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

$('#searchData').on('keyup', function() {
	tabledata.search(this.value).draw();
});

$('#tabledata_filter').css("display", "none");


var tabledataQuery = $('#tabledataQuery').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": true,
	"aaSorting": []
});

$('#fromDate').datepicker({
	dateFormat: 'dd-mm-yy',
	changeMonth: true,
	changeYear: true,
	maxDate: currentDate
});

$('#toDate').datepicker({
	dateFormat: 'dd-mm-yy',
	changeMonth: true,
	changeYear: true,
	maxDate: currentDate
});

$("#refreshDashboardButton").click(function(e) {
	e.preventDefault();
	$('#refreshDashboardButton').attr('disabled', 'disabled');
	getData();
	$('#refreshDashboardButton').removeAttr('disabled');
	$('#selectTripStatus').val('');
	$('#selectStatus').val('');
	$('#selectPaymentStatus').val('');
	$('#fromDate').val('');
	$('#toDate').val('');
	$('#searchData').val('');
})

getData();

function getData() {

	$('.loader').show();

	$.ajax({
		type: "POST",
		data: "",
		url: "tripControllers/getAllTripsDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {

				var result = data.data;
				tabledata.clear();

				for (var i = 0; i < result.length; i++) {

					if (!result[i].hasOwnProperty("tripID")) {
						result[i].tripID = "-";
					}
					if (!result[i].hasOwnProperty("route")) {
						result[i].route = "-";
					}
					if (!result[i].hasOwnProperty("runType")) {
						result[i].runType = "-";
					}
					if (!result[i].hasOwnProperty("runStatus")) {
						result[i].runStatus = "-";
					}
					if (!result[i].hasOwnProperty("vendorTripStatus")) {
						result[i].vendorTripStatus = "-";
					}
					if (!result[i].hasOwnProperty("actualDeparture")) {
						result[i].actualDeparture = "-";
					}
					if (!result[i].hasOwnProperty("vehicleNumber")) {
						result[i].vehicleNumber = "-";
					}
					if (!result[i].hasOwnProperty("standardVechicleType")) {
						result[i].standardVechicleType = "-";
					}
					if (!result[i].hasOwnProperty("standardKM")) {
						result[i].standardKM = "-";
					}
					if (!result[i].hasOwnProperty("totalFreight")) {
						result[i].totalFreight = "-";
					}
					if (!result[i].hasOwnProperty("invoiceNumber")) {
						result[i].invoiceNumber = "-";
					}
					if (!result[i].hasOwnProperty("paymentStatus")) {
						result[i].paymentStatus = "-";
					}

					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" value=\"" + result[i].tripID + "\" class=\"tripIdView\"  >" + result[i].tripID + "</a>";
					//var view = "<button type=\"button\" value=\""+result[i].tripID+"\" id=\""+result[i].tripID+"\"   class=\"yourButtonClass\"  >" + result[i].tripID + "</button>";
					tabledata.row.add([
						view,
						result[i].route,
						result[i].runType,
						result[i].runStatus,
						result[i].vendorTripStatus,
						result[i].actualDeparture,
						result[i].vehicleNumber + " / " + result[i].standardVechicleType,
						result[i].standardKM,
						result[i].totalFreight,
						result[i].invoiceNumber,
						result[i].paymentStatus]);
				}
				tabledata.draw();
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



$('#tabledata tbody').on('click', ".tripIdView", function() {
	var row = $(this).parents('tr')[0];
	setTripStatus(row.cells[0].innerText);
});





function setTripStatus(tripId) {
	var json = {
		"tripID": tripId
	}
	document.tripForm.reset();
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "tripControllers/tripDetailByTripId",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {

			if (data.msg == 'success') {
				var result = data.data;

				myForm = document.getElementById("tripForm");
				setData(myForm, result);
				$("#tripID").val(result.tripID);
				getQueryData(result.tripID)
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




$("#searchTripByDate").bind("click", function() {
	getFilterData();
});

function getFilterData() {

	var fromDate = $("#fromDate").val();
	var toDate = $("#toDate").val();
	var vendorCode = $("#vendorCode").val();

	fromDate = moment(fromDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
	toDate = moment(toDate, 'DD-MM-YYYY').format('YYYY-MM-DD');

	$('#selectTripStatus').val('');
	$('#selectStatus').val('');
	$('#selectPaymentStatus').val('');


	if (fromDate == "" || fromDate == null) {
		Toast.fire({
			type: 'error',
			title: 'Please Select Start Date..'
		});
		document.getElementById("fromDate").focus();
		return;
	}

	if (toDate == "" || toDate == null) {
		Toast.fire({
			type: 'error',
			title: 'Please Select End Date..'
		});
		document.getElementById("toDate").focus();
		return;
	}

	var dateReturnCheck = dateValidationCheck(fromDate, toDate);
	if (dateReturnCheck == "false") {

		$('.loader').show();


		$.ajax({
			type: "GET",
			data: {
				"actualDeparture": fromDate.concat(" ", "00:00:00"),
				"actualArrival": toDate.concat(" ", "23:59:59"),
				"vendorCode": vendorCode
			},
			url: "tripControllers/filterTripDetails",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",

			success: function(data) {
				$('.loader').hide();
				if (data.msg == 'success') {

					var result = data.data;
					tabledata.clear();

					for (var i = 0; i < result.length; i++) {
						if (!result[i].hasOwnProperty("tripID")) {
							result[i].tripID = "-";
						}
						if (!result[i].hasOwnProperty("route")) {
							result[i].route = "-";
						}
						if (!result[i].hasOwnProperty("runType")) {
							result[i].runType = "-";
						}
						if (!result[i].hasOwnProperty("runStatus")) {
							result[i].runStatus = "-";
						}
						if (!result[i].hasOwnProperty("vendorTripStatus")) {
							result[i].vendorTripStatus = "-";
						}
						if (!result[i].hasOwnProperty("actualDeparture")) {
							result[i].actualDeparture = "-";
						}
						if (!result[i].hasOwnProperty("vehicleNumber")) {
							result[i].vehicleNumber = "-";
						}
						if (!result[i].hasOwnProperty("standardVechicleType")) {
							result[i].standardVechicleType = "-";
						}
						if (!result[i].hasOwnProperty("standardKM")) {
							result[i].standardKM = "-";
						}
						if (!result[i].hasOwnProperty("totalFreight")) {
							result[i].totalFreight = "-";
						}
						if (!result[i].hasOwnProperty("invoiceNumber")) {
							result[i].invoiceNumber = "-";
						}
						if (!result[i].hasOwnProperty("paymentStatus")) {
							result[i].paymentStatus = "-";
						}

						var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" value=\"" + result[i].tripID + "\" class=\"tripIdView\"  >" + result[i].tripID + "</a>";

						tabledata.row.add([view,
							result[i].route,
							result[i].runType,
							result[i].runStatus,
							result[i].vendorTripStatus,
							result[i].actualDeparture,
							result[i].vehicleNumber + " / " + result[i].standardVechicleType,
							result[i].standardKM,
							result[i].totalFreight,
							result[i].invoiceNumber,
							result[i].paymentStatus]);
					}
					tabledata.draw();
					$("tbody").show();
				} else {
					Toast.fire({
						type: 'error',
						title: 'Failed.. Try Again..'
					})
				}

			},
			error: function(jqXHR, textStatue, errorThrown) {
				$('.loader').hide();
				Toast.fire({
					type: 'error',
					title: '.. Try Again..'
				})
			}

		});
	} else {
		Toast.fire({
			type: 'error',
			title: 'Start Date Less than End Date.'
		});
		$('#fromDate').val('');
		document.getElementById("fromDate").focus();
		return;
	}
}

function getQueryData(tripId) {

	var obj = {
		"referenceid": tripId,
		"type": "Trip"
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
							result[i].raisedBy = "-";
						}
						if (!result[i].hasOwnProperty("role")) {
							result[i].role = "-";
						}
						if (!result[i].hasOwnProperty("raisedOn")) {
							result[i].raisedOn = "-";
						}
						if (!result[i].hasOwnProperty("comment")) {
							result[i].comment = "-";
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
