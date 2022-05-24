<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|AllTrips</title>

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

<script>
	var statusObject = {
		"In-Transit" : {
			"Yet To Be Approved" : [ "NA" ],
			"Yet To Be Approved By Network Team" : [ "NA" ],
		},
		"Closed" : {
			"Yet To Be Approved" : [ "NA" ],
			"Approved By Network Team" : [ "NA" ],
			"Yet To Be Approved By Network Team" : [ "NA" ],
			"Approved" : [ "Pending" ],
			"Invoicing" : [ "Pending", "Approved" ],
		}
	}
	window.onload = function() {
		var tripStatus = document.getElementById("selectTripStatus");
		var status = document.getElementById("selectStatus");
		var paymentStatus = document.getElementById("selectPaymentStatus");
		for ( var x in statusObject) {
			tripStatus.options[tripStatus.options.length] = new Option(x, x);

		}
		tripStatus.onchange = function() {
			//empty Chapters- and Topics- dropdowns
			paymentStatus.length = 1;
			status.length = 1;
			//display correct values
			for ( var y in statusObject[this.value]) {
				status.options[status.options.length] = new Option(y, y);
			}
			GetSelectedTextValue1();
		}
		status.onchange = function() {
			//empty Chapters dropdown
			paymentStatus.length = 1;
			//display correct values
			var z = statusObject[tripStatus.value][this.value];
			for (var i = 0; i < z.length; i++) {
				paymentStatus.options[paymentStatus.options.length] = new Option(
						z[i], z[i]);
			}
			GetSelectedTextValue1();
		}
	}
