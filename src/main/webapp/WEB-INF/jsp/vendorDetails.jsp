<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|VendorDetails</title>
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
	href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
<link rel="stylesheet"
	href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
<link rel="stylesheet" href="plugins/toastr/toastr.min.css">
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
	vertical-align: top;
	border-top: 1px solid #dee2e6;
	padding: 5px 5px 0px 1.5rem;
}

.select2 {
	width: 100% !important;
}

.PAN {
	text-transform: uppercase;
}

.error {
	color: Red;
	visibility: hidden;
}

.required {
	color: red;
}

.select2-container--default .select2-selection--multiple .select2-selection__choice
	{
	color: black;
}

th, td, tr {
	border-style: hidden;
}
</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
	<jsp:include page="loader.jsp" />
	<div class="wrapper">
		<jsp:include page="navbar.jsp?pagename=Vendor Details" />
		<jsp:include page="sidebar_Admin.jsp?pagename=Vendor Details" />
		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<div class="input-group-prepend">
							<input type="hidden" id="pageContext" value="${pageContext.request.contextPath}">
							</div>
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
							<div class="card card-primary"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="card card-primary">
								<div class="card-body">
									<table id="tabledata" class="nowrap table table-bordered table-hover">
										<thead>
											<tr>
												<th class="bg-primary">Ven. code</th>
												<th class="bg-primary">Sup.Name</th>
												<th class="bg-primary">Process ID</th>
												<th class="bg-primary">Sup.Type</th>
												<th class="bg-primary">Business Class.</th>
												<th class="bg-primary">Introducer Name</th>
												<th class="bg-primary">Introducer Email</th>
												<th class="bg-primary">Status</th>
												<th class="bg-primary">Export</th>
												<th class="bg-primary">Change Password</th>
												<th class="bg-primary">Action</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<aside class="control-sidebar control-sidebar-dark"></aside>
		<div class="container-fluid panel2" style="display: none;">
                        <div class="row">                            
                            <div class="col-lg-12" style="height: 400px;">
                            <a id="ifrmameHref"   target="_blank">Click Here to open doc in new window</a>
                                <iframe id="pdfLink" style="height:100%; width:100%"  ></iframe>
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
												<tr>
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
												</tr>
												<tr class="">
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
														id="message"></span><input type="hidden" id="commercialFlag" name="commercialFlag"  />
														<input type="hidden" id="processedBy" name="processedBy"  />
													</td>

													<td><label for="Supplier Type">Referral Email
															Id</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="referralEmailId"
														name="referralEmailId"
														placeholder="Reference Person Email ID "></td>


												</tr>



												<tr>




													<td><label for="suppName">Legal Entity / Supplier Name<span
															class="required adHocRequired">*</span>
													</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="suppName" name="suppName"
														placeholder="Supplier Name" maxlength="200"> <input
														type="hidden" id="roleId"></td>

													<td><label for="businessClassification">Business
															Classification</label></td>
													<td><select id="businessClassification"
														name="businessClassification" class="form-control p-input">
															<option value="">Select</option>
															<c:forEach items="${classification}" var="classi">

																<option value="${classi}">${classi}</option>
															</c:forEach>

													</select></td>

													<td><label for="mesmeNumber">MESME Certificate
															Number</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="mesmeNumber"
														maxlength="19" name="mesmeNumber"
														placeholder="MESME Certificate Number" disabled="disabled"></td>
												</tr>





												<tr class="">


													<td><label for="aadharNumber">Aadhar Number</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="aadharNumber"
														maxlength="12" name="aadharNumber"
														placeholder="Aadhar Number"></td>

													<td><label for="adharLinkStatus">Aadhar Link
															Status</label></td>

													<td><select class="form-control p-input"
														id="adharLinkStatus" name="adharLinkStatus">
															<option value="">Select</option>
															<c:forEach items="${adharLink}" var="link">

																<option value="${link}">${link}</option>
															</c:forEach>

													</select></td>

													<td><label>Section Type<span
															class="required adHocRequired"></span></label></td>

													<td><select class="form-control p-input"
														id="sectionType" name="sectionType">
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
														class="form-control p-input" id="panNumber"
														name="panNumber" placeholder="Pan Number" maxlength="10"></td>
													<td><label for="tanNumber">TAN Number</label></td>
													<td colspan="1"><input type="text"
														class="form-control p-input" id="tanNumber"
														name="tanNumber" placeholder="TAN Number" maxlength="10"></td>

													<td><label for="eInvoice">E-Invoice Applicable<span
															class="required adHocRequired">*</span></label></td>
													<td><select class="form-control p-input"
														id="enInvApplicable" name="enInvApplicable">
															<option value="">Select</option>
															<c:forEach items="${adharLink}" var="link">

																<option value="${link}">${link}</option>
															</c:forEach>

													</select></td>
												</tr>

												<tr>

													<td><label>Region<span
															class="required adHocRequired"></span></label></td>

													<td style="width: auto"><select
														class="js-example-basic-multiple1 select2" name="region[]"
														id="region" multiple="multiple">
															<c:forEach items="${region}" var="reg">
																<option value="${reg}">${reg}</option>
															</c:forEach>
													</select></td>
													<td><label for="Supplier Type">Supplier Code</label></td>
													<td colspan="2"><input type="hidden" id="id" name="id">
													<input type="hidden" id="createDate" name="createDate">
														<input type="text" class="form-control p-input"
														id="bpCode" name="bpCode" placeholder="Supplier Code"
														style="text-align: center; font-size: x-large;"></td>

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
																name="conFname" placeholder="First Name"  maxlength="50"></td>

															<td><label for="lnameCon">Last Name<span
																	class="required adHocRequired">*</span></label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="conLname"
																name="conLname" placeholder="Last Name"  maxlength="50"></td>

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
																name="conEmail" placeholder="Email"  maxlength="50"></td>
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
															<td colspan="2"><select id="invoiceCurrency"
																name="invoiceCurrency" class="form-control p-input">
																	<c:forEach items="${currency}" var="cur">

																		<option value="${cur}">${cur}</option>
																	</c:forEach>

															</select></td>

															<td><label for="paymentCurrency">Payment
																	Currency<span class="required adHocRequired">*</span>
															</label></td>
															<td colspan="2"><select id="paymentCurrency"
																name="paymentCurrency" class="form-control p-input">
																	<c:forEach items="${currency}" var="cur">

																		<option value="${cur}">${cur}</option>
																	</c:forEach>
															</select></td>

															<td><label for="creditTerms">Payment /
																	Credit Terms<span class="required adHocRequired">*</span>
															</label></td>
															<td colspan="2"><select id="creditTerms"
																name="creditTerms" class="form-control p-input">
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

															<td colspan="2"><select id="paymentMethod"
																name="paymentMethod" class="form-control p-input">

																	<c:forEach items="${paymentMethod}" var="met">
																		<option value="${met}">${met}</option>
																	</c:forEach>
															</select></td>

															<td><label for="dateBasis">Terms Date Basis</label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="dateBasis"
																name="dateBasis" placeholder="Terms Date Basis"></td>
															<td><label for="deliveryTerms">Delivery
																	Terms</label></td>
															<td colspan="2"><input type="text"
																class="form-control p-input" id="deliveryTerms"
																name="deliveryTerms" placeholder="Delivery Terms"></td>


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
																<td colspan="2"><select id="tdsApplication"
																	name="tdsApplication" class="form-control p-input ">
																		<option value="Yes">Yes</option>
																		<option value="No">No</option>
																</select></td>

																<td><label class="addressLable" for="tdsSection">TDS
																		Section<span class="required adHocRequired">*</span>
																</label></td>
																<td colspan="2"><select id="tdsSection"
																	name="tdsSection" class="form-control p-input">
																		<option value="">Select</option>
																		<c:forEach items="${tdsCode}" var="tds">

																			<option value="${tds}">${tds}</option>
																		</c:forEach>



																</select></td>

																<td><label for="tdsRate">TDS Exemption Rate
																		%<span class="required adHocRequired">*</span>
																</label></td>
																<td colspan="2"><input type="text"
																	class="form-control p-input" id="tdsRate"
																	name="tdsRate" placeholder="TDS  Exemption Rate"
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
																<td><select id="fyYear1" name="fyYear1"
																	class="form-control p-input ">
																		<option value="">Select</option>

																		<c:forEach items="${financialYear}" var="fin">

																			<option value="${fin}">${fin}</option>
																		</c:forEach>

																</select></td>
																<td><label>Fill Acknowledgement Number<span
																		class="required adHocRequired"></span></label></td>
																<td><input type="text" id="acknowledgementNumber1"
																	name="acknowledgementNumber1"
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
																<td><select id="fyYear2" name="fyYear2"
																	class="form-control p-input ">
																		<option value="">Select</option>

																		<c:forEach items="${financialYear}" var="fin">

																			<option value="${fin}">${fin}</option>
																		</c:forEach>

																</select></td>
																<td><label>Fill Acknowledgement Number<span
																		class="required adHocRequired"></span></label></td>
																<td><input type="text" id="acknowledgementNumber2"
																	name="acknowledgementNumber2"
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
																<td><select id="fyYear3" name="fyYear3"
																	class="form-control p-input ">
																		<option value="">Select</option>

																		<c:forEach items="${financialYear}" var="fin">

																			<option value="${fin}">${fin}</option>
																		</c:forEach>

																</select></td>
																<td><label>Fill Acknowledgement Number<span
																		class="required adHocRequired"></span></label></td>
																<td><input type="text" id="acknowledgementNumber3"
																	name="acknowledgementNumber3"
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
													<div class="table-responsive"
														style="border-style: solid; border-width: 1px; border-color: #1991eb;">
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

	<div class="modal fade" id="changePassword" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<form role="form" id="changePassword1" autocomplete="off">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Change
							Password</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="exampleInputEmail1">User Name</label> <input
								type="text" class="form-control p-input" id="userID"
								name="userID" readonly>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">New Password</label> <input
								type="hidden" id="passflag"> <input type="password"
								class="form-control p-input" id="password" name="password"
								placeholder="New Password"
								pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
								title="Must contain at least one number and one uppercase and lowercase letter"
								required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="changeVendorPassword"
							class="btn btn-primary">Change Password</button>
					</div>
				</form>
			</div>
		</div>
	</div>



	<script src="plugins/jquery/jquery.min.js"></script>
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
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
	<script src="js/select2.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<script src="plugins/datatables/jquery.dataTables.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>

	<script src="js/vendorDetails.js"></script>


</body>

</html>
