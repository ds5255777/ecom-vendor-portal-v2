<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|PendingApprovalTrips</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="dist/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
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
		<jsp:include page="navbar.jsp?pagename=Pending For Approvel Trips" />
		<jsp:include page="sidebar_Vendor.jsp?pagename=pendingApproval" />
		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6"></div>
						<div class="col-sm-6"></div>
					</div>
				</div>
			</div>
			<section class="content mt-2">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12" style="font-size: 14px;">
							<div class="card card-primary ">
								<div class="card-body ">
								<form role="form" id="addForm" autocomplete="off">
										<div class="row">
											<div class="col-md-2">
												<div class="form-group">
													<select class="form-control" name="selectLevelValue"
														id="selectLevelValue" 
														style="height: auto;">
														<option value="">Select Type</option>
														<option value="route">Route</option>
														<option value="vehicle_number">Vehicle Number</option>
													</select>
												</div>
											</div>
											
											<div class="col-md-2">
												<div class="form-group" style="width: inherit;height: auto;">
													<input type="text" name="selectInputValue" style="height: auto;"
													placeholder="Enter Value" class="form-control" 
													id="selectInputValue">
												</div>
											</div>
											<div class="col-md-2">

												<button type="button" onclick="selectDropDownValue()"
													style="width: inherit;"
													class="btn btn-primary">Search</button>
											</div>
											
											<div class="col-md-2">
													 <input id="flipToInvoice" type="button" style="width: inherit;" class="btn btn-primary" onclick="approvedTrips()" value="Approve Trips" />
											</div>
											
											<div class="col-md-2">
												<div class="dropdown">
													<button type="button"
														class="btn btn-primary dropdown-toggle"
														style="width: inherit;"
														data-toggle="dropdown">Export Details</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="#" id="exportLinkPdf">Download
															PDF</a> <a class="dropdown-item" href="#" id="exportLink">Download
															Excel</a>
													</div>
												</div>
											</div>
											
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
									<table class="table table-bordered table-hover" id="tabledata">
										<thead>
											<tr>
												<th class="bg-primary" ><button type="button" id="checkButton" class="btn btn-default btn-sm checkbox-toggle"><i class="far fa-square"></i>
                                                    </button></th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip Id</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Mode</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Billable KM</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Actual Arrival / Departure</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vehicle No. / Size</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Total Freight</th>
												<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Approve</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<div class="modal fade" id="tripValue" role="dialog">
			<div class="modal-dialog " style="max-width: 1400px;">
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
										<div class="card-body" style="padding-bottom: inherit;">
											<form role="form" id="tripForm" autocomplete="off">
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
															<label class="col-sm-5"
																title="Opening Reading">Opening Reading</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" placeholder="Trip Strating reading"
																onkeypress="return event.charCode >= 48 && event.charCode <= 57" maxlength="5"
																	id="openingReading" name="openingReading">
															</div>
														</div>
													</div>
													<div class="col-md-3">
														<div class="form-group row">
															<label class="col-sm-5"
																title="Closing Reading">Closing Reading</label>
															<div class="col-sm-7">
																<input type="text" class="form-control" placeholder="Trip Closing reading"
																	onkeypress="return event.charCode >= 48 && event.charCode <= 57" id="closingReading"  maxlength="5" name="closingReading">
															</div>
														</div>
													</div>
													
														<div class="col-md-6">
														<div class="form-group row">
														<label class="col-sm-3"
																title="Remarks">Remarks</label>
																<div class="col-sm-9">
															<textarea class="form-control" id="comment"
																name="comment" maxlength="250" required="required"
																placeholder="Remarks if any" rows="1"></textarea>
														</div>
														</div>
														</div>
														<input type="hidden" id="id" name="id" disabled>
														<div class="d-grid gap-2 col-6 mx-auto">

															<div class="form-group row">

																<div class="col-sm-4">
																	<button type="button" class="btn btn-primary"
																		data-toggle="modal" data-target="#myModal"
																		 style="margin-right: 10px; width: inherit;">Approve</button>
																		 </div>
																		 <div class="col-sm-4">
																	<button id="openCoaDetails" type="button"
																		class="btn btn-success" style="margin-right: 10px; width: inherit;"
																		onclick="saveQuery()">Query</button>
																		</div>
																		<div class="col-sm-4">
																	<button type="button" class="btn btn-secondary" style="margin-right: 10px; width: inherit;"
																		id="closeModal" data-dismiss="modal">Close</button>
																		</div>
															</div>
														</div>
													
													
													

															<input type="hidden" class="form-control" id="vendorCode"
																name="vendorCode" value="${userName}" readonly>
												</div>
											</form>
										</div>
									</div>
									<div class=" card-primary">
										<div class="card card-primary ">
											<div class="card-header" style="padding: 4px 0px 4px 4px;">
												<h3 class="card-title" style="font-size: 15px;">Trips
													Query</h3>
											</div>

											<div class="card-body " style="padding: inherit;">
												<form role="form" id="showQueryDetails"
													name="showQueryDetails" style="padding-top: 10px;">
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
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<h3 class="modal-title">Confirmation</h3>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<p>Sure want to Approve Trip.</p>
					</div>
					<div class="modal-footer">

						<button type="button" onclick="updateTripData()" id="updateBtnBtn"
							name="updateBtnBtn" class="btn btn-primary">Approve</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="plugins/jquery/jquery.min.js"></script>
		<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
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
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            
            var dataLimit='${dataLimit}';
    		dataLimit=parseInt(dataLimit);
    		
    		$("#refreshDashboardButton").click(function(e) {
                e.preventDefault();
                $('#refreshDashboardButton').attr('disabled', 'disabled');
                getData();
                $('#refreshDashboardButton').removeAttr('disabled');
                $('#selectLevelValue').val('');
                $('#selectInputValue').val('');
                $('#checkButton').prop( "checked", true );
            })


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
                buttons: [
                    {
                        extend: 'excelHtml5',
                        exportOptions: {
                            columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ],
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'A4',
                        exportOptions: {
                            columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ],
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
            
            $('#searchData').on( 'keyup', function () {
            	tabledata.search( this.value ).draw();
            } );
            
            $('#tabledata_filter').css("display","none");
            
            var tabledataQuery = $('#tabledataQuery').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": false,
                "aaSorting": [],
                "pageLength": dataLimit
            });
            
            $(function() {
                $('.checkbox-toggle').click(function() {
                    var clicks = $(this).data('clicks')
                    if (clicks) {
                        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', false)
                        $('.checkbox-toggle .far.fa-check-square').removeClass('fa-check-square').addClass('fa-square')
                    } else {
                        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', true)
                        $('.checkbox-toggle .far.fa-square').removeClass('fa-square').addClass('fa-check-square')
                    }
                    $(this).data('clicks', !clicks)
                })
                $('.mailbox-star').click(function(e) {
                    e.preventDefault()
                    var $this = $(this).find('a > i')
                    var glyph = $this.hasClass('glyphicon')
                    var fa = $this.hasClass('fa')

                    if (glyph) {
                        $this.toggleClass('glyphicon-star')
                        $this.toggleClass('glyphicon-star-empty')
                    }

                    if (fa) {
                        $this.toggleClass('fa-star')
                        $this.toggleClass('fa-star-o')
                    }
                })
            })
            
            
            var globalTripId = "";

            getData();

            function getData() {

                $('.loader').show();

                $.ajax({
                    type: "POST",
                    data: "",
                    url: "<%=GlobalUrl.getPendingApprovelTripsDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    success: function(data) {

                        $('.loader').hide();
                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();

                            for (var i = 0; i < result.length; i++) {
                            	
                            	if(!result[i].hasOwnProperty("tripID")){
     								result[i].tripID="";
     							}
                                 if(!result[i].hasOwnProperty("route")){
     								result[i].route="";
     							}
                                 if(!result[i].hasOwnProperty("runType")){
     								result[i].runType="";
     							}
                                 if(!result[i].hasOwnProperty("actualKM")){
     								result[i].actualKM="";
     							}
                                 if(!result[i].hasOwnProperty("standardKM")){
     								result[i].standardKM="";
     							}
                                 if(!result[i].hasOwnProperty("mode")){
      								result[i].mode="";
      							}
                                  if(!result[i].hasOwnProperty("originHub")){
      								result[i].originHub="";
      							}
                                  if(!result[i].hasOwnProperty("destHub")){
      								result[i].destHub="";
      							}
                                var approve = "<button type=\"button\" class=\"btn btn-primary btn-xs\" data-toggle=\"modal\" data-target=\"#myModal\" onclick=\"setTripStatus('" + result[i].tripID + "')\" ><i class=\"nav-icon fas fa-pencil-square-o\"> </i> </button>";
                               
                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getTripDataFormDataByTripId('" + result[i].tripID + "')\" >" + result[i].tripID + "</a>";
                                
                                var checkbox = "<div class=\"mailbox-messages\"><input type=\"checkbox\" name=\"option\" value=\"" + result[i].tripID + "\" ><\div>";

	
                                tabledata.row.add([
                                	checkbox,
                                	view, 
                                	result[i].route, 
                                	result[i].runType, 
                                	result[i].mode, 
                                	result[i].standardKM, 
                                	result[i].actualDeparture+" / "+result[i].actualArrival, 
                                	result[i].vehicleNumber+" / "+result[i].standardVechicleType, 
                                	result[i].totalFreight, 
                                	approve]);
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
                globalTripId = "";
                globalTripId = tripId;
            }
      
            function getTripDataFormDataByTripId(tripId) {
                $('.loader').show();

                globalTripId=tripId;
                var json = {
                    "tripID": tripId
                }
                var queryArray=[];
                console.log("trip id json :",json)
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.tripDetailByTripId%>",
                    dataType: "json",
                    async: false,
                    contentType: "application/json",
                    success: function(data) {
                    	$('.loader').hide();
                        if (data.msg == 'success') {
                            var result = data.data;
							
                            queryArray = data.data.queryEntity;
                            var myForm = "";
                            myForm = document.getElementById("tripForm");
                            setData(myForm, result);
                            $("#tripID").val(result.tripID);
                            getQueryData(result.tripID);

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

            function saveQuery() {
			
				var queryByVendor = document.getElementById("comment").value;
				if (queryByVendor === "" || queryByVendor === null || queryByVendor === '') {
                    Toast.fire({
                        type: 'error',
                        title: 'If any query, Please Comment'
                    });
                    document.getElementById("comment").focus();
                    return "";
                }
				
                var json={
                "comment": $("#comment").val(),
                "raisedAgainQuery": $("#tripID").val(),
                "raisedBy": $("#vendorName").val(),
                "id": $("#id").val(),
                "type":"Trip"
                
                }
            	$('.loader').show();                
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.saveQuery%>",
                    dataType: "json",
                    contentType: "application/json",
					
                    success: function(response) {
                    	$('.loader').hide();
                        if (response.msg == 'success') {
                        	
                            swal.fire("", "Remarks Submitted Sucessfully.", "success", "OK").then(function() {
                                window.location = "pendingApproval";
                            });

                            setTimeout(function(response) {

                            }, 2000);
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
            
function updateTripData(){
	if (globalTripId == "") {
        return;
    }

    var obj = {
        "tripID": globalTripId,
        "vendorTripStatus": "<%=GlobalConstants.VENDOR_TRIP_STATUS_APPROVED%>",
        "openingReading":$("#openingReading").val(),
        "closingReading":$("#closingReading").val(),
        "vendorCode":$("#vendorCode").val()
    }
    $('.loader').show();

    $.ajax({
        type: "POST",
        url: "<%=GlobalUrl.updateVendorTripStatusAndOpenCloseReadingByTripId%>",
        data: JSON.stringify(obj),
        dataType: "json",
        contentType: "application/json",
        success: function(response) {
            $('.loader').hide();
            $("#myModal").modal('hide');
            if (response.msg == "success") {
            	swal.fire("", "Trip Approved Sucessfully.", "success", "OK")
            	$("#tripValue").modal('hide');
            	$("#openingReading").val('');
            	$("#closingReading").val('');
                getData();
            } else {
                Toast.fire({
                    type: 'error',
                    title: 'Failed Added..'
                })
            }
        },
        error: function(jqXHR, textStatue, errorThrown) {
            $('.loader').hide();
            Toast.fire({
                type: 'error',
                title: 'Failed Added..'
            })
        }
    });
	
}

function getQueryData(tripId){
	$('.loader').show();
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
						$('.loader').hide();
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
	 
function selectDropDownValue(){
	
	var columnName= $("#selectLevelValue").val();
	var columnValue=$("#selectInputValue").val();
	var vendorCode=$("#vendorCode").val();
	
	if (columnName == "" || columnName == null) {
        Toast.fire({
            type: 'error',
            title: 'Select Column Type.'
        });
        document.getElementById("selectLevelValue").focus();
        return;
    }
	
	if (columnValue == "" || columnValue == null) {
        Toast.fire({
            type: 'error',
            title: 'Please Insert Value.'
        });
        document.getElementById("selectInputValue").focus();
        return;
    }
	
	 var json ={
				"columnName":columnName,
				"columnValue":columnValue,
				"tripStatus":'<%=GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED%>',
				"vendorCode":vendorCode
		}

	 console.log(json);
	 $('.loader').show();
	 $.ajax({
			type : "GET",
			url : "<%=GlobalUrl.filterByColumn%>",
			data :json,
			dataType : "json",
			contentType : "application/json",
			success : function(response) {
				$('.loader').hide();
				if (response.msg == "success") {
					 var result = response.data;
                        tabledata.clear();
                        for (var i = 0; i < result.length; i++) {
                        	if (!result[i].hasOwnProperty("tripID")) {
                                result[i].tripID = "";
                            }
                            if (!result[i].hasOwnProperty("route")) {
                                result[i].route = "";
                            }
                            if (!result[i].hasOwnProperty("originHub")) {
                                result[i].originHub = "";
                            }
                            if (!result[i].hasOwnProperty("destHub")) {
                                result[i].destHub = "";
                            }
                            if (!result[i].hasOwnProperty("runType")) {
                                result[i].runType = "";
                            }
                            if (!result[i].hasOwnProperty("standardKM")) {
                                result[i].standardKM = "";
                            }
                            if (!result[i].hasOwnProperty("mode")) {
                                result[i].mode = "";
                            }
                            if (!result[i].hasOwnProperty("actualDeparture")) {
                                result[i].actualDeparture = "";
                            }
                            if (!result[i].hasOwnProperty("actualArrival")) {
                                result[i].actualArrival = "";
                            }

                            var approve = "<button type=\"button\" class=\"btn btn-primary btn-xs\" data-toggle=\"modal\" data-target=\"#myModal\" onclick=\"setTripStatus('" + result[i].tripID + "')\" ><i class=\"nav-icon fas fa-pencil-square-o\"> </i> </button>";
                            
                            var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getTripDataFormDataByTripId('" + result[i].tripID + "')\" >" + result[i].tripID + "</a>";
                            
                            var checkbox = "<div class=\"mailbox-messages\"><input type=\"checkbox\" name=\"option\" value=\"" + result[i].tripID + "\" ><\div>";

                            tabledata.row.add([
                            	checkbox,
                            	view, 
                            	result[i].route, 
                            	result[i].runType, 
                            	result[i].mode, 
                            	result[i].standardKM, 
                            	result[i].actualDeparture+" / "+result[i].actualArrival, 
                            	result[i].vehicleNumber+" / "+result[i].standardVechicleType, 
                            	result[i].totalFreight, 
                            	approve]);
                        }
                        tabledata.draw();
                        $("tbody").show();
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

	function approvedTrips(){
		var table = document.getElementById('tabledata');
        var checkflag = [];
        $("input:checkbox[name='option']:checked").each(function() {
            checkflag.push($(this).val());
        });

        let values = checkflag.toString();
        if (values == "" || values == null) {
            Toast.fire({
                type: 'error',
                title: 'Please select atleast one trip'
            })
            return;
        }
        console.log(values);
        
        json={
        		"tripID": values,
        		"vendorTripStatus": "<%=GlobalConstants.VENDOR_TRIP_STATUS_APPROVED%>"
        }
        
        console.log(json);
        
        $.ajax({
            type: "GET",
            data: json,
            url: "<%=GlobalUrl.multipleTripApproved%>",
            dataType: "json",
            contentType: "application/json",
            success: function(data) {
            	$('.loader').hide();
                 if (data.msg == 'success') {
                	 swal.fire("", "Trip Approved Sucessfully.", "success", "OK")
                	 $("#openingReading").val('');
                	 $("#closingReading").val('');
                	 $("#selectLevelValue").val('');
                	 $("#selectInputValue").val('');
                	 getData();
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
        </script>
</body>

</html>

