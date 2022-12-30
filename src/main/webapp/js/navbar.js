var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');


$("#invalidateForm").on("click", function() {
	document.forms['logoutForm'].submit();
});

$("#selectVendorCode").on("change", function() {
	GetSelectedInvoiceValue();
});

$("#selectInvoicingStatus").on("change", function() {
	GetSelectedInvoiceValue();
});

$("#changePasswordButton").bind("click", function() {
	changePassword(document.getElementById('passwordConfirm').value);
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
	});
});

function GetSelectedTextValue() {
	var tripStatus = $("#selectTripStatus").val();
	var selectStatus = $("#selectStatus").val();
	var selectPaymentStatus = $("#selectPaymentStatus").val();
	var vendorCode = $("#vendorCode").val();
	$('#fromDate').val('');
	$('#toDate').val('');
	var obj = {
		"runStatus": tripStatus,
		"vendorTripStatus": selectStatus,
		"paymentStatus": selectPaymentStatus,
		"vendorCode": vendorCode
	}
	console.log("Select Status : ", obj);

	$('.loader').show();
	$.ajax({
		type: "POST",
		url: "tripControllers/status",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		data: JSON.stringify(obj),
		success: function(data) {

			console.log("data : ", data);

			$('.loader').hide();
			if (data.msg == "success") {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					if (!result[i].hasOwnProperty("tripID")) {
						result[i].tripID = "-";
					}
					if (!result[i].hasOwnProperty("route")) {
						result[i].route = "-";
					}
					if (!result[i].hasOwnProperty("runType")) {
						result[i].runType = "-";
					}
					if (!result[i].hasOwnProperty("runStatus")) {
						result[i].runStatus = "-";
					}
					if (!result[i].hasOwnProperty("vendorTripStatus")) {
						result[i].vendorTripStatus = "-";
					}
					if (!result[i].hasOwnProperty("actualDeparture")) {
						result[i].actualDeparture = "-";
					}
					if (!result[i].hasOwnProperty("vehicleNumber")) {
						result[i].vehicleNumber = "-";
					}
					if (!result[i].hasOwnProperty("standardVechicleType")) {
						result[i].standardVechicleType = "-";
					}
					if (!result[i].hasOwnProperty("standardKM")) {
						result[i].standardKM = "-";
					}
					if (!result[i].hasOwnProperty("totalFreight")) {
						result[i].totalFreight = "-";
					}
					if (!result[i].hasOwnProperty("invoiceNumber")) {
						result[i].invoiceNumber = "-";
					}
					if (!result[i].hasOwnProperty("paymentStatus")) {
						result[i].paymentStatus = "-";
					}

					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" value=\"" + result[i].tripID + "\" class=\"tripIdView\"  >" + result[i].tripID + "</a>";
					
					tabledata.row.add([view,
						result[i].route,
						result[i].runType,
						result[i].runStatus,
						result[i].vendorTripStatus,
						result[i].actualDeparture,
						result[i].vehicleNumber + " / " + result[i].standardVechicleType,
						result[i].standardKM,
						result[i].totalFreight,
						result[i].invoiceNumber,
						result[i].paymentStatus]);
				}
				tabledata.draw();
				$("tbody").show();
			} else {
				alert("failed");
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			alert("failed, please try again");
		}
	});
}



function getSelectTripList() {

	$("#selectVendorCode ").empty();
	$('#selectVendorCode').append($('<option/>').attr("value", "").text("Select Vendor Code"));

	$.ajax({
		type: "POST",
		data: "",
		url: "financeController/getFilterInvoiceByVendorCode",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",

		success: function(data) {

			if (data.msg == 'success') {
				var result = data.data;

				if (result.length !== 0) {
					for (var i = 0; i < result.length; i++) {
						$('#selectVendorCode').append($('<option/>').attr("value", result[i]).text(result[i]));
					}
				}
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

function GetSelectedInvoiceValue() {
	var vendorCode = $("#selectVendorCode").val();
	var invoiceStatus = $("#selectInvoicingStatus").val();
	var obj = {
		"vendorCode": vendorCode,
		"invoiceStatus": invoiceStatus
	}
	console.log("Select Status : ", obj);

	$('.loader').show();
	$.ajax({
		type: "POST",
		data: JSON.stringify(obj),
		url: "financeController/viewInvoiceForFinanceTeam",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			$('.loader').hide();
			if (data.msg == 'success') {
				var result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					if (!result[i].hasOwnProperty("invoiceNumber")) {
						result[i].invoiceNumber = "";
					}
					if (!result[i].hasOwnProperty("invoiceDate")) {
						result[i].invoiceDate = "";
					}
					if (!result[i].hasOwnProperty("invoiceAmount")) {
						result[i].invoiceAmount = "";
					}
					if (!result[i].hasOwnProperty("invoiceReceivingDate")) {
						result[i].vehicleNumber = "";
					}
					if (!result[i].hasOwnProperty("invoiceStatus")) {
						result[i].invoiceStatus = "";
					}
					if (!result[i].hasOwnProperty("ecomInvoiceNumber")) {
						result[i].invoiceStatus = "";
					}
					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" value=\"" + result[i].tripID + "\" class=\"tripIdView\"  >" + result[i].tripID + "</a>";
					
					tabledata.row.add([view, result[i].invoiceNumber, result[i].vendorCode, result[i].vendorName, result[i].invoiceReceivingDate, result[i].invoiceDate, result[i].invoiceAmount, result[i].invoiceStatus]);
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
			alert("failed, please try again leter");
		}
	});
}

function changePassword(password) {

	$.ajax({
		type: "POST",
		data: "",
		url: "userController/changePassword" + "?password=" + password,
		headers: { 'X-XSRF-TOKEN': csrfToken },
		dataType: "json",
		contentType: "application/json",

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
