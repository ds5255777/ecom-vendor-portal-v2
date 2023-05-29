var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

var pageContext = $("#pageContext").val();


const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});
var tabledata = $('#tabledata').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": true,
	"info": true,
	"scrollX": true,
	"autoWidth": false,
	"aaSorting": [],
	 dom: 'Bfrtip',
        buttons: [
            'csv', 'excel'
        ]
});

$('#searchData').on('keyup', function() {
	tabledata.search(this.value).draw();
});

$('#tabledata_filter').css("display", "none");


var globalProcessId = "";

pendingRequest();
function pendingRequest() {
	$('.loader').show();
	$.ajax({
		type: "POST",
		data: "",
		url: "registrationController/getAllRequest",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" class=\"viewonboard\"  >" + result[i].pid + "</button>";

					if (!result[i].hasOwnProperty("bpCode")) {
						result[i].bpCode = "";
					}
					if (!result[i].hasOwnProperty("introducedByName")) {
						result[i].introducedByName = "";
					}
					if (!result[i].hasOwnProperty("suppName")) {
						result[i].suppName = "";
					}
					if (!result[i].hasOwnProperty("vendorType")) {
						result[i].vendorType = "";
					}
					if (!result[i].hasOwnProperty("createDate")) {
						result[i].createDate = "";
					}
					
					if (!result[i].hasOwnProperty("venStatus")) {
						result[i].venStatus = "";
					}
					if (!result[i].hasOwnProperty("processedOn")) {
						result[i].processedOn = "";
					}
					if (!result[i].hasOwnProperty("processedBy")) {
						result[i].processedBy = "";
					}
					
					var download = "<a href=\"#\" data-toggle=\"modal\"  tittle=\"In-Active Vendor\" data-target=\"#vendorValue\" class=\"downladZipFile\" > <i class=\"fas fa-file-export\"></i>  </a>";


					tabledata.row.add([
						view,
						result[i].bpCode,
						result[i].introducedByEmailID,
						result[i].introducedByName,
						result[i].suppName,
						result[i].vendorType,
						result[i].createDate,
						result[i].venStatus,
						result[i].processedOn,
						result[i].processedBy,
						download]);
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

$('#tabledata tbody').on('click', ".downladZipFile", function() {
	var row = $(this).parents('tr')[0];
	console.log(row.cells[1].innerText);
	//console.log(tabledata.row(row).data().id);
	downladZipFile(row.cells[1].innerText);
});

function downladZipFile(vendorCode) {

	console.log(pageContext+'/downloadZip?vendorCode=' + vendorCode);

	$('.loader').show();
	$('#pdfLink').attr('src', pageContext+'/downloadZip?vendorCode=' + vendorCode);
	$('.loader').hide();

}

function setVenRegStatus(pid) {
	globalProcessId = "";
	globalProcessId = pid;
	console.log(globalProcessId);
}

function setVenRegStatus(pid, status) {
	$('.loader').show();
	var urlOftripsDetail = "vendorView?pid=" + btoa(pid) + "&status=" + btoa(status);
	window.open(urlOftripsDetail, "vendorView", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	$('.loader').hide();
}

$('#tabledata tbody').on('click', ".viewonboard", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setVenRegStatus((row.cells[0].innerText), "Vendor View");
});


