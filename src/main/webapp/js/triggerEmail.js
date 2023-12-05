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
	//getData();
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
		ehsVerification: {
			required: true
		},
		thirdPartyVerification: {
			required: true
		},
		creditTerms: {
			required: true
		},
		comments: {
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

/*$('#thirdPartyVerification').on('change', function(event) {
	debugger
	thirdPartyVerification=$("#thirdPartyVerification").val();
	if(thirdPartyVerification=="Yes"){
		getVerfierList();
	}
	
});
*/
$("#thirdPartyVerification").on("click", function() {

	var thirdPartyVerification = $("#thirdPartyVerification").val();
	if (thirdPartyVerification == "Yes") {

		getVerifierList();
	}
	$('#verifierName').empty();
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
	debugger
	$('.loader').show();
	var region = $("#region").val().toString();
	var venEmail = $("#vendorEmail").val();
	var thirdPartyVerification = $("#thirdPartyVerification").val();
	var ehsVerification = $("#ehsVerification").val();
	var comments = $("#comments").val();
	var json = null



	if ($('#verifierName').val() == "") {
		json = {
			"vendorEmail": venEmail,
			"vendorType": $("#vendorType").val().toString(),
			"region": region,
			"creditTerms": $("#creditTerms").val(),
			"thirdPartyVerification": thirdPartyVerification,
			"commercialHead": $('#commercialHead').val(),
			"ehsVerification": ehsVerification,
			"comments": comments


		}
	} else {
		json = {
			"vendorEmail": venEmail,
			"vendorType": $("#vendorType").val().toString(),
			"region": region,
			"creditTerms": $("#creditTerms").val(),
			"thirdPartyVerification": thirdPartyVerification,
			"ehsVerification": ehsVerification,
			"commercialHead": $('#commercialHead').val(),
			"comments": comments,
			"verifierName": $('#verifierName').val()


		}
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "commercialMailController/sendEmailToVendor",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				$('#addForm')[0].reset();
				swal.fire("", "Request Submitted Successfully", "success", "OK").then(function() {
					$('#region').val("");
					$('#region').trigger('change');
					$('#vendorType').val("");
					$('#vendorType').trigger('change');
					$('#thirdPartyVerification').prop("checked", false);
					$('#ehsVerification').prop("checked", false);
					$('#comments').val("");
					
					  location.reload();

				});
				//getData();
			} else {
				Toast.fire({
					type: 'error',
					title: 'Failed.. Try Again..'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			$('.loader').hide();
			alert("failed, please try again");
		}
	});
}
/*

function getData() {
	debugger
	$('.loader').show();
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
		success: function(data) {
			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					tabledata.row.add([
						i + 1,
						result[i][1],
						result[i][2],
						result[i][3],
						result[i][4],
						result[i][6],
						result[i][7],
						result[i][5],
						"--",
						"--",
						"--",
						result[i][11]]);
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
} */

function getVerifierList() {

	$('#verifierName').empty();
	$.ajax({
		url: 'verifier/listOfAllVerifiers',
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			if (response.msg === 'success') {
				var verifierData = response.data;


				for (var i = 0; i < verifierData.length; i++) {

					$('#verifierName').append($('<option/>').attr("value", verifierData[i].verifierName).text(verifierData[i].verifierName));


					// Perform any desired logic with each verifier name
				}
			} else {
				console.log("Third Party Verification not required");
				// Continue with your code logic for when verification is not required
			}

		},
		error: function(xhr, status, error) {
			console.error(error); // Handle the error appropriately
		}
	});
}


$(document).ready(function() {
	getCommercialHead();
});

function getCommercialHead() {

	$.ajax({
		url: 'commercialMailController/getActiveCommercialHeadUser',
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			if (response.msg === 'success') {
				var comHeadData = response.data;
				console.log(comHeadData);
				$("#commercialHead").val(comHeadData.commercialHead);
			} else {
				alert("Failed ");
			}

		},
		error: function(xhr, status, error) {
			console.error(error); // Handle the error appropriately
		}
	});
}



