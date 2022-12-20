var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$("#pendingRequest").bind("click", function() {
	pendingRequest();
});

$("#approvedRequest").bind("click", function() {
	approvedRequest();
});

$("#rejectedRequest").bind("click", function() {
	rejectedRequest();
});

$("#queryRequest").bind("click", function() {
	queryRequest();
});

$("#updateBtnBtn").bind("click", function() {
	approveInvoice();
});

$('#tabledata tbody').on('click', ".onClickReg", function() {
	;
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setVenRegStatus((row.cells[0].innerText), "Approved Vendor");
});


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
	document.getElementById("lastInvoice").innerHTML = "Pending Request";
	document.getElementById("allRequest").style.display = "block";
	$.ajax({
		type: "POST",
		data: "",
		url: "registrationController/getPendingRequest",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" class=\"clickPid\"  >" + result[i][0] + "</button>";
					tabledata.row.add([
						view,
						result[i][1],
						result[i][2],
						result[i][3],
						result[i][4],
						result[i][5]]);
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

$('#tabledata tbody').on('click', ".clickPid", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setVenRegStatus(row.cells[0].innerText, 'Pending Vendor');
});

function approvedRequest() {
	$('.loader').show();
debugger
	document.getElementById("lastInvoice").innerHTML = "Approved Request";
	document.getElementById("allRequest").style.display = "block";
	$.ajax({
		type: "POST",
		data: "",
		url: "registrationController/getApprovedRequest",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" class=\"onClickReg\"  >" + result[i].pid + "</button>";
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

$('#tabledata tbody').on('click', ".onClickReg", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setVenRegStatus(row.cells[0].innerText, 'Approved Vendor');
});

function rejectedRequest() {
	$('.loader').show();
	document.getElementById("lastInvoice").innerHTML = "Rejected Request";
	document.getElementById("allRequest").style.display = "block";
	$.ajax({
		type: "POST",
		data: "",
		url: "registrationController/getRejectedRequest",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" class=\"rejectRequest\" >" + result[i][0] + "</button>";
					tabledata.row.add([
						view,
						result[i][1],
						result[i][2],
						result[i][3],
						result[i][4],
						result[i][5]]);
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

$('#tabledata tbody').on('click', ".rejectRequest", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setVenRegStatus(row.cells[0].innerText, 'Rejected Vendor');
});

function queryRequest() {
	$('.loader').show();
	document.getElementById("lastInvoice").innerHTML = "Query";
	document.getElementById("allRequest").style.display = "block";
	$.ajax({
		type: "POST",
		data: "",
		url: "registrationController/getQueryRequest",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" class=\"queryRequest\" >" + result[i][0] + "</button>";
					tabledata.row.add([
						view,
						result[i][1],
						result[i][2],
						result[i][3],
						result[i][4],
						result[i][5]]);
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

$('#tabledata tbody').on('click', ".queryRequest", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	setVenRegStatus(row.cells[0].innerText, 'Query Vendor');
});

function setVenRegStatus(pid, status) {
	$('.loader').show();
	var urlOftripsDetail = "vendorView?pid=" + btoa(pid) + "&status=" + btoa(status);
	window.open(urlOftripsDetail, "vendorView", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	$('.loader').hide();
}

function refereshList() {
	pendingRequest();
	location.reload();
	$('.loader').hide();
}