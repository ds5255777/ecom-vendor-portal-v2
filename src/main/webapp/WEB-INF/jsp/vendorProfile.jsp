<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${titleName}|vendorProfile</title>
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

label {
	margin-bottom: 0px;
}

.form-group {
	margin-bottom: 0px;
}
.select2 {
	width: 100% !important;
}
th, td, tr {
	border-style: hidden;
}
.required,.adHocRequired {
	color: red;
}
.select2-selection__clear{
    display: none;
}
</style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm">
	<jsp:include page="loader.jsp" />
	<div class="wrapper">
		<jsp:include page="navbar.jsp?pagename=vendorProfile" />
		<jsp:include page="sidebar_Vendor.jsp?pagename=vendorProfile" />
		<div class="content-wrapper">

			<section class="content">
				<div class="container-fluid">

					<div class="row">

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
													<div class="col-md-2">
														<div class="form-group ">
															<label>Legal Entity / Supplier Name<span
																class="text-danger"></span></label> <input
																class="form-control-sm" type="text" name="suppName"
																id="suppName" readonly style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group ">
															<label>Supplier Code<span class="text-danger"></span></label>
															<input type="hidden" id="suppNames" value="${userName}">
															<input class="form-control-sm" type="text" id="bpCode"
																name="bpCode" readonly style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Business Classification<span
																class="text-danger"></span></label> <input type="text"
																class="form-control-sm" name="businessClassification"
																id="businessClassification" style="width: 100%;">
															<input type="hidden" id="vendorType"
																value="${vendorType}">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>MESME Certificate Number</label> <input
																type="text" class="form-control-sm" name="mesmeNumber"
																id="mesmeNumber" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Aadhar Number</label> <input
																class="form-control-sm" name="aadharNumber"
																id="aadharNumber" type="text" style="width: 100%;"
																readonly>
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Pan Number<span class="text-danger">
															</span></label> <input class="form-control-sm" name="panNumber"
																id="panNumber" type="text" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>TAN Number<span class="text-danger"></span></label>
															<input class="form-control-sm" type="text"
																name="tanNumber" id="tanNumber" readonly
																style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Aadhar Link Status<span
																class="text-danger"></span></label> <input
																class="form-control-sm" type="text"
																name="adharLinkStatus" id="adharLinkStatus" readonly
																style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Section Type<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text"
																name="sectionType" id="sectionType" readonly
																style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>E-Invoice Applicable<span
																class="text-danger"></span></label> <input
																class="form-control-sm" type="text"
																name="enInvApplicable" id="enInvApplicable" readonly
																style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Region<span class="text-danger"></span></label> <input
																type="hidden" name="pid" id="pid"> <input
																class="form-control-sm" type="text" name="region"
																id="region" readonly style="width: 100%;">
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
																<!-- <th class="bg-primary">Supplier Site Code</th>
																<th class="bg-primary">GL Code</th> -->
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
									<div class="card card-primary collapsed-card">
										<div class="card-header" style="padding: 5px 5px 0px 5px;">
											<h4 class="card-title">Bank Details</h4>
											<div class="card-tools">
												<button type="button" class="btn btn-tool"
													data-card-widget="collapse" style="margin-right: 10px;">
													<i class="fas fa-plus"></i>
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


									<div class="card card-primary collapsed-card" style="margin-top: 1rem;">
										<div class="card-header" style="padding: 5px 5px 0px 5px;">
											<h4 class="card-title">Invoice Payment Terms</h4>
											<div class="card-tools">
												<button type="button" class="btn btn-tool"
													data-card-widget="collapse" style="margin-right: 10px;">
													<i class="fas fa-plus"></i>
												</button>
											</div>
										</div>
										<div class="card-body">
											<form id="stepTwoForm" class="forms-sample">
												<div class="row">
													<div class="col-md-2">
														<div class="form-group">
															<label>Invoice Currency<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text" readonly
																name="invoiceCurrency" id="invoiceCurrency"
																style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Payment Currency<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text"
																name="paymentCurrency" id="paymentCurrency"
																style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Payment / Credit Terms<span
																class="text-danger"></span></label> <input type="hidden" id="id"
																name="id" disabled> <input type="text"
																name="creditTerms" id="creditTerms" readonly
																class="form-control-sm" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Payment Method<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text"
																name="paymentMethod" id="paymentMethod" readonly
																style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Terms Date Basis<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text"
																name="dateBasis" id="dateBasis" readonly
																style="width: 100%;">
														</div>
													</div>

													<div class="col-md-2">
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

									<div class="card card-primary collapsed-card" style="margin-top: 1rem;">
										<div class="card-header" style="padding: 5px 5px 0px 5px;">
											<h4 class="card-title">TDS Details</h4>
											<div class="card-tools">
												<button type="button" class="btn btn-tool"
													data-card-widget="collapse" style="margin-right: 10px;">
													<i class="fas fa-plus"></i>
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

															<input class="form-control-sm" type="text"
																name="tdsSection" id="tdsSection" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group">
															<label>TDS Exemption Rate %<span
																class="text-danger"></span></label> <input
																class="form-control-sm" type="text" readonly
																name="tdsRate" id="tdsRate" style="width: 100%;">
														</div>
													</div>
												</div>
											</form>
										</div>
									</div>


									<div class="card card-primary collapsed-card" style="margin-top: 1rem;">
										<div class="card-header" style="padding: 5px 5px 0px 5px;">
											<h4 class="card-title">ITR Details</h4>
											<div class="card-tools">
												<button type="button" class="btn btn-tool"
													data-card-widget="collapse" style="margin-right: 10px;">
													<i class="fas fa-plus"></i>
												</button>
											</div>
										</div>
										<div class="card-body">
											<form id="stepFourForm" class="forms-sample">
												<div class="row">
													<div class="col-md-2">
														<div class="form-group">
															<label>Financial Year1<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text" readonly
																name="fyYear1" id="fyYear1" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Ack. Number1<span class="text-danger"></span></label>
															<input class="form-control-sm" type="text"
																name="acknowledgementNumber1"
																id="acknowledgementNumber1" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Financial Year2<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text" readonly
																name="fyYear2" id="fyYear2" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Ack. Number2<span class="text-danger"></span></label>
															<input class="form-control-sm" type="text"
																name="acknowledgementNumber2"
																id="acknowledgementNumber2" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Financial Year3<span class="text-danger"></span></label>

															<input class="form-control-sm" type="text" readonly
																name="fyYear3" id="fyYear3" style="width: 100%;">
														</div>
													</div>
													<div class="col-md-2">
														<div class="form-group">
															<label>Ack. Number3<span class="text-danger"></span></label>
															<input class="form-control-sm" type="text"
																name="acknowledgementNumber3"
																id="acknowledgementNumber3" style="width: 100%;">
														</div>
													</div>
												</div>
											</form>
										</div>
									</div>
									<div class="row">
										<div class="col-md-3"></div>
										<div class="col-md-3" style="display: block;"
											id="rejectInvBtn">
											<button type="button" id="updateProfile"
												style="margin-right: 10px; width: inherit"
												class="btn btn-success btn-lg">Update Profile</button>
										</div>
										<div class="col-md-3" style="display: block;"
											id="rejectInvBtn">
											<button type="button" id="viewAttachment"
												value="viewAttachment"
												style="margin-right: 10px; width: inherit"
												class="btn btn-primary btn-lg">View Attachment</button>
										</div>
										<div class="col-md-3"></div>
									</div>
								</div>
							</section>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>

	<div class="modal fade" id="viewAttachmentPopUp" role="dialog">
		<div class="modal-dialog " style="max-width: 1300px;">
			<div class="modal-content">
				<div class="modal-body">
					<div class="container-fluid panel1">
						<div class="row">
							<div class="col">
								<div class="row innerRow">


									<div class="col-md-8">
										<div class="form-group">
											<label>Document Name</label> <select class="form-control"
												id="multipleAttachment" style="height: 35px;">

											</select>

										</div>
									</div>
									<div class="col-md-3" style="display: none"
										id="uploadeddateDiv">
										<div class="form-group">
											<label>Uploaded Date</label> <input type="text"
												class="form-control" id="uploadeddate" style="height: 35px;"
												readonly>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="container-fluid panel2">
						<div class="row">
							<div class="col-lg-12" style="height: 400px;">
								<a id="ifrmameHref" target="_blank">Click Here to open doc
									in new window</a>
								<iframe id="pdfLink" style="height: 100%; width: 100%"
									title="Navigation menu"></iframe>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="userModal" role="dialog">
		<div class="modal-dialog " style="max-width: 1400px;">
			<div class="modal-content">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-primary" style="margin-bottom: 10px;">
								<div class="card-header" id="addressBookHead"
									style="background: #11aef6; color: #ffffff;">
									<h6 class="mb-0">Basic Details</h6>
								</div>
								<div id="basicDetailsHeadData"
									aria-labelledby="basicDetailsHead"
									style="border-style: solid; border-width: 1px; border-color: #11aef6;">
									<form id="stepOneForm" class="forms-sample"
										style="padding: 20px;">
										<table class="table center-aligned-table" id="fromTable">
											<thead>
											</thead>
											<tbody>
												<!-- <tr>
													<td><label>Process Id</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="pid" name="pid" readonly></td>

													<td><label>Request Status</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="venStatus"
														name="venStatus" readonly></td>
													<td><label>Supplier Type</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="vendorType"
														name="vendorType" readonly></td>
												</tr> -->
												<!-- <tr class="">
													<td><label for="name">Introducer Name<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="1"><input type="text" readonly
														class="form-control p-input" id="introducedByName"
														name="introducedByName" placeholder="Introducer Name"
														maxlength="50"></td>

													<td><label for="emailId">Introducer Email ID<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="1"><input type="text" readonly
														class="form-control p-input" id="introducedByEmailID"
														name="introducedByEmailID" maxlength="50"
														placeholder="abc@ecomexpress.in"
														onchange="removeValCssByID(this)"><span
														id="message"></span><input type="hidden"
														id="commercialFlag" name="commercialFlag" /> <input
														type="hidden" id="processedBy" name="processedBy" /></td>

													<td><label for="Supplier Type">Referral Email
															Id</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="referralEmailId"
														name="referralEmailId"
														placeholder="Reference Person Email ID "></td>


												</tr> -->



												<tr>




													<td><label for="suppName">Legal Entity /
															Supplier Name<span class="required adHocRequired">*</span>
													</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="suppNameEdit" name="suppNameEdit"
														placeholder="Supplier Name" maxlength="200"> <input
														type="hidden" id="roleId"></td>

													<td><label for="businessClassification">Business
															Classification<span class="required adHocRequired">*</span></label></td>
													<td><select id="businessClassificationEdit"
														name="businessClassificationEdit" class="form-control p-input">
															<option value="">Select</option>
															<c:forEach items="${classification}" var="classi">

																<option value="${classi}">${classi}</option>
															</c:forEach>

													</select></td>

													<td><label for="mesmeNumber">MESME Certificate
															Number<span class="required adHocRequired">*</span></label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="mesmeNumberEdit"
														maxlength="19" name="mesmeNumberEdit"
														placeholder="MESME Certificate Number" disabled="disabled"></td>
												</tr>





												<tr class="">


													<td><label for="aadharNumber">Aadhar Number</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="aadharNumberEdit"
														maxlength="12" name="aadharNumberEdit"
														placeholder="Aadhar Number"></td>

													<td><label for="adharLinkStatus">Aadhar Link
															Status</label></td>

													<td><select class="form-control p-input"
														id="adharLinkStatusEdit" name="adharLinkStatusEdit">
															<option value="">Select</option>
															<c:forEach items="${adharLink}" var="link">

																<option value="${link}">${link}</option>
															</c:forEach>

													</select></td>

													<td><label>Section Type<span
															class="required adHocRequired">*</span></label></td>

													<td><select class="form-control p-input"
														id="sectionTypeEdit" name="sectionTypeEdit">
															<option value="">Select</option>
															<c:forEach items="${sectionType}" var="type">

																<option value="${type}">${type}</option>
															</c:forEach>

													</select></td>



												</tr>

												<tr class="">

													<td><label for="panNumber">Pan Number<span
															class="required adHocRequired"></span></label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="panNumberEdit"
														name="panNumberEdit" placeholder="Pan Number" readonly maxlength="10"></td>
													<td><label for="tanNumber">TAN Number</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="tanNumberEdit"
														name="tanNumberEdit" placeholder="TAN Number" maxlength="10"></td>

													<td><label for="eInvoice">E-Invoice Applicable<span
															class="required adHocRequired">*</span></label></td>
													<td><select class="form-control p-input"
														id="enInvApplicableEdit" name="enInvApplicableEdit">
															<option value="">Select</option>
															<c:forEach items="${adharLink}" var="link">

																<option value="${link}">${link}</option>
															</c:forEach>

													</select></td>
												</tr>

												<tr>

													<td><label>Region<span
															class="required adHocRequired">*</span></label></td>

													<td style="width: auto"><input
																class="form-control-sm" type="text" name="regionEdit"
																id="regionEdit" readonly style="width: 100%;"></td>
													<td><label for="Supplier Type">Supplier Code</label></td>
													<td colspan="2"><input type="hidden" id="id" name="id">
														<input type="hidden" id="createDate" name="createDate">
														<input type="text" class="form-control p-input"
														id="bpCodeEdit" name="bpCodeEdit" placeholder="Supplier Code" readonly
														style="text-align: center; font-size: x-large; background: #11aef6; color: #ffffff;"></td>

												</tr>



											</tbody>
										</table>
									</form>
								</div>
							</div>

							<div id="step-2" class="">
								<div class="card" style="margin-bottom: 10px;">
									<div class="card-header" id="addressBookHead"
										style="background: #11aef6; color: #ffffff;">
										<h6 class="mb-0">Address Book</h6>
									</div>

									<div id="addressBookHeadData" aria-labelledby="addressBookHead"
										style="border-style: solid; border-width: 1px; border-color: #11aef6;">
										<div class="card-body" style="padding-top: 15px;">
											<form id="stepTwoForm" class="forms-sample">
												<table class="table center-aligned-table addTable"
													id="fromTable">

													<tbody>
														<tr class="">
															<td><label class="addressLable" for="country">Country<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><select id="addCountry"
																name="addCountry" class="form-control p-input">
																	<c:forEach items="${country}" var="count">

																		<option value="${count}">${count}</option>
																	</c:forEach>

															</select></td>

															<td><label class="addressLable">State<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><select name="state" id="state"
																class="form-control p-input">
																	<c:forEach items="${stateName}" var="stateNames">

																		<option value="${stateNames}">${stateNames}</option>
																	</c:forEach>
															</select></td>
															<td><label class="addressLable">District/City<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="city" name="city"
																placeholder="District" maxlength="50"></td>
														</tr>
														<tr class="">


															<td><label>Postal/ZIP Code<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="pinCode" name="pinCode"
																placeholder="Postal Code/ ZIP Code" maxlength="6"></td>

															<td><label>Supplier Type<span
																	class="required adHocRequired">*</span></label></td>

															<td colspan="2"><select
																class="js-example-basic-multiple select2"
																name="states[]" id="states" multiple="multiple">
																	<c:forEach items="${business}" var="bus">

																		<option value="${bus}">${bus}</option>
																	</c:forEach>
															</select></td>


															<td><label for="partnerType">Business
																	Partner</label></td>
															<td colspan="2"><select id="partnerType"
																name="partnerType" class="form-control p-input"
																disabled="disabled">
																	<c:forEach items="${partner}" var="par">

																		<option value="${par}">${par}</option>
																	</c:forEach>

															</select></td>
														</tr>

														<tr class="">

															<td><label for="compGstn">GSTN Number<span
																	class="required adHocRequired"></span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input gst" id="compGstn"
																name="compGstn" name="compGstn"
																placeholder="GSTN Number" maxlength="15"></td>

															<td><label for="addressDetails">Address
																	Details<span class="required adHocRequired">*</span>
															</label></td>
															<td colspan="2"><textarea class="form-control"
																	id="addDetails" name="addDetails" maxlength="250"
																	placeholder="Complete Address" rows="2"></textarea></td>
															<td style="width: 150px;"></td>
															<td colspan=''><button type="Button"
																	class="btn btn-primary" id="addBookGridButt"
																	name="addBookGridButt">Add Address</button></td>
														</tr>

													</tbody>
												</table>
											</form>
											<form class="forms-sample">
												<div class="card-body">
													<div class="table-responsive"
														style="border-style: solid; border-width: 1px; border-color: #1991eb;">
														<table class="table center-aligned-table" id="addBookGrid">
															<thead>
																<tr style="background: #1991eb; color: white;">
																	<th>Country</th>
																	<th>State</th>
																	<th>District/City</th>
																	<th>Postal/ZIP Code</th>
																	<th>Supplier Type</th>
																	<th>Supplier</th>
																	<th>GSTN Number</th>
																	<th>Address Details</th>
																	<th>Remove</th>
																</tr>
															</thead>
															<tbody id="addBookGridTbody">
															</tbody>

														</table>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
								<div class="card" style="margin-bottom: 10px;"
									style="margin-bottom: 10px;">
									<div class="card-header" id="contactDir"
										style="background: #1991eb; color: #ffffff;">
										<h6 class="mb-0">Contact Details</h6>
									</div>
									<div id="contactDirData" aria-labelledby="contactDir"
										class="collapse show"
										style="border-style: solid; border-width: 1px; border-color: #1991eb;">
										<div class="card-body">
											<form id="Form-3" class="forms-sample" autocomplete="off">
												<table class="table center-aligned-table" id="fromTable">
													<thead>
													</thead>
													<tbody>
														<tr class="">
															<td><label for="fnameCon">First Name<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="conFname"
																name="conFname" placeholder="First Name" maxlength="50"></td>

															<td><label for="lnameCon">Last Name<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="conLname"
																name="conLname" placeholder="Last Name" maxlength="50"></td>

															<td><label for="phno">Phone Number<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="conPhone"
																name="conPhone" placeholder="Phone Number"
																maxlength="10"></td>
														<tr>
														<tr class="">


															<td><label for="emailId">Email Id<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="conEmail"
																name="conEmail" placeholder="Email" maxlength="50"></td>
															<td></td>
															<td></td>
															<td>
																<button type="button" class="btn btn-primary"
																	id="contactDetailsButt" name="contactDetailsButt">Add
																	Contact Details</button>
															</td>
														<tr>
													</tbody>
												</table>
												<div class="form-group"></div>
											</form>
											<form class="forms-sample" autocomplete="off">
												<div class="card-body">
													<div class="table-responsive"
														style="border-style: solid; border-width: 1px; border-color: #1991eb;">
														<table class="table center-aligned-table"
															id="contactDetailsGrid">
															<thead>
																<tr style="background: #1991eb; color: white;">
																	<th>First Name</th>
																	<th>Last Name</th>
																	<th>Phone Number</th>
																	<th>Email Id</th>
																	<th>Remove</th>
																</tr>
															</thead>
															<tbody id="contactDetailsGridTbody">
															</tbody>
														</table>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>


							<div id="step-3" class="">

								<div class="card" style="margin-bottom: 10px;">
									<div class="card-header" id="addressBookHead"
										style="background: #1991eb; color: #ffffff;">
										<h6 class="mb-0">Invoice Payment Terms</h6>
									</div>
									<div id="addressBookHeadData" aria-labelledby="addressBookHead"
										style="border-style: solid; border-width: 1px; border-color: #1991eb;">
										<div class="card-body" style="margin-bottom: 10px;">
											<form id="stepSixForm" class="forms-sample">
												<table class="table center-aligned-table" id="fromTable">
													<thead>
													</thead>
													<tbody>
														<tr class="">
															<td><label for="invoiceCurrency">Invoice
																	Currency<span class="required adHocRequired">*</span>
															</label></td>
															<td colspan="2"><select id="invoiceCurrencyEdit"
																name="invoiceCurrencyEdit" class="form-control p-input">
																	<c:forEach items="${currency}" var="cur">

																		<option value="${cur}">${cur}</option>
																	</c:forEach>

															</select></td>

															<td><label for="paymentCurrency">Payment
																	Currency<span class="required adHocRequired">*</span>
															</label></td>
															<td colspan="2"><select id="paymentCurrencyEdit"
																name="paymentCurrencyEdit" class="form-control p-input">
																	<c:forEach items="${currency}" var="cur">

																		<option value="${cur}">${cur}</option>
																	</c:forEach>
															</select></td>

															<td><label for="creditTerms">Payment /
																	Credit Terms<span class="required adHocRequired">*</span>
															</label></td>
															<td colspan="2"><select id="creditTermsEdit"
																name="creditTermsEdit" class="form-control p-input" disabled>
																	<option value="">Select</option>
																	<c:forEach items="${payment}" var="pay">

																		<option value="${pay}">${pay}</option>
																	</c:forEach>

															</select></td>
														</tr>
														<tr class="">
															<td><label for="paymentMethod">Payment
																	Method<span class="required adHocRequired">*</span>
															</label></td>

															<td colspan="2"><select id="paymentMethodEdit"
																name="paymentMethodEdit" class="form-control p-input">

																	<c:forEach items="${paymentMethod}" var="met">
																		<option value="${met}">${met}</option>
																	</c:forEach>
															</select></td>

															<td><label for="dateBasis">Terms Date Basis</label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="dateBasisEdit"
																name="dateBasisEdit" placeholder="Terms Date Basis"></td>
															<td><label for="deliveryTerms">Delivery
																	Terms</label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="deliveryTermsEdit"
																name="deliveryTermsEdit" placeholder="Delivery Terms"></td>


														</tr>

													</tbody>
												</table>

											</form>
										</div>
									</div>
								</div>

								<div class="card" style="margin-bottom: 10px;">
									<div class="card-header" id="addressBookHead"
										style="background: #1991eb; color: #ffffff;">
										<h6 class="mb-0">Bank Details</h6>
									</div>
									<div id="addressBookHeadData" aria-labelledby="addressBookHead"
										style="border-style: solid; border-width: 1px; border-color: #1991eb;">
										<div class="card-body" style="margin-bottom: 10px;">
											<form id="Form-4" class="forms-sample" autocomplete="off">
												<table class="table center-aligned-table" id="fromTable">
													<thead>
													</thead>
													<tbody>
														<tr class="">
															<td><label for="bankName">Bank Name<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="bankName"
																name="bankName" placeholder="Bank Name" maxlength="200"></td>

															<td><label for="bankName">Beneficiary Name<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="beneficiaryName"
																name="beneficiaryName" placeholder="Beneficiary Name"
																maxlength="200"></td>

															<td><label for="ifscCode">IFSC Code<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="ifscCode"
																name="ifscCode" placeholder="IFSC Code" maxlength="11"></td>

															<td><label for="accoutNumber">Account Number<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="accoutNumber"
																name="accoutNumber" placeholder="Account Number"></td>

														</tr>

														<tr class="">

															<td><label for="Confirmed accoutNumber">Confirm
																	Account Number<span class="required adHocRequired">*</span>
															</label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="confirmedAccoutNumber"
																name="confirmedAccoutNumber"
																placeholder="Confirm  Account Number" maxlength="16"></td>

															<td><label for="accoutCurrency">Currency<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><select id="accoutCurrency"
																name="accoutCurrency" class="form-control p-input">
																	<c:forEach items="${currency}" var="cur">

																		<option value="${cur}">${cur}</option>
																	</c:forEach>
															</select></td>
															<td></td>
															<td colspan="3">
																<button type="Button" id="addBankGridButt"
																	name="addBankGridButt" class="btn btn-primary">Add
																	Account Details</button>
															</td>

															<div class="registrationFormAlert"
																id="divCheckPasswordMatch"></div>
														</tr>

													</tbody>
												</table>
												<div class="card-body">
													<div class="table-responsive"
														style="border-style: solid; border-width: 1px; border-color: #1991eb;">
														<table class="table center-aligned-table" id="addBankGrid">
															<thead>
																<tr style="background: #1991eb; color: white;">
																	<th>Bank Name</th>
																	<th>Beneficiary Name</th>
																	<th>IFSC Code</th>
																	<th>Currency</th>
																	<th>Account Number</th>
																	<th></th>
																	<th>Action</th>
																</tr>
															</thead>
															<tbody id="addBankGridTbody">
															</tbody>
														</table>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>



							<div id="step-4" class="">
								<div class="card" style="margin-bottom: 10px;">


									<div class="card" style="margin-bottom: 10px;">
										<div class="card-header" id="addressBookHead"
											style="background: #1991eb; color: #ffffff;">
											<h6 class="mb-0">TDS Details</h6>
										</div>
										<div id="addressBookHeadData"
											aria-labelledby="addressBookHead"
											style="border-style: solid; border-width: 1px; border-color: #1991eb;">
											<div class="card-body" style="margin-bottom: 10px;">
												<form id="stepSevenForm" class="forms-sample">
													<table class="table center-aligned-table" id="fromTable">
														<thead>
														</thead>
														<tbody>
															<tr class="">

																<td><label class="addressLable"
																	for="tdsApplication">TDS Applicable<span
																		class="required">*</span></label></td>
																<td colspan="2"><select id="tdsApplicationEdit"
																	name="tdsApplicationEdit" class="form-control p-input ">
																		<option value="Yes">Yes</option>
																		<option value="No">No</option>
																</select></td>

																<td><label class="addressLable" for="tdsSection">TDS
																		Section<span class="required adHocRequired">*</span>
																</label></td>
																<td colspan="2"><select id="tdsSectionEdit"
																	name="tdsSectionEdit" class="form-control p-input">
																		<option value="">Select</option>
																		<c:forEach items="${tdsCode}" var="tds">

																			<option value="${tds}">${tds}</option>
																		</c:forEach>



																</select></td>

																<td><label for="tdsRate">TDS Exemption Rate
																		%<span class="required adHocRequired">*</span>
																</label></td>
																<td colspan="2"><input type="text"
																	class="form-control p-input" id="tdsRateEdit"
																	name="tdsRateEdit" placeholder="TDS  Exemption Rate"
																	maxlength="4"></td>
															</tr>

														</tbody>
													</table>

												</form>
											</div>
										</div>
									</div>


									<div class="card" style="margin-bottom: 10px;">
										<div class="card-header" id="itrHead"
											style="background: #1991eb; color: #ffffff;">
											<h6 class="mb-0">ITR Details</h6>
										</div>
										<div id="itrHeadData" aria-labelledby="itrHead"
											style="border-style: solid; border-width: 1px; border-color: #1991eb;">
											<div class="card-body" style="margin-bottom: 10px;">
												<form id="StepEightForm" class="forms-sample">
													<table class="table center-aligned-table table-striped"
														id="addITRGrid">
														<tbody>
															<tr class="">
																<td><label>Select Financial Year<span
																		class="required adHocRequired"></span></label></td>
																<td><select id="fyYear1Edit" name="fyYear1Edit"
																	class="form-control p-input ">
																		<option value="">Select</option>

																		<c:forEach items="${financialYear}" var="fin">

																			<option value="${fin}">${fin}</option>
																		</c:forEach>

																</select></td>
																<td><label>Fill Acknowledgement Number<span
																		class="required adHocRequired"></span></label></td>
																<td><input type="text" id="acknowledgementNumber1Edit"
																	name="acknowledgementNumber1Edit"
																	class="form-control p-input "></td>
																<td><input type="file" id="ITRFile1"
																	name="ITRFile1"
																	placeholder="Fill Acknowledgement Number"
																	class="form-control p-input" accept=".docx, .pdf">
																	<textarea id="ITRFileText1" rows="5"
																		style="display: none;"></textarea> <label><span
																		style="font-weight: 500; color: #fd7e14;">File
																			size Max ${fileSize} MB</span></label></td>
															</tr>
															<tr class="">
																<td><label>Select Financial Year<span
																		class="required adHocRequired"></span></label></td>
																<td><select id="fyYear2Edit" name="fyYear2Edit"
																	class="form-control p-input ">
																		<option value="">Select</option>

																		<c:forEach items="${financialYear}" var="fin">

																			<option value="${fin}">${fin}</option>
																		</c:forEach>

																</select></td>
																<td><label>Fill Acknowledgement Number<span
																		class="required adHocRequired"></span></label></td>
																<td><input type="text" id="acknowledgementNumber2Edit"
																	name="acknowledgementNumber2Edit"
																	class="form-control p-input "></td>
																<td><input type="file" id="ITRFile2"
																	name="ITRFile2"
																	placeholder="Fill Acknowledgement Number"
																	class="form-control p-input" accept=".docx, .pdf">
																	<textarea id="ITRFileText2" rows="5"
																		style="display: none;"></textarea> <label><span
																		style="font-weight: 500; color: #fd7e14;">File
																			size Max ${fileSize} MB</span></label></td>
															</tr>
															<tr class="">
																<td><label>Select Financial Year<span
																		class="required adHocRequired"></span></label></td>
																<td><select id="fyYear3Edit" name="fyYear3Edit"
																	class="form-control p-input ">
																		<option value="">Select</option>

																		<c:forEach items="${financialYear}" var="fin">

																			<option value="${fin}">${fin}</option>
																		</c:forEach>

																</select></td>
																<td><label>Fill Acknowledgement Number<span
																		class="required adHocRequired"></span></label></td>
																<td><input type="text" id="acknowledgementNumber3Edit"
																	name="acknowledgementNumber3Edit"
																	class="form-control p-input "></td>
																<td><input type="file" id="ITRFile3"
																	name="ITRFile1"
																	placeholder="Fill Acknowledgement Number"
																	class="form-control p-input" accept=".docx, .pdf">
																	<textarea id="ITRFileText3" rows="5"
																		style="display: none;"></textarea> <label><span
																		style="font-weight: 500; color: #fd7e14;">File
																			size Max ${fileSize} MB</span></label></td>
															</tr>
														</tbody>
													</table>
												</form>
											</div>
										</div>
									</div>

								</div>

							</div>
							<div id="step-5" class="">
								<div class="card" style="margin-bottom: 10px;">
									<div class="card-header" id="addressBookHead"
										style="background: #1991eb; color: #ffffff;">
										<h6 class="mb-0">Document Upload</h6>
									</div>
									<div id="addressBookHeadData" aria-labelledby="addressBookHead"
										style="border-style: solid; border-width: 1px; border-color: #11aef6;">
										<div class="card-body">
											<form class="forms-sample">

												<div class="card-body">
													<div class="table-responsive">
														<table class="table center-aligned-table"
															id="addDocTypeGrid"
															style="border-spacing: 0px; table-layout: fixed; margin-left: auto; margin-right: auto;">

															<tbody>
																<tr>
																	<td><label>GST Certificate<span
																			class="required"></span></label></td>
																	<td><input type="file" id="GSTFile" name="GSTFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="GSTFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>

																	<td><label>Proprietorship Declaration<span
																			class="required"></span></label></td>
																	<td><input type="file" id="PDFile" name="PDFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="PDFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>

																</tr>

																<tr>
																	<td><label>PAN Card<span class="required"></span></label></td>
																	<td><input type="file" id="PANFile" name="PANFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="PANFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>

																	<td><label>Cancelled Cheque/ Passbook/
																			Bank Statement<span class="required">*</span>
																	</label></td>
																	<td><input type="file" id="CCFile" name="CCFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="CCFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																</tr>
																<tr>
																	<td><label>Aadhar Card</label></td>
																	<td><input type="file" id="ACFile" name="ACFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="ACFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																	<td><label>Aadhar and PAN Card linking
																			declaration</label></td>
																	<td><input type="file" id="APLFile" name="APLFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="APLFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																</tr>
																<tr>
																	<td><label>ITR Filling Declaration<span
																			class="required">*</span></label></td>
																	<td><input type="file" id="ITRFile" name="ITRFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="ITRFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																	<td><label>Filled Updated VRF Form</label></td>
																	<td><input type="file" id="FUVFFile"
																		name="FUVFFile" class="form-control p-input"
																		accept=".docx, .pdf"> <textarea
																			id="FUVFFileText" rows="5" style="display: none;"></textarea>
																		<label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																</tr>
																<tr>
																	<td><label>MSME Certificate<span
																			class="required">*</span></label></td>
																	<td><input type="file" id="MSMECFile"
																		name="MSMECFile" class="form-control p-input"
																		accept=".docx, .pdf"> <textarea
																			id="MSMECFileText" rows="5" style="display: none;"></textarea>
																		<label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																	<td><label>Approval Mail<span
																			class="required"></span></label></td>
																	<td><input type="file" id="AMFile" name="AMFile"
																		class="form-control p-input" accept=".docx, .pdf">
																		<textarea id="AMFileText" rows="5"
																			style="display: none;"></textarea> <label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																</tr>

																<tr>

																	<td style="word-wrap: break-word;"><label>Name
																			mismatch affidavit or declaration would be required
																			if name mentioned in all document is not same
																			including spelling error<span class="required"></span>
																	</label></td>
																	<td><input type="file" id="NMISFile"
																		name="NMISFile" class="form-control p-input"
																		accept=".docx, .pdf"> <textarea
																			id="NMISFileText" rows="5" style="display: none;"></textarea>
																		<label><span
																			style="font-weight: 500; color: #fd7e14;">File
																				size Max ${fileSize} MB</span></label></td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>

							<div class="card-footer" align="center">
								<button type="submit" id="updateBtn" class="btn btn-primary">Update</button>
								<button type="button" class="btn btn-primary" id="closePopBtn"
									data-dismiss="modal">Close</button>
							</div>


						</div>
					</div>
				</div>
			</div>
		</div>
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
	<script src="plugins/select2/js/select2.full.min.js"></script>
	<script src="js/select2.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
	<script src="plugins/select2/js/select2.full.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<script src="plugins/select2/js/select2.full.min.js"></script>
	<script src="js/vendorProfile.js"></script>

</body>
</html>