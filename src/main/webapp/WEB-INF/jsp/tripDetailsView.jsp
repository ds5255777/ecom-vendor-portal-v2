<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- By Prashant Aggarwal 3-jun-2021 -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Trip detail View</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
    <style>
        custom-file-input {
            height: 25px;
            font-size: 14px;
        }

        .custom-file {
            height: 25px;
            font-size: 14px;
            padding-bottom: 35px;
            font-size: 14px;
        }

        .custom-file-label::after {
            height: auto !important;
        }

        .swal-modal {
            width: 350px !important;
        }

        .custom-file-label {
            padding-bottom: 23px;
            height: 25px;
            font-size: 14px;
        }

        .tableheading {
            font-size: 15px;
            font-weight: bold;
        }

        label {
            font-weight: 500;
            margin-bottom: 1px;
        }

        .form-control {
            height: 25px;
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

        .observedScoreheading {
            width: 60px !important;
        }

        .serialNoheading {
            width: 60px !important;
        }

        .documentheading {
            width: 500px;
        }

        .attachmentheading {
            width: 500px;
        }

        .helpheading {
            width: 60px !important;
        }

        .tooltip.show p {
            text-align: left;
        }

        /* .maximumScoreheading {
	width: 60px !important;
}

.remarkheading {
	width: 25%;
}

.descriptionheading {
	width: 25%;
} */

    </style>
</head>

<body>
    <!-- <div class="wrapper"> -->

    <jsp:include page="loader.jsp" />

    <!-- Main content -->
    <!-- <section class="content mt-2"> -->
    <div class="container-fluid">

        <!-- form start -->
        <form role="form" id="form1" autocomplete="off">
            <c:forEach items="${getTripDetailsById}" var="tripDetail">
                <div class="row">
                    <div class="col-md-12" style="font-size: 14px;">
                        <!-- general form elements -->
                        <div class="card card-primary">
                            <div class="card-header" style="padding: 5px 0px 0px 11px;">
                                <h3 class="card-title" style="font-size: 15px;">Trip Details</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <label for="Trp ID">Trip ID</label> <input type="text" class="form-control p-input" readonly id="tripID" value="${tripDetail.tripID}" name="tripID">
                                    </div>
                                    <div class="col-sm-3">
                                        <label> Field Specialist</label> <input type="text" id="fieldSpecialty" name="fieldSpecialty" class="form-control">
                                    </div>
                                    <div class="col-sm-3">
                                        <label> Company Address </label> <input type="text" id="companyAddress" name="companyAddress" class="form-control">
                                    </div>
                                    <div class="col-sm-3">
                                        <label> Vendor Assessed For Material/Equipment </label> <input type="text" name="vendorAssessedMaterial" id="vendorAssessedMaterial" class="form-control">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <label> Name of Contact Person </label> <input type="text" id="contactPersonName" name="contactPersonName" class="form-control">
                                    </div>
                                    <div class="col-sm-3">
                                        <label> Rating of Material/Equipment</label> <input type="text" id="materialRating" name="materialRating" class="form-control">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Contact No.</label>
                                        <div class="row">
                                            <div class="col-sm-5">

                                            </div>
                                            <div class="col-sm-7">
                                                <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" name="contactNumber" id="contactNumber" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Category of Material/Equipment</label> <input type="text" name="materialCategory" id="materialCategory" class="form-control">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <label>Self Assessment Date</label> <input type="text" readonly name="assessmentDate" id="assessmentDate" class="form-control">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Assessed By</label> <input type="text" name="assessedBy" id="assessedBy" class="form-control">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Email</label> <input type="email" name="email" id="email" class="form-control">
                                    </div>


                                </div>
                            </div>
                            <!-- /.card-body -->

                        </div>

                    </div>
                </div>





            </c:forEach>
        </form>

    </div>

    </section>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button);
        $.widget.bridge('uitooltip', $.ui.tooltip);

    </script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/sparklines/sparkline.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="plugins/chart.js/Chart.min.js"></script>

    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
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
    <script src="js/common.js"></script>
    <script src="js/commonFunctions.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <%-- <script type="text/javascript">
	
