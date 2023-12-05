

var tabledata = $('#tabledata').DataTable({
	"paging": true,
	"lengthChange": false,
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
	getVendorDetailList();
	
});

function getVendorDetailList() {

	$.ajax({
		type: "GET",
		url: "CommercialHeadController/findListOfAllVendorByThirdPartyVerifier",
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
					
					tabledata.row.add([
						c++,
						result.data[i].vendorPid,
						result.data[i].vendorEmail,
						result.data[i].vendorType,
						result.data[i].region,
						result.data[i].creditTerms,
						verifierName,
						status,
						comment,
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

var idOfData = "";
$('#tabledata tbody').on('click', '.viewtmodal', function() {
	idOfData = this.value;

	myMethod();
});

function myMethod() {
	// $('#userModalview').modal('show');
	window.location.href = "vendorRegistrastion?vpid=" + idOfData;
}

/*
$(document).ready(function() {
	getSupplierDetailList();
	
})
function getSupplierDetailList() {
	

	$.ajax({
		type: "Get",
		url: "CommercialHeadController/getSupplierDetailsByThirdPartyVerifier",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(data) {
			$('.loader').hide();
			console.log(data.date);
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				

				//debugger;
				for (var i = 0; i < result.length; i++) {
					var view = "<button type=\"button\" class=\"viewCheckList btn btn-primary btn-xs\" data-placement=\"bottom\" value=\"" + result[i].pid + "\"  data-original-title=\"Click To Edit\" style=\"width: 43px;\"><i class=\"fa fa-edit\"></i></button>";

				var aadharNumber = "";
					if (result[i].hasOwnProperty("aadharNumber")) {
						aadharNumber = result[i].aadharNumber;
					}
					
					
					var region = "";
					if (result[i].hasOwnProperty("region")) {
						region = result[i].region;
					}
			
					tabledata.row.add([
						result[i].introducedByEmailID,
						result[i].suppName,
						result[i].businessClassification,
						result[i].region,
						aadharNumber,
						result[i].vendorType,
						result[i].enInvApplicable,
						view
					]);
				}
				tabledata.draw();
				$("tbody").show();
			}
			else {
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
*/

/*
$('#tabledata tbody').on('click', ".viewCheckList", function() {
	debugger;
	var pid = this.value;
	
	viewSupplierDetails(pid);

});
function viewSupplierDetails(pid) {
	window.location.href = "vendorRegistrastion?vpid="+pid;
}*/


var pid = "";
$('#tabledata tbody').on('click', '.commentmodal', function() {

	pid = this.value;
	$("#userModal").modal('show');
	commentDetails(pid);
});

function commentDetails(pid) {

	$.ajax({
		type: "GET",
		url: "CommercialHeadController/getCommentDetailsOnThirdPartyVerifierPage?vendorPid=" + pid + "",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			var result = data;
			if (data.msg == 'success') {
				console.log(data.data);
				var len = result.data.length;
				tabledata2.clear();
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

$('#CloseBtnComment').click(function(event) {
	$('#userModal').modal('hide');
	event.preventDefault();

});