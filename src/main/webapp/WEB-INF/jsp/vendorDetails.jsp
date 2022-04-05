<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Users</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bbootstrap 4 -->
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <!-- <link rel="stylesheet" href="plugins/summernote/summernote-bs4.css"> -->

    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- <link rel="stylesheet" type="text/css" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-buttons/css/buttons.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-select/css/select.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-fixedheader/css/fixedHeader.bootstrap4.css"> -->
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">


    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">



<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
        
        
        



	<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

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

        .table td,
        .table th {
            vertical-align: top;
            border-top: 1px solid #dee2e6;
            padding: 5px 5px 0px 1.5rem;
        }
        
        
        
        .select2{
				width: 100% !important;
			}
			
			
			 .PAN
		    {
		        text-transform: uppercase;
		  }
		    .error
		    {
		        color: Red;
		        visibility: hidden;
		  }


    </style>

    <style>
    
     .required {
            color: red;
        }
    
        /* changing select2 color  */
       /*  .select2-container--default .select2-purple .select2-selection--multiple .select2-selection__choice,
        .select2-purple .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #006fe6;
            border-color: #006fe6;
            color: #fff;
        }

        .select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected],
        .select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected]:hover,
        .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected],
        .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected]:hover {
            background-color: #006fe6;
            color: #fff;
        } */

    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <jsp:include page="loader.jsp" />
    <div class="wrapper">

        <!-- Navbar -->
        <jsp:include page="navbar.jsp?pagename=Users" />
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <jsp:include page="sidebar_Admin.jsp?pagename=addUsers" />

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <div class="input-group-prepend">

                                <!--   <div class="btn-group">
                                    <div  style="font-size: 20px;font-weight: 500;" id="shiowStatusOfTicket">Master Bank Name</div>
                                </div> -->


                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <!-- <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Dashboard v1</li> -->
                            </ol>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- general form elements -->
                            <div class="card card-primary">
                                
                                <!-- /.card-header -->
                                <!-- form start -->
                                
                                
                                
                                
                                
                              </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Vendor Details</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body">
                                    <table id="tabledata" class="table table-bordered table-hover">
                                        <thead>
                                                           <tr>
                                                           		<!-- <th >Sr.No</th> -->
                                                           		<th>Vendor code</th>
                                                           		<th>Introduced By Name </th>
                                                           		<th>Business Partner Name</th>
                                                                <th>Company Email ID</th>
                                                                <th>introduced by email id</th>
                                                                <th>GSTN Number</th>
                                                                <th>Nature of transactions</th>
                                                                
                                                                <th>Business Partner Type</th>
                                                                <th>Business Partner</th>
                                                                <th>Phone Number</th>
                                                         
                                                           </tr>
                                                     </thead>
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>

                        </div>
                    </div>


                </div>
            </section>
        </div>

        <aside class="control-sidebar control-sidebar-dark"></aside>
    </div>
    <!-- ./wrapper -->

 
