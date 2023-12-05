var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

var globalRegionId="";
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

$('#verifierName').on('input', function(event) {
	this.value = this.value.replace(/[^\w\s]/, '');
});

$('#emailId').on('input', function(event) {
	this.value = this.value.replace(/[^@\w\s.]/, '');
});

var mappingTableArray = [];

var dataLimit = '${dataLimit}';
dataLimit = parseInt(dataLimit);

/*$("#submitBtn").click(function() {

	editData();

});
*/

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



/*$('#tabledata tbody').on('click', ".editmodal", function() {
	debugger
	var row = $(this).parents('tr')[0];
	$("#userModal").modal('show');

});*/


var idUpdate="";
$('#tabledata tbody').on('click', '.editmodal', function() {
	
  var row = $(this).closest('tr');
  var verifierName = row.find('td:eq(1)').text();
  var emailId = row.find('td:eq(2)').text();
  
var commaSeparatedValue=this.value;
idUpdate=commaSeparatedValue.split(",")[0]; 
globalRegionId=commaSeparatedValue.split(",")[1];

  // Set values in the modal inputs
  $('#verifierEdit').val(verifierName);
  $('#emailEdit').val(emailId);
  $('#regionNameEdit').val(globalRegionId);

  // Show the modal
  $("#userModal").modal('show');
});


$('#tabledata tbody').on('click', '.dltWithoutRefernce', function() {
	
  var id = this.value;
  deleteFunction(this.value);

});

function  deleteFunction(id){

	var deleteId=id;
	var json={
	"id":deleteId	
	}
	$.ajax({
        type: "Put",
        data: "",
        url: "verifier/deleteVerifier/"+id,
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

	/*if (confirm("Are you sure to delete it!") == true) {
		var row = $(this).parents('tr')[0];
		deletData(this.value);
	}*/





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
		verifierName: {
			required: true

		},
		emailId: {
			required: true,
			email:true

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

$.validator.setDefaults({
	submitHandler: function() {
		updateFormData();
	}
});
$('#updateForm').validate({

	rules: {
		verifierName: {
			required: true

		},
		emailId: {
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

function validateEmail(email) {
  var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i;
  return emailRegex.test(email);
}


function editData() {
		
	emailId = $("#emailId").val();
	verifierName = $("#verifierName").val();
	regionId= $("#regionName").val();
	
	
	if($("#emailId").val().trim()=="")
	{
		Toast.fire({
			type: 'error',
			title: 'Fill verifier email id'
		});
		return ;
	}
	if($("#verifierName").val().trim()=="")
	{
		Toast.fire({
			type: 'error',
			title: 'Fill verifier name'
		});
		return ;
	}
	if (!validateEmail(emailId)) {
    Toast.fire({
      type: 'error',
      title: 'Please enter a valid email address.'
    });
    return;
  }
	

	status = "";
	var json = {


		"emailId": emailId,
		"verifierName": verifierName,
		"regionId": regionId,
		"regionName":$('#regionName option:selected').text()
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "verifier/createVerifier",
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

$('#verifierEdit').on('input', function(event) {
	this.value = this.value.replace(/[^\w\s]/, '');
});

$('#emailEdit').on('input', function(event) {
	this.value = this.value.replace(/[^@\w\s.]/, '');
});

  function validateEmail(email) {
  var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i;
  return emailRegex.test(email);
}

function updateFormData() {
	
var emailEdit = $("#emailEdit").val();



	var json = {
		"id": idUpdate,
		"verifierName": $("#verifierEdit").val(),
		"emailId": $("#emailEdit").val(),
		"regionId": $("#regionNameEdit").val(),
		"regionName":$('#regionNameEdit option:selected').text()

	}
	
		


	$("#updateBtn").prop("disabled", false);
	/*$('.loader').show();*/
	
	if($("#verifierEdit").val().trim()=="")
	{
		Toast.fire({
			type: 'error',
			title: 'Fill verifier name'
		});
		return ;
	}
	
	if($("#emailEdit").val().trim()=="")
	{
		Toast.fire({
			type: 'error',
			title: 'Fill verifier email id'
		});
		return ;
	}
	
	if (!validateEmail(emailEdit)) {
    Toast.fire({
      type: 'error',
      title: 'Please enter a valid email address.'
    });
    return;
  }
  

	
	
	
	$.ajax({
		type: "PUT",
		data: JSON.stringify(json),
		url: "verifier/updateVerifier",
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
		url: "verifier/listOfAllVerifiers",
		contentType: "application/json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		success: function(data) {
			var result = [];

			if (data.msg == 'success') {
				result = data.data;


				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					var count=1;
/*				var edit = "<button type=\"button\"   class=\"editmodal btn btn-primary btn-xs \" data-placement=\"bottom\" value=\"" + result[i].id + "\"   data-original-title=\"Click To Edit\" style=\"width: 43px; \"><i class=\"fa fa-edit\"> </i> </button>";
*/				
					var edit = "<button type=\"button\" class=\"editmodal btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result[i].id+","+result[i].regionId + "\"  data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-edit\"></i></button>";

					var delet = "<button type=\"button\"   class=\"dltWithoutRefernce btn btn-primary btn-xs \" data-placement=\"bottom\" value=\"" + result[i].id + "\"   data-original-title=\"Click To Edit\" style=\"width: 43px; \"><i class=\"fa fa-trash\"> </i> </button>";

					tabledata.row.add([

						count+i,
						result[i].verifierName,
						result[i].emailId,
						result[i].regionName,
						edit,
						delet

					]
					);

				}tabledata.draw();
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

getRegionList();
function getRegionList(){
	
}

function getRegionList() {
	
	 $('#regionName').empty();
	  $('#regionNameEdit').empty();
  $.ajax({
    url: 'region/listOfAllRegions',
    type: 'GET',
    dataType: 'json',
    success: function(response) {
      if (response.msg === 'success') {
         var regionData = response.data;
         
        
  for (var i = 0; i < regionData.length; i++) {
   
    $('#regionName').append($('<option/>').attr("value", regionData[i].id).text(regionData[i].regionName));
    $('#regionNameEdit').append($('<option/>').attr("value", regionData[i].id).text(regionData[i].regionName));
  
  }
        } else {
          console.log("not find");
          // Continue with your code logic for when verification is not required
        }
     
    },
    error: function(xhr, status, error) {
      console.error(error); // Handle the error appropriately
    }
  });
}





/*function getData() {
	var varifierName = $("#varifierName").val();


	$.ajax({
		type: "GET",
		data: "",
		url: "verifier/getVerifier?id=" + varifierName,
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
			}
			else {
				alert("Failed");
			}



			function getDataByStatus() {
				var status = $("#status").val();


				$.ajax({
					type: "GET",
					data: "",
					url: "verifier/verifiers/status?status=" + status,
					dataType: "json",
					headers: { 'X-XSRF-TOKEN': csrfToken },
					contentType: "application/json",
					async: false,
					success: function(data) {

						if (data.msg == 'success') {
						}
						else {
							alert("Failed");
						}



						$("#username").focusout(function() {

							checkForExistingUserName();

						});
						}
						});
}*/

