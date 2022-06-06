<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|ApprovalAdhocTrips</title>

<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
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
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
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
</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
	<jsp:include page="loader.jsp" />
	<div class="wrapper">

		<!-- Navbar -->
		<jsp:include page="navbar.jsp?pagename=Approved Trips" />
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="slidebar.jsp?pagename=getApprovedAdhocTrips" />

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
								<form role="form" id="addForm" autocomplete="off">
									<div class="row">

										<div class="col-md-2">
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
								<div class="card-body table-responsive p-0"
									style="height: 420px;">
									<table class="table table-head-fixed" id="tabledata1">
										<thead>
											<tr>

												<th class="bg-primary">Trip ID</th>
												<th class="bg-primary">Route</th>
												<th class="bg-primary">Vendor name</th>
												<th class="bg-primary">Vendor Code</th>
												<th class="bg-primary">Run Type</th>
												<th class="bg-primary">Trip Status</th>
												<th class="bg-primary">Vehicle Number</th>


											</tr>
										</thead>

										<tbody>
											<c:forEach var="ApprovedAllDetails"
												items="${ApprovedAllDetailsForNetwork}">
												<tr>
													<td><a
														href="javascript:setTripStatus(${ApprovedAllDetails.tripID})">${ApprovedAllDetails.tripID}</a></td>
													<td>${ApprovedAllDetails.route}</td>
													<td>${ApprovedAllDetails.vendorName}</td>
													<td>${ApprovedAllDetails.vendorCode}</td>
													<td>${ApprovedAllDetails.runType}</td>
													<td>${ApprovedAllDetails.runStatus}</td>
													<td>${ApprovedAllDetails.vehicleNumber}</td>


												</tr>
											</c:forEach>
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



		<div class="modal fade" id="tripValue" role="dialog">
			<div class="modal-dialog " style="max-width: 1400px;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-body" style="overflow-y: auto;">
						<div class="container-fluid panel2" id="headerLineItemForm">
							<div class="row">
								<div class="col-md-12 propTableContainer"
									style="overflow-y: auto; height: 620px;">
									<input type="hidden" id="headerDetailsId" class="form-control">
									<div class="card card-primary">
										<div class="card-header" style="padding: 4px 0px 0px 4px;">
											<h3 class="card-title" style="font-size: 15px;">Trip
												Details</h3>
											<button type="button" class="btn btn-sm" id="closeModal"
												style="float: right;padding: 0 10px 0 0;" data-dismiss="modal">
												<i class="nav-icon far fa-window-close"
													style="font-size: 20px; color: white;"></i>
											</button>
										</div>
										<!-- /.card-header -->
										<div class="card-body" style="padding-bottom: inherit;">
											<form role="form" id="tripForm1">
												<div class="row">
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5">Trip Id</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" id="tripID"
																	name="tripID" autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5">Route</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" id="route"
																	name="route" autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5">Run Type</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" id="runType"
																	name="runType" autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5">Mode</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" id="mode"
																	name="mode" autocomplete="off" disabled>
															</div>
														</div>
													</div>



													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Vehicle Number">Vehicle
																No.</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="vehicleNumber" name="vehicleNumber"
																	autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<!-- text input -->
														<div class="form-group row">
															<label class="col-sm-5" title="Vendor Name">Vendor
																Name</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" id="vendorName"
																	name="vendorName" autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<!-- text input -->
														<div class="form-group row">
															<label class="col-sm-5" title="Actual Vehicle Type">Act Vehicle
																</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="actualVechicleType" name="actualVechicleType"
																	autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<!-- text input -->
														<div class="form-group row">
															<label class="col-sm-5" title="Standard Vehicle Type">Stnd Vehicle
																</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="standardVechicleType" name="standardVechicleType"
																	autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<!-- text input -->
														<div class="form-group row">
															<label class="col-sm-5" title="Standard Payload Capacity">Payload
																Cap.</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="standardPayloadCapacity"
																	name="standardPayloadCapacity" autocomplete="off"
																	disabled>
															</div>
														</div>
													</div>

													<div class="col-md-3">
														<!-- text input -->
														<div class="form-group row">
															<label class="col-sm-5"
																title="Standard Shipment Capacity">Shipment Cap.</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="standardShipmentCapacity"
																	name="standardShipmentCapacity" autocomplete="off"
																	disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Run Status">Run
																Status</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" id="runStatus"
																	name="runStatus" autocomplete="off" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Origin Hub">Origin
																Hub</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	autocomplete="off" id="originHub" name="originHub"
																	disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Origin Region">Origin
																Region</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	autocomplete="off" id="originRegion"
																	name="originRegion" disabled>
															</div>
														</div>
													</div>

													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Destination Hub">Dest
																Hub</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	autocomplete="off" id="destHub" name="destHub" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Actual Departure (ATD)">ATD</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	autocomplete="off" id="actualDeparture"
																	name="actualDeparture" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Actual Arrival (ATA)">ATA</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	autocomplete="off" id="actualArrival"
																	name="actualArrival" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Actual KM">Actual
																KM</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	autocomplete="off" id="actualKM" name="actualKM"
																	disabled>
															</div>
														</div>
													</div>

													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Standard KM">Standard
																KM</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	autocomplete="off" id="standardKM" name="standardKM"
																	disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Mileage">Mileage</label>
															<div class="col-sm-7">
																<input type="text"
																	class="form-control numberWithDecimalcheck"
																	autocomplete="off" id="mileage" name="mileage" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Rate per KM">Rate
																per KM</label>
															<div class="col-sm-7">
																<input type="text"
																	class="form-control numberWithDecimalcheck"
																	autocomplete="off" id="ratePerKm" name="ratePerKm"
																	disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Billable KM">Billable
																KM</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" id="routeKms"
																	name="routeKms" disabled>
															</div>
														</div>
													</div>

													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="FS Base Rate">FS
																Base Rate</label>
															<div class="col-sm-7">
																<input type="text"
																	class="form-control numberWithDecimalcheck"
																	autocomplete="off" id="fsBaseRate" name="fsBaseRate"
																	disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Current Fuel Rate">Fuel
																Rate</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="currentFuelRate" name="currentFuelRate" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="FS Difference">FS
																Diff</label>
															<div class="col-sm-7">
																<input type="text"
																	class="form-control numberWithDecimalcheck"
																	autocomplete="off" id="fsDiff" name="fsDiff" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5" title="Basic Freight">Basic
																Freight</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="basicFreight" name="basicFreight" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<!-- text input -->
														<div class="form-group row">
															<label class="col-sm-5" title="FS">FS</label>
															<div class="col-sm-7">
																<input type="text"
																	class="form-control numberWithDecimalcheck"
																	autocomplete="off" id="fs" name="fs" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5"
																title="Total Freight (Total Trip Cost)">Total
																Freight</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="totalFreight" name="totalFreight" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5"
																title="Lump Sum Amount (Total Trip Cost)">Total
																Amount</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="lumpsomeamount" name="lumpsomeamount" disabled>
															</div>
														</div>
													</div>
													<div class="col-md-3" style="display: none">
														<div class="form-group row">
															<label class="col-sm-5" title="Trip Opening Reading">Start
																Reading</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="openingReading" disabled name="openingReading">
															</div>
														</div>
													</div>
													<div class="col-md-3" style="display: none">
														<div class="form-group row">
															<label class="col-sm-5" title="Trip Closing Reading">End
																Reading</label>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="closingReading" disabled name="closingReading">
															</div>
														</div>
													</div>

													<div class="col-md-3">
														<div class="form-group row">

															<input type="hidden" class="form-control" id="vendorCode"
																name="vendorCode" value=${userName } readonly>
														</div>
													</div>
												</div>
											</form>
										</div>
										<!-- /.card-body -->
									</div>
									<!-- /.card -->
									<div class=" card-primary">
										<div class="card card-primary ">
											<div class="card-header" style="padding: 4px 0px 4px 4px;">
												<h3 class="card-title" style="font-size: 15px;">Trips
													Query</h3>
											</div>

											<div class="card-body " style="padding: inherit;">
												<form role="form" id="showQueryDetails"
													name="showQueryDetails">
													<div class="col-md-12">

														<div class="table-responsive">
															<table class="table table-bordered table-hover"
																id="tabledataQuery">
																<thead>
																	<tr>
																		<th class="bg-primary">S.No</th>
																		<th class="bg-primary">Raised By</th>
																		<th class="bg-primary">Role/Department</th>
																		<th class="bg-primary">Raised On</th>
																		<th class="bg-primary">Remarks</th>

																	</tr>
																</thead>
																<tbody>

																</tbody>
															</table>
														</div>
													</div>
												</form>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>



	<!-- model Start -->



	<script src="plugins/jquery/jquery.min.js"></script>
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
		$.widget.bridge('uitooltip', $.ui.tooltip);
	</script>
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="js/commonFunctions.js"></script>

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
	<script src="plugins/jszip/jszip.min.js"></script>
	<script src="plugins/pdfmake/pdfmake.min.js"></script>
	<script src="plugins/pdfmake/vfs_fonts.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
	
