var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});


$( "#filterDataByColumn" ).bind( "click", function() {
 selectDropDownValue();
});

$( "#invoiceProcess" ).bind( "click", function() {
 invoiceProcessing();
});

var tabledata = $('#tabledata').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": true,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	dom: 'Bfrtip',
	buttons: [

		{
			extend: 'excelHtml5',

			exportOptions: {
				columns: [1, 2, 3, 4, 5, 6, 7, 8, 9],
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [1, 2, 3, 4, 5, 6, 7, 8, 9],
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
	"autoWidth": false,
	"aaSorting": []
});

$(function() {
	$('.checkbox-toggle').click(function() {
		var clicks = $(this).data('clicks')
		if (clicks) {
			$('.mailbox-messages input[type=\'checkbox\']').prop('checked', false)
			$('.checkbox-toggle .far.fa-check-square').removeClass('fa-check-square').addClass('fa-square')
		} else {
			$('.mailbox-messages input[type=\'checkbox\']').prop('checked', true)
			$('.checkbox-toggle .far.fa-square').removeClass('fa-square').addClass('fa-check-square')
		}
		$(this).data('clicks', !clicks)
	})
	$('.mailbox-star').click(function(e) {
		e.preventDefault()
		var $this = $(this).find('a > i')
		var glyph = $this.hasClass('glyphicon')
		var fa = $this.hasClass('fa')

		if (glyph) {
			$this.toggleClass('glyphicon-star')
			$this.toggleClass('glyphicon-star-empty')
		}

		if (fa) {
			$this.toggleClass('fa-star')
			$this.toggleClass('fa-star-o')
		}
	})
})

$("#refreshDashboardButton").click(function(e) {
	e.preventDefault();
	$('#refreshDashboardButton').attr('disabled', 'disabled');
	getData();
	$('#refreshDashboardButton').removeAttr('disabled');
	$('#selectLevelValue').val('');
	$('#selectInputValue').val('');
})

function invoiceProcessing() {
	
	var table = document.getElementById('tabledata');
	var checkflag = [];
	$("input:checkbox[name='option']:checked").each(function() {
		checkflag.push($(this).val());
	});

	let values = checkflag.toString();
	if (values == "" || values == null) {
		Toast.fire({
			type: 'error',
			title: 'Please select atleast one trip'
		})
		return;
	}
	$('.loader').show();
	var urlOftripsDetail = "tripsInvoiceGenerate?id=" + btoa(values);
	window.open(urlOftripsDetail, "tripsInvoiceGenerate", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	$('.loader').hide();
}

getData();

function getData() {
	$('.loader').show();
	$.ajax({
		type: "POST",
		data: "",
		url: "tripControllers/getCloseAndApprovedTripsDetails",
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
					if (!result[i].hasOwnProperty("originHub")) {
						result[i].originHub = "-";
					}
					if (!result[i].hasOwnProperty("destHub")) {
						result[i].destHub = "-";
					}
					if (!result[i].hasOwnProperty("vehicleNumber")) {
						result[i].vehicleNumber = "-";
					}
					if (!result[i].hasOwnProperty("standardVechicleType")) {
						result[i].standardVechicleType = "-";
					}
					if (!result[i].hasOwnProperty("runType")) {
						result[i].runType = "-";
					}
					if (!result[i].hasOwnProperty("standardKM")) {
						result[i].standardKM = "-";
					}
					if (!result[i].hasOwnProperty("actualDeparture")) {
						result[i].actualDeparture = "-";
					}
					if (!result[i].hasOwnProperty("actualArrival")) {
						result[i].actualArrival = "-";
					}
					if (!result[i].hasOwnProperty("totalFreight")) {
						result[i].totalFreight = "-";
					}

					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" class=\"tripIdView\" )\" >" + result[i].tripID + "</a>";
					var checkbox = "<div class=\"mailbox-messages\"><input type=\"checkbox\" name=\"option\" value=\"" + result[i].tripID + "\" ><\div>";


					tabledata.row.add([
						checkbox, view, result[i].route, result[i].originHub + " / " + result[i].destHub,
						result[i].vehicleNumber + " / " + result[i].standardVechicleType,
						result[i].runType, result[i].standardKM, result[i].actualDeparture, result[i].actualArrival, result[i].totalFreight]);
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



$( "#flipToInvoice" ).bind( "click", function() {
 invoiceProcessing();
});

$('#tabledata tbody').on('click', ".tripIdView", function() {
	var row = $(this).parents('tr')[0];
	setTripStatus(row.cells[1].innerText);
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

function refereshList() {
	getData();
	$('.loader').hide();
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
function selectDropDownValue() {
	var columnName = $("#selectLevelValue").val();
	var columnValue = $("#selectInputValue").val();
	var vendorCode = $("#vendorCode").val();

	if (columnName == "" || columnName == null) {
		Toast.fire({
			type: 'error',
			title: 'Select Column Type.'
		});
		document.getElementById("selectLevelValue").focus();
		return;
	}

	if (columnValue == "" || columnValue == null) {
		Toast.fire({
			type: 'error',
			title: 'Please Insert Value.'
		});
		document.getElementById("selectInputValue").focus();
		return;
	}

	var json = {
		"columnName": columnName,
		"columnValue": columnValue,
		"tripStatus": 'Approved',
		"vendorCode": vendorCode
	}
	$('.loader').show();

	$.ajax({
		type: "GET",
		url: "tripControllers/filterByColumn",
		data: json,
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			$('.loader').hide();
			if (response.msg == "success") {
				var result = response.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					if (!result[i].hasOwnProperty("tripID")) {
						result[i].tripID = "-";
					}
					if (!result[i].hasOwnProperty("route")) {
						result[i].route = "-";
					}
					if (!result[i].hasOwnProperty("originHub")) {
						result[i].originHub = "-";
					}
					if (!result[i].hasOwnProperty("destHub")) {
						result[i].destHub = "-";
					}
					if (!result[i].hasOwnProperty("vehicleNumber")) {
						result[i].vehicleNumber = "-";
					}
					if (!result[i].hasOwnProperty("standardVechicleType")) {
						result[i].standardVechicleType = "-";
					}
					if (!result[i].hasOwnProperty("runType")) {
						result[i].runType = "-";
					}
					if (!result[i].hasOwnProperty("standardKM")) {
						result[i].standardKM = "-";
					}
					if (!result[i].hasOwnProperty("actualDeparture")) {
						result[i].actualDeparture = "-";
					}
					if (!result[i].hasOwnProperty("actualArrival")) {
						result[i].actualArrival = "-";
					}
					if (!result[i].hasOwnProperty("totalFreight")) {
						result[i].totalFreight = "-";
					}

					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" class=\"tripIdView\" )\" >" + result[i].tripID + "</a>";
					var checkbox = "<div class=\"mailbox-messages\"><input type=\"checkbox\" name=\"option\" value=\"" + result[i].tripID + "\" ><\div>";

					tabledata.row.add([checkbox,
						view, result[i].route, result[i].originHub + " / " + result[i].destHub,
						result[i].vehicleNumber + " / " + result[i].standardVechicleType,
						result[i].runType, result[i].standardKM, result[i].actualDeparture, result[i].actualArrival, result[i].totalFreight]);
				}
				tabledata.draw();
				$("tbody").show();
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
