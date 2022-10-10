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

function editData(id2) {
	id = "";
	id = id2;
	status = "";

	var json = {

		"id": id2
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "emailConfigurationController/getEmailCofigurationDataById",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				var result = data.data;

				$("#smtpPortEdit").val(result.smtpPort);
				$("#userNameEdit").val(result.userName);
				$("#passwordEdit").val(result.password);
				$("#serverNameEdit").val(result.serverName);


				$("#userModal").modal('show');

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



function addFormData() {
	var json = {

		"serverName": $("#serverName").val(),
		"password": $("#password").val(),
		"userName": $("#userName").val(),
		"smtpPort": $("#smtpPort").val(),
		"isActive": "1"
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "emailConfigurationController/saveUpdateEmailData",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				$('#addForm')[0].reset();

				Toast.fire({
					type: 'success',
					title: 'Saved Successfully..'
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

function updateFormData() {
	var json = {
		"id": id,
		"serverName": $("#serverNameEdit").val(),
		"password": $("#passwordEdit").val(),
		"userName": $("#userNameEdit").val(),
		"smtpPort": $("#smtpPortEdit").val(),
		"isActive": "1"
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "emailConfigurationController/saveUpdateEmailData",
		dataType: "json", headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				Toast.fire({
					type: 'success',
					title: 'Updated Successfully..'
				})
				$("#userModal").modal('hide');

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
		url: "emailConfigurationController/getEmailCofigurationDataByStatus",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					if (!result[i].hasOwnProperty("userName")) {
						result[i].userName = "";
					}
					if (!result[i].hasOwnProperty("serverName")) {
						result[i].serverName = "";
					}
					if (!result[i].hasOwnProperty("smtpPort")) {
						result[i].smtpPort = "";
					}
					if (!result[i].hasOwnProperty("id")) {
						result[i].id = "";
					}
					var inactive = "<button type=\"button\"  class=\"trashButton btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" value=\"" + result[i].id + "\" > <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
					var edit = "<button type=\"button\"  class=\"editEmailData btn btn-primary btn-xs \" data-placement=\"bottom\"   data-original-title=\"Click To Edit\" style=\"width: 43px;\" value=\"" + result[i].id + "\"  ><i class=\"nav-icon fas fa-edit\"> </i> </button>";

					tabledata.row.add([result[i].userName, result[i].serverName, result[i].smtpPort, edit, inactive]);
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

$('#tabledata tbody').on('click', ".trashButton", function() {
	inactiveActiveDeleteData(this.value);
});

$('#tabledata tbody').on('click', ".editEmailData", function() {
	editData(this.value);
});


function inactiveActiveDeleteData(id) {

	var json = {
		"id": id,
		"isActive": "0"
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
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

