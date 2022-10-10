<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titleName}|InvoiceView Finance</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/sweetalert2/sweetalert2.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
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
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
            <h5 style=" color: white;">Invoice-Process</h5>
            <ul class="navbar-nav ml-auto">
                <h6 class="float-sm-right" style="color: white;">
                    <b>Invoice Number : </b> <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" value="${ecomInvoiceNumber}" readonly style="background: #007BFF; color: white; border: 0px;">
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
                                            <label class="col-sm-5">Partner Name <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="vendorName" id="vendorName" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Partner Code <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Business Partner Code" name="vendorCode" id="vendorCode" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" id="invoiceCurrency" name="invoiceCurrency" readonly style="width: 100%;">
                                                <input type="hidden" id="invoiceType" value="${type }">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Receiving Date</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="invoiceReceivingDate" id="invoiceReceivingDate" readonly value="<%=(new java.util.Date()).toLocaleString()%>" style="width: 100%;">
                                                <input type="hidden" id="vendorRole" value="${role }">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Date <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input type="hidden" id="id" name="id" disabled>
                                                <input type="text" name="invoiceDate" id="invoiceDate" readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Number <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Number" name="invoiceNumber" id="invoiceNumber" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">HSN Code<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="hsnCode" id="hsnCode" type="text" placeholder="HSN Code" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="8">
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
                                                <input class="form-control-sm" name="taxAmount" id="taxAmount" type="text" placeholder="Tax Amount" style="width: 100%;" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Cess/Tax<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="greenTax" id="greenTax" type="text" placeholder="Cess/Tax Not Applicable" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5" onblur="calculateInvoice();">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Extra KM<span class="text-danger"> </span></label>
                                            <div class="col-sm-2">
                                                <input class="form-control-sm" name="exteraKM" id="exteraKM" type="text" placeholder="Ex KM" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5" onblur="calculateRateKm();calculateInvoice();">
                                            </div>
                                            <div class="col-sm-2">
                                                <input class="form-control-sm" name="ratePerKm" id="ratePerKm" type="text" placeholder="R/KM" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5">
                                            </div>
                                            <div class="col-sm-3">
                                                <input class="form-control-sm" name="extraKmRate" id="extraKmRate" type="text" placeholder="Rate KM" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Other Charges<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="miscellaneous" id="miscellaneous" type="text" placeholder="Not Applicable" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9-.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5" onblur="calculateInvoice();">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Amount <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="invoiceAmount" id="invoiceAmount" placeholder="Invoice Amount" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Status<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="invoiceStatus" id="invoiceStatus" placeholder="Invoice Amount" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

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
                        <form role="form" id="addForm" autocomplete="off">
                            <div class="row" style="padding-top: 5px; padding-left: 5px;">
                                <div class="col-md-2">
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-primary dropdown-toggle" style="  margin-bottom: 10px; margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;" data-toggle="dropdown">Export Details</button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#" id="exportLink">Download
                                                Excel</a>
                                            <a class="dropdown-item" href="#" id="exportLinkPdf">Download
                                                PDF</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-10"></div>

                            </div>
                        </form>
                        <form id="stepTwoForm" class="forms-sample">
                            <div class="card-body" style="overflow: auto;">
                                <table id="prTable" class="display nowrap table table-bordered table-striped" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip ID</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Rate/Km</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Fuel
                                                Rate</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS Base Rate</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Std. Vehicle</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS Diff</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Basic Freight</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Mileage</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Total Freight</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Lump sum Amount</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Line level
                                                Description</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </form>
                    </div>


                    <div class="card card-primary" id="queryWindow" style="display: none;" style="margin-top: 1rem;">
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
                                            <label class="col-sm-3">Remarks <span class="text-danger"></span></label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" id="comment" name="comment" rows="3" maxlength="250" placeholder="Remarks if Any"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="row">

                        <div class="col-md-3"></div>
                        <div class="col-md-2" style="display: none;" id="prosInvBtn">
                            <button type="button" style="float: right;" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal">Approve Invoice</button>
                        </div>

                        <div class="col-md-1" style="display: none;" id="raiseQueryDiv">
                            <button type="button" id="raiseQuery" value="raiseQuery" class="btn btn-warning btn-lg">Raise
                                Query</button>
                        </div>

                        <div class="col-md-2" style="display: none;" id="viewAttachmentDiv">
                            <button type="button" id="viewAttachment" value="viewAttachment" class="btn btn-primary btn-lg">View Attachment</button>
                        </div>
                        <div class="col-md-1" style="    margin-left: -102px;">
                            <button type="button" id="closewin" class="btn btn-info btn-lg">Close</button>
                        </div>


                    </div>
                    <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title">Confirmation</h3>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <p>Are You Sure to Confirm This Invoice....</p>
                                </div>
                                <div class="modal-footer">

                                    <button type="button" id="updateBtnBtn" name="updateBtnBtn" class="btn btn-primary">Approve</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card card-primary" id="remarkWindow" style="display: none;" style="margin-top: 1rem;">
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
                                <table class="table table-bordered table-hover" id="tabledataQuery">
                                    <thead>
                                        <tr>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">S.No</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Raised By</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Role/Department</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Raised On</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Remarks</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>

    <div class="modal fade" id="viewAttachmentPopUp" role="dialog">
        <div class="modal-dialog " style="max-width: 1300px;">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="container-fluid panel1">
                        <div class="row">
                            <div class="col">
                                <div class="row innerRow">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label>Document Name</label>
                                            <select class="form-control" id="multipleAttachment" style="height: 35px;">

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
                                <a id="ifrmameHref" target="_blank">Click Here to open doc in new window</a>
                                <iframe id="pdfLink" style="height:100%; width:100%" title="Navigation menu"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="dist/js/adminlte.min.js"></script>
    <script src="dist/js/demo.js"></script>
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
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>

    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
    <script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
    <script src="plugins/jszip/jszip.min.js"></script>
    <script src="plugins/pdfmake/pdfmake.min.js"></script>
    <script src="plugins/pdfmake/vfs_fonts.js"></script>
    <script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
    <script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
    <script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>


    <script src="js/invoiceViewFinance.js"></script>
</body>

</html>
