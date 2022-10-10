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

	var jsArray = [];
	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(jsArray),
		url: "poController/getAllProcessPo",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			$('.loader').hide();
			if (data.msg == 'success') {

				var result = data.data;
				tabledata.clear();
				console.log("result" + result);

				var poLineDetails = result[0].poLineDetails;





				for (var i = 0; i < result.length; i++) {

					if (!result[i].hasOwnProperty("id")) {
						result[i].id = "";
					}
					if (!result[i].hasOwnProperty("poNo")) {
						result[i].poNo = "";
					}
					if (!result[i].hasOwnProperty("type")) {
						result[i].type = "";
					}
					if (!result[i].hasOwnProperty("uom")) {
						result[i].uom = "";
					}
					if (!result[i].hasOwnProperty("quantity")) {
						result[i].quantity = "";
					}
					if (!result[i].hasOwnProperty("needByDate")) {
						result[i].needByDate = "";
					}
					if (!result[i].hasOwnProperty("amount")) {
						result[i].amount = "";
					}
					if (!result[i].hasOwnProperty("status")) {
						result[i].status = "";
					}

					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getPoDataFormDataByPoNumber('" + result[i].poNo + "')\" >" + result[i].poNo + "</button>";

					tabledata.row.add([view, result[i].type, result[i].uom, result[i].quantity, result[i].needByDate, result[i].amount, result[i].status]);
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

function setTripStatus(poNo) {
	console.log("poNo" + poNo);
	var json = {
		"poNo": poNo
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "<%=GlobalUrl.poDetailsByPoNo%>",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				var result = data.data;
				var myForm = "";
				myForm = document.getElementById("tripForm");
				setData(myForm, result);
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

function getPoDataFormDataByPoNumber(id) {
	$('.loader').show();
	var urlOftripsDetail = "PoView?id=" + id;
	window.open(urlOftripsDetail, "PoView", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	$('.loader').hide();
}
