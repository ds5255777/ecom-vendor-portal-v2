var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});


$("#searchVendorByDate").bind("click", function() {
	getFilterData();
});
var currentDate = '${currentDate}';
var dataLimit = '${dataLimit}';
dataLimit = parseInt(dataLimit);

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
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61],
			}
		}, {
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61],
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
		}],
	initComplete: function() {
		var $buttons = $('.dt-buttons').hide();
		$('#exportLink').on('click', function() {
			var btnClass = "excel" ? '.buttons-' + "excel" : null;
			if (btnClass)
				$buttons.find(btnClass).click();
		})

		$('#exportLinkPdf').on('click', function() {
			var btnClass = "pdf" ? '.buttons-' + "pdf" : null;
			if (btnClass)
				$buttons.find(btnClass).click();
		})
	}
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
		url: "registrationController/getAllApprovedVendor",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					for (var j = 0; j < result[i].addressDetails.length; j++) {
						if (!result[i].hasOwnProperty("bpCode")) {
							result[i].bpCode = "";
						}
						if (!result[i].hasOwnProperty("suppName")) {
							result[i].suppName = "";
						}
						if (!result[i].hasOwnProperty("createDate")) {
							result[i].createDate = "";
						}
						if (!result[i].addressDetails[j].hasOwnProperty("supplierSiteCode")) {
							result[i].addressDetails[j].supplierSiteCode = "";
						}
						if (!result[i].addressDetails[j].hasOwnProperty("addDetails")) {
							result[i].addressDetails[j].addDetails = "";
						}
						if (!result[i].addressDetails[j].hasOwnProperty("city")) {
							result[i].addressDetails[j].city = "";
						}
						if (!result[i].addressDetails[j].hasOwnProperty("state")) {
							result[i].addressDetails[j].state = "";
						}
						if (!result[i].addressDetails[j].hasOwnProperty("pinCode")) {
							result[i].addressDetails[j].pinCode = "";
						}
						if (!result[i].contactDetails[0].hasOwnProperty("conPhone")) {
							result[i].contactDetails[0].conPhone = "";
						}
						if (!result[i].contactDetails[0].hasOwnProperty("conEmail")) {
							result[i].contactDetails[0].conEmail = "";
						}
						if (!result[i].contactDetails[0].hasOwnProperty("conFname")) {
							result[i].contactDetails[0].conFname = "";
						}
						if (!result[i].contactDetails[0].hasOwnProperty("conLname")) {
							result[i].contactDetails[0].conLname = "";
						}
						if (!result[i].hasOwnProperty("panNumber")) {
							result[i].panNumber = "";
						}
						if (!result[i].hasOwnProperty("tanNumber")) {
							result[i].tanNumber = "";
						}
						if (!result[i].accountDetails[0].hasOwnProperty("bankName")) {
							result[i].accountDetails[0].bankName = "";
						}
						if (!result[i].accountDetails[0].hasOwnProperty("ifscCode")) {
							result[i].accountDetails[0].ifscCode = "";
						}
						if (!result[i].accountDetails[0].hasOwnProperty("accoutCurrency")) {
							result[i].accountDetails[0].accoutCurrency = "";
						}
						if (!result[i].accountDetails[0].hasOwnProperty("beneficiaryName")) {
							result[i].accountDetails[0].beneficiaryName = "";
						}
						if (!result[i].accountDetails[0].hasOwnProperty("accoutNumber")) {
							result[i].accountDetails[0].accoutNumber = "";
						}
						if (!result[i].hasOwnProperty("sro")) {
							result[i].sro = "";
						}
						if (!result[i].hasOwnProperty("wro")) {
							result[i].wro = "";
						}
						if (!result[i].hasOwnProperty("nro")) {
							result[i].nro = "";
						}
						if (!result[i].hasOwnProperty("ero")) {
							result[i].ero = "";
						}
						if (!result[i].hasOwnProperty("dhq")) {
							result[i].dhq = "";
						}
						if (!result[i].hasOwnProperty("sectionType")) {
							result[i].sectionType = "";
						}
						if (!result[i].hasOwnProperty("creditTerms")) {
							result[i].creditTerms = "";
						}
						if (!result[i].hasOwnProperty("businessClassification")) {
							result[i].businessClassification = "";
						}
						if (!result[i].hasOwnProperty("mesmeNumber")) {
							result[i].mesmeNumber = "";
						}
						if (!result[i].hasOwnProperty("aadharNumber")) {
							result[i].aadharNumber = "";
						}
						if (!result[i].hasOwnProperty("adharLinkStatus")) {
							result[i].adharLinkStatus = "";
						}
						if (!result[i].hasOwnProperty("acknowledgementNumber1")) {
							result[i].acknowledgementNumber1 = "";
						}
						if (!result[i].hasOwnProperty("acknowledgementNumber2")) {
							result[i].acknowledgementNumber2 = "";
						}
						if (!result[i].hasOwnProperty("acknowledgementNumber3")) {
							result[i].acknowledgementNumber3 = "";
						}
						var paymentMethod = result[i].paymentMethod;

						if (paymentMethod == "NEFT") {
							paymentMethod = "EFT";
						} else if (paymentMethod == "ONLINE") {
							paymentMethod = result[i].paymentMethod;
						}



						tabledata.row.add([
							result[i].bpCode,
							result[i].suppName,
							moment(result[i].createDate, "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD"),
							result[i].addressDetails[j].supplierSiteCode,
							result[i].addressDetails[j].addDetails,
							"",
							"",
							"",
							result[i].addressDetails[j].city,
							result[i].addressDetails[j].state,
							result[i].addressDetails[j].pinCode,
							"IN",
							"",
							result[i].contactDetails[0].conPhone,
							result[i].contactDetails[0].conEmail,
							result[i].panNumber,
							result[i].tanNumber,
							"",
							"",
							"",
							"",
							result[i].accountDetails[0].bankName,
							"",
							"BANK",
							"IN",
							result[i].accountDetails[0].ifscCode,
							result[i].accountDetails[0].ifscCode,
							result[i].accountDetails[0].accoutCurrency,
							result[i].accountDetails[0].beneficiaryName,
							"`" + result[i].accountDetails[0].accoutNumber,
							result[i].accountDetails[0].ifscCode,
							"",
							result[i].contactDetails[0].conFname + " " + result[i].contactDetails[0].conLname,
							result[i].accountDetails[0].beneficiaryName,
							result[i].accountDetails[0].beneficiaryName,
							result[i].sro,
							result[i].wro,
							result[i].nro,
							result[i].ero,
							result[i].dhq,
							result[i].sectionType + "-IND",
							"",
							result[i].sectionType + "-IND",
							result[i].addressDetails[j].vendorType,
							result[i].addressDetails[j].glCode,
							result[i].addressDetails[j].compGstn,
							"",
							"",
							"",
							"Y",
							"Y",
							"",
							"Y",
							"",
							paymentMethod,
							result[i].creditTerms,
							result[i].businessClassification,
							result[i].mesmeNumber,
							result[i].aadharNumber,
							result[i].adharLinkStatus,
							result[i].acknowledgementNumber1,
							result[i].acknowledgementNumber2,
							result[i].acknowledgementNumber3
						]);
					}
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

