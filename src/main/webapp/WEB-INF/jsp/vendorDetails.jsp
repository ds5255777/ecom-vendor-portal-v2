<%@ page import="com.main.commonclasses.GlobalConstants" %>
<%@ page import="com.main.commonclasses.GlobalUrl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

th, td,tr {
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
                            <div class="card card-primary">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card card-primary">
                                <div class="card-body">
                                    <table id="tabledata" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary">Vendor code</th>
                                                <th class="bg-primary">Business Partner Name</th>
                                                <th class="bg-primary">Business Partner Type</th>
                                                <th class="bg-primary">Business Classification</th>
                                                <th class="bg-primary">Introduced By Name</th>
                                                <th class="bg-primary">introduced by email id</th>
                                                <th class="bg-primary">Status</th>
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
    </div>

    <div class="modal fade" id="userModal" role="dialog">
        <div class="modal-dialog " style="max-width: 1800px;">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-primary" style="margin-bottom: 10px;">
                                <div class="card-header" id="addressBookHead" style="background: #11aef6; color: #ffffff;">
                                    <h6 class="mb-0">Basic Details</h6>
                                </div>
                                <div id="basicDetailsHeadData" aria-labelledby="basicDetailsHead" style="border-style: solid; border-width: 1px; border-color: #11aef6;">
                                    <form id="stepOneForm" class="forms-sample" style="padding: 20px;">
                                        <table class="table center-aligned-table" id="fromTable">
                                            <thead>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><label>Process Id</label></td>
                                                    <td colspan="1"><input type="text" class="form-control p-input" id="pid" name="pid" readonly></td>

                                                    <td><label>Request Status</label></td>
                                                    <td colspan="1"><input type="text" class="form-control p-input" id="venStatus" name="venStatus" readonly></td>
                                                    <td><label>Business Partner Type</label></td>
                                                    <td colspan="1"><input type="text" class="form-control p-input" id="vendorType" name="vendorType" readonly></td>
                                                </tr>
                                                <tr class="">
                                                    <td><label for="name">Introducer Name<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan="1"><input type="text" readonly class="form-control p-input" id="introducedByName" name="introducedByName" placeholder="Introducer Name" maxlength="50"></td>

                                                    <td><label for="emailId">Introducer Email ID<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan="1"><input type="text" readonly class="form-control p-input" id="introducedByEmailID" name="introducedByEmailID" maxlength="50" placeholder="abc@ecomexpress.in" onchange="removeValCssByID(this)"><span id="message"></span></td>

                                                    <td><label for="Supplier Type">Business Partner
                                                            Code</label></td>
                                                    <td colspan="1">
                                                        <input type="hidden" id="id" name="id">
                                                        <input type="text" class="form-control p-input" id="bpCode" name="bpCode" placeholder="Business Partner Code" onchange="removeValCssByID(this);" oninput="this.value = this.value.toUpperCase()">
                                                    </td>


                                                </tr>



                                                <tr>
                                                   
                                                    <input type="hidden" id="roleId">


                                                    <td><label for="suppName">Business Partner Name<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan="1"><input type="text" class="form-control p-input" id="suppName" name="suppName" placeholder="Business Partner Name" onchange="removeValCssByID(this)" oninput="this.value = this.value.toUpperCase()" maxlength="50"></td>

                                                    <td><label for="businessClassification">Business
                                                            Classification</label></td>
                                                    <td><select id="businessClassification" name="businessClassification" class="form-control p-input" onchange="MESMENumber()">
                                                            <option value="">Select</option>
                                                            <c:forEach items="${classification}" var="classi">

                                                                <option value="${classi}">${classi}</option>
                                                            </c:forEach>

                                                        </select></td>

                                                    <td><label for="mesmeNumber">MESME Certificate Number</label></td>
                                                    <td colspan="1"><input type="text" class="form-control p-input" id="mesmeNumber" maxlength="12" name="mesmeNumber" placeholder="MESME Certificate Number" disabled="disabled"></td>
                                                </tr>





                                                <tr class="">


                                                    <td><label for="aadharNumber">Aadhar Number</label></td>
                                                    <td colspan="1"><input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" class="form-control p-input" id="aadharNumber" maxlength="12" name="aadharNumber" placeholder="Aadhar Number" onblur="AadharValidate();"></td>

                                                    <td><label for="adharLinkStatus">Aadhar Link
                                                            Status</label></td>

                                                    <td><select colspan="1" class="form-control p-input" id="adharLinkStatus" name="adharLinkStatus" placeholder="Aadhar Link Status" onchange="removeValCssByID(this)">
                                                            <option value="">Select</option>
                                                            <c:forEach items="${adharLink}" var="link">

                                                                <option value="${link}">${link}</option>
                                                            </c:forEach>

                                                        </select></td>

                                                    <td><label>Section Type<span class="required adHocRequired"></span></label></td>

                                                    <td><select colspan="1" class="form-control p-input" id="sectionType" name="sectionType" placeholder="Aadhar Link Status" onchange="removeValCssByID(this)">
                                                            <option value="">Select</option>
                                                            <c:forEach items="${sectionType}" var="type">

                                                                <option value="${type}">${type}</option>
                                                            </c:forEach>

                                                        </select></td>



                                                </tr>

                                                <tr class="">

                                                    <td><label for="panNumber">Pan Number<span class="required adHocRequired"></span></label></td>
                                                    <td colspan="1"><input type="text" class="form-control p-input" id="panNumber" name="panNumber" placeholder="Pan Number" oninput="this.value = this.value.toUpperCase()" maxlength="10" onchange="removeValCssByID(this)"></td>
                                                    <td><label for="tanNumber">TAN Number</label></td>
                                                    <td colspan="1"><input type="text" class="form-control p-input" id="tanNumber" name="tanNumber" placeholder="TAN Number" oninput="this.value = this.value.toUpperCase()" maxlength="10" onkeypress="return isNumberKey(evt);"></td>

                                                    <td><label>Region<span class="required adHocRequired"></span></label></td>

                                                    <td style="width: auto"><select  class="js-example-basic-multiple1 select2" name="region[]" id="region" multiple="multiple" onchange="region1();">
                                                            <c:forEach items="${region}" var="reg">

                                                                <option value="${reg}">${reg}</option>
                                                            </c:forEach>
                                                        </select></td>

                                                </tr>



                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>

                            <div id="step-2" class="">
                                <div class="card" style="margin-bottom: 10px;">
                                    <div class="card-header" id="addressBookHead" style="background: #11aef6; color: #ffffff;">
                                        <h6 class="mb-0">Address Book</h6>
                                    </div>

                                    <div id="addressBookHeadData" aria-labelledby="addressBookHead" style="border-style: solid; border-width: 1px; border-color: #11aef6;">
                                        <div class="card-body" style="padding-top: 15px;">
                                            <form id="stepTwoForm" class="forms-sample">
                                                <table class="table center-aligned-table addTable" id="fromTable" name="fromTable">

                                                    <tbody>
                                                        <tr class="">
                                                            <td><label class="addressLable" for="country">Country<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><select id="addCountry" name="addCountry" class="form-control p-input">
                                                                    <c:forEach items="${country}" var="count">

                                                                        <option value="${count}">${count}</option>
                                                                    </c:forEach>

                                                                </select></td>

                                                            <td><label class="addressLable">State<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2">
                                                                <select name="state" id="state" class="form-control p-input">
                                                                    <c:forEach items="${stateName}" var="stateNames">

                                                                        <option value="${stateNames}">${stateNames}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </td>
                                                            <td><label class="addressLable">District/City<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="city" name="city" placeholder="District" maxlength="50"></td>
                                                        </tr>
                                                        <tr class="">


                                                            <td><label>Postal/ZIP Code<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="pinCode" name="pinCode" onkeypress="return event.charCode >= 48 && event.charCode <= 57" placeholder="Postal Code/ ZIP Code" maxlength="6"></td>

                                                            <td><label>Business Partner Type<span class="required adHocRequired">*</span></label></td>

                                                            <td colspan="2"><select class="js-example-basic-multiple select2" name="states[]" id="states" onchange="select()" multiple="multiple">
                                                                    <c:forEach items="${business}" var="bus">

                                                                        <option value="${bus}">${bus}</option>
                                                                    </c:forEach>
                                                                </select></td>


                                                            <td><label for="partnerType">Business Partner</label></td>
                                                            <td colspan="2"><select id="partnerType" name="partnerType" class="form-control p-input" disabled="disabled">
                                                                    <c:forEach items="${partner}" var="par">

                                                                        <option value="${par}">${par}</option>
                                                                    </c:forEach>

                                                                </select></td>
                                                        </tr>

                                                        <tr class="">

                                                            <td><label for="compGstn">GSTN Number<span class="required adHocRequired"></span></label></td>
                                                            <td colspan="2"><input type="test" class="form-control p-input gst" id="compGstn" name="compGstn" name="compGstn" placeholder="GSTN Number" oninput="this.value = this.value.toUpperCase()" maxlength="15"></td>

                                                            <td><label for="addressDetails">Address
                                                                    Details<span class="required adHocRequired">*</span>
                                                                </label></td>
                                                            <td colspan="2"><textarea class="form-control" id="addDetails" name="addDetails" maxlength="250" placeholder="Complete Address" rows="2"></textarea></td>
                                                            <td style="width: 150px;"></td>
                                                            <td colspan=''><button type="Button" class="btn btn-primary" id="addBookGridButt" name="addBookGridButt">Add Address</button></td>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                            </form>
                                            <form class="forms-sample">
                                                <div class="card-body">
                                                    <div class="table-responsive" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                                        <table class="table center-aligned-table" id="addBookGrid" name="addBookGrid">
                                                            <thead>
                                                                <tr style="background: #1991eb; color: white;">
                                                                    <th>Country</th>
                                                                    <th>State</th>
                                                                    <th>District/City</th>
                                                                    <th>Postal/ZIP Code</th>
                                                                    <th>Business Partner Type</th>
                                                                    <th>Business Partner</th>
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
                                <div class="card" style="margin-bottom: 10px;" style="margin-bottom: 10px;">
                                    <div class="card-header" id="contactDir" style="background: #1991eb; color: #ffffff;">
                                        <h6 class="mb-0">Contact Details</h6>
                                    </div>
                                    <div id="contactDirData" aria-labelledby="contactDir" class="collapse show" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                        <div class="card-body">
                                            <form id="Form-3" class="forms-sample">
                                                <table class="table center-aligned-table" id="fromTable" name="fromTable">
                                                    <thead>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="">
                                                            <td><label for="fnameCon">First Name<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="conFname" name="conFname" placeholder="First Name"></td>

                                                            <td><label for="lnameCon">Last Name<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="conLname" name="conLname" placeholder="Last Name"></td>

                                                            <td><label for="phno">Phone Number<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="conPhone" onkeypress="return event.charCode >= 48 && event.charCode <= 57" name="conPhone" placeholder="Phone Number" maxlength="10"></td>
                                                        <tr>
                                                        <tr class="">


                                                            <td><label for="emailId">Email Id<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="conEmail" name="conEmail" placeholder="Email"></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td>
                                                                <button type="button" class="btn btn-primary" id="contactDetailsButt" name="contactDetailsButt">Add
                                                                    Contact Details</button>
                                                            </td>
                                                        <tr>
                                                    </tbody>
                                                </table>
                                                <div class="form-group"></div>
                                            </form>
                                            <form class="forms-sample">
                                                <div class="card-body">
                                                    <div class="table-responsive" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                                        <table class="table center-aligned-table" id="contactDetailsGrid" name="contactDetailsGrid">
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
                                    <div class="card-header" id="addressBookHead" style="background: #1991eb; color: #ffffff;">
                                        <h6 class="mb-0">Bank Details</h6>
                                    </div>
                                    <div id="addressBookHeadData" aria-labelledby="addressBookHead" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                        <div class="card-body" style="margin-bottom: 10px;">
                                            <form id="Form-4" class="forms-sample">
                                                <table class="table center-aligned-table" id="fromTable" name="fromTable">
                                                    <thead>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="">
                                                            <td><label for="bankName">Bank Name<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="bankName" name="bankName" placeholder="Bank Name" maxlength="200"></td>

                                                            <td><label for="bankName">Beneficiary Name<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="beneficiaryName" name="beneficiaryName" placeholder="Beneficiary Name" maxlength="200"></td>

                                                            <td><label for="ifscCode">IFSC Code<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="ifscCode" name="ifscCode" placeholder="IFSC Code" oninput="this.value = this.value.toUpperCase()" maxlength="11"></td>

                                                            <td><label for="accoutNumber">Account Number<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="accoutNumber" onkeypress="return event.charCode >= 48 && event.charCode <= 57" name="accoutNumber" placeholder="Account Number"></td>

                                                        </tr>

                                                        <tr class="">

                                                            <td><label for="Confirmed accoutNumber">Confirm Account Number<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="confirmedAccoutNumber" onkeypress="return event.charCode >= 48 && event.charCode <= 57" name="confirmedAccoutNumber" placeholder="Confirm  Account Number" maxlength="16"></td>

                                                            <td><label for="accoutCurrency">Currency<span class="required adHocRequired">*</span></label></td>
                                                            <td colspan="2"><select id="accoutCurrency" name="accoutCurrency" class="form-control p-input">
                                                                    <c:forEach items="${currency}" var="cur">

                                                                        <option value="${cur}">${cur}</option>
                                                                    </c:forEach>
                                                                </select></td>
                                                            <td></td>
                                                            <td colspan="3">
                                                                <button type="Button" id="addBankGridButt" name="addBankGridButt" class="btn btn-primary">Add
                                                                    Account Details</button>
                                                            </td>

                                                            <div class="registrationFormAlert" id="divCheckPasswordMatch"> </div>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                                <div class="card-body">
                                                    <div class="table-responsive" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                                        <table class="table center-aligned-table" id="addBankGrid" name="addBankGrid">
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

                                <div class="card" style="margin-bottom: 10px;">
                                    <div class="card-header" id="addressBookHead" style="background: #1991eb; color: #ffffff;">
                                        <h6 class="mb-0">Invoice Payment Terms</h6>
                                    </div>
                                    <div id="addressBookHeadData" aria-labelledby="addressBookHead" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                        <div class="card-body" style="margin-bottom: 10px;">
                                            <form id="stepSixForm" class="forms-sample">
                                                <table class="table center-aligned-table" id="fromTable" name="fromTable">
                                                    <thead>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="">
                                                            <td><label for="invoiceCurrency">Invoice
                                                                    Currency<span class="required adHocRequired">*</span>
                                                                </label></td>
                                                            <td colspan="2"><select id="invoiceCurrency" name="invoiceCurrency" class="form-control p-input">
                                                                    <c:forEach items="${currency}" var="cur">

                                                                        <option value="${cur}">${cur}</option>
                                                                    </c:forEach>

                                                                </select></td>

                                                            <td><label for="paymentCurrency">Payment
                                                                    Currency<span class="required adHocRequired">*</span>
                                                                </label></td>
                                                            <td colspan="2"><select id="paymentCurrency" name="paymentCurrency" class="form-control p-input">
                                                                    <c:forEach items="${currency}" var="cur">

                                                                        <option value="${cur}">${cur}</option>
                                                                    </c:forEach>
                                                                </select></td>

                                                            <td><label for="creditTerms">Payment / Credit
                                                                    Terms<span class="required adHocRequired">*</span>
                                                                </label></td>
                                                            <td colspan="2"><select id="creditTerms" name="creditTerms" class="form-control p-input"  onchange="removeValCssByID(this)">
                                                                    <option value="">Select</option>
                                                                    <c:forEach items="${payment}" var="pay">

                                                                        <option value="${pay}">${pay}</option>
                                                                    </c:forEach>

                                                                </select></td>
                                                        </tr>
                                                        <tr class="">
                                                            <td><label for="paymentMethod">Payment Method<span class="required adHocRequired">*</span></label></td>

                                                            <td colspan="2">

                                                                <select id="paymentMethod" name="paymentMethod" class="form-control p-input" onchange="removeValCssByID(this)">

                                                                    <c:forEach items="${paymentMethod}" var="met">
                                                                        <option value="${met}">${met}</option>
                                                                    </c:forEach>
                                                                </select>

                                                            </td>

                                                            <td><label for="dateBasis">Terms Date Basis</label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="dateBasis" name="dateBasis" placeholder="Terms Date Basis"></td>
                                                            <td><label for="deliveryTerms">Delivery Terms</label></td>
                                                            <td colspan="2"><input type="text" class="form-control p-input" id="deliveryTerms" name="deliveryTerms" placeholder="Delivery Terms"></td>


                                                        </tr>

                                                    </tbody>
                                                </table>

                                            </form>
                                        </div>
                                    </div>
                                </div>


                            </div>



                            <div id="step-4" class="">
                                <div class="card" style="margin-bottom: 10px;">


                                    <div class="card" style="margin-bottom: 10px;">
                                        <div class="card-header" id="addressBookHead" style="background: #1991eb; color: #ffffff;">
                                            <h6 class="mb-0">TDS Details</h6>
                                        </div>
                                        <div id="addressBookHeadData" aria-labelledby="addressBookHead" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                            <div class="card-body" style="margin-bottom: 10px;">
                                                <form id="stepSevenForm" class="forms-sample">
                                                    <table class="table center-aligned-table" id="fromTable" name="fromTable">
                                                        <thead>
                                                        </thead>
                                                        <tbody>
                                                            <tr class="">

                                                                <td><label class="addressLable" for="tdsApplication">TDS
                                                                        Applicable<span class="required">*</span></label></td>
                                                                <td colspan="2"><select id="tdsApplication" name="tdsApplication" onchange="changetextbox();" class="form-control p-input ">
                                                                        <option value="Yes">Yes</option>
                                                                        <option value="No">No</option>
                                                                    </select></td>

                                                                <td><label class="addressLable" for="tdsSection">TDS
                                                                        Section<span class="required adHocRequired">*</span></label></td>
                                                                <td colspan="2"><select id="tdsSection" name="tdsSection" class="form-control p-input">
                                                                        <option value="">Select</option>
                                                                        <c:forEach items="${tdsCode}" var="tds">

                                                                            <option value="${tds}">${tds}</option>
                                                                        </c:forEach>



                                                                    </select></td>

                                                                <td><label for="tdsRate">TDS Exemption Rate
                                                                        %<span class="required adHocRequired">*</span></label></td>
                                                                <td colspan="2"><input type="text" onkeypress="return event.charCode >= 48 && event.charCode <= 57 || event.charCode <= 46" class="form-control p-input" id="tdsRate" name="tdsRate" placeholder="TDS  Exemption Rate" maxlength="4"></td>
                                                            </tr>

                                                        </tbody>
                                                    </table>

                                                </form>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="card" style="margin-bottom: 10px;">
                                        <div class="card-header" id="itrHead" style="background: #1991eb; color: #ffffff;">
                                            <h6 class="mb-0">ITR Details</h6>
                                        </div>
                                        <div id="itrHeadData" aria-labelledby="itrHead" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                            <div class="card-body" style="margin-bottom: 10px;">
                                                <form id="StepEightForm" class="forms-sample">
                                                    <table class="table center-aligned-table table-striped" id="addITRGrid" name="addITRGrid">
                                                        <tbody>
                                                            <tr class="">
                                                                <td><label>Select Financial Year<span class="required adHocRequired"></span></label> </td>
                                                                <td><select id="fyYear1" name="fyYear1" class="form-control p-input ">
                                                                        <option value="">Select</option>

                                                                        <c:forEach items="${financialYear}" var="fin">

                                                                            <option value="${fin}">${fin}</option>
                                                                        </c:forEach>

                                                                    </select></td>
                                                                <td><label>Fill Acknowledgement Number<span class="required adHocRequired"></span></label> </td>
                                                                <td><input type="text" id="acknowledgementNumber1" name="acknowledgementNumber1" class="form-control p-input "></td>
                                                                <td><input type="file" id="ITRFile1" name="ITRFile1" placeholder="Fill Acknowledgement Number" onchange="handleFileSelect(event,'ITRFileText1'), onValidateFile('ITRFile1')" class="form-control p-input" accept=".jpg, .jpeg, .pdf">
                                                                    <textarea id="ITRFileText1" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                            size Max ${fileSize} MB</span></label>
                                                                </td>
                                                            </tr>
                                                            <tr class="">
                                                                <td><label>Select Financial Year<span class="required adHocRequired"></span></label> </td>
                                                                <td><select id="fyYear2" name="fyYear2" class="form-control p-input ">
                                                                        <option value="">Select</option>

                                                                        <c:forEach items="${financialYear}" var="fin">

                                                                            <option value="${fin}">${fin}</option>
                                                                        </c:forEach>

                                                                    </select></td>
                                                                <td><label>Fill Acknowledgement Number<span class="required adHocRequired"></span></label> </td>
                                                                <td><input type="text" id="acknowledgementNumber2" name="acknowledgementNumber2" class="form-control p-input "></td>
                                                                <td><input type="file" id="ITRFile2" name="ITRFile2" placeholder="Fill Acknowledgement Number" onchange="handleFileSelect(event,'ITRFileText2'), onValidateFile('ITRFile2')" class="form-control p-input" accept=".jpg, .jpeg, .pdf">
                                                                    <textarea id="ITRFileText2" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                            size Max ${fileSize} MB</span></label>
                                                                </td>
                                                            </tr>
                                                            <tr class="">
                                                                <td><label>Select Financial Year<span class="required adHocRequired"></span></label> </td>
                                                                <td><select id="fyYear3" name="fyYear3" class="form-control p-input ">
                                                                        <option value="">Select</option>

                                                                        <c:forEach items="${financialYear}" var="fin">

                                                                            <option value="${fin}">${fin}</option>
                                                                        </c:forEach>

                                                                    </select></td>
                                                                <td><label>Fill Acknowledgement Number<span class="required adHocRequired"></span></label> </td>
                                                                <td><input type="text" id="acknowledgementNumber3" name="acknowledgementNumber3" class="form-control p-input "></td>
                                                                <td><input type="file" id="ITRFile3" name="ITRFile1" placeholder="Fill Acknowledgement Number" onchange="handleFileSelect(event,'ITRFileText3'), onValidateFile('ITRFile1')" class="form-control p-input" accept=".jpg, .jpeg, .pdf">
                                                                    <textarea id="ITRFileText3" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                            size Max ${fileSize} MB</span></label>
                                                                </td>
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
                                    <div class="card-header" id="addressBookHead" style="background: #1991eb; color: #ffffff;">
                                        <h6 class="mb-0">Document Upload</h6>
                                    </div>
                                    <div id="addressBookHeadData" aria-labelledby="addressBookHead" style="border-style: solid; border-width: 1px; border-color: #11aef6;">
                                        <div class="card-body">
                                            <form class="forms-sample">

                                                <div class="card-body">
                                                    <div class="table-responsive" style="border-style: solid; border-width: 1px; border-color: #1991eb;">
                                                        <table class="table center-aligned-table" id="addDocTypeGrid" name="addDocTypeGrid" style="border-spacing: 0px; table-layout: fixed; margin-left: auto; margin-right: auto;">

                                                            <tbody>
                                                                <tr>
                                                                    <td><label>GST Certificate<span class="required"></span></label></td>
                                                                    <td><input type="file" id="GSTFile" name="GSTFile" onchange=" removeValCssByID(this),  handleFileSelect(event,'GSTFileText'), onValidateFile('GSTFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="GSTFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>

                                                                    <td><label>Proprietorship Declaration<span class="required"></span></label></td>
                                                                    <td><input type="file" id="PDFile" name="PDFile" onchange=" removeValCssByID(this),  handleFileSelect(event,'PDFileText'), onValidateFile('PDFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="PDFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>

                                                                </tr>

                                                                <tr>
                                                                    <td><label>PAN Card<span class="required"></span></label></td>
                                                                    <td><input type="file" id="PANFile" name="PANFile" onchange="handleFileSelect(event,'PANFileText'), onValidateFile('PANFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="PANFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>

                                                                    <td><label>Cancelled Cheque/ Passbook/
                                                                            Bank Statement<span class="required">*</span>
                                                                        </label></td>
                                                                    <td><input type="file" id="CCFile" name="CCFile" onchange="handleFileSelect(event,'CCFileText'), onValidateFile('CCFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="CCFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td><label>Aadhar Card</label></td>
                                                                    <td><input type="file" id="ACFile" name="ACFile" onchange="handleFileSelect(event,'ACFileText'), onValidateFile('ACFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="ACFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
                                                                    <td><label>Aadhar and PAN Card linking
                                                                            declaration</label></td>
                                                                    <td><input type="file" id="APLFile" name="APLFile" onchange="handleFileSelect(event,'APLFileText'), onValidateFile('APLFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="APLFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td><label>ITR Filling Declaration<span class="required">*</span></label></td>
                                                                    <td><input type="file" id="ITRFile" name="ITRFile" onchange="handleFileSelect(event,'ITRFileText'), onValidateFile('ITRFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="ITRFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
                                                                    <td><label>Filled Updated VRF Form</label></td>
                                                                    <td><input type="file" id="FUVFFile" name="FUVFFile" onchange="handleFileSelect(event,'FUVFFileText'), onValidateFile('FUVFFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="FUVFFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td><label>MSME Certificate<span class="required">*</span></label></td>
                                                                    <td><input type="file" id="MSMECFile" name="MSMECFile" onchange="handleFileSelect(event,'MSMECFileText'), onValidateFile('MSMECFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="MSMECFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
                                                                    <td><label>Approval Mail<span class="required"></span></label></td>
                                                                    <td><input type="file" id="AMFile" name="AMFile" onchange="handleFileSelect(event,'AMFileText'), onValidateFile('AMFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="AMFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
                                                                </tr>

                                                                <tr>

                                                                    <td style="word-wrap: break-word;"><label>Name
                                                                            mismatch affidavit or declaration would be required
                                                                            if name mentioned in all document is not same
                                                                            including spelling error<span class="required"></span>
                                                                        </label></td>
                                                                    <td><input type="file" id="NMISFile" name="NMISFile" onchange="handleFileSelect(event,'NMISFileText'), onValidateFile('NMISFile')" class="form-control p-input" accept=".jpg, .jpeg, .pdf"> <textarea id="NMISFileText" rows="5" style="display: none;"></textarea>
                                                                        <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                                size Max ${fileSize} MB</span></label>
                                                                    </td>
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
                                <button type="submit" id="updateBtn" onclick="sendToServer()" class="btn btn-primary">Update</button>
                                <button type="button" class="btn btn-primary" id="closePopBtn" data-dismiss="modal">Close</button>
                            </div>


                        </div>
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
	<script src="js/select2.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var bootstrapTooltip = $.fn.tooltip.noConflict();
			$.fn.bstooltip = bootstrapTooltip;
			$('.quickHelp').bstooltip();
		})
	</script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<script src="plugins/datatables/jquery.dataTables.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>
	
	<script>
        function myFunction() {
            document.getElementById("myDropdown").classList.toggle("show");
        }

        function filterFunction() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            div = document.getElementById("myDropdown");
            a = div.getElementsByTagName("a");
            for (i = 0; i < a.length; i++) {
                txtValue = a[i].textContent || a[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }

    </script>


    <script type="text/javascript">
        var globalVendorCode = "";
        var dataLimit='${dataLimit}';
		dataLimit=parseInt(dataLimit);

        var tabledata = $('#tabledata').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": true,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true ,
            "pageLength": dataLimit
        });
        $(document).ready(function() {
            $('.js-example-basic-multiple1').select2({
            	zplaceholder: "Select Region",
                allowClear: true
    		
            });
            
        });
        $(document).ready(function() {
            $('.js-example-basic-multiple2').select2({
            	zplaceholder: "Select Flag",
                allowClear: true
    		
            });
            
        });
       

        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });

        getData();

        var result;
        
        function getData() {
        	
        	var bpcode="";

            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getActiveVendorData%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {
                	
                    if (data.msg == 'success') {
                        var lastName = "";
                        result = data.data;
                        tabledata.clear();
                         for (var i = 0; i < result.length; i++) {
                        	/*  bpcode=result[i].bpCode; */
                        	 if(!result[i].hasOwnProperty("introducedByName")){
     							result[i].introducedByName="";
     						}
                        	 if(!result[i].hasOwnProperty("suppName")){
     							result[i].suppName="";
     						}
                        	 if(!result[i].hasOwnProperty("compEmail")){
     							result[i].compEmail="";
     						}
                        	 if(!result[i].hasOwnProperty("introducedByEmailID")){
     							result[i].introducedByEmailID="";
     						}
                        	 if(!result[i].hasOwnProperty("businessClassification")){
     							result[i].businessClassification="";
     						}
                        	 
                        	 if(!result[i].hasOwnProperty("partnerType")){
     							result[i].partnerType="";
     						}
                        	 if(!result[i].hasOwnProperty("vendorType")){
     							result[i].vendorType="";
     						}
                        	 if(!result[i].hasOwnProperty("phoneNumber")){
     							result[i].phoneNumber="";
     						}
                        	 if(!result[i].hasOwnProperty("flag")){
      							result[i].flag="";
      						}
                        	 
                        	 
                        	 var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#\" onclick=\"editData('" + result[i].bpCode + "')\" >" + result[i].bpCode + "</button>";
                        	 /* var inactive = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"inactiveActiveDeleteData('"  + result[i].bpCode + "' ,'"  +  result[i].suppName + "' )\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>"; */
                        	 
                        	 
                        	 /*  else {
                        		 Status=  "<select  class=\"form-control-sm \" onchange=\"setVendorStatus(this.value,'"+i+"')\" style=\"width: 100px; height: 28px;\" id=\"status_"+i+"\" > <option value=\"1\" \">Active</option><option value=\"0\"  \">In-Active</option> </select > ";		 
                        	 } */ 
                             var inactive = "<a href=\"#\" data-toggle=\"modal\"  tittle=\"In-Active Vendor\" data-target=\"#vendorValue\" onclick=\"inActiveVendor('"  + result[i].bpCode + "' ,'"  + i+ "','"  + result[i].suppName+ "' )\"> <i style=\"color:red;\" class=\"fas fa-user-slash\"></i>  </button>";
                             var active = "<a href=\"#\" data-toggle=\"modal\" tittle=\"Active Vendor\" data-target=\"#vendorValue\" onclick=\"activeVendor('"  + result[i].bpCode + "' ,'"  + i+ "','"  + result[i].suppName+ "' )\"> <i class=\"fas fa-user\"></i>  </button>";
                             
                            tabledata.row.add([view,
                            	result[i].suppName,
                            	result[i].vendorType, 
                            	result[i].businessClassification,
                            	result[i].introducedByName, 
                            	result[i].introducedByEmailID,
                            	result[i].flag,
                            	inactive+" &nbsp;&nbsp; "+active]);
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
        
      
       
        function inActiveVendor(bpcode,index,name){
          	 
          	 
          	 Swal.fire({
          		  title: 'Are you sure want to In-Active?',
          		  text: "Vendor Code : "+bpcode,
          		  icon: 'warning',
          		  showCancelButton: true,
          		  confirmButtonColor: '#3085d6',
          		  cancelButtonColor: '#d33',
          		  confirmButtonText: 'Yes'
          		}).then((result) => {
          			
          			let test=[1];
          			test[0]=result;
          			var val=Object.values(test[0])
          		  if (val=="true") {
          			inactiveVendorFlag(bpcode,index,name);
          		  }
          		})
          		
             }
        
        function inactiveVendorFlag(bpcode,index,name) {
       	 
       	 
       	
           var json = {
               "bpCode": bpcode,
               "status": "0"
           }
           $.ajax({
               type: "POST",
               data: JSON.stringify(json),
               url: "<%=GlobalUrl.setStatusOfVendorByBpCode%>",
               dataType: "json",
               contentType: "application/json",
               async: false,
               success: function(data) {

                   if (data.msg == 'success') {

                   	
                       Toast.fire({
                           type: 'success',
                           title: 'In-Active Successfully..'
                       })


                       getData();
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
        
        function activeVendor(bpcode,index,name){
         	 
         	 
         	 Swal.fire({
         		  title: 'Are you sure want to Active?',
         		  text: "Vendor Code : "+bpcode,
         		  icon: 'warning',
         		  showCancelButton: true,
         		  confirmButtonColor: '#3085d6',
         		  cancelButtonColor: '#d33',
         		  confirmButtonText: 'Yes'
         		}).then((result) => {
         			
         			let test=[1];
         			test[0]=result;
         			var val=Object.values(test[0])
         		  if (val=="true") {
         			activeVendorFlag(bpcode,index,name);
         		  }
         		})
         		
            }
       
       function activeVendorFlag(bpcode,index,name) {
      	 
      	 
      	
          var json = {
              "bpCode": bpcode,
              "status": "1"
          }
          $.ajax({
              type: "POST",
              data: JSON.stringify(json),
              url: "<%=GlobalUrl.setStatusOfVendorByBpCode%>",
              dataType: "json",
              contentType: "application/json",
              async: false,
              success: function(data) {

                  if (data.msg == 'success') {

                  	
                      Toast.fire({
                          type: 'success',
                          title: 'Active Successfully..'
                      })


                      getData();
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

        function getVendorStatus(value,bpcode,index){
        	
        	  var json = {
                      "bpCode": bpcode
                     

                  }


                 
                  $('.loader').show();

                  $.ajax({
                      type: "POST",
                      data: JSON.stringify(json),
                      url: "<%=GlobalUrl.getAllVendorStatus%>",
                      dataType: "json",
                      contentType: "application/json",
                      async: false,
                      success: function(data) {

                         
                          $('.loader').hide();

                          if (data.msg == 'success') {
                        	  var result = data.data;
                        	 
                          	    for (var i = 0; i < result.length; i++) {
                          	    	 alert(result[i].status);	
                              	 
                              var code=result[i].status;
                              	
                              	$("#status_"+index).val(code)
                              } 

                              tabledata.draw();
                              $("tbody").show();
                              
    
                          } else {
                            
                              $('.loader').hide();
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
        
        

        function changetextbox() {
            /* alert(document.getElementById("tdsApplication").value);  */
            if (document.getElementById("tdsApplication").value === "No") {
                document.getElementById("tdsSection").disabled = 'true';
                document.getElementById("tdsRate").disabled = 'true';
                //    document.getElementById("tdsRate").val()="";
                //            	    document.getElementById("tdsSection").value()="";
                $("#tdsSection").val("");
                $("#tdsRate").val("");

            } else {
                document.getElementById("tdsSection").disabled = '';
                document.getElementById("tdsRate").disabled = '';
            }
        }

        $(document).ready(function() {
            $(".email").change(function() {
                var inputvalues = $(this).val();
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (!regex.test(inputvalues)) {
                    $("#compEmail").val("");

                    swal.fire("Alert", "Invalid Email Id", "warning");
                    return regex.test(inputvalues);
                }
            });
            $("#introducedByEmailID").change(function() {
                var inputvalues = $(this).val();
                var regex = /^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@ecomexpress.in$/;
                
                if (!regex.test(inputvalues)) {
                    $("#introducedByEmailID").val("");

                    swal.fire("Alert", "Dear User Please Provide ECOM Patner Email ID", "warning");
                    return regex.test(inputvalues);
                }
            });
        });
        
        $(document).ready(function() {
            $("#conEmail").change(function() {
                var inputvalues = $(this).val();
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (!regex.test(inputvalues)) {
                    $("#conEmail").val("");

                    swal.fire("Alert", "Invalid Email Id....", "warning");
                    return regex.test(inputvalues);
                }
            });
        });

        


        var id="";
        var bpCode="";
       

        function editData(bpCode) {
            
            var json = {

                "bpCode":  bpCode
            }
            
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.getVendorById%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {
                    if (data.msg == 'success') {
                        var result = data.data;
                    	id=result.id;
                    
                    	var myForm = "";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result);
                        
                           var vendorType=result.vendorType;
                        
                           var str = vendorType.split(",");
                           
                         
                        	   for (var i = 0; i < str.length; i++) {
                            	 
                            	   
                            	    if(str[i] == 'Network' && str[i+1] == 'Fixed Asset' && str[i+2] == 'Other'){
                            	    		$('#states').val(["Network","Fixed Asset","Other"]).change() 
                            	    		
                            				break;
                            	    
                            	   	}else if(str[i] == 'Network' && str[i+1] == 'Fixed Asset' ){
                               		   		$('#states').val(["Network","Fixed Asset"]).change().css( "color", "blue" );
                               		  	 	break;
                               	   	}else if(str[i] == 'Fixed Asset' && str[i+1] == 'Other'){
                                  		  	 $('#states').val(["Fixed Asset","Other"]).change()
                                  			break;
                                  	 }else if(str[i] == 'RENT'){
                              		  	 $('#states').val(["Network","Other"]).change()
                               			break;
                               	 	}else if(str[i] == 'Network'){
                                    		 
                                  		   $('#states').val('Network').submit().trigger('change');
                                  			 break;
                                  	 }else if(str[i] == 'FIXED ASSETS'){
                                    		 
                                  		   $('#states').val('FIXED ASSETS').submit().trigger('change'); 
                                  		 	break;
                                  	 }else if(str[i] == 'OTHER EXPENSES'){
                              				$('#states').val('Other').trigger('change');
                              		 		break;
                              	   }else if(str[i] == 'EMPLOYEE NOMINEE'){
                         				$('#states').val('Other').trigger('change');
                          		 		break;
                          	   }else if(str[i] == 'COURIER'){
                     				$('#states').val('Other').trigger('change');
                      		 		break;
                      	   }    	
                            	  
                        	 } 
                        
                           
                        	 select();
                        	  var ero=result.ero;
                        	  var wro=result.wro;
                        	  var nro=result.nro;
                        	  var sro=result.sro;
                        	  var ihq=result.ihq;
                        	  
                        	   if(ero == 'Y'){
                   				$('#region').val('ERO').trigger('change');
                    		 		//break;
                    	   }  
                        	  
                         if(wro == 'Y'){
                      				$('#region').val('WRO').trigger('change');
                       		 		//break;
                       	   } if(nro == 'Y'){
                 				$('#region').val('NRO').trigger('change');
                   		 		//break;
                   	   		}  if(sro == 'Y'){
                 				$('#region').val('SRO1').trigger('change');
                   		 		//break;
                   	   		}  if(ihq == 'Y'){
                 				$('#region').val('IHQ').trigger('change');
                   		 		//break;
                   	   		} 
                       	   
                   	   	 var addressPurchasingFlag=result.addressPurchasingFlag;
                   	  	var addressPaymentFlag=result.addressPaymentFlag;
                   	 	var invoicePrevalidatedFlag=result.invoicePrevalidatedFlag;
                   	  if(addressPurchasingFlag == 'Y'){
            				$('#flag').val('ADDRESS_PURCHASING').trigger('change');
             		 		//break;
             	 	  }  if(addressPaymentFlag == 'Y'){
         				$('#flag').val('ADDRESS_PAYMENT').trigger('change');
           		 		//break;
           	  		 } if(invoicePrevalidatedFlag == 'Y'){
         				$('#flag').val('INVOICE_PREVALIDATED').trigger('change');
           		 		//break;
           	  		 }
                       	   
                   	   	$('#acknowledgementNumber1').val(result.acknowledgementNumber1);
                   		$('#acknowledgementNumber2').val(result.acknowledgementNumber2);
                   		$('#acknowledgementNumber3').val(result.acknowledgementNumber3);
                   		
                   		$('#fyYear1').val(result.fyYear1);
                   		$('#fyYear2').val(result.fyYear2);
                   		$('#fyYear3').val(result.fyYear3);
                   		
                  
                      // if(result.partnerType!="Ad-Hoc"){
                    	   
                    	
                       // tabledata.clear();
                        $("#addBookGridTbody").html("");
                         for (var i = 0; i < result.addressDetails.length; i++) {
                      
                        	
                        	 $("#addBookGridTbody").append(' <tr class=""><td>' +
                        			 result.addressDetails[i].addCountry + '</td><td>' +
                        			 result.addressDetails[i].state + '</td><td>' +
                        			 result.addressDetails[i].city + '</td><td>' +
                        			 result.addressDetails[i].pinCode + '</td><td>' +
                        			 result.addressDetails[i].vendorType + '</td><td>' +
                        			 result.addressDetails[i].partnerType + '</td><td>' +
                        			 result.addressDetails[i].compGstn + '</td><td>' +
                        			 result.addressDetails[i].addDetails + '</td><td> <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');
                        } 
                         
                         $("#contactDetailsGridTbody").html("");
                         
                         for (var i = 0; i < result.contactDetails.length; i++) {

                         $("#contactDetailsGridTbody").append('<tr class=""><td>' +
                        		 result.contactDetails[i].conFname + '</td><td>' +
                        		 result.contactDetails[i].conLname + '</td><td>' +
                        		 result.contactDetails[i].conPhone + '</td><td>' +
                        		 result.contactDetails[i].conEmail + '</td><td> <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                         }
                        
                         $("#addBankGridTbody").html("");
                         for (var i = 0; i < result.accountDetails.length; i++) {
                         $("#addBankGridTbody").append('<tr class=""><td>' +
                        		 result.accountDetails[i].bankName + '</td><td>' +
                        		 result.accountDetails[i].beneficiaryName + '</td><td>' +
                        		 result.accountDetails[i].ifscCode + '</td><td>' +
                        		 result.accountDetails[i].accoutCurrency + '</td><td>' +
                        		 result.accountDetails[i].accoutNumber + '</td><td>' + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                        
                         }
                        
                        myForm = document.getElementById("stepSixForm");
                        setData(myForm, result);
                      
                        
                        myForm = document.getElementById("stepSevenForm");
                        setData(myForm, result);

                        $("#userModal").modal('show');

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
        
       
        
        $(document).ready(function() {
            $('.js-example-basic-multiple').select2({
            	zplaceholder: "Select Partner Type",
                allowClear: true,
                maximumSelectionLength: 1
            });
            
        });

        $("#addBookGridButt").click(function() {
            var abc = document.getElementById('city').value;
            var abc2 = document.getElementById('pinCode').value;
            var abc3 = document.getElementById('addDetails').value;
            var abc4 = document.getElementById('states').value;
        	 if (abc == null || abc == "") {
                 swal.fire("Alert", "District is mandatory", "warning");
                 return false;
             } else if (abc2 == null || abc2 == "") {
                 swal.fire("Alert", "Pin Code is mandatory", "warning");
                 return false;
             } else if (abc4 == null || abc4 == "") {
                 swal.fire("Alert", "Business Partner Type is mandatory", "warning");
                 return false;
             } else if (abc3 == null || abc3 == "") {
                 swal.fire("Alert", "Address is mandatory", "warning");
                 return false;
             }else {

                $("#addBookGrid").append(' <tr class=""><td>' +
                		 document.getElementById('addCountry').value + '</td><td>' +
                         document.getElementById('state').value + '</td><td>' +
                         document.getElementById('city').value + '</td><td>' +
                         document.getElementById('pinCode').value + '</td><td>' +
                         document.getElementById('states').value + '</td><td>' +
                         document.getElementById('partnerType').value + '</td><td>' +
                         document.getElementById('compGstn').value + '</td><td>' +
                         document.getElementById('addDetails').value + '</td><td> <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                 document.getElementById('state').value = "";
                document.getElementById('city').value = "";
                document.getElementById('pinCode').value = "";
                document.getElementById('states').value = "";
                $("#states").val('').trigger('change');
                document.getElementById('addDetails').value = "";
                document.getElementById('compGstn').value="";
                
            }

        });
        
        
        $("#addDocTypeButt").click(function() {
            $("#addDocTypeGrid").append('<tr class=""><td>' + document.getElementById('docType').value + '</td><td>' + document.getElementById('myfile').value + '</td><td><a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');
            document.getElementById('docType').value = "";
            document.getElementById('myfile').value = "";
        });

        $("#contactDetailsButt").click(function() {
            var abc = document.getElementById('conFname').value;
            var abc2 = document.getElementById('conLname').value;
            var abc3 = document.getElementById('conPhone').value;
            var abc4 = document.getElementById('conEmail').value;
            console.log("abc =>" + abc);
            if (abc == null || abc == "") {
                swal.fire("Alert", "First Name is mandatory !", "warning");
                return false;
            } else if (abc2 == null || abc2 == "") {
                swal.fire("Alert", "Last Name is mandatory !", "warning");
                return false;
            } else if (abc3 == null || abc3 == "") {
                swal.fire("Alert", "Phone Number is mandatory !", "warning");
                return false;
            } else if (abc4 == null || abc4 == "") {
                swal.fire("Alert", "Email Id is mandatory !", "warning");
                return false;
            } else {
                console.log("Coming Here");
                $("#contactDetailsGrid").append('<tr class=""><td>' +
                    document.getElementById('conFname').value + '</td><td>' +
                    document.getElementById('conLname').value + '</td><td>' +
                    document.getElementById('conPhone').value + '</td><td>' +
                    document.getElementById('conEmail').value + '</td><td> <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                document.getElementById('conFname').value = "";
                document.getElementById('conLname').value = "";
                document.getElementById('conPhone').value = "";
                document.getElementById('conEmail').value = "";
            }
        });

        $("#addBankGridButt").click(function() {
            var abc = document.getElementById('bankName').value;
            var abc5 = document.getElementById('beneficiaryName').value;
            var abc2 = document.getElementById('ifscCode').value;
            var abc3 = document.getElementById('accoutNumber').value;
            var abc4 = document.getElementById('confirmedAccoutNumber').value;
            console.log("abc =>" + abc);
            if (abc == null || abc == "") {
                swal.fire("Alert", "Bank Name is mandatory", "warning");
                return false;
            } else if (abc5 == null || abc5 == "") {
                swal.fire("Alert", "Beneficiary Name is mandatory", "warning");
                return false;
            } else if (abc2 == null || abc2 == "") {
                swal.fire("Alert", "IFSC Code is mandatory", "warning");
                return false;
            } else if (abc3 == null || abc3 == "") {
                swal.fire("Alert", " Account Number is mandatory", "warning");
                return false;
            }else if (abc4 == null || abc4 == "") {
                swal.fire("Alert", " Confirm Account Number is mandatory", "warning");
                return false;
            
            } else {
                $("#addBankGrid").append('<tr class=""><td>' +
                		document.getElementById('bankName').value + '</td><td>' +
                        document.getElementById('beneficiaryName').value + '</td><td>' +
                        document.getElementById('ifscCode').value + '</td><td>' +
                        document.getElementById('accoutCurrency').value + '</td><td>' +
                        document.getElementById('accoutNumber').value + '</td><td>' + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                document.getElementById('bankName').value = "";
                document.getElementById('beneficiaryName').value = "";
                document.getElementById('ifscCode').value = "";
                document.getElementById('accoutNumber').value = "";
                document.getElementById('confirmedAccoutNumber').value = "";
                document.getElementById('divCheckPasswordMatch').innerHTML = "";
            }
        });
        $body = $("body");

        $(document).on({
            ajaxStart: function() {
                $body.addClass("loading");
            },
            ajaxStop: function() {
                $body.removeClass("loading");
            }
        });

        function sendToServer() {
        	
       
        	var txtPANCard = document.getElementById("panNumber");
            var lblPANCard = document.getElementById("lblPANCard")
            var regex = /([A-Z]){5}([0-9]){4}([A-Z]){1}$/;
        	console.log("Inside Step One");
            var mandFields = "introducedByName,introducedByEmailID,suppName";
            var mandFieldsArr = mandFields.split(",");
            for (i = 0; i < mandFieldsArr.length; i++) {
                console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                if (document.getElementById(mandFieldsArr[i]).value == '') {
                    notifyTooltip(mandFieldsArr[i], "Mandatory Field", "top")
                    console.log("Mandatory Check :: " + mandFieldsArr[i]);
                    return false;
                }
            }
            
            var addressDetailsArray = [];
            var vendorType=[];
            var table = document.getElementById('addBookGrid');
            var rowLength = table.rows.length;

            for (var i = 1; i < rowLength; i += 1) {
                var row = table.rows[i];
                var objs = {
                		"addCountry": row.cells[0].innerHTML,
                        "state": row.cells[1].innerHTML,
                        "city": row.cells[2].innerHTML,
                        "pinCode": row.cells[3].innerHTML,
                        "vendorType": row.cells[4].innerHTML,
                        "partnerType": row.cells[5].innerHTML,
                        "compGstn": row.cells[6].innerHTML,
                        "addDetails": row.cells[7].innerHTML
                };
                addressDetailsArray.push(objs);
                vendorType.push(row.cells[4].innerHTML);
            }
            
            var vendorTypeString=vendorType.join(",");
            var partnerType=document.getElementById("partnerType").value
            
            if(addressDetailsArray.length==0 && partnerType!="Ad-Hoc"){
            
            	swal.fire("Alert", "please add addres....", "warning")
                return regex.test(inputvalues);
            }

            var accountDetailsArray = [];
            table = document.getElementById('addBankGrid');
            rowLength = table.rows.length;

            for (var i = 1; i < rowLength; i += 1) {
                var row = table.rows[i];

                var pushObj = {
                		"bankName": row.cells[0].innerHTML,
                        "beneficiaryName": row.cells[1].innerHTML,
                        "ifscCode": row.cells[2].innerHTML,
                        "accoutCurrency": row.cells[3].innerHTML,
                        "accoutNumber": row.cells[4].innerHTML,
                        "accoutName": row.cells[5].innerHTML,
                }
                accountDetailsArray.push(pushObj);
            }

            if(accountDetailsArray.length==0 && partnerType!="Ad-Hoc"){
            
            
            	swal.fire("Alert", "please add accountDetails", "warning")
                return regex.test(inputvalues);
            }
            
            
            var contactDetailsArray = [];
            table = document.getElementById('contactDetailsGrid');
            rowLength = table.rows.length;

            for (var i = 1; i < rowLength; i += 1) {
                var row = table.rows[i];

                var pushContactObj = {
                    "conFname": row.cells[0].innerHTML,
                    "conLname": row.cells[1].innerHTML,
                    "conPhone": row.cells[2].innerHTML,
                    "conEmail": row.cells[3].innerHTML
                }
                contactDetailsArray.push(pushContactObj);
            }
            
            
            if(contactDetailsArray.length==0 && partnerType!="Ad-Hoc"){
            	swal.fire("Alert", "please add contactDetails....", "warning")
            	
                return regex.test(inputvalues);
            }
            
            
            var itrDetailsArray = [];
            table = document.getElementById('addITRGrid');
            rowLength = table.rows.length;
            
            $body.addClass("loading");

            var step1Obj = FormDataToJSON('stepOneForm');
            
            step1Obj.id=id;
           
            
           
            
            var step6Obj = FormDataToJSON('stepSixForm');
            var step7Obj = FormDataToJSON('stepSevenForm');
            
          

            const finalObj = {
                ...step1Obj,
                ...step6Obj,
                ...step7Obj
            };
            finalObj.accountDetails = accountDetailsArray;
            finalObj.addressDetails = addressDetailsArray;
            finalObj.contactDetails = contactDetailsArray;
            finalObj.itrDetails = itrDetailsArray;

           
            console.log("finalObj"+finalObj);
           
            
            if (document.getElementById("GSTFile").files.length > 0) {
                finalObj.gstFileName = document.getElementById("GSTFile").files.item(0).name;
                finalObj.gstFileText = $("#GSTFileText").val();
            }
            if (document.getElementById("PDFile").files.length > 0) {
                finalObj.pdFileName = document.getElementById("PDFile").files.item(0).name;
                finalObj.pdFileText = $("#PDFileText").val();
            }
            if(document.getElementById("PANFile").files.length>0){
				finalObj.pANFileName = document.getElementById("PANFile").files.item(0).name;
				finalObj.pANFileText = $("#PANFileText").val();
            }
            if (document.getElementById("CCFile").files.length > 0) {
                finalObj.ccFileName = document.getElementById("CCFile").files.item(0).name;
                finalObj.ccFileText = $("#CCFileText").val();
            }
            if (document.getElementById("ACFile").files.length > 0) {
                finalObj.acFileName = document.getElementById("ACFile").files.item(0).name;
                finalObj.acFileText = $("#ACFileText").val();
            }
            if (document.getElementById("APLFile").files.length > 0) {
                finalObj.aplFileName = document.getElementById("APLFile").files.item(0).name;
                finalObj.aplFileText = $("#APLFileText").val();
            }
            if (document.getElementById("ITRFile").files.length > 0) {
                finalObj.itrFileName = document.getElementById("ITRFile").files.item(0).name;
                finalObj.itrFileText = $("#ITRFileText").val();
            }
            if (document.getElementById("FUVFFile").files.length > 0) {
                finalObj.fuvfFileName = document.getElementById("FUVFFile").files.item(0).name;
                finalObj.fuvfFileText = $("#FUVFFileText").val();
            }
            if (document.getElementById("MSMECFile").files.length > 0) {
                finalObj.msmecFileName = document.getElementById("MSMECFile").files.item(0).name;
                finalObj.msmecFileText = $("#MSMECFileText").val();
            }
            if (document.getElementById("AMFile").files.length > 0) {
                finalObj.amFileName = document.getElementById("AMFile").files.item(0).name;
                finalObj.amFileText = $("#AMFileText").val();
            }

            if (document.getElementById("ITRFile1").files.length > 0) {
                finalObj.itraFileName1 = document.getElementById("ITRFile1").files.item(0).name;
                finalObj.itraFileText1 = $("#ITRFileText1").val();
            }
            if (document.getElementById("ITRFile2").files.length > 0) {
                finalObj.itraFileName2 = document.getElementById("ITRFile2").files.item(0).name;
                finalObj.itraFileText2 = $("#ITRFileText2").val();
            }
            if (document.getElementById("ITRFile3").files.length > 0) {
                finalObj.itraFileName3 = document.getElementById("ITRFile3").files.item(0).name;
                finalObj.itraFileText3 = $("#ITRFileText3").val();
            }
            if (document.getElementById("NMISFile").files.length > 0) {
                finalObj.nmisFileName = document.getElementById("NMISFile").files.item(0).name;
                finalObj.nmisFileText = $("#NMISFileText").val();
            }
            
           
            var checked = []
            
             checked=document.getElementById("roleId").value
           
            var values= document.getElementById("roleId").value ;
            console.log("value vendorType : "+values);
            finalObj.vendorType = values;
            
       
            
            var value =[];
            $("#region :selected").each(function(){
           	 value.push($(this).val()); 
            });
            if(value.includes("CRO") || value.includes("ERO")){//ERO
           	 finalObj.ero="Y";
           	 
            } if(value.includes("WRO")){
           	 finalObj.wro="Y";
            } if(value.includes("NRO")){
           	 finalObj.nro="Y";
            } if(value.includes("SRO1") || value.includes("SRO2")){//SRO
           	 finalObj.sro="Y";
            } if(value.includes("IHQ") ){
           	 finalObj.ihq="Y";
            }
            
            
            var value1 =[];
            $("#flag :selected").each(function(){
           	 value.push($(this).val()); 
            });
            if(value.includes("ADDRESS_PURCHASING")){
           	 finalObj.addressPurchasingFlag="Y";
           	 
            } if(value.includes("ADDRESS_PAYMENT")){
           	 finalObj.addressPaymentFlag="Y";
            } if(value.includes("INVOICE_PREVALIDATED")){
           	 finalObj.invoicePrevalidatedFlag="Y";
            }
            
            
            var val = document.getElementById("states").value
				if(val.toLowerCase()=="network"){
					finalObj.glCode="203101";
				}else if(val.toLowerCase()=="other expenses"){
					finalObj.glCode="203104";
				}else if(val.toLowerCase()=="rent"){
					finalObj.glCode="203102";
				}else if(val.toLowerCase()=="fixed assets"){
					finalObj.glCode="203105";
				}else if(val.toLowerCase()=="courier"){
					finalObj.glCode="203103";
				}else if(val.toLowerCase()=="employee nominee"){
					finalObj.glCode="203108";
				}
				
          	var acknowledgementNumber1= $('#acknowledgementNumber1').val();
          	var acknowledgementNumber2= $('#acknowledgementNumber2').val();
          	var acknowledgementNumber3= $('#acknowledgementNumber3').val();
       		
          	var fyYear1= $('#fyYear1').val();
          	var fyYear2= $('#fyYear2').val();
          	var fyYear3= $('#fyYear3').val();
          	
          	finalObj.fyYear1=fyYear1;
          	finalObj.fyYear2=fyYear2;
          	finalObj.fyYear3=fyYear3;
          	
          	finalObj.acknowledgementNumber1=acknowledgementNumber1;
          	finalObj.acknowledgementNumber2=acknowledgementNumber2;
          	finalObj.acknowledgementNumber3=acknowledgementNumber3;
          	finalObj.vendorType=vendorTypeString;
            
            console.log("finalObj",finalObj.vendorType);
        
            $('.loader').show();
           
            $.ajax({
                type: "POST",
                data: JSON.stringify(finalObj),
                url: "ajaxController/SaveRegistration",
                dataType: "json",
                contentType: "application/json",
                success: function(response) {
                	$('.loader').hide();
                    if (response.msg == 'success') {
                    	
                        swal.fire("Thanks", "Vendor Update  Sucessfully", "success", "OK").then(function() {
                            window.location = "vendorDetails";
                        });


                        setTimeout(function(response) {
                            //location.href = "login";
                        }, 1000000);
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

        if (window.File && window.FileReader && window.FileList && window.Blob) {
            /* document.getElementById('CICFile').addEventListener('change', handleFileSelect, false);
            document.getElementById('GSTFile').addEventListener('change', handleFileSelect, false);
            document.getElementById('TDSFile').addEventListener('change', handleFileSelect, false);
            document.getElementById('PANFile').addEventListener('change', handleFileSelect, false);
            document.getElementById('CCFile').addEventListener('change', handleFileSelect, false); */
        } else {
            alert('The File APIs are not fully supported in this browser.');
        }

        
        function showHideRequiredClass() {
            if ($("#partnerType").val() == "Scheduled") {
                $(".required").css("visibility", "visible");
                $("#updateBtn").attr("disabled", true);
            }  else {
                $(".required").css("visibility", "hidden");
                $(".adHocRequired").css("visibility", "visible");
                $("#updateBtn").attr("disabled", false);
            } 
        } 

        
   
        
        function removeValCssByID(controlName) {
            $('#' + controlName.id).css({
                'border': '1px solid #b7b7b7',
                'box-shadow': 'none',
                '-webkit-box-shadow': 'none'
            });
        }
        
       
        
        function notifyTooltip(controlName, tooltipMessage, tooltipPlacement) {
            try {
                if (controlName != null && controlName != '' && tooltipMessage != null && tooltipMessage != '' && tooltipPlacement != null && tooltipPlacement != '') {

                   /* $("#" + controlName).notify(
                        tooltipMessage, {
                            autoHideDelay: 3500,
                            position: tooltipPlacement
                        }
                    );*/
                    $('#manPara').css('display', '');
                    addValCss(controlName);
                    $("#" + controlName).focus();
                } else {
                    console.log('Values Are Passed As Empty Or Null In notifyTooltip()');
                }
            } catch (err) {

            }
        }

        $("#panNumber").change(function() {
            var inputvalues = $(this).val();
            var regex = /[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
            if (!regex.test(inputvalues)) {
                $("#panNumber").val("");
                swal.fire("","Invalid PAN Number", "warning");
                return regex.test(inputvalues);
            }
        });
        $("#tanNumber").change(function() {
            var inputvalues = $(this).val();
            var regex = /[A-Za-z]{4}[0-9]{5}[A-Za-z]{1}/;
            if (!regex.test(inputvalues)) {
                $("#tanNumber").val("");
                swal.fire("","Invalid TAN Number", "warning");
                return regex.test(inputvalues);
            }
        });
        $("#phoneNumber").change(function() {
            var inputvalues = $(this).val();
            var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
            if (!regex.test(inputvalues)) {
                $("#phoneNumber").val("");
                swal.fire("","Invalid Phone Number", "warning");
                return regex.test(inputvalues);
            }
        });
        
        $("#conPhone").change(function() {
            var inputvalues = $(this).val();
            var regex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
            if (!regex.test(inputvalues)) {
                $("#conPhone").val("");
                swal.fire("","Invalid Phone Number", "warning");
                return regex.test(inputvalues);
            }
        });
        
        $("#suppName").keypress(function(event){
        	var inputValue = event.which;
            //alert(inputValue);
           if( !(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0) && !(inputValue >= 37 && inputValue <= 47) ) { 
                event.preventDefault(); 
            } 
           //event.preventDefault();
        }); 

       
       $("#city").keypress(function(event){
         	var inputValue = event.which;
             //alert(inputValue);
             if(inputValue==8){
                 
             }else if(!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) { 
                 event.preventDefault(); 
             }
         });
        
       
       $(document).ready(function() {
           $("#ifscCode").change(function() {
               var inputvalues = $(this).val();
               var regex = /^[A-Z]{4}0[A-Z0-9]{6}$/;
               if (!regex.test(inputvalues)) {
                   $("#ifscCode").val("");

                   swal.fire("Alert", "Invalid IFSC Code", "warning");
                   return regex.test(inputvalues);
               }
           });
       });
      
       
       $("#conFname").keypress(function(event){
          	var inputValue = event.which;
              //alert(inputValue);
              if(inputValue==8){
                  
              }else if(!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) { 
                  event.preventDefault(); 
              }
          });
         
       
       $(function() {
           $('#conLname').on('keypress', function(e) {
               if (e.which == 32){
                   console.log('Space Detected');
                   return false;
               }
           });
   });
       
       
       $("#conLname").keypress(function(event){
       	var inputValue = event.which;
           //alert(inputValue);
           if(inputValue==8){
               
           }else if(!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) { 
               event.preventDefault(); 
           }
       });
      
 
        $("#bankName").keypress(function(event){
        	var inputValue = event.which;
            //alert(inputValue);
            if(inputValue==8){
                
            }else if(!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0)) { 
                event.preventDefault(); 
            }
        });
        var matchFlag=0;
        $(function() {
            $("#confirmedAccoutNumber").keyup(function() {
                var password = $("#accoutNumber").val();
                var passwordConfirm = $("#confirmedAccoutNumber").val();
                var passflag = $("#passflag").val();
                
                if(password!="" && passwordConfirm!=""){
                 if ($('#accoutNumber').val() == $('#confirmedAccoutNumber').val() && passflag!="1" ) {
        		    $('#divCheckPasswordMatch').html('Account number match.').css('color', 'green');
        		    // Enable #x	
        		    $("#addBankGridButt").prop("disabled", false)
        		    
        		  } 
                 else {
                	 
        		    $('#divCheckPasswordMatch').html('Account number do not match!').css('color', 'red');
        		    matchFlag=1;
        		    
             // Disable #x
    		    $('#addBankGridButt').attr('disabled', true);
             
                return;
                	 
        		  }
                }
                 
            });
        }); 
        
        $(function() {
            $("#accoutNumber").keyup(function() {
                var password = $("#accoutNumber").val();
                var passwordConfirm = $("#confirmedAccoutNumber").val();
                var passflag = $("#passflag").val();
                
                if(password!="" || passwordConfirm!=""){
                 if ($('#accoutNumber').val() == $('#confirmedAccoutNumber').val() && passflag!="1" ) {
        		    $('#divCheckPasswordMatch').html('Account number match.').css('color', 'green');
        		    // Enable #x	
        		    $("#addBankGridButt").prop("disabled", false)
        		    
        		  } 
                 else {
                	 if(matchFlag==1){
        		    $('#divCheckPasswordMatch').html('Account number does not match!').css('color', 'red');
             // Disable #x
    		    $('#addBankGridButt').attr('disabled', true);
           
                return;
                	 }
        		  }
                }
            });
        }); 
        $(document).ready(function() {
            $("#accoutNumber").change(function() {
            	var accoutNumber = document.getElementById("accoutNumber").value;
                var a = /^\d{1}$/;
                var b = /^\d{2}$/;
                var c  = /^\d{3}$/;
                if (accoutNumber != '') {
                    if (accoutNumber.match(a) || accoutNumber.match(b) || accoutNumber.match(c)) {
                   	 swal.fire(""," Invalid Account Number", "warning");
                        $("#accoutNumber").val('');
                        $("#confirmedAccoutNumber").val('');
                        $("#accoutNumber").focus();
                    }else {
                    	
                        return true;
                    }
                }
            });
        });
        
        
        $(document).ready(function() {
            $("#compGstn").change(function() {
                var inputvalues = $(this).val();
                var regex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;
                if (!regex.test(inputvalues)) {
                    $("#compGstn").val("");

                    swal.fire("Alert", "Invalid GSTIN Number", "warning");
                    return regex.test(inputvalues);
                }
            });
        });
       
        $(document).ready(function() {
            $("#aadharNumber").change(function() {
            	var aadhar = document.getElementById("aadharNumber").value;
                var adharcardTwelveDigit = /^\d{12}$/;
                var adharSixteenDigit = /^\d{16}$/;
                if (aadhar != '') {
                    if (aadhar.match(adharcardTwelveDigit)) {
                        return true;
                    } else if (aadhar.match(adharSixteenDigit)) {
                        return true;
                    } else {
                    	swal.fire(""," Invalid Aadhar Number", "warning");
                        $("#aadharNumber").val('');
                        $("#aadharNumber").focus();
                        return false;
                    }
                }
            });
        });

        
        function inactiveActiveDeleteData(bpcode,name) {
      
        	 let text="Are You sure to delete "+name;
        	 if (confirm(text) != true) {
        		 
        		    
        		    return false;
        		  } 
        	 
        	 
        	
            var json = {
                "bpCode": bpcode,
                "status": "0"
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.setStatusOfVendorByBpCode%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {

                    	
                        Toast.fire({
                            type: 'success',
                            title: 'Deleted Successfully..'
                        })


                        getData();
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

        function select(){
			
			var element = document.getElementById('states');
        	var element=[...element.options].filter(ele => ele.selected).map(ele => ele.text);
        	var selectedValues = [];    
            $("#states :selected").each(function(){
                selectedValues.push($(this).val()); 
            });
            
            let values = selectedValues.toString();
         
        	document.getElementById("roleId").value=values;
			
			var val = document.getElementById("states").value
			if (val == "Network") {
				document.getElementById("partnerType").disabled = false;
				document.getElementById("partnerType").value = "Scheduled";
			}else{
				document.getElementById("partnerType").disabled = true;
				document.getElementById("partnerType").value = "";
			}
		}
     function MESMENumber(){
    	 var busClassif=$("#businessClassification").val();
    	 if (busClassif != "Other") {
    		 document.getElementById("mesmeNumber").disabled = false;
    	 }else{
    		 document.getElementById("mesmeNumber").disabled = true;
    		 document.getElementById("mesmeNumber").value = "";
    	 }
     }
     function region1(){

     }
    </script>
</body>
</html>
