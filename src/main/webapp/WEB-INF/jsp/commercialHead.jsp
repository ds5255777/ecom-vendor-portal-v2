<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|Commercial Head</title>

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
<link rel="stylesheet" type="text/css"
	href="plugins/jquery-ui/jquery-ui.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
	rel="stylesheet">
<link rel="stylesheet" href="plugins/select2/css/select2.min.css">
<link rel="stylesheet"
	href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
<link rel="stylesheet" href="plugins/toastr/toastr.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />


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
	padding: 5px;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.select2 {
	width: 100% !important;
}

.select2-container--default .select2-selection--multiple .select2-selection__choice
	{
	margin-top: 5px;
	padding: 0;
	padding-left: 20px;
	position: relative;
	max-width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
	vertical-align: bottom;
	white-space: nowrap;
	color: black;
}

.required {
	color: red;
}

.dataTables_wrapper .dataTables_filter {
	text-align: right;
	float: right;
}

.btn-primary:hover {
	color: #127320;
	background-color: #17a2b8;
	border-color: #0062cc;
}

.card-footer {
	background-color: transparent;
	display: flex;
	align-items: center;
	gap: 5px;
}
</style>

</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
	<jsp:include page="loader.jsp" />
	<div class="wrapper">

		<jsp:include page="navbar.jsp?pagename=Commercial Head" />

		<jsp:include page="sidebar_Commercial.jsp?pagename=commercialHead" />

		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<div class="input-group-prepend"></div>
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
						<div class="col-12">
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">Active Data</h3>
								</div>
								<div class="card-body">
									<table id="tabledata" class="table table-bordered table-hover">
										<thead>
											<tr>
												<th class="bg-primary">Serial No.</th>
												<th class="bg-primary">Vendor Email Id</th>
												<th class="bg-primary">Vendor Type</th>
												<th class="bg-primary">Region</th>
												<th class="bg-primary">Payment/Credit Terms</th>
												<th class="bg-primary">EHS Verification</th>
												<th class="bg-primary">ThirdParty Verification</th>
												<th class="bg-primary">Comments</th>
												<th class="bg-primary">VendorPid</th>
												<th class="bg-primary">Verifier Name</th>
												<th class="bg-primary">Action</th>

											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>


				<div class="modal fade" id="userModal" role="dialog">
					<div class="modal-dialog " style="max-width: 1300px;">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Edit Commercial Head</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">Vendor
																	Email</label> <input type="text" readonly="true"
																	name="vendorEmailEdit" class="form-control"
																	id="vendorEmailEdit">
															</div>
														</div>
														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">Vendor Type</label>
																<input type="text" readonly="true" maxlength="70"
																	name="vendorTypeEdit" class="form-control"
																	id="vendorTypeEdit">
															</div>
														</div>

														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">Region</label> <input
																	type="text" readonly="true" maxlength="70"
																	name="regionEdit" class="form-control" id="regionEdit">
															</div>
														</div>

														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">Credit
																	Terms</label> <input type="text" readonly="true" maxlength="70"
																	name="creditTermsEdit" class="form-control"
																	id="creditTermsEdit">
															</div>
														</div>

														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">EHS
																	Verification</label> <input type="text" readonly="true"
																	maxlength="70" name="ehsVerificationEdit"
																	class="form-control" id="ehsVerificationEdit">
															</div>
														</div>

														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">ThirdParty
																	Verification</label> <input type="text" readonly="true"
																	maxlength="70" name="thirdPartyVerificationEdit"
																	class="form-control" id="thirdPartyVerificationEdit">
															</div>
														</div>

														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">Comments(Comercial
																	Team)</label> <input type="text" readonly="true" maxlength="70"
																	name="commentEdit" class="form-control"
																	id="commentEdit">
															</div>
														</div>

														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">Verifier
																	Name</label> <input type="text" readonly="true" maxlength="70"
																	name="verifierNameEdit" class="form-control"
																	id="verifierNameEdit">
															</div>
														</div>


														<div class="col-md-3">
															<div class="form-group">
																<label for="exampleInputserverName1">Comments(Comercial
																	Head) <span style="color: red">*</span>
																</label>
																<textarea type="text" maxlength="70"
																	name="commentOfCommercialHead" class="form-control"
																	id="commentOfCommercialHead"></textarea>
															</div>
														</div>


														<div>
															<input type="hidden" id="statusId" value="" />
														</div>



														<div class="card-footer" align="center">
															<button type="submit" id="approveBtn"
																class="btn btn-success">Approve</button>
															<button type="button" class="btn btn-danger"
																id="rejectBtn" data-dismiss="modal">Reject</button>
															<button type="submit" id="CloseBtnHead"
																class="btn btn-info">Close</button>
														</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>



				<script src="plugins/jquery/jquery.min.js"></script>
				<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
				<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
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

				<script src="js/commercialHead.js"></script>
</body>

</html>
