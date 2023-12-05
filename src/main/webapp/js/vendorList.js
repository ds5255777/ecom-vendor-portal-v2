var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');
var regionList = [];
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
	"pageLength": 100,
	"searching": true,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true
});
var tabledata2 = $('#tabledata2').DataTable({
	"paging": true,
	"lengthChange": false,
	"pageLength": 10,
	"searching": true,
	"info": true,
	"autoWidth": false,
	"aaSorting": []
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

$(document).ready(function() {
	getAlldetailsList();

});

function getAlldetailsList() {

	$.ajax({
		type: "GET",
		url: "searchController/listOfAllVendors",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			//$('.loader').hide();
			var result = data;

			if (result.msg == 'success') {
				var len = result.data.length;

				var c = 1
				tabledata.clear();
				for (var i = 0; i < len; i++) {
					var view = "<button type=\"button\" class=\"viewtmodal btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result.data[i].vendorPid + "\"  data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-edit\"></i></button>";
					var comment = "<button type=\"button\" class=\"commentmodal btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result.data[i].vendorPid + "\"  data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-eye\"></i></button>";
					var verifierName = "";
					if (result.data[i].hasOwnProperty("verifierName")) {
						verifierName = result.data[i].verifierName;
					}

					var status = "";
					if (result.data[i].hasOwnProperty("status")) {
						status = result.data[i].status;
					}
					if (status == 'pending at vendor' || status == 'pending at commercial head' || status == 'Rejected by Commercial Head') {
						view = "";

					}



					tabledata.row.add([
						c++,
						result.data[i].vendorPid,
						result.data[i].vendorEmail,
						result.data[i].vendorType,
						result.data[i].region,
						result.data[i].creditTerms,
						verifierName,
						comment,
						status,
						view]);

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

$.validator.setDefaults({
	submitHandler: function() {
		addFormData();
	}
});


var idOfData = "";
$('#tabledata tbody').on('click', '.viewtmodal', function() {
	idOfData = this.value;

	myMethod();
});


var pid = "";
$('#tabledata tbody').on('click', '.commentmodal', function() {

	pid = this.value;
	$("#userModal").modal('show');
	commentDetails(pid);
});

function commentDetails(pid) {

	$.ajax({
		type: "GET",
		url: "searchController/getCommentDetails?vendorPid=" + pid + "",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			var result = data;
			if (data.msg == 'success') {
				console.log(data.data);
				
				tabledata2.clear();
				
				var len = result.data.length;
				for (var i = 0; i < len; i++) {

					tabledata2.row.add([
						result.data[i].createdBy,
						result.data[i].roleName,
						result.data[i].remark,
						moment(result.data[i].createdOn).format('DD-MM-YYYY HH:mm:ss')]);

				}
				tabledata2.draw();
				$("tbody").show();

			} else if (data.msg == 'Data Not Found') {
				Toast.fire({
					type: 'error',
					title: 'Data Not Found'
				})
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


function myMethod() {
	// $('#userModalview').modal('show');
	window.location.href = "vendorRegistrastion?vpid=" + idOfData;
}

$('#addForm').validate({
	rules: {

		vendorType: {
			required: false
		},
		region: {
			required: false
		},
		creditTerms: {
			required: false
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




$('#searchBtn').click(function(event) {
	event.preventDefault();
	searchListing();
});

function searchListing() {

	var vendorType = $('#vendorType').val();
	var region = $('#region').val();
	var creditTerms = $('#creditTerms').val();
	var verifierName = $('#verifierName').val();
	var status = $('#status').val();


	$.ajax({
		type: "GET",
		url: "searchController/searchVendors?vendorTypes=" + vendorType + '&regions=' + region + '&creditTerms=' + creditTerms + '&verifierName=' + verifierName + '&status=' + status,
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			//$('.loader').hide();
			var result = data.data;
			if (result.msg == 'success') {
				var len = result.data.length;

				var c = 1
				tabledata.clear();
				for (var i = 0; i < len; i++) {
					var view = "<button type=\"button\" class=\"viewtmodal btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result.data[i].vendorPid + "\"  data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-edit\"></i></button>";
					var comment = "<button type=\"button\" class=\"commentmodal btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result.data[i].vendorPid + "\"  data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-eye\"></i></button>";
					var verifierName = "";
					if (result.data[i].hasOwnProperty("verifierName")) {
						verifierName = result.data[i].verifierName;
					}
					
					var vendorPid = "";
					if (result.data[i].hasOwnProperty("vendorPid")) {
						vendorPid = result.data[i].vendorPid;
					}
					

					var status = "";
					if (result.data[i].hasOwnProperty("status")) {
						status = result.data[i].status;
					}
					if (status == 'pending at vendor' || status == 'pending at commercial head' || status == 'Rejected by Commercial Head') {
						view = "";

					}



					tabledata.row.add([
						c++,
						vendorPid,
						result.data[i].vendorEmail,
						result.data[i].vendorType,
						result.data[i].region,
						result.data[i].creditTerms,
						verifierName,
						comment,
						status,
						view]);

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


$('#region').click(function() {
	var regionId = $('#region').val();
});




function getVerifierList() {

	$.ajax({
		url: 'verifier/listOfAllVerifiersByRegion?regionList=' + regionList.toString(),
		type: 'GET',
		dataType: 'json',
		success: function(data) {

			if (data.msg === 'success') {

				var verifierData = data.data;
				console.log(verifierData);

				for (var i = 0; i < verifierData.length; i++) {
					
					$('#verifierName').append($('<option/>').attr("value", verifierData[i].id).text(verifierData[i].verifierName));


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


$("#region").bind("change", function(event) {
	event.preventDefault();
	regionList = [];
	$('#region :selected').each(function(i, selected) {

		regionList.push($(selected).text().trim());

	});

	getVerifierList();
	// api call to fetch data;

});


$('#CloseBtnComment').click(function(event) {
	$('#userModal').modal('hide');
	event.preventDefault();

});