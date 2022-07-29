<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|Vendor Reports</title>

<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet" href="dist/css/ionicons.min.css">
<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<link rel="stylesheet"
	href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
<link rel="stylesheet" href="dist/css/adminlte.min.css">
<link rel="stylesheet"
	href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<link rel="stylesheet"
	href="plugins/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css"
	href="plugins/jquery-ui/jquery-ui.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
	rel="stylesheet">
<link rel="stylesheet" href="plugins/select2/css/select2.min.css">
<link rel="stylesheet"
	href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
<link rel="stylesheet"
	href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
<link rel="stylesheet" href="plugins/toastr/toastr.min.css">

<style>
custom-file-input {
	height: 25px;
	font-size: 14px;
}

.custom-file {
	height: 25px;
	font-size: 14px;
	padding-bottom: 35px;
	font-size: 14px;
}

.custom-file-label::after {
	height: auto !important;
}

.custom-file-label {
	padding-bottom: 23px;
	height: 25px;
	font-size: 14px;
}

.tableheading {
	font-size: 15px;
	font-weight: bold;
}

label {
	font-weight: 500;
	margin-bottom: 1px;
}

.form-control {
	height: 25px;
	font-size: 14px;
}

tbody {
	font-size: 12.9px;
}

.table td, .table th {
	vertical-align: top;
	border-top: 1px solid #dee2e6;
	padding: 5px 5px 0px 1.5rem;
}

.observedScoreheading {
	width: 60px !important;
}

.serialNoheading {
	width: 60px !important;
}

.documentheading {
	width: 500px;
}

.attachmentheading {
	width: 500px;
}

.helpheading {
	width: 60px !important;
}

.tooltip.show p {
	text-align: left;
}

