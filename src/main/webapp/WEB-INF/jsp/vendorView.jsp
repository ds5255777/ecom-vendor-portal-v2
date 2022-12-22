<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${titleName}|VendorView</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="plugins/daterangepicker/daterangepicker.css">
<link rel="stylesheet"
	href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<link rel="stylesheet" href="plugins/select2/css/select2.min.css">
<link rel="stylesheet"
	href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<link rel="stylesheet" href="dist/css/adminlte.min.css">
<link rel="stylesheet"
	href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
<link rel="stylesheet" href="plugins/sweetalert2/sweetalert2.min.css">
<link rel="stylesheet" href="plugins/toastr/toastr.min.css">
<style>
/* .split {
	height: 100%;
	width: 50%;
	position: fixed;
	z-index: 1;
	top: 0;
	overflow-x: hidden;
} */

.left {
	left: 0;
}

.right {
	right: 0;
}

div.fixed {
	position: fixed;
	bottom: 10px;
	width: 50%;
	border: 1px solid black;
}

.modalLoad {
	display: none;
	position: fixed;
	z-index: 1000;
	top: 0;
	left: 0;
	height: 100%;
	width: 100%;
	background: rgba(255, 255, 255, .8)
		url('http://i.stack.imgur.com/FhHRx.gif') 50% 50% no-repeat;
}

body.loading .modal {
	overflow: hidden;
}

body.loading .modal {
	display: block;
}

.table td, .table th {
	padding: 1px !important;
}

.form-control-sm {
	border-width: 1px;
	border-color: #e3e6ea;
}

.card-body {
	padding: 0.5rem 1.25rem 0.5rem 1.25rem;
}

.row {
	margin-bottom: 0.5rem !important;
}
label{
margin-bottom: 0px;
}

.form-group{
margin-bottom: 0px;
}

</style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm">

