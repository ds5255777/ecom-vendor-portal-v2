var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$(document).ready(function() {
	if ('${userStatus}' === 3) {
		$('#changePassword').modal('show');
	}
});

var dataLimit = '${dataLimit}';
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
		//  $("#divCheckPasswordMatch").html(password == $(this).val() ? "Passwords match." : "Passwords do not match!");
	});
});

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

var tabledata = $('#tabledata').DataTable({
	"paging": true,
	"lengthChange": false,
	"searching": false,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"pageLength": 50
});

var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
var unresolvedstsData = {
	labels: [
		'All PO',
		'Unprocessed PO',
		'Processed PO',
		'Draft Invoices',
		'Query'

	],//#FF0000(red),00a65a(inactive)
	datasets: [{
		data: ['${allPOcount}', '${totalUnprocessPOCount}', '${totalProcessPoCount}', '${totalDraftInvoiceCount}', '${totalQueryCount}'],
		backgroundColor: ['#FAA654', 'chocolate', '#28a745', '#dc3545', '#fd7e14'],
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

	var id = "";
	var obj = {
		"id": id
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "poController/getAllUnProcessPo",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				var result = data.data;
				tabledata.clear();

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


					tabledata.row.add([result[i].poNo, result[i].type, result[i].uom, result[i].quantity, result[i].needByDate, result[i].amount]);
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
			alert("failed, please try again letter1");
		}
	});
}

function changePassword(password) {
	console.log(document.getElementById('password').value);
	console.log("my password " + "<%=GlobalUrl.changePassword%>" + "?password=" + password);


	$.ajax({
		type: "POST",
		data: "",
		url: "<%=GlobalUrl.changePassword%>" + "?password=" + password,
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,

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

