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
       <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
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
                    <b>Invoice Number : </b> <input type="text" name="ecomInvoiceNumber" id="ecomInvoiceNumber" value="${invoiceNumber}" readonly  style="background: #007BFF; color: white; border: 0px;width: 210px;">
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
                                            <label class="col-sm-5">Invoice Number <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Number" name="invoiceNumber" id="invoiceNumber" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Type <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Type" name="invoiceType" id="invoiceType"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Po Number<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="poNumber" id="poNumber"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="invoiceDate" id="invoiceDate"  disabled="disabled" class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                 
                                    
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <select class="form-control-sm select2" style="width: 100%;" id="invoiceCurrency" name="invoiceCurrency"disabled="disabled">
                                                    <option value="INR">INR</option>
                                                   
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Site <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <!-- <input class="form-control-sm" type="text" placeholder="Site Name" name="siteName" id="siteName" style="width: 100%;"> -->
                                                <input class="form-control-sm" type="text" placeholder="Supplier Site" name="supplierSite" id="supplierSite" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Operating Unit</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="operatingUnit" id="operatingUnit"  placeholder="Operating Uni"readonly  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Trading partner</label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="tradingPartner" id="tradingPartner" type="text" placeholder="Trading partner" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Number<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="supplierNum" id="supplierNum"   placeholder="Supplier Number" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">GL Date <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="glDate" id="glDate" placeholder="GL Date"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Currency<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="paymentCurrency" id="paymentCurrency"   placeholder="Payment Currency" onfocusout="calculateInvoice()" style="width: 100%;" on>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Match Option <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="matchOption" id="matchOption" placeholder="Match Option"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms Date<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="termsDate" id="termsDate"  placeholder="Terms Date"  style="width: 100%;" on>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="terms" id="terms" placeholder="Terms"  style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Method<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="paymentMethod" id="paymentMethod"  placeholder="Payment Method"  style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Pay Group <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="payGroup" id="payGroup" placeholder="Pay Group "  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Remit To bank account name<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="remitToBankAccountName" id="remitToBankAccountName"  placeholder="Remit To bank account name" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Remit To bank account number <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="remitToBankAccountNumber" id="remitToBankAccountNumber"  placeholder=" Remit To bank account number"  style="width: 100%;" maxlength="20">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Invoice number (DFF)<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="supplierInvoiceNumber" id="supplierInvoiceNumber"  placeholder="Supplier Invoice number"  style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier invoice date (DFF) <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="supplierInvoiceDate" id="supplierInvoiceDate" placeholder=" Supplier invoice date"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    

                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- /.card -->
                                       <!-- /.card -->

