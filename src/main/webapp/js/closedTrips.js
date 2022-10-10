var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var dataLimit = '${dataLimit}';
dataLimit = parseInt(dataLimit);

var tabledata = $('#tabledata').DataTable({
	"paging": true,
	"lengthChange": false,
	"searching": true,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 100,
	dom: 'Bfrtip',
	buttons: [

		{
			extend: 'excelHtml5',

			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7],
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7],
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

var tabledataQuery = $('#tabledataQuery').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": []
});

$('#searchData').on('keyup', function() {
	tabledata.search(this.value).draw();
});

$('#tabledata_filter').css("display", "none");

getData();

function getData() {
	$('.loader').show();

	$.ajax({
		type: "POST",
		data: "",
		url: "tripControllers/getCloseTripsDetails",
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
						result[i].tripID = "";
					}
					if (!result[i].hasOwnProperty("route")) {
						result[i].route = "";
					}
					if (!result[i].hasOwnProperty("runType")) {
						result[i].runType = "";
					}
					if (!result[i].hasOwnProperty("actualKM")) {
						result[i].actualKM = "";
					}
					if (!result[i].hasOwnProperty("standardKM")) {
						result[i].standardKM = "";
					}
					if (!result[i].hasOwnProperty("mode")) {
						result[i].mode = "";
					}
					if (!result[i].hasOwnProperty("actualDeparture")) {
						result[i].actualDeparture = "";
					}
					if (!result[i].hasOwnProperty("actualArrival")) {
						result[i].actualArrival = "";
					}

					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" class=\"tripIdView\"  >" + result[i].tripID + "</a>";

					tabledata.row.add([view, result[i].route, result[i].runType, result[i].actualKM, result[i].standardKM, result[i].mode, result[i].actualDeparture, result[i].actualArrival]);
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
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setTripStatus(row.cells[0].innerText);
});

function setTripStatus(tripId) {
	$('.loader').show();
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
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;


				var myForm = "";
				myForm = document.getElementById("tripForm");
				setData(myForm, result);

				$("#tripID").val(result.tripID);
				getQueryData(result.tripID);


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

function getQueryData(tripId) {
	$('.loader').show();
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
			$('.loader').hide();
			if (response.msg == "success") {

				if ("data" in response) {

					var result = response.data;

					tabledataQuery.clear();
					var count = 0;
					for (var i = 0; i < result.length; i++) {
						count++;
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

