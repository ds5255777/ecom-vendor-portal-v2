

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
	getData();


});

const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});


getData()

function getData() {
	$.ajax({
		type: "Get",
		url: "CommercialHeadController/getDetailFromCommercialTeam",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			if (data.msg == 'success') {
				var result = data.data;
				console.log(result);
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {

					var edit = "<button type=\"button\" class=\"editmodal btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result[i].id + "\"  data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-edit\"></i></button>";

					var verifierName = "";
					if (result[i].hasOwnProperty("verifierName")) {
						verifierName = result[i].verifierName;
					}

					tabledata.row.add([
						i + 1,
						result[i].vendorEmail,
						result[i].vendorType,
						result[i].region,
						result[i].creditTerms,
						result[i].ehsVerification,
						result[i].thirdPartyVerification,
						result[i].comments,
						result[i].vendorPid,
						verifierName,
						edit
					]);

				}
				tabledata.draw();
				$("tbody").show();
			} else {
				Toast.fire({

					title: 'Data Not Found'
				})
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			alert("failed, please try again");
		}
	});
}
var idOfData = "";
var vendorPid = "";
$('#tabledata tbody').on('click', '.editmodal', function() {

	var row = $(this).closest('tr');
	var vendorEmail = row.find('td:eq(1)').text();
	var vendorType = row.find('td:eq(2)').text();
	var region = row.find('td:eq(3)').text();
	var creditTerms = row.find('td:eq(4)').text();
	var ehsVerification = row.find('td:eq(5)').text();
	var thirdPartyVerification = row.find('td:eq(6)').text();
	var comments = row.find('td:eq(7)').text();
	var verifierName = row.find('td:eq(9)').text();
	vendorPid = row.find('td:eq(8)').text();

	idOfData = this.value;
	// alert(verifierName); 
	//  var id = row.find('td:eq(0)').text();
	//var commaSeparatedValue=this.value;
	//idUpdate=commaSeparatedValue.split(",")[0]; 
	//globalRegionId=commaSeparatedValue.split(",")[1];

	// Set values in the modal inputs
	$('#vendorEmailEdit').val(vendorEmail);
	$('#vendorTypeEdit').val(vendorType);
	$('#regionEdit').val(region);
	$('#creditTermsEdit').val(creditTerms);
	$('#ehsVerificationEdit').val(ehsVerification);
	$('#thirdPartyVerificationEdit').val(thirdPartyVerification);
	$('#commentEdit').val(comments);
	$('#verifierNameEdit').val(verifierName);


	// Show the modal
	$("#userModal").modal('show');
});


$("#approveBtn").click(function() {

	var commentOfCommercialHead = $("#commentOfCommercialHead").val();
	if (commentOfCommercialHead == '') {

		Toast.fire({
			title: 'Remark is mandatory'
		})
		return false;

	}
	ApproveMethod();
})

function ApproveMethod() {
	debugger;

	var json = null
	if ($('#verifierName').val() == "") {
		json = {
			"vendorEmail": $('#vendorEmailEdit').val(),
			"vendorType": $('#vendorTypeEdit').val().toString(),
			"region": $('#regionEdit').val(),
			"creditTerms": $('#creditTermsEdit').val(),
			"thirdPartyVerification": $('#thirdPartyVerificationEdit').val(),
			"ehsVerification": $('#ehsVerificationEdit').val(),
			"comments": $('#commentEdit').val(),
			"commentsHead": $('#commentOfCommercialHead').val(),
			"vendorPid": vendorPid,
			"id": idOfData


		}
	} else {
		json = {
			"vendorEmail": $('#vendorEmailEdit').val(),
			"vendorType": $('#vendorTypeEdit').val().toString(),
			"region": $('#regionEdit').val(),
			"creditTerms": $('#creditTermsEdit').val(),
			"thirdPartyVerification": $('#thirdPartyVerificationEdit').val(),
			"ehsVerification": $('#ehsVerificationEdit').val(),
			"comments": $('#commentEdit').val(),
			"commentsHead": $('#commentOfCommercialHead').val(),
			"verifierName": $('#verifierNameEdit').val(),
			"vendorPid": vendorPid,
			"id": idOfData

		}
	}




	/*var json = {
		"vendorEmail": $('#vendorEmailEdit').val(),
		"vendorType": $('#vendorTypeEdit').val(),
		"region": $('#regionEdit').val(),
		"creditTerms": $('#creditTermsEdit').val(),
		"thirdPartyVerification": $('#thirdPartyVerificationEdit').val(),
		"ehsVerification": $('#ehsVerificationEdit').val(),
		"comments": $('#commentEdit').val(),
		"commentsHead": $('#commentOfCommercialHead').val(),
		"verifierName": $('#verifierNameEdit').val(),
		"vendorPid": vendorPid,
		"id": idOfData

	}*/

	$.ajax({
		type: "Put",
		data: JSON.stringify(json),
		url: "CommercialHeadController/findCommercialTeamDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			$("#approveBtn").prop("disabled", false);

			if (data.msg == 'success') {
				$('.loader').show();
				Toast.fire({
					type: 'success',
					title: 'Approved Successfully..'

				})
				$("#userModal").modal('hide');
				getData();
			} else {
				$("#approveBtn").prop("disabled", false);
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


$("#rejectBtn").click(function() {

	var commentHead = $('#commentOfCommercialHead').val().trim();  // Get the value of the comments of commercial head input field
	if (commentHead === '') {

		Toast.fire({
			title: 'Remark is mandatory'
		})
		return false;
	}

	RejectMethod(commentHead);  // Pass the comment of commercial head as an argument to the RejectMethod function
});

function RejectMethod(commentHead) {

	var id = idOfData;

	var json = {
		"id": id,
		"commentsHead": commentHead  // Include the comment of commercial head in the JSON payload
	}

	$.ajax({
		type: "PUT",
		data: JSON.stringify(json),
		url: "CommercialHeadController/rejectCommercialTeamDetails",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				//$('.loader').show();
				Toast.fire({
					type: 'error',
					title: 'Rejected Successfully'
				})
				location.reload();

				$("#userModal").modal('hide');
				getData();
			} else {
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


	$('#CloseBtnHead').click(function(event) {
		event.preventDefault();

	});


}
