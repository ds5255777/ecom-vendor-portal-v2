<%@ page import="com.main.commonclasses.GlobalConstants" %>
<%@ page import="com.main.commonclasses.GlobalUrl" %>
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
                    <b>Invoice Number : </b> <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" readonly style="background: #007BFF; color: white; border: 0px;">
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
                                                <input class="form-control-sm" name="greenTax" id="greenTax" type="text" placeholder="Cess/Tax Not Applicable"  style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5" onblur="calculateInvoice();">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Extra KM<span class="text-danger"> </span></label>
                                            <div class="col-sm-2">
                                                <input class="form-control-sm" name="exteraKM" id="exteraKM" type="text" placeholder="Ex KM"  style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5"  onblur="calculateRateKm();calculateInvoice();">
                                            </div>
                                             <div class="col-sm-2">
                                                <input class="form-control-sm" name="ratePerKm" id="ratePerKm" type="text" placeholder="R/KM"  style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5">
                                            </div>
                                            <div class="col-sm-3">
                                                <input class="form-control-sm" name="extraKmRate" id="extraKmRate" type="text" placeholder="Rate KM" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5"  >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Other Charges<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="miscellaneous" id="miscellaneous" type="text" placeholder="Not Applicable"  style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9-.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="5"  onblur="calculateInvoice();">
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
													<button type="button"
														class="btn btn-primary dropdown-toggle"
														style="  margin-bottom: 10px; margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
														data-toggle="dropdown">Export Details</button>
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
                            <button type="button" id="raiseQuery" value="raiseQuery" onclick="raiseQueryModel()" class="btn btn-warning btn-lg">Raise
                                Query</button>
                        </div>

                        <div class="col-md-2" style="display: none;" id="viewAttachmentDiv">
                            <button type="button" id="viewAttachment" onclick="displayAttachmentForPoDetails()" value="viewAttachment" class="btn btn-primary btn-lg">View Attachment</button>
                        </div>
                        <div class="col-md-1" style="    margin-left: -102px;">
                            <button type="button" onclick="closeWin()" class="btn btn-info btn-lg">Close</button>
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

                                    <button type="button" onclick="approveInvoice()" id="updateBtnBtn" name="updateBtnBtn" class="btn btn-primary">Approve</button>
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
		

    <script>
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
    });
    
        var prTable = $("#prTable").DataTable({
        	  "paging": false,
              "lengthChange": false,
              "searching": false,
              "info": false,
              "autoWidth": false,
              "aaSorting": [],
              "scrollX": true,
              
              dom: 'Bfrtip',
              //buttons: ['excel','pdf','print'],
              buttons: [

                  {
                      extend: 'excelHtml5',

                      exportOptions: {
                          columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                      }
                  },
                  {
                      extend: 'pdfHtml5',
                      orientation: 'landscape',
                      pageSize: 'A3',
                      exportOptions: {
                          columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                      },
                      customize: function(doc) {

                          var tblBody = doc.content[1].table.body;
                          for (var i = 0; i < tblBody[0].length; i++) {
                              //	 console.log(tblBody[0]);
                              //	 console.log(tblBody[0][i]);
                              tblBody[0][i].fillColor = '#FFFFFF';
                              tblBody[0][i].color = 'black';
                          }

                          var objLayout = {};
                          objLayout['hLineWidth'] = function(i) {
                              return .5;
                          };
                          objLayout['vLineWidth'] = function(i) {
                              return .5;
                          };
                          objLayout['hLineColor'] = function(i) {
                              return '#aaa';
                          };
                          objLayout['vLineColor'] = function(i) {
                              return '#aaa';
                          };
                          objLayout['paddingLeft'] = function(i) {
                              return 4;
                          };
                          objLayout['paddingRight'] = function(i) {
                              return 4;
                          };
                          doc.content[1].layout = objLayout;
                          var obj = {};
                          obj['hLineWidth'] = function(i) {
                              return .5;
                          };
                          obj['hLineColor'] = function(i) {
                              return '#aaa';
                          };
                          //   doc.content[1].margin = [ 150, 0, 150, 0 ];

                      }
                  }
              ],
              initComplete: function() {
                  var $buttons = $('.dt-buttons').hide();
                  $('#exportLink').on('click', function() {
                      var btnClass = "excel" ?
                          '.buttons-' + "excel" :
                          null;
                      if (btnClass) $buttons.find(btnClass).click();
                  })

                  $('#exportLinkPdf').on('click', function() {
                      var btnClass = "pdf" ?
                          '.buttons-' + "pdf" :
                          null;
                      if (btnClass) $buttons.find(btnClass).click();
                  })
              }
          });
        
        
        
        
        var tabledataQuery = $('#tabledataQuery').DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": []
        });
        
        $("input[type=text]").prop('disabled', true);

        var ecomInvoiceNumber = '${ecomInvoiceNumber}';
        var type = '${type}';
        var role = '${role}';
        
        showHideButton();

        function showHideButton(){
        
        	if( type =="In-Processed Invoice" || type =="Query Invoice" ){
        		if(role=="<%=GlobalConstants.ROLE_FINANCE%>"){
        		$("#prosInvBtn").css("display","block");
        		$("#viewAttachmentDiv").css("display","block");
        		$("#raiseQueryDiv").css("display","block");
        		$("#queryWindow").css("display","block");
        		$("#remarkWindow").css("display","block");
        		}else{
        			$("#prosInvBtn").css("display","none");
            		$("#viewAttachmentDiv").css("display","block");
            		$("#raiseQueryDiv").css("display","none");
            		$("#queryWindow").css("display","none");
        		}
        	} else if(type == "Pending For Approval"){
        		if(role=="<%=GlobalConstants.ROLE_FINANCE_HEAD%>"){
        			$("#prosInvBtn").css("display","block");
            		$("#viewAttachmentDiv").css("display","block");
            		$("#raiseQueryDiv").css("display","block");
            		$("#queryWindow").css("display","block");
            		$("#remarkWindow").css("display","block");
        		}else{
            		$("#prosInvBtn").css("display","none");
            		$("#viewAttachmentDiv").css("display","block");
            		$("#raiseQueryDiv").css("display","none");
            		$("#queryWindow").css("display","none");
            		$("#remarkWindow").css("display","block");
        		}
        	} else if(type == "All Invoices" || type == "Processed Invoice"){
        		$("#prosInvBtn").css("display","none");
        		$("#viewAttachmentDiv").css("display","block");
        		$("#raiseQueryDiv").css("display","none");
        		$("#queryWindow").css("display","none");
        		$("#remarkWindow").css("display","block");
        	}
        }
        
        function closeWin() {
            window.close()
        }
        
        var tripLineArray = [];
        setInvoiceDetails();

        function setInvoiceDetails() {

            var obj = {
                "ecomInvoiceNumber": ecomInvoiceNumber,
            }
			console.log(obj);
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getSelectInvoiceDetails%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                        tripLineArray = data.data.invoiceLineItem;
                        var myForm = "";
                        var myFormTwo="";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result);
                        $('#prTable').DataTable().clear();
                        for (var i = 0; i < tripLineArray.length; i++) {
                            if (!tripLineArray[i].hasOwnProperty("runType")) {
                                tripLineArray[i].runType = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("tripID")) {
                                tripLineArray[i].tripID = "";
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
                            if (!tripLineArray[i].hasOwnProperty("standardVechicleType")) {
                                result[i].standardVechicleType = "";
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
                            if (!tripLineArray[i].hasOwnProperty("mileage")) {
                                result[i].mileage = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("actualKM")) {
                                tripLineArray[i].actualKM = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("totalFreight")) {
                                tripLineArray[i].totalFreight = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("lumpsomeamount")) {
                                tripLineArray[i].lumpsomeamount = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("lineLevelDescription")) {
                                tripLineArray[i].lineLevelDescription = "";
                            }
                            $('#prTable').DataTable().row.add([tripLineArray[i].tripID, tripLineArray[i].runType, tripLineArray[i].route, tripLineArray[i].standardKM, tripLineArray[i].ratePerKm, tripLineArray[i].currentFuelRate, tripLineArray[i].fsBaseRate, tripLineArray[i].standardVechicleType, tripLineArray[i].fsDiff, tripLineArray[i].basicFreight, tripLineArray[i].fs, tripLineArray[i].mileage,  tripLineArray[i].totalFreight,tripLineArray[i].lumpsomeamount, tripLineArray[i].lineLevelDescription]);
                        }
                        $("#invoiceNumber").val(result.invoiceNumber);
                        $("#ecomInvoiceNumber").val(result.ecomInvoiceNumber);
                        $('#prTable').DataTable().draw();
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
        
		function displayAttachment(){
			
			var invoiceNumber = $("#invoiceNumber").val();
			console.log("id >> "+id);
			
			var obj ={
					"invoiceNumber": invoiceNumber,	
			}
			
			$.ajax({
				type : "POST",
				url : "<%=GlobalUrl.getDocumentByInvoiceNumber%>",
				async : false,
				data :JSON.stringify(obj),
				dataType : "json",
				contentType : "application/json",
				success : function(response) {
					if (response.msg == "success") {
					
						
					} else {
						Toast.fire({
							type : 'error',
							title : 'Failed Added..'
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
		
		function approveInvoice(){
			
			var ecomInvoiceNumber=$("#ecomInvoiceNumber").val();
			
			if (ecomInvoiceNumber == "") {
                return;
            }
            $('.loader').show();
            var obj ={
					"ecomInvoiceNumber": ecomInvoiceNumber
			}

            $.ajax({
                type: "POST",
                url: "<%=GlobalUrl.approveInvoiceFinanceSide%>",
                data: JSON.stringify(obj),
                dataType: "json",
                contentType: "application/json",
                success: function(response) {
                    $('.loader').hide();
                    $("#myModal").modal('hide');
                    if (response.msg == "success") {
                        Swal.fire({
                            type: 'success',
                            title: 'Aproved Successfully..'
                        }).then(function() {
                        	window.opener.refereshList();
                            window.close(); 
                        });
                        
                    } else {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed Added..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    $('.loader').hide();
                    Toast.fire({
                        type: 'error',
                        title: 'Failed Added..'
                    })
                }
            });

		}
		
		function raiseQueryModel(){
			var query = document.getElementById("comment").value;
            if (query === "" || query === null || query === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Please Insert Remarks'
                });
                document.getElementById("comment").focus();
                return "";
            }
            
            var finalObj={
                    "comment": $("#comment").val(),
                    "raisedAgainQuery": $("#invoiceNumber").val(),
                    "id": $("#id").val(),
                    "type":"Invoice"
                    }
            $.ajax({
                type: "POST",
                data: JSON.stringify(finalObj),
                url: "<%=GlobalUrl.saveQuery%>",
                dataType: "json",
                contentType: "application/json",
                success: function(response) {

                    if (response.msg == 'success') {
                        swal.fire("", "Remarks Submitted Successfully ", "success", "OK").then(function() {
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
		
		/* Document Modal code */
		
		 function displayAttachmentForPoDetails(){
				
			 $('#multipleAttachment').empty();
			 
			 var obj ={
						"foreignKey": $('#ecomInvoiceNumber').val(),
						"type": "Invoice"
				}
				
				$.ajax({
					type : "POST",
					url : "<%=GlobalUrl.getDocumentByTypeAndForeignKey%>",
					data :JSON.stringify(obj),
					dataType : "json",
					contentType : "application/json",
					success : function(response) {
						if (response.msg == "success") {
						
							if("data" in response){
							
								var result = response.data;
								
								console.log(result,"------");
								
								$('#multipleAttachment').append($('<option/>').attr("value", '').text("Select"));
								
								for (var i = 0; i < result.length; i++) {																						
									$('#multipleAttachment').append($('<option/>').attr("value", result[i].docPath).text(result[i].docName));			
								}
								$("#viewAttachmentPopUp").modal('show');
								
							}else{
								Toast.fire({
									type : 'error',
									title : 'Attachment Not Available..'
								})
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
		
		 $("#multipleAttachment").change(function () {
			 
			 $("#pdfLink").contents().find("body").html(" ");
			    var fileName = $("#multipleAttachment option:selected").text();
			    
			    console.log("fileName from drop down >> " + fileName);
				var filePath = $("#multipleAttachment").val();
			    
				 fileName = encodeURIComponent(fileName);
			     filePath = encodeURIComponent(filePath);
					var urlpath = "getDoc" + "?name=" + fileName+ "&path=" + filePath;

					$('#pdfLink').attr('src', urlpath);
					$('#ifrmameHref').attr('href', urlpath);

				});
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
			
		
    </script>
</body>

</html>
