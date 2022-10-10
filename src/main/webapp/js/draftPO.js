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
				columns: [0, 1, 2],
			}
		},
		{
			extend: 'pdfHtml5',
			orientation: 'landscape',
			pageSize: 'A4',
			exportOptions: {
				columns: [0, 1, 2],
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
	var jsArray = [];
	$('.loader').show();
	$.ajax({
		type: "POST",
		data: JSON.stringify(jsArray),
		url: "PoInvoiceContoller/getAllDraftInvoicePO",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					if (!result[i].hasOwnProperty("invoiceNumber")) {
						result[i].invoiceNumber = "";
					}
					if (!result[i].hasOwnProperty("poNumber")) {
						result[i].poNumber = "";
					}
					if (!result[i].hasOwnProperty("vendorCode")) {
						result[i].vendorCode = "";
					}
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getInvoiceDataFormDataByInvoiceNumber('" + result[i].invoiceNumber + "')\" >" + result[i].invoiceNumber + "</button>";
					var action = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"deleteInvoice('" + result[i].id + "','" + result[i].invoiceNumber + "')\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
					tabledata.row.add([view, result[i].poNumber, result[i].vendorCode, action]);
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

function getInvoiceDataFormDataByInvoiceNumber(invoiceNumber) {
	$('.loader').show();
	var urlOftripsDetail = "draftPoInvoiceGenerate?id=" + invoiceNumber;
	window.open(urlOftripsDetail, "draftPoInvoiceGenerate", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	// $('.loader').hide()
	window.location.reload()
}

function deleteInvoice(invoiceID, ecomInvoiceNumber) {

	var invoiceNumber = ecomInvoiceNumber;
	var json = {
		"invoiceNumber": invoiceNumber,
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "<%=GlobalUrl.deleteDraftPoInvoice%>",
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

function refereshList() {
	getData();
}
