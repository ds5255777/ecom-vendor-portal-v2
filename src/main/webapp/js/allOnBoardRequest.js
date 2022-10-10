var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});
var tabledata = $('#tabledata').DataTable({
	"paging": false,
	"lengthChange": false,
	"searching": false,
	"info": false,
	"autoWidth": false,
	"aaSorting": []
});

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
					tabledata.row.add([
						view,
						result[i].introducedByEmailID,
						result[i].introducedByName,
						result[i].suppName,
						result[i].vendorType,
						result[i].venStatus]);
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