function getFilterData() {

	var fromDate = $("#fromDate").val();
	var toDate = $("#toDate").val();

	fromDate = moment(fromDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
	toDate = moment(toDate, 'DD-MM-YYYY').format('YYYY-MM-DD');


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
				"startDate": fromDate,
				"endDate": toDate
			},
			url: "registrationController/filterVendorDetails",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",

			success: function(data) {

				$('.loader').hide();
				if (data.msg == 'success') {

					var result = data.data;
					tabledata.clear();

					for (var i = 0; i < result.length; i++) {
						for (var j = 0; j < result[i].addressDetails.length; j++) {
							if (!result[i].hasOwnProperty("bpCode")) {
								result[i].bpCode = "";
							}
							if (!result[i].hasOwnProperty("suppName")) {
								result[i].suppName = "";
							}
							if (!result[i].hasOwnProperty("createDate")) {
								result[i].createDate = "";
							}
							if (!result[i].addressDetails[j].hasOwnProperty("supplierSiteCode")) {
								result[i].addressDetails[j].supplierSiteCode = "";
							}
							if (!result[i].addressDetails[j].hasOwnProperty("addDetails")) {
								result[i].addressDetails[j].addDetails = "";
							}
							if (!result[i].addressDetails[j].hasOwnProperty("city")) {
								result[i].addressDetails[j].city = "";
							}
							if (!result[i].addressDetails[j].hasOwnProperty("state")) {
								result[i].addressDetails[j].state = "";
							}
							if (!result[i].addressDetails[j].hasOwnProperty("pinCode")) {
								result[i].addressDetails[j].pinCode = "";
							}
							if (!result[i].contactDetails[0].hasOwnProperty("conPhone")) {
								result[i].contactDetails[0].conPhone = "";
							}
							if (!result[i].contactDetails[0].hasOwnProperty("conEmail")) {
								result[i].contactDetails[0].conEmail = "";
							}
							if (!result[i].contactDetails[0].hasOwnProperty("conFname")) {
								result[i].contactDetails[0].conFname = "";
							}
							if (!result[i].contactDetails[0].hasOwnProperty("conLname")) {
								result[i].contactDetails[0].conLname = "";
							}
							if (!result[i].hasOwnProperty("panNumber")) {
								result[i].panNumber = "";
							}
							if (!result[i].hasOwnProperty("tanNumber")) {
								result[i].tanNumber = "";
							}
							if (!result[i].accountDetails[0].hasOwnProperty("bankName")) {
								result[i].accountDetails[0].bankName = "";
							}
							if (!result[i].accountDetails[0].hasOwnProperty("ifscCode")) {
								result[i].accountDetails[0].ifscCode = "";
							}
							if (!result[i].accountDetails[0].hasOwnProperty("accoutCurrency")) {
								result[i].accountDetails[0].accoutCurrency = "";
							}
							if (!result[i].accountDetails[0].hasOwnProperty("beneficiaryName")) {
								result[i].accountDetails[0].beneficiaryName = "";
							}
							if (!result[i].accountDetails[0].hasOwnProperty("accoutNumber")) {
								result[i].accountDetails[0].accoutNumber = "";
							}
							if (!result[i].hasOwnProperty("sro")) {
								result[i].sro = "";
							}
							if (!result[i].hasOwnProperty("wro")) {
								result[i].wro = "";
							}
							if (!result[i].hasOwnProperty("nro")) {
								result[i].nro = "";
							}
							if (!result[i].hasOwnProperty("ero")) {
								result[i].ero = "";
							}
							if (!result[i].hasOwnProperty("dhq")) {
								result[i].dhq = "";
							}
							if (!result[i].hasOwnProperty("sectionType")) {
								result[i].sectionType = "";
							}
							if (!result[i].hasOwnProperty("creditTerms")) {
								result[i].creditTerms = "";
							}
							if (!result[i].hasOwnProperty("businessClassification")) {
								result[i].businessClassification = "";
							}
							if (!result[i].hasOwnProperty("mesmeNumber")) {
								result[i].mesmeNumber = "";
							}
							if (!result[i].hasOwnProperty("aadharNumber")) {
								result[i].aadharNumber = "";
							}
							if (!result[i].hasOwnProperty("adharLinkStatus")) {
								result[i].adharLinkStatus = "";
							}
							if (!result[i].hasOwnProperty("acknowledgementNumber1")) {
								result[i].acknowledgementNumber1 = "";
							}
							if (!result[i].hasOwnProperty("acknowledgementNumber2")) {
								result[i].acknowledgementNumber2 = "";
							}
							if (!result[i].hasOwnProperty("acknowledgementNumber3")) {
								result[i].acknowledgementNumber3 = "";
							}
							var paymentMethod = result[i].paymentMethod;

							if (paymentMethod == "NEFT") {
								paymentMethod = "EFT";
							} else if (paymentMethod == "ONLINE") {
								paymentMethod = result[i].paymentMethod;
							}



							tabledata.row.add([
								result[i].bpCode,
								result[i].suppName,
								moment(result[i].createDate, "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD"),
								result[i].addressDetails[j].supplierSiteCode,
								result[i].addressDetails[j].addDetails,
								"",
								"",
								"",
								result[i].addressDetails[j].city,
								result[i].addressDetails[j].state,
								result[i].addressDetails[j].pinCode,
								"IN",
								"",
								result[i].contactDetails[0].conPhone,
								result[i].contactDetails[0].conEmail,
								result[i].panNumber,
								result[i].tanNumber,
								"",
								"",
								"",
								"",
								result[i].accountDetails[0].bankName,
								"",
								"BANK",
								"IN",
								result[i].accountDetails[0].ifscCode,
								result[i].accountDetails[0].ifscCode,
								result[i].accountDetails[0].accoutCurrency,
								result[i].accountDetails[0].beneficiaryName,
								"`" + result[i].accountDetails[0].accoutNumber,
								result[i].accountDetails[0].ifscCode,
								"",
								result[i].contactDetails[0].conFname + " " + result[i].contactDetails[0].conLname,
								result[i].accountDetails[0].beneficiaryName,
								result[i].accountDetails[0].beneficiaryName,
								result[i].sro,
								result[i].wro,
								result[i].nro,
								result[i].ero,
								result[i].dhq,
								result[i].sectionType + "-IND",
								"",
								result[i].sectionType + "-IND",
								result[i].addressDetails[j].vendorType,
								result[i].addressDetails[j].glCode,
								result[i].addressDetails[j].compGstn,
								"",
								"",
								"",
								"Y",
								"Y",
								"",
								"Y",
								"",
								paymentMethod,
								result[i].creditTerms,
								result[i].businessClassification,
								result[i].mesmeNumber,
								result[i].aadharNumber,
								result[i].adharLinkStatus,
								result[i].acknowledgementNumber1,
								result[i].acknowledgementNumber2,
								result[i].acknowledgementNumber3
							]);
						}
					}
					tabledata.draw();
					$("tbody").show();
				} else {
					console.log(data);
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

