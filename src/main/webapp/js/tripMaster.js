var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$('#vendorName').on('input', function (event) { 
    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
});

$('#city').on('input', function (event) { 
    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
});
$('#cityEdit').on('input', function (event) { 
    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
});





$('#route').blur(function () {
      $(":input").each(function(){
          this.value = this.value.toUpperCase();          
      });
});
$('#vendorCode').blur(function () {
      $(":input").each(function(){
          this.value = this.value.toUpperCase();          
      });
});
$('#city').blur(function () {
      $(":input").each(function(){
          this.value = this.value.toUpperCase();          
      });
});
$('#routeEdit').blur(function () {
      $(":input").each(function(){
          this.value = this.value.toUpperCase();          
      });
});
$('#vendorCodeEdit').blur(function () {
      $(":input").each(function(){
          this.value = this.value.toUpperCase();          
      });
});
$('#cityEdit').blur(function () {
      $(":input").each(function(){
          this.value = this.value.toUpperCase();          
      });
});

//$("#vendorName").rules("add", { regex: "[a-zA-Z. ]+" })


var tabledataExcelUpload = $('#tabledataExcelUpload').DataTable({
	"paging": true,
	"lengthChange": false,
	"searching": true,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 100

});

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
			title: '',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
				"format": {
					"header": function(data, columnindex, trDOM, node) {
						// Here 2 is the index of the column 
						// whose header name we want to change(0 based)
						return GetColumnPrefix(columnindex);
					}
				}
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
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


function GetColumnPrefix(colIndex) {
	switch (colIndex) {
		case 0:
			return "id";
		case 1:
			return "route";
		case 2:
			return "vendorName";
		case 3:
			return "vendorCode";
		case 4:
			return "type";
		case 5:
			return "city";
		case 6:
			return "cityName";
		case 7:
			return "state";
		case 8:
			return "vehicleType";
		case 9:
			return "tripCost";
		case 10:
			return "rate";
		case 11:
			return "baseRate";
		case 12:
			return "stdMileagePerKm";
		case 13:
			return "maxKms";
		case 14:
			return "currentFuelRate";
		case 15:
			return "fsDiff";
		case 16:
			return "agreementMadeDate";
		case 17:
			return "agreementExpiryDate";

		// leave space after the prefix

		default:
			return "";
	}
}

$('#searchData').on('keyup', function() {
	tabledata.search(this.value).draw();
});

$('#tabledata_filter').css("display", "none");

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

$('#checkListFormCode').select2({
	theme: 'bootstrap4'
});
$('#checkListFormCodeEdit').select2({
	theme: 'bootstrap4'
});

$('.select2bs4').select2({
	theme: 'bootstrap4'
})

$.validator.setDefaults({
	submitHandler: function() {
		addFormData();
	}
});
$('#addForm').validate({

	rules: {
		route: {
			required: true
		},
		vendorName: {
			required: true
		},
		vendorCode: {
			required: true
		},
		type: {
			required: true
		},
		city: {
			required: true
		},
		cityName: {
			required: true
		},
		state: {
			required: true
		},
		vehicleType: {
			required: true
		},
		tripCost: {
			required: true
		},
		rate: {
			required: true
		},
		baseRate: {
			required: true
		},
		currentFuelRate: {
			required: true
		},
		stdMileagePerKm: {
			required: true
		},
		maxKms: {
			required: true
		},
		agreementMadeDate: {
			required: true
		},
		fsDiff: {
			required: true
		},
		agreementExpiryDate: {
			required: true
		}
	},

	errorElement: 'span',
	errorPlacement: function(error, element) {
		error.addClass('invalid-feedback');
		element.closest('.form-group').append(error);
	},
	highlight: function(element, errorClass, validClass) {
		$(element).addClass('is-invalid');
	},
	unhighlight: function(element, errorClass, validClass) {
		$(element).removeClass('is-invalid');
	}
});

$.validator.setDefaults({
	submitHandler: function() {
		updateFormData();

	}
});
$('#updateMDMData').validate({
	rules: {
		route: {
			required: true
		},
		vendorName: {
			required: true
		},
		vendorCode: {
			required: true
		},
		type: {
			required: true
		},
		city: {
			required: true
		},
		cityName: {
			required: true
		},
		state: {
			required: true
		},
		vehicleType: {
			required: true
		},
		tripCost: {
			required: true
		},
		rate: {
			required: true
		},
		baseRate: {
			required: true
		},
		currentFuelRate: {
			required: true
		},
		stdMileagePerKm: {
			required: true
		},
		maxKms: {
			required: true
		},
		agreementMadeDate: {
			required: true
		},
		fsDiff: {
			required: true
		},
		agreementExpiryDate: {
			required: true
		}

	},

	errorElement: 'span',
	errorPlacement: function(error, element) {
		error.addClass('invalid-feedback');
		element.closest('.form-group').append(error);
	},
	highlight: function(element, errorClass, validClass) {
		$(element).addClass('is-invalid');
	},
	unhighlight: function(element, errorClass, validClass) {
		$(element).removeClass('is-invalid');
	}
});

