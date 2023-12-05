<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>




<!DOCTYPE html>
<html lang="en">

<head>


<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Supplier Registration</title>


<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/smartwizard@4.3.1/dist/css/smart_wizard_theme_circles.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/smartwizard@4.3.1/dist/css/smart_wizard_theme_arrows.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="plugins/fontawesome-free/css/fontawesome.min.css" />
<link rel="stylesheet"
	href="dist/css/perfect-scrollbar/dist/css/perfect-scrollbar.min.css" />
<link rel="stylesheet"
	href="plugins/flag-icon-css/css/flag-icon.min.css" />
<link rel="stylesheet" href="dist/css/style.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/smartwizard@4.3.1/dist/css/smart_wizard.min.css" />
<link rel="stylesheet"
	href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
<link rel="stylesheet" href="plugins/toastr/toastr.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />

<style>
.mainbody, .header, .footer {
	padding: 5px;
}

.mainbody {
	margin-top: 0;
	min-height: 150px;
	max-height: 388px;
	overflow: auto;
}

.modal-backdrop.show {
	opacity: 0;
}

.header {
	height: 10px;
	border-bottom: 1px solid #EEE;
	background-color: #ffffff;
	height: 40px;
	-webkit-border-top-left-radius: 5px;
	-webkit-border-top-right-radius: 5px;
	-moz-border-radius-topleft: 5px;
	-moz-border-radius-topright: 5px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.footer {
	height: 40px;
	background-color: whiteSmoke;
	border-top: 1px solid #DDD;
	-webkit-border-bottom-left-radius: 5px;
	-webkit-border-bottom-right-radius: 5px;
	-moz-border-radius-bottomleft: 5px;
	-moz-border-radius-bottomright: 5px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
}

.delete-icon {
	font-size: 24px; /* Increase the size of the delete icon */
	background-color: none;
	backround: blue;
	color: blue; /* Set the color to blue */
	cursor: pointer;
}

/* .modal {
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
 */
.PAN {
	text-transform: uppercase;
}

.error {
	color: Red;
	visibility: hidden;
}

/* body.loading .modal {
	overflow: hidden;
}

body.loading .modal {
	display: block;
} */

/* .visually-hidden {
	position: absolute;
	width: 1px;
	height: 1px;
	left: -10000px;
	overflow: hidden;
} */
.control, fieldset {
	margin: 6px 0;
}

label {
	display: inline-block;
	width: 160px;
	vertical-align: top;
	font-weight: 100 !important;
}

.addressLable {
	display: inline-block;
	width: 100px;
	vertical-align: top;
	font-weight: 100 !important;
}

::-webkit-input-placeholder {
	opacity: .5;
}

.required, .pdDocClass, .cancelledChequeMend {
	color: red;
}

#addDetails {
	resize: vertical;
}

.navbar .navbar-menu-wrapper {
	transition: width .8s ease!importent;
	padding: 2px 0px !important;
	width: calc(100% - 0px) !important;
}

.select2 {
	width: 100% !important;
}

.select2-container--default .select2-selection--multiple .select2-selection__clear
	{
	cursor: pointer;
	font-weight: bold;
	height: 20px;
	margin-right: 10px;
	margin-top: 5px;
	position: absolute;
	right: 0;
	padding: 1px;
	display: none;
}

.typeahead {
	width: 20%;
	top: 60px !important;
	left: 50px !important;
}

.DeleteFileBtn {
	font-size: 12px !important;
}
</style>


</head>

