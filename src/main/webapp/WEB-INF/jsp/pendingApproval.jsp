<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|PendingApprovalTrips</title>

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
		<jsp:include page="navbar.jsp?pagename=Pending For Approvel Trips" />
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="sidebar_Vendor.jsp?pagename=pendingApproval" />

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
							<div class="card card-primary ">
								<div class="card-header" style="padding: 4px 0px 4px 4px;">
									<h3 class="card-title" style="font-size: 15px;">Pending
										Approval Trips List</h3>
								</div>
								<!-- /.card-header -->
								<div class="card-body ">
									<table class="table table-bordered table-hover" id="tabledata">
										<thead>
											<tr>
												<th style="padding: 5px 5px 5px 1.5rem;">Trip Id</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Route</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Mode</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Actual KM</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Origin Hub</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Destination
													Hub</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Approve</th>
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

			<!-- Modal -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<h3 class="modal-title">Confirmation</h3>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<p>Are You Sure to Confirm This Trip....</p>
						</div>
						<div class="modal-footer">

							<button type="button" onclick="updateTripData()"
								id="updateBtnBtn" name="updateBtnBtn" class="btn btn-primary">Approve</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Control Sidebar -->
			<!-- <aside class="control-sidebar control-sidebar-dark">
			Control sidebar content goes here
		</aside>
		/.control-sidebar -->
		</div>
		<!-- ./wrapper -->

		<!-- model Start -->

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
												<form role="form" id="tripForm">
													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Trip ID</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="tripID" name="tripID"
																	autocomplete="off" disabled>
																	<input
																	type="hidden" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="id" name="id"
																	autocomplete="off" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Route</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="route" name="route"
																	autocomplete="off" disabled>
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
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Mode</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="mode" name="mode"
																	autocomplete="off" disabled>
															</div>
														</div>

													</div>
													<div class="row">
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Vehicle
																	Number</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="vehicleNumber" name="vehicleNumber"
																	autocomplete="off" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
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
																	Payload Capacity</label> <input type="text"
																	class="form-control" style="height: 30px;"
																	placeholder="Enter" id="standardPayloadCapacity"
																	name="standardPayloadCapacity" autocomplete="off"
																	disabled>
															</div>
														</div>
													</div>

													<div class="row">
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
														<div class="col-sm-3">
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
																	name="standardKM" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Mileage</label> <input
																	type="text" class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="mileage" name="mileage" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Rate per KM</label> <input
																	type="text" class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="ratePerKm" name="ratePerKm"
																	disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Bilable KM</label> <input
																	type="text" class="form-control" style="height: 30px;"
																	placeholder="Enter" id="routeKms" name="routeKms"
																	disabled>
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
																	autocomplete="off" id="fsBaseRate" name="fsBaseRate"
																	disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Current Fuel
																	Rate</label> <input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="currentFuelRate" name="currentFuelRate" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">FS Diff</label> <input
																	type="text" class="form-control numberWithDecimalcheck"
																	style="height: 30px;" placeholder="Enter"
																	autocomplete="off" id="fsDiff" name="fsDiff" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Basic Freight</label>
																<input type="text" class="form-control"
																	style="height: 30px;" placeholder="Enter"
																	id="basicFreight" name="basicFreight" disabled>
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
																	autocomplete="off" id="fs" name="fs" disabled>
															</div>
														</div>
														<div class="col-sm-3">
															<!-- text input -->
															<div class="form-group">
																<label style="margin-bottom: 1px;">Total Freight
																	(Total Trip Cost)</label> <input type="text"
																	class="form-control" style="height: 30px;"
																	placeholder="Enter" id="totalFreight"
																	name="totalFreight" disabled>
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
													</div>
													<div class="row">

														<div class="col-sm-6">
															<textarea class="form-control" id="comment"
																name="comment" maxlength="250" required="required"
																placeholder="Remarks if any" rows="3"></textarea>
														</div>

														<div class="col-sm-6">

															<div class="form-group">
																<!-- <input type="checkbox" id="lumpsum" name="lumpsum" class="messageCheckbox" value="" onclick="lumpsomePropertyChange()">
                                                                        <label for="lumsum"> If Lump Some amount is applicable</label><br> 
                                                                        <div class="form-group">
                                                                            <label style="margin-bottom: 1px;">Amount</label>
                                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="AmountLumpSum" name="AmountLumpSum" disabled>
                                                                        </div> -->
																<div class="row" style="padding: 15px;">
																<!-- <button id="saveCoaDetails" type="button"
																		class="btn btn-success" style="margin-right: 10px;"
																		onclick="updateTripData()">Approve</button> -->
																		<button type="button" onclick="checkIt()"
																			id="updateBtnBtn" name="updateBtnBtn" class="btn btn-primary" style="margin-right: 10px;">Approve</button>
																	<button id="openCoaDetails" type="button"
																		class="btn btn-success" style="margin-right: 10px;"
																		onclick="saveQuery()">Query</button>
																	<button type="button" class="btn btn-secondary"
																		id="closeModal" data-dismiss="modal">Close</button>
																</div>
															</div>
														</div>




													</div>
												</form>
											</div>
											<!-- /.card-body -->
										</div>
										<!-- /.card -->
									</table>

									<!-- <form role="form" id="queryDetails" name="queryDetails">
                                        <textarea class="form-control" id="comment" name="comment" maxlength="250" placeholder="If any Query Regardin in This Trip Comment..." rows="3"></textarea>
                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="tripID" name="tripID" autocomplete="off" disabled>
                                    </form> -->


									<!-- </div> -->
									<%-- <div class="col-md-5">
                                    <a href="${pageContext.request.contextPath}/getDoc" target="_blank">Click Here to open doc in new window</a>
                                    <!-- <iframe id="pdfLink" style="height:100%; width:100%"> -->

                                    <!-- Comment History window -->
                                    <div class="card card-primary ">
                                        <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                            <h3 class="card-title" style="font-size: 15px;">Ad-Hoc Trips Query</h3>
                                        </div>
                                        <!-- /.card-header -->
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
                                        <!-- /.card-body -->
                                    </div>

                                    <!-- Comment History window -->


                                </div> --%>
									<div class="col-md-12">
										<div class="card card-primary ">
											<div class="card-header" style="padding: 4px 0px 4px 4px;">
												<h3 class="card-title" style="font-size: 15px;">Trips
													Query</h3>
											</div>

											<div class="card-body ">
												<form role="form" id="showQueryDetails"
													name="showQueryDetails">
													<table class="table table-bordered table-hover"
														id="tabledataQuery">
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
									<!-- <div class="row" style="padding: 15px;">
                                        <button id="openCoaDetails" type="button" class="btn btn-success" style="margin-right:10px;" onclick="saveQuery()">Query</button>
                                        <button id="saveCoaDetails" type="button" class="btn btn-success" style="margin-right:10px;" onclick="updateTripData()">Approve</button>
                                        <button type="button" class="btn btn-secondary" id="closeModal" data-dismiss="modal">Close</button>
                                    </div> -->
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
		</div>
		<!-- model Start -->
