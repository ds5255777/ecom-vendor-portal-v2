var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$("#searchByDate").bind("click", function() {
	getFilterData();
});

var statusObject = {
	"In-Transit": {
		"Yet To Be Approved": ["NA"],
		"Yet To Be Approved By Network Team": ["NA"],
	},
	"Closed": {
		"Yet To Be Approved": ["NA"],
		"Yet To Be Approved By Network Team": ["NA"],
		"Approved": ["Pending"],
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
		GetSelectedTextValue1();
	}
	status.onchange = function() {
		paymentStatus.length = 1;
		var z = statusObject[tripStatus.value][this.value];
		for (var i = 0; i < z.length; i++) {
			paymentStatus.options[paymentStatus.options.length] = new Option(
				z[i], z[i]);
		}
		GetSelectedTextValue1();
	}
}



var dataLimit = '${dataLimit}';
dataLimit = parseInt(dataLimit);
const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var currentDate = '${currentDate}';

var tabledataQuery = $('#tabledataQuery').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": []
});

var tabledata = $('#tabledata').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": true,
	"info": false,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 100,
	dom: 'Bfrtip',
	buttons: [

		{
			extend: 'excelHtml5',

			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
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
			if (btnClass)
				$buttons.find(btnClass).click();
		})

		$('#exportLinkPdf').on('click', function() {
			var btnClass = "pdf" ?
				'.buttons-' + "pdf" :
				null;
			if (btnClass)
				$buttons.find(btnClass).click();
		})
	}
});

$('#searchData').on('keyup', function() {
	tabledata.search(this.value).draw();
});

$('#tabledata_filter').css("display", "none");

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


function calculateTotalFreight() {

	var fs = parseFloat("0");
	var totalFreight = parseFloat("0");

	if ($.isNumeric($("#currentFuelRate").val())) {
		totalFreight = parseFloat($("#currentFuelRate").val());
	}
	var engMarks = document.getElementById('currentFuelRate').value;
	var currentFuelRate = parseFloat($("#currentFuelRate").val());
	var fsBaseRate = parseFloat($("#fsBaseRate").val());
	var mileage = parseFloat($("#mileage").val());
	var routeKms = parseFloat($("#routeKms").val());
	fs = ((currentFuelRate - fsBaseRate / mileage) * routeKms);

}

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
	$("#pageInfo").css("display", "block");
	$("#pagingId").css("display", "block");
})

$('#tabledata tbody').on('click', ".tripIdView", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setTripStatus(row.cells[0].innerText);
});

function setTripStatus(tripId) {
	globalTripId = "";
	globalTripId = tripId;
}

function setTripStatus(tripId) {

	var json = {
		"tripID": tripId
	}

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
				var myForm = "";
				myForm = document.getElementById("tripForm");
				setData(myForm, result);
				$("#tripID").val(result.tripID);
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

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "tripControllers/getRemarksByRefID",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			if (data.msg == 'success') {
				if ("data" in data) {
					var result = data.data;
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
		}
	});
}


