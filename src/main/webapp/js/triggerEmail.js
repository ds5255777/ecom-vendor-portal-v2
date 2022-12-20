var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


function myFunction() {
	document.getElementById("myDropdown").classList.toggle("show");
}

function filterFunction() {
	var input, filter, ul, li, a, i;
	input = document.getElementById("myInput");
	filter = input.value.toUpperCase();
	div = document.getElementById("myDropdown");
	a = div.getElementsByTagName("a");
	for (i = 0; i < a.length; i++) {
		txtValue = a[i].textContent || a[i].innerText;
		if (txtValue.toUpperCase().indexOf(filter) > -1) {
			a[i].style.display = "";
		} else {
			a[i].style.display = "none";
		}
	}
}

var tabledata = $('#tabledata').DataTable({
	"paging": true,
	"lengthChange": false,
	"searching": true,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true
});
$(document).ready(function() {
	$('.js-example-basic-multiple1').select2({
		zplaceholder: "Select Region",
		allowClear: true

	});

});

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});


$.validator.setDefaults({
	submitHandler: function() {
		addFormData();

	}
});
$('#addForm').validate({

	rules: {
		vendorEmail: {
			required: true,
			email: true
		},
		vendorType: {
			required: true

		},
		region: {

			required: true

		},
		creditTerms: {
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
$('#updateForm').validate({

	rules: {
		userName: {
			required: true,
			email: true
		},
		password: {
			required: true

		},
		serverName: {

			required: true

		},
		smtpPort: {
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


var id = "";
var status = "";



function addFormData() {

	var region = $("#region").val().toString();

	var json = {
		"vendorEmail": $("#vendorEmail").val(),
		"vendorType": $("#vendorType").val().toString(),
		"region": region,
		"creditTerms": $("#creditTerms").val()
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "commercialMailController/sendEmailToVendor",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {

				$('#addForm')[0].reset();


				swal.fire("Email sent sucessfully", "", "success", "OK").then(function() {
					$('#region').val("");
					$('#region').trigger('change');
					$('#vendorType').val("");
					$('#vendorType').trigger('change');
				});

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

getData();

function getData() {


	var json = {
		"isActive": "1"
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "commercialMailController/getAllSentEmail",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				var result = data.data;
				tabledata.clear();

				for (var i = 0; i < result.length; i++) {

					if (!result[i].hasOwnProperty("vendorEmail")) {
						result[i].vendorEmail = "";
					}
					if (!result[i].hasOwnProperty("vendorType")) {
						result[i].vendorType = "";
					}
					if (!result[i].hasOwnProperty("region")) {
						result[i].region = "";
					}
					if (!result[i].hasOwnProperty("creditTerms")) {
						result[i].creditTerms = "";
					}
					if (!result[i].hasOwnProperty("processOn")) {
						result[i].processOn = "";
					}
					if (!result[i].hasOwnProperty("processBy")) {
						result[i].processBy = "";
					}


					tabledata.row.add([result[i].vendorEmail, result[i].vendorType, result[i].region, result[i].creditTerms, result[i].processOn, result[i].processBy]);

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


function inactiveActiveDeleteData() {
	$.ajax({
		type: "POST",
		data: "",
		url: "emailConfigurationController/updateEmailConfigurationSatatusByid",
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