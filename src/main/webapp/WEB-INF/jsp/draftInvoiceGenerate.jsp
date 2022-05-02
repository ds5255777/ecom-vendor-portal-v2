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
    <title>${titleName} | Draft Invoice Generate</title>
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
                    <b>Invoice Number : </b> <input type="text" name="ecomInvoiceNumber" id="ecomInvoiceNumber" readonly value="${invoiceNumber }" style="background: #007BFF; color: white; border: 0px;">
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
                                                <input class="form-control-sm" type="text" name="vendorName" id="vendorName" readonly value="${vendorName }" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Partner Code <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Business Partner Code" name="vendorCode" readonly value="${userName }" id="vendorCode" style="width: 100%;">
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
                                                <input type="date" name="invoiceDate" id="invoiceDate" class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Number <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Number" oninput="this.value = this.value.replace(/[^0-9-_A-Za-z]/g, '').replace(/(\..*)\./g, '$1');this.value = this.value.toUpperCase();" name="invoiceNumber" id="invoiceNumber" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <select class="form-control-sm select2" style="width: 100%;" id="invoiceCurrency" name="invoiceCurrency">
                                                    <option value="INR">INR</option>
                                                    <!-- <option value="USD">USD</option>
                                                    <option value="KES">KES</option> -->
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
                                            <label class="col-sm-5">Tax (%)<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" readonly name="taxAmount" id="taxAmount" type="number" placeholder="Tax Amount" value="18" oninput="calculateInvoice()" style="width: 100%;" >
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

                                    <input type="text" id="id" name="id" hidden>
                                    <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" hidden value="${invoiceNumber }">

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
                                        <th style="padding: 5px 5px 5px 1.5rem;">Number</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Trip ID</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Rate per km</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Current Fuel
                                            Rate</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">FS Base Rate</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">FS Diff</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Basic Freight</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">FS</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Actual KM</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Total Freight</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Lumpsome Amount</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Line level
                                            Description</th>
                                        <th style="padding: 5px 5px 5px 1.5rem;">Action</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->

                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Document Upload</h4>
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
                                            <label class="col-sm-5 control-label">Upload Invoice<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="InvoiceUpload" name="InvoiceUpload" class="form-control-sm" accept=".jpg, .jpeg, .pdf" onchange="handleFileSelect(event,'InvoiceFileText'), onValidateFile('InvoiceUpload')" class="form-control p-input">
                                                <textarea id="InvoiceFileText" name="InvoiceFileText" rows="5" style="display: none;"></textarea>
                                                <label><span style="font-weight: 500; color: #fd7e14;">(* File size Max  ${fileSize} MB)</span></label>
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
                    <div class="card card-primary"  id="queryWindow" style="display: block;" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Vendor Remarks</h4>
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
										    <label class="col-sm-3" >Remarks <span class="text-danger"></span></label>
										    <div class="col-sm-9">
										    <textarea class="form-control" id="remarks" name="remarks" rows="3" maxlength="250" placeholder="Remarks if Any, 250 Characters only"></textarea>
										 </div>
										 </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    </div>
                    <center>
                        <div class="form-group">
                            <label style="visibility: hidden;">Select </label>
                            <button type="button" onclick="sendToServer()" class="btn btn-success">Submit Invoice</button>

                            <label style="visibility: hidden;">Select</label>
                            <button type="button" onclick="discardInvoice()" class="btn btn-info" style="background-color: #323d84">Cancel Invoice</button>

                            <label style="visibility: hidden;">Select</label>
                            <button type="button" onclick="closeWin()" class="btn btn-info">Save as Draft</button>
                        </div>
                    </center>
                    <!-- /.row -->
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

        function closeWin() {
            window.opener.refereshList();
            window.close()
        }
        
        $(function(){
    	    $('[name="invoiceDate"]').prop('max', function(){
    	        return new Date().toJSON().split('T')[0];
    	    });
    	});
       

        function onValidateFile(id) {
            var fileInput3 = document.getElementById(id).value;
            var gst = document.getElementById(id);
            var allowedExtensions = /(\.jpg|\.jpeg|\.pdf)$/i;

            if (typeof(gst.files) != "undefined") {

                const fsize = gst.files.item(0).size;
                const file = Math.round((fsize / 1024));
                if (file > ${maxFileSize}) {
                    swal.fire("", "File should less than 5 MB.", "warning");
                    $("#" + id).val("");
                } else {
                    var ext = fileInput3.split(".")[1];
                    if (ext == "pdf" || ext == "jpg" || ext == "JPEG" || ext == "JPG" || ext == "jpeg" || ext == "PDF") {} else {
                        swal.fire("", "Select Only JPEG & PDF File.", "warning");
                        $("#" + id).val("");
                        return false;
                    }
                }
            } else {
                alert("This browser does not support HTML5.");
            }
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
                url: "<%=GlobalUrl.findByTripDetailUsingTripID%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        Toast.fire({
                            type: 'success',
                            title: 'Add Successfully.'
                        })
                        getTripDetails();
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

        var allTripId = ${listofTrips};
        var tripLineArray = [];
        var totalFreight = 0;
        var lumpsomeamount = parseFloat(0);

        function sendToServer() {
        	
            var invoiceDa = document.getElementById("invoiceDate").value;
            if (invoiceDa === "" || invoiceDa === null || invoiceDa === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Select Date'
                });
                document.getElementById("invoiceDate").focus();
                return "";
            }

            var invoiceNu = document.getElementById("invoiceNumber").value;
            if (invoiceNu === "" || invoiceNu === null || invoiceNu === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Fill Invoice Number'
                });
                document.getElementById("invoiceNumber").focus();
                return "";
            }
            
            var invoiceCheckStatus = checkForExistingInvoiceNumber();

            if (invoiceCheckStatus == "false") {

                return;
            }

            var invoiceDoc = document.getElementById("InvoiceUpload").value;
            if (invoiceDoc === "" || invoiceDoc === null || invoiceDoc === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Upload Invoice Document'
                });
                document.getElementById("InvoiceUpload").focus();
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
            console.log(tripLineArray.length);
            if(tripLineArray.length === 0){
            	Toast.fire({
                    type: 'error',
                    title: 'Select More Then One Trips'
                });
                return "";
            }
            


            var stepOneObj = FormDataToJSON('stepOneForm');
            var stepTwoObj = FormDataToJSON('queryForm');

            const finalObj = {
                ...stepOneObj,
                ...stepTwoObj
            };

            if (document.getElementById("InvoiceUpload").files.length > 0) {
                finalObj.invoiceFileName = document.getElementById("InvoiceUpload").files.item(0).name;
                finalObj.invoiceFileText = $("#InvoiceFileText").val();
            }
            if (document.getElementById("DocumentFileOne").files.length > 0) {
                finalObj.documentFileOneName = document.getElementById("DocumentFileOne").files.item(0).name;
                finalObj.documentFileOneText = $("#DocumentFileOneText").val();
            }
            if (document.getElementById("DocumentFileTwo").files.length > 0) {
                finalObj.documentFileTwoName = document.getElementById("DocumentFileTwo").files.item(0).name;
                finalObj.documentFileTwoText = $("#DocumentFileTwoText").val();
            }

            
            	
             
            // after
            tripLineArray.forEach((item) => {
                item.id = null;
            });

            finalObj.invoiceLineItem = tripLineArray;

            $.ajax({
                type: "POST",
                data: JSON.stringify(finalObj),
                url: "<%=GlobalUrl.saveInvoice%>",
                dataType: "json",
                contentType: "application/json",
                success: function(response) {

                    if (response.msg == 'success') {
                        swal.fire("", "Invoice Processed Sucessfully", "success", "OK").then(function() {
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
        getTripDetails();

        function updateTextData(index, textValue) {
            tripLineArray[index].lineLevelDescription = textValue.trim();
        }

        function getTripDetails() {
            var invoiceNumber = $("#ecomInvoiceNumber").val();

            var obj = {
                "invoiceNumber": invoiceNumber
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getDraftLineTripDetails%>",
                dataType: "json",
                contentType: "application/json",
                success: function(response) {

                    if (response.msg == 'success') {
                        var result = response.data;
                        var action = "";
                        var textBox = "";
                        var taxableAmount = 0;
                        /* var temp = [];
                        var temp1 = []; */
                        tripLineArray = result;

                        $('#prTable').DataTable().clear();
                        for (var i = 0; i < result.length; i++) {

                            if (!result[i].hasOwnProperty("tripID")) {
                                result[i].tripID = "";
                            }
                            if (!result[i].hasOwnProperty("runType")) {
                                result[i].runType = "";
                            }
                            if (!result[i].hasOwnProperty("route")) {
                                result[i].route = "";
                            }
                            if (!result[i].hasOwnProperty("standardKM")) {
                                result[i].standardKM = "";
                            }
                            if (!result[i].hasOwnProperty("ratePerKm")) {
                                result[i].ratePerKm = "";
                            }
                            if (!result[i].hasOwnProperty("currentFuelRate")) {
                                result[i].currentFuelRate = "";
                            }
                            if (!result[i].hasOwnProperty("fsBaseRate")) {
                                result[i].fsBaseRate = "";
                            }
                            if (!result[i].hasOwnProperty("fsDiff")) {
                                result[i].fsDiff = "";
                            }
                            if (!result[i].hasOwnProperty("basicFreight")) {
                                result[i].basicFreight = "";
                            }
                            if (!result[i].hasOwnProperty("fs")) {
                                result[i].fs = "";
                            }
                            if (!result[i].hasOwnProperty("actualKM")) {
                                result[i].actualKM = "";
                            }
                            if (!result[i].hasOwnProperty("totalFreight")) {
                                result[i].totalFreight = "0";
                            }
                            if (!result[i].hasOwnProperty("lumpsomeamount")) {
                                result[i].lumpsomeamount = "0";
                            }

                            textBox = "<input type=\"text\" class=\"form-control\" id=\"form-control\" placeholder=\"Fill Description\" maxlength=\"100\" oninput=\"updateTextData('" + i + "',this.value)\" style=\" height: 25px;padding: 5px 5px 5px 1.5rem; \">";
                            action = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"deleteRow('" + result[i].tripID + "')\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                            $('#prTable').DataTable().row.add([i + 1, result[i].tripID, result[i].runType, result[i].route, result[i].standardKM, result[i].ratePerKm, result[i].currentFuelRate, result[i].fsBaseRate, result[i].fsDiff, result[i].basicFreight, result[i].fs, result[i].actualKM, result[i].totalFreight, result[i].lumpsomeamount, textBox, action]);
                            id = (result[i].id);
                            taxableAmount += parseFloat(result[i].totalFreight)+ parseFloat(result[i].lumpsomeamount);
                        }
                       
                      

                        $("#taxableAmount").val(parseFloat(taxableAmount).toFixed(2));
                        $('#prTable').DataTable().draw();
                        $("tbody").show();
                        calculateInvoice();
                        
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

        function discardInvoice() {
            var invoiceNumber = $("#ecomInvoiceNumber").val();
            var obj = {
                "ecomInvoiceNumber": invoiceNumber
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.discardDraftInvoice%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        swal.fire("", "Deleted Successfully.", "success", "OK").then(function() {
                            window.opener.refereshList();
                            window.close();
                        });
                        setTimeout(function(response) {}, 2000);
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

        function deleteRow(tripID) {
            prTable
                .row($(tripID).parents('tr'))
                .remove()
                .draw();
            deleteThisTrip(tripID);
            getTripDetails();
        }

        function deleteThisTrip(tripID) {
            var json = {
                "tripID": tripID
            }
            console.log(json);
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.deleteLineItem%>",
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

           /*  var obj = {
                "vendorCode": bpname
            } */

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
                        
                        console.log(result,"--------");
                        
                        if (result.length !== 0) {
                            for (var i = 0; i < result.length; i++) {
                                $('#tripList').append($('<option/>').attr("value", result[i]).text(result[i]));
                                console.log(result[i].tripID);
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

        function calculateInvoice() {
            var taxAmount = $("#taxAmount").val();
            var taxableAmount = $("#taxableAmount").val();
            var taxAmount= parseFloat(taxableAmount) *  (parseFloat(taxAmount) /100);
            var finalInvoiceAmount = parseFloat(taxableAmount) +  parseFloat(taxAmount) ;
            $("#invoiceAmount").val(parseFloat(finalInvoiceAmount).toFixed(2));
        }
        
        $("#invoiceNumber").focusout(function() {

            checkForExistingInvoiceNumber();

        });
        
        function checkForExistingInvoiceNumber(){
        	var invoiceCheckStatus = "false";
        	
        	//alert("hiii");
        	var bpname = $("#vendorCode").val();


            if ($("#invoiceNumber").val() != "") {

                var json = {
                    "invoiceNumber": $("#invoiceNumber").val(),
                    "vendorCode": bpname

                }
                
                console.log(json);
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.checkForExistingInvoiceNumber%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                    	console.log(data.msg);
                        if (data.msg == 'exist') {

                            Toast.fire({
                                type: 'warning',
                                title: 'Invoice Number Already Exists.'
                            })
                            $("#invoiceNumber").val('');

                        } else if (data.msg == 'success') {
                        	invoiceCheckStatus = "true";
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
            return invoiceCheckStatus;
        }
        
    </script>
</body>

</html>
