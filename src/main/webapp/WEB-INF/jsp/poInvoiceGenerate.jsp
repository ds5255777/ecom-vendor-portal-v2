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

<body class="hold-transition sidebar-mini sidebar-collapse text-sm" onunload="javascript:refreshParent()">
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
                                                <input type="text" name="invoiceDate" id="invoiceDate"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                 
                                    
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <select class="form-control-sm select2" style="width: 100%;" id="invoiceCurrency" name="invoiceCurrency" readonly>
                                                    <option value="INR" readonly>INR</option>
                                                   
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">invoice Amount <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <!-- <input class="form-control-sm" type="text" placeholder="Site Name" name="siteName" id="siteName" style="width: 100%;"> -->
                                                <input class="form-control-sm" type="text" placeholder="invoice Amount" name="invoiceAmount" id="invoiceAmount"  style="width: 100%;">
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
                                            <label class="col-sm-5">Operating Unit<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="operatingUnit" id="operatingUnit"  placeholder="Operating Uni"readonly  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Trading partner<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="tradingPartner" id="tradingPartner" type="text" placeholder="Trading partner" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Number<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="supplierNum" id="supplierNum" placeholder="Supplier Number" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">GL Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="date" name="glDate" id="glDate" placeholder="GL Date"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Currency<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                
                                                 <select class="form-control-sm select2" style="width: 100%;" id="paymentCurrency" name="paymentCurrency" readonly>
                                                    <option value="INR" readonly>INR</option>
                                                   
                                                </select>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Match Option <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="invoiceMatchoption" id="invoiceMatchoption" placeholder="Match Option" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms Date<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="date" name="termsDate" id="termsDate" placeholder="Terms Date"  style="width: 100%;" on>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="terms" id="terms" placeholder="Terms"  style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Method</label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="paymentMethod" id="paymentMethod"  placeholder="Payment Method"  style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Pay Group </label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm"  name="payGroup" id="payGroup" placeholder="Pay Group "  style="width: 100%;">
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
                                            <label class="col-sm-5">Supplier Invoice number (DFF)</label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="supplierInvoiceNumber" id="supplierInvoiceNumber"  placeholder="Supplier Invoice number"  style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier invoice date (DFF) </label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="date" name="supplierInvoiceDate" id="supplierInvoiceDate" placeholder=" Supplier invoice date"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    

                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- /.card -->
                                       <!-- /.card -->

                  <!--   <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Document Upload</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div> -->
                        <!-- /.card-header -->
                    <!--     <div class="card-body" style="overflow: auto;">
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
                            <form id="stepThreeForm" class="forms-sample">
                                <div class="row">
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Line type <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="lineType" name="lineType" id="lineType"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Account<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Account" name="account" id="account"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">GL Date<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="date" placeholder="GL Date" name="gldate" id="gldate"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Amount <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Type" name="amount" id="amount"   style="width: 100%;">
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
                        
                        
                        
                     <!--  <div class="card-body">
                            <form id="stepTwoForm" class="forms-sample">
                                <div class="row">
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Line type <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="lineType" name="lineType1" id="lineType1"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">PO Number<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="poNumber" name="poNumber1" id="poNumber1" disabled="disabled" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">GL Date<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="date" placeholder="GL Date" name="gldate1" id="gldate1"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Amount <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Amount" name="amount1" id="amount1"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">PO Line <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="PO Line" name="poLine1" id="poLine1"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Receipt Number <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Receipt Number" name="amount1" id="receiptNumber1"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Receipt Line <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Receipt Line" name="receiptLine1" id="receiptLine1"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Quantity Invoiced <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Quantity Invoicede" name="quantityInvoiced1" id="quantityInvoiced1"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                       <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">UOM <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="UOM" name="uom1" id="uom1"   style="width: 100%;" readonly>
                                            </div>
                                        </div>
                                    </div>
                                       <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Unit Price <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Unit Price" name="unitPrice1" id="unitPrice1"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                      <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Description <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Description" name="description1" id="description1"   style="width: 100%;" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <button type="Button" class="btn btn-primary" id="addBookGridButt" name="addBookGridButt">Add Item</button>
                                    
                                 </div>
                             </form>
                          </div>
                          </div>
                        
                       

                        /.card-body
                    </div>
 -->                    <!-- /.card -->
                   
                    
                    
                    <center>
                        <div class="form-group">
                            <label style="visibility: hidden;">Select </label>
                            <button type="button" onclick="sendToServer()" class="btn btn-info">Submit Invoice</button>

                            <label style="visibility: hidden;">Select</label>
                            <button type="button" onclick="savedraftinvoice();" class="btn btn-info">Discard Invoice</button>

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
    
    var  poNo='${PoNumber}';
   // alert("poNo"+poNo)
   
   getPoDetails();
    
    function getPoDetails() {
    	tripLineArray=[];
        var obj = {
            "poNo": poNo
        }
		
        $.ajax({
            type: "POST",
            data: JSON.stringify(obj),
            url: "<%=GlobalUrl.getAllPODetailsByPoNo%>",
            dataType: "json",
            contentType: "application/json",
            async: false,
            success: function(data) {

                if (data.msg == 'success') {
                    var result = data.data;
                   //var tripLineArray = data.data.poInvoiceLine;
                    tripLineArray=result[0].poLineDetails;
                    var myForm = "";
                    myForm = document.getElementById("stepOneForm");
                    setData(myForm, result[0]);
                
                  /*   myForm = document.getElementById("stepTwoForm");
                    setData(myForm, result[0]); */
                    
                    $('#org2').val(result[0].org)
                     $('#uom2').val(result[0].uom)
                      $('#shipTo2').val(result[0].shipTo)
                       $('#quantity2').val(result[0].quantity);
                    
                    $('#needByDate2').val(result[0].needByDate)
                    $('#chargeAccount2').val(result[0].chargeAccount)
                 
                   // myForm = document.getElementById("stepThreeForm");
                   // setData(myForm, result[0]);
                    $('#deliverTo3').val(result[0].deliverTo)
                    $('#chargeAccount3').val(result[0].chargeAccount)
                    
              
                 $('#poNumber').val('${PoNumber}'); 
                    $('#poNumber1').val('${PoNumber}'); 
                    
                    $('#uom1').val( tripLineArray[0].uom);
                    $('#description1').val( tripLineArray[0].description);
                    
                    var d = new Date();
                    $( "#invoiceDate" ).val(d.getFullYear()+'/'+(d.getMonth()+1)+'/'+d.getDate());
                    
                    $('#invoiceCurrency').val(result[0].currency);  
                    $('#paymentCurrency').val(result[0].currency); 
                    
                 //   Quantity	Remaning Quantity 	Quantity Invoiced	Unit Price	UOM	Tax Percentage	Base Amount	Tax Amount	Total Amount
                    
                    $('#prTable').DataTable().clear();
                    for (var i = 0; i < tripLineArray.length; i++) {

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
                        var receipentLine= "<input type=\"text\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('receipentLine','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
                        var description= "<input type=\"text\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('description','"+i+"',this.value)\" value=\"" + tripLineArray[i].description + "\" class=\"form-control-sm \" \"> ";
                        var lineType= "<input type=\"text\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('lineType','"+i+"',this.value)\"  class=\"form-control-sm \" \"> ";
                        var poline= "<input type=\"text\" style=\"width: 100px; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var glDate= "<input type=\"text\" style=\"width: 100px; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var remaningQuantity= "<input type=\"text\" style=\"width: 100%; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var quantity= "<input type=\"text\" style=\"width: 100px; height: 28px;\" value=\"" + tripLineArray[i].quantity + "\" class=\"form-control-sm \" \"> ";
                        var quantityInvoiced= "<input type=\"text\" id=\"quantityInvoiced_"+i+"\" style=\"width: 100%; height: 28px;\" oninput=\"updatebaseaAmt('"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
                        var unitPrice= "<input type=\"text\" style=\"width: 100%; height: 28x;\" value=\"" + tripLineArray[i].price + "\" oninput=\"updatePOLineItem('receipentLine','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
                        var uom= "<input type=\"text\" style=\"width: 100px; height: 28px;\"  class=\"form-control-sm \" \"> ";
                        var taxAmount= "<input type=\"text\" style=\"width: 100%; height: 28px;\"  id=\"tax_"+i+"\" class=\"form-control-sm \" \"> ";
                        var baseAmount= "<input type=\"text\" style=\"width: 100%; height: 28px;\"   id=\"baseAmt_"+i+"\"   class=\"form-control-sm \" > ";
                        var taxPercentage= "    <select  class=\"form-control-sm \" style=\"width: 100%; height: 28px;\" id=\"taxAmount\"  onchange=\"updatetotalAmount(this.value,'"+i+"')\" > <option value=\"0\" \">0%</option><option value=\"5\"  \">5%</option><option value=\"8\"  \">8%</option><option value=\"18\" \">18%</option><option value=\"28\" \">28%</option> </select > ";
                        var totalAmount= "<input type=\"text\"  class=\"form-control-sm \" style=\"width: 100%; height: 28px;\" id=\"totamt_"+i+"\" > ";
                        
                        
                       // action = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"deleteRow('" + result[i].tripID + "')\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
						$('#prTable').DataTable().row.add([i + 1,receipentLine,description,lineType,poline,glDate,quantity,remaningQuantity,quantityInvoiced,unitPrice,uom,taxPercentage,baseAmount,taxAmount,totalAmount]);
                        
						
						
                        //Receipent Line	Description	Line Type	PO Line	GL Date
                       // Quantity	Remaning Quantity 	Quantity Invoiced	Unit Price	UOM	Tax Percentage	Base Amount	Tax Amount	Total Amount
                    }
                    $('#prTable').DataTable().draw();
                    $("tbody").show();
                       
                    
                    
                    
                    
                }else {
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
    
    
    
  //  setDraftInvoice();
    
  function updatePOLineItem(key,index,value){
	  tripLineArray[index][key]=value;
	  console.log(tripLineArray);
  }
  
    function setDraftInvoice() {
    	

	   
        
       
            //itrDetailsArray.push(objs);
        

      
        var matchOption=$("#invoiceMatchoption").val() ;
       
        
       // itrDetailsArray.push(obj);

         var stepOneObj = FormDataToJSON('stepOneForm');
        var stepThreeObj = FormDataToJSON('stepThreeForm');

        const finalObj = {
            ...stepOneObj,
            ...stepThreeObj
            
        };
       
        
        
       // finalObj.poInvoiceLine.poNumber =poNo;
        finalObj.matchOption=matchOption;

        
        console.log(finalObj);
//return;
        
        $.ajax({
            type: "POST",
            data: JSON.stringify(finalObj),
            url: "<%=GlobalUrl.saveDraftInvoice%>",
            dataType: "json",
            contentType: "application/json",
            success: function(response) {

            	

            	 if (response.msg == 'success') {
                     
                    
                     
                     
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

    function updatetotalAmount(value,index){
 	   
    	if(value==""){
    		return;
    	}
    	var baseamt =parseFloat(tripLineArray[index].price);
    	var taxamt=baseamt*(parseFloat(value)/100);
    	taxamt=parseFloat(taxamt).toFixed(2);
    	$("#tax_"+index).val(taxamt);
    	var totalAmount=(parseFloat(baseamt)+parseFloat(taxamt)).toFixed(2);
    	
    	$("#totamt_"+index).val(totalAmount);
    	
    	
    }
    
   function updatebaseaAmt(index,quntity){
	   var allquantity =parseFloat(tripLineArray[index].quantity)
	   if(allquantity>=parseFloat(quntity)){
					
		  
   	
			  
				   var unitprice =parseFloat(tripLineArray[index].price);
				   
				var baseamt=(parseFloat(unitprice)*parseFloat(quntity)).toFixed(2);
				 $("#baseAmt_"+index).val(baseamt);
   			
      
			   }else{
				  // alert("kjhlkjh");
				   $("#quantityInvoiced_"+index).val("");
				   $("#baseAmt_"+index).val("");
				   
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
       
       
        
        
        
        
      
        
        var matchOption=$("#invoiceMatchoption").val() ;
       
        
        //itrDetailsArray.push(obj);

         var stepOneObj = FormDataToJSON('stepOneForm');
        var stepThreeObj = FormDataToJSON('stepThreeForm');

        const finalObj = {
            ...stepOneObj,
            ...stepThreeObj
            
        };
        
       
        //finalObj.poInvoiceLine.poNumber =poNo;
        finalObj.matchOption=matchOption;
        
	console.log();
    
        
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
                     swal.fire("Thanks", "Invoice Process Sucessfully", "Success", "OK").then(function() {
                    	
                         window.close();
                       
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
  			  Discardinvoice();
    		function Discardinvoice(){

    		    
    	      
    	        var matchOption=$("#invoiceMatchoption").val() ;
    	       
    	        
    	       // itrDetailsArray.push(obj);

    	         var stepOneObj = FormDataToJSON('stepOneForm');
    	        var stepThreeObj = FormDataToJSON('stepThreeForm');

    	        const finalObj = {
    	            ...stepOneObj,
    	            ...stepThreeObj
    	            
    	        };
    	        
    	       
    	       // finalObj.poInvoiceLine.poNumber =poNo;
    	        finalObj.matchOption=matchOption;

	        
	        console.log(finalObj);
	//return;
	        
	        $.ajax({
	            type: "POST",
	            data: JSON.stringify(finalObj),
	            url: "<%=GlobalUrl.saveDraftInvoice%>",
	            dataType: "json",
	            contentType: "application/json",
	            success: function(response) {

	            	

	            	 if (response.msg == 'success') {
	                     
	            		
	            		 
	                     
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
    
    		function savedraftinvoice(){
    			Discardinvoice();
    		 swal.fire("", "Save To Draft ", "success", "OK").then(function() {
            	
                 window.close();
                 
             });
    		}
    		
    		 function refreshParent() 
    	        {
    	            window.opener.location.reload(true);
    	        }
    	
    		  $("#addBookGridButt").click(function() {
    	            var abc = document.getElementById('lineType1').value;
    	            var abc2 = document.getElementById('poNumber1').value;
    	            var abc3 = document.getElementById('gldate1').value;
    	            var abc4 = document.getElementById('amount1').value;
    	            var abc5 = document.getElementById('poLine1').value;
    	            var abc6 = document.getElementById('receiptNumber1').value;
    	            var abc7 = document.getElementById('receiptLine1').value;
    	            var abc8 = document.getElementById('quantityInvoiced1').value;
    	            var abc9 = document.getElementById('uom1').value;
    	            var abc10 = document.getElementById('unitPrice1').value;
    	            var abc11 = document.getElementById('description1').value;
    	            console.log("abc =>" + abc);
    	            if (abc == null || abc == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            } else if (abc6 == null || abc6 == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            } else if (abc3 == null || abc3 == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            }  else if (abc4 == null || abc4 == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            } else if (abc5 == null || abc5 == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            }  else if (abc7 == null || abc7 == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            } else if (abc8 == null || abc8 == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            }else if (abc10 == null || abc10 == "") {
    	                swal.fire("Alert", "Fill Mandatory Field ! ", "warning");
    	                return false;
    	            }
    	            else {

    	                $("#addBookGrid").append(' <tr class=""><td>' +
    	                		abc + '</td><td>' +
    	                		abc2+ '</td><td>' +
    	                		abc3 + '</td><td>' +
    	                		abc4 + '</td><td>' +
    	                		abc5 + '</td><td>' +
    	                		abc6+ '</td><td>' +
    	                		abc7 + '</td><td>' +
    	                		abc8 + '</td><td>' +
    	                		abc9+ '</td><td>' +
    	                		abc10 + '</td><td>' +
    	                		 abc11 + '</td>' +
    	                     '<td><a href="#" class="btn btn-danger btn-sm" onClick="$(this).closest(&quot;tr&quot;).remove();">Remove</a></td></tr>');

    	                 document.getElementById('lineType1').value="";
        	             //document.getElementById('poNumber1').value="";
        	             $('#poNumber1').val('${PoNumber}'); 
        	           document.getElementById('gldate1').value="";
        	             document.getElementById('amount1').value="";
        	             document.getElementById('poLine1').value="";
        	             document.getElementById('receiptNumber1').value="";
        	           document.getElementById('receiptLine1').value="";
        	             document.getElementById('quantityInvoiced1').value="";
        	             document.getElementById('uom1').value="";
        	             document.getElementById('unitPrice1').value="";
        	             document.getElementById('description1').value="";
    	            }

    	        });

    		 
    		 
    		  
    </script>
</body>

</html>