function addFormData() {
	$("#submitBtn").prop("disabled", true);

	var fromDate = $("#agreementMadeDate").val();
	var toDate = $("#agreementExpiryDate").val();

	fromDate = moment(fromDate, 'YYYY-MM-DD').format('DD-MMM-YY');
	toDate = moment(toDate, 'YYYY-MM-DD').format('DD-MMM-YY');

	var json = {
		"route": $("#route").val(),
		"vendorName": $("#vendorName").val(),
		"vendorCode": $("#vendorCode").val(),
		"type": $("#type").val(),
		"city": $("#city").val(),
		"cityName": $("#cityName").val(),
		"state": $("#state").val(),
		"vehicleType": $("#vehicleType").val(),
		"rate": $("#rate").val(),
		"tripCost": $("#tripCost").val(),
		"baseRate": $("#baseRate").val(),
		"stdMileagePerKm": $("#stdMileagePerKm").val(),
		"maxKms": $("#maxKms").val(),
		"fixedKm": $("#maxKms").val(),
		"agreementMadeDate": fromDate,
		"agreementExpiryDate": toDate,
		"currentFuelRate": $("#currentFuelRate").val(),
		"fsDiff": $("#fsDiff").val()
	}
	$('.loader').show();
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "masterController/saveTripMaster",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		/* async: false, */
		contentType: "application/json",

		success: function(data) {

			$("#submitBtn").prop("disabled", false);
			$('.loader').hide();
			if (data.msg == 'success') {

				Toast.fire({
					type: 'success',
					title: 'Saved Successfully..'
				})

				$("#addForm")[0].reset();
				getData();
			} else {
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


function updateFormData() {
	var fromDate = $("#agreementMadeDateEdit").val();
	var toDate = $("#agreementExpiryDateEdit").val();

	fromDate = moment(fromDate, 'YYYY-MM-DD').format('DD-MMM-YY');
	toDate = moment(toDate, 'YYYY-MM-DD').format('DD-MMM-YY');

	var json = {
		"id": id,
		"route": $("#routeEdit").val(),
		"vendorName": $("#vendorNameEdit").val(),
		"vendorCode": $("#vendorCodeEdit").val(),
		"type": $("#typeEdit").val(),
		"city": $("#cityEdit").val(),
		"cityName": $("#cityNameEdit").val(),
		"state": $("#stateEdit").val(),
		"vehicleType": $("#vehicleTypeEdit").val(),
		"rate": $("#rateEdit").val(),
		"tripCost": $("#tripCostEdit").val(),
		"baseRate": $("#baseRateEdit").val(),
		"stdMileagePerKm": $("#stdMileagePerKmEdit").val(),
		"maxKms": $("#maxKmsEdit").val(),
		"fixedKm": $("#maxKmsEdit").val(),
		"agreementMadeDate": fromDate,
		"agreementExpiryDate": toDate,
		"currentFuelRate": $("#currentFuelRateEdit").val(),
		"fsDiff": $("#fsDiffEdit").val()
	}


	$("#updateBtn").prop("disabled", true);
	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "masterController/saveUpdateMasterDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			$("#updateBtn").prop("disabled", false);
			$('.loader').hide();

			if (data.msg == 'success') {

				Toast.fire({
					type: 'success',
					title: 'Updated Successfully..'
				})
				$("#userModal").modal('hide');
				getData();
			} else {
				$("#updateBtn").prop("disabled", false);
				$('.loader').hide();
				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}

		},
		error: function(jqXHR, textStatue, errorThrown) {
			$("#updateBtn").prop("disabled", false);
			$('.loader').hide();
			alert("failed, please try again");
		}

	});

}

getData();

