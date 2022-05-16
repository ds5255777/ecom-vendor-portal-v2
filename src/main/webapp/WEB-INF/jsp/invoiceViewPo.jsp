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
     <script src="plugins/toastr/toastr.min.js"></script>
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
                    <b>Invoice Number : </b> <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" value="${invoiceNo}" readonly style="background: #007BFF; color: white; border: 0px;">
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
                            <h4 class="card-title">Basic Details</h4>
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
                                            <label class="col-sm-5">Supplier Invoice number (DFF) <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                 <input class="form-control-sm" type="text" placeholder="Invoice Number" name="vendorInvoiceNumber" id="vendorInvoiceNumber" maxlength="70" style="width: 100%;">
                                  
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Type <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Type" name="invoiceType" id="invoiceType"  readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Po Number<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="poNumber" id="poNumber" readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="invoiceDate" id="invoiceDate" readonly class="form-control-sm" style="width: 100%;">
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
                                                <input class="form-control-sm" name="tradingPartner" id="tradingPartner" type="text" placeholder="Trading partner" style="width: 100%;" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Number<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="supplierNum" id="supplierNum" readonly="readonly"  placeholder="Supplier Number" style="width: 100%;" on>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">GL Date <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="glDate" id="glDate" placeholder="GL Date" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                       <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Currency<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                
                                                 <select class="form-control-sm select2" style="width: 100%;" id="paymentCurrency" name="paymentCurrency" disabled="disabled">
                                                    <option value="INR" readonly>INR</option>
                                                   
                                                </select>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Match Option <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="matchOption" id="matchOption" placeholder="Match Option" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms Date<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="termsDate" id="termsDate" readonly="readonly" placeholder="Terms Date"  style="width: 100%;" on>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="terms" id="terms" placeholder="Terms" readonly style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Method<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="paymentMethod" id="paymentMethod"  placeholder="Payment Method"  style="width: 100%;" readonly="readonly">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Pay Group <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="payGroup" id="payGroup" placeholder="Pay Group " readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Remit To Bank Account Name<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="remitToBankAccountName" id="remitToBankAccountName"  placeholder="Remit To bank account name" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Remit To bank account number <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="remitToBankAccountNumber" id="remitToBankAccountNumber"  placeholder=" Remit To bank account number"  style="width: 100%;" maxlength="20">
                                            </div>
                                        </div>
                                    </div>
                                    
                                  
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier invoice date (DFF) </label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="supplierInvoiceDate" id="supplierInvoiceDate" placeholder=" Supplier invoice date"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    

                                </div>
                            </form>
                        </div>
                    </div>
                    
                    
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
                                                <input class="form-control-sm" type="text" placeholder="GL Date" name="gldate1" id="gldate1" readonly style="width: 100%;">
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
                        <form id="stepThreeForm" class="forms-sample">
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
                                        <!-- <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Quantity</th> -->
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Remaning Quantity</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Quantity Invoiced</th>
                                       
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">UOM</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Tax %</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Base Amount</th>
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Tax Amount</th>
                                       
                                        <th class="bg-primary"  style="padding: 5px 5px 5px 1.5rem;">Total Amount</th>
                                        
                                    </tr>
                                        
                                    </thead>
                                </table>
                            </div>
                        </form>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                    <!-- Query Form -->
                    
                    <div class="card card-primary" id="queryWindow" style="margin-top: 1rem;">
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
                                    <div>
                                    <div class="col-md-3">
                                    <div class="col-md-1"  id="raiseQueryDiv">
								<button type="button" id="raiseQuery" value="raiseQuery"
									onclick="raiseQueryModel()" class="btn btn-primary">Replay
									</button>
							</div></div></div>
							 <div>
                                    <div class="col-md-3">
                                 <div class="form-group">
                            
                            <button type="button" class="btn btn-primary" id="closeModal" onclick="closeWin()">Close</button>
                        </div>
							</div></div>
                                    
                                </div>
                                
                                
                            </form>
                        </div>
                    </div>
                    
                    
							
                    <!-- Query -->
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
                    
                    
                    <%-- <center>
                        <div class="form-group">
                            <label style="visibility: hidden;">Select </label> <br>
                            <button type="button" class="btn btn-primary" id="closeModal" onclick="closeWin()">Close</button>
                        </div>
                    </center> --%>
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
        var prTable1 = $("#prTable").DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true,
            "pageLength": 15,
        });
        
        var prTable = $("#tabledataQuery").DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true,
            "pageLength": 15,
        });
        
        
        function closeWin() {
            window.close()
        }
        var invoiceNumber = '${invoiceNo}';
        var status='${status}';
        var tripLineArray = [];
        setInvoiceDetails();

        function setInvoiceDetails() {

            var obj = {
                "invoiceNumber": invoiceNumber,
                "status"  : status
            }
			//alert("invoiceNumber"+invoiceNumber);
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getSelectInvoiceDetailsPo%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                       //var tripLineArray = data.data.poInvoiceLine;
                       var tripLineArray=result[0].poInvoiceLine;
                       var grossamt1=result[0].grossTotalAmt;
                        var myForm = "";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result[0]);
                        
                        myForm = document.getElementById("stepTwoForm");
                        setData(myForm, result[0]);
                        
                       
                     
                      //  $('#lineType').val(tripLineArray[0].lineType)
                       //  $('#account').val(result[0].account)
                       //   $('#gldate').val(tripLineArray[0].gldate)
                           $('#gldate1').val(result[0].glDate);
                       
                        
                      
                        $('#prTable').DataTable().clear();
                         for (var i = 0; i < tripLineArray.length; i++) {
                            if (!tripLineArray[i].hasOwnProperty("lineType")) {
                                tripLineArray[i].lineType = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("amount")) {
                                tripLineArray[i].amount = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("poNumber")) {
                                tripLineArray[i].poNumber = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("poline")) {
                                tripLineArray[i].poline = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("receiptNumber")) {
                                tripLineArray[i].receiptNumber = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("receiptline")) {
                                tripLineArray[i].receiptline = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("quantityInvoiced")) {
                                tripLineArray[i].quantityInvoiced = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("uom")) {
                                tripLineArray[i].uom = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("unitPrice")) {
                                tripLineArray[i].unitPrice = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("description")) {
                                tripLineArray[i].description = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("gldate")) {
                                tripLineArray[i].gldate = "";
                            }
                            
                            $('#prTable').DataTable().row.add([i + 1,tripLineArray[i].receiptline,tripLineArray[i].description,tripLineArray[i].lineType,tripLineArray[i].poline,tripLineArray[i].gldate,tripLineArray[i].remaningQuatity,tripLineArray[i].quantityInvoiced,tripLineArray[i].uom,tripLineArray[i].taxper,tripLineArray[i].baseAmount,tripLineArray[i].taxAmount,tripLineArray[i].totalAmount]);
                         }
                         var  grossamt= "<input type=\"text\" value=\"" + result[0].grossTotalAmt + "\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"grossAmt\" >";
                         prTable1.row.add(["","","","","","","","","","","","Gross Total",grossamt,""]);
                      
                         
                    
                        $('#prTable').DataTable().draw();
                        $("tbody").show();
                        $('#prTable1').DataTable().draw();
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
        
        var referenceid='${invoiceNo}';
        function raiseQueryModel(){
			var comment = document.getElementById("comment").value;
			
            if (comment === "" || comment === null || comment === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Please Insert Remarks'
                });
                document.getElementById("comment").focus();
                return "";
            }
            
            var obj = {
                    "comment": comment,
                    "referenceid": referenceid
                }
            
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.savePoInvoiceQuery%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {

                    	document.getElementById("comment").value='';
                        $('.loader').hide();
                        swal.fire("Thanks", "Sucessfully Submitted", "success", "OK")
                       // location.reload();
                      
					
                        getData();
                    } else {
                        $("#submitBtn").prop("disabled", false);
                        $('.loader').hide();

                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }

                },
                error: function(jqXHR, textStatue, errorThrown) {
                    $("#submitBtn").prop("disabled", false);
                    $('.loader').hide();
                    alert("failed, please try again");
                }

            });
            
            
        } 
        
        
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });
        
        
        getData();
        function getData(){
        	
        	 var obj = {
                    
                     "referenceid": referenceid
                 }
             
             $.ajax({
                 type: "POST",
                 data: JSON.stringify(obj),
                 url: "<%=GlobalUrl.getPoQueryData%>",
                 dataType: "json",
                 contentType: "application/json",
                 async: false,
                 success: function(data) {
                	 
                	

                     if (data.msg == 'success') {

                    	 $('#tabledataQuery').DataTable().clear();
                    	 var result = data.data;
                    	 
                    	 for (var i = 0; i < result.length; i++) {
                    	 $('#tabledataQuery').DataTable().row.add([i+1,result[i].raisedBy, result[i].raisedOn, result[i].comment]);
                    	 }
                    	   $('#tabledataQuery').DataTable().draw();
                           $("tbody").show();
                    	 
                     } else {
                         $("#submitBtn").prop("disabled", false);
                         $('.loader').hide();

                         Toast.fire({
                             type: 'error',
                             title: 'Failed.. Try Again..'
                         })
                     }

                 },
                 error: function(jqXHR, textStatue, errorThrown) {
                     $("#submitBtn").prop("disabled", false);
                     $('.loader').hide();
                     alert("failed, please try again");
                 }

             });
             

        }
       
        
    </script>
</body>

</html>
