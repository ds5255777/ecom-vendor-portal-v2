var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

var pageContext = $("#pageContext").val();

$("#GSTFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'GSTFileText', 'GSTFile'), onValidateFile('GSTFile');
});

$("#PDFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'PDFileText', 'Proprietorship Declaration'), onValidateFile('GSTFile');
});

$("#PANFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'PANFileText', 'PAN Card'), onValidateFile('PANFile');
});

$("#CCFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'CCFileText', 'Cancelle Cheque'), onValidateFile('CCFile');
});

$("#ACFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ACFileText', 'Aadhar Card'), onValidateFile('ACFile');
});

$("#APLFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'APLFileText', 'Aadhar PAN Linking'), onValidateFile('APLFile');
});

$("#ITRFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText', 'ITR Declaratin'), onValidateFile('ITRFile');
});

$("#FUVFFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'FUVFFileText', 'VRF Form'), onValidateFile('FUVFFile');
});

$("#MSMECFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'MSMECFileText', 'MSME Certificate'), onValidateFile('MSMECFile');
});

$("#AMFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'AMFileText', 'Approval Mail'), onValidateFile('AMFile');
});

$("#NMISFile").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'NMISFileText', 'Name Mismatch Affidavit'), onValidateFile('NMISFile');
});

$("#ITRFile3").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText3'), onValidateFile('ITRFile3');
});

$("#ITRFile2").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText2'), onValidateFile('ITRFile2');
});

$("#ITRFile1").bind("change", function() {
	removeValCssByID(this), handleFileSelect(event, 'ITRFileText1'), onValidateFile('ITRFile1');
});

$("#bpCode").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#businessClassification").bind("change", function() {
	MESMENumber();
});

$("#aadharNumber").bind("input", function() {
	this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
});

$("#aadharNumber").bind("blur", function() {
	AadharValidate();
});

$("#panNumber").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#tanNumber").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#region").bind("change", function() {
	region1();
});

$("#pinCode").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#states").bind("change", function() {
	select();
});

$("#compGstn").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#conPhone").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#ifscCode").bind("input", function() {
	this.value = this.value.toUpperCase();
});

$("#accoutNumber").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#confirmedAccoutNumber").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57;
});

$("#tdsApplication").bind("change", function() {
	changetextbox();
});

$("#tdsRate").bind("keypress", function() {
	return event.charCode >= 48 && event.charCode <= 57 || event.charCode <= 46;
})

$("#panNumber").focusout(function() {
	checkForExistingPanNumber();
});

$("#bpCode").focusout(function() {
	checkForExistingVendorCode();
});


$("#changeVendorPassword").bind("click", function() {

	var val = $("#password").val();
	vendorPasswordChange(val);
});



$(document).ready(function() {
	var bootstrapTooltip = $.fn.tooltip.noConflict();
	$.fn.bstooltip = bootstrapTooltip;
	$('.quickHelp').bstooltip();
})

$("#updateBtn").bind("click", function() {
	sendToServer();
});


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


function handleFileSelect(evt, id) {
	var f = evt.target.files[0]; // FileList object
	var reader = new FileReader();
	reader.onload = (function(theFile) {
		return function(e) {
			var binaryData = e.target.result;
			var base64String = window.btoa(binaryData);

			$("#" + id).val(base64String);

		};
	})(f);
	reader.readAsBinaryString(f);
}

function onValidateFile(id) {
	var fileInput3 = document.getElementById(id).value;
	var gst = document.getElementById(id);
	var allowedExtensions = /(\.docx|\.pdf)$/i;
	if (typeof (gst.files) != "undefined") {

		const fsize = gst.files.item(0).size;

		const file = Math.round((fsize / 1024));
		if (file > 5500) {
			swal.fire("Alert", "Please select File size less than 5 MB....", "warning");
			$("#" + id).val("");
		} else {
			var ext = fileInput3.split(".")[1];

			if (ext == "pdf" || ext == "PDF" || ext == "DOCX" || ext == "docx") {
			} else {
				swal.fire("Alert", "Invalid File Type, Select Only Word & PDF File....", "warning");

				$("#" + id).val("");
				return false;
			}
		}
	} else {
		alert("This browser does not support HTML5.");
	}
}

var globalVendorCode = "";

var tabledata = $('#tabledata').DataTable({
	"paging": true,
	"lengthChange": false,
	"searching": true,
	"info": true,
	"autoWidth": false,
	"aaSorting": [],
	"scrollX": true,
	"pageLength": 100,
	dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
});
$(document).ready(function() {
	$('.js-example-basic-multiple1').select2({
		zplaceholder: "Select Region",
		allowClear: true

	});

});
$(document).ready(function() {
	$('.js-example-basic-multiple2').select2({
		zplaceholder: "Select Flag",
		allowClear: true

	});

});


const Toast = Swal.mixin({
	toast: true,
	position: 'top-end',
	showConfirmButton: false,
	timer: 3000
});

getData();

var result;

