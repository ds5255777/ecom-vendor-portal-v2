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

var mappingTableArray = [];

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
	"pageLength": 100
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
		firstName: {
			required: true

		},
		lastName: {
			required: true

		},
		emailId: {
			email: true,
			required: true

		},
		contactNo: {
			required: true

		},
		username: {
			required: true

		},
		password: {
			required: true

		},
		roleId: {
			required: true

		},
		licenseType: {
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
		firstName: {
			required: true

		},
		lastName: {
			required: true

		},
		emailId: {
			email: true,
			required: true

		},
		contactNo: {
			required: true

		},

		username: {
			required: true

		},

		roleId: {
			required: true

		},
		licenseTypeEdit: {
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
		url: "userController/getUserById",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			if (data.msg == 'success') {

				var result = data.data;

				$("#roleIdEdit").val(result.roleId);
				$("#usernameEdit").val(result.username);
				$("#contactNoEdit").val(result.contactNo);
				$("#emailIdEdit").val(result.emailId);
				$("#lastNameEdit").val(result.lastName);
				$("#firstNameEdit").val(result.firstName);
				status = result.status;

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

	var usernameCheckStatus = checkForExistingUserName();

	if (usernameCheckStatus == "false") {

		return;
	}

	$("#submitBtn").prop("disabled", true);
	$('.loader').show();

	var json = {

		"roleId": $("#roleId").val(),
		"password": $("#password").val(),
		"username": $("#username").val(),
		"contactNo": $("#contactNo").val(),
		"emailId": $("#emailId").val(),
		"lastName": $("#lastName").val(),
		"firstName": $("#firstName").val(),
		"status": "1",

	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/saveUpdateUserDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				$("#submitBtn").prop("disabled", false);
				$('.loader').hide();
				Toast.fire({
					type: 'success',
					title: 'Submitted Successfully..'
				})
				$("#addForm")[0].reset();

				getData();
			} else {
				$("#submitBtn").prop("disabled", false);
				$('.loader').hide();

				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}

		},
		error: function(jqXHR, textStatue, errorThrown) {
			$("#submitBtn").prop("disabled", false);
			$('.loader').hide();
			alert("failed, please try again");
		}

	});

}

function updateFormData() {

	var json = {
		"id": id,
		"roleId": $("#roleIdEdit").val(),
		"password": $("#passwordEdit").val(),
		"username": $("#usernameEdit").val(),
		"contactNo": $("#contactNoEdit").val(),
		"emailId": $("#emailIdEdit").val(),
		"lastName": $("#lastNameEdit").val(),
		"firstName": $("#firstNameEdit").val(),
		"status": $("#statusEdit").val(),

	}


	$("#updateBtn").prop("disabled", true);
	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/saveUpdateUserDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			$("#updateBtn").prop("disabled", false);
			$('.loader').hide();

			if (data.msg == 'success') {

				Toast.fire({
					type: 'success',
					title: 'Updated Successfully..'
				})
				$("#userModal").modal('hide');
				getData();
			} else {
				$("#updateBtn").prop("disabled", false);
				$('.loader').hide();
				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}

		},
		error: function(jqXHR, textStatue, errorThrown) {
			$("#updateBtn").prop("disabled", false);
			$('.loader').hide();
			alert("failed, please try again");
		}

	});

}

getData();

function getData() {

	$.ajax({
		type: "POST",
		data: "",
		url: "userController/getActiveUsersData",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {

				var lastName = "";
				var result = data.data;
				tabledata.clear();

				for (var i = 0; i < result.length; i++) {


					if (!result[i].hasOwnProperty("username")) {
						result[i].username = "";
					}
					if (!result[i].hasOwnProperty("firstName")) {
						result[i].firstName = "";
					}
					if (!result[i].hasOwnProperty("lastName")) {
						result[i].lastName = "";
					}
					if (!result[i].hasOwnProperty("emailId")) {
						result[i].emailId = "";
					}
					if (!result[i].hasOwnProperty("contactNo")) {
						result[i].contactNo = "";
					}
					if (!result[i].hasOwnProperty("status")) {
						result[i].status = "";
					}
					if (!result[i].hasOwnProperty("id")) {
						result[i].id = "";
					}


					var inactive = "<button type=\"button\"  class=\"trashButton btn btn-primary btn-xs \" value=\"" + result[i].id + "," + result[i].username + "\" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" > <i class=\"nav-icon fas fa-trash\"> </i>  </button>";

					var edit = "<button type=\"button\"  class=\"editDataById btn btn-primary btn-xs \" value=\"" + result[i].id + "\" data-placement=\"bottom\"   data-original-title=\"Click To Edit\" style=\"width: 43px;\" ><i class=\"nav-icon fas fa-edit\"> </i> </button>";
					lastName = "";
					if (result[i].hasOwnProperty("lastName")) {
						lastName = result[i].lastName;
					}
					var status = "";
					if (result[i].status == 1) {
						status = "Active";
					} else if (result[i].status == 0) {
						status = "In-Active";
					}
					tabledata.row.add([result[i].username, result[i].firstName, lastName, result[i].rolesObj.roleName, result[i].emailId, result[i].contactNo, status, edit + " " + inactive]);

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

	var valueOfTrash = this.value;
	const listOfVal = valueOfTrash.split(",");
	inactiveActiveDeleteData(listOfVal[0],listOfVal[1]);
});

$('#tabledata tbody').on('click', ".editDataById", function() {

	editData(this.value);
});


function inactiveActiveDeleteData(userid, name) {
	var uname = $("#uname").val();
	if (uname === name) {
		swal.fire("Alert", "Can not delete current user ! ", "warning");
		return false;

	}
	let text = "Are You sure to delete " + name;
	if (confirm(text) != true) {


		return false;
	}



	var json = {
		"id": userid,
		"status": "0"
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/setStatusOfUserById",
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

$("#username").focusout(function() {

	checkForExistingUserName();

});


function checkForExistingUserName() {

	var usernameCheckStatus = "false";

	if ($("#username").val() != "") {

		var json = {
			"username": $("#username").val(),

		}
		$.ajax({
			type: "POST",
			data: JSON.stringify(json),
			url: "userController/checkForExistingUserName",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",
			async: false,
			success: function(data) {

				if (data.msg == 'exist') {

					Toast.fire({
						type: 'warning',
						title: 'UserName Already Exists..'
					})

					$("#username").val('');

				} else if (data.msg == 'success') {
					usernameCheckStatus = "true";
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

	return usernameCheckStatus;
}
