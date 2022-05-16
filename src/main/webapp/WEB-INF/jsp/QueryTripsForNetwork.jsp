<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|QueryRaised</title>

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
		<jsp:include page="navbar.jsp?pagename=Query Raised" />
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="slidebar.jsp?pagename=Query Raised" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6"></div>
						<div class="col-sm-6">
							<!-- <ol class="breadcrumb float-sm-right">
                                                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active">Dashboard v1</li>
                                                    </ol> -->
						</div>

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
							<form role="form" id="addForm" autocomplete="off">
								<div class="row">

									<div class="col-md-2">
										<div class="dropdown">
											<button type="button" class="btn btn-primary dropdown-toggle"
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
							<!-- /.card-header -->
							<div class="card-body table-responsive p-0"
								style="height: 420px;">
								<table class="table table-head-fixed" id="tabledata1">
									<thead>
										<tr>

											<th class="bg-primary">Trip ID</th>
											<th class="bg-primary">Route</th>
											<th class="bg-primary">Vendor Name</th>
											<th class="bg-primary">Vendor Code</th>
											<th class="bg-primary">Run Type</th>
											<th class="bg-primary">Trip Status</th>
											<th class="bg-primary">Vehicle Number</th>

										</tr>
									</thead>

									<tbody>
										<c:forEach var="ApprovedAllDetails"
											items="${AllDetailsForNetwork}">
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



		<!-- Modal -->
		<div class="modal fade" id="tripValue" role="dialog">
			<div class="modal-dialog " style="max-width: 1200px;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-body" style="overflow-y: auto;">
						<div class="container-fluid panel2" id="headerLineItemForm">
							<div class="row">
								<div class="col-md-12 propTableContainer"
									style="overflow-y: auto; height: 650px;">
									<input type="hidden" id="headerDetailsId" class="form-control">
									<table class="table table-striped" id="tripDetailsTable">
										<div class="card card-primary">
											<div class="card-header" style="padding: 4px 0px 4px 4px;">
												<h3 class="card-title" style="font-size: 15px;">Trip
													Details</h3>
											</div>


											<!-- /.card-header -->
											<div class="card-body">
												<form role="form" id="tripForm1">

													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<div class="row">
																	<label style="margin-top: 5px; margin-left: 10px;">Trip
																		ID</label>
																</div>
																<input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter" id="tripID"
																	name="tripID" autocomplete="off" disabled>
															</div>
														</div>

														<div class="col-sm-3">

															<div class="form-group">
																<label style="margin-bottom: 1px;">Vendor Name</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="vendorName" name="vendorName"
																	autocomplete="off" disabled>
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Route</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="route" name="route"
																	autocomplete="off">
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Run Type</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="runType" name="runType"
																	autocomplete="off" disabled>
															</div>
														</div>
													</div>

													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Mode</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="mode" name="mode"
																	autocomplete="off" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Vehicle
																	Number</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="vehicleNumber" name="vehicleNumber"
																	autocomplete="off">
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Actual
																	Vehicle Type</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="actualVechicleType" name="actualVechicleType"
																	autocomplete="off" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Standard
																	Shipment Capacity</label> <input type="text"
																	class="form-control" style="height: 30px;"
																	placeholder="Enter" id="standardShipmentCapacity"
																	name="standardShipmentCapacity" autocomplete="off"
																	disabled>
															</div>
														</div>

													</div>
													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Standard
																	Payload Capacity</label> <input type="text"
																	class="form-control" style="height: 30px;"
																	placeholder="Enter" id="standardPayloadCapacity"
																	name="standardPayloadCapacity" autocomplete="off"
																	disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Run Status</label>
																<div class="form-group">
																	<input type="text" class="form-control"
																		style="height: 30px;" id="runStatus" name="runStatus"
																		autocomplete="off" disabled>
																</div>
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Origin Hub</label>
																<div class="form-group">
																	<input type="text" class="form-control"
																		autocomplete="off" style="height: 30px;"
																		id="originHub" name="originHub" disabled>
																</div>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Origin Region</label>
																<input type="text" class="form-control"
																	autocomplete="off" style="height: 30px;"
																	placeholder="Enter" id="originRegion"
																	name="originRegion" disabled>
															</div>
														</div>

													</div>



													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Dest Hub</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" autocomplete="off" id="destHub"
																	name="destHub" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Actual
																	Departure (ATD)</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="actualDeparture"
																	name="actualDeparture" disabled>
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Actual
																	Arrival (ATA)</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="actualArrival"
																	name="actualArrival" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Actual KM</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" autocomplete="off" id="actualKM"
																	name="actualKM" disabled>
															</div>
														</div>
													</div>



													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Standard KM</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" autocomplete="off" id="standardKM"
																	name="standardKM">
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Mileage</label> <input
																	type="text" class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="mileage" name="mileage">
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Rate per KM</label> <input
																	type="text" class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="ratePerKm" name="ratePerKm">
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Billable KM</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="routeKms" name="routeKms">
															</div>
														</div>
													</div>






													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">FS Base Rate</label>
																<input type="text"
																	class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	onclick="setTimeout(calcualteFormulae, 3000)"
																	autocomplete="off" id="fsBaseRate" name="fsBaseRate">
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Current Fuel
																	Rate</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="currentFuelRate" name="currentFuelRate">
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">FS Diff</label> <input
																	type="text" class="form-control numberWithDecimalcheck"
																	style="height: 30px;"
																	onclick="setTimeout(calcualteFormulae, 3000)"
																	placeholder="Enter" autocomplete="off" id="fsDiff"
																	name="fsDiff">
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Basic Freight</label>
																<input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="basicFreight" name="basicFreight">
															</div>
														</div>
													</div>

													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">FS</label> <input
																	type="text" class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="fs" name="fs">
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Total Freight
																	(Total Trip Cost)</label> <input type="text"
																	class="form-control" style="height: 30px;"
																	placeholder="Enter" id="totalFreight"
																	name="totalFreight">
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Opening
																	Reading</label> <input type="text"
																	class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="openingReading"
																	name="openingReading">
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Closing
																	Reading</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="closingReading" name="closingReading">
															</div>
														</div>

														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">

																<input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="vendorCode" name="vendorCode" hidden>
															</div>
														</div>
													</div>


													<div class="row">


														<div class="col-sm-6">
															<!-- text input -->
															<div class="form-group">
																<input type="checkbox" id="lumpsum" name="lumpsum"
																	class="messageCheckbox" value=""
																	onclick="lumpsomePropertyChange()"> <label
																	for="lumsum"> If Lump Some amount is applicable</label><br>
																<div class="form-group">
																	<label style="margin-bottom: 1px;">Amount</label> <input
																		type="text" class="form-control" style="height: 30px;"
																		placeholder="Enter" id="AmountLumpSum"
																		name="AmountLumpSum">
																</div>
															</div>
														</div>

														<div class="col-sm-6">
															<textarea class="form-control" id="comment"
																name="comment" maxlength="250"
																placeholder="Remarks if any" rows="3"></textarea>
														</div>


													</div>

												</form>
											</div>
											<!-- /.card-body -->
										</div>
										<!-- /.card -->
									</table>


									<div class="row" style="padding: 15px;">

										<button id="saveCoaDetails" type="button"
											class="btn btn-success" style="margin-right: 10px;"
											onclick="updateTripDataByNetworkTeam('No')">Submit
											to Vendor</button>

										<button type="button" class="btn btn-secondary"
											id="closeModal" data-dismiss="modal">Close</button>
										&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-warning" id="recalculate"
											onclick="refreshValues()">Refresh</button>

									</div>


									<div class="col-md-12">
										<div class="card card-primary ">
											<div class="card-header" style="padding: 4px 0px 4px 4px;">
												<h3 class="card-title" style="font-size: 15px;">Ad-Hoc
													Trips Query</h3>
											</div>

											<div class="card-body ">
												<form role="form" id="showQueryDetails"
													name="showQueryDetails">
													<table class="table table-bordered table-hover"
														id="tabledata">
														<thead>
															<tr>
																<th style="padding: 5px 5px 5px 1.5rem;">S.No</th>
																<th style="padding: 5px 5px 5px 1.5rem;">Raised By</th>
																<th style="padding: 5px 5px 5px 1.5rem;">Raised On</th>
																<th style="padding: 5px 5px 5px 1.5rem;">Remarks</th>

															</tr>
														</thead>
														<tbody>

														</tbody>
													</table>
												</form>
											</div>

										</div>
									</div>



								</div>
								<!--                                        <div class="col-md-5">
                                        <%-- <a href="${pageContext.request.contextPath}/getDoc" target="_blank">Click Here to open doc in new window</a> --%>
                                         <iframe id="pdfLink" style="height:100%; width:100%"> 

                                         Comment History window 
                                        <div class="card card-primary ">
                                            <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                                <h3 class="card-title" style="font-size: 15px;">Ad-Hoc Trips Query</h3>
                                            </div>
                                             /.card-header 
                                            <div class="card-body ">
                                                <form role="form" id="showQueryDetails" name="showQueryDetails">
                                                    <table class="table table-bordered table-hover" id="tabledata">
                                                        <thead>
                                                            <tr>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">S.No</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Date</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Comment</th>

                                                            </tr>
                                                        </thead>
                                                        <tbody>

                                                        </tbody>
                                                    </table>
                                                </form>
                                            </div>
                                             /.card-body 
                                        </div>

                                         Comment History window 


                                    </div>-->
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
                                                                    columns: [ 0, 1, 2, 3, 4],
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
                                                    console.log(document.getElementById("mode").value);
                                                    //alert(document.getElementById("mode").value);
                                                    if (document.getElementById("mode").value === "Line Haul") {
                                                        document.getElementById("openingReading").d = 'true';
                                                        document.getElementById("closingReading").d = 'true';
                                                        //    document.getElementById("tdsRate").val()="";
                                                        //            	    document.getElementById("tdsSection").value()="";
                                                        $("#tdsSection").val("");
                                                        $("#tdsRate").val("");
                                                    } else {
                                                        document.getElementById("openingReading").d = '';
                                                        document.getElementById("closingReading").d = '';
                                                    }


                                                    var globalTripId = "";
                                                    function setTripStatus(tripId) {

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
                                                                console.log("data.msg" + data.msg);
                                                                if (data.msg == 'success') {
                                                                    var result = data.data;
                                                                    var myForm = "";
                                                                    myForm = document.getElementById("tripForm1");
                                                                    console.log("result " + result.innerHTML);
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
                                                                //alert("failed, please try again");
                                                                Toast.fire({
                                                                    type: 'error',
                                                                    title: 'Failed.. Try Again..'
                                                                })
                                                            }

                                                        });


                                                        //Ajax to get remarks
                                                        $.ajax({
                                                            type: "POST",
                                                            data: JSON.stringify(json),
                                                            url: "<%=GlobalUrl.getRemarksByRefID%>",
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            async: false,
                                                            success: function (data) {
                                                                console.log("data.msg" + data.msg);
                                                                console.log("data.data " + data.data);
                                                                console.log("Actual data.data " + JSON.stringify(data.data));
                                                                if (data.msg == 'success') {
                                                                    var resData = data.data;
                                                                    var table = document.getElementById("tabledata");
                                                                    for (i = 0; i < resData.length; i++) {
                                                                        console.log(resData[i].id);
                                                                        console.log(resData[i].comment);
                                                                        var row = table.insertRow(i + 1);


                                                                        var cell1 = row.insertCell(0);
                                                                        var cell2 = row.insertCell(1);
                                                                        var cell3 = row.insertCell(2);
                                                                        var cell4 = row.insertCell(3);

                                                                        cell1.innerHTML = i + 1;
                                                                        cell2.innerHTML = resData[i].raisedBy;
                                                                        cell3.innerHTML = resData[i].raisedOn;
                                                                        cell4.innerHTML = resData[i].comment;


                                                                    }
                                                                }
                                                            }


                                                        });


                                                    }



                                                    function lumpsomePropertyChange() {
                                                        var checkedValue = $('.messageCheckbox:checked').val();
                                                        console.log("checkedValue " + checkedValue);
                                                        $("#AmountLumpSum").prop('', true);
                                                        $("#fs").prop('', false);
                                                        $("#totalFreight").prop('', false);
                                                        $("#basicFreight").prop('', false);

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
                                                            $("#AmountLumpSum").prop('', false);
                                                            $('#fs').val('');
                                                            $('#totalFreight').val('');
                                                            $('#basicFreight').val('');
                                                            $("#fs").prop('', true);
                                                            $("#totalFreight").prop('', true);
                                                            $("#basicFreight").prop('', true);

                                                            //Recalcluate


                                                        }



                                                    }



                                                    function updateTripDataByNetworkTeam(query) {



                                                        //Validations
                                                        var ratePerKm = document.getElementById("ratePerKm").value;
                                                        var milage = document.getElementById("mileage").value;

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
                                                        console.log("Milage ::" + milage);

                                                        console.log("ratePerKm " + ratePerKm);
                                                        if (milage === "" || milage === null || milage === '') {
                                                            Toast.fire({
                                                                type: 'error',
                                                                title: 'Mileage cannot be empty!! '
                                                            });
                                                            document.getElementById("mileage").focus();
                                                            return "";
                                                        }


                                                        if (ratePerKm === "" || ratePerKm === null || ratePerKm === '') {
                                                            Toast.fire({
                                                                type: 'error',
                                                                title: 'Please chcek the Value of Rate Per KM'
                                                            });
                                                            document.getElementById("ratePerKm").focus();
                                                            return "";
                                                        }

                                                        if (routeKms === "" || routeKms === null || routeKms === '') {
                                                            Toast.fire({
                                                                type: 'error',
                                                                title: 'Billable Kms cannot be empty!!'
                                                            });
                                                            document.getElementById("routeKms").focus();
                                                            return "";
                                                        }

                                                        //currentFuelRate

                                                        if (currentFuelRate === "" || currentFuelRate === null || currentFuelRate === '') {
                                                            Toast.fire({
                                                                type: 'error',
                                                                title: 'Current Fuel Rate cannot be empty!!'
                                                            });
                                                            document.getElementById("currentFuelRate").focus();
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

                                                        console.log("checkedValue is" + checkedValue);

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

                                                            //fs

                                                            if (fs === "" || fs === null || fs === '') {
                                                                Toast.fire({
                                                                    type: 'error',
                                                                    title: 'Please check the Value of FS'
                                                                });
                                                                document.getElementById("fs").focus();
                                                                return "";
                                                            }


                                                        } else {
                                                            console.log("lumpsonme amoynt sceneroir " + AmountLumpSum);
                                                            if (AmountLumpSum === '' || AmountLumpSum === null || AmountLumpSum === '0' || AmountLumpSum === '0.0') {
                                                                Toast.fire({
                                                                    type: 'error',
                                                                    title: 'Please check the Value of Lump Sum Amount'
                                                                });
                                                                document.getElementById("AmountLumpSum").focus();
                                                                return "";

                                                            }


                                                        }
                                                        console.log("After Validation ::");

                                                        calcualteFormulae();

                                                        var fs = document.getElementById("fs").value;
                                                        console.log("fs" + fs);
                                                        var totalFreight = document.getElementById("totalFreight").value;
                                                        var basicFreight = document.getElementById("basicFreight").value;
                                                        var comments_by_User = document.getElementById("comment").value;
                                                        console.log("comments_by_User " + comments_by_User);

                                                        var standardKM = document.getElementById("standardKM").value;

                                                        var obj = {
                                                            "tripID": document.getElementById("tripID").value,
                                                            "processedBy": 'NetworkTeam',
                                                            "processedOn": dateTime,
                                                            "LumpSomeAmount": document.getElementById("AmountLumpSum").value,
                                                            "AssigenedTo": "Vendor",
                                                            "fs": fs,
                                                            "totalFreight": totalFreight,
                                                            "basicFreight": basicFreight,
                                                            "commentsby": comments_by_User,
                                                            "standardKM": standardKM,
                                                            "milage": milage,
                                                            "ratePerKm": ratePerKm,
                                                            "routeKms": routeKms,
                                                            "fsBaseRate": fsBaseRate,
                                                            "currentFuelRate": currentFuelRate,
                                                            "fsDiff": fsDiff,
                                                            "Query": query
                                                        }

                                                        //  calcualteFormulae();
                                                        console.log("Commin here before ajax call");
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

                                                        if ('No' == query) {
                                                            $('#tripValue').modal('hide');
                                                            location.reload();
                                                        }

                                                    }


                                                    function calcualteFormulae() {
                                                        var currentFuelRate = document.getElementById("currentFuelRate").value;
                                                        var fsBaseRate = document.getElementById("fsBaseRate").value;

                                                        console.log("currentFuelRate " + currentFuelRate);
                                                        console.log("fsBaseRate " + fsBaseRate);


                                                        var basicFreight = parseFloat(currentFuelRate) - parseFloat(fsBaseRate);
                                                        document.getElementById("basicFreight").value = basicFreight.toFixed(2);

                                                        var mileage = document.getElementById("mileage").value;
                                                        var routeKms = document.getElementById("routeKms").value;
                                                        console.log("mileage " + mileage);
                                                        console.log("routeKms " + routeKms);
                                                        var fs = (parseFloat(basicFreight) / parseFloat(mileage)) * parseFloat(routeKms);
                                                        document.getElementById("fs").value = fs.toFixed(2);
                                                        ;



                                                        var totalFreight = parseFloat(basicFreight) + parseFloat(fs);
                                                        document.getElementById("totalFreight").value = totalFreight.toFixed(2);

                                                    }

                                                    function refreshValues() {
                                                        console.log("*****Inside refresh values option*******");

                                                        var route = document.getElementById("route").value;//route
                                                        var vendorCode = document.getElementById("vendorCode").value;
                                                        console.log("route us ::" + route);
                                                        console.log("vendorCode ::" + vendorCode);

                                                        var obj = {

                                                            "route": route,
                                                            "vendorCode": vendorCode
                                                        }


                                                        $.ajax({
                                                            type: "POST",
                                                            data: JSON.stringify(obj),
                                                            url: "<%=GlobalUrl.refreshValues%>",
			
							dataType : "json",
							contentType : "application/json",
							async : false,
							success : function(data) {
								console.log("data.msg" + data.msg);
								console.log("data.data " + data.data);
								console.log("Actual data.data "
										+ JSON.stringify(data.data));
								if (data.msg == 'success') {
									var resData = data.data;
									console.log("" + resData.currentFuelRate);
									document.getElementById("currentFuelRate").value = resData.currentFuelRate
											.toFixed(2);
									document.getElementById("ratePerKm").value = resData.rate
											.toFixed(2);
									document.getElementById("mileage").value = resData.stdMileagePerKm
											.toFixed(2);
									document.getElementById("standardKM").value = resData.fixedKm;
									// document.getElementById("resData.currentFuelRate").value = resData.fsDiff.toFixed(2);
									document.getElementById("fsDiff").value = resData.fsDiff;
									document.getElementById("fsBaseRate").value = resData.baseRate
											.toFixed(2);

									//actualKM

									if ("0" == document
											.getElementById("actualKM")) {
										document.getElementById("routeKms").value = resData.fixedKm;
									} else if (parseFloat(document
											.getElementById("actualKM").value) < parseFloat(document
											.getElementById("standardKM").value)) {
										document.getElementById("routeKms").value = document
												.getElementById("standardKM").value;
									} else {
										document.getElementById("routeKms").value = document
												.getElementById("actualKM").value;
									}

									calcualteFormulae();
									updateTripDataByNetworkTeam('Yes');

								}
							}

						});

			}
		</script>
</body>

</html>
