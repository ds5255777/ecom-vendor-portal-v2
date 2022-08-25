<!DOCTYPE html>
<%@ page import="com.main.commonclasses.GlobalConstants" %>
<%@ page import="com.main.commonclasses.GlobalUrl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|MasterCheckList</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
<link rel="stylesheet" href="dist/css/adminlte.min.css">
<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

<link rel="stylesheet" href="plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

<link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
<link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
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

		<jsp:include page="navbar.jsp?pagename=Trip Master" />

		 <%
    	String rolename = (String) request.getSession().getAttribute("role");
		 out.print(rolename);
        
        %>
        <c:choose>  
			    <c:when test="<%=rolename.equalsIgnoreCase(adminRole)%>">  
					<jsp:include page="sidebar_Admin.jsp?pagename=masterEvaluationCriteria" />
				</c:when>  
			    <c:when test="<%=rolename.equalsIgnoreCase(financeRole)%>">  
					<jsp:include page="slidebar_Finance.jsp?pagename=masterEvaluationCriteria" />
				</c:when>
		</c:choose>

		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<div class="input-group-prepend">
							</div>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
							</ol>
						</div>
					</div>
				</div>
			</div>
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">Trip Master Details</h3>
								</div>
								<form role="form" id="addForm" autocomplete="off">
									<div class="card-body">
										<div class="row">
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
									<div class="card-footer" align="center">
										<button type="submit" class="btn btn-primary" id="submitBtn" >Submit</button>
										<div class="btn btn-default btn-file"
											style="background-color: #007bff; color: white;">

											<a href="excel/MasterCheckList.xlsx" download
												style="color: white;"> <i class="fas fa-download"></i>
												Download Template
											</a>
										</div>
									
									<div class="btn btn-default btn-file"
											style="background-color: #007bff; color: white;">
											<i class="fas fa-paperclip"></i> Upload Excel <input
												type="file" style="cursor: pointer;" id="readExcel"
												accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"
												name="attachment">
										</div>
										
										<!-- <div class="btn btn-default btn-file"
											style="background-color: #007bff; color: white;">
											<i class="fas fa-paperclip"></i> Upload Excel (Update) <input
												type="file" style="cursor: pointer;" id="readExcelUpdate" onchange="handleFileSelectForExcelUpdate(event)"
												accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"
												name="attachmentUpdate">
										</div> -->
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
								<div class="card-body">
								<form role="form" id="addForm" autocomplete="off">
										<div class="row">
											
											<div class="col-md-2">
												<div class="dropdown">
													<button type="button"
														class="btn btn-primary dropdown-toggle"
														style="  margin-bottom: 10px; margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
														data-toggle="dropdown">Export Details</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="#" id="exportLinkPdf">Download
															PDF</a> <a class="dropdown-item" href="#" id="exportLink">Download
															Excel</a>
													</div>
												</div>
											</div>
											<div class="col-md-8"></div>
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
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<aside class="control-sidebar control-sidebar-dark"></aside>
	</div>

	<div class="modal fade" id="userModal" role="dialog">
		<div class="modal-dialog " style="max-width: 1300px;">
			<div class="modal-content">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">Update Master Detail</h3>
								</div>

								<form role="form" id="updateMDMData" autocomplete="off">
									<div class="card-body">
										<div class="row">

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
													<option value="Milk Run">Milk Run</option> 
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

									<div class="card-footer" align="center">
										<button type="submit" id="updateBtn" class="btn btn-primary">Update</button>
										<button type="button" class="btn btn-primary"
											data-dismiss="modal">Close</button>
									</div>
								</form>
							</div>

						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	
	<div class="modal fade" id="excelUploadModal" role="dialog">
		<div class="modal-dialog " style="max-width: 1050px;">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body">

					<div class="col-md-12">
						<div class="table-reponsive">

							<table id="tabledataExcelUpload" class="table table-bordered">
								<thead>
									<tr>
										<th class="bg-primary">Route</th>
										<th class="bg-primary">Vendor Name</th>
										<th class="bg-primary">Vendor Code</th>
										<th class="bg-primary">Type</th>
										<th class="bg-primary">Origin</th>
										<th class="bg-primary">City Name</th>
										<th class="bg-primary">State</th>
										<th class="bg-primary">Vehicle Type</th>
										<th class="bg-primary">Trip Cost</th>
										<th class="bg-primary">Rate</th>
										<th class="bg-primary">Base Rate</th>
										<th class="bg-primary">Mileage/Km</th>
										<th class="bg-primary">Max Kms</th>
										<th class="bg-primary">Fuel Rate</th>
										<th class="bg-primary">FS Diff</th>
										<th class="bg-primary">Agreement Made Date</th>
										<th class="bg-primary">Agreement Expiry Date</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-primary" id="excelUploadSaveBtn">Submit</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>
	
	
	<script src="plugins/jquery/jquery.min.js"></script>
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/jszip.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/xlsx.js"></script>
	<script>
		$.widget.bridge('uibutton', $.ui.button);
		$.widget.bridge('uitooltip', $.ui.tooltip);
	</script>
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="js/commonFunctions.js"></script>
	<script src="js/common.js"></script>

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
     
 	var tabledataExcelUpload = $('#tabledataExcelUpload').DataTable({
		"paging" : true,
		"lengthChange" : false,
		"searching" : true,
		"info" : true,
		"autoWidth" : false,
		"aaSorting" : [],
		"scrollX" : true,
		"pageLength": 100
		
	});
           
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

            	   {
		                  extend: 'excelHtml5',
		                  title: '',
		                  exportOptions: {
		                  	columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
		                  	"format": {
		                        "header": function(data, columnindex, trDOM, node){
		                          // Here 2 is the index of the column 
		                          // whose header name we want to change(0 based)
		                        	return GetColumnPrefix(columnindex);
		                        }
		                      }
		                   }
		                  },
                   {
                       extend: 'pdfHtml5',
                       orientation: 'landscape',
                       pageSize: 'A4',
                       exportOptions: {
                           columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,  17],
                       },
                       customize: function(doc) {

                           var tblBody = doc.content[1].table.body;
                           for (var i = 0; i < tblBody[0].length; i++) {
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
                       }
                   }
               ],
               initComplete: function() {
                   var $buttons = $('.dt-buttons').hide();
                   $('#exportLink').on('click', function() {
                       var btnClass = "excel" ?
                           '.buttons-' + "excel" :
                           null;
                       if (btnClass) $buttons.find(btnClass).click();
                   })

                   $('#exportLinkPdf').on('click', function() {
                       var btnClass = "pdf" ?
                           '.buttons-' + "pdf" :
                           null;
                       if (btnClass) $buttons.find(btnClass).click();
                   })
               }
           });
           
           
           function GetColumnPrefix(colIndex) {
			    switch (colIndex) {
			    case 0:
			    	  return "id";  
			    case 1:
			    	  return "route";
			      case 2:
			    	  return "vendorName";
			      case 3:
			    	  return "vendorCode";
			      case 4:
			    	  return "type";
			      case 5:
			    	  return "city";  
			    case 6:
			    	  return "cityName";
			      case 7:
			    	  return "state";
			      case 8:
			    	  return "vehicleType";
			      case 9:
			    	  return "tripCost";	
			      case 10:
			    	  return "rate";
			      case 11:
			    	  return "baseRate";
			      case 12:
			    	  return "stdMileagePerKm";
			      case 13:
			    	  return "maxKms";
			      case 14:
			    	  return "currentFuelRate";
			      case 15:
			    	  return "fsDiff";
			      case 16:
			    	  return "agreementMadeDate";
			      case 17:
			    	  return "agreementExpiryDate";
			      
			         // leave space after the prefix
			    
			      default:
			        return "";
			    }
			  }

           $('#searchData').on( 'keyup', function () {
           	tabledata.search( this.value ).draw();
           } );
           
           $('#tabledata_filter').css("display","none");
           
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
                    
                    var fromDate = $("#agreementMadeDate").val();
                    var toDate = $("#agreementExpiryDate").val();
                    
                    fromDate=moment(fromDate, 'YYYY-MM-DD').format('DD-MMM-YY');
                    toDate=moment(toDate, 'YYYY-MM-DD').format('DD-MMM-YY');

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
                             "agreementMadeDate" :fromDate,
                             "agreementExpiryDate" :toDate,
                             "currentFuelRate" :$("#currentFuelRate").val(),
                             "fsDiff" :$("#fsDiff").val()
                     }
                    $('.loader').show();
                          $.ajax({
                               type: "POST",
                               data:  JSON.stringify(json),
                               url: "<%=GlobalUrl.saveTripMaster%>", 
			                   dataType : "json",
			                   /* async: false, */
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

        	   var fromDate = $("#agreementMadeDateEdit").val();
               var toDate = $("#agreementExpiryDateEdit").val();
               
               fromDate=moment(fromDate, 'YYYY-MM-DD').format('DD-MMM-YY');
               toDate=moment(toDate, 'YYYY-MM-DD').format('DD-MMM-YY');
               
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
                   "agreementMadeDate" :fromDate,
                   "agreementExpiryDate" :toDate,
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
                       if (data.msg == 'success') {

                           var result = data.data;
                           
                           var fromDate = result.agreementMadeDate;
                           var toDate = result.agreementExpiryDate;
                           
                           fromDate=moment(fromDate, 'DD-MMM-YY').format('YYYY-MM-DD');
                           toDate=moment(toDate, 'DD-MMM-YY').format('YYYY-MM-DD');
                           
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
                           $("#agreementMadeDateEdit").val(fromDate);
                           $("#agreementExpiryDateEdit").val(toDate);

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
          
          
       // for read Excel and convert to json Array	
			var input_dom_element = document.getElementById("readExcel");
			input_dom_element.addEventListener('change', handleFileSelectForExcel, false);
			
			var ExcelToJSON = function() {
			
		      this.parseExcel = function(file) {
		        var reader = new FileReader();
			
		        reader.onload = function(e) {
		          var data = e.target.result;
		          var workbook = XLSX.read(data, {
		            type: 'binary'
		          });
		          workbook.SheetNames.forEach(function(sheetName) {
		            // Here is your object
		            var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
		            var json_object = JSON.stringify(XL_row_object);	
		            if(buttonType=="New"){
		            	 jsonArray  = JSON.parse(json_object);
				            console.log("new.."+jsonArray);
				            
					         showJsonArrayTable();
		            }
		            /* else if(buttonType=="Update"){
		            	 jsonArrayUpdate  = JSON.parse(json_object);
				            console.log("update.."+jsonArrayUpdate);
				            updateCommodityData();
		            } */
		           
		            jQuery( '#xlx_json' ).val( json_object );
		          })
		          
		          // modify jsonArray 
		          
		          	
		        };

		        reader.onerror = function(ex) {
		          console.log(ex);
		        };

		        reader.readAsBinaryString(file);
		      };
		  };
		  
		  function handleFileSelectForExcelUpdate(evt) {
			  
			  buttonType = "Update";
			  
			  jsonArrayUpdate=[];
		    var filesUpdate = evt.target.files; // FileList object
		    var xl2jsonUpdate = new ExcelToJSON();
		    xl2jsonUpdate.parseExcel(filesUpdate[0]);
		  }
		  
		  function handleFileSelectForExcel(evt) {
			    buttonType="New";
			  var files = evt.target.files; // FileList object
			    var xl2json = new ExcelToJSON();
			    xl2json.parseExcel(files[0]);
			  }	
		  
		  function showJsonArrayTable(){
				
				tabledataExcelUpload.clear();
				
				 for(var i=0;i<jsonArray.length;i++){
					 tabledataExcelUpload.row.add([ jsonArray[i].route,
                  	   jsonArray[i].vendorName,
                	   jsonArray[i].vendorCode,
                	   jsonArray[i].type,
                	   jsonArray[i].city,
                	   jsonArray[i].cityName,
                	   jsonArray[i].state,
                	   jsonArray[i].vehicleType,
                	   jsonArray[i].tripCost,
                	   jsonArray[i].rate,
                	   jsonArray[i].baseRate,
                	   jsonArray[i].stdMileagePerKm,
                	   jsonArray[i].maxKms,
                	   jsonArray[i].currentFuelRate,
                	   jsonArray[i].fsDiff,
                	   jsonArray[i].agreementMadeDate,
                	   jsonArray[i].agreementExpiryDate  ]);
		         }
				 
				 tabledataExcelUpload.draw();
			     $("tbody").show();
				
				
				$("#excelUploadModal").modal('show');
			}
		  
		  $("#excelUploadSaveBtn").click(function () {
				
				if(jsonArray.length==0){
					
					Toast.fire({
						type : 'warning',
						title : 'No Data in Excel Sheet'
					})
					
					return;
				}
				
				$('.loader').show();
				
				$("#excelUploadSaveBtn").prop("disabled",true);
				$.ajax({
			      	type: "POST",
			  		data:  JSON.stringify(jsonArray),
			        url: "<%=GlobalUrl.saveAgreementList%>",
					dataType : "json",
					contentType : "application/json",
					
					success : function(data) {
						$('.loader').hide();
						if (data.msg == 'success') {	
							
							Toast.fire({
								type : 'success',
								title : 'Successfull..'
							})
							
							$("#excelUploadModal").modal('hide');
							
							$("#projectsList").prop("disabled",false);
							$("#sitesList").prop("disabled",false);
							$("#categoryList").prop("disabled",false);
							$("#subCategoryList").prop("disabled",false);
							showUploadedFilesData();
							$("#addForm")[0].reset();
							arrayAttachment = [];
							jsonArray=[];
							getTableData();
							$("#submitBtn").prop("disabled",false);
							getData();
						} else {
							Toast.fire({
								type : 'error',
								title : 'Failed.. Try Again..'
							})
						}

					},
					error : function(jqXHR, textStatue, errorThrown) {
						$('.loader').hide();
						$("#excelUploadSaveBtn").prop("disabled",false);
						
						alert("failed, please try again");
					}

				});
				
			})

     </script>

</body>
</html>
