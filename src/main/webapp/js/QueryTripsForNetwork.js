var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$("#saveCoaDetails").bind("click", function() {
	updateTripDataByNetworkTeam('No');
});
$("#recalculate").bind("click", function() {
	refreshValues();
});

$("#vendorName").bind("click", function() {
	getBpCode();
});

$('#vendorName').select2({
	theme: 'bootstrap4'
});

$("#lumpsum").bind("click", function() {
	lumpsomePropertyChange();
});


var dataLimit = '${dataLimit}';
dataLimit = parseInt(dataLimit);

var tabledataQuery = $('#queryTabledata').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": []
});


$('#tripValue').modal("hide");
const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var tabledata = $('#tabledata1').DataTable({
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
				columns: [0, 1, 2, 3, 4, 5, 6],
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6],
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

$('#tabledata1_filter').css("display", "none");

var globalTripId = "";

getData();
function getData() {


	$('.loader').show();

	$.ajax({
		type: "POST",
		data: "",
		url: "tripControllers/getQueryTrips",
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
					if (!result[i].hasOwnProperty("vendorName")) {
						result[i].vendorName = "-";
					}
					if (!result[i].hasOwnProperty("vendorCode")) {
						result[i].vendorCode = "-";
					}
					if (!result[i].hasOwnProperty("runType")) {
						result[i].runType = "-";
					}
					if (!result[i].hasOwnProperty("vehicleNumber")) {
						result[i].vehicleNumber = "-";
					}



					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\"  class=\"tripIdView\" >" + result[i].tripID + "</a>";

					var tempString = [view,
						result[i].route,
						result[i].vendorName,
						result[i].vendorCode,
						result[i].runType,
						result[i].runStatus,
						result[i].vehicleNumber];

					tabledata.row.add(tempString);
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


$('#tabledata1 tbody').on('click', ".tripIdView", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setTripStatus(row.cells[0].innerText, row.cells[2].innerText);
});

function setTripStatus(tripId, vendorNameOfTrip) {

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
				myForm = document.getElementById("tripForm1");
				setData(myForm, result);
				$("#vendorName").val(vendorNameOfTrip).trigger('change');
				$('#tripValue').modal('show');
			} else {
				Toast.fire({
					type: 'error',
					title: 'Error in getting values. Please Try Again after sometime'
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



function lumpsomePropertyChange() {
	var checkedValue = $('.messageCheckbox:checked').val();
	$("#AmountLumpSum").prop('disabled', true);
	$("#AmountLumpSum").val("");
	$("#fs").prop('disabled', false);
	$("#totalFreight").prop('disabled', false);
	$("#basicFreight").prop('disabled', false);

	var currentFuelRate = document.getElementById("currentFuelRate").value;
	var fsBaseRate = document.getElementById("fsBaseRate").value;
	var standKMS = document.getElementById("standardKM").value;
	var ratePerKm = document.getElementById("ratePerKm").value;

	var fsCal = parseFloat(currentFuelRate) - parseFloat(fsBaseRate);
	var basicFreight = parseFloat(standKMS) * parseFloat(ratePerKm);
	document.getElementById("basicFreight").value = basicFreight.toFixed(2);

	var mileage = document.getElementById("mileage").value;
	var routeKms = document.getElementById("routeKms").value;
	var fs = (parseFloat(fsCal) / parseFloat(mileage)) * parseFloat(routeKms);
	document.getElementById("fs").value = fs.toFixed(2);

	var totalFreight = parseFloat(basicFreight) + parseFloat(fs);
	document.getElementById("totalFreight").value = totalFreight.toFixed(2);

	var a = $("#fs").val();
	var b = $("#totalFreight").val();
	var c = $("#basicFreight").val();

	$("#fs").val(a);
	$("#totalFreight").val(b);
	$("#basicFreight").val(c);


	if (checkedValue == '') {
		$("#AmountLumpSum").prop('disabled', false);
		$('#fs').val('');
		$('#totalFreight').val('');
		$('#basicFreight').val('');
		$("#fs").prop('disabled', true);
		$("#totalFreight").prop('disabled', true);
		$("#basicFreight").prop('disabled', true);

		$("#fs").val("");
		$("#totalFreight").val("");
		$("#basicFreight").val("");
	}
}

function updateTripDataByNetworkTeam(query) {
	//Validations
	var ratePerKm = document.getElementById("ratePerKm").value;
	var milage = document.getElementById("mileage").value;
	var routeKms = document.getElementById("routeKms").value;
	var fsBaseRate = document.getElementById("fsBaseRate").value;
	var currentFuelRate = document.getElementById("currentFuelRate").value;
	var fsDiff = document.getElementById("fsDiff").value;
	var basicFreight = document.getElementById("basicFreight").value;
	var totalFreight = document.getElementById("totalFreight").value;
	var openingReading = document.getElementById("openingReading").value;
	var closingReading = document.getElementById("closingReading").value;
	var AmountLumpSum = document.getElementById("AmountLumpSum").value;
	var lumpsum = document.getElementById("lumpsum").value;
	var fs = document.getElementById("fs").value;
	var vendorName = document.getElementById("vendorName").value;
	var vendorCode = document.getElementById("vendorCode").value;

	if (milage === "" || milage === null || milage === '') {
		Toast.fire({
			type: 'error',
			title: 'Mileage cannot be empty!! '
		});
		document.getElementById("mileage").focus();
		return "";
	}


	if (ratePerKm === "" || ratePerKm === null || ratePerKm === '') {
		Toast.fire({
			type: 'error',
			title: 'Please chcek the Value of Rate Per KM'
		});
		document.getElementById("ratePerKm").focus();
		return "";
	}

	if (routeKms === "" || routeKms === null || routeKms === '') {
		Toast.fire({
			type: 'error',
			title: 'Billable Kms cannot be empty!!'
		});
		document.getElementById("routeKms").focus();
		return "";
	}

	if (currentFuelRate === "" || currentFuelRate === null || currentFuelRate === '') {
		Toast.fire({
			type: 'error',
			title: 'Current Fuel Rate cannot be empty!!'
		});
		document.getElementById("currentFuelRate").focus();
		return "";
	}



	if (fsBaseRate === "" || fsBaseRate === null || fsBaseRate === '') {
		Toast.fire({
			type: 'error',
			title: 'Please chcek the Value of Fs Base Rate'
		});
		document.getElementById("fsBaseRate").focus();
		return "";
	}

	if (fsDiff === "" || fsDiff === null || fsDiff === '') {
		Toast.fire({
			type: 'error',
			title: 'Please chcek the Value of Fs Diff'
		});
		document.getElementById("fsDiff").focus();
		return "";
	}

	var today = new Date();
	var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
	var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
	var dateTime = date + ' ' + time;
	var checkedValue = $('.messageCheckbox:checked').val();

	if (checkedValue != '' || checkedValue != "") {
		checkedValue = 'unchecked';

		if (basicFreight === "" || basicFreight === null || basicFreight === '') {
			Toast.fire({
				type: 'error',
				title: 'Please chcek the Value of Basic Fraight'
			});
			document.getElementById("basicFreight").focus();
			return "";
		}

		if (totalFreight === "" || totalFreight === null || totalFreight === '') {
			Toast.fire({
				type: 'error',
				title: 'Please chcek the Value of Total Fraight'
			});
			document.getElementById("totalFreight").focus();
			return "";
		}

		if (fs === "" || fs === null || fs === '') {
			Toast.fire({
				type: 'error',
				title: 'Please check the Value of FS'
			});
			document.getElementById("fs").focus();
			return "";
		}


	} else {
		if (AmountLumpSum === '' || AmountLumpSum === null || AmountLumpSum === '0' || AmountLumpSum === '0.0') {
			Toast.fire({
				type: 'error',
				title: 'Please check the Value of Lump Sum Amount'
			});
			document.getElementById("AmountLumpSum").focus();
			return "";
		}
	}

	calcualteFormulae();

	var checkbox = $('#lumpsum').is(':checked');
	if (checkbox == true) {
		$("#fs").val("0");
		$("#totalFreight").val("0");
		$("#basicFreight").val("0");
	} else {
		$("#AmountLumpSum").val("0");
	}

	var fs = document.getElementById("fs").value;
	var totalFreight = document.getElementById("totalFreight").value;
	var basicFreight = document.getElementById("basicFreight").value;
	var comments_by_User = document.getElementById("comment").value;

	var standardKM = document.getElementById("standardKM").value;

	var obj = {
		"tripID": document.getElementById("tripID").value,
		"processedBy": 'NetworkTeam',
		"processedOn": dateTime,
		"LumpSomeAmount": document.getElementById("AmountLumpSum").value,
		"AssigenedTo": "Vendor",
		"fs": fs,
		"totalFreight": totalFreight,
		"basicFreight": basicFreight,
		"commentsby": comments_by_User,
		"standardKM": standardKM,
		"milage": milage,
		"ratePerKm": ratePerKm,
		"routeKms": routeKms,
		"fsBaseRate": fsBaseRate,
		"currentFuelRate": currentFuelRate,
		"fsDiff": fsDiff,
		"Query": query,
		"vendorName": vendorName,
		"vendorCode": vendorCode,
		"type": "Trip"
	}
	console.log(obj);
	//  calcualteFormulae();
	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "dashboardController/updateDetailsforNetwork",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			if (data.msg == 'success') {
				var result = data.data;

			} else {
				Toast.fire({
					type: 'error',
					title: 'Error in getting values. Please Try Again after sometime'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			Toast.fire({
				type: 'error',
				title: 'Action Performed'
			})
		}

	});

	if ('No' == query) {
		$('#tripValue').modal('hide');
		location.reload();
	}

}


function calcualteFormulae() {
	var currentFuelRate = document.getElementById("currentFuelRate").value;
	var fsBaseRate = document.getElementById("fsBaseRate").value;
	var standKMS = document.getElementById("standardKM").value;
	var ratePerKm = document.getElementById("ratePerKm").value;

	var fsCal = parseFloat(currentFuelRate) - parseFloat(fsBaseRate);
	var basicFreight = parseFloat(standKMS) * parseFloat(ratePerKm);
	document.getElementById("basicFreight").value = basicFreight.toFixed(2);

	var mileage = document.getElementById("mileage").value;
	var routeKms = document.getElementById("routeKms").value;
	var fs = (parseFloat(fsCal) / parseFloat(mileage)) * parseFloat(routeKms);
	document.getElementById("fs").value = fs.toFixed(2);

	var totalFreight = parseFloat(basicFreight) + parseFloat(fs);
	document.getElementById("totalFreight").value = totalFreight.toFixed(2);

}

function refreshValues() {
	var route = document.getElementById("route").value;//route
	var vendorCode = document.getElementById("vendorCode").value;
	var obj = {
		"route": route,
		"vendorCode": vendorCode
	}


	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "dashboardController/refreshValues",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			if (data.msg == 'success') {
				var resData = data.data;
				document.getElementById("currentFuelRate").value = resData.currentFuelRate
					.toFixed(2);
				document.getElementById("ratePerKm").value = resData.rate
					.toFixed(2);
				document.getElementById("mileage").value = resData.stdMileagePerKm
					.toFixed(2);
				document.getElementById("standardKM").value = resData.maxKms;
				document.getElementById("fsDiff").value = resData.fsDiff;
				document.getElementById("fsBaseRate").value = resData.baseRate
					.toFixed(2);
				document.getElementById("routeKms").value = resData.maxKms;

				if ("0" == document.getElementById("actualKM")) {
					document.getElementById("routeKms").value = document
						.getElementById("standardKM").value;
				} else if (parseFloat(document
					.getElementById("actualKM").value) < parseFloat(document
						.getElementById("standardKM").value)) {
					document.getElementById("routeKms").value = document
						.getElementById("standardKM").value;
				} else {
					document.getElementById("routeKms").value = document
						.getElementById("standardKM").value;
				}

				calcualteFormulae();
				updateTripDataByNetworkTeam('Yes');

			}else{
				Toast.fire({
					type: 'error',
					title: 'This Route is not found in MDM, please contact finance department'
				})
			}
		}

	});

}

function getBpCode() {
	var vendorName = $("#vendorName").val();

	var json = {
		"vendorName": vendorName
	}
	console.log(json);
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "dashboardController/getBpCodeForNetwork",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {

			if (data.msg == 'success') {
				var result = data.data;
				$("#vendorCode").val(result);

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