function getData() {

	var bpcode = "";

	$.ajax({
		type: "POST",
		data: "",
		url: "userController/getActiveVendorData",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {
				var lastName = "";
				result = data.data;
				tabledata.clear();
				for (var i = 0; i < result.length; i++) {
					/*  bpcode=result[i].bpCode; */
					if (!result[i].hasOwnProperty("introducedByName")) {
						result[i].introducedByName = "";
					}
					if (!result[i].hasOwnProperty("suppName")) {
						result[i].suppName = "";
					}
					if (!result[i].hasOwnProperty("pid")) {
						result[i].pid = "";
					}
					if (!result[i].hasOwnProperty("compEmail")) {
						result[i].compEmail = "";
					}
					if (!result[i].hasOwnProperty("introducedByEmailID")) {
						result[i].introducedByEmailID = "";
					}
					if (!result[i].hasOwnProperty("businessClassification")) {
						result[i].businessClassification = "";
					}

					if (!result[i].hasOwnProperty("partnerType")) {
						result[i].partnerType = "";
					}
					if (!result[i].hasOwnProperty("vendorType")) {
						result[i].vendorType = "";
					}
					if (!result[i].hasOwnProperty("phoneNumber")) {
						result[i].phoneNumber = "";
					}
					if (!result[i].hasOwnProperty("flag")) {
						result[i].flag = "";
					}
					var download = "<a href=\"#\" data-toggle=\"modal\"  tittle=\"In-Active Vendor\" data-target=\"#vendorValue\" class=\"downladZipFile\" > <i class=\"fas fa-file-export\"></i>  </a>";


					var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#\" class=\"checkVendorCode\">" + result[i].bpCode + "</a>";
					if (result[i].flag == "Active") {
						var changePassword = "<button type=\"button\" id=\"" + result[i].bpCode + "\" style=\"display: block\" class=\"tripApprove btn btn-primary btn-xs\"  value=\"" + result[i].bpCode + "\"> <i class=\"fas fa-key\"></i>  </button>";
					} else {
						var changePassword = "<button type=\"button\" id=\"" + result[i].bpCode + "\" style=\"display: none\" class=\"tripApprove btn btn-primary btn-xs\"  value=\"" + result[i].bpCode + "\"> <i class=\"fas fa-key\"></i>  </button>";
					}
					if (result[i].flag == "Active") {
						var button = "<a href=\"#\" data-toggle=\"modal\"  tittle=\"In-Active Vendor\" data-target=\"#vendorValue\" class=\"inactiveVendor\" > <i style=\"color:red;\" class=\"fas fa-user-slash\"></i>  </a>";
					} else if (result[i].flag == "In-Active") {
						var button = "<a href=\"#\" data-toggle=\"modal\" tittle=\"Active Vendor\" data-target=\"#vendorValue\" class=\"activeVendor\" > <i class=\"fas fa-user\"></i>  </a>";
					} else if (result[i].flag == "Inactive")  {
						var button = "<a href=\"#\" data-toggle=\"modal\" tittle=\"Active Vendor\" data-target=\"#vendorValue\" class=\"activeVendor\" > <i class=\"fas fa-user\"></i>  </a>";
					}else  {
						var button = "<a href=\"#\" data-toggle=\"modal\" tittle=\"Active Vendor\" data-target=\"#vendorValue\" class=\"activeVendor\" > <i class=\"fas fa-user\"></i>  </a>";
					}

					tabledata.row.add([view,
						result[i].suppName,
						result[i].pid,
						result[i].vendorType,
						result[i].businessClassification,
						result[i].introducedByName,
						result[i].introducedByEmailID,
						result[i].flag,
						download,
						changePassword,
						button]);
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


$('#tabledata tbody').on('click', ".tripApprove", function() {
	var userName = this.value;
	//$("#userID").val(userName);
	//$("#changePassword").modal('show');
	//$("#password").val('');
	changeVendorPass(userName);
});


function changeVendorPass(userName) {


	Swal.fire({
		title: 'Are you sure want to Reset Vendor password.?',
		text: "Vendor Name : " + userName,
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes'
	}).then((result) => {
		let test = [1];
		test[0] = result;
		var val = Object.values(test[0])
		if (val == "true") {
			vendorPasswordChange(userName);
		}
	})

}




$('#tabledata tbody').on('click', ".checkVendorCode", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	editData(row.cells[0].innerText);
});

$('#tabledata tbody').on('click', ".inactiveVendor", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);

	inActiveVendor(row.cells[0].innerText, row.rowIndex, row.cells[1].innerText);
});

$('#tabledata tbody').on('click', ".activeVendor", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	activeVendor(row.cells[0].innerText, row.rowIndex, row.cells[1].innerText);
});

$('#tabledata tbody').on('click', ".downladZipFile", function() {
	var row = $(this).parents('tr')[0];
	console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	downladZipFile(row.cells[0].innerText);
});

function downladZipFile(vendorCode) {

	console.log(pageContext+'/downloadZip?vendorCode=' + vendorCode);

	$('.loader').show();
	$('#pdfLink').attr('src', pageContext+'/downloadZip?vendorCode=' + vendorCode);
	$('.loader').hide();

}


function inActiveVendor(bpcode, index, name) {


	Swal.fire({
		title: 'Are you sure want to In-Active?',
		text: "Vendor Code : " + bpcode,
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes'
	}).then((result) => {

		let test = [1];
		test[0] = result;
		var val = Object.values(test[0])
		if (val == "true") {
			inactiveVendorFlag(bpcode, index, name);
		}
	})

}

function AadharValidate() {
	var aadhar = document.getElementById("aadharNumber").value;
	var adharcardTwelveDigit = /^\d{12}$/;
	var adharSixteenDigit = /^\d{16}$/;
	if (aadhar != '') {
		if (aadhar.match(adharcardTwelveDigit)) {
			return true;
		} else if (aadhar.match(adharSixteenDigit)) {
			return true;
		} else {
			swal.fire("", " Invalid Aadhar Number", "warning");
			$("#aadharNumber").val('');
			$("#aadharNumber").focus();
			//return false;
		}
	}
}

function inactiveVendorFlag(bpcode, index, name) {



	var json = {
		"bpCode": bpcode,
		"status": "0"
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/setStatusOfVendorByBpCode",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {


				Toast.fire({
					type: 'success',
					title: 'In-Active Successfully..'
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

function activeVendor(bpcode, index, name) {


	Swal.fire({
		title: 'Are you sure want to Active?',
		text: "Vendor Code : " + bpcode,
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes'
	}).then((result) => {
		let test = [1];
		test[0] = result;
		var val = Object.values(test[0])
		if (val == "true") {
			activeVendorFlag(bpcode, index, name);
		}
	})

}

function activeVendorFlag(bpcode, index, name) {



	var json = {
		"bpCode": bpcode,
		"status": "1"
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/setStatusOfVendorByBpCode",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {

			if (data.msg == 'success') {


				Toast.fire({
					type: 'success',
					title: 'Active Successfully..'
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



function getVendorStatus(value, bpcode, index) {

	var json = {
		"bpCode": bpcode


	}



	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/getAllVendorStatus",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {


			$('.loader').hide();

			if (data.msg == 'success') {
				var result = data.data;

				for (var i = 0; i < result.length; i++) {
					alert(result[i].status);

					var code = result[i].status;

					$("#status_" + index).val(code)
				}

				tabledata.draw();
				$("tbody").show();


			} else {

				$('.loader').hide();
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



function changetextbox() {
	/* alert(document.getElementById("tdsApplication").value);  */
	if (document.getElementById("tdsApplication").value === "No") {
		document.getElementById("tdsSection").disabled = 'true';
		document.getElementById("tdsRate").disabled = 'true';
		//    document.getElementById("tdsRate").val()="";
		//            	    document.getElementById("tdsSection").value()="";
		$("#tdsSection").val("");
		$("#tdsRate").val("");

	} else {
		document.getElementById("tdsSection").disabled = '';
		document.getElementById("tdsRate").disabled = '';
	}
}

$(document).ready(function() {
	$(".email").change(function() {
		var inputvalues = $(this).val();
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (!regex.test(inputvalues)) {
			$("#compEmail").val("");

			swal.fire("Alert", "Invalid Email Id", "warning");
			return regex.test(inputvalues);
		}
	});
	$("#introducedByEmailID").change(function() {
		var inputvalues = $(this).val();
		var regex = /^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@ecomexpress.in$/;

		if (!regex.test(inputvalues)) {
			$("#introducedByEmailID").val("");

			swal.fire("Alert", "Dear User Please Provide ECOM Patner Email ID", "warning");
			return regex.test(inputvalues);
		}
	});
});

$(document).ready(function() {
	$("#conEmail").change(function() {
		var inputvalues = $(this).val();
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (!regex.test(inputvalues)) {
			$("#conEmail").val("");

			swal.fire("Alert", "Invalid Email Id....", "warning");
			return regex.test(inputvalues);
		}
	});
});




var id = "";
var bpCode = "";


function editData(bpCode) {

	var json = {

		"bpCode": bpCode
	}

	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/getVendorById",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			if (data.msg == 'success') {
				var result = data.data;
				id = result.id;

				var myForm = "";
				myForm = document.getElementById("stepOneForm");
				setData(myForm, result);

				var vendorType = result.vendorType;

				var str = vendorType.split(",");


				for (var i = 0; i < str.length; i++) {


					if (str[i] == 'Network' && str[i + 1] == 'Fixed Asset' && str[i + 2] == 'Other') {
						$('#states').val(["Network", "Fixed Asset", "Other"]).change()

						break;

					} else if (str[i] == 'Network' && str[i + 1] == 'Fixed Asset') {
						$('#states').val(["Network", "Fixed Asset"]).change().css("color", "blue");
						break;
					} else if (str[i] == 'Fixed Asset' && str[i + 1] == 'Other') {
						$('#states').val(["Fixed Asset", "Other"]).change()
						break;
					} else if (str[i] == 'RENT') {
						$('#states').val(["Network", "Other"]).change()
						break;
					} else if (str[i] == 'Network') {

						$('#states').val('Network').submit().trigger('change');
						break;
					} else if (str[i] == 'FIXED ASSETS') {

						$('#states').val('FIXED ASSETS').submit().trigger('change');
						break;
					} else if (str[i] == 'OTHER EXPENSES') {
						$('#states').val('Other').trigger('change');
						break;
					} else if (str[i] == 'EMPLOYEE NOMINEE') {
						$('#states').val('Other').trigger('change');
						break;
					} else if (str[i] == 'COURIER') {
						$('#states').val('Other').trigger('change');
						break;
					}

				}


				select();
				var ero = result.ero;
				var wro = result.wro;
				var nro = result.nro;
				var sro = result.sro;
				var ihq = result.ihq;

				if (ero == 'Y') {
					$('#region').val('ERO').trigger('change');
					//break;
				}

				if (wro == 'Y') {
					$('#region').val('WRO').trigger('change');
					//break;
				} if (nro == 'Y') {
					$('#region').val('NRO').trigger('change');
					//break;
				} if (sro == 'Y') {
					$('#region').val('SRO1').trigger('change');
					//break;
				} if (ihq == 'Y') {
					$('#region').val('IHQ').trigger('change');
					//break;
				}

				var addressPurchasingFlag = result.addressPurchasingFlag;
				var addressPaymentFlag = result.addressPaymentFlag;
				var invoicePrevalidatedFlag = result.invoicePrevalidatedFlag;
				if (addressPurchasingFlag == 'Y') {
					$('#flag').val('ADDRESS_PURCHASING').trigger('change');
					//break;
				} if (addressPaymentFlag == 'Y') {
					$('#flag').val('ADDRESS_PAYMENT').trigger('change');
					//break;
				} if (invoicePrevalidatedFlag == 'Y') {
					$('#flag').val('INVOICE_PREVALIDATED').trigger('change');
					//break;
				}

				$('#acknowledgementNumber1').val(result.acknowledgementNumber1);
				$('#acknowledgementNumber2').val(result.acknowledgementNumber2);
				$('#acknowledgementNumber3').val(result.acknowledgementNumber3);

				$('#fyYear1').val(result.fyYear1);
				$('#fyYear2').val(result.fyYear2);
				$('#fyYear3').val(result.fyYear3);


				// if(result.partnerType!="Ad-Hoc"){


				// tabledata.clear();
				$("#addBookGridTbody").html("");
				for (var i = 0; i < result.addressDetails.length; i++) {


					$("#addBookGridTbody").append(' <tr class=""><td>' +
						result.addressDetails[i].addCountry + '</td><td>' +
						result.addressDetails[i].state + '</td><td>' +
						result.addressDetails[i].city + '</td><td>' +
						result.addressDetails[i].pinCode + '</td><td>' +
						result.addressDetails[i].vendorType + '</td><td>' +
						result.addressDetails[i].partnerType + '</td><td>' +
						result.addressDetails[i].compGstn + '</td><td>' +
						result.addressDetails[i].addDetails + '</td><td> <a href="#" class="removeAddress btn btn-danger btn-sm" value="abc">Remove</a></td></tr>');
				}

				$("#contactDetailsGridTbody").html("");

				for (var i = 0; i < result.contactDetails.length; i++) {

					$("#contactDetailsGridTbody").append('<tr class=""><td>' +
						result.contactDetails[i].conFname + '</td><td>' +
						result.contactDetails[i].conLname + '</td><td>' +
						result.contactDetails[i].conPhone + '</td><td>' +
						result.contactDetails[i].conEmail + '</td><td> <a href="#" class="removeContact btn btn-danger btn-sm" abc="xyz">Remove</a></td></tr>');

				}

				$("#addBankGridTbody").html("");
				for (var i = 0; i < result.accountDetails.length; i++) {
					$("#addBankGridTbody").append('<tr class=""><td>' +
						result.accountDetails[i].bankName + '</td><td>' +
						result.accountDetails[i].beneficiaryName + '</td><td>' +
						result.accountDetails[i].ifscCode + '</td><td>' +
						result.accountDetails[i].accoutCurrency + '</td><td>' +
						result.accountDetails[i].accoutNumber + '</td><td>' + '</td><td>  <a href="#" class="removeBank btn btn-danger btn-sm" value="dgg">Remove</a></td></tr>');


				}

				/*  for (var i = 0; i < result.itrDetails.length; i++) {
				 $("#addITRGrid").append('<tr class=""><td>' +
						 result.itrDetails[i].fyYear + '</td><td>' +

						 result.itrDetails[i].acknowledgementNumber + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

				 
			    
				 }
				 */



				myForm = document.getElementById("stepSixForm");
				setData(myForm, result);


				myForm = document.getElementById("stepSevenForm");
				setData(myForm, result);

				//  } 

				// $("#id").val(result.id);
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



$(document).ready(function() {
	$('.js-example-basic-multiple').select2({
		zplaceholder: "Select Partner Type",
		allowClear: true,
		maximumSelectionLength: 1
	});

});





$("#addBookGridButt").click(function() {
	var abc = document.getElementById('city').value;
	var abc2 = document.getElementById('pinCode').value;
	var abc3 = document.getElementById('addDetails').value;
	var abc4 = document.getElementById('states').value;
	if (abc == null || abc == "") {
		swal.fire("Alert", "District is mandatory", "warning");
		return false;
	} else if (abc2 == null || abc2 == "") {
		swal.fire("Alert", "Pin Code is mandatory", "warning");
		return false;
	} else if (abc4 == null || abc4 == "") {
		swal.fire("Alert", "Business Partner Type is mandatory", "warning");
		return false;
	} else if (abc3 == null || abc3 == "") {
		swal.fire("Alert", "Address is mandatory", "warning");
		return false;
	} else {

		$("#addBookGrid").append(' <tr class=""><td>' +
			document.getElementById('addCountry').value + '</td><td>' +
			document.getElementById('state').value + '</td><td>' +
			document.getElementById('city').value + '</td><td>' +
			document.getElementById('pinCode').value + '</td><td>' +
			document.getElementById('states').value + '</td><td>' +
			document.getElementById('partnerType').value + '</td><td>' +
			document.getElementById('compGstn').value + '</td><td>' +
			document.getElementById('addDetails').value + '</td><td> <a href="#" class="removeAddress btn btn-danger btn-sm" value="abc">Remove</a></td></tr>');

		/*  document.getElementById('addCountry').value = "";
		 document.getElementById('state').value = ""; */
		document.getElementById('city').value = "";
		document.getElementById('pinCode').value = "";
		document.getElementById('states').value = "";
		$("#states").val('').trigger('change');
		document.getElementById('addDetails').value = "";
		document.getElementById('compGstn').value = "";

	}

});

$(document).on("click", ".removeAddress", function() {
	$(this).closest("tr").remove();
});


$("#addDocTypeButt").click(function() {
	$("#addDocTypeGrid").append('<tr class=""><td>' + document.getElementById('docType').value + '</td><td>' + document.getElementById('myfile').value + '</td><td><a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');
	document.getElementById('docType').value = "";
	document.getElementById('myfile').value = "";
});

$("#contactDetailsButt").click(function() {
	var abc = document.getElementById('conFname').value;
	var abc2 = document.getElementById('conLname').value;
	var abc3 = document.getElementById('conPhone').value;
	var abc4 = document.getElementById('conEmail').value;
	console.log("abc =>" + abc);
	if (abc == null || abc == "") {
		swal.fire("Alert", "First Name is mandatory !", "warning");
		return false;
	} else if (abc2 == null || abc2 == "") {
		swal.fire("Alert", "Last Name is mandatory !", "warning");
		return false;
	} else if (abc3 == null || abc3 == "") {
		swal.fire("Alert", "Phone Number is mandatory !", "warning");
		return false;
	} else if (abc4 == null || abc4 == "") {
		swal.fire("Alert", "Email Id is mandatory !", "warning");
		return false;
	} else {
		console.log("Coming Here");
		$("#contactDetailsGrid").append('<tr class=""><td>' +
			document.getElementById('conFname').value + '</td><td>' +
			document.getElementById('conLname').value + '</td><td>' +
			document.getElementById('conPhone').value + '</td><td>' +
			document.getElementById('conEmail').value + '</td><td> <a href="#" class="removeContact btn btn-danger btn-sm" >Remove</a></td></tr>');

		document.getElementById('conFname').value = "";
		document.getElementById('conLname').value = "";
		document.getElementById('conPhone').value = "";
		document.getElementById('conEmail').value = "";
	}
});

$(document).on("click", ".removeContact", function() {
	$(this).closest("tr").remove();
});

$("#addBankGridButt").click(function() {
	var abc = document.getElementById('bankName').value;
	var abc5 = document.getElementById('beneficiaryName').value;
	var abc2 = document.getElementById('ifscCode').value;
	var abc3 = document.getElementById('accoutNumber').value;
	var abc4 = document.getElementById('confirmedAccoutNumber').value;
	console.log("abc =>" + abc);
	if (abc == null || abc == "") {
		swal.fire("Alert", "Bank Name is mandatory", "warning");
		return false;
	} else if (abc5 == null || abc5 == "") {
		swal.fire("Alert", "Beneficiary Name is mandatory", "warning");
		return false;
	} else if (abc2 == null || abc2 == "") {
		swal.fire("Alert", "IFSC Code is mandatory", "warning");
		return false;
	} else if (abc3 == null || abc3 == "") {
		swal.fire("Alert", " Account Number is mandatory", "warning");
		return false;
	} else if (abc4 == null || abc4 == "") {
		swal.fire("Alert", " Confirm Account Number is mandatory", "warning");
		return false;

	} else {
		$("#addBankGrid").append('<tr class=""><td>' +
			document.getElementById('bankName').value + '</td><td>' +
			document.getElementById('beneficiaryName').value + '</td><td>' +
			document.getElementById('ifscCode').value + '</td><td>' +
			document.getElementById('accoutCurrency').value + '</td><td>' +
			document.getElementById('accoutNumber').value + '</td><td>' + '</td><td>  <a href="#" class="removeBank btn btn-danger btn-sm" value="abc">Remove</a></td></tr>');

		document.getElementById('bankName').value = "";
		document.getElementById('beneficiaryName').value = "";
		document.getElementById('ifscCode').value = "";
		document.getElementById('accoutNumber').value = "";
		document.getElementById('confirmedAccoutNumber').value = "";
		document.getElementById('divCheckPasswordMatch').innerHTML = "";
	}
});

$(document).on("click", ".removeBank", function() {
	$(this).closest("tr").remove();
});

$body = $("body");

$(document).on({
	ajaxStart: function() {
		$body.addClass("loading");
	},
	ajaxStop: function() {
		$body.removeClass("loading");
	}
});

/*  $("#addITRGridButt").click(function() {
	 var abc = document.getElementById('fyYear').value;
	 var abc1 = document.getElementById('acknowledgementNumber').value;
	 var abc2 = document.getElementById('ITRAFile').value;
	 // alert(abc2)
	//C:\fakepath\
		  
	  let txt=abc2.substr(12);
	 console.log("abc =>" + abc);
	 if (abc == null || abc == "") {
		 swal.fire("Alert", "Select Financial Year Number. !", "warning");
		 return false;
	 } else if (abc1 == null || abc1 == "") {
		 swal.fire("Alert", "Fill Acknowledgement Number. !", "warning");
		 return false;
	 } else {
		  $("#addITRGrid").append('<tr class=""><td>' +
			 document.getElementById('fyYear').value + '</td><td>' +

			 document.getElementById('acknowledgementNumber').value + '</td><td>' +

			 txt + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

		 document.getElementById('fyYear').value = "";
		 document.getElementById('acknowledgementNumber').value = "";
	 }
 }); 

  */

/*  function ValidatePAN() {
	 var txtPANCard = document.getElementById("panNumber");
	 var lblPANCard = document.getElementById("lblPANCard")
	 var regex = /([A-Z]){5}([0-9]){4}([A-Z]){1}$/;
	 if (regex.test(txtPANCard.value.toUpperCase())) {
		 lblPANCard.style.visibility = "hidden";
		 return true;
	 } else {
		 lblPANCard.style.visibility = "visible";
		 return false;
	 }
 }
  */


function sendToServer() {

	var txtPANCard = document.getElementById("panNumber");
	var lblPANCard = document.getElementById("lblPANCard")
	var regex = /([A-Z]){5}([0-9]){4}([A-Z]){1}$/;
	/*  if (regex.test(txtPANCard.value.toUpperCase())) {
		 lblPANCard.style.visibility = "hidden";
		 
	 } else {
		 lblPANCard.style.visibility = "visible";
		 swal.fire("Alert", "Invalid Pan Number", "warning");
		 return false;
	 }  */
	//alert("hii");
	console.log("Inside Step One");
	/*var mandFields = "introducedByName,introducedByEmailID,suppName";
	var mandFieldsArr = mandFields.split(",");
	for (i = 0; i < mandFieldsArr.length; i++) {
		console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
		if (document.getElementById(mandFieldsArr[i]).value == '') {
			notifyTooltip(mandFieldsArr[i], "Mandatory Field", "top")
			console.log("Mandatory Check :: " + mandFieldsArr[i]);
			return false;
		}
	}*/
	var mandFields = "introducedByName,introducedByEmailID,suppName,businessClassification";
	var mandFieldsArr = mandFields.split(",");
	for (i = 0; i < mandFieldsArr.length; i++) {
		console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
		if (document.getElementById(mandFieldsArr[i]).value == '') {
			notifyTooltip(mandFieldsArr[i], "Mandatory Field", "top")
			console.log("Mandatory Check :: " + mandFieldsArr[i]);
			return false;
		}
	}

	var businessClass = $("#businessClassification").val();
	if (businessClass == "Micro Enterprise" || businessClass == "Medium Enterprise" || businessClass == "Small Enterprise") {
		var mandFields = "mesmeNumber";
		var mandFieldsArr = mandFields.split(",");
		for (i = 0; i < mandFieldsArr.length; i++) {
			if (document.getElementById(mandFieldsArr[i]).value == '') {
				notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
				return false;
			}
		}
	}



	/* var element = document.getElementById('states');
	var element=[...element.options].filter(ele => ele.selected).map(ele => ele.text);
	var selectedValues = [];    
	$("#states :selected").each(function(){
		selectedValues.push($(this).val()); 
	});
		if(selectedValues== ""){
		swal.fire("Alert", "please select Business Partner Type....", "warning")
		return regex.test(inputvalues);
	} */


	var addressDetailsArray = [];
	var vendorType = [];
	var table = document.getElementById('addBookGrid');
	var rowLength = table.rows.length;

	for (var i = 1; i < rowLength; i += 1) {
		var row = table.rows[i];
		var objs = {
			"addCountry": row.cells[0].innerHTML,
			"state": row.cells[1].innerHTML,
			"city": row.cells[2].innerHTML,
			"pinCode": row.cells[3].innerHTML,
			"vendorType": row.cells[4].innerHTML,
			"partnerType": row.cells[5].innerHTML,
			"compGstn": row.cells[6].innerHTML,
			"addDetails": row.cells[7].innerHTML
		};
		addressDetailsArray.push(objs);
		vendorType.push(row.cells[4].innerHTML);
	}

	var vendorTypeString = vendorType.join(",");
	var partnerType = document.getElementById("partnerType").value

	if (addressDetailsArray.length == 0 && partnerType != "Ad-Hoc") {

		swal.fire("Alert", "please add addres....", "warning")
		return regex.test(inputvalues);
	}

	var paymentMethod = $("#paymentMethod").val();
	if (paymentMethod == "NEFT") {
		var accountDetailsArray = [];
		table = document.getElementById('addBankGrid');
		rowLength = table.rows.length;

		for (var i = 1; i < rowLength; i += 1) {
			var row = table.rows[i];

			var pushObj = {
				"bankName": row.cells[0].innerHTML,
				"beneficiaryName": row.cells[1].innerHTML,
				"ifscCode": row.cells[2].innerHTML,
				"accoutCurrency": row.cells[3].innerHTML,
				"accoutNumber": row.cells[4].innerHTML,
				"accoutName": row.cells[5].innerHTML,
			}
			accountDetailsArray.push(pushObj);
		}

		if (accountDetailsArray.length == 0 && partnerType != "Ad-Hoc") {


			swal.fire("Alert", "please add accountDetails", "warning")
			return regex.test(inputvalues);
		}
	}


	var contactDetailsArray = [];
	table = document.getElementById('contactDetailsGrid');
	rowLength = table.rows.length;

	for (var i = 1; i < rowLength; i += 1) {
		var row = table.rows[i];

		var pushContactObj = {
			"conFname": row.cells[0].innerHTML,
			"conLname": row.cells[1].innerHTML,
			"conPhone": row.cells[2].innerHTML,
			"conEmail": row.cells[3].innerHTML
		}
		contactDetailsArray.push(pushContactObj);
	}


	if (contactDetailsArray.length == 0 && partnerType != "Ad-Hoc") {
		swal.fire("Alert", "please add contactDetails....", "warning")

		return regex.test(inputvalues);
	}


	var itrDetailsArray = [];
	table = document.getElementById('addITRGrid');
	rowLength = table.rows.length;
	/* 
				for (var i = 1; i < rowLength; i += 1) {
					var row = table.rows[i];
	
					var pushItrObj = {
						"fyYear": row.cells[0].innerHTML,
						"acknowledgementNumber": row.cells[1].innerHTML
					}
					itrDetailsArray.push(pushItrObj);
				} */



	$body.addClass("loading");

	var step1Obj = FormDataToJSON('stepOneForm');

	step1Obj.id = id;




	var step6Obj = FormDataToJSON('stepSixForm');
	//var step8Obj = FormDataToJSON('StepEightForm');
	var step7Obj = FormDataToJSON('stepSevenForm');



	const finalObj = {
		step1Obj,
		step6Obj,
		step7Obj
		//...step8Obj
	};
	finalObj.accountDetails = accountDetailsArray;
	finalObj.addressDetails = addressDetailsArray;
	finalObj.contactDetails = contactDetailsArray;
	finalObj.itrDetails = itrDetailsArray;


	console.log("finalObj" + finalObj);


	if (document.getElementById("GSTFile").files.length > 0) {
		finalObj.gstFileName = document.getElementById("GSTFile").files.item(0).name;
		finalObj.gstFileText = $("#GSTFileText").val();
	}
	if (document.getElementById("PDFile").files.length > 0) {
		finalObj.pdFileName = document.getElementById("PDFile").files.item(0).name;
		finalObj.pdFileText = $("#PDFileText").val();
	}
	if (document.getElementById("PANFile").files.length > 0) {
		finalObj.pANFileName = document.getElementById("PANFile").files.item(0).name;
		finalObj.pANFileText = $("#PANFileText").val();
	}
	if (document.getElementById("CCFile").files.length > 0) {
		finalObj.ccFileName = document.getElementById("CCFile").files.item(0).name;
		finalObj.ccFileText = $("#CCFileText").val();
	}
	if (document.getElementById("ACFile").files.length > 0) {
		finalObj.acFileName = document.getElementById("ACFile").files.item(0).name;
		finalObj.acFileText = $("#ACFileText").val();
	}
	if (document.getElementById("APLFile").files.length > 0) {
		finalObj.aplFileName = document.getElementById("APLFile").files.item(0).name;
		finalObj.aplFileText = $("#APLFileText").val();
	}
	if (document.getElementById("ITRFile").files.length > 0) {
		finalObj.itrFileName = document.getElementById("ITRFile").files.item(0).name;
		finalObj.itrFileText = $("#ITRFileText").val();
	}
	if (document.getElementById("FUVFFile").files.length > 0) {
		finalObj.fuvfFileName = document.getElementById("FUVFFile").files.item(0).name;
		finalObj.fuvfFileText = $("#FUVFFileText").val();
	}
	if (document.getElementById("MSMECFile").files.length > 0) {
		finalObj.msmecFileName = document.getElementById("MSMECFile").files.item(0).name;
		finalObj.msmecFileText = $("#MSMECFileText").val();
	}
	if (document.getElementById("AMFile").files.length > 0) {
		finalObj.amFileName = document.getElementById("AMFile").files.item(0).name;
		finalObj.amFileText = $("#AMFileText").val();
	}
	// last three year ITR file upload
	if (document.getElementById("ITRFile1").files.length > 0) {
		finalObj.itraFileName1 = document.getElementById("ITRFile1").files.item(0).name;
		finalObj.itraFileText1 = $("#ITRFileText1").val();
	}
	if (document.getElementById("ITRFile2").files.length > 0) {
		finalObj.itraFileName2 = document.getElementById("ITRFile2").files.item(0).name;
		finalObj.itraFileText2 = $("#ITRFileText2").val();
	}
	if (document.getElementById("ITRFile3").files.length > 0) {
		finalObj.itraFileName3 = document.getElementById("ITRFile3").files.item(0).name;
		finalObj.itraFileText3 = $("#ITRFileText3").val();
	}
	if (document.getElementById("NMISFile").files.length > 0) {
		finalObj.nmisFileName = document.getElementById("NMISFile").files.item(0).name;
		finalObj.nmisFileText = $("#NMISFileText").val();
	}


	var checked = []

	checked = document.getElementById("roleId").value


	/*  $("input[name='option[]']:checked").each(function() {
		 checked.push($(this).val());
	 }); */

	/*  $("input[name='vendorType[]']:value").each(function() {
		 checked.push($(this).val());
	 });

	/*  $("#vendorType").value {
		 checked.push($(this).val());
	 }); */



	var values = document.getElementById("roleId").value;
	console.log("value vendorType : " + values);
	finalObj.vendorType = values;



	var value = [];
	$("#region :selected").each(function() {
		value.push($(this).val());
	});
	if (value.includes("CRO") || value.includes("ERO")) {//ERO
		finalObj.ero = "Y";

	} if (value.includes("WRO")) {
		finalObj.wro = "Y";
	} if (value.includes("NRO")) {
		finalObj.nro = "Y";
	} if (value.includes("SRO1") || value.includes("SRO2")) {//SRO
		finalObj.sro = "Y";
	} if (value.includes("IHQ")) {
		finalObj.ihq = "Y";
	}


	var value1 = [];
	$("#flag :selected").each(function() {
		value.push($(this).val());
	});
	if (value.includes("ADDRESS_PURCHASING")) {
		finalObj.addressPurchasingFlag = "Y";

	} if (value.includes("ADDRESS_PAYMENT")) {
		finalObj.addressPaymentFlag = "Y";
	} if (value.includes("INVOICE_PREVALIDATED")) {
		finalObj.invoicePrevalidatedFlag = "Y";
	}


	var val = document.getElementById("states").value
	if (val.toLowerCase() == "network") {
		finalObj.glCode = "203101";
	} else if (val.toLowerCase() == "other expenses") {
		finalObj.glCode = "203104";
	} else if (val.toLowerCase() == "rent") {
		finalObj.glCode = "203102";
	} else if (val.toLowerCase() == "fixed assets") {
		finalObj.glCode = "203105";
	} else if (val.toLowerCase() == "courier") {
		finalObj.glCode = "203103";
	} else if (val.toLowerCase() == "employee nominee") {
		finalObj.glCode = "203108";
	}

	var acknowledgementNumber1 = $('#acknowledgementNumber1').val();
	var acknowledgementNumber2 = $('#acknowledgementNumber2').val();
	var acknowledgementNumber3 = $('#acknowledgementNumber3').val();

	var fyYear1 = $('#fyYear1').val();
	var fyYear2 = $('#fyYear2').val();
	var fyYear3 = $('#fyYear3').val();

	finalObj.fyYear1 = fyYear1;
	finalObj.fyYear2 = fyYear2;
	finalObj.fyYear3 = fyYear3;

	finalObj.acknowledgementNumber1 = acknowledgementNumber1;
	finalObj.acknowledgementNumber2 = acknowledgementNumber2;
	finalObj.acknowledgementNumber3 = acknowledgementNumber3;
	finalObj.vendorType = vendorTypeString;

	console.log("finalObj", finalObj.vendorType);

	$('.loader').show();

	$.ajax({
		type: "POST",
		data: JSON.stringify(finalObj),
		url: "ajaxController/SaveRegistration",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		success: function(response) {
			//return;
			$('.loader').hide();
			//$('userModal').hide();
			if (response.msg == 'success') {

				swal.fire("Thanks", "Vendor Update  Sucessfully", "success", "OK");
				$("#userModal").modal('hide');


				setTimeout(function(response) {
					//location.href = "login";
				}, 1000000);
			} else {
				alert("failed");
			}
		},
		error: function(jqXHR, textStatue, errorThrown) {
			Swal.fire({
				icon: 'error',
				title: 'Oops...',
				text: 'Something went wrong!',
			})
		}
	});
}

if (window.File && window.FileReader && window.FileList && window.Blob) {
	/* document.getElementById('CICFile').addEventListener('change', handleFileSelect, false);
	document.getElementById('GSTFile').addEventListener('change', handleFileSelect, false);
	document.getElementById('TDSFile').addEventListener('change', handleFileSelect, false);
	document.getElementById('PANFile').addEventListener('change', handleFileSelect, false);
	document.getElementById('CCFile').addEventListener('change', handleFileSelect, false); */
} else {
	alert('The File APIs are not fully supported in this browser.');
}


function showHideRequiredClass() {
	//alert($("#partnerType").val());
	if ($("#partnerType").val() == "Scheduled") {
		//alert("ji..");
		$(".required").css("visibility", "visible");
		$("#updateBtn").attr("disabled", true);
	} else {
		$(".required").css("visibility", "hidden");
		$(".adHocRequired").css("visibility", "visible");
		$("#updateBtn").attr("disabled", false);
		//alert("ji..2");
	}
}




function removeValCssByID(controlName) {
	$('#' + controlName.id).css({
		'border': '1px solid #b7b7b7',
		'box-shadow': 'none',
		'-webkit-box-shadow': 'none'
	});
}



function notifyTooltip(controlName, tooltipMessage, tooltipPlacement) {
	try {
		if (controlName != null && controlName != '' && tooltipMessage != null && tooltipMessage != '' && tooltipPlacement != null && tooltipPlacement != '') {

			/* $("#" + controlName).notify(
				 tooltipMessage, {
					 autoHideDelay: 3500,
					 position: tooltipPlacement
				 }
			 );*/
			$('#manPara').css('display', '');
			addValCss(controlName);
			$("#" + controlName).focus();
		} else {
			console.log('Values Are Passed As Empty Or Null In notifyTooltip()');
		}
	} catch (err) {

	}
}

$("#panNumber").change(function() {
	var inputvalues = $(this).val();
	var regex = /[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
	if (!regex.test(inputvalues)) {
		$("#panNumber").val("");
		swal.fire("", "Invalid PAN Number", "warning");
		return regex.test(inputvalues);
	}
});
$("#tanNumber").change(function() {
	var inputvalues = $(this).val();
	var regex = /[A-Za-z]{4}[0-9]{5}[A-Za-z]{1}/;
	if (!regex.test(inputvalues)) {
		$("#tanNumber").val("");
		swal.fire("", "Invalid TAN Number", "warning");
		return regex.test(inputvalues);
	}
});
$("#phoneNumber").change(function() {
	var inputvalues = $(this).val();
	var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
	if (!regex.test(inputvalues)) {
		$("#phoneNumber").val("");
		swal.fire("", "Invalid Phone Number", "warning");
		return regex.test(inputvalues);
	}
});

$("#conPhone").change(function() {
	var inputvalues = $(this).val();
	var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
	if (!regex.test(inputvalues)) {
		$("#conPhone").val("");
		swal.fire("", "Invalid Phone Number", "warning");
		return regex.test(inputvalues);
	}
});

$("#suppName").keypress(function(event) {
	var inputValue = event.which;
	//alert(inputValue);
	if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0) && !(inputValue >= 37 && inputValue <= 47)) {
		event.preventDefault();
	}
	//event.preventDefault();
});


$("#city").keypress(function(event) {
	var inputValue = event.which;
	//alert(inputValue);
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});


$(document).ready(function() {
	$("#ifscCode").change(function() {
		var inputvalues = $(this).val();
		var regex = /^[A-Z]{4}0[A-Z0-9]{6}$/;
		if (!regex.test(inputvalues)) {
			$("#ifscCode").val("");

			swal.fire("Alert", "Invalid IFSC Code", "warning");
			return regex.test(inputvalues);
		}
	});
});


$("#conFname").keypress(function(event) {
	var inputValue = event.which;
	//alert(inputValue);
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});


$(function() {
	$('#conLname').on('keypress', function(e) {
		if (e.which == 32) {
			console.log('Space Detected');
			return false;
		}
	});
});


$("#conLname").keypress(function(event) {
	var inputValue = event.which;
	//alert(inputValue);
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});


$("#bankName").keypress(function(event) {
	var inputValue = event.which;
	//alert(inputValue);
	if (inputValue == 8) {

	} else if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) {
		event.preventDefault();
	}
});
var matchFlag = 0;
$(function() {
	$("#confirmedAccoutNumber").keyup(function() {
		var password = $("#accoutNumber").val();
		var passwordConfirm = $("#confirmedAccoutNumber").val();
		var passflag = $("#passflag").val();

		if (password != "" && passwordConfirm != "") {
			if ($('#accoutNumber').val() == $('#confirmedAccoutNumber').val() && passflag != "1") {
				$('#divCheckPasswordMatch').html('Account number match.').css('color', 'green');
				// Enable #x	
				$("#addBankGridButt").prop("disabled", false)

			}
			else {

				$('#divCheckPasswordMatch').html('Account number do not match!').css('color', 'red');
				matchFlag = 1;

				// Disable #x
				$('#addBankGridButt').attr('disabled', true);

				return;

			}
		}

	});
});

$(function() {
	$("#accoutNumber").keyup(function() {
		var password = $("#accoutNumber").val();
		var passwordConfirm = $("#confirmedAccoutNumber").val();
		var passflag = $("#passflag").val();

		if (password != "" || passwordConfirm != "") {
			if ($('#accoutNumber').val() == $('#confirmedAccoutNumber').val() && passflag != "1") {
				$('#divCheckPasswordMatch').html('Account number match.').css('color', 'green');
				// Enable #x	
				$("#addBankGridButt").prop("disabled", false)

			}
			else {
				if (matchFlag == 1) {
					$('#divCheckPasswordMatch').html('Account number does not match!').css('color', 'red');
					// Disable #x
					$('#addBankGridButt').attr('disabled', true);

					return;
				}
			}
		}
	});
});
$(document).ready(function() {
	$("#accoutNumber").change(function() {
		var accoutNumber = document.getElementById("accoutNumber").value;
		var a = /^\d{1}$/;
		var b = /^\d{2}$/;
		var c = /^\d{3}$/;
		if (accoutNumber != '') {
			if (accoutNumber.match(a) || accoutNumber.match(b) || accoutNumber.match(c)) {
				swal.fire("", " Invalid Account Number", "warning");
				$("#accoutNumber").val('');
				$("#confirmedAccoutNumber").val('');
				$("#accoutNumber").focus();
			} else {

				return true;
			}
		}
	});
});


$(document).ready(function() {
	$("#compGstn").change(function() {
		var inputvalues = $(this).val();
		var regex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;
		if (!regex.test(inputvalues)) {
			$("#compGstn").val("");

			swal.fire("Alert", "Invalid GSTIN Number", "warning");
			return regex.test(inputvalues);
		}
	});
});

$(document).ready(function() {
	$("#aadharNumber").change(function() {
		var aadhar = document.getElementById("aadharNumber").value;
		var adharcardTwelveDigit = /^\d{12}$/;
		var adharSixteenDigit = /^\d{16}$/;
		if (aadhar != '') {
			if (aadhar.match(adharcardTwelveDigit)) {
				return true;
			} else if (aadhar.match(adharSixteenDigit)) {
				return true;
			} else {
				swal.fire("", " Invalid Aadhar Number", "warning");
				$("#aadharNumber").val('');
				$("#aadharNumber").focus();
				//return false;
			}
		}
	});
});


function inactiveActiveDeleteData(bpcode, name) {

	let text = "Are You sure to delete " + name;
	if (confirm(text) != true) {


		return false;
	}



	var json = {
		"bpCode": bpcode,
		"status": "0"
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/setStatusOfVendorByBpCode",
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

function select() {

	var element = document.getElementById('states');
	var element = [...element.options].filter(ele => ele.selected).map(ele => ele.text);
	var selectedValues = [];
	$("#states :selected").each(function() {
		selectedValues.push($(this).val());
	});
	// alert(selectedValues);

	let values = selectedValues.toString();

	document.getElementById("roleId").value = values;
	//alert("roleId111: "+num);


	var val = document.getElementById("states").value
	if (val == "Network") {
		document.getElementById("partnerType").disabled = false;
		document.getElementById("partnerType").value = "Scheduled";
	} else {
		document.getElementById("partnerType").disabled = true;
		document.getElementById("partnerType").value = "";

	}

}

function MESMENumber() {

	var busClassif = $("#businessClassification").val();


	if (busClassif == "Other Enterprise" || busClassif == "") {

		document.getElementById("mesmeNumber").disabled = true;
		document.getElementById("mesmeNumber").value = "";
	}
	else {
		document.getElementById("mesmeNumber").disabled = false;
		document.getElementById("mesmeNumber").value = "";

	}
}

function region1() {

}

function checkForExistingPanNumber() {
	var PanNumberCheckStatus = "false";
	var panNumber = $("#panNumber").val();
	if (panNumber != "") {
		var json = {
			"panNumber": panNumber,
			"flag": "Active"
		}

		$.ajax({
			type: "GET",
			data: json,
			url: "ajaxController/checkExistingPan",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",
			async: false,
			success: function(data) {
				if (data.msg == 'exist') {
					swal.fire("Alert", "<b>" + panNumber + "</b> This Pan Number is Already Exists", "warning");
					document.getElementById("panNumber").focus();
					$("#panNumber").val('');
				} else if (data.msg == 'success') {
					PanNumberCheckStatus = "true";
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
	return PanNumberCheckStatus;
}

function checkForExistingVendorCode() {

	var vendorCodeCheckStatus = "false";
	var bpCode = $("#bpCode").val();
	var suppName = $("#suppName").val();
	if (bpCode != "") {
		var json = {
			"bpCode": bpCode,
			"suppName": suppName

		}

		console.log(json);

		$.ajax({
			type: "GET",
			data: json,
			url: "ajaxController/checkVendorCode",
			dataType: "json",
			headers: { 'X-XSRF-TOKEN': csrfToken },
			contentType: "application/json",
			async: false,
			success: function(data) {
				if (data.msg == 'exist') {
					swal.fire("Alert", "<b>" + bpCode + "</b> This Vendor Code is Already Exists", "warning");
					document.getElementById("bpCode").focus();
					$("#bpCode").val('');
				} else if (data.msg == 'success') {
					vendorCodeCheckStatus = "true";
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
	return vendorCodeCheckStatus;
}

function vendorPasswordChange(val) {
	console.log(val);
	var json = {
		"bpCode": val
	}
	$.ajax({
		type: "POST",
		data: JSON.stringify(json),
		url: "userController/changeVenPass",
		dataType: "json",
		headers: { 'X-XSRF-TOKEN': csrfToken },
		contentType: "application/json",
		async: false,
		success: function(data) {
			if (data.msg == 'success') {
				swal.fire("", "<b>" + val + "</b><br> Password send successfully", "success");
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

  function viewAttachment(){
			
			$("#pdfLink").contents().find("body").html("");
			$('#pdfLink').attr('src', '');
		    $('#ifrmameHref').attr('href', '');
			
			$("#viewAttachmentPopUp").modal('show');													
			$("#multipleAttachment").empty();
				
				var docNameList = "";
				var docPathList = "";
				
				$("#multipleAttachment").empty();
					var option = "";
				
							for (var i = 0; i < documentArray2.length; i++) {
					            option += " <option value='" + documentArray2[i].file + "'>" + documentArray2[i].filename + "</option>"
					        }									
						
						$("#multipleAttachment").append(option);							
					
						  var fileName = $("#multipleAttachment option:selected").text();
						    var filePath = $("#multipleAttachment").val();
						  					
					 fileName = encodeURIComponent(fileName);
				     filePath = encodeURIComponent(filePath);					    
				    var ctx = $("#contextPathURL").val();
				    var urlPath = "<%=GlobalUrl.getDoc%>"					    
				    var urlpath = ctx + "/"+urlPath+"?name=" + fileName+"&path="+filePath;

					$('#pdfLink').attr('src', urlpath);
				    $('#ifrmameHref').attr('href', urlpath);
		}
		

		$("#multipleAttachment").change(function () {
		    var fileNameAndPath = $("#multipleAttachment").val();			    
		    var fileName = $("#multipleAttachment option:selected").text();
		    var filePath = $("#multipleAttachment").val();
		    
		     fileName = encodeURIComponent(fileName);
		     filePath = encodeURIComponent(filePath);
		    var ctx = $("#contextPathURL").val();
		    
		    var urlPath = "<%=GlobalUrl.getDoc %>"
			var urlpath = ctx + "/"+urlPath+"?name=" + fileName+"&path="+filePath;
		    
		    $('#pdfLink').attr('src', urlpath);
		    $('#ifrmameHref').attr('href', urlpath);

		});	