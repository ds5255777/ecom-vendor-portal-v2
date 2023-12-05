<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

<link rel="stylesheet"
	href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">


<style>
input:focus {
	outline-color: red;
}

.mainbody, .header, .footer {
	padding: 5px;
}

.mainbody {
	margin-top: 0;
	min-height: 150px;
	max-height: 388px;
	overflow: auto;
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

.modal {
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

.visually-hidden {
	position: absolute;
	width: 1px;
	height: 1px;
	left: -10000px;
	overflow: hidden;
}

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

.required {
	color: red;
}

.msmeClass, .pdDocClass, .cancelledChequeMend {
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
	/* border: hidden; */
	display: none;
}

select[readonly].select2+.select2-container {
	pointer-events: none;
	touch-action: none;
}

.typeahead {
	width: 20%;
	top: 60px !important;
	left: 50px !important;
}

.modal-backdrop {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 00;
    background-color: #000;
    }
    
    .modal-backdrop.show {
    opacity: 0;
}
</style>


</head>

<body>
	<jsp:include page="loader.jsp" />


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
		<br> <br> <input type="hidden" id="vendorPrimaryKey" /> <input
			type="hidden" id="vendorPid" /> <input type="hidden" id="supId" />

		<div class="container-fluid" style="margin-left: 0px; width: 100%;">
			<div id="smartwizard" style="background: white; padding: 20px;">
				<ul>
					<li style="margin-left: 0px; margin-right: auto;"><a
						href="#step-1">Step-1<br /> <small>Basic Details</small></a></li>
					<li style="margin: auto;"><a href="#step-2">Step-2<br />
							<small>General Details</small></a></li>
					<li style="margin: auto;"><a href="#step-3">Step-3<br />
							<small>Banking Details</small></a></li>
					<li style="margin: auto; margin-left: auto;"><a href="#step-4">Step-4<br />
							<small>Tax Detail</small></a></li>
					<li style="margin: auto; margin-left: auto;"><a href="#step-5">Step-5<br />
							<small>Documents</small></a></li>
					<%--
				 	<li id="step6Id" style="margin: unset; margin-left: auto;"><a
						href="#step-6">Step-6<br /> <small>Query</small></a></li> --%>


				</ul>
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
									style="padding: 20px;" autocomplete="off">
									<table class="table center-aligned-table" id="fromTable">
										<thead>
										</thead>
										<tbody>
											<tr class="">
												<td><label for="name">Introducer Name<span
														class="required adHocRequired">*</span></label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" id="introducedByName"
													name="introducedByName" placeholder="Introducer Name"
													maxlength="50"></td>

												<td><label for="emailId">Introducer Email ID<span
														class="required adHocRequired">*</span></label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" id="introducedByEmailID"
													name="introducedByEmailID" maxlength="50"
													placeholder="abc@ecomexpress.in"><span id="message"></span>
													<input type="hidden" id="roleId" /> <input type="hidden"
													id="commercialFlag" name="commercialFlag"
													value="${commercialFlag}" /></td>

												<td><label for="Supplier Type">Referral Email
														Id</label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" id="referralEmailId"
													name="referralEmailId" value="${referralEmailId}"
													placeholder="Reference Person Email ID "></td>
											</tr>
											<tr>


												<td><label for="suppName">Legal Entity/Supplier
														Name<span class="required adHocRequired">*</span>
												</label></td>

												<td colspan="1"><input type="text"
													class="form-control p-input" id="suppName" name="suppName"
													placeholder="Supplier Name" maxlength="200"
													value="${suppName}"></td>

												<td><label for="businessClassification">Business
														Classification<span class="required adHocRequired">*</span>
												</label></td>
												<td><select id="businessClassification"
													name="businessClassification" class="form-control p-input">
														<option value="">Select</option>
														<c:forEach items="${classification}" var="classi">
															<c:if test="${classi eq businessClassification}">
																<option value="${classi}" selected>${classi}</option>
															</c:if>
															<c:if test="${classi ne businessClassification}">
																<option value="${classi}">${classi}</option>
															</c:if>
														</c:forEach>

												</select></td>

												<td><label for="mesmeNumber">MESME Certificate
														Number<span class="msmeClass" style="visibility: hidden;">*</span>
												</label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" id="mesmeNumber"
													maxlength="19" value="${mesmeNumber}" name="mesmeNumber"
													placeholder="MESME Certificate Number" disabled="disabled"></td>

											</tr>
											<input type="hidden" id="vPid" value="${vPid}" />
											<tr class="">


												<td><label for="aadharNumber">Aadhar Number</label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" id="aadharNumber"
													maxlength="12" value="${aadharNumber}" name="aadharNumber"
													placeholder="Aadhar Number"></td>

												<td><label for="adharLinkStatus">Aadhar Link
														Status</label></td>

												<td><select class="form-control p-input"
													id="adharLinkStatus" name="adharLinkStatus">
														<option value="">Select</option>
														<c:forEach items="${adharLink}" var="link">
															<c:if test="${link eq adharLinkStatus2}">
																<option value="${link}" selected>${link}</option>
															</c:if>
															<c:if test="${link ne adharLinkStatus2}">
																<option value="${link}">${link}</option>
															</c:if>


														</c:forEach>

												</select></td>

												<td><label>Section Type<span
														class="required adHocRequired">*</span></label></td>

												<td><select class="form-control p-input"
													id="sectionType" name="sectionType">
														<option value="">Select</option>
														<c:forEach items="${sectionType}" var="type">
															<c:if test="${type eq sectionType2}">
																<option value="${type}" selected>${type}</option>
															</c:if>
															<c:if test="${type ne sectionType2}">
																<option value="${type}">${type}</option>
															</c:if>

														</c:forEach>

												</select></td>



											</tr>

											<tr class="">

												<td><label for="panNumber">Pan Number<span
														class="required adHocRequired"></span></label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" id="panNumber"
													name="panNumber" placeholder="Pan Number" maxlength="10"
													value="${panNumber}"></td>

												<td><label for="tanNumber">TAN Number</label></td>
												<td colspan="1"><input type="text"
													class="form-control p-input" id="tanNumber"
													name="tanNumber" placeholder="TAN Number" maxlength="10"
													value="${tanNumber}"></td>

												<td><label for="eInvoice">E-Invoice Applicable<span
														class="required adHocRequired">*</span></label></td>
												<td><select class="form-control p-input"
													id="enInvApplicable" name="enInvApplicable">
														<option value="">Select</option>
														<c:forEach items="${adharLink}" var="link">
															<c:if test="${link eq eInvoice}">
																<option value="${link} " selected>${link}</option>
															</c:if>

															<c:if test="${link ne eInvoice}">
																<option value="${link}">${link}</option>
															</c:if>

														</c:forEach>

												</select></td>
											</tr>
											<tr class="">
												<td><label>Region</label></td>

												<td>
													<%-- 	<select class="form-control p-input"
													multiple="true" id="region" name="region">
														<option value="">Select</option>
														<c:forEach items="${region}" var="reg">
															<c:if test="${reg eq regionList}">
																<option value="${reg}" selected>${reg}</option>
															</c:if>

														</c:forEach>

												</select> --%> <input type="text"
													class="form-control p-input" id="region" name="region"
													placeholder="region " maxlength="10" disabled
													value="${regionList}">
												</td>
											</tr>

										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
					<div class="" style="display: none;">
						<input type="hidden" id="vendorEmail" value="${vendorEmail}">
						<input type="hidden" id="vendorType1" value="${vendorType1}">
						<input type="hidden" id="region1" value="${region1}"> <input
							type="hidden" id="creditTerms1" value="${creditTerms}"> <input
							type="hidden" id="processByEmailId" value="${processByEmailId}">
						<input type="hidden" id="processBy" value="${processBy}">
						<input type="hidden" id="processBy" value="${pid}">


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
									<form id="stepTwoForm" class="forms-sample" autocomplete="off">
										<table class="table center-aligned-table addTable"
											id="fromTable">

											<tbody>
												<tr class="">
													<td><label class="addressLable" for="country">Country<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><select id="addCountry"
														name="addCountry" class="form-control p-input">
															<c:forEach items="${country}" var="count">

																<c:if test="${count eq addCountry}">

																	<option value="${count}" selected>${count}</option>
																</c:if>
																<c:if test="${count ne addCountry}">

																	<option value="${count}">${count}</option>
																</c:if>
															</c:forEach>
													</select></td>


													<td><label class="addressLable">State<span
															class="required adHocRequired">*</span></label></td>

													<td colspan="2"><select name="state" id="state"
														class="form-control p-input">
															<c:forEach items="${stateName}" var="stateNames">
																<c:if test="${stateNames eq state}">
																	<option value="${stateNames}" selected>${stateNames}</option>
																</c:if>
																<c:if test="${stateNames ne state}">
																	<option value="${stateNames}">${stateNames}</option>
																</c:if>
															</c:forEach>
													</select></td>


													<td><label class="addressLable">District/City<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="city" name="city"
														placeholder="District" maxlength="50" value="${city}"></td>
												</tr>
												<tr class="">


													<td><label>Postal/ZIP Code<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="pinCode" name="pinCode"
														placeholder="Postal Code/ ZIP Code" maxlength="6"
														value="${pinCode}"></td>

													<%-- 	<td><label>Supplier Type<span
															class="required adHocRequired">*</span></label></td>

													<td colspan="2"><select
														class="js-example-basic-multiple1 select2" name="states"
														id="states">
															<c:forEach items="${vendorType2}" var="bus">

																<option value="${bus}">${bus}</option>
															</c:forEach>
													</select></td> --%>



													<td><label>Supplier Type<span
															class="required adHocRequired">*</span></label></td>

													<td colspan="2"><select
														class="js-example-basic-multiple select2" name="states"
														id="states" multiple="multiple">
															<c:forEach items="${vendorType2}" var="bus">

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
															placeholder="Complete Address" rows="3"></textarea></td>
													<td style="width: 150px;"></td>

												</tr>

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
												<tr class="">


													<td><label for="emailId">Email ID<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conEmail" name="conEmail"
														placeholder="Email ID" maxlength="50"></td>
													<td></td>
													<td></td>


													<td colspan=''><button type="Button"
															class="btn btn-primary" id="addBookGridButt"
															name="addBookGridButt">Add Address</button></td>
											</tbody>
										</table>
									</form>
									<div class="forms-sample " autocomplete="off">
										<div class="card-body">
											<div class="table-responsive"
												style="border-style: solid; border-width: 1px; border-color: #1991eb; overflow: scroll;">
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
															<th>First Name</th>
															<th>Last Name</th>
															<th>Phone Number</th>
															<th>Email Id</th>
															<th>Remove</th>
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
						</div>
						<%-- 	<div class="card" style="margin-bottom: 10px;"
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
														class="form-control p-input" id="conFname" name="conFname"
														placeholder="First Name" maxlength="50"
														value="${conFname}"></td>

													<td><label for="lnameCon">Last Name<span
															class="required adHocRequired"></span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conLname" name="conLname"
														placeholder="Last Name" maxlength="50" value="${conLname}"></td>

													<td><label for="phno">Phone Number<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conPhone" name="conPhone"
														placeholder="Phone Number" maxlength="10"
														value="${conPhone}"></td>
												<tr>
												<tr class="">


													<td><label for="emailId">Email ID<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="conEmail" name="conEmail"
														placeholder="Email ID" maxlength="50" value="${conEmail}"></td>
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
															<th>Email ID</th>
															<th>Remove</th>
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
						</div> --%>
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
									<form id="stepSixForm" class="forms-sample" autocomplete="off">
										<table class="table center-aligned-table" id="fromTable">
											<thead>
											</thead>
											<tbody>
												<tr class="">
													<td><label for="invoiceCurrency">Invoice
															Currency<span class="required adHocRequired">*</span>
													</label></td>

													<td colspan="2"><select name="invoiceCurrency"
														id="invoiceCurrency" class="form-control p-input">
															<c:forEach items="${currency}" var="cur">
																<c:if test="${cur eq invoiceCurrency}">
																	<option value="${cur}" selected>${cur}</option>
																</c:if>
																<c:if test="${cur ne invoiceCurrency}">
																	<option value="${cur}">${cur}</option>
																</c:if>
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


													<td><label for="creditTerms">Payment / Credit
															Terms<span class="required adHocRequired">*</span>
													</label></td>
													<td><select id="creditTerms" name="creditTerms"
														class="form-control p-input">
															<option value="">Select</option>
															<c:forEach items="${payment}" var="pay">

																<option value="${pay}">${pay}</option>
															</c:forEach>

													</select></td>
												</tr>

												<tr class="">
													<td><label for="paymentMethod">Payment Method<span
															class="required adHocRequired">*</span></label></td>

													<td><select id="paymentMethod" name="paymentMethod"
														class="form-control p-input">
															<option value="">Select</option>
															<c:forEach items="${paymentMethod}" var="met">
																<c:if test="${met eq paymentMethod2}">
																	<option value="${met}" selected>${met}</option>
																</c:if>
																<c:if test="${met ne paymentMethod2}">
																	<option value="${met}">${met}</option>
																</c:if>
															</c:forEach>

													</select></td>

													<input type="hidden" id="paymentMethod2"
														value="${paymentMethod2}" />


													<td><label for="dateBasis">Terms Date Basis</label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="dateBasis"
														name="dateBasis" placeholder="Terms Date Basis"
														value="${dateBasis}"></td>

													<td><label for="deliveryTerms">Delivery Terms</label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="deliveryTerms"
														name="deliveryTerms" placeholder="Delivery Terms"
														value="${deliveryTerms}"></td>


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
														class="typeahead form-control p-input"
														data-provide="typeahead" id="bankName" name="bankName"
														placeholder="Bank Name" maxlength="200"
														value="${bankName}" style="width: 100%"></td>


													<td><label for="bankName">Beneficiary Name<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="beneficiaryName"
														name="beneficiaryName" placeholder="Beneficiary Name"
														maxlength="200" value="${beneficiaryName}"></td>


													<td><label for="ifscCode">IFSC Code<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="ifscCode" name="ifscCode"
														placeholder="IFSC Code" maxlength="11" value="${ifscCode}"></td>


													<td><label for="accoutNumber">Account Number<span
															class="required adHocRequired">*</span></label></td>
													<td colspan="2"><input type="text"
														class="form-control p-input" id="accoutNumber"
														name="accoutNumber" placeholder="Account Number"
														maxlength="16" value="${accoutNumber}"></td>

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
								<div id="addressBookHeadData" aria-labelledby="addressBookHead"
									style="border-style: solid; border-width: 1px; border-color: #1991eb;">
									<div class="card-body" style="margin-bottom: 10px;">
										<form id="stepSevenForm" class="forms-sample"
											autocomplete="off">
											<table class="table center-aligned-table" id="fromTable">
												<thead>
												</thead>
												<tbody>
													<tr class="">

														<td><label class="addressLable" for="tdsApplication">TDS
																Applicable<span class="required adHocRequired">*</span>
														</label></td>
														<td colspan="2"><select id="tdsApplication"
															name="tdsApplication" class="form-control p-input ">
															
																<c:if test="${tdsApplication eq 'Yes' }">
																	<option value="Yes" Selected>Yes</option>
																	<option value="No">No</option>
																</c:if>
																<c:if test="${tdsApplication ne 'Yes' }">
																	<option value="Yes">Yes</option>
																	<option value="No" Selected>No</option>
																</c:if>
														</select></td>


														<td><label class="addressLable" for="tdsSection">TDS
																Section<span class="required adHocRequired" >*</span>
														</label></td>

														<td><select class="form-control p-input"
															id="tdsSection" name="tdsSection"disabled>
																<option value="">Select</option>
																<c:forEach items="${tdsCode}" var="tds">
																	<c:if test="${tds eq tdsSection}">
																		<option value="${tds}" selected>${tds}</option>
																	</c:if>
																	<c:if test="${tds ne tdsSection}">
																		<option value="${tds}">${tds}</option>
																	</c:if>

																</c:forEach>
														</select></td>


														<td><label for="tdsRate">TDS Exemption Rate %<span
																class="required adHocRequired">*</span></label></td>
														<td colspan="2"><input type="text"
															class="form-control p-input" id="tdsRate" name="tdsRate"
															placeholder="TDS  Exemption Rate" maxlength="10"
															value="${tdsRate}" disabled></td>
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
										<form id="StepEightForm" class="forms-sample"
											autocomplete="off">
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
																	<c:if test="${fin eq fyYear1}">
																		<option value="${fyYear1}" selected>${fyYear1}</option>
																	</c:if>
																	<option value="${fin}">${fin}</option>
																</c:forEach>

														</select></td>

														<td><label>Fill Acknowledgement Number<span
																class="required adHocRequired"></span></label></td>
														<td><input type="text" id="acknowledgementNumber1"
															name="acknowledgementNumber1" maxlength="20"
															value="${acknowledgementNumber1}"
															class="form-control p-input "></td>


														<td><input type="file" id="ITRFile1" name="ITRFile1"
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
																	<c:if test="${fin eq fyYear2}">
																		<option value="${fyYear2}" selected>${fyYear2}</option>
																	</c:if>
																	<option value="${fin}">${fin}</option>
																</c:forEach>

														</select></td>
														<td><label>Fill Acknowledgement Number<span
																class="required adHocRequired"></span></label></td>
														<td><input type="text" id="acknowledgementNumber2"
															name="acknowledgementNumber2" maxlength="20"
															value="${acknowledgementNumber2}"
															class="form-control p-input "></td>

														<td><input type="file" id="ITRFile2" name="ITRFile2"
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
																	<c:if test="${fin eq fyYear3}">
																		<option value="${fyYear3}" selected>${fyYear3}</option>
																	</c:if>
																	<option value="${fin}">${fin}</option>
																</c:forEach>

														</select></td>
														<td><label>Fill Acknowledgement Number<span
																class="required adHocRequired"></span></label></td>
														<td><input type="text" id="acknowledgementNumber3"
															name="acknowledgementNumber3" maxlength="20"
															class="form-control p-input "
															value="${acknowledgementNumber3}"></td>

														<td><input type="file" id="ITRFile3" name="ITRFile1"
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
									<form class="forms-sample" autocomplete="off">

										<div class="card-body">
											<div class="table-responsive"
												style="border-style: solid; border-width: 1px; border-color: #1991eb;">
												<table class="table center-aligned-table"
													id="addDocTypeGrid">

													<tbody>
														<tr>
															<td><label>GST Certificate<span
																	class="required"></span></label></td>
															<td><input type="file" id="GSTFile" name="GSTFile"
																class="form-control p-input" accept=".docx, .pdf">
																<textarea id="GSTFileText" rows="5"
																	style="display: none;"></textarea> <label><span
																	style="font-weight: 500; color: #fd7e14;">File
																		size Max ${fileSize} MB</span></label> <a
																href="document/GST Declaration.zip" download>
																	Download Template </a></td>

															<td><label>Proprietorship Declaration</label></td>
															<td><input type="file" id="PDFile" name="PDFile"
																class="form-control p-input" accept=".docx, .pdf">
																<textarea id="PDFileText" rows="5"
																	style="display: none;"></textarea> <label><span
																	style="font-weight: 500; color: #fd7e14;">File
																		size Max ${fileSize} MB</span></label> <a
																href="document/ProprietorshipDeclaration.docx" download>Download
																	Template </a></td>

														</tr>

														<tr>
															<td><label>PAN Card<span class="required"></span></label></td>
															<td><input type="file" id="PANFile" name="PANFile"
																class="form-control p-input" accept=".docx, .pdf">
																<textarea id="PANFileText" rows="5"
																	style="display: none;"></textarea> <label><span
																	style="font-weight: 500; color: #fd7e14;">File
																		size Max ${fileSize} MB</span></label></td>

															<td><label>Cancelled Cheque/ Passbook/ Bank
																	Statement<span class="cancelledChequeMend"
																	style="visibility: hidden;">*</span>
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
																		size Max ${fileSize} MB</span></label><a
																href="document/139 - Declaration from payees.docx"
																download>Download Template </a></td>
														</tr>
														<tr>
															<td><label>ITR Filling Declaration<span
																	class="required">*</span></label></td>
															<td><input type="file" id="ITRFile" name="ITRFile"
																class="form-control p-input" accept=".docx, .pdf">
																<textarea id="ITRFileText" rows="5"
																	style="display: none;"></textarea> <label><span
																	style="font-weight: 500; color: #fd7e14;">File
																		size Max ${fileSize} MB</span></label><a
																href="document/206AB - Declaration form ITR Filing.docx"
																download>Download Template </a></td>
															<td><label>Contract Document</label></td>
															<td><input type="file" id="FUVFFile" name="FUVFFile"
																class="form-control p-input" accept=".docx, .pdf">
																<textarea id="FUVFFileText" rows="5"
																	style="display: none;"></textarea> <label><span
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
																		size Max ${fileSize} MB</span></label><a
																href="document/GST and MSME Annexure.xlsx" download>Download
																	Template </a></td>

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
															<td><label>Name mismatch affidavit or
																	declaration would be required if name mentioned in all

																	document is not same including spelling error<span
																	class="pdDocClass" style="visibility: hidden;">*</span>
															</label></td>
															<td><input type="file" id="NMISFile" name="NMISFile"
																class="form-control p-input" accept=".docx, .pdf">
																<textarea id="NMISFileText" rows="5"
																	style="display: none;"></textarea> <label><span
																	style="font-weight: 500; color: #fd7e14;">File
																		size Max ${fileSize} MB</span></label></td>
														</tr>
														
														
														<tr>
															
															<td>
															
															<c:if test="${venStatus=='pending at vendor upon raise query'}">
															
															<button type="button" id="viewattachment"
															class="btn btn-primary">View Attachment</button>
															</c:if>
															</td>
															</label></td>
														</tr>

													</tbody>
												</table>
											</div>
											 <input type="hidden" id="venStatus" name="status" value="${venStatus}" />
											 
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>

					<%-- <div id="step-6" class="">
						<div class="card queryFormUiText">
							<p
								style="font-size: 40px; color: green; text-align: center; margin-top: 100px; margin-bottom: 100px;">Thanks
								for registration! Click the Finish button for complete</p>
						</div>
						<div class="card queryFormUi"
							style="display: none; margin-bottom: 10px;">
							<div class="card-header" id="addressBookHead"
								style="background: #1991eb; color: #ffffff;">
								<h6 class="mb-0">Query</h6>
							</div>
							<div id="queryBookHeadData" aria-labelledby="queryBookHead"
								style="border-style: solid; border-width: 1px; border-color: #11aef6;">

								<form class="" autocomplete="off">
									<table class="table center-aligned-table" id="fromTable">
										<tbody>
											<tr class="container">
												<td style="width: 150px;"><label for="supplierQuery">Remarks</label>

													<input type="hidden" name="pid" id="pid" value="${pid}">
												</td>
												<td style="width: 150px;"><textarea
														class="form-control" id="comment" name="comment" rows="3"
														maxlength="250" placeholder="Remarks if Any"></textarea></td>
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
								<form id="queryForm" class="forms-sample" autocomplete="off">
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
					</div> --%>

				</div>
			</div>
		</div>
	</div>
	
	
	 <div class="modal fade" id="viewAttachmentPopUp" role="dialog">
					<div class="modal-dialog " style="max-width: 1300px;">
						Modal content
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
	
	<script src="plugins/jquery/jquery.min.js"></script>
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
	<script src="dist/js/notify.min.js"></script>
	<script src="js/select2.min.js"></script>


	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
	<script src="plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
	<script src="js/bootstrap3-typeahead.min.js"></script>

	<script src="js/jquery.smartWizard.min.js"></script>
	<script src="plugins/popper/umd/popper.min.js"></script>
	<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="dist/css/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>
	<script src="plugins/js/off-canvas.js"></script>
	<script src="plugins/js/hoverable-collapse.js"></script>
	<script src="js/registration.js"></script>
	<script src="js/commonFunctions.js"></script>
</body>

</html>