<!-- <script type = "text/javascript">  
window.onload = function(){  
	
	alert("hii")
	select();
}  
</script> -->


    <div class="modal fade" id="userModal" role="dialog">
        <div class="modal-dialog " style="max-width: 1800px;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- general form elements -->
                            <div class="card card-primary">
                                <!-- <div class="card-header">
                                    <h3 class="card-title">Update User</h3>
                                </div> -->




				<div class="card card-primary" style="margin-bottom: 10px;">
							<div class="card-header" id="addressBookHead"
								style="background: #11aef6; color: #ffffff;">
								<h6 class="mb-0">Basic Details</h6>
							</div>
						<div id="basicDetailsHeadData" aria-labelledby="basicDetailsHead"
								style="border-style: solid; border-width: 1px; border-color: #11aef6;">
                               <form role="form" id="stepOneForm" class="forms-sample" style="padding: 20px;" autocomplete="off" >
									<table class="table center-aligned-table" id="fromTable" name="fromTable">
										<thead>
										</thead>
										<tbody>
											<tr class="">

												
												
												<td><label for="name">Introduced By Name<span
														class="required adHocRequired">*</span></label></td>
												<td colspan='1'>
												
												 <input type="hidden" id ="bpCode" name="bpCode" /> 
												
												<input type="text"
													class="form-control p-input" id="introducedByName"
													name="introducedByName" placeholder="Reference Name"
													onchange="removeValCssByID(this)" required></td>

												<td><label for="emailId">Introduced By Email ID<span
														class="required adHocRequired">*</span></label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="introducedByEmailID"
													name="introducedByEmailID" placeholder="abc@ecomexpress.in"
													onchange="removeValCssByID(this)"><span
													id="message"></span></td>

											</tr>
											
											
											<tr>

												<td><label>Business Partner Type<span
														class="required adHocRequired">*</span></label></td>
												
												<td style="width: auto">
												<select class="js-example-basic-multiple select2"  name="states[]" style="color: red;" id="states" value="Network" onchange="select()" multiple="multiple" >
												<option    value="Network">&emsp;&emsp;Network</option>
												<option  value="Fixed Asset">&emsp;&emsp;Fixed Asset</option>
												<option   value="Other">&emsp;&emsp;Other</option>
												</select>
													
												</td>
												
												
												
												<td><label for="partnerType">Business Partner</label></td>
												<td><select id="partnerType" name="partnerType"
													class="form-control p-input"
													onchange="showHideRequiredClass();" disabled="disabled">
														<option id="scheduled" value="Scheduled">Scheduled</option>
														<option id="adHoc" value="Ad-Hoc">Ad-Hoc(Need
															Basic)</option>
												</select></td>
												<input type="hidden" id="roleId" />
											</tr>



											<script>
											
											function select(){
												 
												
												var element = document.getElementById('states');
									        	var element=[...element.options].filter(ele => ele.selected).map(ele => ele.text);
									        	var selectedValues = [];    
									            $("#states :selected").each(function(){
									                selectedValues.push($(this).val()); 
									            });
									            //alert(selectedValues);
									            
									            let values = selectedValues.toString();
									         
									        	document.getElementById("roleId").value=values;
									        	//alert("roleId111: "+num);
												
									        
												
												var val = document.getElementById("states").value
												if (val == "Network") {
													document.getElementById("partnerType").disabled = false;
													if(document.getElementById("partnerType").value == ''){
													document.getElementById("partnerType").value = "Scheduled";
													}
												}else{
													document.getElementById("partnerType").disabled = true;
													document.getElementById("partnerType").value = "";
													
												}
												
											}
											</script>



											<tr class="">
												<td><label for="suppName">Business Partner Name<span
														class="required adHocRequired">*</span></label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="suppName" name="suppName"
													placeholder="Name(As per Cheque/Passbook)"
													onchange="removeValCssByID(this)"></td>

												<td><label for="compEmail">Company Email ID<span
														class="required adHocRequired">*</span></label></td>
												<td colspan='1'><input type="email"
													class="form-control p-input email" id="compEmail"
													name="compEmail" placeholder="Company Mail ID"
													onchange="removeValCssByID(this);" required></td>

												<td><label for="phoneNumber">Phone Number</label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="phoneNumber"
													name="phoneNumber" placeholder="Phone Number"
													maxlength="10"
													onkeyup=" return validatephone(this.value); "
													onchange="removeValCssByID(this)"><span
													id="message"></span></td>
											</tr>

											<tr class="">
												<td><label for="aadharNumber">Aadhar Number</label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="aadharNumber"
													name="aadharNumber" placeholder="Aadhar Number"
													onblur="AadharValidate();"></td>

												<td><label for="panNumber">Pan Number<span
														class="required adHocRequired">*</span></label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="panNumber"
													name="panNumber" placeholder="Pan Number"oninput="this.value = this.value.toUpperCase()">
													<span id="lblPANCard" class="error">Invalid PAN Number</span>
													</td>

												<td><label for="tanNumber">TAN Number</label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="tanNumber"
													name="tanNumber" placeholder="TAN Number"></td>
											</tr>

											<tr>
												<td><label for="adharLinkStatus">Aadhar Link
														Status</label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="adharLinkStatus"
													name="adharLinkStatus" placeholder="Aadhar Link Status"></td>

												<td><label for="compGstn">GSTN Number</label></td>
												<td colspan='1'><input type="test"
													class="form-control p-input gst" id="compGstn"
													name="compGstn" placeholder="GSTN Number"></td>

												<td><label for="natureOfTransactions">Nature of
														transactions<span class="required adHocRequired">*</span>
												</label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="natureOfTransactions"
													name="natureOfTransactions"
													placeholder="Nature of transactions"
													onchange="removeValCssByID(this)"></td>
											</tr>

											<tr>

												<td><label for="businessClassification">Business
														Classification</label></td>
												<td colspan='1'><input type="text"
													class="form-control p-input" id="businessClassification"
													name="businessClassification"
													placeholder="Business Classification"
													onchange="removeValCssByID(this)"></td>

												<!-- <td><label for="siteDff">SITE DFF</label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="siteDff" name="siteDff" placeholder="SITE DFF"></td>

                                                <td><label for="opeUnitReqMap">Operating Unit
                                                        required to MAP<span class="required adHocRequired">*</span></label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="opeUnitReqMap" name="opeUnitReqMap" placeholder="Operating Unit required to MAP" onchange="removeValCssByID(this)"></td> -->

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
											id="fromTable" name="fromTable">

											<tbody>
												<tr class="">
													<td><label class="addressLable" for="country">Country<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><select id="addCountry"
														name="addCountry" class="form-control p-input">
															<option id="india" name="india" value="India">India</option>
													</select></td>

													<td><label class="addressLable">State<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><select name="state" id="state"
														class="form-control p-input">
															<option value="Andhra Pradesh">Andhra Pradesh</option>
															<option value="Andaman and Nicobar Islands">Andaman
																and Nicobar Islands</option>
															<option value="Arunachal Pradesh">Arunachal
																Pradesh</option>
															<option value="Assam">Assam</option>
															<option value="Bihar">Bihar</option>
															<option value="Chandigarh">Chandigarh</option>
															<option value="Chhattisgarh">Chhattisgarh</option>
															<option value="Dadar and Nagar Haveli">Dadar and
																Nagar Haveli</option>
															<option value="Daman and Diu">Daman and Diu</option>
															<option value="Delhi">Delhi</option>
															<option value="Lakshadweep">Lakshadweep</option>
															<option value="Puducherry">Puducherry</option>
															<option value="Goa">Goa</option>
															<option value="Gujarat">Gujarat</option>
															<option value="Haryana">Haryana</option>
															<option value="Himachal Pradesh">Himachal
																Pradesh</option>
															<option value="Jammu and Kashmir">Jammu and
																Kashmir</option>
															<option value="Jharkhand">Jharkhand</option>
															<option value="Karnataka">Karnataka</option>
															<option value="Kerala">Kerala</option>
															<option value="Madhya Pradesh">Madhya Pradesh</option>
															<option value="Maharashtra">Maharashtra</option>
															<option value="Manipur">Manipur</option>
															<option value="Meghalaya">Meghalaya</option>
															<option value="Mizoram">Mizoram</option>
															<option value="Nagaland">Nagaland</option>
															<option value="Odisha">Odisha</option>
															<option value="Punjab">Punjab</option>
															<option value="Rajasthan">Rajasthan</option>
															<option value="Sikkim">Sikkim</option>
															<option value="Tamil Nadu">Tamil Nadu</option>
															<option value="Telangana">Telangana</option>
															<option value="Tripura">Tripura</option>
															<option value="Uttar Pradesh">Uttar Pradesh</option>
															<option value="Uttarakhand">Uttarakhand</option>
															<option value="West Bengal">West Bengal</option>
													</select> <!-- <input type="text"
														class="form-control p-input" id="state" name="state"
														placeholder="State"> --></td>
													<td><label class="addressLable">City<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="city" name="city"
														placeholder="city"></td>
												</tr>
												<tr class="">


													<td><label>Postal Code/ ZIP Code<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="pinCode" name="pinCode"
														onkeypress="return event.charCode >= 48 && event.charCode <= 57"
														placeholder="Postal Code/ ZIP Code" maxlength="6"></td>

													<td><label for="addressDetails">Address
															Details<span class="required adHocRequired">*</span>
													</label></td>
													<td colspan='2'><textarea class="form-control"
															id="addDetails" name="addDetails"
															placeholder="Complete Address" rows="3"></textarea></td>
													<td style="width: 150px;"></td>
													<td colspan='3'><button type="Button"
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
												<table class="table center-aligned-table" id="addBookGrid"
													name="addBookGrid">
													<thead>
														<tr style="background: #1991eb; color: white;">
															<th>Country</th>
															<th>State</th>
															<th>City</th>
															<th>Postal Code/ ZIP Code</th>
															<th>Address Details</th>
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
									<form id="Form-3" class="forms-sample">
										<table class="table center-aligned-table" id="fromTable"
											name="fromTable">
											<thead>
											</thead>
											<tbody>
												<tr class="">
													<td><label for="fnameCon">First Name<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="conFname" name="conFname"
														placeholder="First Name"></td>

													<td><label for="lnameCon">Last Name<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="conLname" name="conLname"
														placeholder="Last Name"></td>

													<td><label for="phno">Phone Number<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="conPhone"
														onkeypress="return event.charCode >= 48 && event.charCode <= 57"
														name="conPhone" placeholder="Phone Number" maxlength="10"></td>
												<tr>
												<tr class="">


													<td><label for="emailId">Email<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="conEmail" name="conEmail"
														placeholder="Email"></td>
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
															<th>Email</th>
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
						</div>
					</div>
					
								
					<div id="step-3" class="">
						<div class="card" style="margin-bottom: 10px;">
							<div class="card-header" id="addressBookHead"
								style="background: #1991eb; color: #ffffff;">
								<h6 class="mb-0">Bank Details</h6>
							</div>
							<div id="addressBookHeadData" aria-labelledby="addressBookHead"
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
													<td colspan='2'><input type="email"
														class="form-control p-input" id="bankName" name="bankName"
														placeholder="Bank Name"></td>

													<td><label for="ifscCode">RTGS/ IFSC Code<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="ifscCode" name="ifscCode"
														placeholder="RTGS/ IFSC Code"></td>


													<td><label for="accoutNumber">Account Number<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="accoutNumber"
														onkeypress="return event.charCode >= 48 && event.charCode <= 57"
														name="accoutNumber" placeholder="Account Number"></td>

												</tr>
												<tr class="">
													<td><label for="accoutCurrency">Currency<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><select id="accoutCurrency"
														name="accoutCurrency" class="form-control p-input">
															<option value="INR">INR</option>
															<option value="USD">USD</option>
															<option value="KES">KES</option>
													</select></td>
													<td></td>
													<td colspan='3'>
														<button type="Button" id="addBankGridButt"
															name="addBankGridButt" class="btn btn-primary">Add
															Account Details</button>
													</td>
												</tr>

											</tbody>
										</table>
										<div class="card-body">
											<div class="table-responsive"
												style="border-style: solid; border-width: 1px; border-color: #1991eb;">
												<table class="table center-aligned-table" id="addBankGrid"
													name="addBankGrid">
													<thead>
														<tr style="background: #1991eb; color: white;">
															<th>Bank Name</th>
															<th>RTGS/ IFSC Code</th>
															<th>Currency</th>
															<th>Account Number</th>
															<th></th>
															<th>Action</th>
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

						<div class="card" style="margin-bottom: 10px;">
							<div class="card-header" id="addressBookHead"
								style="background: #1991eb; color: #ffffff;">
								<h6 class="mb-0">Invoice Payment Terms</h6>
							</div>
							<div id="addressBookHeadData" aria-labelledby="addressBookHead"
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
													<td colspan='2'><select id="invoiceCurrency"
														name="invoiceCurrency" class="form-control p-input">
															<option value="INR">INR</option>
															<option value="USD">USD</option>
															<option value="KES">KES</option>
													</select></td>

													<td><label for="paymentCurrency">Payment
															Currency<span class="required adHocRequired">*</span>
													</label></td>
													<td colspan='2'><select id="paymentCurrency"
														name="paymentCurrency" class="form-control p-input">
															<option value="INR">INR</option>
															<option value="USD">USD</option>
															<option value="KES">KES</option>
													</select></td>

													<td><label for="creditTerms">Payment / Credit
															Terms<span class="required adHocRequired">*</span>
													</label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="creditTerms"
														name="creditTerms" onchange="removeValCssByID(this)"
														placeholder="Payment / Credit Terms"></td>
												</tr>
												<tr class="">
													<td><label for="paymentMethod">Payment Method<span
															class="required adHocRequired">*</span></label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="paymentMethod"
														name="paymentMethod" onchange="removeValCssByID(this)"
														placeholder="Payment Method"></td>

													<td><label for="dateBasis">Terms Date Basis</label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="dateBasis"
														name="dateBasis" placeholder="Terms Date Basis"></td>
													<td><label for="deliveryTerms">Delivery Terms</label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="deliveryTerms"
														name="deliveryTerms" placeholder="Delivery Terms"></td>


												</tr>

											</tbody>
										</table>

									</form>
								</div>
							</div>
						</div>

				</div>	




								<div id="step-4" class="">
						<div class="card" style="margin-bottom: 0px;">

							<!-- Start -->

							<div class="card" style="margin-bottom: 10px;">
								<div class="card-header" id="addressBookHead"
									style="background: #1991eb; color: #ffffff;">
									<h6 class="mb-0">TDS Details</h6>
								</div>
								<div id="addressBookHeadData" aria-labelledby="addressBookHead"
									style="border-style: solid; border-width: 1px; border-color: #1991eb;">
									<div class="card-body" style="margin-bottom: 10px;">
										<form id="stepSevenForm" class="forms-sample">
											<table class="table center-aligned-table" id="fromTable"
												name="fromTable">
												<thead>
												</thead>
												<tbody>
													<tr class="">
														<td><label class="addressLable" for="tdsApplication">TDS
																Applicable<span
															class="required adHocRequired">*</span></label></td>
														<td colspan='2'><select id="tdsApplication"
															name="tdsApplication" onchange="changetextbox();"
															class="form-control p-input ">
																<option value="Yes">Yes</option>
																<!-- <option value="No">No</option> -->
														</select></td>

														<td><label class="addressLable" for="tdsSection">TDS
																Section<span
															class="required adHocRequired">*</span></label></td>
														<td colspan='2'><input type="text"
															class="form-control p-input" id="tdsSection"
															name="tdsSection" placeholder="TDS Section" onchange="removeValCssByID(this)"></td>

														<td><label for="tdsRate">TDS Exemption Rate
																(If Any)<span
															class="required adHocRequired">*</span></label></td>
														<td colspan='2'><input type="text"
															class="form-control p-input" id="tdsRate" name="tdsRate"
															placeholder="TDS  Exemption Rate" onchange="removeValCssByID(this)"></td>
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
											<table class="table center-aligned-table" id="fromTable"
												name="fromTable">
												<thead>
												</thead>
												<tbody>
													<tr>
														<td><label class="addressLable" for="tdsApplication">Financial
																Year</label></td>
														<td colspan='2'><select id="fyYear"
															class="form-control p-input ">
																<option value="2018-19">2018-19</option>
																<option value="2019-20">2019-20</option>
																<option value="2020-21">2020-21</option>
																<option value="2021-22">2021-22</option>

														</select></td>
														<td style="width: 150px;"></td>
														<td><label for="tdsApplication">Acknowledgement
																Number</label></td>

														<td colspan='2'><input type="text"
															id="acknowledgementNumber" name="acknowledgementNumber"
															class="form-control p-input "></td>
														<td style="width: 150px;"></td>
														<td colspan='2'>
															<button type="Button" id="addITRGridButt"
																name="addITRGridButt" class="btn btn-primary">Add
																ITR Details</button>
														</td>

													</tr>
												</tbody>
											</table>
											<div class="card-body">
												<div class="table-responsive"
													style="border-style: solid; border-width: 1px; border-color: #1991eb;">
													<table class="table center-aligned-table" id="addITRGrid"
														name="addITRGrid">
														<thead>
															<tr style="background: #1991eb; color: white;">
																<th>Financial Year</th>
																<th>Acknowledgement Number</th>
																<th>Action</th>

															</tr>
														</thead>
														<tbody>
														</tbody>
													</table>



												</div>
											</div>
										</form>
									</div>
								
							

							<!-- End -->

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
													id="addDocTypeGrid" name="addDocTypeGrid">

													<tbody>
														<tr>
															<td><label>GST Certificate<span
																	class="required">*</span></label></td>
															<td><input type="file" id="GSTFile" name="GSTFile"
																onchange=" removeValCssByID(this),  handleFileSelect(event,'GSTFileText'), onValidateFile('GSTFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt" >Doc view</button>
																
																<textarea id="GSTFileText" rows="5"
																	style="display: none;"></textarea>
																	
																	</td>
																
															<td><label>Proprietorship declaration<span
																	class="required">*</span></label></td>
															<td><input type="file" id="PDFile" name="PDFile"
																onchange=" removeValCssByID(this),  handleFileSelect(event,'PDFileText'), onValidateFile('PDFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
															
															
																<textarea id="PDFileText" rows="5"
																	style="display: none;"></textarea>
																	
																	
														</tr>

														<tr>
															<td><label>PAN Card<span class="required">*</span></label></td>
															<td><input type="file" id="PANFile" name="PANFile"
																onchange="handleFileSelect(event,'PANFileText'), onValidateFile('PANFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																<textarea id="PANFileText" rows="5"
																	style="display: none;"></textarea></td>

															<td><label>Cancelled Cheque/ Passbook/ Bank
																	Statement<span class="required">*</span>
															</label></td>
															<td><input type="file" id="CCFile" name="CCFile"
																onchange="handleFileSelect(event,'CCFileText'), onValidateFile('CCFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
															
																<textarea id="CCFileText" rows="5"
																	style="display: none;"></textarea></td>
														</tr>
														<tr>
															<td><label>Aadhar Card</label></td>
															<td><input type="file" id="ACFile" name="ACFile"
																onchange="handleFileSelect(event,'ACFileText'), onValidateFile('ACFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="ACFileText" rows="5"
																	style="display: none;"></textarea></td>
															<td><label>Aadhar and PAN Card linking
																	declaration</label></td>
															<td><input type="file" id="APLFile" name="APLFile"
																onchange="handleFileSelect(event,'APLFileText'), onValidateFile('APLFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="APLFileText" rows="5"
																	style="display: none;"></textarea></td>
														</tr>
														<tr>
															<td><label>ITR Filling Declaration<span
																	class="required">*</span></label></td>
															<td><input type="file" id="ITRFile" name="ITRFile"
																onchange="handleFileSelect(event,'ITRFileText'), onValidateFile('ITRFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="ITRFileText" rows="5"
																	style="display: none;"></textarea></td>
															<td><label>Filled Updated VRF Form<span
																	class="required">*</span></label></td>
															<td><input type="file" id="FUVFFile" name="FUVFFile"
																onchange="handleFileSelect(event,'FUVFFileText'), onValidateFile('FUVFFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="FUVFFileText" rows="5"
																	style="display: none;"></textarea></td>
														</tr>
														<tr>
															<td><label>MSME Certificate<span
																	class="required">*</span></label></td>
															<td><input type="file" id="MSMECFile"
																name="MSMECFile"
																onchange="handleFileSelect(event,'MSMECFileText'), onValidateFile('MSMECFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="MSMECFileText" rows="5"
																	style="display: none;"></textarea></td>
															<td><label>Approval Mail<span
																	class="required">*</span></label></td>
															<td><input type="file" id="AMFile" name="AMFile"
																onchange="handleFileSelect(event,'AMFileText'), onValidateFile('AMFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="AMFileText" rows="5"
																	style="display: none;"></textarea></td>
														</tr>

														<tr>
															<td><label>ITR Acknowledgment of 3 years<span
																	class="required">*</span></label></td>
															<td><input type="file" id="ITRAFile" name="ITRAFile"
																onchange="handleFileSelect(event,'ITRAFileText'), onValidateFile('ITRAFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="ITRAFileText" rows="5"
																	style="display: none;"></textarea></td>
															<td><label>Name mismatch affidavit or
																	declaration would be required if name mentioned in all
																	document is not same including spelling error<span
																	class="required">*</span>
															</label></td>
															<td><input type="file" id="NMISFile" name="NMISFile"
																onchange="handleFileSelect(event,'NMISFileText'), onValidateFile('NMISFile')"
																class="form-control p-input" accept=".jpg, .jpeg, .pdf">
																
																<button type="Button"style="height: 30px;width: 69px;font-size: smaller;"
															class="btn btn-primary" id="docViewBtn"
															name="addBookGridButt">Doc view</button>
																
																<textarea id="NMISFileText" rows="5"
																	style="display: none;"></textarea></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
							
								<div class="card-footer" align="center">
                                        <button type="submit" id="updateBtn" onclick="sendToServer()" class="btn btn-primary">Update</button>
                                        <button type="button" class="btn btn-primary" id="closePopBtn" data-dismiss="modal">Close</button>
                                    </div>
							
							<!-- model End -->	
				
            		</div>
				</div>
			</div>
		</div>
	</div>
            
      </div></div></div></div></div>



    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button);
        $.widget.bridge('uitooltip', $.ui.tooltip);

    </script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
     <script src="js/commonFunctions.js"></script>
    <!-- ChartJS -->

    <!-- Sparkline -->
    <script src="plugins/sparklines/sparkline.js"></script>
    <!-- JQVMap -->

    <!-- daterangepicker -->
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Summernote -->

    <!-- overlayScrollbars -->
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->

    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
    <script src="js/moment.min.js"></script>

    <script src="plugins/select2/js/select2.full.min.js"></script>
    

