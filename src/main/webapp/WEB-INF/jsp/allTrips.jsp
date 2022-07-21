<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|AllTrips</title>

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
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
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
		},
		"Closed" : {
			"Yet To Be Approved" : [ "NA" ],
			"Yet To Be Approved By Network Team" : [ "NA" ],
			"Query" : [ "NA" ],
			"Approved" : [ "Pending" ],
			"Draft-Invoicing" : [ "NA" ],
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
			GetSelectedTextValue();
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
			GetSelectedTextValue();
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
		<jsp:include page="navbar.jsp?pagename=All Trips" />
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->

		<%
		String rolename = (String) request.getSession().getAttribute("role");
		%>
		<c:choose>
			<c:when test='<%=rolename.equalsIgnoreCase("Admin")%>'>
				<jsp:include page="sidebar_Admin.jsp?pagename=allTrips" />
			</c:when>
			<c:otherwise>
				<jsp:include page="sidebar_Vendor.jsp?pagename=allTrips" />
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
												<input type="text" name="fromDate"
													placeholder="Act Dept Start Date" class="form-control"
													id="fromDate" readonly>
											</div>
											<div class="col-md-1">
												<input type="text" name="toDate"
													placeholder="Act Dept End Date" class="form-control"
													id="toDate" readonly>
											</div>
											<div class="col-md-1">

												<button type="button" onclick="getFilterData()"
													style="imargin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
													class="btn btn-primary">Search</button>
											</div>

											<div class="col-md-1">
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
											<div class="col-md-6"></div>
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
										id="tabledata" style="width:100%">
										<thead>
											<tr>
												<th class="bg-primary">Trip Id</th>
												<th class="bg-primary">Route</th>
												<th class="bg-primary">Run Type</th>
												<th class="bg-primary">Run Status</th>
												<th class="bg-primary">Vendor Status</th>
												<th class="bg-primary">Act Dept</th>
												<th class="bg-primary" >Vehicle No. / Size</th>
												<th class="bg-primary">Std. KM</th>
												 <th class="bg-primary" >Total Freight</th>
												 <th class="bg-primary">Invoice Number</th>
												<th class="bg-primary">Pay Status</th>
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
										<div class="card-header" style="padding: 0px 5px 0px 5px;">
											<h3 class="card-title" style="font-size: 15px;padding-top: 6px;">Trip
												Details</h3>
												<button type="button" class="btn btn-sm" id="closeModal" style="float: right;padding: 5px 5px 0px 0;"
												data-dismiss="modal"><i class="nav-icon far fa-window-close" style="font-size: 20px; color: white;"></i></button>
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
															<label class="col-sm-5" title="Standard Vehicle Type">Std. Vehicle
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
															<label class="col-sm-5" title="Current Fuel Rate">Fuel Rate</label>
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
															<label class="col-sm-5" title="FS">FS Amount</label>
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
																title="Lump Sum Amount (Total Trip Cost)">Lump Sum Amt.</label>
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
		<script src="plugins/jszip/jszip.min.js"></script>
		<script src="plugins/pdfmake/pdfmake.min.js"></script>
		<script src="plugins/pdfmake/vfs_fonts.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
		
		<script type="text/javascript">
        
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });

		var currentDate='${currentDate}';
		var dataLimit='${dataLimit}';
		dataLimit=parseInt(dataLimit);
		
            var tabledata = $('#tabledata').DataTable({
            	
                "paging": true,
                "lengthChange": false,
                "searching": true,
                "info": true,
                "autoWidth": true,
                "aaSorting": [],
                "scrollX": true,
                "pageLength": dataLimit,
                dom: 'Bfrtip',
                //buttons: ['excel','pdf','print'],
                buttons: [

                    {
                        extend: 'excelHtml5',

                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'A4',
                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
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
            
            $('#tabledata_filter').css("display","none");
         

            var tabledataQuery = $('#tabledataQuery').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": true,
                "aaSorting": []
            });

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

           /*  $.validator.setDefaults({
                submitHandler: function() {
                    getFilterData();
                }
            }); */

            $("#refreshDashboardButton").click(function(e) {
                e.preventDefault();
                $('#refreshDashboardButton').attr('disabled', 'disabled');
                getData();
                $('#refreshDashboardButton').removeAttr('disabled');
                $('#selectTripStatus').val('');
                $('#selectStatus').val('');
                $('#selectPaymentStatus').val('');
                $('#fromDate').val('');
                $('#toDate').val('');
                $('#searchData').val('');
            })
            
           getData();

            function getData() {

                $('.loader').show();

                $.ajax({
                    type: "POST",
                    data: "",
                    url: "<%=GlobalUrl.getAllTripsDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    success: function(data) {
//return;
                        $('.loader').hide();
                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();

                            for (var i = 0; i < result.length; i++) {
                            	
                            	if(!result[i].hasOwnProperty("tripID")){
     								result[i].tripID="-";
     							}
								if(!result[i].hasOwnProperty("route")){
     								result[i].route="-";
     							}
                                 if(!result[i].hasOwnProperty("runType")){
     								result[i].runType="-";
     							}
                                 if(!result[i].hasOwnProperty("runStatus")){
      								result[i].runStatus="-";
      							}
                                 if(!result[i].hasOwnProperty("vendorTripStatus")){
     								result[i].vendorTripStatus="-";
     							}
                                 if(!result[i].hasOwnProperty("actualDeparture")){
      								result[i].actualDeparture="-";
      							}
                                 if(!result[i].hasOwnProperty("vehicleNumber")){
           							result[i].vehicleNumber="-";
           						}
                                 if(!result[i].hasOwnProperty("standardVechicleType")){
           							result[i].standardVechicleType="-";
           						}
                                 if(!result[i].hasOwnProperty("standardKM")){
     								result[i].standardKM="-";
     							}
                                 if(!result[i].hasOwnProperty("totalFreight")){
           							result[i].totalFreight="-";
           						}
                                   if(!result[i].hasOwnProperty("invoiceNumber")){
             							result[i].invoiceNumber="-";
             						}
                                  if(!result[i].hasOwnProperty("paymentStatus")){
        							result[i].paymentStatus="-";
        						}

                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";
                               
                                tabledata.row.add([
                                	view, 
                                	result[i].route,
                                	result[i].runType, 
                                	result[i].runStatus,
                                	result[i].vendorTripStatus,
                                	result[i].actualDeparture, 
                                	result[i].vehicleNumber+" / "+result[i].standardVechicleType,  
                                	result[i].standardKM, 
                                	result[i].totalFreight,
                                	result[i].invoiceNumber, 
                                	result[i].paymentStatus]);
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
           
            function setTripStatus(tripId) {
                var json = {
                    "tripID": tripId
                }

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.tripDetailByTripId%>",
                    dataType: "json",
                    contentType: "application/json",
                    success: function(data) {

                        if (data.msg == 'success') {
                            var result = data.data;
                            var myForm = "";
                            myForm = document.getElementById("tripForm");
                            setData(myForm, result);
                            $("#tripID").val(result.tripID);
                            getQueryData(result.tripID)
                        } else {
                            Toast.fire({
                                type: 'error',
                                title: 'Failed.. Try Again..'
                            })
                        }
                    },
                    error: function(jqXHR, textStatue, errorThrown) {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                });
            }

            function getFilterData() {

                var fromDate = $("#fromDate").val();
                var toDate = $("#toDate").val();
                var vendorCode = $("#vendorCode").val();
                
                /* var d = new Date(); */
                console.log(fromDate ,"  ", toDate);
                fromDate=moment(fromDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
                toDate=moment(toDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
                console.log("After : ",fromDate ,"  ", toDate);
                
                $('#selectTripStatus').val('');
                $('#selectStatus').val('');
                $('#selectPaymentStatus').val('');
                

                if (fromDate == "" || fromDate == null) {
                    Toast.fire({
                        type: 'error',
                        title: 'Please Select Start Date..'
                    });
                    document.getElementById("fromDate").focus();
                    return;
                }

                if (toDate == "" || toDate == null) {
                    Toast.fire({
                        type: 'error',
                        title: 'Please Select End Date..'
                    });
                    document.getElementById("toDate").focus();
                    return;
                }
                
              var dateReturnCheck=  dateValidationCheck(fromDate,toDate);
              if(dateReturnCheck == "false"){
            	 
                  $('.loader').show();


                  $.ajax({
                      type: "GET",
                      data: {
                          "actualDeparture": fromDate.concat(" ","00:00:00"),
                          "actualArrival": toDate.concat(" ","23:59:59"),
                          "vendorCode": vendorCode
                      },
                      url: "<%=GlobalUrl.filterTripDetails%>",
                      dataType: "json",
                      contentType: "application/json",

                      success: function(data) {
                          $('.loader').hide();
                          if (data.msg == 'success') {

                              var result = data.data;
                              tabledata.clear();

                              for (var i = 0; i < result.length; i++) {
                            	  if(!result[i].hasOwnProperty("tripID")){
       								result[i].tripID="-";
       							}
  								if(!result[i].hasOwnProperty("route")){
       								result[i].route="-";
       							}
                                   if(!result[i].hasOwnProperty("runType")){
       								result[i].runType="-";
       							}
                                   if(!result[i].hasOwnProperty("runStatus")){
        								result[i].runStatus="-";
        							}
                                   if(!result[i].hasOwnProperty("vendorTripStatus")){
       								result[i].vendorTripStatus="-";
       							}
                                   if(!result[i].hasOwnProperty("actualDeparture")){
        								result[i].actualDeparture="-";
        							}
                                   if(!result[i].hasOwnProperty("vehicleNumber")){
             							result[i].vehicleNumber="-";
             						}
                                   if(!result[i].hasOwnProperty("standardVechicleType")){
             							result[i].standardVechicleType="-";
             						}
                                   if(!result[i].hasOwnProperty("standardKM")){
       								result[i].standardKM="-";
       							}
                                   if(!result[i].hasOwnProperty("totalFreight")){
             							result[i].totalFreight="-";
             						}
                                     if(!result[i].hasOwnProperty("invoiceNumber")){
               							result[i].invoiceNumber="-";
               						}
                                    if(!result[i].hasOwnProperty("paymentStatus")){
          							result[i].paymentStatus="-";
          						}

                                  var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";
                                 
                                  tabledata.row.add([view, 
                                	result[i].route,
                                	result[i].runType, 
                                	result[i].runStatus,
                                	result[i].vendorTripStatus,
                                	result[i].actualDeparture, 
                                	result[i].vehicleNumber+" / "+result[i].standardVechicleType,  
                                	result[i].standardKM, 
                                	result[i].totalFreight,
                                	result[i].invoiceNumber, 
                                	result[i].paymentStatus]);
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
                      error: function(jqXHR, textStatue, errorThrown) {
                          $('.loader').hide();
                          Toast.fire({
                              type: 'error',
                              title: '.. Try Again..'
                          })
                      }

                  });
              }else{
            	  Toast.fire({
                      type: 'error',
                      title: 'Start Date Less than End Date.'
                  });
            	  $('#fromDate').val('');
                  document.getElementById("fromDate").focus();
                  return;
              }
            }
            //getQueryData();
   		 
   		 function getQueryData(tripId){
   			 
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
   			     								result[i].raisedBy="-";
   			     							}
   				                        	if(!result[i].hasOwnProperty("role")){
   			     								result[i].role="-";
   			     							}
   				                        	if(!result[i].hasOwnProperty("raisedOn")){
   			     								result[i].raisedOn="-";
   			     							}
   				                        	if(!result[i].hasOwnProperty("comment")){
   			     								result[i].comment="-";
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
        </script>
</body>

</html>
