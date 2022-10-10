<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titleName}|PO Invoice Generate</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="dist/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
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

        #ui-datepicker-div {
            z-index: 1000 !important;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm" onunload="javascript:refreshParent()">
    <div class="wrapper">
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
            <h5 style="color: white;">Invoice-Process</h5>
            <ul class="navbar-nav ml-auto">
                <h6 class="float-sm-right" style="color: white;">
                    <b>Invoice Number : </b> <input type="text" name="ecomInvoiceNumber" id="ecomInvoiceNumber" value="${invoiceNumber}" readonly style="background: #007BFF; color: white; border: 0px; width: 210px;">
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
                            <form id="stepOneForm" class="forms-sample" autocomplete="off">
                                <div class="row">

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Invoice Number
                                                <span class="text-danger"></span>
                                            </label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="hidden" placeholder="Invoice Number" name="invoiceNumber" id="invoiceNumber" readonly maxlength="70" style="width: 100%;"> <input class="form-control-sm" type="text" placeholder="Invoice Number" name="vendorInvoiceNumber" id="vendorInvoiceNumber" maxlength="70" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9-_A-Za-z]/g, '').replace(/(\..*)\./g, '$1');this.value = this.value.toUpperCase();">

                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Type<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">

                                                <select class="form-control-sm select2" style="width: 100%;" id="invoiceType" name="invoiceType" readonly>
                                                    <option value="Standard" readonly>Standard</option>
                                                    <option value="Credit Memo" readonly>Credit Memo</option>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">PO Number<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="poNumber" id="poNumber" readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="invoiceDate" id="invoiceDate" readonly="readonly" class="form-control-sm" onchange="invoiceDateCheck();addtermDate();" placeholder="DD-MM-YYYY" style="width: 100%;">
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
                                            <label class="col-sm-5">Invoice Amount <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Invoice Amount" onkeypress="return event.charCode >= 46 && event.charCode <= 57" maxlength="70" name="invoiceAmount" id="invoiceAmount" style="width: 100%;" readonly>
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
                                            <label class="col-sm-5">Operating Unit<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="operatingUnit" id="operatingUnit" placeholder="Operating Uni" readonly style="width: 100%;">
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
                                            <label class="col-sm-5">Terms Date<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">


                                                <input type="text" name="termsDate" id="termsDate" readonly class="form-control-sm" placeholder="DD-MM-YYYY" style="width: 100%;">

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment / Credit
                                                Terms <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">

                                                <select id="terms" name="terms" style="width: 100%;" disabled="disabled" class="form-control-sm select2" placeholder="Payment / Credit Terms" onchange="calTermsDate()">
                                                    <option value="">Select</option>
                                                    <c:forEach items="${creidtTerms}" var="pay">

                                                        <option value="${pay}">${pay}</option>
                                                    </c:forEach>

                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Method</label>
                                            <div class="col-sm-7">

                                                <select class="form-control-sm select2" style="width: 100%;" id="paymentMethod" name="paymentMethod" readonly>
                                                    <c:forEach items="${paymentMethod}" var="met">

                                                        <option value="${met}">${met}</option>
                                                    </c:forEach>

                                                </select>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5" title="Remit To Bank Account Number">Remit To Bank Account
                                                <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-7">
                                                <select id="remitToBankAccountNumber" name="remitToBankAccountNumber" style="width: 100%;" onchange="calTermsDate()" class="form-control-sm select2" placeholder=" Remit To Bank Account Number">
                                                    <option value="">Select</option>
                                                    <c:forEach items="${accountNumber}" var="pay">

                                                        <option value="${pay}">${pay}</option>
                                                    </c:forEach>

                                                </select>
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
                                <input type="hidden" id="grossamt">
                            </div>
                        </div>

                        <div class="card-body" style="overflow: auto;">

                            <form id="stepTwoForm" class="forms-sample" autocomplete="off">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-4 control-label">Line Item</label>
                                            <div class="col-sm-8">
                                                <select id="tripList" name="tripList" class="form-control-sm select2" style="width: 100% !important;">
                                                    <option>Select Line Item</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <button type="button" class="btn btn-primary" style="margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;" id="docBtn" name="docBtn" onclick="addPOLineitem()">Add</button>

                                        </div>
                                    </div>
                                </div>
                            </form>


                            <table id="prTable" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
                                            S.No</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
                                            Line Number</th>

                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Description</th>



                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Quantity</th>
                                        <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Remaning
                                            Quantity</th>
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
                            <form id="stepFourForm" class="forms-sample" autocomplete="off">
                                <div class="row">

                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Upload Invoice<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="InvoiceUpload" name="InvoiceUpload" class="form-control-sm" accept=".jpg, .jpeg, .pdf" onchange="handleFileSelect(event,'InvoiceFileText'), onValidateFile('InvoiceUpload')" class="form-control p-input">
                                                <textarea id="InvoiceFileText" name="InvoiceFileText" rows="5" style="display: none;"></textarea>
                                                <label><span style="font-weight: 500; color: #fd7e14;">(* File
                                                        size Max ${fileSize} MB)</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label">Summary Sheet<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="file" id="DocumentFileOne" name="DocumentFileOne" class="form-control-sm" accept=".pdf, .doc, .docx, .xls, .xlsx" onchange="handleFileSelect(event,'DocumentFileOneText'), onValidateFileOne('DocumentFileOne')" class="form-control p-input">
                                                <textarea id="DocumentFileOneText" name="DocumentFileOneText" rows="5" style="display: none;"></textarea>
                                                <label><span style="font-weight: 500; color: #fd7e14;">(* File
                                                        size Max ${fileSize} MB)</span></label>
                                            </div>
                                        </div>
                                    </div>



                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-3">Remarks <span class="text-danger">*</span></label>
                                            <div class="col-sm-6">
                                                <textarea class="form-control" id="comment" name="comment" rows="1" placeholder="Remarks if Any"></textarea>
                                            </div>


                                            <div class="col-sm-3" id="raiseQueryDiv">
                                                <button type="button" id="raiseQuery" value="raiseQuery" onclick="raiseQueryModel()" class="btn btn-primary">Replay
                                                </button>
                                            </div>


                                        </div>
                                    </div>



                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card card-primary" style="margin-top: 1rem; ">
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
                                            <th style="padding: 5px 5px 5px 1.5rem;">Role</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Remarks</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </div>


                    <div class="form-group" style="text-align: center;">
                        <label style="visibility: hidden;">Select </label>
                        <button type="button" onclick="sendToServer()" class="btn btn-info">Submit Invoice</button>

                        <label style="visibility: hidden;">Select</label>
                        <button type="button" onclick="savedraftinvoice();" class="btn btn-info">Discard Invoice</button>

                        <label style="visibility: hidden;">Select</label>
                        <button type="button" onclick="window.close()" class="btn btn-info">Close</button>
                    </div>

                </div>
            </section>
        </div>
        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script>
        $.widget.bridge('uibutton', $.ui.button);
        $.widget.bridge('uitooltip', $.ui.tooltip);

    </script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="js/commonFunctions.js"></script>
    <script src="plugins/sparklines/sparkline.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <script src="dist/js/adminlte.js"></script>
    <script src="dist/js/demo.js"></script>
    <script src="js/moment.min.js"></script>
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
    <script src="plugins/jquery-validation/additional-methods.min.js"></script>
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
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


    <script src="js/poInvoiceGenerate.js"></script>
</body>

</html>