<script type="text/javascript">

   $('#tripValue').modal("hide");
   const Toast = Swal.mixin({
       toast: true,
       position: 'top-end',
       showConfirmButton: false,
       timer: 3000
   });
   
   var tabledataQuery = $('#tabledataQuery').DataTable({
       "paging": false,
       "lengthChange": false,
       "searching": false,
       "info": false,
       "autoWidth": false,
       "aaSorting": []
   });
   var tabledata = $('#tabledata1').DataTable({
       "paging": true,
       "lengthChange": false,
       "searching": true,
       "info": true,
       "autoWidth": false,
       "aaSorting": [],
       "scrollX": true,
       "pageLength": 10,
       dom: 'Bfrtip',
       //buttons: ['excel','pdf','print'],
       buttons: [

           {
               extend: 'excelHtml5',

               exportOptions: {
                   columns: [ 0,1, 2, 3, 4],
               }
           },
           {
               extend: 'pdfHtml5',
               orientation: 'landscape',
               pageSize: 'A4',
               exportOptions: {
                   columns: [ 0, 1, 2, 3, 4],
               },
               customize: function(doc) {

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
   
   $('#searchData').on( 'keyup', function () {
   	tabledata.search( this.value ).draw();
   } );
   
   $('#tabledata1_filter').css("display","none");
   
   if (document.getElementById("mode").value === "Line Haul") {
       document.getElementById("openingReading").d = 'true';
       document.getElementById("closingReading").d = 'true';
       $("#tdsSection").val("");
       $("#tdsRate").val("");
   } else {
       document.getElementById("openingReading").d = '';
       document.getElementById("closingReading").d = '';
   }

   var globalTripId = "";
   function setTripStatus(tripId) {

       var json = {
           "tripID": tripId
       }
       
       console.log(json);

       $.ajax({
           type: "POST",
           data: JSON.stringify(json),
           url: "<%=GlobalUrl.tripDetailByTripId%>",
           dataType: "json",
           contentType: "application/json",
           async: false,
           success: function (data) {
               if (data.msg == 'success') {
                   var result = data.data;
                   var myForm = "";
                   myForm = document.getElementById("tripForm1");
                   setData(myForm, result);
                   $('#tripValue').modal('show');
               } else {
                   Toast.fire({
                       type: 'error',
                       title: 'Error in getting values. Please Try Again after sometime'
                   })
               }
           },
           error: function (jqXHR, textStatue, errorThrown) {
               Toast.fire({
                   type: 'error',
                   title: 'Failed.. Try Again..'
               })
           }

       });

       var obj ={
					"referenceid": tripId,
					"type": "Trip"
			}
			
			$.ajax({
				type : "POST",
				url : "<%=GlobalUrl.getQueryByTypeAndForeignKey%>",
				data :JSON.stringify(obj),
				dataType : "json",
				contentType : "application/json",
				success : function(response) {
					if (response.msg == "success") {
					
						if("data" in response){
						
							var result = response.data;												
							
						     	tabledataQuery.clear();
						     	var count=0;
			                        for (var i = 0; i < result.length; i++) {
			                        	if(!result[i].hasOwnProperty("raisedBy")){
			                               	result[i].raisedBy="";
			                               }
			                                             if(!result[i].hasOwnProperty("role")){
			                               	result[i].role="";
			                               }
			                                             if(!result[i].hasOwnProperty("raisedOn")){
			                               	result[i].raisedOn="";
			                               }
			                                             if(!result[i].hasOwnProperty("comment")){
			                               	result[i].comment="";
			                               }                    
			                        count++;
			                        tabledataQuery.row.add([count,result[i].raisedBy, result[i].role, result[i].raisedOn, result[i].comment]);
			                        }
			                        tabledataQuery.draw();
			                        $("tbody").show();
							}
					} else {
						Toast.fire({
							type : 'error',
							title : 'Failed ..'
						})
					}
				},
				error : function(jqXHR, textStatue, errorThrown) {
					
					Toast.fire({
						type : 'error',
						title : 'Failed Added try again..'
					})

				}
			});
   }

   function lumpsomePropertyChange() {
       var checkedValue = $('.messageCheckbox:checked').val();
       console.log("checkedValue " + checkedValue);
       $("#AmountLumpSum").prop('disabled', true);
       $("#fs").prop('disabled', false);
       $("#totalFreight").prop('disabled', false);
       $("#basicFreight").prop('disabled', false);

       var currentFuelRate = document.getElementById("currentFuelRate").value;
       var fsBaseRate = document.getElementById("fsBaseRate").value;

       console.log("currentFuelRate " + currentFuelRate);
       console.log("fsBaseRate " + fsBaseRate);


       var basicFreight = parseFloat(currentFuelRate) - parseFloat(fsBaseRate);
       document.getElementById("basicFreight").value = basicFreight.toFixed(2);
       ;


       var mileage = document.getElementById("mileage").value;
       var routeKms = document.getElementById("routeKms").value;
       console.log("mileage " + mileage);
       console.log("routeKms " + routeKms);
       var fs = (parseFloat(basicFreight) / parseFloat(mileage)) * parseFloat(routeKms);
       document.getElementById("fs").value = fs.toFixed(2);
       ;



       var totalFreight = parseFloat(basicFreight) + parseFloat(fs);
       document.getElementById("totalFreight").value = totalFreight.toFixed(2);

       if (checkedValue == '') {
           $("#AmountLumpSum").prop('disabled', false);
           $('#fs').val('');
           $('#totalFreight').val('');
           $('#basicFreight').val('');
           $("#fs").prop('disabled', true);
           $("#totalFreight").prop('disabled', true);
           $("#basicFreight").prop('disabled', true);

           //Recalcluate


       }



   }



   function updateTripDataByNetworkTeam() {


       //Validations
       var ratePerKm = document.getElementById("ratePerKm").value;
       var routeKms = document.getElementById("routeKms").value;
       var fsBaseRate = document.getElementById("fsBaseRate").value;
       var currentFuelRate = document.getElementById("currentFuelRate").value;
       var fsDiff = document.getElementById("fsDiff").value;
       var basicFreight = document.getElementById("basicFreight").value;
       var totalFreight = document.getElementById("totalFreight").value;
       var openingReading = document.getElementById("openingReading").value;
       var closingReading = document.getElementById("closingReading").value;
       var AmountLumpSum = document.getElementById("AmountLumpSum").value;
       var lumpsum = document.getElementById("lumpsum").value;
       var fs = document.getElementById("fs").value;


       console.log("routeKms " + routeKms);
       console.log("fsBaseRate " + fsBaseRate);
       console.log("currentFuelRate " + currentFuelRate);
       console.log("fsDiff " + fsDiff);
       console.log("basicFreight " + basicFreight);
       console.log("totalFreight " + totalFreight);

       console.log("openingReading " + openingReading);
       console.log("closingReading " + closingReading);
       console.log("AmountLumpSum " + AmountLumpSum);
       console.log("lumpsum " + lumpsum);

       console.log("ratePerKm " + ratePerKm);
       if (ratePerKm === "" || ratePerKm === null || ratePerKm === '') {
           Toast.fire({
               type: 'error',
               title: 'Please chcek the Value of Rate Per KM'
           });
           document.getElementById("ratePerKm").focus();
           return "";
       }

       if (fsBaseRate === "" || fsBaseRate === null || fsBaseRate === '') {
           Toast.fire({
               type: 'error',
               title: 'Please chcek the Value of Fs Base Rate'
           });
           document.getElementById("fsBaseRate").focus();
           return "";
       }

       if (fsDiff === "" || fsDiff === null || fsDiff === '') {
           Toast.fire({
               type: 'error',
               title: 'Please chcek the Value of Fs Diff'
           });
           document.getElementById("fsDiff").focus();
           return "";
       }






       var today = new Date();
       var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
       var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
       var dateTime = date + ' ' + time;
       var checkedValue = $('.messageCheckbox:checked').val();

       console.log("checkedValue " + checkedValue);

       if (checkedValue != '' || checkedValue != "") {
           checkedValue = 'unchecked';

           if (basicFreight === "" || basicFreight === null || basicFreight === '') {
               Toast.fire({
                   type: 'error',
                   title: 'Please chcek the Value of Basic Fraight'
               });
               document.getElementById("basicFreight").focus();
               return "";
           }

           if (totalFreight === "" || totalFreight === null || totalFreight === '') {
               Toast.fire({
                   type: 'error',
                   title: 'Please chcek the Value of Total Fraight'
               });
               document.getElementById("totalFreight").focus();
               return "";
           }

 

           if (fs === "" || fs === null || fs === '') {
               Toast.fire({
                   type: 'error',
                   title: 'Please check the Value of FS'
               });
               document.getElementById("fs").focus();
               return "";
           }


       } else {
           if (AmountLumpSum == '' || AmountLumpSum == null || AmountLumpSum == '0' || AmountLumpSum == '0.0') {
               Toast.fire({
                   type: 'error',
                   title: 'Please chcek the Value of Lump Sum Amount'
               });
           }

           return "";

       }

       var fs = document.getElementById("fs").value;
       console.log("fs" + fs);
       var totalFreight = document.getElementById("totalFreight").value;
       var basicFreight = document.getElementById("basicFreight").value;
       var comments_by_User = document.getElementById("comment").value;
       console.log("comments_by_User " + comments_by_User);
       var obj = {
           "tripID": document.getElementById("tripID").value,
           "processedBy": 'NetworkTeam',
           "processedOn": dateTime,
           "LumpSomeAmount": document.getElementById("AmountLumpSum").value,
           "AssigenedTo": "Vendor",
           "fs": fs,
           "totalFreight": totalFreight,
           "basicFreight": basicFreight,
           "commentsby": comments_by_User

       }



       $.ajax({
           type: "POST",
           data: JSON.stringify(obj),
           url: "<%=GlobalUrl.updateDetailsforNetwork%>",
           dataType: "json",
           contentType: "application/json",
           async: false,
           success: function (data) {
               console.log("data.msg" + data.msg);
               if (data.msg == 'success') {
                   var result = data.data;

               } else {
                   Toast.fire({
                       type: 'error',
                       title: 'Error in getting values. Please Try Again after sometime'
                   })
               }
           },
           error: function (jqXHR, textStatue, errorThrown) {
               //alert("failed, please try again");
               Toast.fire({
                   type: 'error',
                   title: 'Action Performed'
               })
           }

       });


       $('#tripValue').modal('hide');


   }

                </script>

</body>

</html>
