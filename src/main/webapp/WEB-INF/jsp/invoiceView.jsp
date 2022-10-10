<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head lang="en">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titleName}|InvoiceView</title>
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

        /*  #prTable  {
		    display: block;
		    overflow-x: auto;
		    white-space: nowrap;
		} */

    </style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm">
    <div class="wrapper">
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
            <h5 style=" color: white;">Invoice-Process</h5>
            <ul class="navbar-nav ml-auto">
                <li class="float-sm-right" style="color: white;">
                    Invoice Number : <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" value="${invoiceNumber}" readonly style="background: #007BFF; color: white; border: 0px;">
                </li>
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
                                                <input type="hidden" id="type" name="type" value="${type}">
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
                                            <label class="col-sm-5">Invoice Receiving Date</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="invoiceReceivingDate" id="invoiceReceivingDate" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="invoiceCurrency" id="invoiceCurrency" style="width: 100%;">
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
                                                <input class="form-control-sm" name="taxAmount" id="taxAmount" type="text" placeholder="Tax Amount" style="width: 100%;">
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
                        <div class="card-body" style="overflow: auto;">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table id="prTable" class="display nowrap table table-bordered" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary">Trip ID</th>
                                                <th class="bg-primary">Run Type</th>
                                                <th class="bg-primary">Route</th>
                                                <th class="bg-primary">Standard KM</th>
                                                <th class="bg-primary">Rate/km</th>
                                                <th class="bg-primary">Fuel Rate</th>
                                                <th class="bg-primary">FS Base Rate</th>
                                                <th class="bg-primary">Std. Vehicle</th>
                                                <th class="bg-primary">FS Diff</th>
                                                <th class="bg-primary">Basic Freight</th>
                                                <th class="bg-primary">FS</th>
                                                <th class="bg-primary">Mileage</th>
                                                <th class="bg-primary">Total Freight</th>
                                                <th class="bg-primary">Lump sum Amount</th>
                                                <th class="bg-primary">Line level Description</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
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
                                    <div class="col-md-6">
                                        <div class="col-md-3" id="raiseQueryDiv">
                                            <button type="button" id="raiseQuery" value="raiseQuery" class="btn btn-primary">Reply
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3"></div>
                        <div class="col-md-2" style="display: none;" id="viewAttachmentDiv">
                            <button type="button" id="viewAttachment" value="viewAttachment" class="btn btn-primary btn-lg">View Attachments</button>
                        </div>
                        <div class="col-md-1" style="    margin-left: -102px;">
                            <button type="button" id="closeWindow" class="btn btn-info btn-lg">Close</button>
                        </div>
                    </div>
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
                                        <table class="table table-bordered table-hover" id="tabledataQuery">
                                            <thead>
                                                <tr>
                                                    <th class="bg-primary">S.No</th>
                                                    <th class="bg-primary">Raised By</th>
                                                    <th class="bg-primary">Role/Department</th>
                                                    <th class="bg-primary">Raised On</th>
                                                    <th class="bg-primary">Remarks</th>
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
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
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

    <script src="js/invoiceView.js"></script>
</body>

</html>
