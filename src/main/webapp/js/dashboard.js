var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


$(document).ready(function() {
	if ('${ userStatus }' === 3) {
		$('#changePassword').modal('show');
	}
});
var dataLimit = [['${dataLimit}']];
dataLimit = parseInt(dataLimit);

$('#changePassword1').validate({
	rules: {
		password: {
			required: true
		},
		passwordConfirm: {
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
		document.getElementById("passflag").value = "1";

	},
	unhighlight: function(element, errorClass, validClass) {
		$(element).removeClass('is-invalid');
		document.getElementById("passflag").value = "0";
	}
});

$(function() {
	$("#passwordConfirm").keyup(function() {
		var password = $("#password").val();
		var passwordConfirm = $("#passwordConfirm").val();
		var passflag = $("#passflag").val();
		if ($('#password').val() == $('#passwordConfirm').val() && passflag != "1") {
			$('#divCheckPasswordMatch').html('Passwords match.').css('color', 'green');
			// Enable #x	
			$("#changePasswordButton").prop("disabled", false)

		}
		else {
			$('#divCheckPasswordMatch').html('Passwords do not match!').css('color', 'red');
			// Disable #x
			$('#changePasswordButton').attr('disabled', true);
			return;
		}
	});
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
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"pageLength": dataLimit
});
var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
var unresolvedstsData = {
	labels: [
		'In-Transit Trips',
		'Closed Trips',
		'Query Trips'
	],
	datasets: [{
		data: [$("#inTransitCount").val(), $("#closedCount").val(), $("#queryCount").val()],
		backgroundColor: ['#ffc107', '#28a745', '#C422F4'],
	}]
}
var unresolvedstsOptions = {
	maintainAspectRatio: false,
	responsive: true,
}
var unresolvedstsOptionsChart = new Chart(unresolvedsts, {
	type: 'doughnut',
	data: unresolvedstsData,
	options: unresolvedstsOptions
})

getDashBoardInformation();

function getDashBoardInformation() {

	
	$.ajax({
		type: "POST",
		data: "",
		url: "dashboardController/getDashboardDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			if (data.msg == 'success') {
				var result = data.data
				var tripList = data.data.tripList;
				tabledata.clear();
				var count = 0;
				var date = "";
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
					if (!result[i].hasOwnProperty("invoiceStatus")) {
						result[i].invoiceStatus = "";
					}
					if (!result[i].hasOwnProperty("ecomInvoiceNumber")) {
						result[i].invoiceStatus = "";
					}
					if (!result[i].hasOwnProperty("vendorName")) {
						result[i].vendorName = "";
					}
					if (!result[i].hasOwnProperty("vendorCode")) {
						result[i].vendorCode = "";
					}
					date = result[i].invoiceReceivingDate.split(",");

					tabledata.row.add([
						result[i].ecomInvoiceNumber,
						date[0],
						result[i].invoiceNumber,
						result[i].invoiceAmount,
						result[i].invoiceStatus]);
				}
				tabledata.draw();
				$("tbody").show();
			} else {
				Toast.fire({
					type: 'error',
					title: 'Failed..not Load Try Again..'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			alert("failed, please try again letter");
		}
	});
}

function changePassword(password) {

	$.ajax({
		type: "POST",
		data: "",
		url: "<%=GlobalUrl.changePassword%>" + "?password=" + password,
		dataType: "json",
		contentType: "application/json",

		success: function(data) {
			$('.loader').hide();
			$("#changePassword").modal('hide');
			if (data.msg == "success") {
				Swal.fire({
					type: 'success',
					title: 'Password Updated Successfully..'
				})

			} else {
				Swal.fire({
					type: 'error',
					title: 'Try Again...'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			alert("failed, please try again letter");
		}
	});

}
