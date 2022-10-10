<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titleName} | Draft Invoice Generate</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
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

        #ui-datepicker-div {
            z-index: 1000 !important;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm">
    <div class="wrapper">
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
            <h5 style=" color: white;">Invoice-Process</h5>
            <ul class="navbar-nav ml-auto">
                <h6 class="float-sm-right" style="color: white;">
                    <b>Invoice Number : </b> <input type="text" name="ecomInvoiceNumber" id="ecomInvoiceNumber" readonly value="${invoiceNumber }" style="background: #007BFF; color: white; border: 0px;">
                </h6>
            </ul>
        </nav>

        <div class="content-wrapper" style="margin-left: 0px !important;">
            <section class="content" style="overflow: hidden;">
                <div class="container-fluid">
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
                                            <label class="col-sm-5">Partner Name <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="vendorName" id="vendorName" readonly value="${vendorName }" style="width: 100%;">
                                                <input type="hidden" id="listOfSelectTrips" value="${listofTrips}">
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
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <select class="form-control-sm select2" style="width: 100%;" id="invoiceCurrency" name="invoiceCurrency">
                                                    <option value="INR">INR</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Receiving Date</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" style="width: 100%;" name="invoiceReceivingDate" id="invoiceReceivingDate" readonly value="<%=(new java.util.Date()).toLocaleString()%>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="invoiceDate" placeholder="Invoice Date" class="form-control-sm" style="width: 100%;" id="invoiceDate" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Number <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Number"  name="invoiceNumber" id="invoiceNumber" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">e-Invoice Applicable</label>
                                            <div class="col-sm-7">
                                                <input type="text" name="eInvoiceApplibale" id="eInvoiceApplibale" value="${eInvoiceStatus }"  class="form-control-sm" style="width: 100%;" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">IRN Number<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="irnNumber" placeholder="IRN Number" class="form-control-sm" maxlength="70" style="width: 100%;" id="irnNumber" >
                                            </div>
                                        </div>
                                    </div>


                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">HSN Code<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="hsnCode" id="hsnCode" type="text" placeholder="HSN Code" style="width: 100%;" maxlength="8">
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
                                            <label class="col-sm-5">Tax (%)<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" readonly name="taxAmount" id="taxAmount" type="number" placeholder="Tax Amount" value="18" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Cess/Tax<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="greenTax" id="greenTax" type="text" placeholder="Cess/Tax If Applicable" style="width: 100%;"  maxlength="5" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Extra KM<span class="text-danger"> </span></label>
                                            <div class="col-sm-2">
                                                <input class="form-control-sm" name="exteraKM" id="exteraKM" type="text" placeholder="Ex KM" style="width: 100%;" maxlength="5">
                                            </div>
                                            <div class="col-sm-2">
                                                <input class="form-control-sm" name="ratePerKm" id="ratePerKm" type="text" readonly style="width: 100%;">
                                            </div>
                                            <div class="col-sm-3">
                                                <input class="form-control-sm" name="extraKmRate" id="extraKmRate" type="text" readonly placeholder="Rate KM" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Other Charges<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="miscellaneous" id="miscellaneous" type="text" placeholder="If Applicable" style="width: 100%;" maxlength="5">
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

                                    <input type="hidden" id="id" name="id">
                                    <input type="hidden" id="ecomInvoiceNumber" name="ecomInvoiceNumber" value="${invoiceNumber }">

                                </div>
                            </form>
                        </div>
                    </div>
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
                                                    5px;height: 30px;padding: 2px 10px 2px 10px;" id="docBtn" name="docBtn" >Add</button>

                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>


                        <div class="card-body" style="overflow: auto;">
                            <table id="prTable" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Number</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip ID</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Rate per km</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Current Fuel
                                            Rate</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS Base Rate</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Std. Vehicle</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS Diff</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Basic Freight</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Mileage</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Total Freight</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Lumpsome Amount</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Line level
                                            Description</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Action</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Document Upload</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body" style="overflow: auto;">
                            <form id="stepFourForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Upload Invoice<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="InvoiceUpload" name="InvoiceUpload" class="form-control-sm" accept=" .pdf"  class="form-control p-input">
                                                <textarea id="InvoiceFileText" name="InvoiceFileText" rows="5" style="display: none;"></textarea>
                                                <label><span style="font-weight: 500; color: #fd7e14;">(* File size Max 5 MB)</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Summary Sheet<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="DocumentFileOne" name="DocumentFileOne" class="form-control-sm" accept=".pdf, .doc, .docx, .xls, .xlsx"  class="form-control p-input">
                                                <textarea id="DocumentFileOneText" name="DocumentFileOneText" rows="5" style="display: none;"></textarea>
                                                <label><span style="font-weight: 500; color: #fd7e14;">(* File size Max 5)</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">FS Calculation Sheet<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="DocumentFileTwo" name="DocumentFileTwo" class="form-control-sm" accept=".pdf, .doc, .docx, .xls, .xlsx"  class="form-control p-input">
                                                <textarea id="DocumentFileTwoText" name="DocumentFileTwoText" rows="5" style="display: none;"></textarea>
                                                <label><span style="font-weight: 500;color: #fd7e14;">(* File size Max 5 MB)</span></label>
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
                        <button type="button" id="saveInvoiceToServer" class="btn btn-success">Submit Invoice</button>

                        <label style="visibility: hidden;">Select</label>
                        <button type="button" id="deleteInvoice" class="btn btn-info" style="background-color: #323d84">Cancel Invoice</button>

                        <label style="visibility: hidden;">Select</label>
                        <button type="button" id="closeWindow" class="btn btn-info">Save as Draft</button>
                    </div>
                </center>
            </section>
        </div>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="dist/js/demo.js"></script>
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
    <script src="plugins/select2/js/select2.full.min.js"></script>
    
     <script src="js/draftInvoiceGenerate.js"></script>
	<script src="js/commonFunctions.js"></script>

</body>

</html>
