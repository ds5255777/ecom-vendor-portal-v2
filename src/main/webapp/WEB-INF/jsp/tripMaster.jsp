<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|MasterCheckList</title>

<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bbootstrap 4 -->
<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- iCheck -->
<link rel="stylesheet"
	href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- JQVMap -->
<link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet"
	href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="plugins/daterangepicker/daterangepicker.css">
<!-- summernote -->
<!-- <link rel="stylesheet" href="plugins/summernote/summernote-bs4.css"> -->



<!-- <link rel="stylesheet" type="text/css" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-buttons/css/buttons.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-select/css/select.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-fixedheader/css/fixedHeader.bootstrap4.css"> -->
<link rel="stylesheet" type="text/css"
	href="plugins/jquery-ui/jquery-ui.min.css">


<!-- Google Font: Source Sans Pro -->
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
label {
	font-weight: 500;
	margin-bottom: 1px;
}

.form-control {
	height: 35px;
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
</style>

<style>
/* changing select2 color  */
.select2-container--default .select2-purple .select2-selection--multiple .select2-selection__choice,
	.select2-purple .select2-container--default .select2-selection--multiple .select2-selection__choice
	{
	background-color: #006fe6;
	border-color: #006fe6;
	color: #fff;
}

.select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected],
	.select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected]:hover,
	.select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected],
	.select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected]:hover
	{
	background-color: #006fe6;
	color: #fff;
}
</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
<%
String adminRole = GlobalConstants.ROLE_ADMIN;
String financeRole = GlobalConstants.ROLE_FINANCE;

request.setAttribute("adminRole", adminRole);
request.setAttribute("financeRole", financeRole);