<body>

	<jsp:include page="loader.jsp" />
	<input type="hidden" id="contextPathURL"
		value="${pageContext.request.contextPath}">

	<div class="">
		<nav
			class="navbar navbar-default col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
			<div class="navbar-menu-wrapper d-flex align-items-center">
				<ul class="navbar-nav d-flex align-items-center flex-row"
					style="margin-left: 30px;">
					<li class="nav-item"><a class="nav-link profile-pic" href="#"><img
							class="img-fluid" src="dist/img/logo/ecomlogo.png" alt=""
							style="width: 40px;"></a></li>
				</ul>
				<h4 style="color: white;">Supplier Registration</h4>
			</div>
		</nav>
		<br> <br>
		<div class="content-wrapper" style="margin-left: 0px; width: 100%;">
			<div id="smartwizard" style="background: white; padding: 20px;">

				<div>
					<div id="step-1" class="">
						<p id="manPara" style="display: none; color: RED">Please fill
							all mandatory fields.</p>
						<div class="card" style="margin-bottom: 10px;">
							<div class="card-header" id="addressBookHead"
								style="background: #11aef6; color: #ffffff;">
								<h6 class="mb-0">Basic Details</h6>
							</div>
							<div id="basicDetailsHeadData" aria-labelledby="basicDetailsHead"
								style="border-style: solid; border-width: 1px; border-color: #11aef6;">
								<form id="stepOneForm" class="forms-sample"
									style="padding: 20px;">
									<table class="table center-aligned-table" id="fromTable"
										name="fromTable">
										<thead>
										</thead>
										<tbody>
											<tr class="">
												<td><label for="name">Introducer Name<span
														class="required adHocRequired">*</span></label></td>
												<td colspan="1"><c:if test="${vpid!=''}">
														<input type="text" value="${introducedByName}"
															class="form-control p-input" id="introducedByName"
															name="introducedByName" placeholder="Introducer Name"
															readonly="true" maxlength="50">
													</c:if> <c:if test="${vpid==''}">
														<input type="text" value="${introducedByName}"
															class="form-control p-input" id="introducedByName"
															name="introducedByName" placeholder="Introducer Name"
															maxlength="50">
													</c:if></td>

												<td><label for="emailId">Introducer Email ID<span
														class="required adHocRequired">*</span></label></td>
												<td colspan="1"><c:if test="${vpid!=''}">
														<input type="text" value="${introducedByEmailID}"
															class="form-control p-input" id="introducedByEmailID"
															readonly="true" name="introducedByEmailID" maxlength="50"
															value="${userMailId }" placeholder="abc@ecomexpress.in">
														<span id="message"></span>
													</c:if> <c:if test="${vpid==''}">
														<input type="text" value="${introducedByEmailID}"
															class="form-control p-input" id="introducedByEmailID"
															name="introducedByEmailID" maxlength="50"
															value="${userMailId }" placeholder="abc@ecomexpress.in">
														<span id="message"></span>
													</c:if></td>


												<td><label for="Supplier Type">Supplier Code</label></td>
												<td colspan="1"><input type="text" value="${uname}"
													class="form-control p-input" id="bpCode" name="bpCode"
													placeholder="Supplier Code" readonly="readonly"
													disabled="disabled"></td>


											</tr>



											<tr>
												<input type="hidden" id="roleId" />

												<td><label for="suppName">Legal Entity/Supplier
														Name<span class="required adHocRequired">*</span>
												</label></td>
												<td colspan="1"><c:if test="${vpid!=''}">
														<input type="text" value="${suppName2}"
															class="form-control p-input" id="suppName"
															name="suppName" readonly="true"
															placeholder="Supplier Name" maxlength="200">
													</c:if> <c:if test="${vpid==''}">
														<input type="text" value="${suppName2}"
															class="form-control p-input" id="suppName"
															name="suppName" placeholder="Supplier Name"
															maxlength="200">
													</c:if></td>

												<td><label for="businessClassification">Business
														Classification<span class="required adHocRequired">*</span>
												</label></td>
												<td><c:if test="${vpid!=''}">
														<input type="text" value="${businessDetails}"
															class="form-control p-input" readonly="true">
													</c:if> <c:if test="${vpid==''}">
														<select id="businessClassification"
															name="businessClassification"
															class="form-control p-input">
															<option value="">Select</option>
															<c:forEach items="${classification}" var="classi">

																<option value="${classi}">${classi}</option>
															</c:forEach>

														</select>
													</c:if></td>




												<td><label for="mesmeNumber">MESME Certificate
														Number<span class="required adHocRequired">*</span>
												</label></td>
												<td colspan="1"><input type="text"
													value="${mesmeNumber}" class="form-control p-input"
													id="mesmeNumber" maxlength="19" name="mesmeNumber"
													placeholder="MESME Certificate Number" disabled="disabled"
													readonly></td>
											</tr>





											<tr class="">


												<td><label for="aadharNumber">Aadhar Number</label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" readonly="true"
													id="aadharNumber" maxlength="12" name="aadharNumber"
													value="${aadharNumber}" placeholder="Aadhar Number"></td>

												<td><label for="adharLinkStatus">Aadhar Link
														Status</label></td>

												<td><c:if test="${vpid!=''}">
														<input type="text" value="${aadharLink}"
															class="form-control p-input" readonly="true">
													</c:if> <c:if test="${vpid==''}">
														<select colspan="1" class="form-control p-input"
															id="adharLinkStatus" name="adharLinkStatus"
															placeholder="Aadhar Link Status">
															<option value="">Select</option>
															<c:forEach items="${adharLink}" var="link">


																<option value="${link}">${link}</option>
															</c:forEach>

														</select>
													</c:if></td>

												<td><label>Section Type<span
														class="required adHocRequired">*</span></label></td>

												<td><c:if test="${vpid!=''}">
														<input type="text" value="${sectionTypeDetails}"
															class="form-control p-input" readonly="true">
													</c:if> <c:if test="${vpid==''}">
														<select class="form-control p-input" id="sectionType"
															name="sectionType">
															<option value="">Select</option>
															<c:forEach items="${sectionType}" var="type">

																<option value="${type}">${type}</option>
															</c:forEach>

														</select>
													</c:if></td>



											</tr>

											<tr class="">

												<td><label for="panNumber">Pan Number<span
														class="required adHocRequired"></span></label></td>
												<td colspan="1"><c:if test="${vpid==''}">
														<input type="text" value="${panNumber}"
															class="form-control p-input" id="panNumber"
															name="panNumber" placeholder="Pan Number" maxlength="10">
													</c:if> <c:if test="${vpid!=''}">
														<input type="text" readonly="true" value="${panNumber}"
															class="form-control p-input" id="panNumber"
															name="panNumber" placeholder="Pan Number" maxlength="10">
													</c:if></td>
												<td><label for="tanNumber">TAN Number</label></td>
												<td colspan="1"><c:if test="${vpid==''}">
														<input type="text" value="${tanNumber}"
															class="form-control p-input" id="tanNumber"
															name="tanNumber" placeholder="TAN Number" maxlength="10">
													</c:if> <c:if test="${vpid!=''}">
														<input type="text" value="${tanNumber}"
															class="form-control p-input" readonly="true"
															id="tanNumber" name="tanNumber" placeholder="TAN Number"
															maxlength="10">
													</c:if></td>

												<td><label for="eInvoice">E-Invoice Applicable<span
														class="required adHocRequired">*</span>
												</label></td>
												<td><c:if test="${vpid!=''}">
														<input type="text" value="${eVoice}"
															class="form-control p-input" readonly="true">
													</c:if> <c:if test="${vpid==''}">
														<select class="form-control p-input" id="enInvApplicable"
															name="enInvApplicable">
															<option value="">Select</option>
															<c:forEach items="${adharLink}" var="link">

																<option value="${link}">${link}</option>
															</c:forEach>

														</select>
													</c:if></td>


											</tr>
											
											<tr>
											
												<td><label>Region<span
														class="required adHocRequired">*</span></label></td>

												<td style="width: auto"><c:if test="${vpid!=''}">
														<input type="text" value="${region2}" name="region[]"
															id="region" class="form-control p-input" readonly="true">
													</c:if> <c:if test="${vpid==''}">
														<select class="js-example-basic-multiple1 select2"
															multiple="multiple">


															<c:forEach items="${region}" var="reg">


																<option value="${reg}">${reg}</option>


															</c:forEach>
														</select>
													</c:if></td>

											</tr>

										</tbody>
									</table>
								</form>
							</div>
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
											id="fromTable" name="fromTable">
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
														class="js-example-basic-multiple select2" name="states[]"
														id="states" multiple="multiple">
															<c:forEach items="${business}" var="bus">

																<option value="${bus}">${bus}</option>
															</c:forEach>
													</select></td>

													<td class="supplierTypelabel" id="selectSupplierType"
														style="visibility: hidden;"><label for="partnerType">Supplier</label></td>
													<td class="supplierTypeInput" id="selectPartnerType"
														style="visibility: hidden;" colspan="2"><select
														id="partnerType" name="partnerType"
														class="form-control p-input" disabled="disabled">
															<c:forEach items="${partner}" var="par">

																<option value="${par}">${par}</option>
															</c:forEach>

													</select></td>

												</tr>

												<tr class="">
												<tr class="">

													<td><label for="compGstn">GSTN Number<span
															class="required adHocRequired"></span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input gst" id="compGstn"
														name="compGstn" name="compGstn" placeholder="GSTN Number"
														maxlength="15"></td>

													<td><label for="addressDetails">Address
															Details<span class="required adHocRequired">*</span>
													</label></td>
													<td colspan="2"><textarea class="form-control"
															id="addDetails" name="addDetails" maxlength="250"
															placeholder="Complete Address" rows="2"></textarea></td>
												<tr class="">
													<td><label for="fnameCon">First Name<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conFname" name="conFname"
														placeholder="First Name" maxlength="50"></td>

													<td><label for="lnameCon">Last Name<span
															class="required adHocRequired"></span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conLname" name="conLname"
														placeholder="Last Name" maxlength="50"></td>

													<td><label for="phno">Phone Number<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conPhone" name="conPhone"
														placeholder="Phone Number" maxlength="10"></td>
												<tr>
												<tr class="">


													<td><label for="emailId">Email Id<span
															class="required adHocRequired">*</span>
													</label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conEmail" name="conEmail"
														placeholder="Email" maxlength="50"></td>



													<c:if test="${vpid==''}">
														<td style="width: 150px;"></td>
														<td colspan=''><button type="Button"
																class="btn btn-primary" id="addBookGridButt"
																name="addBookGridButt">Add Address</button></td>
													</c:if>
												</tr>
												</tr>

											</tbody>
										</table>
									</form>


									<div class="forms-sample">
										<div class="card-body">
											<div class="table-responsive"
												style="border-style: solid; border-width: 1px; border-color: #1991eb; overflow: scroll;">
												<table class="table center-aligned-table" id="addBookGrid"
													name="addBookGrid">
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
															<th>First Name</th>
															<th>Last Name</th>
															<th>Phone Number</th>
															<th>Email Id</th>
															<c:if test="${vpid==''}">
																<th>Remove</th>
															</c:if>
														</tr>
													</thead>


													<tbody>


													</tbody>
												</table>
											</div>
										</div>
									</div>




									<%--  <form class="forms-sample">
										<div class="card-body">
											<div class="table-responsive"
												style="border-style: solid; border-width: 1px; border-color: #1991eb;">
												<table class="table center-aligned-table" id="addBookGrid"
													name="addBookGrid">
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
															<th>First Name</th>
															<th>Last Name</th>
															<th>Phone Number</th>
															<th>Email Id</th>
															<c:if test="${vpid==''}">
																<th>Remove</th>
															</c:if>
														</tr>
													</thead>
													<tbody>
														<c:if test="${vpid!=''}">
															<c:forEach items="${contactDetails}" var="contactDetails"
																varStatus="loop">

																<c:forEach items="${addressDetails}"
																	var="addressDetails" varStatus="loop">
																	<tr>
																		<td>${addressDetails.addCountry}</td>
																		<td>${addressDetails.state}</td>
																		<td>${addressDetails.city}</td>
																		<td>${addressDetails.pinCode}</td>
																		<td>${addressDetails.vendorType}</td>
																		<td>${addressDetails.partnerType}</td>
																		<td>${addressDetails.compGstn}</td>
																		<td>${addressDetails.addDetails}</td>

																		<td>${contactDetails.conFname}</td>
																		<td>${contactDetails.conLname}</td>
																		<td>${contactDetails.conPhone}</td>
																		<td>${contactDetails.conEmail}</td>

																	</tr>

																</c:forEach>


															</c:forEach>
														</c:if>
													</tbody>
												</table>
											</div>
										</div>
									</form> 
								</div>
							</div>
						</div> --%>

									<%--  <div class="card" style="margin-bottom: 10px;"
							style="margin-bottom: 10px;">
							<div class="card-header" id="contactDir"
								style="background: #1991eb; color: #ffffff;">
								<h6 class="mb-0">Contact Details</h6>
							</div>

							<div id="contactDirData" aria-labelledby="contactDir"
								class="collapse show"
								style="border-style: solid; border-width: 1px; border-color: #1991eb;">
								<div class="card-body">
									<form id="Form-3" class="forms-sample">

										<table class="table center-aligned-table" id="fromTable"
											name="fromTable">
											<thead>
											</thead>
											<tbody>
												<tr class="">
													<td><label for="fnameCon">First Name<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><c:if test="${vpid==''}">
															<input type="text" class="form-control p-input"
																id="conFname" name="conFname" placeholder="First Name"
																maxlength="50">
														</c:if> <c:if test="${vpid!=''}">
															<input type="text" class="form-control p-input"
																readonly="true" value="${conFname}" id="conFname"
																name="conFname" placeholder="First Name" maxlength="50">
														</c:if></td>

													<td><label for="lnameCon">Last Name<span
															class="required adHocRequired"></span></label></td>
													<td colspan="2"><c:if test="${vpid==''}">
															<input type="text" class="form-control p-input"
																id="conLname" name="conLname" placeholder="Last Name"
																maxlength="50">
														</c:if> <c:if test="${vpid!=''}">
															<input type="text" class="form-control p-input"
																readonly="true" id="conLname" name="conLname"
																placeholder="Last Name" value="${conLname}"
																maxlength="50">
														</c:if></td>

													<td><label for="phno">Phone Number<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><c:if test="${vpid!=''}">
															<input type="text" class="form-control p-input"
																readonly="true" id="conPhone" name="conPhone"
																placeholder="Phone Number" value="${conPhone }"
																maxlength="10">
														</c:if> <c:if test="${vpid==''}">
															<input type="text" class="form-control p-input"
																id="conPhone" name="conPhone" placeholder="Phone Number"
																maxlength="10">
														</c:if></td>
												<tr>
												<tr class="">


													<td><label for="emailId">Email Id<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><c:if test="${vpid!=''}">
															<input type="text" readonly="true"
																class="form-control p-input" id="conEmail"
																name="conEmail" placeholder="Email" value="${conEmail}"
																maxlength="50">
														</c:if> <c:if test="${vpid==''}">
															<input type="text" class="form-control p-input"
																id="conEmail" name="conEmail" placeholder="Email"
																maxlength="50">
														</c:if></td>
													<td></td>
													<td></td>
													<td><c:if test="${vpid==''}">
															<button type="button" class="btn btn-primary"
																id="contactDetailsButt" name="contactDetailsButt">Add
																Contact Details</button>
														</c:if></td>
												<tr>
											</tbody>
										</table>
										<div class="form-group"></div>
									</form>
									<form class="forms-sample">
										<div class="card-body">
											<div class="table-responsive"
												style="border-style: solid; border-width: 1px; border-color: #1991eb;">
												<table class="table center-aligned-table"
													id="contactDetailsGrid" name="contactDetailsGrid">
													<thead>
														<tr style="background: #1991eb; color: white;">
															<th>First Name</th>
															<th>Last Name</th>
															<th>Phone Number</th>
															<th>Email Id</th>
															<c:if test="${vpid==''}">
																<th>Remove</th>
															</c:if>
														</tr>
													</thead>
													<tbody>

														<c:if test="${vpid!=''}">

															<c:forEach items="${contactDetails}" var="contactDetails"
																varStatus="loop">
																<tr>
																	<td>${contactDetails.conFname}</td>
																	<td>${contactDetails.conLname}</td>
																	<td>${contactDetails.conPhone}</td>
																	<td>${contactDetails.conEmail}</td>

																</tr>

															</c:forEach>
														</c:if>

													</tbody>
												</table>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>  --%>

								</div>
								<div id="step-3" class="">

									<div class="card" style="margin-bottom: 10px;">
										<div class="card-header" id="addressBookHead"
											style="background: #1991eb; color: #ffffff;">
											<h6 class="mb-0">Invoice Payment Terms</h6>
										</div>
										<div id="addressBookHeadData"
											aria-labelledby="addressBookHead"
											style="border-style: solid; border-width: 1px; border-color: #1991eb;">
											<div class="card-body" style="margin-bottom: 10px;">
												<form id="stepSixForm" class="forms-sample">
													<table class="table center-aligned-table" id="fromTable"
														name="fromTable">
														<thead>
														</thead>
														<tbody>
															<tr class="">
																<td><label for="invoiceCurrency">Invoice
																		Currency<span class="required adHocRequired">*</span>
																</label></td>

																<td colspan="2"><c:if test="${vpid!=''}">
																		<input type="text" value="${invoiceCurrency}"
																			class="form-control p-input" readonly="true">
																	</c:if> <c:if test="${vpid==''}">
																		<select id="invoiceCurrency" name="invoiceCurrency"
																			class="form-control p-input">
																			<c:forEach items="${currency}" var="cur">

																				<option value="${cur}">${cur}</option>
																			</c:forEach>

																		</select>
																	</c:if></td>



																<td><label for="paymentCurrency">Payment
																		Currency<span class="required adHocRequired">*</span>
																</label></td>

																<td colspan="2"><c:if test="${vpid!=''}">
																		<input type="text" value="${paymentCurrency2}"
																			class="form-control p-input" readonly="true">
																	</c:if> <c:if test="${vpid==''}">
																		<select id="paymentCurrency" name="paymentCurrency"
																			class="form-control p-input">
																			<c:forEach items="${currency}" var="cur">

																				<option value="${cur}">${cur}</option>
																			</c:forEach>

																		</select>
																	</c:if></td>




																<td><label for="creditTerms">Payment /
																		Credit Terms<span class="required adHocRequired">*</span>
																</label></td>

																<td colspan="2"><c:if test="${vpid!=''}">
																		<input name="creditTerms" id="creditTerms" type="text"
																			value="${creditTerms2}" class="form-control p-input"
																			readonly="true">
																	</c:if> <c:if test="${vpid==''}">
																		<select class="js-example-basic-multiple select2">
																			<c:forEach items="${payment}" var="pay">

																				<option value="${pay}">${pay}</option>
																			</c:forEach>
																		</select>
																	</c:if></td>



															</tr>
															<tr class="">
																<td><label for="paymentMethod">Payment
																		Method<span class="required adHocRequired">*</span>
																</label></td>

																<td colspan="2"><c:if test="${vpid!=''}">
																		<input type="text" value="${paymentMethod2}"
																			class="form-control p-input" readonly="true">
																	</c:if> <c:if test="${vpid==''}">
																		<select class="js-example-basic-multiple select2"
																			name="paymentMethod" id="creditTerms"
																			multiple="multiple">
																			<c:forEach items="${paymentMethod}" var="pay">

																				<option value="${met}">${met}</option>
																			</c:forEach>
																		</select>
																	</c:if></td>



																<td><label for="dateBasis">Terms Date Basis</label></td>

																<td colspan="2"><c:if test="${vpid!=''}">
																		<input type="text" class="form-control p-input"
																			readonly="true" id="dateBasis" name="dateBasis"
																			placeholder="Terms Date Basis" value="${dateBasis }"
																			maxlength="10">
																	</c:if> <c:if test="${vpid==''}">
																		<input type="text" class="form-control p-input"
																			id="dateBasis" name="dateBasis"
																			placeholder="Terms Date Basis" maxlength="10">
																	</c:if></td>


																<td><label for="deliveryTerms">Delivery
																		Terms</label></td>

																<td colspan="2"><c:if test="${vpid!=''}">
																		<input type="text" class="form-control p-input"
																			readonly="true" id="deliveryTerms"
																			name="deliveryTerms" placeholder="Delivery Terms"
																			value="${deliveryTerms }" maxlength="10">
																	</c:if> <c:if test="${vpid==''}">
																		<input type="text" class="form-control p-input"
																			id="deliveryTerms" name="deliveryTerms"
																			placeholder="Delivery Terms" maxlength="10">
																	</c:if></td>


															</tr>

														</tbody>
													</table>

												</form>
											</div>
										</div>
									</div>

									<div class="card" id="bankDetails"
										style="margin-bottom: 10px; display: none;">
										<div class="card-header" id="addressBookHead"
											style="background: #1991eb; color: #ffffff;">
											<h6 class="mb-0">Bank Details</h6>
										</div>
										<div id="addressBookHeadData"
											aria-labelledby="addressBookHead"
											style="border-style: solid; border-width: 1px; border-color: #1991eb;">
											<div class="card-body" style="margin-bottom: 10px;">
												<form id="Form-4" class="forms-sample">
													<table class="table center-aligned-table" id="fromTable"
														name="fromTable">
														<thead>
														</thead>
														<tbody>
															<tr class="">
																<td><label for="bankName">Bank Name<span
																		class="required adHocRequired">*</span></label></td>
																<td colspan="2"><input type="text"
																	class="typeahead form-control p-input"
																	data-provide="typeahead" id="bankName" name="bankName"
																	placeholder="Bank Name" maxlength="200"
																	style="width: 100%"></td>

																<td><label for="bankName">Beneficiary Name<span
																		class="required adHocRequired">*</span></label></td>
																<td colspan="2"><input type="text"
																	class="form-control p-input" id="beneficiaryName"
																	name="beneficiaryName" placeholder="Beneficiary Name"
																	maxlength="200"></td>

																<td><label for="ifscCode">IFSC Code<span
																		class="required adHocRequired">*</span></label></td>
																<td colspan="2"><input type="text"
																	value="${tdsRate}" class="form-control p-input"
																	id="ifscCode" name="ifscCode" placeholder="IFSC Code"
																	maxlength="11"></td>

																<td><label for="accoutNumber">Account
																		Number<span class="required adHocRequired">*</span>
																</label></td>
																<td colspan="2"><input type="text"
																	class="form-control p-input" id="accoutNumber"
																	name="accoutNumber" placeholder="Account Number"
																	maxlength="16"></td>

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
															<table class="table center-aligned-table"
																id="addBankGrid" name="addBankGrid">
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
																<tbody id="bankDetailsTable">
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
																			class="required">*</span>
																	</label></td>

																	<td colspan="2"><c:if test="${vpid!=''}">
																			<input type="text" value="${tdsApplication2}"
																				class="form-control p-input" readonly="true">
																		</c:if> <c:if test="${vpid==''}">
																			<select id="tdsApplication" name="tdsApplication"
																				class="form-control p-input ">
																				<option value="Yes">Yes</option>
																				<option value="No">No</option>
																			</select>
																		</c:if></td>



																	<td><label class="addressLable" for="tdsSection">TDS
																			Section<span class="required adHocRequired">*</span>
																	</label></td>

																	<td colspan="2"><c:if test="${vpid!=''}">
																			<input type="text" value="${tdsSection2}"
																				class="form-control p-input" readonly="true">
																		</c:if> <c:if test="${vpid==''}">
																			<select class="js-example-basic-multiple select2"
																				name="tdsSection" id="tdsSection"
																				multiple="multiple">
																				<c:forEach items="${tdsCode}" var="tds">

																					<option value="${tds}">${tds}</option>
																				</c:forEach>
																			</select>
																		</c:if></td>


																	<td><label for="tdsRate">TDS Exemption
																			Rate %<span class="required adHocRequired">*</span>
																	</label></td>

																	<td colspan="2"><c:if test="${vpid!=''}">
																			<input type="text" class="form-control p-input"
																				readonly="true" id="tdsRate" name="tdsRate"
																				placeholder="TDS  Exemption Rate"
																				value="${tdsRate2 }" maxlength="10">
																		</c:if> <c:if test="${vpid==''}">
																			<input type="text" class="form-control p-input"
																				id="tdsRate" name="tdsRate"
																				placeholder="TDS  Exemption Rate" maxlength="10">
																		</c:if></td>


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
															id="addITRGrid" name="addITRGrid">
															<tbody>
																<tr class="">

																	<td><label>Select Financial Year<span
																			class="required adHocRequired"></span>
																	</label></td>
																	<td><c:if test="${vpid!=''}">
																			<input type="text" value="${fyYear1}"
																				class="form-control p-input" readonly="true">
																		</c:if> <c:if test="${vpid==''}">
																			<select id="fyYear1" name="fyYear1"
																				class="form-control p-input">
																				<option value="">Select</option>
																				<c:forEach items="${financialYear}" var="fin">

																					<option value="${fin}">${fin}</option>
																				</c:forEach>

																			</select>
																		</c:if></td>




																	<td><label>Fill Acknowledgement Number<span
																			class="required adHocRequired"></span></label></td>

																	<td><c:if test="${vpid!=''}">
																			<input type="text" id="acknowledgementNumber1"
																				name="acknowledgementNumber1" readonly="true"
																				value="${acknowledgementNumber1}" maxlength="20"
																				class="form-control p-input ">
																		</c:if> <c:if test="${vpid==''}">
																			<input type="text" id="acknowledgementNumber1"
																				name="acknowledgementNumber1" maxlength="20"
																				class="form-control p-input ">
																		</c:if></td>


																	<c:if test="${rolename!='Commercial Team'}">
																		<c:if test="${rolename!='Verifier'}">
																			<c:if test="${rolename!='AM/DM'}">
																				<c:if test="${rolename!='Sr. Manager'}">
																					<c:if test="${rolename!='Doc Checker'}">

																						<td><input type="file" id="ITRFile1"
																							name="ITRFile1"
																							placeholder="Fill Acknowledgement Number"
																							class="form-control p-input"
																							accept=" .pdf, .docx"> <textarea
																								id="ITRFileText1" rows="5"
																								style="display: none;"></textarea> <label><span
																								style="font-weight: 500; color: #fd7e14;">File
																									size Max ${fileSize} MB</span></label></td>
																					</c:if>
																				</c:if>
																			</c:if>
																		</c:if>
																	</c:if>
																</tr>

																<tr class="">
																	<td><label>Select Financial Year<span
																			class="required adHocRequired"></span>
																	</label></td>
																	<td><c:if test="${vpid!=''}">
																			<input type="text" value="${fyYear2}"
																				class="form-control p-input" readonly="true">
																		</c:if> <c:if test="${vpid==''}">
																			<select id="fyYear2" name="fyYear2"
																				class="form-control p-input">
																				<option value="">Select</option>
																				<c:forEach items="${financialYear}" var="fin">

																					<option value="${fin}">${fin}</option>
																				</c:forEach>

																			</select>
																		</c:if></td>


																	<td><label>Fill Acknowledgement Number<span
																			class="required adHocRequired"></span></label></td>
																	<td><c:if test="${vpid!=''}">
																			<input type="text" id="acknowledgementNumber2"
																				name="acknowledgementNumber2"
																				value="${acknowledgementNumber2}" readonly='true'
																				maxlength="20" class="form-control p-input ">
																		</c:if> <c:if test="${vpid==''}">
																			<input type="text" id="acknowledgementNumber2"
																				name="acknowledgementNumber2" maxlength="20"
																				class="form-control p-input ">
																		</c:if></td>


																	<c:if test="${rolename!='Commercial Team'}">
																		<c:if test="${rolename!='Verifier'}">
																			<c:if test="${rolename!='AM/DM'}">
																				<c:if test="${rolename!='Sr. Manager'}">
																					<c:if test="${rolename!='Doc Checker'}">
																						<td><input type="file" id="ITRFile2"
																							name="ITRFile2"
																							placeholder="Fill Acknowledgement Number"
																							class="form-control p-input" accept=".pdf, .docx">
																							<textarea id="ITRFileText2" rows="5"
																								style="display: none;"></textarea> <label><span
																								style="font-weight: 500; color: #fd7e14;">File
																									size Max ${fileSize} MB</span></label></td>
																					</c:if>
																				</c:if>
																			</c:if>
																		</c:if>
																	</c:if>
																</tr>

																<tr class="">
																	<td><label>Select Financial Year<span
																			class="required adHocRequired"></span>
																	</label></td>
																	<td><c:if test="${vpid!=''}">
																			<input type="text" value="${fyYear3}"
																				class="form-control p-input" readonly="true">
																		</c:if> <c:if test="${vpid==''}">
																			<select id="fyYear3" name="fyYear3"
																				class="form-control p-input">
																				<option value="">Select</option>
																				<c:forEach items="${financialYear}" var="fin">

																					<option value="${fin}">${fin}</option>
																				</c:forEach>

																			</select>
																		</c:if></td>


																	<td><label>Fill Acknowledgement Number<span
																			class="required adHocRequired"></span></label></td>
																	<td><c:if test="${vpid!=''}">
																			<input type="text" id="acknowledgementNumber3"
																				name="acknowledgementNumber3"
																				value="${acknowledgementNumber3}" readonly="true"
																				maxlength="20" class="form-control p-input ">
																		</c:if> <c:if test="${vpid==''}">
																			<input type="text" id="acknowledgementNumber3"
																				name="acknowledgementNumber3" maxlength="20"
																				class="form-control p-input ">
																		</c:if></td>


																	<c:if test="${rolename!='Commercial Team'}">
																		<c:if test="${rolename!='Verifier'}">
																			<c:if test="${rolename!='AM/DM'}">
																				<c:if test="${rolename!='Sr. Manager'}">
																					<c:if test="${rolename!='Doc Checker'}">
																						<td><input type="file" id="ITRFile3"
																							name="ITRFile1"
																							placeholder="Fill Acknowledgement Number"
																							class="form-control p-input" accept=".pdf, .docx">
																							<textarea id="ITRFileText3" rows="5"
																								style="display: none;"></textarea> <label><span
																								style="font-weight: 500; color: #fd7e14;">File
																									size Max ${fileSize} MB</span></label></td>
																					</c:if>
																				</c:if>
																			</c:if>
																		</c:if>
																	</c:if>

																</tr>


															</tbody>

														</table>
														<div>
															<c:if test="${rolename!='Commercial Team'}">
																<c:if test="${rolename!='Doc Checker'}">
																	<h6>Upload Documents</h6>
																	<div class="btn btn-primary"
																		style="width: 131px; font-weight: 500; font-size: 14px; background: none; border: none;">
																		<input type="file" id="vendorMiscellanousDoc"
																			name="attachments[]" multiple
																			placeholder="Attachments"
																			class="form-control p-input" accept=" .pdf, .docx">

																	</div>
																</c:if>
															</c:if>

															<div>
																<span id="showUploadFilesTata"></span>
															</div>
														</div>
													</form>
												</div>
											</div>
										</div>

									</div>

								</div>
								<c:if test="${rolename!='Commercial Team'}">
									<c:if test="${rolename!='Verifier'}">
										<c:if test="${rolename!='AM/DM'}">
											<c:if test="${rolename!='Sr. Manager'}">
												<c:if test="${rolename!='Doc Checker'}">
													<div id="step-5" class="">
														<div class="card" style="margin-bottom: 10px;">
															<div class="card-header" id="addressBookHead"
																style="background: #1991eb; color: #ffffff;">
																<h6 class="mb-0">Document Upload</h6>
															</div>
															<div id="addressBookHeadData"
																aria-labelledby="addressBookHead"
																style="border-style: solid; border-width: 1px; border-color: #11aef6;">
																<div class="card-body">
																	<form class="forms-sample">

																		<div class="card-body">
																			<div class="table-responsive"
																				style="border-style: solid; border-width: 1px; border-color: #1991eb;">
																				<table class="table center-aligned-table"
																					id="addDocTypeGrid" name="addDocTypeGrid">

																					<tbody>
																						<tr>
																							<td><label>GST Certificate<span
																									class="required"></span></label></td>
																							<td><input type="file" id="GSTFile"
																								name="GSTFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="GSTFileText" rows="5"
																									style="display: none;"></textarea> <label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label> <a
																								href="document/GST Declaration.zip" download>
																									Download Template </a></td>

																							<td><label>Proprietorship
																									Declaration</label></td>
																							<td><input type="file" id="PDFile"
																								name="PDFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="PDFileText" rows="5" style="display: none;"></textarea>
																								<label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label> <a
																								href="document/ProprietorshipDeclaration.docx"
																								download>Download Template </a></td>

																						</tr>

																						<tr>
																							<td><label>PAN Card<span
																									class="required"></span></label></td>
																							<td><input type="file" id="PANFile"
																								name="PANFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="PANFileText" rows="5"
																									style="display: none;"></textarea> <label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label></td>

																							<td><label>Cancelled Cheque/
																									Passbook/ Bank Statement<span
																									class="cancelledChequeMend"
																									style="visibility: hidden;">*</span>
																							</label></td>
																							<td><input type="file" id="CCFile"
																								name="CCFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="CCFileText" rows="5" style="display: none;"></textarea>
																								<label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label></td>
																						</tr>
																						<tr>
																							<td><label>Aadhar Card</label></td>
																							<td><input type="file" id="ACFile"
																								name="ACFile" class="form-control p-input"
																								accept=".docx, 	.pdf"> <textarea
																									id="ACFileText" rows="5" style="display: none;"></textarea>
																								<label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label></td>
																							<td><label>Aadhar and PAN Card
																									linking declaration</label></td>
																							<td><input type="file" id="APLFile"
																								name="APLFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="APLFileText" rows="5"
																									style="display: none;"></textarea> <label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label><a
																								href="document/139 - Declaration from payees.docx"
																								download>Download Template </a></td>
																						</tr>
																						<tr>
																							<td><label>ITR Filling Declaration<span
																									class="required notRequreDocument"
																									style="visibility: visible;">*</span></label></td>
																							<td><input type="file" id="ITRFile"
																								name="ITRFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="ITRFileText" rows="5"
																									style="display: none;"></textarea> <label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label><a
																								href="document/206AB - Declaration form ITR Filing.docx"
																								download>Download Template </a></td>
																							<td><label>Filled Updated VRF Form</label></td>
																							<td><input type="file" id="FUVFFile"
																								name="FUVFFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="FUVFFileText" rows="5"
																									style="display: none;"></textarea> <label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label></td>
																						</tr>
																						<tr>
																							<td><label>MSME Certificate<span
																									class="required notRequreDocument"
																									style="visibility: visible;">*</span></label></td>
																							<td><input type="file" id="MSMECFile"
																								name="MSMECFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="MSMECFileText" rows="5"
																									style="display: none;"></textarea> <label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label><a
																								href="document/GST and MSME Annexure.xlsx"
																								download>Download Template </a></td>
																							<td><label>Approval Mail<span
																									class="required"></span></label></td>
																							<td><input type="file" id="AMFile"
																								name="AMFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="AMFileText" rows="5" style="display: none;"></textarea>
																								<label><span
																									style="font-weight: 500; color: #fd7e14;">File
																										size Max ${fileSize} MB</span></label></td>
																						</tr>

																						<tr>
																							<td><label>Name mismatch affidavit
																									or declaration would be required if name
																									mentioned in all document is not same including
																									spelling error<span class="pdDocClass"
																									style="visibility: hidden;">*</span>
																							</label></td>
																							<td><input type="file" id="NMISFile"
																								name="NMISFile" class="form-control p-input"
																								accept=".docx, .pdf"> <textarea
																									id="NMISFileText" rows="5"
																									style="display: none;"></textarea> <label><span
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
												</c:if>
											</c:if>
										</c:if>
									</c:if>
								</c:if>

								<div id="step-6" class="">
									<div class="card queryFormUi"
										style="display: none; margin-bottom: 10px;">
										<div class="card-header" id="addressBookHead"
											style="background: #1991eb; color: #ffffff;">
											<h6 class="mb-0">Query</h6>
										</div>
										<div id="queryBookHeadData" aria-labelledby="queryBookHead"
											style="border-style: solid; border-width: 1px; border-color: #11aef6;">

											<form class="">
												<table class="table center-aligned-table" id="fromTable">
													<tbody>
														<tr class="container">
															<td style="width: 150px;"><label for="supplierQuery">Remarks</label>

																<input type="hidden" name="pid" id="pid" value="${pid}">
															</td>
															<td style="width: 150px;"><textarea
																	class="form-control" id="comment" name="comment"
																	rows="3" maxlength="250" placeholder="Remarks if Any"></textarea></td>
															<td style="width: 150px;"><button type="Button"
																	class="btn btn-primary" id="addSupplierQueryBtn"
																	name="addSupplierQueryBtn" onclick="saveRemarks()">Add
																	Remarks</button></td>
														</tr>
													</tbody>
												</table>
											</form>

										</div>

										<div class="card-body">
											<form id="queryForm" class="forms-sample">
												<div class="col-md-12">
													<div class="table-responsive">
														<table class="table table-bordered table-hover"
															id="tabledataQuery">
															<thead>
																<tr>
																	<th class="bg-primary" style="color: white;">S.No</th>
																	<th class="bg-primary" style="color: white;">Raised
																		on</th>
																	<th class="bg-primary" style="color: white;">Remarks</th>
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
								<input type="hidden" id="rolename" value="${rolename}" />
								<div class="card-footer" align="center">
									<c:if test="${vpid!=''}">

										<c:if test="${rolename=='Commercial Team'}">
											<c:if test="${status!='pending at vendor upon raise query'}">
												<c:if test="${status!='Pending at Verifier'}">
													<c:if
														test="${status!='Pending For Ehs Verification at AM/DM'}">
														<c:if test="${status!='Pending For Approval'}">
															<c:if test="${status!='Rejected by Verifier'}">
																<c:if
																	test="${status!='Pending at Senior Manager For Ehs Verification'}">
																	<c:if test="${status!='Rejected By AM/DM'}">
																		<c:if test="${status!='Rejected By Senior Manager'}">

																			<button type="button" id="approve"
																				class="btn btn-primary">Approve</button>
																			<button type="button" class="btn btn-info"
																				id="raise_query">Raise Query</button>

																		</c:if>
																	</c:if>
																</c:if>
															</c:if>
														</c:if>
													</c:if>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${rolename=='Verifier'}">
											<button type="button" id="approve_verifier"
												class="btn btn-primary">Approve</button>
											<button type="button" class="btn btn-info"
												id="reject_verifier">Reject</button>

										</c:if>

										<c:if test="${rolename=='AM/DM'}">
											<button type="button" id="approve_ehsVerifier"
												class="btn btn-primary">Approve</button>
											<button type="button" class="btn btn-info"
												id="reject_ehsVerifier">Reject</button>

										</c:if>


										<c:if test="${rolename=='Sr. Manager'}">
											<button type="button" id="approve_ehsVerifier_manager"
												class="btn btn-primary">Approve</button>
											<button type="button" class="btn btn-info"
												id="reject_ehsVerifier_manager">Reject</button>

										</c:if>

										<c:if test="${rolename=='Doc Checker'}">
											<button type="button" id="approve_doc"
												class="btn btn-primary">Approve</button>
											<button type="button" class="btn btn-info" id="reject_doc">Reject</button>

										</c:if>

										<button type="button" id="viewattachment"
											class="btn btn-primary">View Attachment</button>


										<%-- <c:if test="${rolename!='Commercial Team'}">
								<c:if test="${rolename!='Doc Checker'}">
									<div class="btn btn-primary"
										style="width: 131px; font-weight: 500; font-size: 14px; background: none; border: none;">
										<input type="file" id="vendorMiscellanousDoc"
											name="attachments[]" multiple placeholder="Attachments"
											class="form-control p-input" accept=" .pdf, .docx">

									</div>
								</c:if>
							</c:if> --%>




									</c:if>

									<c:if test="${vpid==''}">
										<button type="submit" id="updateBtn" class="btn btn-success">Submit</button>
										<button type="button" class="btn btn-danger" id="closePopBtn">Close</button>
									</c:if>
									<!--			<span id="raise_query_remark" style="display: none;"> <textarea
								type="text" name="remark" id="remark"></textarea>
							<button type="submit" id="submitBtn" class="btn btn-primary">Submit</button>
						</span> -->
								</div>
								<input type="hidden" id="vpid" value="${vpid}" />
							</div>
						</div>
					</div>
				</div>



				<div class="modal fade" id="userModalD" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="approve_comment"
																	class="form-control" id="approve_comment"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="approveSubmitBtnD"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="approveSubmitCloseBtnD"
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



				<div class="modal fade" id="userModalokk" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="remark_raise"
																	class="form-control" id="remark_raise"></textarea>
															</div>
														</div>

													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="submitBtn"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="closeBtn" class="btn btn-info">Close</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="modal fade" id="userModal" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col-md-12">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="reject_remark_raise"
																	class="form-control" id="reject_remark_raise"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="rejectsubmitBtn"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="rejectCloseBtn"
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

				<div class="modal fade" id="userModalDhir" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col-md-12">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="approve_remark"
																	class="form-control" id="approve_remark"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="approveSubmitBtn"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="approveSubmitCloseBtn"
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


				<div class="modal fade" id="userModalR" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="reject_comment_thirdParty"
																	class="form-control" id="reject_comment_thirdParty"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="rejectSubmitThirdPartyBtnR"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="rejectSubmitCloseThirdPartyBtnR"
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


				<div class="modal fade" id="userModalV" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="approve_comment"
																	class="form-control" id="approve_comment_ehs"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="approveSubmitBtnV"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="approveSubmitCloseBtnV"
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

				<div class="modal fade" id="userModalH" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="reject_comment_ehs"
																	class="form-control" id="reject_comment_ehs"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="rejectSubmitBtnH"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="rejectSubmitCloseBtnH"
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


				<div class="modal fade" id="userModalManager" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="approve_comment_manager"
																	class="form-control" id="approve_comment_ehs_manager"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="approveSubmitBtnManager"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="approveSubmitCloseBtnManager"
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


				<div class="modal fade" id="userModalManagerReject" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">Comment</h3>
											</div>
											<form role="form" id="updateForm" autocomplete="off">
												<div class="card-body">
													<div class="row">
														<div class="col">
															<div class="form-group">
																<label for="exampleInputserverName1"
																	style="font-weight: 600 !important; letter-spacing: 0.5px; !important">Remarks</label>
																<textarea type="text" name="reject_comment_ehs_manager"
																	class="form-control" id="reject_comment_ehs_manager"></textarea>
															</div>
														</div>



													</div>
												</div>
												<div class="card-footer" align="center">
													<button type="submit" id="rejectBtnManager"
														class="btn btn-primary">Submit</button>
													<button type="submit" id="rejectCloseBtnManager"
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


				<div class="modal fade" id="viewAttachmentPopUp" role="dialog">
					<div class="modal-dialog " style="max-width: 1300px;">
						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-body">
								<div class="container-fluid panel1">
									<div class="row">
										<div class="col">
											<div class="row innerRow">
												<div class="col-md-3">
													<div class="form-group">
														<label>Document Type</label> <select class="form-control"
															id="documentType" style="height: 35px;">

														</select>
													</div>
												</div>
												<div class="col-md-6">
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
															class="form-control" id="uploadeddate"
															style="height: 35px;" readonly>
													</div>
												</div>

											</div>
										</div>
									</div>
								</div>
								<div class="container-fluid panel2">
									<div class="row">
										<div class="col-lg-12" style="height: 400px;">
											<a id="ifrmameHref" target="_blank">Click Here to open
												doc in new window</a>
											<iframe id="pdfLink" style="height: 100%; width: 100%"></iframe>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

				<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
				<script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
				<script src="plugins/jquery/jquery.min.js"></script>
				<script src="js/jquery-ui.js"></script>
				<script src="dist/js/notify.min.js"></script>
				<script src="js/select2.min.js"></script>

				<script src="js/jquery.smartWizard.min.js"></script>
				<script src="plugins/popper/umd/popper.min.js"></script>
				<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
				<script src="js/bootstrap3-typeahead.min.js"></script>
				<script
					src="dist/css/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>
				<script src="plugins/js/off-canvas.js"></script>
				<script src="plugins/js/hoverable-collapse.js"></script>
				<script src="plugins/js/misc.js"></script>
				<script src="js/vendorRegistrastion.js"></script>
</body>

</html>
