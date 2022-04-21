<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titleName}|InvoiceProcess</title>
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- Select2 -->
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <!-- Bootstrap4 Duallistbox -->
    <link rel="stylesheet" href="plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
    <!-- BS Stepper -->
    <link rel="stylesheet" href="plugins/bs-stepper/css/bs-stepper.min.css">
    <!-- dropzonejs -->
    <link rel="stylesheet" href="plugins/dropzone/min/dropzone.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/sweetalert2/sweetalert2.min.css">
    <style>
        .table td,
        .table th {
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

    </style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm">
    <div class="wrapper">
        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;"" >
			<!-- Left navbar links -->
			<h5 style=" color: white;">Invoice-Process</h5>
            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <!-- Navbar Search -->
                <h6 class="float-sm-right" style="color: white;">
                    <b>Invoice Number : </b> <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" readonly style="background: #007BFF; color: white; border: 0px;">
                </h6>
            </ul>
        </nav>

        <!-- /.navbar -->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper" style="margin-left: 0px !important;">
            <!-- Main content -->
            <section class="content" style="overflow: hidden;">
                <div class="container-fluid">
                    <!-- SELECT2 EXAMPLE -->
                    <div class="card card-primary" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">BASIC DETAILS</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="stepOneForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Partner Name <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="vendorName" id="vendorName" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Partner Code <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Business Partner Code" name="vendorCode" id="vendorCode" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Site Name <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <!-- <input class="form-control-sm" type="text" placeholder="Site Name" name="siteName" id="siteName" style="width: 100%;"> -->
                                                <select class="form-control-sm select2" style="width: 100%;" id="siteName" name="siteName">
                                                    <option value="Site_1">Site 1</option>
                                                    <option value="Site_2">Site 2</option>
                                                    <option value="Site_3">Site 3</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                            <input type="hidden" id="id" name="id" disabled>
                                                <input type="date" name="invoiceDate" id="invoiceDate" readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Number <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Number" name="invoiceNumber" id="invoiceNumber" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <select class="form-control-sm select2" style="width: 100%;" id="invoiceCurrency" name="invoiceCurrency">
                                                    <option value="INR">INR</option>
                                                    <option value="USD">USD</option>
                                                    <option value="KES">KES</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Receiving Date</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="invoiceReceivingDate" id="invoiceReceivingDate" readonly value="<%=(new java.util.Date()).toLocaleString()%>" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Taxable Amount</label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="taxableAmount" id="taxableAmount" type="text" placeholder="Taxable Amount" style="width: 100%;" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Tax Amount<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="taxAmount" id="taxAmount" type="number" placeholder="Tax Amount" onfocusout="calculateInvoice()" style="width: 100%;" on>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Amount <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="number" name="invoiceAmount" id="invoiceAmount" placeholder="Invoice Amount" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- /.card -->
                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Line Item's</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <form id="stepTwoForm" class="forms-sample">
                            <div class="card-body" style="overflow: auto;">
                                <table id="prTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                             <th style="padding: 5px 5px 5px 1.5rem;">Route</th> 
                                            <th style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Rate per km</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Current Fuel Rate</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">FS Base Rate</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">FS Diff</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Basic Freight</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">FS</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Actual KM</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Total Freight</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Line level Description</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </form>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                    <div class="card card-primary"  id="queryWindow" style="display: none;" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Remarks</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="queryForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group row">
										    <label class="col-sm-3" >Remarks <span class="text-danger">*</span></label>
										    <div class="col-sm-9">
										    <textarea class="form-control" id="comment" name="comment" rows="3" placeholder="Remarks if Any"></textarea>
										 </div>
										 </div>
                                    </div>
                                    <div class="col-md-6">
                                    <div class="col-md-3"  id="raiseQueryDiv">
								<button type="button" id="raiseQuery" value="raiseQuery"
									onclick="raiseQueryModel()" class="btn btn-primary">Replay
									</button>
								</div>
								</div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="row" >
						<div class="col-md-3"></div>
							<div class="col-md-2" style="display: none;"
								id="viewAttachmentDiv">
								<button type="button" id="viewAttachment"
									onclick="displayAttachmentForPoDetails()" value="viewAttachment"
									class="btn btn-primary btn-lg">View Attachment</button>
							</div>
							<div class="col-md-1" style="    margin-left: -102px;">
								<button type="button" onclick="closeWin()"
									class="btn btn-info btn-lg">Close</button>
							</div>
					</div>
                    <!-- /.row -->
                    
                    <div class="card card-primary" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Remarks List</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="queryForm" class="forms-sample">
                                <table class="table table-bordered table-hover"
														id="tabledataQuery">
														<thead>
															<tr>
																<th style="padding: 5px 5px 5px 1.5rem;">S.No</th>
																<th style="padding: 5px 5px 5px 1.5rem;">Raised By</th>
																<th style="padding: 5px 5px 5px 1.5rem;">Raised On</th>
																<th style="padding: 5px 5px 5px 1.5rem;">Remarks</th>
															</tr>
														</thead>
														<tbody>

														</tbody>
													</table>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Control sidebar content goes here -->
        </aside>
        <!-- /.control-sidebar -->
    </div>
    
    <!-- Document  Modal  -->
		
		<div class="modal fade" id="viewAttachmentPopUp" role="dialog">
        <div class="modal-dialog " style="max-width: 1300px;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-body">
                    <div class="container-fluid panel1">
                        <div class="row">
                            <div class="col">
                                <div class="row innerRow">
                                    
                                    
                                    <div class="col-md-8">
                                       <div class="form-group">
                                            <label>Document Name</label>
                                            <select class="form-control" id="multipleAttachment" style="height: 35px;" >
                                                
                                            </select>
                                             
                                        </div> 
                                    </div>
                                    <div class="col-md-3" style="display: none" id="uploadeddateDiv">
                                        <div class="form-group">
                                            <label>Uploaded Date</label>
                                            <input type="text" class="form-control" id="uploadeddate" style="height: 35px;" readonly>                                               
                                        </div>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid panel2">
                        <div class="row">                            
                            <div class="col-lg-12" style="height: 400px;">
                            <a id="ifrmameHref"   target="_blank">Click Here to open doc in new window</a>
                                <iframe id="pdfLink" style="height:100%; width:100%"  ></iframe>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                <button type="button"  class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap4 Duallistbox -->
    <script src="plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <!-- InputMask -->
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/inputmask/jquery.inputmask.min.js"></script>
    <!-- date-range-picker -->
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Bootstrap Switch -->
    <script src="plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
    <!-- BS-Stepper -->
    <script src="plugins/bs-stepper/js/bs-stepper.min.js"></script>
    <!-- dropzonejs -->
    <script src="plugins/dropzone/min/dropzone.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
    <!-- Page specific script -->
    <!-- DataTables  & Plugins -->
    <script src="js/commonFunctions.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>
    <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
    <script src="plugins/jquery-validation/additional-methods.min.js"></script>
    <script src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
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
    <!-- Select2 -->
    <script src="plugins/select2/js/select2.full.min.js"></script>

    <script>
        var prTable = $("#prTable").DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true,
            "pageLength": 15,
        });
        
        var tabledataQuery = $('#tabledataQuery').DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": []
        });
        
        var invoiceNumber = '${invoiceNumber}';
        var type = '${type}';
        var tripLineArray = [];
        setInvoiceDetails();
        
        showHideButton();

        function showHideButton(){
        
        	if( type =="Invoice Queue" || type =="Pending Queue" || type =="Approved Queue" ){
        		$("#prosInvBtn").css("display","block");
        		$("#viewAttachmentDiv").css("display","block");
        		$("#raiseQueryDiv").css("display","block");
        	}
        	else if( type =="Query Queue"  ){
        		$("#queryWindow").css("display","block");
        		$("#viewAttachmentDiv").css("display","block"); 
        	}
        }

        function closeWin() {
            window.close()
        }

        function setInvoiceDetails() {

            var obj = {
                "invoiceNumber": invoiceNumber
            }

            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getSelectInvoiceDetails%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                        tripLineArray = data.data.invoiceLineItem;
                        var myForm = "";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result);
                        $('#prTable').DataTable().clear();
                        for (var i = 0; i < tripLineArray.length; i++) {
                            if (!tripLineArray[i].hasOwnProperty("runType")) {
                                tripLineArray[i].runType = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("route")) {
                                tripLineArray[i].route = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("standardKM")) {
                                tripLineArray[i].standardKM = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("ratePerKm")) {
                                tripLineArray[i].ratePerKm = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("currentFuelRate")) {
                                tripLineArray[i].currentFuelRate = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("fsBaseRate")) {
                                tripLineArray[i].fsBaseRate = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("fsDiff")) {
                                tripLineArray[i].fsDiff = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("basicFreight")) {
                                tripLineArray[i].basicFreight = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("fs")) {
                                tripLineArray[i].fs = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("actualKM")) {
                                tripLineArray[i].actualKM = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("totalFreight")) {
                                tripLineArray[i].totalFreight = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("lumpsomeamount")) {
                                tripLineArray[i].lumpsomeamount = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("lineLevelDescription")) {
                                tripLineArray[i].lineLevelDescription = "";
                            }
                            $('#prTable').DataTable().row.add([tripLineArray[i].runType, tripLineArray[i].route, tripLineArray[i].standardKM, tripLineArray[i].ratePerKm, tripLineArray[i].currentFuelRate, tripLineArray[i].fsBaseRate, tripLineArray[i].fsDiff, tripLineArray[i].basicFreight, tripLineArray[i].fs, tripLineArray[i].actualKM, tripLineArray[i].totalFreight, tripLineArray[i].lineLevelDescription]);
                        }
                        $("#invoiceNumber").val(result.invoiceNumber);
                        $("#ecomInvoiceNumber").val(result.ecomInvoiceNumber);
                        $('#prTable').DataTable().draw();
                        $("tbody").show();
                    } else {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    Toast.fire({
                        type: 'error',
                        title: 'Failed.. Try Again..'
                    })
                }
            });
        }
        
        getQueryData();
		 
		 function getQueryData(){
			 
			 var obj ={
						"referenceid": $('#invoiceNumber').val(),
						"type": "Invoice"
				}
				
				$.ajax({
					type : "POST",
					url : "<%=GlobalUrl.getQueryByTypeAndForeignKey%>",
					data :JSON.stringify(obj),
					dataType : "json",
					contentType : "application/json",
					success : function(response) {
						if (response.msg == "success") {
						
							if("data" in response){
							
								var result = response.data;												
								
							     	tabledataQuery.clear();
							     	var count=0;
				                        for (var i = 0; i < result.length; i++) {
				                        	count++;
				                        	tabledataQuery.row.add([count,result[i].raisedBy, result[i].raisedOn, result[i].comment]);
				                        }
				                        tabledataQuery.draw();
				                        $("tbody").show();
								}
						} else {
							Toast.fire({
								type : 'error',
								title : 'Failed ..'
							})
						}
					},
					error : function(jqXHR, textStatue, errorThrown) {
						
						Toast.fire({
							type : 'error',
							title : 'Failed Added try again..'
						})

					}
				}); 
		 }
		 
		 function raiseQueryModel(){
				var query = document.getElementById("comment").value;
	            if (query === "" || query === null || query === '') {
	                Toast.fire({
	                    type: 'error',
	                    title: 'Please Insert Remarks'
	                });
	                document.getElementById("comment").focus();
	                return "";
	            }
	            
	            var finalObj={
	                    "comment": $("#comment").val(),
	                    "raisedAgainQuery": $("#invoiceNumber").val(),
	                    "id": $("#id").val(),
	                    "type":"Invoice"
	                    }
	            $.ajax({
	                type: "POST",
	                data: JSON.stringify(finalObj),
	                url: "<%=GlobalUrl.saveQuery%>",
	                dataType: "json",
	                contentType: "application/json",
	                success: function(response) {

	                    if (response.msg == 'success') {
	                        swal.fire("", "your Remarks Sucessfully Save", "success", "OK").then(function() {
	                        	window.opener.refereshList();
	                            window.close(); 
	                        });
	                        setTimeout(function(response) {}, 2000);
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
		 
		 /* Document Modal code */
			
		 function displayAttachmentForPoDetails(){
				
			 $('#multipleAttachment').empty();
			 
			 var obj ={
						"foreignKey": $('#ecomInvoiceNumber').val(),
						"type": "Invoice"
				}
				
				$.ajax({
					type : "POST",
					url : "<%=GlobalUrl.getDocumentByTypeAndForeignKey%>",
					data :JSON.stringify(obj),
					dataType : "json",
					contentType : "application/json",
					success : function(response) {
						if (response.msg == "success") {
						
							if("data" in response){
							
								var result = response.data;												
								
								$('#multipleAttachment').append($('<option/>').attr("value", '').text("Select"));
								
								for (var i = 0; i < result.length; i++) {																						
									$('#multipleAttachment').append($('<option/>').attr("value", result[i].docPath).text(result[i].docName));			
								}
								$("#viewAttachmentPopUp").modal('show');
								
							}else{
								Toast.fire({
									type : 'error',
									title : 'Attachment Not Available..'
								})
							}
						} else {
							Toast.fire({
								type : 'error',
								title : 'Failed ..'
							})
						}
					},
					error : function(jqXHR, textStatue, errorThrown) {
						
						Toast.fire({
							type : 'error',
							title : 'Failed Added try again..'
						})

					}
				}); 								 
			}
		
		 $("#multipleAttachment").change(function () {
			 
			 $("#pdfLink").contents().find("body").html(" ");
			    var fileName = $("#multipleAttachment option:selected").text();
			    
			    console.log("fileName from drop down >> " + fileName);
				var filePath = $("#multipleAttachment").val();
			    
				 fileName = encodeURIComponent(fileName);
			     filePath = encodeURIComponent(filePath);
					var urlpath = "getDoc" + "?name=" + fileName+ "&path=" + filePath;

					$('#pdfLink').attr('src', urlpath);
					$('#ifrmameHref').attr('href', urlpath);

				});
			
    </script>
</body>

</html>