%>
	<jsp:include page="loader.jsp" />
	<div class="wrapper">

		<!-- Navbar -->
		<jsp:include page="navbar.jsp?pagename=Modify CheckList" />
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		 <%
    	String rolename = (String) request.getSession().getAttribute("role");
		 out.print(rolename);
        
        %>
        <c:choose>  
			    <c:when test='<%=rolename.equalsIgnoreCase(adminRole)%>'>  
					<jsp:include page="sidebar_Admin.jsp?pagename=masterEvaluationCriteria" />
				</c:when>  
			    <c:when test='<%=rolename.equalsIgnoreCase(financeRole)%>'>  
				<!-- Right navbar links -->
					<jsp:include page="slidebar_Finance.jsp?pagename=dashboard" />
				</c:when>
		</c:choose>
		<!-- /.navbar -->	

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<div class="input-group-prepend">

								<!--   <div class="btn-group">
                                    <div  style="font-size: 20px;font-weight: 500;" id="shiowStatusOfTicket">Master Bank Name</div>
                                </div> -->


							</div>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<!-- <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Dashboard v1</li> -->
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->
			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<!-- general form elements -->
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">Trip Master Details</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->
								<form role="form" id="addForm" autocomplete="off">
									<div class="card-body">
										<div class="row">
											<!-- <div class="col-md-2">
												<label>Zone</label> <select class="form-control" id="zone"
													name="zone">
													<option value="">-- Select --</option>
													<option value="East">East</option>
													<option value="West">West</option>
													<option value="Center">Center</option>
													<option value="South">South</option>
												</select>
											</div> -->

											<div class="col-md-2">
												<label>Route</label> <input type="text" name="route"
													class="form-control" id="route" maxlength="50" oninput="this.value = this.value.toUpperCase()">
											</div>

											<div class="col-md-2">
												<label>Vendor Name</label> <input type="text"
													name="vendorName" class="form-control" id="vendorName"
													pattern="[a-zA-Z. ]+" maxlength="50">
											</div>

											<div class="col-md-2">
												<label>Vendor Code</label> <input type="text"
													name="vendorCode" class="form-control" id="vendorCode" oninput="this.value = this.value.toUpperCase()">
											</div>

											<div class="col-md-2">
												<label>Type</label> <select class="form-control" id="type"
													name="type">
													<option value="">-- Select --</option>
													<option value="Line Haul">Line Haul</option>
													<!-- <option value="Milk Run">Milk Run</option> -->
												</select>
											</div>

											<div class="col-md-2">
												<label>Origin</label> <input type="text" name="city"
													class="form-control" id="city" pattern="[a-zA-Z0-9]+"
													maxlength="3" oninput="this.value = this.value.toUpperCase()">
											</div>

											<div class="col-md-2">
												<label>City Name</label> <input type="text" name="cityName"
													class="form-control" id="cityName">
											</div>

											<div class="col-md-2">
												<label>State</label> <input type="text" name="state"
													class="form-control" id="state">
											</div>

											<div class="col-md-2">
												<label>Vehicle Type</label> <input type="text"
													name="vehicleType" class="form-control" id="vehicleType"
													maxlength="50">
											</div>

											<div class="col-md-2">
												<label>Trip Cost</label> <input type="number"
													name="tripCost" class="form-control" id="tripCost"
													maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Rate </label> <input type="number" name="rate"
													class="form-control" id="rate" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Base Rate</label> <input type="number"
													name="baseRate" class="form-control" id="baseRate"
													maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Std. Mileage/KM</label> <input type="number"
													name="stdMileagePerKm" class="form-control"
													id="stdMileagePerKm" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Max KMS</label> <input type="number" name="maxKms"
													class="form-control" id="maxKms" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Agreement Made Date</label> <input type="date"
													name="agreementMadeDate" class="form-control"
													id="agreementMadeDate">
											</div>


											<div class="col-md-2">
												<label>Agreement Expiry date</label> <input type="date"
													name="agreementExpiryDate" class="form-control"
													id="agreementExpiryDate">
											</div>

											<div class="col-md-2">
												<label>Current Fuel Rate</label> <input type="number"
													name="currentFuelRate" class="form-control"
													id="currentFuelRate" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>FS Diff</label> <input type="text" name="fsDiff"
													class="form-control" id="fsDiff">
											</div>

										</div>
									</div>
									<!-- /.card-body -->

									<div class="card-footer" align="center">
										<button type="submit" id="submitBtn" class="btn btn-primary">Add</button>
									</div>
								</form>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-12">
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">Active Master</h3>
								</div>
								<!-- /.card-header -->
								<div class="card-body">
									<table id="tabledata"
										class="table table-bordered table-hover display nowrap">
										<thead>
											<tr>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
												</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
													Name</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
													Code</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Type</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Origin</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">City
													Name</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">State</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vehicle
													Type</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip
													Cost</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Rate</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Base
													Rate</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Mileage/Km</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Max
													Kms</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Fuel
													Rate</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS
													Diff</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Agreement
													Made Date</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Agreement
													Expiry Date</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Agreement
													Action</th>

											</tr>
										</thead>


									</table>
								</div>
								<!-- /.card-body -->
							</div>

						</div>
					</div>


				</div>

			</section>
			<!-- /.content -->

			<!-- /.content -->
		</div>


		<aside class="control-sidebar control-sidebar-dark"></aside>
	</div>



	<div class="modal fade" id="userModal" role="dialog">
		<div class="modal-dialog " style="max-width: 1300px;">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body">
					<!-- <div class="container-fluid panel1"> -->
					<div class="row">
						<div class="col-md-12">
							<!-- general form elements -->
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">Update Master Detail</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->

								<form role="form" id="updateMDMData" autocomplete="off">
									<div class="card-body">
										<div class="row">
											<!-- <div class="col-md-2">
												<label>Zone</label> <select class="form-control" id="zone"
													name="zone">
													<option value="">-- Select --</option>
													<option value="East">East</option>
													<option value="West">West</option>
													<option value="Center">Center</option>
													<option value="South">South</option>
												</select>
											</div> -->

											<div class="col-md-2">
												<label>Route</label> <input type="text" name="route"
													class="form-control" id="routeEdit" maxlength="50" oninput="this.value = this.value.toUpperCase()">
											</div>

											<div class="col-md-2">
												<label>Vendor Name</label> <input type="text"
													name="vendorName" class="form-control" id="vendorNameEdit"
													pattern="[a-zA-Z. ]+" maxlength="50">
											</div>

											<div class="col-md-2">
												<label>Vendor Code</label> <input type="text"
													name="vendorCode" class="form-control" id="vendorCodeEdit" oninput="this.value = this.value.toUpperCase()">
											</div>

											<div class="col-md-2">
												<label>Type</label> <select class="form-control" id="typeEdit"
													name="type">
													<option value="">-- Select --</option>
													<option value="Line Haul">Line Haul</option>
													<!-- <option value="Milk Run">Milk Run</option> -->
												</select>
											</div>

											<div class="col-md-2">
												<label>Origin</label> <input type="text" name="cityEdit"
													class="form-control" id="cityEdit" pattern="[a-zA-Z0-9]+"
													maxlength="3" oninput="this.value = this.value.toUpperCase()">
											</div>

											<div class="col-md-2">
												<label>City Name</label> <input type="text" name="cityName"
													class="form-control" id="cityNameEdit" >
											</div>

											<div class="col-md-2">
												<label>State</label> <input type="text" name="state"
													class="form-control" id="stateEdit">
											</div>

											<div class="col-md-2">
												<label>Vehicle Type</label> <input type="text"
													name="vehicleType" class="form-control" id="vehicleTypeEdit"
													maxlength="50">
											</div>

											<div class="col-md-2">
												<label>Trip Cost</label> <input type="number"
													name="tripCost" class="form-control" id="tripCostEdit"
													maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Rate </label> <input type="number" name="rate"
													class="form-control" id="rateEdit" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Base Rate</label> <input type="number"
													name="baseRate" class="form-control" id="baseRateEdit"
													maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Std. Mileage/KM</label> <input type="number"
													name="stdMileagePerKmEdit" class="form-control"
													id="stdMileagePerKmEdit" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Max KMS</label> <input type="number" name="maxKms"
													class="form-control" id="maxKmsEdit" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>Agreement Made Date</label> <input type="date"
													name="agreementMadeDateEdit" class="form-control"
													id="agreementMadeDateEdit">
											</div>


											<div class="col-md-2">
												<label>Agreement Expiry date</label> <input type="date"
													name="agreementExpiryDateEdit" class="form-control"
													id="agreementExpiryDateEdit">
											</div>

											<div class="col-md-2">
												<label>Current Fuel Rate</label> <input type="number"
													name="currentFuelRate" class="form-control"
													id="currentFuelRateEdit" maxlength="10" min=0>
											</div>

											<div class="col-md-2">
												<label>FS Diff</label> <input type="text" name="fsDiff"
													class="form-control" id="fsDiffEdit">
											</div>
										</div>
									</div>




									<!-- /.card-body -->

									<div class="card-footer" align="center">
										<button type="submit" id="updateBtn" class="btn btn-primary">Update</button>
										<button type="button" class="btn btn-primary"
											data-dismiss="modal">Close</button>
									</div>
								</form>
							</div>

						</div>
					</div>
					<!-- </div> -->

				</div>

			</div>
		</div>
	</div>
	<!-- jQuery -->
	<script src="plugins/jquery/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
		$.widget.bridge('uitooltip', $.ui.tooltip);
	</script>
	<!-- Bootstrap 4 -->
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- ChartJS -->
	<script src="js/commonFunctions.js"></script>
	<script src="js/common.js"></script>

	<!-- Sparkline -->
	<script src="plugins/sparklines/sparkline.js"></script>
	<!-- JQVMap -->

	<!-- daterangepicker -->
	<script src="plugins/moment/moment.min.js"></script>
	<script src="plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script
		src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Summernote -->

	<!-- overlayScrollbars -->
	<script
		src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE App -->
	<script src="dist/js/adminlte.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->

	<!-- AdminLTE for demo purposes -->
	<script src="dist/js/demo.js"></script>
	<script src="js/moment.min.js"></script>

	<script src="plugins/select2/js/select2.full.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			var bootstrapTooltip = $.fn.tooltip.noConflict();
			$.fn.bstooltip = bootstrapTooltip;
			$('.quickHelp').bstooltip();
		})
	</script>

	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>

	<script src="plugins/datatables/jquery.dataTables.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>
     <script type="text/javascript">
           var tabledata = $('#tabledata').DataTable({
                "paging" : true,
                "lengthChange" : false,
                "searching" : true,
                "info" : true,
                "aaSorting" : [],
                "scrollX" : true,
                "pageLength":100
           });

           const Toast = Swal.mixin({
                toast : true,
                position : 'top-end',
                showConfirmButton : false,
                timer : 3000
           });

           $('#checkListFormCode').select2({
                theme : 'bootstrap4'
           });
           $('#checkListFormCodeEdit').select2({
                theme : 'bootstrap4'
           });

           $('.select2bs4').select2({
                theme : 'bootstrap4'
           })

           $.validator.setDefaults({
                submitHandler : function() {
                	 //alert("insode add12");
                     addFormData();

                }
           });
           $('#addForm').validate({

                rules : {
                	route : {                          
                		required : true
                	},
                	vendorName : {                          
                		required : true
                	},
                	vendorCode : {                          
                		required : true
                	},
                	type : {
                		required : true
                    },
					 city : {
                        required : true
					 },
					 cityName:{
						 required : true
					 },
					 state:{
						 required : true
					 },
					 vehicleType : {                          
                        required : true
					 },
					 tripCost : {                          
                        required : true
					 },
					 rate : {                          
                        required : true
					 },
					 baseRate : {                          
                        required : true
					 },
					 currentFuelRate : {                          
						 required : true
					 },
					 stdMileagePerKm : {                          
                        required : true
					 },
					 maxKms : {                          
                        required : true
					 },
					 agreementMadeDate : {                          
                        required : true
					 },
					 fsDiff : {
						 required : true
					 },
					 agreementExpiryDate : {                          
                        required : true
					 }
                },

                errorElement : 'span',
                errorPlacement : function(error, element) {
                     error.addClass('invalid-feedback');
                     element.closest('.form-group').append(error);
                },
                highlight : function(element, errorClass, validClass) {
                     $(element).addClass('is-invalid');
                },
                unhighlight : function(element, errorClass, validClass) {
                     $(element).removeClass('is-invalid');
                }
           });

           $.validator.setDefaults({
                submitHandler : function() {
                     updateFormData();

                     //alert("insode add");
                }
           });
           $('#updateMDMData').validate({
				rules : {
					route : {                          
                		required : true
                	},
                	vendorName : {                          
                		required : true
                	},
                	vendorCode : {                          
                		required : true
                	},
                	type : {
                		required : true
                    },
					 city : {
                        required : true
					 },
					 cityName:{
						 required : true
					 },
					 state:{
						 required : true
					 },
					 vehicleType : {                          
                        required : true
					 },
					 tripCost : {                          
                        required : true
					 },
					 rate : {                          
                        required : true
					 },
					 baseRate : {                          
                        required : true
					 },
					 currentFuelRate : {                          
						 required : true
					 },
					 stdMileagePerKm : {                          
                        required : true
					 },
					 maxKms : {                          
                        required : true
					 },
					 agreementMadeDate : {                          
                        required : true
					 },
					 fsDiff : {
						 required : true
					 },
					 agreementExpiryDate : {                          
                        required : true
					 }

              },

              errorElement : 'span',
              errorPlacement : function(error, element) {
                   error.addClass('invalid-feedback');
                   element.closest('.form-group').append(error);
              },
              highlight : function(element, errorClass, validClass) {
                   $(element).addClass('is-invalid');
              },
              unhighlight : function(element, errorClass, validClass) {
                   $(element).removeClass('is-invalid');
              }
         });

           function addFormData(){

               $("#submitBtn").prop("disabled",true);               
                    $('.loader').show();
               
                     var json={
                    		 "route" :$("#route").val(),
                    		 "vendorName" :$("#vendorName").val(),
                    		 "vendorCode" :$("#vendorCode").val(),
                    		 "type" :$("#type").val(),
                             "city" :$("#city").val(),
                             "cityName" :$("#cityName").val(),
                             "state" :$("#state").val(),
                             "vehicleType" :$("#vehicleType").val(), 
                             "rate" :$("#rate").val(),
                             "tripCost" :$("#tripCost").val(),
                             "baseRate" :$("#baseRate").val(),
                             "stdMileagePerKm" :$("#stdMileagePerKm").val(),
                             "maxKms" :$("#maxKms").val(),
                             "fixedKm" :$("#maxKms").val(),
                             "agreementMadeDate" :$("#agreementMadeDate").val(),
                             "agreementExpiryDate" :$("#agreementExpiryDate").val(),
                             "currentFuelRate" :$("#currentFuelRate").val(),
                             "fsDiff" :$("#fsDiff").val()
                     }
                    
                          $.ajax({
                               type: "POST",
                               data:  JSON.stringify(json),
                               url: "<%=GlobalUrl.saveTripMaster%>", 
			                   dataType : "json",
			                   async: false,
			                   contentType : "application/json",
                    
		                    success : function(data) {
		                    	
		                          $("#submitBtn").prop("disabled",false);
		                          $('.loader').hide();
		                          if (data.msg == 'success') {
		
		                               Toast.fire({
		                                    type : 'success',
		                                    title : 'Saved Successfully..'
		                               })
		
		                                $("#addForm")[0].reset();
		                               getData();
		                          } else {
		                               Toast.fire({
		                                    type : 'error',
		                                    title : 'Failed.. Try Again..'
		                               })
		                          }
		
		                    },
		                    error : function(jqXHR, textStatue, errorThrown) {
		                          $("#submitBtn").prop("disabled",false);
		                          $('.loader').hide();
		                          alert("failed, please try again");
		                    }
		
		               });
          }
          
           
           function updateFormData() {

        	  // alert("Hello! I am an alert box!!");
               var json = {
                   "id": id,
                   "route" :$("#routeEdit").val(),
          		   "vendorName" :$("#vendorNameEdit").val(),
          		   "vendorCode" :$("#vendorCodeEdit").val(),
          		   "type" :$("#typeEdit").val(),
                   "city" :$("#cityEdit").val(),
                   "cityName" :$("#cityNameEdit").val(),
                   "state" :$("#stateEdit").val(),
                   "vehicleType" :$("#vehicleTypeEdit").val(), 
                   "rate" :$("#rateEdit").val(),
                   "tripCost" :$("#tripCostEdit").val(),
                   "baseRate" :$("#baseRateEdit").val(),
                   "stdMileagePerKm" :$("#stdMileagePerKmEdit").val(),
                   "maxKms" :$("#maxKmsEdit").val(),
                   "fixedKm" :$("#maxKmsEdit").val(),
                   "agreementMadeDate" :$("#agreementMadeDateEdit").val(),
                   "agreementExpiryDate" :$("#agreementExpiryDateEdit").val(),
                   "currentFuelRate" :$("#currentFuelRateEdit").val(),
                   "fsDiff" :$("#fsDiffEdit").val()
               }


               $("#updateBtn").prop("disabled", true);
               $('.loader').show();

               $.ajax({
                   type: "POST",
                   data: JSON.stringify(json),
                   url: "<%=GlobalUrl.saveUpdateMasterDetails%>",
                   dataType: "json",
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
                   url: "<%=GlobalUrl.getActiveMasterData%>",
                   dataType: "json",
                   contentType: "application/json",
                   async: false,
                   success: function(data) {

                       if (data.msg == 'success') {

                           var result = data.data;
                           tabledata.clear();
                           var count=0;

                           for (var i = 0; i < result.length; i++) {
                        	   if(!result[i].hasOwnProperty("route")){
     								result[i].route="";
     							}
								if(!result[i].hasOwnProperty("vendorName")){
     								result[i].vendorName="";
     							}
								if(!result[i].hasOwnProperty("vendorCode")){
           						result[i].vendorCode="";
           						}
								if(!result[i].hasOwnProperty("type")){
     								result[i].type="";
     							}
								if(!result[i].hasOwnProperty("city")){
     								result[i].city="";
     							}
                               if(!result[i].hasOwnProperty("cityName")){
     								result[i].cityName="";
     							}
								if(!result[i].hasOwnProperty("state")){
     								result[i].state="";
     							}
								if(!result[i].hasOwnProperty("vehicleType")){
           						result[i].vehicleType="";
           						}
								if(!result[i].hasOwnProperty("tripCost")){
        							result[i].tripCost="";
        						}
								if(!result[i].hasOwnProperty("rate")){
      								result[i].rate="";
      							}
								if(!result[i].hasOwnProperty("baseRate")){
         							result[i].baseRate="";
         						}
								if(!result[i].hasOwnProperty("stdMileagePerKm")){
									result[i].stdMileagePerKm="";
          						}
                               if(!result[i].hasOwnProperty("maxKms")){
           						result[i].maxKms="";
           						}
								if(!result[i].hasOwnProperty("currentFuelRate")){
        							result[i].currentFuelRate="";
        						}
                               if(!result[i].hasOwnProperty("fsDiff")){
     								result[i].fsDiff="";
     							}
                               if(!result[i].hasOwnProperty("agreementExpiryDate")){
									result[i].agreementExpiryDate="";
           						}
                               if(!result[i].hasOwnProperty("agreementMadeDate")){
           						result[i].agreementMadeDate="";
           						}
                               count++;

                               var inactive = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"inactiveActiveDeleteData("+result[i].id+")\"> <i class=\"nav-icon fas fa-trash\"></i>  </button>";
                               var edit = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"   data-original-title=\"Click To Edit\" onclick=\"editData("+result[i].id+")\"><i class=\"nav-icon fas fa-edit\"></i> </button>";
                              
                               tabledata.row.add([count,
                            	   result[i].route,
                            	   result[i].vendorName,
                            	   result[i].vendorCode,
                            	   result[i].type,
                            	   result[i].city,
                            	   result[i].cityName,
                            	   result[i].state,
                            	   result[i].vehicleType,
                            	   result[i].tripCost,
                            	   result[i].rate,
                            	   result[i].baseRate,
                            	   result[i].stdMileagePerKm,
                            	   result[i].maxKms,
                            	   result[i].currentFuelRate,
                            	   result[i].fsDiff,
                            	   result[i].agreementMadeDate,
                            	   result[i].agreementExpiryDate ,
                            	   edit+"&nbsp;"+inactive]);
                               
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


           function editData(id2) {
               id = "";
               id = id2;
               status = "";
               var json = {
                   "id": id2
               }
               
               console.log(json);
               $.ajax({
                   type: "POST",
                   data: JSON.stringify(json),
                   url: "<%=GlobalUrl.getMasterById%>",
                   dataType: "json",
                   contentType: "application/json",
                   async: false,
                   success: function(data) {
                       //debugger;
                       if (data.msg == 'success') {

                           var result = data.data;

                           
                           
                           
                           $("#routeEdit").val(result.route);
                           $("#vendorNameEdit").val(result.vendorName);
                           $("#vendorCodeEdit").val(result.vendorCode);
                           $("#typeEdit").val(result.type);
                           $("#cityEdit").val(result.city);
                           $("#cityNameEdit").val(result.cityName);
                           $("#stateEdit").val(result.state);
                           $("#vehicleTypeEdit").val(result.vehicleType);
                           $("#tripCostEdit").val(result.tripCost);
                           $("#stdMileagePerKmEdit").val(result.stdMileagePerKm);
                           $("#rateEdit").val(result.rate);
                           $("#baseRateEdit").val(result.baseRate);
                           $("#currentFuelRateEdit").val(result.currentFuelRate);
   						   $("#maxKmsEdit").val(result.maxKms);
                           $("#fsDiffEdit").val(result.fsDiff);
                           $("#agreementMadeDateEdit").val(result.agreementMadeDate);
                           $("#agreementExpiryDateEdit").val(result.agreementExpiryDate);

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

           function inactiveActiveDeleteData(userid) {

               var json = {
                   "id": userid,
                   
               }
               $.ajax({
                   type: "POST",
                   data: JSON.stringify(json),
                   url: "<%=GlobalUrl.deleteMaster%>",
                   dataType: "json",
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
           $(function(){
        	    $('[name="agreementMadeDate"]').prop('max', function(){
        	        return new Date().toJSON().split('T')[0];
        	    });
        	});
           $(function(){
       	    $('[name="agreementExpiryDate"]').prop('min', function(){
       	        return new Date().toJSON().split('T')[0];
       	    });
       	});
           $(function(){
       	    $('[name="agreementMadeDateEdit"]').prop('max', function(){
       	        return new Date().toJSON().split('T')[0];
       	    });
       	});
          $(function(){
      	    $('[name="agreementExpiryDateEdit"]').prop('min', function(){
      	        return new Date().toJSON().split('T')[0];
      	    });
      	});
           
           
                    
               </script>

</body>
</html>