/* date picker dropdown is hiding .. thats y added the below style */
#ui-datepicker-div {
	z-index: 1000 !important;
}
/*  date picker style ended */
</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
	<jsp:include page="loader.jsp" />
	<div class="wrapper">

		<!-- Navbar -->
        <jsp:include page="navbar.jsp?pagename=Vendor Details" />
        <!-- /.navbar -->

		<%
		String rolename = (String) request.getSession().getAttribute("role");
		%>
		<c:choose>
			<c:when test='<%=rolename.equalsIgnoreCase("Admin")%>'>
				<jsp:include page="sidebar_Admin.jsp?pagename=vendorReports" />
			</c:when>
			<c:otherwise>
				<jsp:include page="slidebar_Finance.jsp?pagename=vendorReports" />
			</c:otherwise>
		</c:choose>



		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6"></div>
						<div class="col-sm-6"></div>
					</div>
				</div>
			</div>

			<!-- /.content-header -->


			<!-- Main content -->
			<section class="content mt-2">
				<div class="container-fluid">

					<div class="row">
						<div class="col-md-12" style="font-size: 14px;">
							<!-- general form elements -->
							<div class="card card-primary ">
								<!-- /.card-header -->
								<div class="card-body ">
									<form role="form" id="addForm" autocomplete="off">
										<div class="row">

											<div class="col-md-1">
												<div class="dropdown">
													<button type="button"
														class="btn btn-primary dropdown-toggle"
														style="margin-bottom: 10px; margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
														data-toggle="dropdown">Export Details</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="#" id="exportLinkPdf">Download
															PDF</a> <a class="dropdown-item" href="#" id="exportLink">Download
															Excel</a>
													</div>
												</div>
											</div>
											<div class="col-md-9"></div>
											<div class="col-md-2">
												<div class="form-group row">
													<label class="col-md-4">Search : </label>
													<div class="col-md-8">
														<input type="text" name="searchData" placeholder="Search"
															class="form-control" id="searchData">
													</div>
												</div>
											</div>
										</div>
									</form>
									<table
										class="display nowrap table table-head-fixed table-bordered table-hover"
										id="tabledata" style="width: 100%">
										<thead>
											<tr>
												<th class="bg-primary">Supplier_Number</th>
												<th class="bg-primary">Supplier_name</th>
												<th class="bg-primary">Supplier_site_code</th>
												<th class="bg-primary">Address_line1</th>
												<th class="bg-primary">Address_line2</th>
												<th class="bg-primary">Address_line3</th>
												<th class="bg-primary">Address_line4</th>
												<th class="bg-primary">CitY</th>
												<th class="bg-primary">State</th>
												<th class="bg-primary">Pin Code</th>
												<th class="bg-primary">CountrY</th>
												<th class="bg-primary">Landline_Number</th>
												<th class="bg-primary">Mobile_Number</th>
												<th class="bg-primary">Email address</th>
												<th class="bg-primary">PAN_Number</th>
												<th class="bg-primary">TAN_Number</th>
												<th class="bg-primary">CST_Registration_Number</th>
												<th class="bg-primary">LST_Registration_Number</th>
												<th class="bg-primary">ST_Registration_Number</th>
												<th class="bg-primary">VAT_Registration_Number</th>
												<th class="bg-primary">Bank_Name</th>
												<th class="bg-primary">Bank_Number</th>
												<th class="bg-primary">Institution_TYpe</th>
												<th class="bg-primary">CountrY_Code</th>
												<th class="bg-primary">Branch_Name</th>
												<th class="bg-primary">Branch_Number</th>
												<th class="bg-primary">CurrencY</th>
												<th class="bg-primary">Account_Name</th>
												<th class="bg-primary">Account_Number</th>
												<th class="bg-primary">IFSC_Code</th>
												<th class="bg-primary">Website</th>
												<th class="bg-primary">Contact_Person</th>
												<th class="bg-primary">Alternate_Supplier_Name</th>
												<th class="bg-primary">Alias</th>
												<th class="bg-primary">SRO</th>
												<th class="bg-primary">WRO</th>
												<th class="bg-primary">NRO</th>
												<th class="bg-primary">ERO</th>
												<th class="bg-primary">DHQ</th>
												<th class="bg-primary">SECTION_TYPE</th>
												<th class="bg-primary">SECTION_CODE</th>
												<th class="bg-primary">TDS_VENDOR_TYPE_LOOKUP_CODE</th>
												<th class="bg-primary">SUPPLIER_TYPE</th>
												<th class="bg-primary">GLCODE</th>
												<th class="bg-primary">SUPPLIER_GST_REGISTRATION_NUM</th>
												<th class="bg-primary">All_invoice_flag</th>
												<th class="bg-primary">Unmatched_Invoice_flag</th>
												<th class="bg-primary">Unvalidated_Invoice_flag</th>
												<th class="bg-primary">ADDRESS_PURCHASING_FLAG</th>
												<th class="bg-primary">ADDRESS_PAYMENT_FLAG</th>
												<th class="bg-primary">ADDRESS_RFQ_FLAG</th>
												<th class="bg-primary">INVOICE_PREVALIDATED_FLAG</th>
												<th class="bg-primary">INVOICE_PREAPPROVED_FLAG</th>
												<th class="bg-primary">PAYMENT_METHOD_CODE</th>
												<th class="bg-primary">PAYMENT_TERM</th>
												<th class="bg-primary">Business Classification</th>
												<th class="bg-primary">Certificate No. (if MSME Yes)</th>
												<th class="bg-primary">Aadhar Number</th>
												<th class="bg-primary">Aadhar Link Status</th>
												<th class="bg-primary">ITR_Acknowledgement_Number_FY19</th>
												<th class="bg-primary">ITR_Acknowledgement_Number_FY20</th>
												<th class="bg-primary">ITR_Acknowledgement_Number_FY21</th>

											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
							</div>
						</div>
					</div>
				</div>
			</section>

		</div>
		<!-- ./wrapper -->

		<script src="plugins/jquery/jquery.min.js"></script>
		<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
		<script>
			$.widget.bridge('uibutton', $.ui.button);
			$.widget.bridge('uitooltip', $.ui.tooltip);
		</script>
		<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
		<script src="js/commonFunctions.js"></script>
		<script src="js/common.js"></script>
		<script src="plugins/sparklines/sparkline.js"></script>
		<script src="plugins/moment/moment.min.js"></script>
		<script src="plugins/daterangepicker/daterangepicker.js"></script>
		<script
			src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
		<script
			src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
		<script src="dist/js/adminlte.js"></script>
		<script src="dist/js/demo.js"></script>
		<script src="js/moment.min.js"></script>
		<script src="plugins/select2/js/select2.full.min.js"></script>
		<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
		<script src="plugins/jquery-validation/additional-methods.min.js"></script>
		<script src="plugins/datatables/jquery.dataTables.js"></script>
		<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
		<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
		<script src="plugins/toastr/toastr.min.js"></script>

		<script src="plugins/datatables/jquery.dataTables.js"></script>
		<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
		<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
		<script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
		<script src="plugins/pdfmake/pdfmake.min.js"></script>
		<script src="plugins/pdfmake/vfs_fonts.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

		<script type="text/javascript">
			const Toast = Swal.mixin({
				toast : true,
				position : 'top-end',
				showConfirmButton : false,
				timer : 3000
			});

			var currentDate = '${currentDate}';
			var dataLimit = '${dataLimit}';
			dataLimit = parseInt(dataLimit);

			var tabledata = $('#tabledata').DataTable({

				"paging" : true,
				"lengthChange" : false,
				"searching" : true,
				"info" : true,
				"autoWidth" : false,
				"aaSorting" : [],
				"scrollX" : true,
				"pageLength" : dataLimit,
				dom : 'Bfrtip',
				//buttons: ['excel','pdf','print'],
				buttons : [

				{
					extend : 'excelHtml5',

					exportOptions : {
						columns : [ 0, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61],
					}
				}, {
					extend : 'pdfHtml5',
					orientation : 'landscape',
					pageSize : 'A4',
					exportOptions : {
						columns : [ 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61 ],
					},
					customize : function(doc) {

						var tblBody = doc.content[1].table.body;
						for (var i = 0; i < tblBody[0].length; i++) {
							//	 console.log(tblBody[0]);
							//	 console.log(tblBody[0][i]);
							tblBody[0][i].fillColor = '#FFFFFF';
							tblBody[0][i].color = 'black';
						}

						var objLayout = {};
						objLayout['hLineWidth'] = function(i) {
							return .5;
						};
						objLayout['vLineWidth'] = function(i) {
							return .5;
						};
						objLayout['hLineColor'] = function(i) {
							return '#aaa';
						};
						objLayout['vLineColor'] = function(i) {
							return '#aaa';
						};
						objLayout['paddingLeft'] = function(i) {
							return 4;
						};
						objLayout['paddingRight'] = function(i) {
							return 4;
						};
						doc.content[1].layout = objLayout;
						var obj = {};
						obj['hLineWidth'] = function(i) {
							return .5;
						};
						obj['hLineColor'] = function(i) {
							return '#aaa';
						};
						//   doc.content[1].margin = [ 150, 0, 150, 0 ];

					}
				} ],
				initComplete : function() {
					var $buttons = $('.dt-buttons').hide();
					$('#exportLink').on('click', function() {
						var btnClass = "excel" ? '.buttons-' + "excel" : null;
						if (btnClass)
							$buttons.find(btnClass).click();
					})

					$('#exportLinkPdf').on('click', function() {
						var btnClass = "pdf" ? '.buttons-' + "pdf" : null;
						if (btnClass)
							$buttons.find(btnClass).click();
					})
				}
			});

			$('#searchData').on('keyup', function() {
				tabledata.search(this.value).draw();
			});

			$('#tabledata_filter').css("display", "none");
			
			getData();
			
			function getData(){
				$('.loader').show();

                $.ajax({
                    type: "POST",
                    data: "",
                    url: "<%=GlobalUrl.getAllApprovedVendor%>",
                    dataType: "json",
                    contentType: "application/json",
                    success: function(data) {
                        $('.loader').hide();
                        if (data.msg == 'success') {
                            var result = data.data;
                            tabledata.clear();
                            for (var i = 0; i < result.length; i++) {
                            	 for (var j = 0; j < result[i].addressDetails.length; j++) {
                            		 if(!result[i].hasOwnProperty("bpCode")){
                            			 result[i].bpCode="";
                            		 }
                            		 if(!result[i].hasOwnProperty("suppName")){
                            			 result[i].suppName="";
                            		 }
                            		 if(!result[i].addressDetails[j].hasOwnProperty("supplierSiteCode")){
                            			 result[i].addressDetails[j].supplierSiteCode="";
                            		 }
                            		 if(!result[i].addressDetails[j].hasOwnProperty("addDetails")){
                            			 result[i].addressDetails[j].addDetails="";
                            		 }
                            		 if(!result[i].addressDetails[j].hasOwnProperty("city")){
                            			 result[i].addressDetails[j].city="";
                            		 }
                            		 if(!result[i].addressDetails[j].hasOwnProperty("state")){
                            			 result[i].addressDetails[j].state="";
                            		 }
                            		 if(!result[i].addressDetails[j].hasOwnProperty("pinCode")){
                            			 result[i].addressDetails[j].pinCode="";
                            		 }
                            		 if(!result[i].contactDetails[0].hasOwnProperty("conPhone")){
                            			 result[i].contactDetails[0].conPhone="";
                            		 }
                            		 if(!result[i].contactDetails[0].hasOwnProperty("conEmail")){
                            			 result[i].contactDetails[0].conEmail="";
                            		 }
                            		 if(!result[i].contactDetails[0].hasOwnProperty("conFname")){
                            			 result[i].contactDetails[0].conFname="";
                            		 }
                            		 if(!result[i].contactDetails[0].hasOwnProperty("conLname")){
                            			 result[i].contactDetails[0].conLname="";
                            		 }
                            		 if(!result[i].hasOwnProperty("panNumber")){
                            			 result[i].panNumber="";
                            		 }
                            		 if(!result[i].hasOwnProperty("tanNumber")){
                            			 result[i].tanNumber="";
                            		 }
                            		 if(!result[i].accountDetails[0].hasOwnProperty("bankName")){
                            			 result[i].accountDetails[0].bankName="";
                            		 }
                            		 if(!result[i].accountDetails[0].hasOwnProperty("ifscCode")){
                            			 result[i].accountDetails[0].ifscCode="";
                            		 }
                            		 if(!result[i].accountDetails[0].hasOwnProperty("accoutCurrency")){
                            			 result[i].accountDetails[0].accoutCurrency="";
                            		 }
                            		 if(!result[i].accountDetails[0].hasOwnProperty("beneficiaryName")){
                            			 result[i].accountDetails[0].beneficiaryName="";
                            		 }
                            		 if(!result[i].accountDetails[0].hasOwnProperty("accoutNumber")){
                            			 result[i].accountDetails[0].accoutNumber="";
                            		 }
                            		 if(!result[i].hasOwnProperty("sro")){
                            			 result[i].sro="";
                            		 }
                            		 if(!result[i].hasOwnProperty("wro")){
                            			 result[i].wro="";
                            		 }
                            		 if(!result[i].hasOwnProperty("nro")){
                            			 result[i].nro="";
                            		 }
                            		 if(!result[i].hasOwnProperty("ero")){
                            			 result[i].ero="";
                            		 }
                            		 if(!result[i].hasOwnProperty("dhq")){
                            			 result[i].dhq="";
                            		 }
                            		 if(!result[i].hasOwnProperty("sectionType")){
                            			 result[i].sectionType="";
                            		 }
                            		 if(!result[i].hasOwnProperty("creditTerms")){
                            			 result[i].creditTerms="";
                            		 }
                            		 if(!result[i].hasOwnProperty("businessClassification")){
                            			 result[i].businessClassification="";
                            		 }
                            		 if(!result[i].hasOwnProperty("mesmeNumber")){
                            			 result[i].mesmeNumber="";
                            		 }
                            		 if(!result[i].hasOwnProperty("aadharNumber")){
                            			 result[i].aadharNumber="";
                            		 }
                            		 if(!result[i].hasOwnProperty("adharLinkStatus")){
                            			 result[i].adharLinkStatus="";
                            		 }
                            		 if(!result[i].hasOwnProperty("acknowledgementNumber1")){
                            			 result[i].acknowledgementNumber1="";
                            		 }
                            		 if(!result[i].hasOwnProperty("acknowledgementNumber2")){
                            			 result[i].acknowledgementNumber2="";
                            		 }
                            		 if(!result[i].hasOwnProperty("acknowledgementNumber3")){
                            			 result[i].acknowledgementNumber3="";
                            		 }
                            		 var paymentMethod=result[i].paymentMethod;

                            		 if(paymentMethod=="NEFT"){
                            			 paymentMethod="EFT";
                            		 }else if(paymentMethod=="ONLINE"){
                            			 paymentMethod=result[i].paymentMethod;
                            		 }
                            		 
                            	tabledata.row.add([
                            		result[i].bpCode,
                            		result[i].suppName,
                            		result[i].addressDetails[j].supplierSiteCode,
                            		result[i].addressDetails[j].addDetails,
                            		"",
                            		"",
                            		"",
                            		result[i].addressDetails[j].city,
                            		result[i].addressDetails[j].state,
                            		result[i].addressDetails[j].pinCode,
                            		"IN",
                            		"",
                            		result[i].contactDetails[0].conPhone,
                            		result[i].contactDetails[0].conEmail,
                            		result[i].panNumber,
                            		result[i].tanNumber,
                            		"",
                            		"",
                            		"",
                            		"",
                            		result[i].accountDetails[0].bankName,
                            		"",
                            		"BANK",
                            		"IN",
                            		result[i].accountDetails[0].ifscCode,
                            		result[i].accountDetails[0].ifscCode,
                            		result[i].accountDetails[0].accoutCurrency,
                            		result[i].accountDetails[0].beneficiaryName,
                            		"`"+result[i].accountDetails[0].accoutNumber,
                            		result[i].accountDetails[0].ifscCode,
                            		"",
                            		result[i].contactDetails[0].conFname+" "+ result[i].contactDetails[0].conLname,
                            		result[i].accountDetails[0].beneficiaryName,
                            		result[i].accountDetails[0].beneficiaryName,
                            		result[i].sro,
                            		result[i].wro,
                            		result[i].nro,
                            		result[i].ero,
                            		result[i].dhq,
                            		result[i].sectionType+"-IND",
                            		"",
                            		result[i].sectionType+"-IND",
                            		result[i].addressDetails[j].vendorType,
                            		result[i].addressDetails[j].glCode,
                            		result[i].addressDetails[j].compGstn,
                            		"",
                            		"",
                            		"",
                            		"Y",
                            		"Y",
                            		"",
                            		"Y",
                            		"",
                            		paymentMethod,
                            		result[i].creditTerms,
                            		result[i].businessClassification,
                            		result[i].mesmeNumber,
                            		result[i].aadharNumber,
                            		result[i].adharLinkStatus,
                            		result[i].acknowledgementNumber1,
                            		result[i].acknowledgementNumber2,
                            		result[i].acknowledgementNumber3
                            	]);
                            }
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
			
			
			
			
		</script>
</body>

</html>