<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    
    
    

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
        /* When the user clicks on the button,
        toggle between hiding and showing the dropdown content */
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
        var mappingTableArray = [];

        var tabledata = $('#tabledata').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": true,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true 
        });


        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });

       
        getData();

        function getData() {

            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getActiveVendorData%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                	//alert("hii"+data.msg);
                    if (data.msg == 'success') {

                        var lastName = "";
                        var result = data.data;
                        
                        console.log(result);
                         
                        tabledata.clear();

                         for (var i = 0; i < result.length; i++) {
                        	
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
                        	 if(!result[i].hasOwnProperty("compGstn")){
     							result[i].compGstn="";
     						}
                        	 if(!result[i].hasOwnProperty("natureOfTransactions")){
     							result[i].natureOfTransactions="";
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

                        	 
                        	 var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#\" onclick=\"editData('" + result[i].bpCode + "')\" >" + result[i].bpCode + "</button>";
                        	
                            tabledata.row.add([view,result[i].introducedByName, result[i].suppName,result[i].compEmail, result[i].introducedByEmailID,result[i].compGstn, result[i].natureOfTransactions,result[i].partnerType, result[i].vendorType,result[i].phoneNumber ]);

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

                    swal.fire("Alert", "Invalid Email Id....", "warning");
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
        	
            bpCode = bpCode;
            
            var json = {

                "bpCode": bpCode
            }
            
            
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.getVendorById%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {
                    //debugger;
                    if (data.msg == 'success') {
                        var result = data.data;
                    	console.log(result);
                    
                    	id=result[0].id;
                    
                    	var myForm = "";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result[0]);
                        
                           var vendorType=result[0].vendorType;
                        
                           var str = vendorType.split(",");
                           
                         
                        	   for (let i = 0; i < str.length; i++) {
                            	  // alert("str"+str[i]);
                            	   
                            	    if(str[i] == 'Network' && str[i+1] == 'Fixed Asset' && str[i+2] == 'Other'){
                            	    		$('#states').val(["Network","Fixed Asset","Other"]).change() 
                            				break;
                            	    
                            	   	}else if(str[i] == 'Network' && str[i+1] == 'Fixed Asset' ){
                               		   		$('#states').val(["Network","Fixed Asset"]).change()
                               		  	 	break;
                               	   	}else if(str[i] == 'Fixed Asset' && str[i+1] == 'Other'){
                                  		  	 $('#states').val(["Fixed Asset","Other"]).change()
                                  			break;
                                  	 }else if(str[i] == 'Network' && str[i+1] == 'Other'){
                              		  	 $('#states').val(["Network","Other"]).change()
                               			break;
                               	 	}else if(str[i] == 'Network'){
                                    		 
                                  		   $('#states').val('Network').submit().trigger('change');
                                  			 break;
                                  	 }else if(str[i] == 'Fixed Asset'){
                                    		 
                                  		   $('#states').val('Fixed Asset').submit().trigger('change'); 
                                  		 	break;
                                  	 }else if(str[i] == 'Other'){
                              				$('#states').val('Other').trigger('change');
                              		 		break;
                              	   }    	
                            	  
                        	 } 
                        
                           
                        	 select();
                      
                  
                       if(result[0].partnerType!="Ad-Hoc"){
                    	   
                    	
                        tabledata.clear();

                         for (var i = 0; i < result[0].addressDetails.length; i++) {
                      
                        	
                        	 $("#addBookGrid").append(' <tr class=""><td>' +
                        			 result[0].addressDetails[i].addCountry + '</td><td>' +
                        			 result[0].addressDetails[i].state + '</td><td>' +
                        			 result[0].addressDetails[i].city + '</td><td>' +
                        			 result[0].addressDetails[i].pinCode + '</td><td>' +
                        			 result[0].addressDetails[i].addDetails + '</td><td> <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                        	 
                        	 
                        	 
                        } 
                         for (var i = 0; i < result[0].contactDetails.length; i++) {

                         $("#contactDetailsGrid").append('<tr class=""><td>' +
                        		 result[0].contactDetails[i].conFname + '</td><td>' +
                        		 result[0].contactDetails[i].conLname + '</td><td>' +
                        		 result[0].contactDetails[i].conPhone + '</td><td>' +
                        		 result[0].contactDetails[i].conEmail + '</td><td> <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                         }
                        
                        
                         for (var i = 0; i < result[0].accountDetails.length; i++) {
                         $("#addBankGrid").append('<tr class=""><td>' +
                        		 result[0].accountDetails[i].bankName + '</td><td>' +
                        		 result[0].accountDetails[i].ifscCode + '</td><td>' +
                        		 result[0].accountDetails[i].accoutNumber + '</td><td>' +
                        		 result[0].accountDetails[i].accoutCurrency + '</td><td>' + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                        
                         }
                        
                         for (var i = 0; i < result[0].itrDetails.length; i++) {
                         $("#addITRGrid").append('<tr class=""><td>' +
                        		 result[0].itrDetails[i].fyYear + '</td><td>' +

                        		 result[0].itrDetails[i].acknowledgementNumber + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                        
                        
                         }
                        
                    
                       
                        
                        myForm = document.getElementById("stepSixForm");
                        setData(myForm, result[0]);
                      
                        
                        myForm = document.getElementById("stepSevenForm");
                        setData(myForm, result[0]);

                       } 
                        
                       // $("#id").val(result[0].id);
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
                allowClear: true
                
            });
            
        });
        
        
        


        $("#addBookGridButt").click(function() {
            var abc = document.getElementById('city').value;
            var abc2 = document.getElementById('pinCode').value;
            var abc3 = document.getElementById('addDetails').value;
            console.log("abc =>" + abc);
            if (abc == null || abc == "") {
                swal.fire("Alert", "Fill Mandatory Field ! City", "warning");
                return false;
            } else if (abc2 == null || abc2 == "") {
                swal.fire("Alert", "Fill Mandatory Field ! Pin Code", "warning");
                return false;
            } else if (abc3 == null || abc3 == "") {
                swal.fire("Alert", "Fill Mandatory Field ! Address", "warning");
                return false;
            } else {

                $("#addBookGrid").append(' <tr class=""><td>' +
                    document.getElementById('addCountry').value + '</td><td>' +
                    document.getElementById('state').value + '</td><td>' +
                    document.getElementById('city').value + '</td><td>' +
                    document.getElementById('pinCode').value + '</td><td>' +
                    document.getElementById('addDetails').value + '</td><td> <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                /*  document.getElementById('addCountry').value = "";
                 document.getElementById('state').value = ""; */
                document.getElementById('city').value = "";
                document.getElementById('pinCode').value = "";
                document.getElementById('addDetails').value = "";
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
                swal.fire("Alert", "Fill Mandatory Field !", "warning");
                return false;
            } else if (abc2 == null || abc2 == "") {
                swal.fire("Alert", "Fill Mandatory Field !", "warning");
                return false;
            } else if (abc3 == null || abc3 == "") {
                swal.fire("Alert", "Fill Mandatory Field !", "warning");
                return false;
            } else if (abc4 == null || abc4 == "") {
                swal.fire("Alert", "Fill Mandatory Field !", "warning");
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
            var abc2 = document.getElementById('ifscCode').value;
            var abc3 = document.getElementById('accoutNumber').value;
            console.log("abc =>" + abc);
            if (abc == null || abc == "") {
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                swal.fire("Alert", "Fill Mandatory Field ! Bank Name", "warning");
                return false;
            } else if (abc2 == null || abc2 == "") {
                swal.fire("Alert", "Fill Mandatory Field ! IFSC Code", "warning");
                return false;
            } else if (abc3 == null || abc3 == "") {
                swal.fire("Alert", "Fill Mandatory Field ! Account Number", "warning");
                return false;
            } else {
                $("#addBankGrid").append('<tr class=""><td>' +
                    document.getElementById('bankName').value + '</td><td>' +
                    document.getElementById('ifscCode').value + '</td><td>' +
                    document.getElementById('accoutCurrency').value + '</td><td>' +
                    document.getElementById('accoutNumber').value + '</td><td>' + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                document.getElementById('bankName').value = "";
                document.getElementById('ifscCode').value = "";
                document.getElementById('accoutNumber').value = "";
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

        $("#addITRGridButt").click(function() {
            var abc = document.getElementById('fyYear').value;
            var abc1 = document.getElementById('acknowledgementNumber').value;
            console.log("abc =>" + abc);
            if (abc == null || abc == "") {
                swal.fire("Alert", "Select Financial Year Number. !", "warning");
                return false;
            } else if (abc1 == null || abc1 == "") {
                swal.fire("Alert", "Fill Acknowledgement Number. !", "warning");
                return false;
            } else {
                $("#addITRGrid").append('<tr class=""><td>' +
                    document.getElementById('fyYear').value + '</td><td>' +

                    document.getElementById('acknowledgementNumber').value + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                document.getElementById('fyYear').value = "";
                document.getElementById('acknowledgementNumber').value = "";
            }
        });

        
        
       /*  function ValidatePAN() {
            var txtPANCard = document.getElementById("panNumber");
            var lblPANCard = document.getElementById("lblPANCard")
            var regex = /([A-Z]){5}([0-9]){4}([A-Z]){1}$/;
            if (regex.test(txtPANCard.value.toUpperCase())) {
                lblPANCard.style.visibility = "hidden";
                return true;
            } else {
                lblPANCard.style.visibility = "visible";
                return false;
            }
        }
         */
        
        
        function sendToServer() {
        	
       
        	var txtPANCard = document.getElementById("panNumber");
            var lblPANCard = document.getElementById("lblPANCard")
            var regex = /([A-Z]){5}([0-9]){4}([A-Z]){1}$/;
            if (regex.test(txtPANCard.value.toUpperCase())) {
                lblPANCard.style.visibility = "hidden";
                
            } else {
                lblPANCard.style.visibility = "visible";
                swal.fire("Alert", "Invalid Pan Number", "warning");
                return false;
            } 
        	//alert("hii");
        	console.log("Inside Step One");
            var mandFields = "introducedByName,introducedByEmailID,suppName,compEmail,panNumber,natureOfTransactions";
            var mandFieldsArr = mandFields.split(",");
            for (i = 0; i < mandFieldsArr.length; i++) {
                console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                if (document.getElementById(mandFieldsArr[i]).value == '') {
                    notifyTooltip(mandFieldsArr[i], "Mandatory Field", "top")
                    console.log("Mandatory Check :: " + mandFieldsArr[i]);
                    return false;
                }
            }
        	
            var element = document.getElementById('states');
        	var element=[...element.options].filter(ele => ele.selected).map(ele => ele.text);
        	var selectedValues = [];    
            $("#states :selected").each(function(){
                selectedValues.push($(this).val()); 
            });
            if(selectedValues== ""){
            	swal.fire("Alert", "please select Business Partner Type....", "warning")
                return regex.test(inputvalues);
            }
            
            
            var addressDetailsArray = [];
            var table = document.getElementById('addBookGrid');
            var rowLength = table.rows.length;

            for (var i = 1; i < rowLength; i += 1) {
                var row = table.rows[i];
                var objs = {
                    "addCountry": row.cells[0].innerHTML,
                    "state": row.cells[1].innerHTML,
                    "city": row.cells[2].innerHTML,
                    "pinCode": row.cells[3].innerHTML,
                    "addDetails": row.cells[4].innerHTML
                };
                addressDetailsArray.push(objs);
            }
            
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
                    "ifscCode": row.cells[1].innerHTML,
                    "accoutCurrency": row.cells[2].innerHTML,
                    "accoutNumber": row.cells[3].innerHTML,
                    "accoutName": row.cells[4].innerHTML,
                }
                accountDetailsArray.push(pushObj);
            }

            if(accountDetailsArray.length==0 && partnerType!="Ad-Hoc"){
            
            
            	swal.fire("Alert", "please add accountDetails....", "warning")
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

            for (var i = 1; i < rowLength; i += 1) {
                var row = table.rows[i];

                var pushItrObj = {
                    "fyYear": row.cells[0].innerHTML,
                    "acknowledgementNumber": row.cells[1].innerHTML
                }
                itrDetailsArray.push(pushItrObj);
            }
            
           
            
            $body.addClass("loading");

            var step1Obj = FormDataToJSON('stepOneForm');
            
            step1Obj.id=id;
           
            
           
            
            var step6Obj = FormDataToJSON('stepSixForm');
            //var step8Obj = FormDataToJSON('StepEightForm');
            var step7Obj = FormDataToJSON('stepSevenForm');
            
          

            const finalObj = {
                ...step1Obj,
                ...step6Obj,
                ...step7Obj
                //...step8Obj
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
            if (document.getElementById("ITRAFile").files.length > 0) {
                finalObj.itraFileName = document.getElementById("ITRAFile").files.item(0).name;
                finalObj.itraFileText = $("#ITRAFileText").val();
            }
            if (document.getElementById("NMISFile").files.length > 0) {
                finalObj.nmisFileName = document.getElementById("NMISFile").files.item(0).name;
                finalObj.nmisFileText = $("#NMISFileText").val();
            }
            
           
            var checked = []
            
             checked=document.getElementById("roleId").value
           
             
            /*  $("input[name='option[]']:checked").each(function() {
                 checked.push($(this).val());
             }); */
            
           /*  $("input[name='vendorType[]']:value").each(function() {
                checked.push($(this).val());
            });

           /*  $("#vendorType").value {
                checked.push($(this).val());
            }); */
            
          
            
            var values= document.getElementById("roleId").value ;
            console.log("value vendorType : "+values);
            finalObj.vendorType = values;
            
            console.log("finalObj",finalObj.vendorType);
        
			 
           
            $.ajax({
                type: "POST",
                data: JSON.stringify(finalObj),
                url: "ajaxController/SaveRegistration",
                dataType: "json",
                contentType: "application/json",
                success: function(response) {
                	//return;
                    if (response.msg == 'success') {
                        swal.fire("Thanks", "Vendor Onbording request Sucessfully Register", "success", "OK").then(function() {
                            window.location = "vendorDetails";
                        });


                        setTimeout(function(response) {
                            //location.href = "login";
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
            //alert($("#partnerType").val());
            if ($("#partnerType").val() == "Scheduled") {
                //alert("ji..");
                $(".required").css("visibility", "visible");
                $("#updateBtn").attr("disabled", true);
            }  else {
                $(".required").css("visibility", "hidden");
                $(".adHocRequired").css("visibility", "visible");
                $("#updateBtn").attr("disabled", false);
                //alert("ji..2");
            } 
        } 

        
        function AadharValidate() {
            var aadhar = document.getElementById("aadharNumber").value;
            var adharcardTwelveDigit = /^\d{12}$/;
            var adharSixteenDigit = /^\d{16}$/;
            if (aadhar != '') {
                if (aadhar.match(adharcardTwelveDigit)) {
                    return true;
                } else if (aadhar.match(adharSixteenDigit)) {
                    return true;
                } else {
                    alert("Enter valid Aadhar Number");
                    $("#aadharNumber").val('');
                    $("#aadharNumber").focus();
                    //return false;
                }
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

     
        
    </script>
</body>

</html>