</script>
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
		<jsp:include page="navBar_Network.jsp?pagename=All Trips (Network)" />
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="slidebar.jsp?pagename=AllTripsNetwork" />

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
						<!-- <div class="col-md-12"> -->
						<div class="col-md-12" style="font-size: 14px;">
							<!-- general form elements -->
							<div class="card">

								<!-- /.card-header -->
								<div class="card-body ">
									<form role="form" id="addForm" autocomplete="off">


										<div class="row">
											<div class="col-md-2">
												<input type="text" name="fromDate"
													placeholder="Select Starting Date" class="form-control"
													id="fromDate" style="height: 34px;">
											</div>
											<div class="col-md-2">
												<input type="text" name="toDate"
													placeholder="Select End Date" class="form-control"
													id="toDate" style="height: 34px;">
											</div>
											<div class="col-md-2">
												<label for="exampleInputserverName1"
													style="visibility: hidden;">Text</label>
												<button type="button" onclick="getFilterData()"
													class="btn btn-primary">Search</button>
											</div>
											<div class="col-md-3"></div>
											<div class="col-md-2">
												<div class="form-group row">
													<label class="col-md-4" style="margin-top: 7px;">Search
														: </label>
													<div class="col-md-8">
														<input type="text" name="searchData" placeholder="search"
															class="form-control" id="searchData"
															style="height: 34px;">
													</div>
												</div>
											</div>

											<div class="col-md-1">
												<div class="dropdown">
													<button type="button"
														class="btn btn-primary dropdown-toggle"
														style="font-size: 14px; float: right; margin-bottom: 10px;"
														data-toggle="dropdown">Export Details</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="#" id="exportLinkPdf">Download
															PDF</a> <a class="dropdown-item" href="#" id="exportLink">Download
															Excel</a>
													</div>
												</div>
											</div>
										</div>
									</form>
									<table class="table table-bordered table-hover" id="tabledata">
										<thead>
											<tr>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip
													Id</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run
													Type</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
													Name</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
													Code</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run
													Status</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
													Status</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Actual
													Departure</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Actual
													KM</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Standard
													KM</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Origin
													Hub</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Destination
													Hub</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Payment
													Status</th>
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

			<!-- Control Sidebar -->
			<!-- <aside class="control-sidebar control-sidebar-dark">
                            Control sidebar content goes here
                    </aside>
                    /.control-sidebar -->
		</div>
		<!-- ./wrapper -->

		<!-- Model Start -->
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
										<div class="card-header" style="padding: 4px 0px 4px 4px;">
											<h3 class="card-title" style="font-size: 15px;">Trip
												Details</h3>
											<button type="button" class="btn" id="closeModal"
												style="float: right;" data-dismiss="modal">
												<i class="nav-icon far fa-window-close"
													style="font-size: 20px; color: white;"></i>
											</button>
										</div>
										<!-- /.card-header -->
										<div class="card-body" style="padding-bottom: inherit;">
											<form role="form" id="tripForm">
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
															<label class="col-sm-5" title="Actual Vehicle Type">Vehicle
																Type</label>
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
            <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
            <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
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
            
            var dataLimit='${dataLimit}';
    		dataLimit=parseInt(dataLimit);
      const Toast = Swal.mixin({
          toast: true,
          position: 'top-end',
          showConfirmButton: false,
          timer: 3000
      });
      
      var currentDate='${currentDate}';

      var tabledata = $('#tabledata').DataTable({
          "paging": true,
          "lengthChange": false,
          "searching": true,
          "info": true,
          "autoWidth": false,
          "aaSorting": [],
          "scrollX": true,
          "pageLength": dataLimit,
          dom: 'Bfrtip',
          //buttons: ['excel','pdf','print'],
          buttons: [

              {
                  extend: 'excelHtml5',

                  exportOptions: {
                      columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                  }
              },
              {
                  extend: 'pdfHtml5',
                  orientation: 'landscape',
                  pageSize: 'A4',
                  exportOptions: {
                      columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                  },
                  customize: function (doc) {

                      var tblBody = doc.content[1].table.body;
                      for (var i = 0; i < tblBody[0].length; i++) {
                          //	 console.log(tblBody[0]);
                          //	 console.log(tblBody[0][i]);
                          tblBody[0][i].fillColor = '#FFFFFF';
                          tblBody[0][i].color = 'black';
                      }

                      var objLayout = {};
                      objLayout['hLineWidth'] = function (i) {
                          return .5;
                      };
                      objLayout['vLineWidth'] = function (i) {
                          return .5;
                      };
                      objLayout['hLineColor'] = function (i) {
                          return '#aaa';
                      };
                      objLayout['vLineColor'] = function (i) {
                          return '#aaa';
                      };
                      objLayout['paddingLeft'] = function (i) {
                          return 4;
                      };
                      objLayout['paddingRight'] = function (i) {
                          return 4;
                      };
                      doc.content[1].layout = objLayout;
                      var obj = {};
                      obj['hLineWidth'] = function (i) {
                          return .5;
                      };
                      obj['hLineColor'] = function (i) {
                          return '#aaa';
                      };
                      //   doc.content[1].margin = [ 150, 0, 150, 0 ];

                  }
              }
          ],
          initComplete: function () {
              var $buttons = $('.dt-buttons').hide();
              $('#exportLink').on('click', function () {
                  var btnClass = "excel" ?
                          '.buttons-' + "excel" :
                          null;
                  if (btnClass)
                      $buttons.find(btnClass).click();
              })

              $('#exportLinkPdf').on('click', function () {
                  var btnClass = "pdf" ?
                          '.buttons-' + "pdf" :
                          null;
                  if (btnClass)
                      $buttons.find(btnClass).click();
              })
          }
      });

      // #myInput is a <input type="text"> element
         $('#searchData').on( 'keyup', function () {
         	tabledata.search( this.value ).draw();
         } );
         
         $('#tabledata_filter').css("display","none");
      
         $('#fromDate').datepicker({
             dateFormat: 'dd-mm-yy',
             changeMonth: true,
             changeYear: true,
             maxDate: currentDate
         });

         $('#toDate').datepicker({
             dateFormat: 'dd-mm-yy',
             changeMonth: true,
             changeYear: true,
             maxDate: currentDate
         });


         function calculateTotalFreight() {

             var fs = parseFloat("0");
             var totalFreight = parseFloat("0");

             if ($.isNumeric($("#currentFuelRate").val())) {
                 totalFreight = parseFloat($("#currentFuelRate").val());
                 console.log("Hiiii" + totalFreight);
             }
             var engMarks = document.getElementById('currentFuelRate').value;
             var currentFuelRate = parseFloat($("#currentFuelRate").val());
             var fsBaseRate = parseFloat($("#fsBaseRate").val());
             var mileage = parseFloat($("#mileage").val());
             var routeKms = parseFloat($("#routeKms").val());
             /* if($.isNumeric( $("#currentFuelRate").val() )){
              totalFreight = totalFreight+parseFloat($("#currentFuelRate").val());
              } */
             fs = ((currentFuelRate - fsBaseRate / mileage) * routeKms);

             console.log(parseFloat(fs));
         }

         $("#refreshDashboardButton").click(function (e) {
             e.preventDefault();
             $('#refreshDashboardButton').attr('disabled', 'disabled');
             getData();
             $('#refreshDashboardButton').removeAttr('disabled');
             $('#selectTripStatus').val('');
             $('#selectStatus').val('');
             $('#selectPaymentStatus').val('');
             $('#fromDate').val('');
             $('#toDate').val('');
         })

         getData();

         function getData() {

             var jsArray = [];
             $('.loader').show();

             $.ajax({
                 type: "POST",
                 data: JSON.stringify(jsArray),
                 url: "<%=GlobalUrl.getAllTripsDetails%>",
                 dataType: "json",
                 contentType: "application/json",
                 async: false,
                 success: function (data) {

                     $('.loader').hide();
                     if (data.msg == 'success') {

                         var result = data.data;
                         tabledata.clear();

                         for (var i = 0; i < result.length; i++) {

                             var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";

                             var tempString = [view, result[i].route, result[i].runType, result[i].vendorName, result[i].vendorCode, result[i].runStatus, result[i].vendorTripStatus, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub, result[i].paymentStatus];
                           
                             tabledata.row.add(tempString);
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
                 error: function (jqXHR, textStatue, errorThrown) {
                     alert("failed, please try again");
                 }
             });
         }

         /* function viewCheckList(id){
          console.log("id >> "+id );
          location.href = "tripDetailsView?type="+tripID 
          var urlOftripsDetail="tripDetailsView?type="+id;
          window.open(urlOftripsDetail, "TripsDetails", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
          
          } */
         function setTripStatus(tripId) {
             globalTripId = "";
             globalTripId = tripId;
             console.log("tripid : " + globalTripId);
         }

         function setTripStatus(tripId) {
             console.log("Trip od" + tripId);
             //	 tripId =  $("#tripID").val();		

             var json = {
                 "tripID": tripId
             }

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
                         /* jsondata=JSON.parse(result) */
                         var myForm = "";
                         myForm = document.getElementById("tripForm");
                         setData(myForm, result);
                         $("#tripID").val(result.tripID);
                     } else {
                         Toast.fire({
                             type: 'error',
                             title: 'Failed.. Try Again..'
                         })
                     }
                 },
                 error: function (jqXHR, textStatue, errorThrown) {
                     //alert("failed, please try again");
                     Toast.fire({
                         type: 'error',
                         title: 'Failed.. Try Again..'
                     })
                 }
             });
         }

         function searchTripData() {
             var jsArray = [];
             $('.loader').show();
             console.log("Status" + status);
             $.ajax({
                 type: "POST",
                 url: "<%=GlobalUrl.status%>?status=" + status,
             dataType: "json",
             contentType: "application/json",
             success: function (data) {
                 $('.loader').hide();
                 if (data.msg == "success") {
                     var result = data.data;
                     tabledata.clear();
                     for (var i = 0; i < result.length; i++) {

                         var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";

                         var tempString = [view, result[i].route, result[i].runType, result[i].vendorName, result[i].vendorCode, result[i].runStatus, result[i].vendorTripStatus, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub, result[i].paymentStatus];
                       
                         tabledata.row.add(tempString);
                     }
                     tabledata.draw();
                     $("tbody").show();
                 } else {
                     alert("failed");
                 }
             },
             error: function (jqXHR, textStatue, errorThrown) {
                 alert("failed, please try again");
             }
         });
     }

     function getFilterData() {
     	$('#selectTripStatus').val('');
         $('#selectStatus').val('');
         $('#selectPaymentStatus').val('');
     	
         
         var fromDate = $("#fromDate").val();
         var toDate = $("#toDate").val();
         
         if (fromDate == "" || fromDate == null) {
             //alert("plaese select from date"+fromDate);
             Toast.fire({
                 type: 'error',
                 title: 'Please Select Start Date..'
             });
             document.getElementById("fromDate").focus();
             return;
         }

         if (toDate == "" || toDate == null) {
             //alert("plaese select from date"+fromDate);
             Toast.fire({
                 type: 'error',
                 title: 'Please Select End Date..'
             });
             document.getElementById("toDate").focus();
             return;
         }
         $('.loader').show();

         $.ajax({
             type: "GET",
             data: {
             	"actualDeparture": fromDate.concat(" ","00:00:00"),
                 "actualArrival": toDate.concat(" ","23:59:59")
             },
             url: "<%=GlobalUrl.filterTripDetailsByNetwork%>",
             dataType: "json",
             contentType: "application/json",

             success: function (data) {
             	console.log(data," : data : ");
                 $('.loader').hide();
                 if (data.msg == 'success') {
                     //alert("Hiii");
                     console.log(data);

                     var result = data.data;
                     tabledata.clear();

                     for (var i = 0; i < result.length; i++) {

                         var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";

                         var tempString = [view, result[i].route, result[i].runType, result[i].vendorName, result[i].vendorCode, result[i].runStatus, result[i].vendorTripStatus, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub, result[i].paymentStatus];
                       
                         tabledata.row.add(tempString);
                     }
                     tabledata.draw();
                     $("tbody").show();                                                                    
                     } else {
                     console.log(data);
                     Toast.fire({
                         type: 'error',
                         title: 'Failed.. Try Again..'
                     })
                 }

             },
             error: function (jqXHR, textStatue, errorThrown) {
                 $('.loader').hide();
                 Toast.fire({
                     type: 'error',
                     title: '.. Try Again..'
                 })
             }

         });

     }


     function GetSelectedTextValue1() {
         
         var tripStatus = $("#selectTripStatus").val();
         var selectStatus = $("#selectStatus").val();
         var selectPaymentStatus = $("#selectPaymentStatus").val();
         var obj = {
             "runStatus": tripStatus,
             "vendorTripStatus": selectStatus,
             "paymentStatus": selectPaymentStatus,
         }

console.log("Status : ",obj);




         $('.loader').show();
         $.ajax({
             type: "POST",
             url: "<%=GlobalUrl.statusNetwork%>",
             dataType: "json",
             contentType: "application/json",
             data: JSON.stringify(obj),
             success: function (data) {
                 //alert("Hiiiiiiiiiiiiii");

                 $('.loader').hide();
                 if (data.msg == "success") {

                     var result = data.data;
                     console.log("****GetSelected******%%%%%%"+result);
                     tabledata.clear();

                     for (var i = 0; i < result.length; i++) {

                         var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";

                         var tempString = [view, result[i].route, result[i].runType, result[i].vendorName, result[i].vendorCode, result[i].runStatus, result[i].vendorTripStatus, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub, result[i].paymentStatus];
                       
                         tabledata.row.add(tempString);
                     }
                     tabledata.draw();
                     $("tbody").show();
                 } else {
                     alert("failed");
                 }
             },
             error: function (jqXHR, textStatue, errorThrown) {
                 alert("failed, please try again");
             }
         });
     }


            </script>
</body>

</html>
