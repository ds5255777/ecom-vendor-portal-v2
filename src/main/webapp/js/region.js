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

$('#regionName').on('input', function(event) {
	this.value = this.value.replace(/[^\w\s]/, '');
});

$('#regionEdit').on('input', function(event) {
	this.value = this.value.replace(/[^\w\s]/, '');
});

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

var idUpdate="";
$('#tabledata tbody').on('click', '.editmodal', function() {
	debugger
  var row = $(this).closest('tr');
  var regionName = row.find('td:eq(0)').text();

idUpdate=this.value

  // Set values in the modal inputs
  $('#regionEdit').val(regionName);

  // Show the modal
  $("#userModal").modal('show');
});

$('#tabledata tbody').on('click', '.dltWithoutRefernce', function() {
	debugger

  var id = this.value;
  deleteFunction(this.value);

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
		regionName: {
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
		regionName: {
			required: true

		},
		

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

$("#submitBtn").click(function() {

	editData();

});

$("#updateBtn").click(function() {

	updateFormData();

});


function editData() {
	debugger
	
	regionName = $("#regionName").val();
	
	if($("#regionName").val().trim()=="")
	{
		Toast.fire({
			type: 'error',
			title: 'Fill region'
		});
		return ;
	}

	status = "";
	var json = {

		"regionName": regionName
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "region/saveRegion",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			if (data.msg == 'success') {

				var result = data.data;
				location.reload();
				/*getData();*/

			/*	$("#verifierName").val(result.verifierName);
				$("#emailId").val(result.emailId);
				status = result.status;

				$("#userModal").modal('show');*/

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

		"regionName": $("#regionName").val(),
		"status": "1",

	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "region/saveRegion",
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
		"id": idUpdate,
		"regionName": $("#regionEdit").val(),
		"status": $("#statusEdit").val(),

	}


	$("#updateBtn").prop("disabled", true);
	$('.loader').show();

	$.ajax({
		type: "Put",
		data: JSON.stringify(json),
		url: "region/updateRegion",
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
	debugger
	$.ajax({
		type: "GET",
		dataType: "json",
		url: "region/listOfAllRegions",
		contentType: "application/json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		success: function(data) {
			var result = [];

			if (data.msg == 'success') {
				result = data.data;


				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					var edit = "<button type=\"button\" class=\"editmodal btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result[i].id + "\" data-id=\"" + result[i].id + "\" data-name=\"" + result[i].verifierName + "\" data-email=\"" + result[i].emailId + "\" data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-edit\"></i></button>";

					var delet = "<button type=\"button\"   class=\"dltWithoutRefernce btn btn-primary btn-xs \" data-placement=\"bottom\" value=\"" + result[i].id + "\"   data-original-title=\"Click To Edit\" style=\"width: 43px; \"><i class=\"fa fa-trash\"> </i> </button>";


					tabledata.row.add([

						
						result[i].regionName,
						edit,
						delet

					]
					);

				}
				tabledata.draw();
				$("table").show();

			}else if (data.msg === 'Data Not Found') {
                Toast.fire({
                    type: 'error',
                    title: 'Data Not Found!'
                });
               
            } 
			
			
			 else {
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

function deleteFunction(id) {
	debugger
    

    $('.loader').show();

    $.ajax({
        type: "DELETE",
        data: "",
        url: "region/deleteRegion/"+id,
        dataType: "json",
        headers: { 'X-XSRF-TOKEN': csrfToken },
        contentType: "application/json",        
        success: function(data) {
            $("#deleteBtn").prop("disabled", false);
            $('.loader').hide();

            if (data.msg === 'success') {
                Toast.fire({
                    type: 'success',
                    title: 'Deleted Successfully..'
                });
                getData();
            } 
            
            
            else {
                Toast.fire({
                    type: 'error',
                    title: 'Failed.. Try Again..'
                });
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            $("#deleteBtn").prop("disabled", false);
            $('.loader').hide();
            alert("Failed, please try again");
        }
    });
}