<div class="row">
<div class="col-md-7">
	<!-- <div class="split left wrapper"> -->
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light"
			style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
			<h5 style="color: white;">Vendor Onboarding Process</h5>
			<ul class="navbar-nav ml-auto">
				<p class="float-sm-right" style="color: white;">
					<b>Process ID : </b> <input type="text" id="pid" name="pid"
						value="${pid}" readonly
						style="background: #007BFF; color: white; border: 0px;">
				</p>
			</ul>
		</nav>

		<div class="content-wrapper" style="margin-left: 0px !important;">
			<section class="content" style="overflow: hidden;">
				<div class="container-fluid">
					<div class="card card-primary" style="margin-top: 1rem;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Basic Details</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="stepOneForm" class="forms-sample">
								<div class="row">

									<div class="col-md-3">
										<div class="form-group ">
											<label>Introducer Name<span class="text-danger"></span></label>
											<input class="form-control-sm" type="text" readonly
												name="introducedByName" id="introducedByName"
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group ">
											<label>Introducer Email ID<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text"
												name="introducedByEmailID" id="introducedByEmailID" readonly
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group ">
											<label>Referral Email Id<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" name="referralEmailId"
												id="referralEmailId" readonly style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group ">
											<label>Legal Entity / Supplier Name<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" name="suppName"
												id="suppName" readonly style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group ">
											<label>Supplier Code<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text"id="bpCode" name="bpCode" readonly style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Business Classification<span
												class="text-danger"></span></label> <input type="text"
												class="form-control-sm" name="businessClassification"
												id="businessClassification" style="width: 100%;"> <input
												type="hidden" id="vendorType" value="${vendorType}">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>MESME Certificate Number</label> <input type="text"
												class="form-control-sm" name="mesmeNumber" id="mesmeNumber"
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Aadhar Number</label> <input class="form-control-sm"
												name="aadharNumber" id="aadharNumber" type="text"
												style="width: 100%;" readonly>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Pan Number<span class="text-danger"> </span></label>

											<input class="form-control-sm" name="panNumber"
												id="panNumber" type="text" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>TAN Number<span class="text-danger"></span></label> <input
												class="form-control-sm" type="text" name="tanNumber"
												id="tanNumber" readonly style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Aadhar Link Status<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text"
												name="adharLinkStatus" id="adharLinkStatus" readonly
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Section Type<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" name="sectionType"
												id="sectionType" readonly style="width: 100%;">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Address Book</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body" style="overflow: auto;">
							<div class="col-md-12">
								<div class="table-responsive">
									<table id="addTable"
										class="display nowrap table table-bordered"
										style="width: 100%">
										<thead>
											<tr>
												<th class="bg-primary">Vendor Type</th>
												<th class="bg-primary">Vendor Category</th>
												<th class="bg-primary">Country</th>
												<th class="bg-primary">State</th>
												<th class="bg-primary">District</th>
												<th class="bg-primary">Postal Code/ ZIP Code</th>
												<th class="bg-primary">Address Details</th>
												<th class="bg-primary">GSTN Number</th>
												<th class="bg-primary">Supplier Site Code</th>
												<th class="bg-primary">GL Code</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>

					<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Contact Details</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body" style="overflow: auto;">
							<div class="col-md-12">
								<div class="table-responsive">
									<table id="contactTable"
										class="display nowrap table table-bordered"
										style="width: 100%">
										<thead>
											<tr>
												<th class="bg-primary">First Name</th>
												<th class="bg-primary">Last Name</th>
												<th class="bg-primary">Phone Number</th>
												<th class="bg-primary">Email ID</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Bank Details</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body" style="overflow: auto;">
							<div class="col-md-12">
								<div class="table-responsive">
									<table id="bankTable"
										class="display nowrap table table-bordered"
										style="width: 100%">
										<thead>
											<tr>
												<th class="bg-primary">Bank Name</th>
												<th class="bg-primary">Account Number</th>
												<th class="bg-primary">Beneficiary Name</th>
												<th class="bg-primary">IFSC Code</th>
												<th class="bg-primary">Currency</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>


					<div class="card card-primary" style="margin-top: 1rem;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Invoice Payment Terms</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="stepTwoForm" class="forms-sample">
								<div class="row">
									<div class="col-md-3">
										<div class="form-group">
											<label>Invoice Currency<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" readonly
												name="invoiceCurrency" id="invoiceCurrency"
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Payment Currency<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text"
												name="paymentCurrency" id="paymentCurrency"
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Payment / Credit Terms<span
												class="text-danger"></span></label> <input type="hidden" id="id"
												name="id" disabled> <input type="text"
												name="creditTerms" id="creditTerms" readonly
												class="form-control-sm" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Payment Method<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text"
												name="paymentMethod" id="paymentMethod" readonly
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Terms Date Basis<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" name="dateBasis"
												id="dateBasis" readonly style="width: 100%;">
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group">
											<label>Delivery Terms<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text"
												name="deliveryTerms" id="deliveryTerms" readonly
												style="width: 100%;">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>

					<div class="card card-primary" style="margin-top: 1rem;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">TDS Details</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="stepThreeForm" class="forms-sample">
								<div class="row">
									<div class="col-md-4">
										<div class="form-group">
											<label>TDS Applicable<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" readonly
												name="tdsApplication" id="tdsApplication"
												style="width: 100%;">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>TDS Section<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" name="tdsSection"
												id="tdsSection" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>TDS Exemption Rate %<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" readonly
												name="tdsRate" id="tdsRate" style="width: 100%;">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>


					<div class="card card-primary" style="margin-top: 1rem;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">ITR Details</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="stepFourForm" class="forms-sample">
								<div class="row">
									<div class="col-md-3">
										<div class="form-group">
											<label>Financial Year1<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" readonly
												name="fyYear1" id="fyYear1" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Ack. Number1<span
												class="text-danger"></span></label> <input class="form-control-sm"
												type="text" name="acknowledgementNumber1"
												id="acknowledgementNumber1" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Financial Year2<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" readonly
												name="fyYear2" id="fyYear2" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Ack. Number2<span
												class="text-danger"></span></label> <input class="form-control-sm"
												type="text" name="acknowledgementNumber2"
												id="acknowledgementNumber2" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Financial Year3<span class="text-danger"></span></label>

											<input class="form-control-sm" type="text" readonly
												name="fyYear3" id="fyYear3" style="width: 100%;">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Ack. Number3<span
												class="text-danger"></span></label> <input class="form-control-sm"
												type="text" name="acknowledgementNumber3"
												id="acknowledgementNumber3" style="width: 100%;">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>

					 <div class="card card-primary" id="queryWindow"
						style="display: block;" style="margin-top: 1rem;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Comment</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="queryForm" class="forms-sample">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="col-sm-3">Comment <span
												class="text-danger"></span></label>
											<div class="col-sm-9">
												<textarea class="form-control" id="comment" name="comment"
													rows="3" maxlength="250" placeholder="Remarks if Any"></textarea>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>

					<div class="row">
						<div class="col-md-3" style="display: no ne;" id="prosInvBtn">
							<button type="button" id="approve"
								style="margin-right: 10px; width: inherit"
								class="btn btn-success btn-lg">Approve Request</button>
						</div>

						<div class="col-md-3" style="display: none;" id="rejectInvBtn">
							<button type="button" id="rejected"
								style="margin-right: 10px; width: inherit"
								class="btn btn-danger btn-lg">Rejecte Request</button>
						</div>

						<!-- <div class="col-md-3" style="display: none;" id="raiseQueryDiv">
							<button type="button" id="raiseQuery"
								style="margin-right: 10px; width: inherit" value="raiseQuery"
								class="btn btn-warning btn-lg">Raise Query</button>
						</div> -->

						<div class="col-md-3">
							<button type="button" id="closeWindow"
								style="margin-right: 10px; width: inherit"
								class="btn btn-info btn-lg">Close</button>
						</div>
					</div>

					 <div class="card card-primary" id="queryTableView" style="margin-top: 1rem; display: none;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Remarks List</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="queryForm" class="forms-sample">
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
			</section>
		</div>

		<aside class="control-sidebar control-sidebar-dark"></aside>
	<!-- </div> -->
	</div>
	
	<div class="col-md-5">

	<!-- <div class="split right"> -->
		<div class="form-group">
			<label for="doc">Document Details</label> <select
				class="form-control" id="multipleAttachment" style="height: 35px;">

			</select>
		</div>
		<a id="ifrmameHref" target="_blank">Click Here to open doc in new
			window</a>
		<iframe id="pdfLink" title="pdfLink" style="height: 90%; width: 100%"></iframe>
	</div>
	<!-- </div> -->
	
	</div>

	<script src="plugins/jquery/jquery.min.js"></script>
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="plugins/moment/moment.min.js"></script>
	<script src="plugins/daterangepicker/daterangepicker.js"></script>
	<script
		src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<script src="dist/js/adminlte.min.js"></script>
	<script src="dist/js/demo.js"></script>
	<script src="js/commonFunctions.js"></script>
	<script src="js/common.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<script src="plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
	<script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
	<script src="plugins/jszip/jszip.min.js"></script>
	<script src="plugins/pdfmake/pdfmake.min.js"></script>
	<script src="plugins/pdfmake/vfs_fonts.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
	<script src="plugins/select2/js/select2.full.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<script src="plugins/select2/js/select2.full.min.js"></script>
	<script src="js/vendorView.js"></script>


</body>

</html>