function getFilterData() {
	$('#selectTripStatus').val('');
	$('#selectStatus').val('');
	$('#selectPaymentStatus').val('');


	var fromDate = $("#fromDate").val();
	var toDate = $("#toDate").val();


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
	fromDate = moment(fromDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
	toDate = moment(toDate, 'DD-MM-YYYY').format('YYYY-MM-DD');


	var dateReturnCheck = dateValidationCheck(fromDate, toDate);
	if (dateReturnCheck == "false") {


		$('.loader').show();


		$.ajax({
			type: "GET",
			data: {
				"actualDeparture": fromDate.concat(" ", "00:00:00"),
				"actualArrival": toDate.concat(" ", "23:59:59"),
				"vendorCode": ""
			},
			url: "tripControllers/filterTripDetails?actualDeparture",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",

			success: function(data) {
				$('.loader').hide();
				if (data.msg == 'success') {
					$("#pageInfo").css("display", "none");
					$("#pagingId").css("display", "none");
					var result = data.data;
					showTableData(data, 1);
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


function GetSelectedTextValue1() {

	$('#fromDate').val('');
	$('#toDate').val('');

	var tripStatus = $("#selectTripStatus").val();
	var selectStatus = $("#selectStatus").val();
	var selectPaymentStatus = $("#selectPaymentStatus").val();
	var obj = {
		"runStatus": tripStatus,
		"vendorTripStatus": selectStatus,
		"paymentStatus": selectPaymentStatus,
	}

	$('.loader').show();
	$.ajax({
		type: "POST",
		url: "tripControllers/status",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		data: JSON.stringify(obj),
		success: function(data) {

			$('.loader').hide();
			if (data.msg == "success") {
				var result = data.data;
				showDataInTable(result);
			} else {
				alert("failed");
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			alert("failed, please try again");
		}
	});
}

getData();
function getData() {
	$('#selectTripStatus').val('');
	$('#selectStatus').val('');
	$('#selectPaymentStatus').val('');
	$('#fromDate').val('');
	$('#toDate').val('');
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
				showTableData(data, 1);
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

function showTableData(data, pageNumber) {
	var result = data.data;
	pageNumber = parseInt(pageNumber);
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
		if (!result[i].hasOwnProperty("mode")) {
			result[i].mode = "-";
		}
		if (!result[i].hasOwnProperty("vendorName")) {
			result[i].vendorName = "-";
		}
		if (!result[i].hasOwnProperty("vendorCode")) {
			result[i].vendorCode = "-";
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
		if (!result[i].hasOwnProperty("actualKM")) {
			result[i].actualKM = "-";
		}
		if (!result[i].hasOwnProperty("standardVechicleType")) {
			result[i].standardVechicleType = "-";
		}
		if (!result[i].hasOwnProperty("standardKM")) {
			result[i].standardKM = "-";
		}
		if (!result[i].hasOwnProperty("originHub")) {
			result[i].originHub = "-";
		}
		if (!result[i].hasOwnProperty("destHub")) {
			result[i].destHub = "-";
		}

		var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\"  class=\"tripIdView\" >" + result[i].tripID + "</a>";
		tabledata.row.add([view,
			result[i].route,
			result[i].runType,
			result[i].mode,
			result[i].vendorName,
			result[i].vendorCode,
			result[i].runStatus,
			result[i].vendorTripStatus,
			result[i].actualDeparture,
			result[i].standardVechicleType,
			result[i].actualKM,
			result[i].standardKM,
			result[i].originHub,
			result[i].destHub]);
	}
	tabledata.draw();
	$("tbody").show();

	var pageLength = parseInt(Math.round(data.totalRecord / 100));

	var pageHtml = "";
	for (var k = 1; k <= pageLength; k++) {

		if (pageNumber == 1 && k == 1) {
			pageHtml += "<li class=\"getPaginationData paginate_button page-item active\" id=\"pageId_" + k + "\" ><a  style=\"cursor: pointer;\" value=\"" + k + "\" aria-controls=\"tabledata\" data-dt-idx=\"" + k + "\" tabindex=\"" + k + "\" class=\"page-link\">" + k + "</a></li>";
		}
		else if (pageNumber == k) {
			pageHtml += "<li class=\"getPaginationData paginate_button page-item active\" id=\"pageId_" + k + "\" ><a  style=\"cursor: pointer;\" value=\"" + k + "\" aria-controls=\"tabledata\" data-dt-idx=\"" + k + "\" tabindex=\"" + k + "\" class=\"page-link\">" + k + "</a></li>";
		}
		else {
			pageHtml += "<li class=\"getPaginationData paginate_button page-item\" id=\"pageId_" + k + "\" ><a style=\"cursor: pointer;\" value=\"" + k + "\" aria-controls=\"tabledata\" data-dt-idx=\"" + k + "\" tabindex=\"" + k + "\" class=\"page-link\">" + k + "</a></li>";
		}

	}
	var previousBtn = "";
	var nextBtn = "";

	var nextPageNmbr = pageNumber + 1;
	var prvsPageNmbr = pageNumber - 1;

	if (pageNumber == 1) {
		previousBtn = "<li class=\"paginate_button page-item previous disabled\"  id=\"tabledata_previous\"><a style=\"cursor: pointer;\" aria-controls=\"tabledata\" data-dt-idx=\"0\" tabindex=\"0\" class=\"page-link\">Previous</a></li>";
	}
	else {

		previousBtn = "<li class=\"prvsPageNumbr paginate_button page-item previous\" value=\"" + prvsPageNmbr + "\" id=\"tabledata_previous\"><a style=\"cursor: pointer;\" aria-controls=\"tabledata\" data-dt-idx=\"0\" tabindex=\"0\" class=\"page-link\">Previous</a></li>";
	}
	if (pageNumber == pageLength) {
		nextBtn = "<li class=\"paginate_button page-item next disabled\" id=\"tabledata_next\"><a style=\"cursor: pointer;\" aria-controls=\"tabledata\" data-dt-idx=\"2\" tabindex=\"0\" class=\"page-link\">Next</a></li>";
	}
	else {
		nextBtn = "<li class=\"nextPageNumbr paginate_button page-item next\" value=\"" + nextPageNmbr + "\" id=\"tabledata_next\"><a style=\"cursor: pointer;\" aria-controls=\"tabledata\" data-dt-idx=\"2\" tabindex=\"0\" class=\"page-link\">Next</a></li>";
	}

	var pageNumberShow = "<li class=\"paginate_button page-item active\" value=\"" + pageNumber + "\" ><button>" + pageNumber + "</button></li>";

	var pagingHtml = "<div class=\"dataTables_paginate paging_simple_numbers\" ><ul class=\"pagination\">" +
		previousBtn + pageNumberShow + nextBtn + "</ul></div>";

	var infoHtml = "";
	if (pageNumber == 1) {
		infoHtml = "<div class=\"dataTables_info\" id=\"tabledata1_info\" role=\"status\" aria-live=\"polite\">Showing " + pageNumber * 1 + " to " + (pageNumber * 100) + " of " + data.totalRecord + " entries</div>";
	} else {
		infoHtml = "<div class=\"dataTables_info\" id=\"tabledata1_info\" role=\"status\" aria-live=\"polite\">Showing " + (((pageNumber - 1) * 100) + 1) + " to " + (pageNumber * 100) + " of " + data.totalRecord + " entries</div>";
	}
	if (pageNumber == pageLength) {
		infoHtml = "<div class=\"dataTables_info\" id=\"tabledata1_info\" role=\"status\" aria-live=\"polite\">Showing " + (((pageNumber - 1) * 100) + 1) + " to " + data.totalRecord + " of " + data.totalRecord + " entries</div>";
	}

	$("#pageInfo").html(infoHtml);

	$("#pagingId").html(pagingHtml);



}


$('#tabledata tbody').on('click', ".nextPageNumbr", function() {
	getPaginationData(this.value);

});

$("body").on("click", ".nextPageNumbr", function() {

	getPagination(this.value);

});

$("body").on("click", ".prvsPageNumbr", function() {

	getPagination(this.value);

});

$("body").on("click", ".getPaginationData", function() {

	var classVal = $(this).attr('id').split("_");
	getPagination(classVal[1]);

});



function getPagination(pageNumber) {

	var obj = {
		"id": pageNumber
	}

	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "tripControllers/getPaginationDataOfVendor",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {


			$('.loader').hide();

			if (data.msg == 'success') {
				//var result = data.data;
				showTableData(data, pageNumber);

			}
			else {
				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}

		},
		error: function(jqXHR, textStatue, errorThrown) {
			$('.loader').hide();
			alert("failed, please try again");
		}

	});

}
