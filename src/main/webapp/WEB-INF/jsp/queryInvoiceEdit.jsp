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
    <title>${titleName} | Query Invoice</title>
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
			<h5 style=" color: white;">Invoice-Process</h5>
            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <!-- Navbar Search -->
                <h6 class="float-sm-right" style="color: white;">
                    <b>Invoice Number : </b> <input type="text" name="ecomInvoiceNumber" id="ecomInvoiceNumber" readonly value="${invoiceNumber}" style="background: #007BFF; color: white; border: 0px;">
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
                                            <label class="col-sm-5">Partner Name <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="vendorName" id="vendorName" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Partner Code <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  type="text" name="vendorCode" id="vendorCode" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Site Name <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  type="text" name="siteName" id="siteName" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Date <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="invoiceDate"  id="invoiceDate" class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Number <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  type="text"  oninput="this.value = this.value.replace(/[^0-9-_A-Za-z]/g, '').replace(/(\..*)\./g, '$1');this.value = this.value.toUpperCase();" name="invoiceNumber" id="invoiceNumber" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                            	<input class="form-control-sm"  type="text" name="invoiceCurrency" id="invoiceCurrency" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Inv Receiving Date</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm"  name="invoiceReceivingDate" id="invoiceReceivingDate" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Taxable Amount</label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="taxableAmount" id="taxableAmount" type="text"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Tax (%)<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="taxAmount" id="taxAmount" type="text" value="18" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Amount <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  type="text" name="invoiceAmount" id="invoiceAmount" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <input type="hidden" id="id" name="id" >
                                    <input type="hidden" id="ecomInvoiceNumber" name="ecomInvoiceNumber"  value="${invoiceNumber }">

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
                        <div class="card-body" style="overflow: auto;">
                            <form id="stepTwoForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-4 control-label">Trip Id</label>
                                            <div class="col-sm-8">
                                                <select id="tripList" name="tripList" class="form-control-sm select2" style="width: 100% !important;">
                                                    <option>Select Trip ID</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <button type="button" class="btn btn-primary" style="margin-right:
                                                    5px;height: 30px;padding: 2px 10px 2px 10px;" id="docBtn" name="docBtn" onclick="AddDocCheck()">Add</button>

                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- /.card-header -->

                        <div class="card-body" style="overflow: auto;">
                            <table id="prTable" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">S.No</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip ID</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Stnd KM</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Rate/km</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Fuel
                                            Rate</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS Base Rate</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS Diff</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Basic Freight</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Actual KM</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Total Freight</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Lumpsome Amount</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Line level
                                            Description</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Action</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->

                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Remarks & Document Update</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body" style="overflow: auto;">
                            <form id="stepFourForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
										    <label class="col-sm-3" >Remarks <span class="text-danger">*</span></label>
										    <div class="col-sm-9">
										    <textarea class="form-control" id="remarks" name="remarks" rows="3" maxlength="250" placeholder="Remarks if Any, 250 Characters only"></textarea>
										 </div>
										 </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Summary Sheet<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="DocumentFileOne" name="DocumentFileOne" class="form-control-sm" accept=".pdf, .doc, .docx, .xls, .xlsx" onchange="handleFileSelect(event,'DocumentFileOneText'), onValidateFileOne('DocumentFileOne')" class="form-control p-input">
                                                <textarea id="DocumentFileOneText" name="DocumentFileOneText" rows="5" style="display: none;"></textarea>
                                                <label><span style="font-weight: 500; color: #fd7e14;">(* File size Max  ${fileSize} MB)</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">FS Calculation Sheet<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="DocumentFileTwo" name="DocumentFileTwo" class="form-control-sm" accept=".pdf, .doc, .docx, .xls, .xlsx"  onchange="handleFileSelect(event,'DocumentFileTwoText'), onValidateFileOne('DocumentFileTwo')" class="form-control p-input">
                                                <textarea id="DocumentFileTwoText" name="DocumentFileTwoText" rows="5" style="display: none;"></textarea>
                                                <label><span  style="font-weight: 500;color: #fd7e14;">(* File size Max  ${fileSize} MB)</span></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    </div>
                    <center>
                        <div class="form-group">
                            <label style="visibility: hidden;">Select </label>
                            <button type="button" onclick="sendToServer()" class="btn btn-success">Submit Invoice</button>

                            <label style="visibility: hidden;">Select</label>
                            <button type="button" onclick="closeWin()" class="btn btn-info">Close</button>
                        </div>
                    </center>
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
								<div class="col-md-12">

									<div class="table-responsive">
										<table
											class="table table-bordered table-hover"
											id="tabledataQuery">
											<thead>
												<tr>
													<th class="bg-primary"  >S.No</th>
													<th class="bg-primary"  >Raised By</th>
													<th class="bg-primary">Role/Department</th>
													<th class="bg-primary" >Raised On</th>
													<th class="bg-primary" >Remarks</th>
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
    <script src="js/common.js"></script>
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
        function disableF5(e) {
            if ((e.which || e.keyCode) == 116) e.preventDefault();
        };
        $(document).on("keydown", disableF5);
        
        $("input[type=text]").prop('disabled', true);
        var tripLineArray = [];
        var totalFreight = 0;
        var lumpsomeamount = parseFloat(0);

        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });

        var prTable = $("#prTable").DataTable({
            "paging": true,
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
        
        function closeWin() {
            window.opener.refereshList();
            window.close()
        }
        
        function onValidateFileOne(id) {
            var fileInput3 = document.getElementById(id).value;
            var gst = document.getElementById(id);
            var allowedExtensions = /(\.pdf|\.doc|\.docx|\.xls|\.xlsx)$/i;

            if (typeof(gst.files) != "undefined") {

                const fsize = gst.files.item(0).size;
                const file = Math.round((fsize / 1024));
                if (file > ${maxFileSize}) {
                    swal.fire("", "File should less than 5 MB.", "warning");
                    $("#" + id).val("");
                } else {
                    var ext = fileInput3.split(".")[1];
                    if (ext == "pdf" || ext == "PDF" || ext == "docx" || ext == "DOCX" || ext == "doc" || ext == "DOC" ||  ext == "xls" || ext == "XLS" || ext == "xlsx" || ext == "XLSX") {} else {
                        swal.fire("", "Select Only DOC, XLSX & PDF File.", "warning");
                        $("#" + id).val("");
                        return false;
                    }
                }
            } else {
                alert("This browser does not support HTML5.");
            }
        }
        
        setInvoiceDetails();
        
        function setInvoiceDetails() {
        	var invoiceNumber = $("#ecomInvoiceNumber").val();
            var obj = {
                "ecomInvoiceNumber": invoiceNumber
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getQueryInvoice%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                     if (data.msg == 'success') {
                    	 var result = data.data;
                    	 var action = "";
                         var textBox = "";
                         var taxableAmount = 0;
                    	 tripLineArray = data.data.invoiceLineItem;
                         var myForm = "";
                         myForm = document.getElementById("stepOneForm");
                         setData(myForm, result);
                          
                         showTableData();
                         $("#vendorName").val(result.vendorName);
                         $("#invoiceNumber").val(result.invoiceNumber);
                         $("#ecomInvoiceNumber").val(result.ecomInvoiceNumber);
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
				                        	if(!result[i].hasOwnProperty("raisedBy")){
				                               	result[i].raisedBy="";
				                               }
				                                             if(!result[i].hasOwnProperty("role")){
				                               	result[i].role="";
				                               }
				                                             if(!result[i].hasOwnProperty("raisedOn")){
				                               	result[i].raisedOn="";
				                               }
				                                             if(!result[i].hasOwnProperty("comment")){
				                               	result[i].comment="";
				                               }                    
				                        count++;
				                        tabledataQuery.row.add([count,result[i].raisedBy, result[i].role, result[i].raisedOn, result[i].comment]);
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
        
		 
		 function showTableData(){
			 
			 var taxableAmount = 0;
			 
			 prTable.clear();
             for (var i = 0; i < tripLineArray.length; i++) {
                 if (!tripLineArray[i].hasOwnProperty("tripID")) {
                     tripLineArray[i].tripID = "";
                 }
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
                     tripLineArray[i].totalFreight = 0;
                 }
                 if (!tripLineArray[i].hasOwnProperty("lumpsomeamount")) {
                     tripLineArray[i].lumpsomeamount = 0;
                 }
                 if (!tripLineArray[i].hasOwnProperty("lineLevelDescription")) {
                     tripLineArray[i].lineLevelDescription = "";
                 }
                 textBox = "<input type=\"text\" class=\"form-control\" id=\"form-control\" placeholder=\"Fill Description\" maxlength=\"100\" value=\""+tripLineArray[i].lineLevelDescription+"\" oninput=\"updateTextData('" + i + "',this.value)\" style=\" height: 25px;padding: 5px 5px 5px 1.5rem; \">";
                 action = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"deleteRow('" + tripLineArray[i].tripID + "')\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                 prTable.row.add([i+1,tripLineArray[i].tripID,tripLineArray[i].runType, tripLineArray[i].route, 
                	tripLineArray[i].standardKM, 
                	tripLineArray[i].ratePerKm, 
                	tripLineArray[i].currentFuelRate, 
                	tripLineArray[i].fsBaseRate, 
                	tripLineArray[i].fsDiff, 
                	tripLineArray[i].basicFreight,
                	tripLineArray[i].fs, 
                	tripLineArray[i].actualKM, 
                	tripLineArray[i].totalFreight,
                	tripLineArray[i].lumpsomeamount,
                	textBox,action]);
                 id = (tripLineArray[i].id);
                 taxableAmount += parseFloat(tripLineArray[i].totalFreight)+ parseFloat(tripLineArray[i].lumpsomeamount);
             }
            
             $("#taxableAmount").val(parseFloat(taxableAmount).toFixed(2));
             prTable.draw();
             $("tbody").show();
             calculateInvoice();
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
                    $("#" + id).val(base64String);
                };
            })(f);
            reader.readAsBinaryString(f);
        }
        
       /*  function updateTextData(index, textValue) {
            tripLineArray[index].lineLevelDescription = textValue.trim();
        } */
        
        function deleteRow(tripID) {
            prTable
                .row($(tripID).parents('tr'))
                .remove()
                .draw();
            deleteThisTrip(tripID);
            setInvoiceDetails();
        }
        
        function deleteThisTrip(tripID) {
            var json = {
                "tripID": tripID
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.deleteTripQueryInvoice%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        Toast.fire({
                            type: 'success',
                            title: 'Deleted Successfully.'
                        })
                        	/* $("#taxAmount").val(''); */
                        getSelectTripList();
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
        
        getSelectTripList();
        var bpname = $("#vendorCode").val();
        

        function getSelectTripList() {
        	
        	$("#tripList ").empty();
        	$('#tripList').append($('<option/>').attr("value", "").text("Select Trip Id"));

            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getTripDetailByTripId%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                        
                        
                        if (result.length !== 0) {
                            for (var i = 0; i < result.length; i++) {
                                $('#tripList').append($('<option/>').attr("value", result[i]).text(result[i]));
                            }
                        }
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
        
        function AddDocCheck() {
            var invoiceNumber = $("#ecomInvoiceNumber").val();
            var tripID = document.getElementById("tripList").value;
			if(tripID != ''){
            var json = {
                "tripID": tripID,
                "invoiceNumber": invoiceNumber
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.addNewTripInQueryInvoice%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        Toast.fire({
                            type: 'success',
                            title: 'Added Successfully.'
                        })
                        var result=data.data;
                        result.newAdded="1";
                        tripLineArray.push(result);
                        showTableData();
                        getSelectTripList();
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
        }
        
        function sendToServer(){
        	
        	var remarks = document.getElementById("remarks").value;
            if (remarks === "" || remarks === null || remarks === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Remarks field not blank'
                });
                document.getElementById("remarks").focus();
                return "";
            }
            
            var docOne = document.getElementById("DocumentFileOne").value;
            if (docOne === "" || docOne === null || docOne === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Upload Summary Sheet'
                });
                document.getElementById("docOne").focus();
                return "";
            }
            
            var docTwo = document.getElementById("DocumentFileTwo").value;
            if (docTwo === "" || docTwo === null || docTwo === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Upload FS Calculation Sheet'
                });
                document.getElementById("docTwo").focus();
                return "";
            }
            if(tripLineArray.length === 0){
            	Toast.fire({
                    type: 'error',
                    title: 'Select More Then One Trips'
                });
                return "";
            }
            
            const finalObj = {
            		"remarks": $('#remarks').val(),
            		"ecomInvoiceNumber":$('#ecomInvoiceNumber').val(),
            		"taxableAmount":$('#taxableAmount').val(),
            		"invoiceAmount":$('#invoiceAmount').val(),
            		"invoiceNumber":$('#invoiceNumber').val(),
            		"assignTo":"<%=GlobalConstants.ROLE_FINANCE%>",
            		"invoiceStatus":"<%=GlobalConstants.INVOICE_STATUS_IN_REVIEW%>",
            		"vendorCode":$('#vendorCode').val()
            };
            
            if (document.getElementById("DocumentFileOne").files.length > 0) {
                finalObj.documentFileOneName = document.getElementById("DocumentFileOne").files.item(0).name;
                finalObj.documentFileOneText = $("#DocumentFileOneText").val();
            }
            if (document.getElementById("DocumentFileTwo").files.length > 0) {
                finalObj.documentFileTwoName = document.getElementById("DocumentFileTwo").files.item(0).name;
                finalObj.documentFileTwoText = $("#DocumentFileTwoText").val();
            }
            
            tripLineArray.forEach((item) => {
                item.id = null;
                
            });
			
            finalObj.invoiceLineItems = tripLineArray;
            
           //return;
            
            $.ajax({
                type: "POST",
                data: JSON.stringify(finalObj),
                url: "<%=GlobalUrl.updateInvoice%>",
                dataType: "json",
                contentType: "application/json",
                success: function(response) {

                    if (response.msg == 'success') {
                        swal.fire("", "Remarks/Documents Successfully Submitted", "success", "OK").then(function() {
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
        
        function updateTextData(index, textValue) {
            tripLineArray[index].lineLevelDescription = textValue.trim();
        }
        
        function calculateInvoice() {
            var taxAmount = $("#taxAmount").val();
            var taxableAmount = $("#taxableAmount").val();
            var taxAmount= parseFloat(taxableAmount) *  (parseFloat(taxAmount) /100);
            var finalInvoiceAmount = parseFloat(taxableAmount) +  parseFloat(taxAmount) ;
            $("#invoiceAmount").val(parseFloat(finalInvoiceAmount).toFixed(2));
        } 
        
    </script>
</body>

</html>
