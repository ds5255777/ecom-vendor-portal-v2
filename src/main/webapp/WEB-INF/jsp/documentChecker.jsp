<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.Arrays,java.util.List"%>

<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|Dashboard</title>
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
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
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style>
tbody {
	font-size: 12.9px;
}

.table td, .table th {
	padding: 5px;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.dataTables_wrapper .dataTables_filter {
	text-align: right;
	float: right;
}

</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
	<div class="wrapper">

		<jsp:include page="navbar.jsp?pagename=Document Checker" />
		<jsp:include page="documentCheckerBar.jsp?pagename=Document Checker" />
		
		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-12">
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
						<div class="col-md-12">

							<div class="card card-primary  card-outline ">
								<div class="card-header"></div>
								<div class="card-body table-responsive p-0"
									style="height: 420px;">
									<table class="table table-head-fixed" id="tabledata">
										<thead>
											<tr>
												<th class="bg-primary">Serial No</th>
												<th class="bg-primary">Vendor Email</th>
												<th class="bg-primary">Vendor Type</th>
												<th class="bg-primary">Region</th>
												<th class="bg-primary">Payment/Credit Terms</th>
												<th class="bg-primary">Verifier Name</th>
												<th class="bg-primary">Status</th>
												<th class="bg-primary">comments</th>
												<th class="bg-primary">View</th>
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


	</div>

	<aside class="control-sidebar control-sidebar-dark"></aside>
	</div>
	
	<div class="modal fade" id="userModal" role="dialog">
		<div class="modal-dialog " style="max-width: 1300px;">
			<div class="modal-content">
				<div class="modal-body">
					<section class="content">
						<div class="container-fluid">
							<div class="row">
								<div class="col-12">
									<div class="card card-primary">
										<div class="card-header">
											<h3 class="card-title">Comments Details</h3>
										</div>
										<!-- <div class="card-body"> -->
										<table class="table table-bordered table-hover"
											id="tabledata2">
											<thead>
												<tr>
													<th class="bg-primary">User</th>
													<th class="bg-primary">Role</th>
													<th class="bg-primary">Remark</th>
													<th class="bg-primary">Date/Time</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>

										<div class="card-footer" align="center">
											<button type="submit" id="CloseBtnComment"
												class="btn btn-info">Close</button>
										</div>

									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>

	<script src="plugins/jquery/jquery.min.js"></script>
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/chart.js/Chart.min.js"></script>
	<script src="plugins/sparklines/sparkline.js"></script>
	<script src="plugins/jqvmap/jquery.vmap.min.js"></script>
	<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
	<script src="plugins/jquery-knob/jquery.knob.min.js"></script>
	<script src="plugins/moment/moment.min.js"></script>
	<script src="plugins/daterangepicker/daterangepicker.js"></script>
	<script
		src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<script
		src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<script src="dist/js/adminlte.js"></script>
	<script src="dist/js/demo.js"></script>
	<script src="plugins/datatables/jquery.dataTables.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
	<script src="dist/js/chart2.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>
	<script src="js/documentChecker.js"></script>
</body>

</html>
