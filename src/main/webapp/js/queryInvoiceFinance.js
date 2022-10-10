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

$('#tabledata_filter').css("display", "none");

getData();
function getData() {
	$('.loader').show();
	$.ajax({
		type: "POST",
		data: "",
		url: "financeController/viewAllQueryInvoiceForFinanceTeam",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {

			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					if (!result[i].hasOwnProperty("invoiceNumber")) {
						result[i].invoiceNumber = "";
					}
					if (!result[i].hasOwnProperty("invoiceDate")) {
						result[i].invoiceDate = "";
					}
					if (!result[i].hasOwnProperty("invoiceAmount")) {
						result[i].invoiceAmount = "";
					}
					if (!result[i].hasOwnProperty("invoiceReceivingDate")) {
						result[i].vehicleNumber = "";
					}
					if (!result[i].hasOwnProperty("invoiceStatus")) {
						result[i].invoiceStatus = "";
					}
					if (!result[i].hasOwnProperty("ecomInvoiceNumber")) {
						result[i].invoiceStatus = "";
					}
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" class=\"viewInvoice\" value=\"" + result[i].ecomInvoiceNumber + "\" >" + result[i].ecomInvoiceNumber + "</button>";

					tabledata.row.add([view, result[i].invoiceNumber, result[i].vendorCode, result[i].vendorName, result[i].invoiceReceivingDate, result[i].invoiceDate, result[i].invoiceAmount, result[i].invoiceStatus]);
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
			alert("failed, please try again leter");
		}
	});
}




$('#tabledata tbody').on('click', ".viewInvoice", function() {
	var row = $(this).parents('tr')[0];
	getInvoiceDataFormDataByInvoiceNumber(row.cells[0].innerText,'Query Invoice');
});

function getInvoiceDataFormDataByInvoiceNumber(id, type) {
	$('.loader').show();

	var urlOftripsDetail = "invoiceViewFinance?id=" + id + "&type=" + type;
	window.open(urlOftripsDetail, "invoiceViewFinance", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	$('.loader').hide();
}

function refereshList() {
	getData();
}
