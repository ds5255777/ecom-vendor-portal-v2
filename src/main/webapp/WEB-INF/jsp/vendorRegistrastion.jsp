<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<!DOCTYPE html>
<html lang="en">

<head>


<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Business Partner Registration</title>


<!-- Optional SmartWizard themes -->
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
<script src="plugins/jquery/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
<script src="dist/js/notify.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>


<script>

        function addValCss(controlName) {
            $('#' + controlName).css({
                'border': '1px solid red',
                'box-shadow': 'inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(249, 0, 0, 0.6)',
                '-webkit-box-shadow': 'inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(249, 0, 0, 0.6)',
                'outline-color': 'transparent'
            });
        }

        function removeValCss(controlName) {
            $('#' + controlName).css({
                'border': '1px solid #b7b7b7',
                'box-shadow': 'none',
                '-webkit-box-shadow': 'none'
            });
        }

        function removeValCssByID(controlName) {
            $('#' + controlName.id).css({
                'border': '1px solid #b7b7b7',
                'box-shadow': 'none',
                '-webkit-box-shadow': 'none'
            });
        }

              $("#smartwizard").on("leaveStep", function(e, anchorObject, stepNumber, stepDirection, stepPosition) {
                console.log(anchorObject);
                console.log("stepNumber " + stepNumber);
                console.log("stepDirection " + stepDirection);
                console.log("getCurrentIndex " + $("#smartwizard").smartWizard("currentStep"));
                console.log(stepPosition);


                if (stepNumber === 3) {
                    console.log("Coming Here");
                    $('.btnfinish').attr('disabled', false);
                } else {
                    $('.btnfinish').attr('disabled', true);
                }
                return checkMand(stepNumber);

            });
    
        
        

         function showHideRequiredClass() {
            //alert($("#partnerType").val());
            if ($("#partnerType").val() == "Scheduled") {
                //alert("ji..");
                $(".required").css("visibility", "visible");
                $("#finishButton").attr("disabled", true);
            }  else {
                $(".required").css("visibility", "hidden");
                $(".adHocRequired").css("visibility", "visible");
                $("#finishButton").attr("disabled", false);
                //alert("ji..2");
            } 
        } 

        function checkMand(stepNo) {

            console.log("stepNo " + stepNo);
            if (stepNo == 0) {

                

                	
            	 console.log("Inside Step One");
                 var mandFields = "introducedByName,introducedByEmailID,suppName";
                 var mandFieldsArr = mandFields.split(",");
                 for (i = 0; i < mandFieldsArr.length; i++) {
                     console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                     if (document.getElementById(mandFieldsArr[i]).value == '') {
                         notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                        
                         console.log("mandatory Check :: " + mandFieldsArr[i]);
                         
                         return false;
                     }
                 }

                   
             

            } else if (stepNo == 1) {
                console.log("Inside Step Two");
                var addBookGridCount = $("#addBookGrid tr").length;
                var contactDetailsGrid = $("#contactDetailsGrid tr").length;
                console.log("addBookGridCount " + addBookGridCount);
                console.log("contactDetailsGrid " + contactDetailsGrid);
                if (addBookGridCount == 1) {
                    swal.fire("Alert", "Add Atleast One Address !", "warning")
                        .then((value) => {});
                    return false;
                }
                if (contactDetailsGrid == 1) {
                    swal.fire("Alert", "Add Atleast One Conttact", "warning")
                        .then((value) => {});
                    return false;
                }
            } else if (stepNo == 2) {
                console.log("Inside Step Three");
                var addBankGrid = $("#addBankGrid tr").length;
                console.log("addBankGrid " + addBankGrid);
                if (addBankGrid == 1) {
                    swal.fire("Alert", "Add Atleast One Account Detail", "warning")
                        .then((value) => {

                        });
                    return false;
                }
                console.log("Inside Step Three second part");
                //

                var mandFields = "invoiceCurrency,paymentCurrency,creditTerms,paymentMethod";
                var mandFieldsArr = mandFields.split(",");
                for (i = 0; i < mandFieldsArr.length; i++) {
                    console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                    if (document.getElementById(mandFieldsArr[i]).value == '') {
                        notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                        console.log("mandatory Check :: " + mandFieldsArr[i]);
                        return false;
                    }
                }
            } else if (stepNo == 3) {

                console.log("Inside Step Four");
                 if ($("#tdsApplication").val() == "Yes") {
                    var mandFields = "tdsSection,tdsRate";
                    var mandFieldsArr = mandFields.split(",");
                    for (i = 0; i < mandFieldsArr.length; i++) {
                        console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                        if (document.getElementById(mandFieldsArr[i]).value == '') {
                            notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                            console.log("mandatory Check :: " + mandFieldsArr[i]);
                            return false;
                        }
                    }
                 }
            }
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
            /* $("#introducedByEmailID").change(function() {
                var inputvalues = $(this).val();
                var regex = /^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@ecomexpress.in$/;
                
                if (!regex.test(inputvalues)) {
                    $("#introducedByEmailID").val("");

                    swal.fire("Alert", "Dear User Please Provide ECOM Patner Email ID", "warning");
                    return regex.test(inputvalues);
                }
            }); */
        });
        
        $(document).ready(function() {
            $("#conEmail").change(function() {
                var inputvalues = $(this).val();
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (!regex.test(inputvalues)) {
                    $("#conEmail").val("");

                    swal.fire("Alert", "Invalid Email Id", "warning");
                    return regex.test(inputvalues);
                }
            });
        });

        function validatephone(phone) {

            phone = phone.replace(/[^0-9]/g, '');
            $("#phoneNumber").val(phone);
            if (phone == '' || !phone.match(/^0[0-9]{9}$/)) {
                return false;
            } else {
                return true;
            }
        }
        
        function onValidateFile(id){
        	var fileInput3 = document.getElementById(id).value;
        	var gst = document.getElementById(id);
        	var allowedExtensions = /(\.jpg|\.jpeg|\.pdf)$/i;
        	 /* if (!allowedExtensions.exec(fileInput3)) {
        		 $("#GSTFile").val("");
             	swal.fire("Alert", "Invalid File Type, Select Only JPEG & PDF File....", "warning");
             	return false;
             } */
        	 if (typeof (gst.files) != "undefined") {
             	//alert("hello");
             	
             	const fsize = gst.files.item(0).size;
             	
             	console.log(fsize);
             	const file = Math.round((fsize / 1024));
             	console.log(file);
                // var size = parseFloat(cc.files[0].size / (1024 * 1024)).toFixed(2);
                 //alert("Your File Size is "+(file/1024)+"MB");
                 if(file > ${maxFileSize}) {
                 	swal.fire("Alert", "Please select File size less than 5 MB....", "warning");
                 	$("#" + id).val("");
                 }else{
                 	 var ext = fileInput3.split(".")[1];
                     // alert("Extension is "+ext);
                      
                      if( ext=="pdf" || ext=="jpg" || ext=="JPEG" || ext=="JPG" || ext=="jpeg" || ext=="PDF" ){
                      	//Sab valid hai
                      }else{
                      	swal.fire("Alert", "Invalid File Type, Select Only JPEG & PDF File....", "warning");
                          
                      	$("#" + id).val("");
                          return false;	
                      }
                 }
             } else {
                 alert("This browser does not support HTML5.");
             }
        }
        
            function disableScrolling() {
                setTimeout(function() {
                    document.body.style.overflow = 'hidden';
                }, 1000);
            }
              
            function enableScrolling() {
                document.body.style.overflow = '';
            }
            
            $(document).ready(function() {
                
            });
                 

        </script>

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


 .PAN
    {
        text-transform: uppercase;
    }
    .error
    {
        color: Red;
        visibility: hidden;
    }