<p id="demo"></p>


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

		<script type="text/javascript">
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });

            var tabledata = $('#tabledata').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": false,
                "aaSorting": []
            });
            
            var tabledataQuery = $('#tabledataQuery').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": false,
                "aaSorting": []
            });
            
            
               /*  console.log(document.getElementById("mode").value);
                //alert(document.getElementById("mode").value);
                if (document.getElementById("mode").value === "Line Haul") {
                    document.getElementById("openingReading").disabled = 'true';
                    document.getElementById("closingReading").disabled = 'true';
                    //    document.getElementById("tdsRate").val()="";
                    //            	    document.getElementById("tdsSection").value()="";
                    $("#tdsSection").val("");
                    $("#tdsRate").val("");

                } else {
                    document.getElementById("openingReading").disabled = '';
                    document.getElementById("closingReading").disabled = '';
                } */
            

            var globalTripId = "";

            getData();

            function getData() {

                var jsArray = [];

                $('.loader').show();

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsArray),
                    url: "<%=GlobalUrl.getPendingApprovelTripsDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        $('.loader').hide();
                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();

                            for (var i = 0; i < result.length; i++) {
                                var approve = "<button type=\"button\" class=\"btn btn-primary btn-xs\" data-toggle=\"modal\" data-target=\"#myModal\" onclick=\"setTripStatus('" + result[i].tripID + "')\" ><i class=\"nav-icon fas fa-pencil-square-o\"> </i> </button>";
                                //var view = "<button type=\"button\" class=\" btn-xs\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >"+result[i].tripID+"</button>";
                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getTripDataFormDataByTripId('" + result[i].tripID + "')\" >" + result[i].tripID + "</a>";

                                //var	edit="<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"   data-original-title=\"Click To Approve\" style=\"width: 43px;\"  onclick=\"tripsInvoiceDisplay("+result[i].invoiceNumber+")\"><i class=\"nav-icon fas fa-pencil-square-o\"> </i> </button>"; 
                                //var viewData = "<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"viewCheckList('" + result[i].siteQualityId + "','" + result[i].checkListId + "','"+result[i].url+"')\"><i class='fa fa-eye ' ></i></button>";
                                tabledata.row.add([view, result[i].route, result[i].runType, result[i].mode, result[i].standardKM, result[i].actualKM, result[i].originHub, result[i].destHub, approve]);
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

            function updateTripData() {

                if (globalTripId == "") {
                    return;
                }

                var obj = {
                    "tripID": globalTripId,
                    "vendorTripStatus": "Approved"
                }
				
                //console.log("vendorTripStatus   ",globalTripId);
				//alert("HIII ");
                $('.loader').show();

                $.ajax({
                    type: "POST",
                    url: "<%=GlobalUrl.updateVendorTripStatusByTripId%>",
                    data: JSON.stringify(obj),
                    dataType: "json",
                    contentType: "application/json",
                    success: function(response) {
                        $('.loader').hide();
                        $("#myModal").modal('hide');
                        if (response.msg == "success") {
                            Swal.fire({
                                type: 'success',
                                title: 'Aprove Trips Successfully..'
                            })
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

            //get Trip All Details
            function getTripDataFormDataByTripId(tripId) {
                console.log("Trip Id : " + tripId);
                //	 tripId =  $("#tripID").val();		

                var json = {
                    "tripID": tripId
                }
                var queryArray=[];
//queryEntity
                console.log("trip id json :",json)
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.tripDetailByTripId%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        if (data.msg == 'success') {
                            var result = data.data;
							
                            queryArray = data.data.queryEntity;
                            /* jsondata=JSON.parse(result) */
                            ;
                            var myForm = "";
                            //var myForm1 = "";
                            //var myForm2="";
                            myForm = document.getElementById("tripForm");
                            //myForm1 = document.getElementById("showQueryDetails");
                           // myForm2 = document.getElementById("tripDetails");
                            setData(myForm, result);
                            //setData(myForm1, result);
                           // setData(myForm, result);
                            $("#tripID").val(result.tripID);
                            
                           // $('#tabledataQuery').DataTable().clear();
                            tabledataQuery.clear();
                           
                            for (var i = 0; i < queryArray.length; i++) {
                                console.log(queryArray[i].raisedOn);
                          	 /* $('#tabledataQuery').DataTable() */
                          	 tabledataQuery.row.add([ i+1, queryArray[i].raisedBy, queryArray[i].raisedOn, queryArray[i].comment ]);                         
                           console.log(queryArray[i].raisedBy);
                           }
                            
                            
                           //$('#queryArray').DataTable().draw();
                           tabledataQuery.draw();
                           $("tbody").show(); 


                        } else {
                            Toast.fire({
                                type: 'error',
                                title: 'Failed.. Try Again..'
                            })
                        }
                    },
                    error: function(jqXHR, textStatue, errorThrown) {
                        //alert("failed, please try again");
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }

                });
            }

            function saveQuery() {
				/* var tripid={
						"tripID":$("#roleId").val(),
				} */
				
				var queryByVendor = document.getElementById("comment").value;
				if (queryByVendor === "" || queryByVendor === null || queryByVendor === '') {
                    Toast.fire({
                        type: 'error',
                        title: 'If any query, Please Comment'
                    });
                    document.getElementById("comment").focus();
                    return "";
                }
				
				//console.log("Save Query obj : ",obj);
                /* var queryDetails = FormDataToJSON('tripForm');

                const finalObj = {
                    ...queryDetails
                    
                }; */
                
                var json={
                "comment": $("#comment").val(),
                "raisedAgainQuery": $("#tripID").val(),
                "raisedBy": $("#vendorName").val(),
              //  "id": $("#id").val(),
                
                }
                console.log(json);
                
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.saveTripQuery%>",
                    dataType: "json",
                    contentType: "application/json",

                    success: function(response) {
                        if (response.msg == 'success') {
                        	
                        	
                            swal.fire("Thanks", "your Query Sucessfully Submitted", "success", "OK").then(function() {
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
            
     function checkIt(){
    	 
         if (confirm("Are you sure Approve This trip!")) {
        	 var tripID = document.getElementById("tripID").value;
        	 updateTripDataByVendor(tripID);
         } else {
             return;
         }
         }       
            
function updateTripDataByVendor(tripID){
	
	//var tripID = document.getElementById("tripID").value;

	if (tripID == "") {
        return;
    }

    var obj = {
        "tripID": tripID,
        "vendorTripStatus": "Approved",
        "openingReading":$("#openingReading").val(),
        "closingReading":$("#closingReading").val(),
    }
	console.log("----------",obj);
    $('.loader').show();

    $.ajax({
        type: "POST",
        url: "<%=GlobalUrl.updateVendorTripStatusByTripId%>",
        data: JSON.stringify(obj),
        dataType: "json",
        contentType: "application/json",
        success: function(response) {
            $('.loader').hide();
            $("#tripValue").modal('hide');
            if (response.msg == "success") {
            	swal.fire("Thanks", "your Trip Sucessfully Approved", "success", "OK")
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
        </script>
</body>

</html>
