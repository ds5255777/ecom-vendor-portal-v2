<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titleName}|InvoiceProcess</title>
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
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
            <h5 style="color: white;">Invoice-Process</h5>
            <ul class="navbar-nav ml-auto">
                <h6 class="float-sm-right" style="color: white;">
                    <b>Invoice Number : </b> <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" value="${invoiceNo}" readonly style="background: #007BFF; color: white; border: 0px;">
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
                                            <label class="col-sm-5">Supplier Invoice Number
                                                <span class="text-danger"></span>
                                            </label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Number" name="vendorInvoiceNumber" id="vendorInvoiceNumber" maxlength="70" style="width: 100%;">
												<input type="hidden" id="status" value="${status }">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Type <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Type" name="invoiceType" id="invoiceType" readonly style="width: 100%;">
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
                                                <select class="form-control-sm select2" style="width: 100%;" id="invoiceCurrency" name="invoiceCurrency" disabled="disabled">
                                                    <option value="INR">INR</option>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Amount <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="invoice Amount" onkeypress="return event.charCode >= 46 && event.charCode <= 57" maxlength="70" name="invoiceAmount" id="invoiceAmount" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Site <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Supplier Site" name="supplierSite" id="supplierSite" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3" style="display: none;">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Operating Unit</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="operatingUnit" id="operatingUnit" placeholder="Operating Uni" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Currency<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <select class="form-control-sm select2" style="width: 100%;" id="paymentCurrency" name="paymentCurrency" disabled="disabled">
                                                    <option value="INR" disabled>INR</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms Date<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="termsDate" id="termsDate" readonly="readonly" placeholder="Terms Date" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms <span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="terms" id="terms" placeholder="Terms" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Method<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="paymentMethod" id="paymentMethod" placeholder="Payment Method" style="width: 100%;" readonly="readonly">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Remit To bank account Number
                                                <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="remitToBankAccountNumber" id="remitToBankAccountNumber" placeholder=" Remit To bank account number" style="width: 100%;" maxlength="20">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card card-primary" id="lineItems" style="display: none;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Line Item's</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <form id="stepThreeForm" class="forms-sample">
                            <div class="card-body" style="overflow: auto;">
                                <table id="prTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
                                                S.No</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
                                                Line Number</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Description</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Quantity
                                                Invoiced</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Unit
                                                Price</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">UOM</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Tax
                                                %</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Base
                                                Amount</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Tax
                                                Amount</th>
                                            <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Total
                                                Amount</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </form>
                    </div>

                    <div class="card card-primary" id="queryWindow" style="margin-top: 1rem;  display: none;">
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
                                            <label class="col-sm-3">Remarks <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" id="comment" name="comment" rows="3" placeholder="Remarks if Any"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-md-3">
                                            <div class="col-md-1" id="raiseQueryDiv">
                                                <button type="button" id="raiseQuery" value="raiseQuery" onclick="raiseQueryModel()" class="btn btn-primary">Replay
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <button type="button" class="btn btn-primary" id="closeModal" onclick="closeWin()">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="card card-primary" style="margin-top: 1rem; display: none;">
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
                    <div class="form-group text-center">
                        <div class="col-md-3"></div>
							<button type="button" id="viewAttachment" value="viewAttachment" class="btn btn-primary btn-lg">View Attachments</button>
							 <button type="button" id="closeWindow" class="btn btn-info btn-lg">Close</button>
							 
                        <!-- <button type="button" onclick="closeWin()" class="btn btn-info btn-lg">Close</button> -->
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
                </div>
            </section>
        </div>
    </div>
    <aside class="control-sidebar control-sidebar-dark">
    </aside>
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

    <script src="js/invoiceViewPo.js"></script>


</body>

</html>
