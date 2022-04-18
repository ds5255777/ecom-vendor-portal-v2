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
    <title>${titleName}|Po Process</title>
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
			<!-- Left navbar links -->
			<h5 style=" color: white;">PO-Process</h5>
            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <!-- Navbar Search -->
                <h6 class="float-sm-right" style="color: white;">
                    <b>PO Number : </b> <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" value="${poNumber}" readonly style="background: #007BFF; color: white; border: 0px;">
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
                                   
                                   
                                     				 <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">PO Number</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="poNo" name="poNo" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Supplier Site</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="supplierSite" name="supplierSite" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Ship To</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="shipTo" name="shipTo" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Bill To</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="billTo" name="billTo" autocomplete="off" disabled>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Buyer</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="buyer" name="buyer" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Currency</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="currency" name="currency" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                                                                       <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">UOM</label>
                                                            <div class="form-group">
                                                                <input type="text" class="form-control" autocomplete="off" style="height: 30px;" id="uOM" name="uOM" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Quantity</label>
                                                            <input type="text" class="form-control" autocomplete="off" style="height: 30px;" placeholder="Enter" id="quantity" name="quantity" disabled>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Price</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="price" name="price" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Need By Date</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="needByDate" name="needByDate" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Charge Account</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="chargeAccount" name="chargeAccount" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Org</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="org" name="org" disabled>
                                                        </div>
                                                    </div>

                                                </div>

                                                                                               <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Deliver To</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="deliverTo" name="deliverTo" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Description</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="description" name="description" disabled>
                                                        </div>
                                                    </div>
                                                                          

                                </div>
                            </form>
                        </div>
                    </div>
                    
                    
                    <div class="card card-primary">
                    <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Po Shipments</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        
                     <div class="card-body">
                            <form id="stepTwoForm" class="forms-sample">
                                <div class="row">
                                   
                                   
                                   
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Amount</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="amount" name="amount" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Match Approval Level</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="matchApprovalLevel" name="matchApprovalLevel" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Invoice Match option</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="invoiceMatchoption" name="invoiceMatchoption" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Accrue at Receipt flag</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="accrueatReceiptflag" name="accrueatReceiptflag" disabled>
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
                        <div class="card-body">
                        <form id="stepThreeForm" class="forms-sample">
                            <div class="card-body" style="overflow: auto;">
                                <table id="prTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <!-- <th style="padding: 5px 5px 5px 1.5rem;">Number</th> -->
                                            <th style="padding: 5px 5px 5px 1.5rem;">Line Number</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Item Type</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Item</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Category</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Description</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">UOM</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Quantity</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Price</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Need By Date</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Amount</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Charge Account</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </form>
                        <!-- /.card-body -->
                    </div></div>
                    <!-- /.card -->
                    <center>
                        <div class="form-group">
                            <label style="visibility: hidden;">Select </label> <br>
                            <button type="button" class="btn btn-primary" id="closeModal" onclick="closeWin()">Close</button>
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
        var prTable = $("#prTable").DataTable({
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
        var poNo = '${poNumber}';
        var tripLineArray = [];
        setInvoiceDetails();

        function setInvoiceDetails() {

            var obj = {
                "poNo": poNo
            }
			//alert("invoiceNumber"+invoiceNumber);
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
                       var tripLineArray=result[0].poLineDetails;
                        var myForm = "";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result[0]);
                       
                     
                        $('#lineType').val(tripLineArray[0].lineType)
                         $('#account').val(result[0].account)
                          $('#gldate').val(tripLineArray[0].gldate)
                           $('#amount').val(tripLineArray[0].amount);
                       
                        
                      
                        $('#prTable').DataTable().clear();
                         for (var i = 0; i < tripLineArray.length; i++) {
                            if (!tripLineArray[i].hasOwnProperty("lineNumber")) {
                                tripLineArray[i].lineNumber = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("itemType")) {
                                tripLineArray[i].itemType = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("item")) {
                                tripLineArray[i].item = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("category")) {
                                tripLineArray[i].category = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("description")) {
                                tripLineArray[i].description = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("uom")) {
                                tripLineArray[i].uom = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("quantity")) {
                                tripLineArray[i].quantity = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("price")) {
                                tripLineArray[i].price = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("needByDate")) {
                                tripLineArray[i].needByDate = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("amount")) {
                                tripLineArray[i].amount = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("chargeAccount")) {
                                tripLineArray[i].chargeAccount = "";
                            }
                            
                            $('#prTable').DataTable().row.add([tripLineArray[i].lineNumber, tripLineArray[i].itemType, tripLineArray[i].item, tripLineArray[i].category, tripLineArray[i].description, tripLineArray[i].uom, tripLineArray[i].quantity, tripLineArray[i].price, tripLineArray[i].needByDate, tripLineArray[i].amount, tripLineArray[i].chargeAccount]);
                        }
                       // $("#invoiceNumber").val(result.invoiceNumber);
                       // $("#ecomInvoiceNumber").val(result.ecomInvoiceNumber);
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
    </script>
</body>

</html>