function getData() {

	$.ajax({
		type: "POST",
		data: "",
		url: "masterController/getActiveMasterData",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				var result = data.data;
				tabledata.clear();
				var count = 0;

				for (var i = 0; i < result.length; i++) {
					if (!result[i].hasOwnProperty("route")) {
						result[i].route = "";
					}
					if (!result[i].hasOwnProperty("vendorName")) {
						result[i].vendorName = "";
					}
					if (!result[i].hasOwnProperty("vendorCode")) {
						result[i].vendorCode = "";
					}
					if (!result[i].hasOwnProperty("type")) {
						result[i].type = "";
					}
					if (!result[i].hasOwnProperty("city")) {
						result[i].city = "";
					}
					if (!result[i].hasOwnProperty("cityName")) {
						result[i].cityName = "";
					}
					if (!result[i].hasOwnProperty("state")) {
						result[i].state = "";
					}
					if (!result[i].hasOwnProperty("vehicleType")) {
						result[i].vehicleType = "";
					}
					if (!result[i].hasOwnProperty("tripCost")) {
						result[i].tripCost = "";
					}
					if (!result[i].hasOwnProperty("rate")) {
						result[i].rate = "";
					}
					if (!result[i].hasOwnProperty("baseRate")) {
						result[i].baseRate = "";
					}
					if (!result[i].hasOwnProperty("stdMileagePerKm")) {
						result[i].stdMileagePerKm = "";
					}
					if (!result[i].hasOwnProperty("maxKms")) {
						result[i].maxKms = "";
					}
					if (!result[i].hasOwnProperty("currentFuelRate")) {
						result[i].currentFuelRate = "";
					}
					if (!result[i].hasOwnProperty("fsDiff")) {
						result[i].fsDiff = "";
					}
					if (!result[i].hasOwnProperty("agreementExpiryDate")) {
						result[i].agreementExpiryDate = "";
					}
					if (!result[i].hasOwnProperty("agreementMadeDate")) {
						result[i].agreementMadeDate = "";
					}
					count++;

					var inactive = "<button type=\"button\"  class=\"tridlttable btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\"> <i class=\"nav-icon fas fa-trash\"></i>  </button>";
					var edit = "<button type=\"button\"  class=\"triedttable btn btn-primary btn-xs \" data-placement=\"bottom\"   data-original-title=\"Click To Edit\" ><i class=\"nav-icon fas fa-edit\"></i> </button>";

					tabledata.row.add([result[i].id,
						result[i].route,
						result[i].vendorName,
						result[i].vendorCode,
						result[i].type,
						result[i].city,
						result[i].cityName,
						result[i].state,
						result[i].vehicleType,
						result[i].tripCost,
						result[i].rate,
						result[i].baseRate,
						result[i].stdMileagePerKm,
						result[i].maxKms,
						result[i].currentFuelRate,
						result[i].fsDiff,
						result[i].agreementMadeDate,
						result[i].agreementExpiryDate,
						edit + "&nbsp;" + inactive]);

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


function editData(id2) {
	id = "";
	id = id2;
	status = "";
	var json = {
		"id": id2
	}

	console.log(json);
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "masterController/getMasterById",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			if (data.msg == 'success') {

				var result = data.data;

				var fromDate = result.agreementMadeDate;
				var toDate = result.agreementExpiryDate;

				fromDate = moment(fromDate, 'DD-MMM-YY').format('YYYY-MM-DD');
				toDate = moment(toDate, 'DD-MMM-YY').format('YYYY-MM-DD');

				$("#routeEdit").val(result.route);
				$("#vendorNameEdit").val(result.vendorName);
				$("#vendorCodeEdit").val(result.vendorCode);
				$("#typeEdit").val(result.type);
				$("#cityEdit").val(result.city);
				$("#cityNameEdit").val(result.cityName);
				$("#stateEdit").val(result.state);
				$("#vehicleTypeEdit").val(result.vehicleType);
				$("#tripCostEdit").val(result.tripCost);
				$("#stdMileagePerKmEdit").val(result.stdMileagePerKm);
				$("#rateEdit").val(result.rate);
				$("#baseRateEdit").val(result.baseRate);
				$("#currentFuelRateEdit").val(result.currentFuelRate);
				$("#maxKmsEdit").val(result.maxKms);
				$("#fsDiffEdit").val(result.fsDiff);
				$("#agreementMadeDateEdit").val(fromDate);
				$("#agreementExpiryDateEdit").val(toDate);

				$("#userModal").modal('show');

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

function inactiveActiveDeleteData(userid) {

	var json = {
		"id": userid,

	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "masterController/deleteMaster",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				Toast.fire({
					type: 'success',
					title: 'Deleted Successfully..'
				})


				getData();
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
$(function() {
	$('[name="agreementMadeDate"]').prop('max', function() {
		return new Date().toJSON().split('T')[0];
	});
});
$(function() {
	$('[name="agreementExpiryDate"]').prop('min', function() {
		return new Date().toJSON().split('T')[0];
	});
});
$(function() {
	$('[name="agreementMadeDateEdit"]').prop('max', function() {
		return new Date().toJSON().split('T')[0];
	});
});
$(function() {
	$('[name="agreementExpiryDateEdit"]').prop('min', function() {
		return new Date().toJSON().split('T')[0];
	});
});


// for read Excel and convert to json Array	
var input_dom_element = document.getElementById("readExcel");
input_dom_element.addEventListener('change', handleFileSelectForExcel, false);

var ExcelToJSON = function() {

	this.parseExcel = function(file) {
		var reader = new FileReader();

		reader.onload = function(e) {
			var data = e.target.result;
			var workbook = XLSX.read(data, {
				type: 'binary'
			});
			workbook.SheetNames.forEach(function(sheetName) {
				// Here is your object
				var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
				var json_object = JSON.stringify(XL_row_object);
				if (buttonType == "New") {
					jsonArray = JSON.parse(json_object);
					console.log("new.." + jsonArray);

					showJsonArrayTable();
				}
				/* else if(buttonType=="Update"){
					 jsonArrayUpdate  = JSON.parse(json_object);
						console.log("update.."+jsonArrayUpdate);
						updateCommodityData();
				} */

				jQuery('#xlx_json').val(json_object);
			})

			// modify jsonArray 


		};

		reader.onerror = function(ex) {
			console.log(ex);
		};

		reader.readAsBinaryString(file);
	};
};

function handleFileSelectForExcelUpdate(evt) {

	buttonType = "Update";

	jsonArrayUpdate = [];
	var filesUpdate = evt.target.files; // FileList object
	var xl2jsonUpdate = new ExcelToJSON();
	xl2jsonUpdate.parseExcel(filesUpdate[0]);
}

function handleFileSelectForExcel(evt) {
	buttonType = "New";
	var files = evt.target.files; // FileList object
	var xl2json = new ExcelToJSON();
	xl2json.parseExcel(files[0]);
}

function showJsonArrayTable() {

	tabledataExcelUpload.clear();

	for (var i = 0; i < jsonArray.length; i++) {
		tabledataExcelUpload.row.add([jsonArray[i].route,
		jsonArray[i].vendorName,
		jsonArray[i].vendorCode,
		jsonArray[i].type,
		jsonArray[i].city,
		jsonArray[i].cityName,
		jsonArray[i].state,
		jsonArray[i].vehicleType,
		jsonArray[i].tripCost,
		jsonArray[i].rate,
		jsonArray[i].baseRate,
		jsonArray[i].stdMileagePerKm,
		jsonArray[i].maxKms,
		jsonArray[i].currentFuelRate,
		jsonArray[i].fsDiff,
		jsonArray[i].agreementMadeDate,
		jsonArray[i].agreementExpiryDate]);
	}

	tabledataExcelUpload.draw();
	$("tbody").show();


	$("#excelUploadModal").modal('show');
}

$("#excelUploadSaveBtn").click(function() {

	if (jsonArray.length == 0) {

		Toast.fire({
			type: 'warning',
			title: 'No Data in Excel Sheet'
		})

		return;
	}

	$('.loader').show();

	$("#excelUploadSaveBtn").prop("disabled", true);
	$.ajax({
		type: "POST",
		data: JSON.stringify(jsonArray),
		url: "masterController/saveAgreementList",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",

		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {

				Toast.fire({
					type: 'success',
					title: 'Successfull..'
				})

				$("#excelUploadModal").modal('hide');

				$("#projectsList").prop("disabled", false);
				$("#sitesList").prop("disabled", false);
				$("#categoryList").prop("disabled", false);
				$("#subCategoryList").prop("disabled", false);
				showUploadedFilesData();
				$("#addForm")[0].reset();
				arrayAttachment = [];
				jsonArray = [];
				getTableData();
				$("#submitBtn").prop("disabled", false);
				getData();
			} else {
				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}

		},
		error: function(jqXHR, textStatue, errorThrown) {
			$('.loader').hide();
			$("#excelUploadSaveBtn").prop("disabled", false);

			alert("failed, please try again");
		}

	});
	
	})
	
	$('#tabledata tbody').on('click', ".tridlttable", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	inactiveActiveDeleteData(row.cells[0].innerText);
});	
$('#tabledata tbody').on('click', ".triedttable", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	editData(row.cells[0].innerText);
});	