<!--                     <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Document Upload</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        /.card-header
                        <div class="card-body" style="overflow: auto;">
                            <form id="stepFourForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Upload Invoice<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="InvoiceUpload" name="InvoiceUpload" class="form-control-sm" accept=".jpg, .jpeg, .pdf" onchange="handleFileSelect(event,'InvoiceFileText'), onValidateFile('InvoiceUpload')" class="form-control p-input">
                                                <textarea id="InvoiceFileText" name="InvoiceFileText" rows="5" style="display: none;"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Document1<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="DocumentFileOne" name="DocumentFileOne" class="form-control-sm" accept=".jpg, .jpeg, .pdf" onchange="handleFileSelect(event,'DocumentFileOneText'), onValidateFile('DocumentFileOne')" class="form-control p-input">
                                                <textarea id="DocumentFileOneText" name="DocumentFileOneText" rows="5" style="display: none;"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Document2<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="DocumentFileTwo" name="DocumentFileTwo" class="form-control-sm" accept=".jpg, .jpeg, .pdf" onchange="handleFileSelect(event,'DocumentFileTwoText'), onValidateFile('DocumentFileTwo')" class="form-control p-input">
                                                <textarea id="DocumentFileTwoText" name="DocumentFileTwoText" rows="5" style="display: none;"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        /.card-body
                    </div> -->
                    
                     <div class="card card-primary">
                    <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Invoice distribution</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        
                     <div class="card-body">
                            <form id="stepTwoForm" class="forms-sample">
                                <div class="row">
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Line type <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="lineType" name="lineType" id="lineType" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Account<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Type" name="account" id="account" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">GL Date<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="GL Date" name="glDate1" id="glDate1" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Amount <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Type" name="amount" id="amount" readonly  style="width: 100%;">
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
                  
                        <!-- /.card-body -->
                   
                    <!-- /.card -->
                    <!-- Query Form -->
                    
                    
                           
                        <div class="card-body" style="overflow: auto;">
                            <table id="prTable" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                    <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;"> S.No</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;"> Receipent Line</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Description</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Line Type</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">PO Line</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">GL Date</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Quantity</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Remaning Quantity</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Quantity Invoiced</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Unit Price</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">UOM</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Tax %</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Base Amount</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Tax Amount</th>
                                       
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Total Amount</th>
                                         <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Action</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    
                    
                                        
                       <center>
                        <div class="form-group">
                            <label style="visibility: hidden;">Select </label>
                            <button type="button" onclick="sendToServer()" class="btn btn-info">Submit Invoice</button>

                            <!-- <label style="visibility: hidden;">Select</label>
                            <button type="button" onclick="discardInvoice()" class="btn btn-info">Discard Invoice</button>
 -->
                            <label style="visibility: hidden;">Select</label>
                            <button type="button" onclick="window.close()" class="btn btn-info">Close</button>
                        </div>
                    </center>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
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
       
    var tripLineArray=[];
    var prTable = $('#prTable').DataTable({
		"paging" : false,
		"lengthChange" : false,
		"searching" : false,
		"info" : false,
		"autoWidth" : false,
		"aaSorting" : [],
		"scrollX" : false
	});
    
    var  invoiceNumber='${invoiceNumber}';
   // alert("poNo"+poNo)
   
   getPoDetails();
    
    function getPoDetails() {

        var obj = {
            "invoiceNumber": invoiceNumber
        }
		
        $.ajax({
            type: "POST",
            data: JSON.stringify(obj),
            url: "<%=GlobalUrl.getAllDraftPODetailsByInvoiceNo%>",
            dataType: "json",
            contentType: "application/json",
            async: false,
            success: function(data) {

                if (data.msg == 'success') {
                    var result = data.data;

                    
                    var  glDate= result[0].glDate;
                    var termsDate= result[0].termsDate;
                    var supplierInvoiceDate= result[0].supplierInvoiceDate;
                   
                    
                    
                    
                    
                    
                    
                        if( glDate !== undefined ){
                        	
                              $('#glDate').val(glDate.split(" ")[0]);
        					}else{
        						document.getElementById("glDate").type="date"; 
                            	
                            	 
                            }
        					if( termsDate !== undefined ){
                              $('#termsDate').val(termsDate.split(" ")[0]);
                              } else{
                            	  document.getElementById("termsDate").type="date"; 
                              	
                              }
        					if( termsDate !== undefined ){
                              $('#supplierInvoiceDate').val(supplierInvoiceDate.split(" ")[0]);
                              
                        }else{
                        	document.getElementById("supplierInvoiceDate").type="date";
                        }
                  
                    
                    
                     tripLineArray=result[0].poInvoiceLine;
                    var myForm = "";
                    myForm = document.getElementById("stepOneForm");
                    setData(myForm, result[0]);
                    
                   
                    
                  
                  /*   $('#glDate').datepicker({
                        dateFormat: 'yy-mm-dd',
                        changeMonth: true,
                        changeYear: true,

                    }); */
                    
                    myForm = document.getElementById("stepTwoForm");
                    setData(myForm, result[0]);
                    
                 //  var date =result[0].glDate;
                   
                   
                   
                  // $('#gldate').val( new Date(date));
                   
                                 
                  
                    $('#prTable').DataTable().clear();
                    for (var i = 0; i < tripLineArray.length; i++) {
                    	 id=tripLineArray[i].id;
                    	// var remaningQuat;
                    	 if(tripLineArray[i].remaningQuatity!=null){
                    		 remaningQuat= tripLineArray[i].remaningQuatity;
                    		 tripLineArray[i].quantity=tripLineArray[i].remaningQuatity;
                    	 }else{
                    		 remaningQuat=tripLineArray[i].quantity;
                    	 }
                    	 

/*                         if (!tripLineArray[i].hasOwnProperty("tripID")) {
                        	tripLineArray[i].tripID = "";
                        }
                        if (!tripLineArray[i].hasOwnProperty("runType")) {
                        	tripLineArray[i].runType = "";
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
                        	tripLineArray[i].totalFreight = "0";
                        }
                        if (!result[i].hasOwnProperty("lumpsomeamount")) {
                            result[i].lumpsomeamount = "0";
                        } */  
                        var totalamot;
                        var receipentLine= "<input type=\"text\" id=\"receipentLine_"+i+"\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('receiptline','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
                        var description= "<input type=\"text\" id=\"description_"+i+"\" readonly style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('description','"+i+"',this.value)\" value=\"" + tripLineArray[i].description + "\" class=\"form-control-sm \" \"> ";
                        var lineType= "<input type=\"text\" id=\"lineType_"+i+"\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('lineType','"+i+"',this.value)\"  class=\"form-control-sm \" \"> ";
                        var poline= "<input type=\"text\" id=\"poline_"+i+"\" oninput=\"updatePOLineItem('poline','"+i+"',this.value)\" style=\"width: 70px; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var glDate= "<input type=\"date\" id=\"glDate_"+i+"\" oninput=\"updatePOLineItem('gldate','"+i+"',this.value)\" style=\"width: 100px; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var remaningQuantity= "<input type=\"text\" readonly id=\"remaningQuantity_"+i+"\" style=\"width: 100%; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var quantity= "<input type=\"text\" readonly style=\"width: 100px; height: 28px;\" value=\"" + remaningQuat + "\" class=\"form-control-sm \" \"> ";
                        var quantityInvoiced= "<input type=\"text\" id=\"quantityInvoiced_"+i+"\" style=\"width: 100%; height: 28px;\" oninput=\"updatebaseaAmt('"+id+"','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
                        var unitPrice= "<input type=\"text\" id=\"unitPrice_"+i+"\" readonly style=\"width: 100px; height: 28x;\" value=\"" + tripLineArray[i].unitPrice + "\"  class=\"form-control-sm \" \"> ";
                        var uom= "<input type=\"text\" id=\"uom_"+i+"\" style=\"width: 100px; height: 28px;\"  class=\"form-control-sm \" \"> ";
                        var taxAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"  id=\"tax_"+i+"\" class=\"form-control-sm \" \"> ";
                        var baseAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"   id=\"baseAmt_"+i+"\"   class=\"form-control-sm \" > ";
                        var taxPercentage= "    <select  class=\"form-control-sm \" style=\"width: 67px; height: 28px;\" id=\"taxper_"+i+"\"  onchange=\"updatetotalAmount(this.value,'"+i+"')\" > <option value=\"0\" \">0%</option><option value=\"5\"  \">5%</option><option value=\"8\"  \">8%</option><option value=\"18\" \">18%</option><option value=\"28\" \">28%</option> </select > ";
                        var totalAmount= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"totamt_"+i+"\" > ";
                        var inactive = "<button type=\"button\"  class=\" btndeleterow\" style=\"color: #fff;background-color: #007bff; border-color: #007bff;box-shadow: none;\" data-placement=\"bottom\" onclick=\"inactiveActiveDeleteData(" + i + ")\"  data-original-title=\"Click To Delete\" > <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                        
						prTable.row.add([i + 1,receipentLine,description,lineType,poline,glDate,quantity,remaningQuantity,quantityInvoiced,unitPrice,uom,taxPercentage,baseAmount,taxAmount,totalAmount,inactive]);
				  
						
						
                        //Receipent Line	Description	Line Type	PO Line	GL Date
                       // Quantity	Remaning Quantity 	Quantity Invoiced	Unit Price	UOM	Tax Percentage	Base Amount	Tax Amount	Total Amount
                    }
                    var  grossamt= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"grossAmt\" >";
                    prTable.row.add(["","","","","","","","","","","","Total","","",grossamt,""]);
                 
                    $('#prTable').DataTable().draw();
                    $("tbody").show();
                       
                    
                    
                    
                    
               
        
        
		         

                    
                    
                    
                   
                    
                    
                    // gldate=document.getElementById("glDate").value;
                   // document.getElementById("glDate1").value=gldate;

                    var pono =document.getElementById('poNumber').value
                    //document.getElementById('poNumber1').value=pono;
                    
					for (var i = 0; i < result[0].length; i++) {
                        if (!result[0].hasOwnProperty("tripLineArray")) {
                        	 $('#uom1').val( tripLineArray[0].uom);
                             $('#description1').val( tripLineArray[0].description);
                             
                        }
					}
					
					
                   
                    var d = new Date();
                    $( "#invoiceDate" ).val(d.getFullYear()+'/'+(d.getMonth()+1)+'/'+d.getDate());
                    
                    
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
    
    
    
    
    function updatePOLineItem(key,index,value){
  	  tripLineArray[index][key]=value;
  	  console.log(tripLineArray);
    }
    
    
    function updatetotalAmount(value,index){
  	  var quntity =$("#quantityInvoiced_"+index).val();
    	if(value=="" || quntity==""){
    		
    		return;
    	}
    	
    	
    	if(quntity==""){
    		
    	}
    	quntity =parseFloat($("#quantityInvoiced_"+index).val());
    	
      var unitprice =parseFloat($("#unitPrice_"+index).val());
    	var baseAmount=(parseFloat(unitprice)*parseFloat(quntity)).toFixed(2);
  	 $("#baseAmt_"+index).val(baseAmount);
  	 
  	 baseAmount=parseFloat(baseAmount); 
  	 tripLineArray[index].baseAmount=baseAmount;
  	 
    	var taxAmount=baseAmount*(parseFloat(value)/100);
    	taxAmount=parseFloat(taxAmount).toFixed(2);
    	$("#tax_"+index).val(taxAmount);
    	 
    	var totalAmount=(parseFloat(baseAmount)+parseFloat(taxAmount)).toFixed(2);
    	
    	$("#totamt_"+index).val(totalAmount);
    	
    	
    	
    //	grosstotalamt=(parseFloat(grosstotalamt)+parseFloat(totalAmount)).toFixed(2);
    	
    	
    	
    	 tripLineArray[index].totalAmount=totalAmount;
    	 tripLineArray[index].taxAmount=taxAmount;
    	 tripLineArray[index].taxper=value;
    	 
    	calculateGrossAmt();
  	  
    	 
    }
   
    
    function calculateGrossAmt(){
  	  grosstotalamt=0;
  	  	 for(var k=0; k<tripLineArray.length; k++){
  	  		 
  	  		 if(tripLineArray[k].hasOwnProperty("totalAmount")){
  	  			grosstotalamt += parseFloat(tripLineArray[k].totalAmount);
  	  		 }
  	  	 }
  	  	 
  	  	 
  	  	 
  	  	$("#grossAmt").val(parseFloat(grosstotalamt).toFixed(2));
  	  	 tripLineArray.grossTotalAmt=grosstotalamt;
  		  
    }
    
    function setTripArrayDataBlankForIndex(index){
  	  
  	  $("#quantityInvoiced_"+index).val("");
  	   $("#baseAmt_"+index).val("");
  	   $("#remaningQuantity_"+index).val("");
  	   $("#tax_"+index).val("");
  	   $("#totamt_"+index).val("");
  	  
  	  tripLineArray[index].totalAmount=0;
  	  	 tripLineArray[index].taxAmount=0;
  	  	 tripLineArray[index].taxper=0;
  	  	tripLineArray[index].baseAmount=0;
  	  	tripLineArray[index].quantityInvoiced=""; 
  	  	
  	  	calculateGrossAmt();
    }
    
    var remaningQuatity=[];
    var remanId=[];
   function updatebaseaAmt(reId, index,quntity){
  	 
  	 
  	 if(quntity==""){
  		 
  		 setTripArrayDataBlankForIndex(index);
  		 return; 
  	 }
  	   var allquantity =parseFloat(tripLineArray[index].quantity)
  	   //var allquantity = remaningQuat;
  		 quntity=parseFloat(quntity);
  		  		 if(quntity<=allquantity){
  		  			 
  		  			tripLineArray[index].quantityInvoiced=quntity; 
  		  			 var  remaningQuantity= allquantity-quntity;
  					  $("#remaningQuantity_"+index).val(remaningQuantity);
  					 var taxper = $("#taxper_"+index).val();
  					 tripLineArray[index].remaningQuatity=remaningQuantity;
  						tripLineArray[index].lineitemId=reId; 
  					 updatetotalAmount(taxper,index);
  					  // remanId[index].reId=reId;
  					  // remaningQuatity[index].remaningQuatity=remaningQuantity;
  					
  					  // remanId.push(reId);
  					  // remaningQuatity.push(remaningQuantity);			        
  					  // tripLineArray[index].remaningQuantity=remaningQuantity;   
  					  
  					  // tripLineArray[index].taxper=taxper;
  	    
  				   }else{
  					  // alert("kjhlkjh");
  					  alert("Quantity is greater");
  					  setTripArrayDataBlankForIndex(index);
                     }	
  	 }
  	  
    

    
    
    
      
  function sendToServer() {
    	
    	//invoiceDate
		var invoiceDa = document.getElementById("invoiceDate").value;
		if (invoiceDa === "" || invoiceDa === null || invoiceDa === '') {
            Toast.fire({
                type: 'error',
                title: 'Please Select Date'
            });
            document.getElementById("invoiceDate").focus();
            return "";
        }
    	
    	var invoiceNu = document.getElementById("invoiceNumber").value;
		if (invoiceNu === "" || invoiceNu === null || invoiceNu === '') {
            Toast.fire({
                type: 'error',
                title: 'Please fill Invoice Number'
            });
            document.getElementById("invoiceNumber").focus();
            return "";
        }
		
		//invoiceDate
		/* var invoiceAm = document.getElementById("invoiceAmount").value;
		if (invoiceAm === "" || invoiceAm === null || invoiceAm === '') {
            Toast.fire({
                type: 'error',
                title: 'Please fill Invoice Amount'
            });
            document.getElementById("invoiceAmount").focus();
            return "";
        }
		
		//vehicleNumber
		var vehicleNu = document.getElementById("vehicleNumber").value;
		if (vehicleNu === "" || vehicleNu === null || vehicleNu === '') {
            Toast.fire({
                type: 'error',
                title: 'Please fill vehicle Number'
            });
            document.getElementById("vehicleNumber").focus();
            return "";
        }

		//vehicleNumber
		var invoiceDoc = document.getElementById("InvoiceUpload").value;
		if (invoiceDoc === "" || invoiceDoc === null || invoiceDoc === '') {
            Toast.fire({
                type: 'error',
                title: 'Please Upload Document'
            });
            document.getElementById("InvoiceUpload").focus();
            return "";
        }
		//vehicleNumber
		/* var docOne = document.getElementById("DocumentFileOne").value;
		if (docOne === "" || docOne === null || docOne === '') {
            Toast.fire({
                type: 'error',
                title: 'Please Upload Document'
            });
            document.getElementById("DocumentFileOne").focus();
            return "";
        }
		//vehicleNumber
		var docTwo = document.getElementById("DocumentFileTwo").value;
		if (docTwo === "" || docTwo === null || docTwo === '') {
            Toast.fire({
                type: 'error',
                title: 'Please Upload Document'
            });
            document.getElementById("DocumentFileTwo").focus();
            return "";
        } */

         var stepOneObj = FormDataToJSON('stepOneForm');
        //var stepThreeObj = FormDataToJSON('stepThreeForm');

        const finalObj = {
            ...stepOneObj,
           // ...stepThreeObj
        };
	console.log();
    

        
     // after
       /*  tripLineArray.forEach((item) => {
        	console.log(tripLineArray);
        	console.log(item);
        	item.id=null;
        });
     
     console.log(tripLineArray);
        
        finalObj.invoiceLineItem=tripLineArray */;
        
        console.log(finalObj);
//return;
        
        $.ajax({
            type: "POST",
            data: JSON.stringify(finalObj),
            url: "<%=GlobalUrl.savePoInvoice%>",
            dataType: "json",
            contentType: "application/json",
            success: function(response) {

            	 if (response.msg == 'success') {
                     swal.fire("Thanks", "your Invoice Process Sucessfully", "success", "OK").then(function() {
                    	 window.opener.refereshList();
                         window.close();
                         //window.location="closedAndApprovedTrips";
                     });
                     
                     
                     setTimeout(function(response) {

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




    
    </script>
</body>

</html>