$(document).ready(function() {
		
	$.ajax({
      	type: "POST",
  		data:  "",
  		url: "<%=GlobalUrl.getCurrentDate%>",
    dataType : "json",
    contentType : "application/json",
    async : false,
    success : function(data) {
    $("#assessmentDate").val(data.data);

    },
    error : function(jqXHR, textStatue, errorThrown) {
    alert("failed, please try again");
    }

    });


    })

    var arrayAttachment = [];
    var vendorMisDoc = [];
    $(document).ready(function() {
    var bootstrapTooltip = $.fn.tooltip.noConflict();
    $.fn.bstooltip = bootstrapTooltip;
    $('.bootToolTip').bstooltip();
    })

    const Toast = Swal.mixin({
    toast : true,
    position : 'top-end',
    showConfirmButton : false,
    timer : 3000
    });

    var todayDate=moment().format("YYYY-MM-DD");
    var base64DataOfGrpah="";

    /* $('#assessmentDate').datepicker({
    dateFormat : 'yy-mm-dd',
    changeMonth : true,
    changeYear : true,
    minDate: todayDate


    }); */

    //$('#assessmentDate').val(todayDate);

    function handleFileSelect(evt,e) {
    var wholeobjData=e;
    var row = e.closest("tr");

    console.log(row.innerText);
    var tdcellValue=row.innerText;
    tdcellValue=tdcellValue.split("Choose")[0];
    tdcellValue = replaceAllSpecialCharacter(tdcellValue);
    tdcellValue = tdcellValue.trim();
    console.log("tdcellValue.33."+tdcellValue);


    console.log("start selecting file");
    var f = evt.target.files[0]; // FileList object
    // console.log("printing f >> "+f);
    var reader = new FileReader();
    reader.onload = (function(theFile) {
    return function(e) {
    var binaryData = e.target.result;
    var base64String = window.btoa(binaryData);

    var fileName = f.name;
    var extension = fileName.substring(fileName.lastIndexOf(".") , fileName.length);
    fileName = fileName.substring(0 , fileName.lastIndexOf("."));
    tdcellValue=tdcellValue.split(" ")[0];
    fileName = replaceAllSpecialCharacter(fileName);
    fileName = tdcellValue+"("+fileName+")";
    fileName = fileName+extension;
    console.log("final File Name >> "+fileName);
    var showfiles = "";
    var obj = {
    "filename" : fileName,
    "file" : base64String,
    "objData":wholeobjData
    }

    if(arrayAttachment.length>0){
    var indexValueAtTheTimeOfremoval = "";
    for(var k=0;k<arrayAttachment.length;k++){ indexValueAtTheTimeOfremoval="" ; var replaceableVal=tdcellValue.split(" ")[0];
						   
							if(arrayAttachment[k].filename.includes(replaceableVal)){								 
								indexValueAtTheTimeOfremoval = k;
								break;
							}
						}							
						if($.isNumeric(indexValueAtTheTimeOfremoval)){							
							arrayAttachment.splice(indexValueAtTheTimeOfremoval,1);						
							indexValueAtTheTimeOfremoval="";
						}
						
					}
					
					arrayAttachment.push(obj);
					showUploadedVendorOnBoardingDocument();
					console.log(" array size on filling>> "
        + arrayAttachment.length);

        evt.target.value='';

        };
        })(f);
        // Read in the image file as a data URL.
        reader.readAsBinaryString(f);
        }

        function handleFileSelect2(evt,spanId) {

        console.log(spanId);
        var f = evt.target.files[0]; // FileList object
        var reader = new FileReader();
        // Closure to capture the file information.
        reader.onload = (function (theFile) {
        return function (e) {
        var binaryData = e.target.result;
        //Converting Binary Data to base 64
        var base64String = window.btoa(binaryData);


        var showfiles="";
        var fileName = f.name;
        var extension = fileName.substring(fileName.lastIndexOf(".") , fileName.length);
        fileName = fileName.substring(0 , fileName.lastIndexOf("."));
        fileName = replaceAllSpecialCharacter(fileName);
        fileName = fileName+extension;

        var obj={
        "filename":fileName,
        "file":base64String
        }
        vendorMisDoc.push(obj);
        showUploadedFilesData();

        };
        })(f);
        // Read in the image file as a data URL.
        reader.readAsBinaryString(f);
        }

        function deleteData(id,spanId){

        vendorMisDoc.splice(id, 1);
        showUploadedFilesData();

        }

        function showUploadedFilesData(){

        var showfiles="";
        var spanId="showUploadFilesTata";
        for(var i=0; i < vendorMisDoc.length ; i++){ var inactive="<button type=\" button\" class=\"btn btn-primary btn-xs\" onclick=\"deleteData("+i+",'"+spanId+"');\"><i class=\"fa fa-trash-o\"></i> </button>";
            showfiles +=vendorMisDoc[i].filename+"&nbsp;&nbsp;&nbsp;&nbsp;"+inactive+"<br>";
            }

            $("#"+spanId).html(showfiles);
            }

            function deleteDataVendorOnBoardingDocument(id,spanId){
            var objData=arrayAttachment[id].objData;

            $(objData).next('.custom-file-label').html("Choose");
            arrayAttachment.splice(id, 1);
            showUploadedVendorOnBoardingDocument();

            }

            function showUploadedVendorOnBoardingDocument(){

            var showfiles="";
            var spanId="showUploadVendorOnBoardingDocument";
            for(var i=0; i < arrayAttachment.length ; i++){ var inactive="<button type=\" button\" class=\"btn btn-primary btn-xs\" onclick=\"deleteDataVendorOnBoardingDocument("+i+",'"+spanId+"');\"><i class=\"fa fa-trash-o\"></i> </button>";
                showfiles +=arrayAttachment[i].filename+"&nbsp;&nbsp;&nbsp;&nbsp;"+inactive+"<br>";
                }

                $("#"+spanId).html(showfiles);
                }

                $.validator.setDefaults({
                submitHandler : function() {
                saveSelfAssessmentForm();

                //alert("insode add");
                }
                });
                $('#selfAssessmentEvaluationForm').validate({

                rules : {
                vendorName : {
                required : true

                },
                countryCode : {
                required : true

                },
                companyAddress : {
                required : true

                },
                email : {
                email:true,
                required : true

                },
                contactPersonName : {
                required : true

                },
                contactNumber : {
                required : true

                },
                assessmentDate : {
                required : true

                },
                fieldSpecialty : {
                required : true

                },
                vendorAssessedMaterial : {
                required : true

                },
                materialRating : {
                required : true

                },
                iSOCertificate9001 : {
                required : true

                },
                iSOCertificate14001 : {
                required : true

                },
                iSOCertificate45001 : {
                required : true

                },
                materialCategory : {
                required : true

                },
                assessedBy : {
                required : true

                },
                certificateofIncorporation : {
                required : true

                },
                companyProfile : {
                required : true

                },
                solarBackground : {
                required : true

                },
                balanceSheetwithProfitAndLoss : {
                required : true

                },
                organizationChart : {
                required : true

                },
                manpowerDetails : {
                required : true

                },
                employeeInsurancePolicy : {
                required : true

                },
                iSOCertificate : {
                required : true

                },
                qualityPolicy : {
                required : true

                },
                ehsPolicyAndPollutionControlDocument : {
                required : true

                },
                manufacturingCapacityReport : {
                required : true

                },
                processFlowChart : {
                required : true

                },
                plantAndMachineryDetails : {
                required : true

                },
                qap : {
                required : true

                },
                inHouseTestingAndLabFacilities : {
                required : true

                },
                typeTestReport : {
                required : true

                },
                customerApprovedProfile : {
                required : true

                },
                pastExperienceDetails : {
                required : true

                },
                performanceCertificate : {
                required : true

                }

                },

                errorElement : 'span',
                errorPlacement : function(error, element) {
                error.addClass('invalid-feedback');
                element.closest('.form-group').append(error);
                },
                highlight : function(element, errorClass, validClass) {
                $(element).addClass('is-invalid');
                },
                unhighlight : function(element, errorClass, validClass) {
                $(element).removeClass('is-invalid');
                }
                });

                function saveSelfAssessmentForm() {

                var flag = false;
                var index = 0;
                var generalRequirment = $("#generalRequirmentTable tbody");
                generalRequirment.find('tr').each(function (i, el) {
                index++;
                var $tds = $(this).find('td'),
                //attachment = $(this).find("td:eq(2) input[type='file']").val();
                attachment = $(this).find('td')[2].innerText;
                score = $(this).find("td:eq(3) input[type='text']").val();
                if( attachment.toUpperCase() == "CHOOSE"){
                if($.isNumeric(score)){
                if(score !=0){
                flag = true;
                return false;
                }
                }
                }
                });

                if(flag){
                Toast.fire({
                type: 'warning',
                title: 'Please select document in General Requirment at row'+index
                })

                return;
                }
                index = 0;
                var msgForCertification="";
                var certification = $("#certificationTable tbody");
                var attachment = "";
                var score = "";
                certification.find('tr').each(function (i, el) {


                //if($("#iSOCertificate9001").val())
                var $tds = $(this).find('td');
                attachment = "";
                score = "";

                if(index==0){
                msgForCertification="Please select document in Certification at row 1 for 9001";
                //attachment = $(this).find("td:eq(3) input[type='file']").val();
                attachment = $(this).find('td')[3].innerText;
                score = $(this).find("td:eq(4) input[type='text']").val();
                }
                else if(index==1 || index==2){
                if(index==1){
                msgForCertification="Please select document in Certification at row 1 for 14001";
                }else{
                msgForCertification="Please select document in Certification at row 1 for 18001/45001";
                }

                // attachment = $(this).find("td:eq(1) input[type='file']").val();
                attachment = $(this).find('td')[1].innerText;
                score = $(this).find("td:eq(2) input[type='text']").val();
                }
                else {
                msgForCertification="Please select document in Certification at row "+(index-1);
                //attachment = $(this).find("td:eq(2) input[type='file']").val();
                attachment = $(this).find('td')[2].innerText;
                score = $(this).find("td:eq(3) input[type='text']").val();
                }

                index++;
                if(attachment.toUpperCase() == "CHOOSE"){
                if($.isNumeric(score)){
                if(score !=0){
                flag = true;
                return false;
                }
                }
                }
                });

                if(flag){

                attachment = "";
                score = "";

                Toast.fire({
                type: 'warning',
                title: msgForCertification
                })

                return;
                }

                index = 0;
                var manufacturingTable = $("#manufacturingTable tbody");
                manufacturingTable.find('tr').each(function (i, el) {
                index++;
                var $tds = $(this).find('td'),
                /* attachment = $(this).find("td:eq(2) input[type='file']").val();
                score = $(this).find("td:eq(3) input[type='text']").val();

                if(attachment ==""){ */
                attachment = $(this).find('td')[2].innerText;
                score = $(this).find("td:eq(3) input[type='text']").val();
                if( attachment.toUpperCase() == "CHOOSE"){
                if($.isNumeric(score)){
                if(score !=0){
                flag = true;
                return false;
                }
                }
                }
                });

                if(flag){
                Toast.fire({
                type: 'warning',
                title: 'Please select document in Manufacturing at row'+index
                })

                return;
                }
                index = 0
                var qualityControlTable = $("#qualityControlTable tbody");
                qualityControlTable.find('tr').each(function (i, el) {
                index++;
                var $tds = $(this).find('td'),
                /* attachment = $(this).find("td:eq(2) input[type='file']").val();
                score = $(this).find("td:eq(3) input[type='text']").val();
                if(attachment ==""){ */
                attachment = $(this).find('td')[2].innerText;
                score = $(this).find("td:eq(3) input[type='text']").val();
                if( attachment.toUpperCase() == "CHOOSE"){
                if($.isNumeric(score)){
                if(score !=0){
                flag = true;
                return false;
                }
                }
                }
                });

                if(flag){
                Toast.fire({
                type: 'warning',
                title: 'Please select document in Quality Control at row'+index
                })

                return;
                }

                index = 0
                var customerAndPastProjectTable = $("#customerAndPastProjectTable tbody");
                customerAndPastProjectTable.find('tr').each(function (i, el) {
                index++;
                var $tds = $(this).find('td'),
                /* attachment = $(this).find("td:eq(2) input[type='file']").val();
                score = $(this).find("td:eq(3) input[type='text']").val();
                if(attachment ==""){ */
                attachment = $(this).find('td')[2].innerText;
                score = $(this).find("td:eq(3) input[type='text']").val();
                if( attachment.toUpperCase() == "CHOOSE"){
                if($.isNumeric(score)){
                if(score !=0){
                flag = true;
                return false;
                }
                }
                }
                });

                if(flag){
                Toast.fire({
                type: 'warning',
                title: 'Please select document in Customer And Past Project at row'+index
                })

                return;
                }

                $("#SubmitBtn").prop("disabled",true);

                $('.loader').show();

                var obj = FormDataToJSON('selfAssessmentEvaluationForm');

                var countryCode = $("#countryCode").val();
                var phnNo = countryCode+$("#contactNumber").val();
                obj.contactNumber = phnNo;
                obj['attachment'] = arrayAttachment;
                obj['type'] = '<%=GlobalConstants.SUPPLIER_FORM_TYPE1%>';
                obj['status'] = '<%=GlobalConstants.SUPPLIER_ONBOARDED_STATUS%>';
                obj.source = "supplier";
                obj.isReassessment = "<%= GlobalConstants.IS_REASSESSMENT_NO%>";
                obj['vendorMiscellaneousAttachment'] = vendorMisDoc;
                obj.base64DataOfGrpah=base64DataOfGrpah.split("data:image/png;base64,")[1];

                //return;
                $.ajax({
                type : "POST",
                url : "<%=GlobalUrl.saveOnBoarding %>",
                data : JSON.stringify(obj),
                dataType : "json",
                contentType : "application/json",
                success : function(response) {
                console.log("successs");

                $('.loader').hide();
                $("#SubmitBtn").prop("disabled",false);
                if (response.msg == "success") {

                swal({
                title: "Successfully Added",
                text: "Tracker ID : "+response.data,
                icon: "success",
                }).then((value) =>{
                location.reload();
                });


                arrayAttachment = [];
                } else {
                $("#SubmitBtn").prop("disabled",false);
                Toast.fire({
                type : 'error',
                title : 'Failed Added..'
                })
                }
                },
                error : function(jqXHR, textStatue, errorThrown) {
                console.log("error");
                $("#SubmitBtn").prop("disabled",false);
                $('.loader').hide();
                console.log("error " + JSON.stringify(jqXHR));
                console.log("error " + textStatue);
                console.log("error " + errorThrown);

                Toast.fire({
                type : 'error',
                title : 'Failed Added..'
                })

                }
                });

                }

                function calculatetableTotal() {

                var generalRequirmentTableTextSum = 0;
                var certificationTableTextSum = 0;
                var manufacturingTableTextSum = 0;
                var qualityControlTableTextSum = 0;
                var customerAndPastProjectTableTextSum = 0;

                $(".generalRequirmentTableText").each(function() {

                var inputType = $(this).val();
                if(!inputType==""){
                if($.isNumeric( inputType )){
                generalRequirmentTableTextSum += +$(this).val();
                }else{
                $(this).val("NA");
                }

                }


                });
                $(".certificationTableText").each(function() {

                var inputType = $(this).val();
                if(!inputType==""){
                if($.isNumeric( inputType )){
                certificationTableTextSum += +$(this).val();
                }else{
                $(this).val("NA");
                }
                }

                });
                $(".manufacturingTableText").each(function() {

                var inputType = $(this).val();
                if(!inputType==""){
                if($.isNumeric( inputType )){
                manufacturingTableTextSum += +$(this).val();
                }else{
                $(this).val("NA");
                }
                }

                });
                $(".qualityControlTableText").each(function() {
                var inputType = $(this).val();
                if(!inputType==""){
                if($.isNumeric( inputType )){
                qualityControlTableTextSum += +$(this).val();
                }else{
                $(this).val("NA");
                }
                }
                });
                $(".customerAndPastProjectTableText").each(function() {
                var inputType = $(this).val();
                if(!inputType==""){
                if($.isNumeric( inputType )){
                customerAndPastProjectTableTextSum += +$(this).val();
                }else{
                $(this).val("NA");
                }
                }
                });

                /* console.log(" generalRequirmentTableTextSum >>"+generalRequirmentTableTextSum);
                console.log(" certificationTableTextSum >>"+certificationTableTextSum);
                console.log(" manufacturingTableTextSum >>"+manufacturingTableTextSum);
                console.log(" qualityControlTableTextSum >>"+qualityControlTableTextSum);
                console.log(" customerAndPastProjectTableTextSum >>"+customerAndPastProjectTableTextSum); */

                $("#generalRequriementTotalObservedScore").val(generalRequirmentTableTextSum);
                $("#certicationTotalObservedScore").val(certificationTableTextSum);
                $("#maufacturingTotalObservedScore").val(manufacturingTableTextSum);
                $("#qualityControlTotalObservedScore").val(qualityControlTableTextSum);
                $("#customerPastProjectTotalObservedScore").val(customerAndPastProjectTableTextSum);


                var total = generalRequirmentTableTextSum+certificationTableTextSum +manufacturingTableTextSum +qualityControlTableTextSum +customerAndPastProjectTableTextSum;
                $("#grandTotalObservedScore").val(total);

                //setTimeout(calculateGrandTotalValue, 1000);
                drawGraphData()
                }

                drawGraphData();

                var salesChart;
                var barChart ;
                drawGraphData();

                function drawGraphData(){

                console.log("... show graph...");

                $("#barChartDiv").css("display","block");

                var generalRequriementTotalObservedScore=$("#generalRequriementTotalObservedScore").val();
                var certicationTotalObservedScore=$("#certicationTotalObservedScore").val();
                var maufacturingTotalObservedScore=$("#maufacturingTotalObservedScore").val();
                var qualityControlTotalObservedScore=$("#qualityControlTotalObservedScore").val();
                var customerPastProjectTotalObservedScore=$("#customerPastProjectTotalObservedScore").val();



                var mode = 'index';

                var intersect = true;

                var barChartOptions = {
                responsive : true,
                maintainAspectRatio : false,
                datasetFill : false,
                animation: {
                onComplete: done
                },
                hover: {
                mode : mode,
                intersect: intersect
                },
                scales: {
                yAxes: [{
                ticks: {
                beginAtZero: true
                }
                }]
                },
                legend: {
                onClick: (e) => e.stopPropagation()
                }
                }
                var areaChartData = {
                labels : ['GENERAL REQUIREMENTS', 'CERTIFICATION', 'MANUFACTURING', 'QUALITY CONTROL', 'CUSTOMER & PAST PROJECT'],
                datasets: [
                {
                label : 'Maximum Score',
                backgroundColor : '#c44040',
                borderColor : '#c44040',
                pointRadius : false,
                pointColor : '#3b8bba',
                pointStrokeColor : 'rgba(60,141,188,1)',
                pointHighlightFill : '#fff',
                pointHighlightStroke: 'rgba(60,141,188,1)',
                data : [26, 16, 20, 16, 22]
                },
                {
                label : 'Observed Score',
                backgroundColor : '#90EE90',
                borderColor : '#90EE90',
                pointRadius : false,
                pointColor : 'rgba(210, 214, 222, 1)',
                pointStrokeColor : '#c1c7d1',
                pointHighlightFill : '#fff',
                pointHighlightStroke: 'rgba(220,220,220,1)',
                data : [generalRequriementTotalObservedScore, certicationTotalObservedScore, maufacturingTotalObservedScore, qualityControlTotalObservedScore, customerPastProjectTotalObservedScore]
                },
                ]
                }


                var barChartCanvas = document.getElementById("barChart").getContext("2d");
                var barChartData = jQuery.extend(true, {}, areaChartData);
                var temp0 = areaChartData.datasets[0];
                var temp1 = areaChartData.datasets[1];
                barChartData.datasets[1] = temp1;
                barChartData.datasets[0] = temp0;


                if (barChart) {
                barChart.destroy();
                }

                barChart = new Chart(barChartCanvas, {
                type: 'bar',
                data: barChartData,
                options: barChartOptions
                })

                }
                function done(){
                // alert("haha");
                base64DataOfGrpah=barChart.toBase64Image();
                // console.log(base64DataOfGrpah);
                // document.getElementById("url").src=url;
                }



                </script> --%>

</body>

</html>