/* When the body has the loading class, we turn
               the scrollbar off with overflow:hidden */
body.loading .modal {
	overflow: hidden;
}

/* Anytime the body has the loading class, our
               modal element will be visible */
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

#addDetails {
	resize: vertical;
}

.navbar .navbar-menu-wrapper {
	transition: width .8s ease!importent;
	padding: 2px 0px !important;
	width: calc(100% - 0px) !important;
}
.select2{
width: 100% !important;
}
.select2-container--default .select2-selection--multiple .select2-selection__clear {
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
</style>


</head>

<body>

<jsp:include page="loader.jsp" />


	<div class="">
		<!-- partial:../../partials/_navbar.html -->
		<nav
			class="navbar navbar-default col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
			<div class="navbar-menu-wrapper d-flex align-items-center">
				<ul class="navbar-nav d-flex align-items-center flex-row"
					style="margin-left: 30px;">
					<li class="nav-item"><a class="nav-link profile-pic" href="#"><img
							class="img-fluid" src="dist/img/logo/ecomlogo.png" alt=""
							style="width: 40px;"></a></li>
				</ul>
				<h4 style="color: white;">Business Partner Registration</h4>
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
                                                <td><label for="name">Introducer Name<span class="required adHocRequired">*</span></label></td>
                                                <td colspan='1'><input type="text" value="${uname}" class="form-control p-input" id="introducedByName" name="introducedByName" placeholder="Introducer Name" maxlength="50" readonly></td>

                                                <td><label for="emailId">Introducer Email ID<span class="required adHocRequired">*</span></label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="introducedByEmailID" name="introducedByEmailID" maxlength="50" placeholder="abc@ecomexpress.in" onchange="removeValCssByID(this)"><span id="message"></span></td>

                                                <td><label for="Supplier Type">Business Partner
                                                        Code</label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="bpCode" name="bpCode" placeholder="Business Partner Code" onchange="removeValCssByID(this)" ></td>


                                            </tr>



                                            <tr>

                                                <%-- <td><label>Business Partner Type<span class="required adHocRequired">*</span></label></td>

                                                <td style="width: auto"><select class="js-example-basic-multiple select2" name="states[]" id="states" onchange="select()" multiple="multiple">
                                                        <c:forEach items="${business}" var="bus">

                                                            <option value="${bus}">${bus}</option>
                                                        </c:forEach>
                                                    </select></td>


                                                <td><label for="partnerType">Business Partner</label></td>
                                                <td><select id="partnerType" name="partnerType" class="form-control p-input" onchange="showHideRequiredClass();" disabled="disabled">
                                                        <c:forEach items="${partner}" var="par">

                                                            <option value="${par}">${par}</option>
                                                        </c:forEach>

                                                    </select></td> --%>
                                                <input type="hidden" id="roleId" />


                                                <td><label for="suppName">Business Partner Name<span class="required adHocRequired">*</span></label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="suppName" name="suppName" placeholder="Business Partner Name" onchange="removeValCssByID(this)" oninput="this.value = this.value.toUpperCase()" maxlength="50"></td>
                                            
												<td><label for="businessClassification">Business
                                                        Classification</label></td>
                                                <td><select id="businessClassification" name="businessClassification" class="form-control p-input"  onchange="MESMENumber()">
                                                        <option value="">Select</option>
                                                        <c:forEach items="${classification}" var="classi">

                                                            <option value="${classi}">${classi}</option>
                                                        </c:forEach>

                                                    </select></td>

                                                <td><label for="mesmeNumber">MESME Certificate Number</label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="mesmeNumber" maxlength="12" name="mesmeNumber" placeholder="MESME Certificate Number" disabled="disabled"></td>
													</tr>





                                            <tr class="">

                                                
                                                <td><label for="aadharNumber">Aadhar Number</label></td>
                                                <td colspan='1'><input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" class="form-control p-input" id="aadharNumber" maxlength="12" name="aadharNumber" placeholder="Aadhar Number" onblur="AadharValidate();"></td>
													
												<td><label for="adharLinkStatus">Aadhar Link
                                                        Status</label></td>

                                                <td><select colspan='1' class="form-control p-input" id="adharLinkStatus" name="adharLinkStatus" placeholder="Aadhar Link Status" onchange="removeValCssByID(this)">
                                                        <option value="">Select</option>
                                                        <c:forEach items="${adharLink}" var="link">

                                                            <option value="${link}">${link}</option>
                                                        </c:forEach>

                                                    </select></td>	
                                                    
                                                 <td><label>Section Type<span class="required adHocRequired"></span></label></td>

                                                <td><select colspan='1' class="form-control p-input" id="sectionType" name="sectionType" placeholder="Aadhar Link Status" onchange="removeValCssByID(this)">
                                                        <option value="">Select</option>
                                                        <c:forEach items="${sectionType}" var="type">

                                                            <option value="${type}">${type}</option>
                                                        </c:forEach>

                                                    </select></td>   



                                            </tr>

                                            <tr class="">

                                                <td><label for="panNumber">Pan Number<span class="required adHocRequired"></span></label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="panNumber" name="panNumber" placeholder="Pan Number" oninput="this.value = this.value.toUpperCase()" maxlength="10" onchange="removeValCssByID(this)"></td>
                                                <td><label for="tanNumber">TAN Number</label></td>
                                                <td colspan='1'><input type="text" class="form-control p-input" id="tanNumber" name="tanNumber" placeholder="TAN Number" oninput="this.value = this.value.toUpperCase()" maxlength="10" onkeypress="return isNumberKey(evt);"></td>
												
												<td><label>Region<span class="required adHocRequired"></span></label></td>

                                                <td style="width: auto"><select colspan='1' class="js-example-basic-multiple1 select2" name="region[]" id="region" multiple="multiple" onchange="region1();">
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
                                                    <td><label class="addressLable" for="country">Country<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><select id="addCountry" name="addCountry" class="form-control p-input">
                                                            <c:forEach items="${country}" var="count">

                                                                <option value="${count}">${count}</option>
                                                            </c:forEach>

                                                        </select></td>

                                                    <td><label class="addressLable">State<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'>
                                                        <select name="state" id="state" class="form-control p-input">
                                                            <c:forEach items="${stateName}" var="stateNames">

                                                                <option value="${stateNames}">${stateNames}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </td>
                                                    <td><label class="addressLable">District/City<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><input type="text" class="form-control p-input" id="city" name="city" placeholder="District" maxlength="50"></td>
                                                </tr>
                                                <tr class="">


                                                    <td><label>Postal/ZIP Code<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><input type="text" class="form-control p-input" id="pinCode" name="pinCode" onkeypress="return event.charCode >= 48 && event.charCode <= 57" placeholder="Postal Code/ ZIP Code" maxlength="6"></td>
                                                    
                                                    <td><label>Business Partner Type<span class="required adHocRequired">*</span></label></td>

                                                <td colspan="2"><select class="js-example-basic-multiple select2" name="states[]" id="states" onchange="select()" multiple="multiple">
                                                        <c:forEach items="${business}" var="bus">

                                                            <option value="${bus}">${bus}</option>
                                                        </c:forEach>
                                                    </select></td>


                                                <td><label for="partnerType">Business Partner</label></td>
                                                <td colspan="2"><select id="partnerType" name="partnerType" class="form-control p-input"  disabled="disabled">
                                                        <c:forEach items="${partner}" var="par">

                                                            <option value="${par}">${par}</option>
                                                        </c:forEach>

                                                    </select></td>
                                                    
                                                    <%-- <td><label for="Business Partner Type">Business Partner Type<span class="required adHocRequired">*</span>
                                                        </label></td>

                                                    <td colspan='2'><select  class="form-control p-input" id="natureOfTransactions" name="natureOfTransactions" placeholder="Nature of Transactions" onchange="removeValCssByID(this)">
                                                            <option value="">Select</option>
                                                            <c:forEach items="${business}" var="nat">

                                                                <option value="${nat}">${nat}</option>
                                                            </c:forEach>

                                                        </select></td>
                                                        
                                                     <td><label for="partnerType">Business Partner</label></td>
                                               		 <td colspan="2"><select id="partnerType" name="partnerType" class="form-control p-input" onchange="showHideRequiredClass();" disabled="disabled">
                                                        <c:forEach items="${partner}" var="par">

                                                            <option value="${par}">${par}</option>
                                                        </c:forEach>

                                                    </select></td> --%>   
                                                </tr>

                                                <tr class="">
                                                
                                               		 <td><label for="compGstn">GSTN Number<span class="required adHocRequired"></span></label></td>
                                                    <td colspan='2'><input type="test" class="form-control p-input gst" id="compGstn" name="compGstn" name="compGstn" placeholder="GSTN Number" oninput="this.value = this.value.toUpperCase()" maxlength="15"></td>

                                                    <td><label for="addressDetails">Address
                                                            Details<span class="required adHocRequired">*</span>
                                                        </label></td>
                                                    <td colspan='2'><textarea class="form-control" id="addDetails" name="addDetails" maxlength="250" placeholder="Complete Address" rows="3"></textarea></td>
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


													<td><label for="emailId">Email Id<span
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
															<th>Email Id</th>
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
                                                    <td><label for="bankName">Bank Name<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><input type="text" class="form-control p-input" id="bankName" name="bankName" placeholder="Bank Name" maxlength="200"></td>

													<td><label for="bankName">Beneficiary Name<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><input type="text" class="form-control p-input" id="beneficiaryName" name="beneficiaryName" placeholder="Beneficiary Name" maxlength="200"></td>

                                                    <td><label for="ifscCode">IFSC Code<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><input type="text" class="form-control p-input" id="ifscCode" name="ifscCode" placeholder="IFSC Code" oninput="this.value = this.value.toUpperCase()" maxlength="11"></td>

                                                    <td><label for="accoutNumber">Account Number<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><input type="text" class="form-control p-input" id="accoutNumber" onkeypress="return event.charCode >= 48 && event.charCode <= 57" name="accoutNumber" placeholder="Account Number" maxlength="16"></td>

                                                </tr>

                                                <tr class="">
                                                    
                                                    <td><label for="Confirmed accoutNumber">Confirm Account Number<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><input type="text" class="form-control p-input" id="confirmedAccoutNumber" onkeypress="return event.charCode >= 48 && event.charCode <= 57" name="confirmedAccoutNumber" placeholder="Confirm  Account Number" maxlength="16"></td>

													<td><label for="accoutCurrency">Currency<span class="required adHocRequired">*</span></label></td>
                                                    <td colspan='2'><select id="accoutCurrency" name="accoutCurrency" class="form-control p-input">
                                                            <c:forEach items="${currency}" var="cur">

                                                                <option value="${cur}">${cur}</option>
                                                            </c:forEach>
                                                        </select></td>
                                                    <td></td>
                                                    <td colspan='3'>
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
															<c:forEach items="${currency}" var="cur">

																<option value="${cur}">${cur}</option>
															</c:forEach>

													</select></td>

													<td><label for="paymentCurrency">Payment
															Currency<span class="required adHocRequired">*</span>
													</label></td>
													<td colspan='2'><select id="paymentCurrency"
														name="paymentCurrency" class="form-control p-input">
															<c:forEach items="${currency}" var="cur">

																<option value="${cur}">${cur}</option>
															</c:forEach>
													</select></td>

													 <td><label for="creditTerms">Payment / Credit
                                                                                Terms<span class="required adHocRequired">*</span>
                                                                     </label></td>
														<td><select id="creditTerms" name="creditTerms"
														class="form-control p-input" colspan='2'
														placeholder="Payment / Credit Terms"
														onchange="removeValCssByID(this)">
															<option value="">Select</option>
															<c:forEach items="${payment}" var="pay">

																<option value="${pay}">${pay}</option>
															</c:forEach>

													</select></td>
													
												</tr>
												<tr class="">
														<td><label for="paymentMethod">Payment Method<span
															class="required adHocRequired">*</span></label></td>
													
													<td colspan='2'>
													
														<select id="paymentMethod" name="paymentMethod"
														class="form-control p-input" colspan='2'
														placeholder="Payment Method"
														onchange="removeValCssByID(this)">
															
															<c:forEach items="${paymentMethod}" var="met">
																<option value="${met}">${met}</option>
															</c:forEach>
													</select>
													
														</td>

													<td><label for="dateBasis">Terms Date Basis</label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="dateBasis"
														name="dateBasis" placeholder="Terms Date Basis" maxlength="150"></td>
													<td><label for="deliveryTerms">Delivery Terms</label></td>
													<td colspan='2'><input type="text"
														class="form-control p-input" id="deliveryTerms"
														name="deliveryTerms" placeholder="Delivery Terms" maxlength="150"></td>


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
                                                        <!-- <td><label class="addressLable" for="tdsApplication">TDS
                                                                Applicable</label></td>
                                                        <td colspan='2'><input type="text" id="tdsApplication" value="Yes" name="tdsApplication" readonly class="form-control p-input "> </td> -->

														<td><label class="addressLable" for="tdsApplication">TDS
                                                                Applicable<span class="required">*</span></label></td>
                                                        <td colspan='2'><select id="tdsApplication" name="tdsApplication" onchange="changetextbox();" class="form-control p-input ">
                                                                <option value="Yes">Yes</option>
                                                                <option value="No">No</option>
                                                            </select></td>

                                                        <td><label class="addressLable" for="tdsSection">TDS
                                                                Section<span class="required adHocRequired">*</span></label></td>
                                                        <td colspan='2'><select id="tdsSection" name="tdsSection" class="form-control p-input" colspan='2' placeholder="TDS Section">
                                                                <option value="">Select</option>
                                                                <c:forEach items="${tdsCode}" var="tds">

                                                                    <option value="${tds}">${tds}</option>
                                                                </c:forEach>



                                                            </select></td>

                                                        <td><label for="tdsRate">TDS Exemption Rate
                                                                %<span class="required adHocRequired">*</span></label></td>
                                                        <td colspan='2'><input type="text" onkeypress="return event.charCode >= 48 && event.charCode <= 57 || event.charCode <= 46" class="form-control p-input" id="tdsRate" name="tdsRate" placeholder="TDS  Exemption Rate" maxlength="4"></td>
                                                    </tr>

                                                </tbody>
											</table>

										</form>
									</div>
								</div>
							</div>

							<!-- End -->

							<!-- Start -->

							<div class="card" style="margin-bottom: 10px;">
								<div class="card-header" id="itrHead"
									style="background: #1991eb; color: #ffffff;">
									<h6 class="mb-0">ITR Details</h6>
								</div>
								<div id="itrHeadData" aria-labelledby="itrHead"
									style="border-style: solid; border-width: 1px; border-color: #1991eb;">
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
														<td><input type="text" id="acknowledgementNumber1"
															name="acknowledgementNumber1"
															class="form-control p-input "></td>
														<td><input type="file" id="ITRFile1" name="ITRFile1" placeholder="Fill Acknowledgement Number"
															onchange="handleFileSelect(event,'ITRFileText1'), onValidateFile('ITRFile1')"
															class="form-control p-input" accept=".jpg, .jpeg, .pdf">
															<textarea id="ITRFileText1" rows="5"
																style="display: none;"></textarea> <label><span
																style="font-weight: 500; color: #fd7e14;">File
																	size Max ${fileSize} MB</span></label></td>
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
														<td><input type="text" id="acknowledgementNumber2"
															name="acknowledgementNumber2"
															class="form-control p-input "></td>
														<td><input type="file" id="ITRFile2" name="ITRFile2" placeholder="Fill Acknowledgement Number"
															onchange="handleFileSelect(event,'ITRFileText2'), onValidateFile('ITRFile2')"
															class="form-control p-input" accept=".jpg, .jpeg, .pdf">
															<textarea id="ITRFileText2" rows="5"
																style="display: none;"></textarea> <label><span
																style="font-weight: 500; color: #fd7e14;">File
																	size Max ${fileSize} MB</span></label></td>
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
														<td><input type="text" id="acknowledgementNumber3"
															name="acknowledgementNumber3"
															class="form-control p-input "></td>
														<td><input type="file" id="ITRFile3" name="ITRFile1" placeholder="Fill Acknowledgement Number"
															onchange="handleFileSelect(event,'ITRFileText3'), onValidateFile('ITRFile1')"
															class="form-control p-input" accept=".jpg, .jpeg, .pdf">
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
                                                            <td><label>GST Certificate<span class="required"></span></label></td>
                                                            <td><input type="file" id="GSTFile" name="GSTFile" onchange=" removeValCssByID(this),  handleFileSelect(event,'GSTFileText','GSTFile'), onValidateFile('GSTFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="GSTFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                                         <a href="document/GST Declaration.zip" download> 
                                                                         Download Template
                                                                </a>
                                                            </td>

                                                            <td><label>Proprietorship Declaration<span class="required"></span></label></td>
                                                            <td><input type="file" id="PDFile" name="PDFile" onchange=" removeValCssByID(this),  handleFileSelect(event,'PDFileText','Proprietorship Declaration'), onValidateFile('PDFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="PDFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                                <a href="document/ProprietorshipDeclaration.docx" download>Download Template
                                                                </a>
                                                            </td>

                                                        </tr>

                                                        <tr>
                                                            <td><label>PAN Card<span class="required"></span></label></td>
                                                            <td><input type="file" id="PANFile" name="PANFile" onchange="handleFileSelect(event,'PANFileText','PAN Card'), onValidateFile('PANFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="PANFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                            </td>

                                                            <td><label>Cancelled Cheque/ Passbook/ Bank
                                                                    Statement<span class="required">*</span>
                                                                </label></td>
                                                            <td><input type="file" id="CCFile" name="CCFile" onchange="handleFileSelect(event,'CCFileText','Cancelle Cheque'), onValidateFile('CCFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="CCFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><label>Aadhar Card</label></td>
                                                            <td><input type="file" id="ACFile" name="ACFile" onchange="handleFileSelect(event,'ACFileText','Aadhar Card'), onValidateFile('ACFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="ACFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                            </td>
                                                            <td><label>Aadhar and PAN Card linking
                                                                    declaration</label></td>
                                                            <td><input type="file" id="APLFile" name="APLFile" onchange="handleFileSelect(event,'APLFileText','Aadhar PAN Linking'), onValidateFile('APLFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="APLFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label><a href="document/139 - Declaration from payees.docx" download>Download Template
                                                                </a>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><label>ITR Filling Declaration<span class="required">*</span></label></td>
                                                            <td><input type="file" id="ITRFile" name="ITRFile" onchange="handleFileSelect(event,'ITRFileText','ITR Declaratin'), onValidateFile('ITRFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="ITRFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label><a href="document/206AB - Declaration form ITR Filing.docx" download>Download Template
                                                                </a>
                                                            </td>
                                                            <td><label>Filled Updated VRF Form</label></td>
                                                            <td><input type="file" id="FUVFFile" name="FUVFFile" onchange="handleFileSelect(event,'FUVFFileText','VRF Form'), onValidateFile('FUVFFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="FUVFFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><label>MSME Certificate<span class="required">*</span></label></td>
                                                            <td><input type="file" id="MSMECFile" name="MSMECFile" onchange="handleFileSelect(event,'MSMECFileText','MSME Certificate'), onValidateFile('MSMECFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="MSMECFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label><a href="document/GST and MSME Annexure.xlsx" download>Download Template
                                                                </a>
                                                            </td>
                                                            <td><label>Approval Mail<span class="required"></span></label></td>
                                                            <td><input type="file" id="AMFile" name="AMFile" onchange="handleFileSelect(event,'AMFileText','Approval Mail'), onValidateFile('AMFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="AMFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <!-- <td><label>ITR Acknowledgment of 3 years<span
																	class="required">*</span></label></td>
															<td><input type="file" id="ITRAFile" name="ITRAFile"
																onchange="handleFileSelect(event,'ITRAFileText'), onValidateFile('ITRAFile')"
																class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
																<textarea id="ITRAFileText" rows="5"
																	style="display: none;"></textarea></td> -->
                                                            <td><label>Name mismatch affidavit or
                                                                    declaration would be required if name mentioned in all

                                                                    document is not same including spelling error<span class="required"></span>
                                                                </label></td>
                                                            <td><input type="file" id="NMISFile" name="NMISFile" onchange="handleFileSelect(event,'NMISFileText','Name Mismatch Affidavit'), onValidateFile('NMISFile')" class="form-control p-input" accept=".docx, .jpg, .jpeg, .pdf">
                                                                <textarea id="NMISFileText" rows="5" style="display: none;"></textarea> <label><span style="font-weight: 500; color: #fd7e14;">File
                                                                        size Max ${fileSize} MB</span></label>
                                                                <!-- <a href="C:/1.BPAAS/Document/doc.pdf" download="doc.pdf">Download Template
																		</a> -->
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
					
					
				<!-- query page -->

					<div id="step-6" class="">
						<div class="card queryFormUi" style="display: none; margin-bottom: 10px;">
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
													<td style="width: 150px;">
														<textarea class="form-control" id="comment" name="comment" rows="3" maxlength="250" placeholder="Remarks if Any"></textarea>
													</td>
													<td style="width: 150px;"><button type="Button"
															class="btn btn-primary" id="addSupplierQueryBtn"
															name="addSupplierQueryBtn" onclick="saveRemarks()">Add Remarks</button></td>
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
														<th class="bg-primary" style="color: white;">Raised on</th>
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

									<div class="card-footer" align="center">
                                        <button type="submit" id="updateBtn" onclick="sendToServer()" class="btn btn-primary">Save</button>
                                        <button type="button" class="btn btn-primary" id="closePopBtn" onclick="window.close();">Close</button>
                                    </div>

				</div>
			</div>
		</div>
	</div>




	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
	<script src="js/commonFunctions.js"></script>
	<script>
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: true,
            timer: 3000
        });
        $(document).ready(function() {
            $('.js-example-basic-multiple').select2({
            	zplaceholder: "Select Partner Type",
                allowClear: true,
                maximumSelectionLength: 1
            });
            
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
                	swal.fire(""," Invalid Aadhar Number", "warning");
                    $("#aadharNumber").val('');
                    $("#aadharNumber").focus();
                    //return false;
                }
            }
        }
       
        $("#addBookGridButt").click(function() {
        	var abc = document.getElementById('city').value;
            var abc2 = document.getElementById('pinCode').value;
            var abc3 = document.getElementById('addDetails').value;
            var abc4 = document.getElementById('states').value;
            
            console.log("abc =>" + abc);
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

                /*  document.getElementById('addCountry').value = "";
                 document.getElementById('state').value = ""; */
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
             }else if (abc2 == null || abc2 == "") {
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

     /*    $("#addITRGridButt").click(function() {
            var abc = document.getElementById('fyYear').value;
            var abc1 = document.getElementById('acknowledgementNumber').value;
            let abc2 = document.getElementById('ITRAFile').value;
        
          let cc=abc2.substr(12);
          
          
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

                    document.getElementById('acknowledgementNumber').value + '</td><td>' +

                    cc + '</td><td>  <a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

                document.getElementById('fyYear').value = "";
                document.getElementById('acknowledgementNumber').value = "";
                document.getElementById('ITRAFile').value="";
            }
        });

 */        
  
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
                var regex = /^[a-zA-Z0-9+_.-]*@ecomexpress.in$/;
                
                if (!regex.test(inputvalues)) {
                    $("#introducedByEmailID").val("");
                    document.getElementById("introducedByEmailID").focus();
                    swal.fire("Alert", "Invalid Email ID", "warning");
                    document.getElementById("introducedByEmailID").focus();
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

                    swal.fire("Alert", "Invalid Email Id", "warning");
                    return regex.test(inputvalues);
                }
            });
        });

        
        
        
        
        
        
        
        function sendToServer() {
        
        	 console.log("Inside Step One");
             var mandFields = "introducedByName,introducedByEmailID,bpCode,suppName";
             var mandFieldsArr = mandFields.split(",");
             for (i = 0; i < mandFieldsArr.length; i++) {
                 console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                 if (document.getElementById(mandFieldsArr[i]).value == '') {
                     notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                    
                     console.log("mandatory Check :: " + mandFieldsArr[i]);
                     
                     return false;
                 }
             }
        	
           /*  var element = document.getElementById('states');
        	var element=[...element.options].filter(ele => ele.selected).map(ele => ele.text);
        	var selectedValues = [];    
            $("#states :selected").each(function(){
                selectedValues.push($(this).val()); 
            }); */
            /* if(selectedValues== ""){
            	swal.fire("Alert", "Please Select Business Partner Type", "warning")
                return regex.test(inputvalues);
            } */
           
        	
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
                        "vendorType": row.cells[4].innerHTML,
                        "partnerType": row.cells[5].innerHTML,
                        "compGstn": row.cells[6].innerHTML,
                        "addDetails": row.cells[7].innerHTML
                };
                addressDetailsArray.push(objs);
            }

            var partnerType=document.getElementById("partnerType").value
            
            if(addressDetailsArray.length==0 ){
            	
            	swal.fire("Alert", "Please Add Address Details", "warning")
                return false;
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
            
            if(contactDetailsArray.length==0  ){
            	
				swal.fire("Alert", "Please Add Contact Details", "warning")
                return false;
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
                        "accoutName": row.cells[5].innerHTML
                }
                accountDetailsArray.push(pushObj);
            }

            if(accountDetailsArray.length==0 ){
            	
            	swal.fire("Alert", "Please Add Account Details", "warning")
                return false;
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
            
            var mandFields = "invoiceCurrency,paymentCurrency,creditTerms,paymentMethod";
            var mandFieldsArr = mandFields.split(",");
            for (i = 0; i < mandFieldsArr.length; i++) {
                console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                if (document.getElementById(mandFieldsArr[i]).value == '') {
                    notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                    console.log("mandatory Check :: " + mandFieldsArr[i]);
                    return false;
                }
            }
            console.log("Inside Step Four");
            if ($("#tdsApplication").val() == "Yes") {
               var mandFields = "tdsSection,tdsRate";
               var mandFieldsArr = mandFields.split(",");
               for (i = 0; i < mandFieldsArr.length; i++) {
                   console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                   if (document.getElementById(mandFieldsArr[i]).value == '') {
                       notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                       console.log("mandatory Check :: " + mandFieldsArr[i]);
                       return false;
                   }
               }
            }
            
            /* if ($("#partnerType").val() == "Ad-Hoc" || $("#partnerType").val() == "Scheduled") {  */
        		  
        		  var mandFields = "CCFile,ITRFile,MSMECFile";
                  var mandFieldsArr = mandFields.split(",");

                  for (i = 0; i < mandFieldsArr.length; i++) {
                      console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                      if (document.getElementById(mandFieldsArr[i]).value == '') {
                          notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                          console.log("mandatory Check :: " + mandFieldsArr[i]);
                          return false;
                      }
                  }
        	   /* }  */
        	   /* else{
        		  var mandFields = "suppName";
                  var mandFieldsArr = mandFields.split(",");
                  for (i = 0; i < mandFieldsArr.length; i++) {
                      console.log("vslue " + document.getElementById(mandFieldsArr[i]).value);
                      if (document.getElementById(mandFieldsArr[i]).value == '') {
                          notifyTooltip(mandFieldsArr[i], "mandatory Field", "top")
                          console.log("mandatory Check :: " + mandFieldsArr[i]);
                          return false;
                      }
                  }
        	  } */ 

            
            
            $body.addClass("loading");

            var step1Obj = FormDataToJSON('stepOneForm');
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
           
            if (document.getElementById("NMISFile").files.length > 0) {
                finalObj.nmisFileName = document.getElementById("NMISFile").files.item(0).name;
                finalObj.nmisFileText = $("#NMISFileText").val();
            }
            
            // last three year ITR file upload
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

            /* var checked = []
            
            
            $("input[name='option[]']:checked").each(function() {
                checked.push($(this).val());
            });

            let values = checked.toString();
            console.log(values); */
            
           var values= document.getElementById("roleId").value ;
            
            
            
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
                    	 
                    	swal.fire("Vendor onboarding request sucessfully register", "Process ID : " + response.data, "success", "OK").then(function() {
                           
                            
                        	window.close();
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

        function handleFileSelect(evt, id) {
            var f = evt.target.files[0]; // FileList object
            var reader = new FileReader();
            // Closure to capture the file information.
            reader.onload = (function(theFile) {
                return function(e) {
                    var binaryData = e.target.result;
                    //Converting Binary Data to base 64
                    var base64String = window.btoa(binaryData);
                    //showing file converted to base64
                    console.log(base64String);

                    $("#" + id).val(base64String);

                    //  document.getElementById(evt.target.id + 'Text').value = base64String;
                    //alert('File converted to base64 successfuly!\nCheck in Textarea');
                };
            })(f);
            // Read in the image file as a data URL.
            reader.readAsBinaryString(f);
        }

           /*  getEntityName();
         function getEntityName(){
         	
         	var myForm="";
         	myForm = document.getElementById("stepSevenForm");
         	
         	for (var i = 0; i < myForm.elements.length; i++) {
                
               	var idOfElement=myForm.elements[i].id;
               	
               	if(idOfElement!=""){
               		
                    console.log(idOfElement);
                     		
               	}
               }	
         }  */    

         
         
          
         function notifyTooltip(controlName, tooltipMessage, tooltipPlacement) {
             try {
                 if (controlName != null && controlName != '' && tooltipMessage != null && tooltipMessage != '' && tooltipPlacement != null && tooltipPlacement != '') {
 				
                 	 if(controlName=="introducedByName"){
                 		 swal.fire("Alert", "Introducer Name is mandatory", "warning")
                          .then((value) => {});
                 		 
                 	 }
                 	 else  if(controlName=="introducedByEmailID"){
                    	  
                   	   swal.fire("Alert", "Introducer Email Id is mandatory", "warning")
                          .then((value) => {});
                      } 
                 	 else  if(controlName=="bpCode"){
                    	  
                      	   swal.fire("Alert", "Business Partner Code is mandatory", "warning")
                             .then((value) => {});
                         }
                 	/* else  if(controlName=="states"){
                 	  
                 	   swal.fire("Alert", "Business Partner Type is mandatory", "warning")
                        .then((value) => {});
                    } */
                 	else  if(controlName=="suppName"){
                   	  
                  	   swal.fire("Alert", "Business Partner Name is mandatory", "warning")
                         .then((value) => {});
                     }
                 	
                 	else  if(controlName=="panNumber"){
                   	  
                    	   swal.fire("Alert", "PAN Number is mandatory", "warning")
                           .then((value) => {});
                       }
                 	
                 	 else  if(controlName=="creditTerms"){
                       	  
                     	   swal.fire("Alert", "Payment / Credit Terms is mandatory", "warning")
                            .then((value) => {});
                        }
                 	 else  if(controlName=="paymentMethod"){
                      	  
                   	   swal.fire("Alert", "Payment Method is mandatory", "warning")
                          .then((value) => {});
                      }
                 	  else  if(controlName=="tdsSection"){
                    	  
                   	   swal.fire("Alert", "TDS Section is mandatory", "warning")
                          .then((value) => {});
                      }
               	 else  if(controlName=="tdsRate"){
                  	  
                 	   swal.fire("Alert", "TDS Rate is mandatory", "warning")
                        .then((value) => {});
                    } 
                 	 
              
                 	 
               /* 	else  if(controlName=="GSTFile"){
                	  
              	   swal.fire("Alert", "GST Certificate is mandatory", "warning")
                     .then((value) => {});
                 } */
               	/* else  if(controlName=="PDFile"){
                  	  
               	   swal.fire("Alert", "Proprietorship Declaration is mandatory", "warning")
                      .then((value) => {});
                  }
               	else  if(controlName=="PANFile"){
                  	  
               	   swal.fire("Alert", "PAN Card is mandatory", "warning")
                      .then((value) => {});
                  } */
               	else  if(controlName=="CCFile"){
                	  
                	   swal.fire("Alert", "Cancelled Cheque/ Passbook/ Bank Statement  is mandatory", "warning")
                       .then((value) => {});
                   }
               	else  if(controlName=="ITRFile"){
                	  
                	   swal.fire("Alert", "ITR Filling Declaration is mandatory", "warning")
                       .then((value) => {});
                   }
               
               	else  if(controlName=="MSMECFile"){
                	  
                	   swal.fire("Alert", "MSME Certificate is mandatory", "warning")
                       .then((value) => {});
                   }
               	else  if(controlName=="AMFile"){
                	  
                	   swal.fire("Alert", "Approval Mail is mandatory", "warning")
                       .then((value) => {});
                   }
               	else  if(controlName=="NMISFile"){
                	  
                	   swal.fire("Alert", "Name Mismatch Affidavit is mandatory", "warning")
                       .then((value) => {});
                   }
                 	
                    // $('#manPara').css('display', '');
                    // addValCss(controlName);
                     $("#" + controlName).focus();
                 } else {
                     console.log('Values Are Passed As Empty Or Null In notifyTooltip()');
                 }
             } catch (err) {

             }
         } 
 
       
        
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
                            //return false;
                        }
                    }
                });
            });
        	function select(){
    			
				var element = document.getElementById('states');
	        	var element=[...element.options].filter(ele => ele.selected).map(ele => ele.text);
	        	var selectedValues = [];    
	            $("#states :selected").each(function(){
	                selectedValues.push($(this).val()); 
	            });
	           // alert(selectedValues);
	            
	            let values = selectedValues.toString();
	         
	        	document.getElementById("roleId").value=values;
	        	//alert("roleId111: "+num);
		
				
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
				
				console.log(busClassif);
				
				if (busClassif !== "Other Enterprise" ) {
					document.getElementById("mesmeNumber").disabled = false;
					
				}
				else {
					document.getElementById("mesmeNumber").disabled = true;
					document.getElementById("mesmeNumber").value = "";
					
				} if(busClassif ==""){
					document.getElementById("mesmeNumber").disabled = true;
					document.getElementById("mesmeNumber").value = "";
				}
				
			}
			
        	
			function region1(){
			
				
			}
	       
			function checkForExistingUserName() {

	            var usernameCheckStatus = "false";

	            if ($("#bpCode").val() != "") {

	                var json = {
	                    "username": $("#bpCode").val(),

	                }
	                $.ajax({
	                    type: "POST",
	                    data: JSON.stringify(json),
	                    url: "<%=GlobalUrl.checkForExistingUserName%>",
	                    dataType: "json",
	                    contentType: "application/json",
	                    async: false,
	                    success: function(data) {

	                        if (data.msg == 'exist') {

	                            Toast.fire({
	                                type: 'warning',
	                                title: 'UserName Already Exists..'
	                            })

	                            $("#bpCode").val('');
	                            return false;

	                        } else if (data.msg == 'success') {
	                            usernameCheckStatus = "true";
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

	            return usernameCheckStatus;
	        }
			
    </script>

	<script
		src="https://cdn.jsdelivr.net/npm/smartwizard@4.3.1/dist/js/jquery.smartWizard.min.js"></script>
	<script src="plugins/popper/umd/popper.min.js"></script>
	<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="dist/css/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>
	<script src="plugins/js/off-canvas.js"></script>
	<script src="plugins/js/hoverable-collapse.js"></script>
	<script src="plugins/js/misc.js"></script>
</body>
</html>
