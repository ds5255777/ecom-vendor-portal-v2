<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Process PO</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
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

    <!-- <script>
        var statusObject = {
            "In-Transit": {
                "Yet To Be Approved": ["NA"],
                "Query": ["NA"],
            },
            "Closed": {
                "Yet To Be Approved": ["NA"],
                "Approved": ["Pending"],
                "Draft-Invoicing": ["Pending"],
                "Invoicing": ["Pending", "Approved"],
            }
        }
        window.onload = function() {
            var tripStatus = document.getElementById("selectTripStatus");
            var status = document.getElementById("selectStatus");
            var paymentStatus = document.getElementById("selectPaymentStatus");
            for (var x in statusObject) {
                tripStatus.options[tripStatus.options.length] = new Option(x, x);
            }
            tripStatus.onchange = function() {
                //empty Chapters- and Topics- dropdowns
                paymentStatus.length = 1;
                status.length = 1;
                //display correct values
                for (var y in statusObject[this.value]) {
                    status.options[status.options.length] = new Option(y, y);
                }
                GetSelectedTextValue();
            }
            status.onchange = function() {
                //empty Chapters dropdown
                paymentStatus.length = 1;
                //display correct values
                var z = statusObject[tripStatus.value][this.value];
                for (var i = 0; i < z.length; i++) {
                    paymentStatus.options[paymentStatus.options.length] = new Option(z[i], z[i]);
                }
                GetSelectedTextValue();
            }
        }

    </script>
 -->    <style>
        custom-file-input {
            height: 25px;
            font-size: 14px;
        }

        .custom-file {
            height: 25px;
            font-size: 14px;
            padding-bottom: 35px;
            font-size: 14px;
        }

        .custom-file-label::after {
            height: auto !important;
        }

        .custom-file-label {
            padding-bottom: 23px;
            height: 25px;
            font-size: 14px;
        }

        .tableheading {
            font-size: 15px;
            font-weight: bold;
        }

        label {
            font-weight: 500;
            margin-bottom: 1px;
        }

        .form-control {
            height: 25px;
            font-size: 14px;
        }

        tbody {
            font-size: 12.9px;
        }

        .table td,
        .table th {
            vertical-align: top;
            border-top: 1px solid #dee2e6;
            padding: 5px 5px 0px 1.5rem;
        }

        .observedScoreheading {
            width: 60px !important;
        }

        .serialNoheading {
            width: 60px !important;
        }

        .documentheading {
            width: 500px;
        }

        .attachmentheading {
            width: 500px;
        }

        .helpheading {
            width: 60px !important;
        }

        .tooltip.show p {
            text-align: left;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <jsp:include page="loader.jsp" />
    <div class="wrapper">

        <!-- Navbar -->
        <jsp:include page="navbar.jsp?pagename=Process PO" />
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        
       <jsp:include page="slidebar_Po.jsp?pagename=Unprocess PO" /> 
  
  
        

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6">
                            <!-- <ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Dashboard v1</li>
						</ol> -->
                        </div>

                    </div>
                </div>
            </div>

            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content mt-2">
                <div class="container-fluid">

                    <div class="row">
                        <!-- <div class="col-md-12"> -->
                        <div class="col-md-12" style="font-size: 14px;">
                            <!-- general form elements -->
                            <div class="card card-primary ">
                                <div class="card-header">
                                     <h3 class="card-title" style="font-size: 15px;">PO
                                            Details</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body ">
                                    <form role="form" id="addForm" autocomplete="off">
                                        <div class="row">

                                           
                                           
                                        </div>
                                    </form>
                                    <table class="table table-bordered table-hover" id="tabledata">
                                        <thead>
                                            <tr>
												 <th style="padding: 5px 5px 5px 1.5rem;">PO Number</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Type</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">UOM</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Quantity</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Need By Date</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Amount</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Status</th>
                                               
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Control Sidebar -->
            <!-- <aside class="control-sidebar control-sidebar-dark">
			Control sidebar content goes here
		</aside>
		/.control-sidebar -->
        </div>
        <!-- ./wrapper -->








        <!-- Model Start -->
        <div class="modal fade" id="tripValue" role="dialog">
            <div class="modal-dialog " style="max-width: 1200px;">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-body" style="overflow-y: auto;">
                        <div class="container-fluid panel2" id="headerLineItemForm">
                            <div class="row">
                                <div class="col-md-12 propTableContainer" style="overflow-y: auto; height: 574px;">
                                    <input type="hidden" id="headerDetailsId" class="form-control">
                                    <!-- <table class="table " id="property-desc"> -->
                                    <div class="card card-primary">
                                        <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                            <h3 class="card-title" style="font-size: 15px;">PO Details</h3>
                                        </div>


                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <form role="form" id="tripForm">
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
                                                            <label style="margin-bottom: 1px;">Line Number</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="lineNumber" name="lineNumber" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Item Type</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="itemType" name="itemType" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Item</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="item" name="item" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Category</label>
                                                            <div class="form-group">
                                                                <input type="text" class="form-control" style="height: 30px;" id="category" name="category" autocomplete="off" disabled>
                                                            </div>
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
                                        <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
                                    

                                    <div class="container">
                                        <div class="col-md-12 text-center" style="padding-top: 0px;">
                                            <button type="button" class="btn btn-primary" id="closeModal" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <!-- model Start -->

        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
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

        <script type="text/javascript">
        
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });
        
        
        var tabledata = $('#tabledata').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": true,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });
        
        getData();

        function getData() {

            var jsArray = [];
            $('.loader').show();

            $.ajax({
                type: "POST",
                data: JSON.stringify(jsArray),
                url: "<%=GlobalUrl.getAllProcessPo%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    $('.loader').hide();
                    if (data.msg == 'success') {

                        var result = data.data;
                        tabledata.clear();
                        console.log("result" + result);

                        for (var i = 0; i < result.length; i++) {
                        	
                        	if(!result[i].hasOwnProperty("id")){
 								result[i].id="";
 							}
                        	if(!result[i].hasOwnProperty("poNo")){
 								result[i].poNo="";
 							}
                             if(!result[i].hasOwnProperty("type")){
 								result[i].type="";
 							}
                             if(!result[i].hasOwnProperty("uom")){
 								result[i].uom="";
 							}
                             if(!result[i].hasOwnProperty("quantity")){
 								result[i].quantity="";
 							}
                             if(!result[i].hasOwnProperty("needByDate")){
  								result[i].needByDate="";
  							}
                             if(!result[i].hasOwnProperty("ammount")){
  								result[i].ammount="";
  							}
                             if(!result[i].hasOwnProperty("status")){
 								result[i].status="";
 							}
                             
							// tabledata.row.add([view ,result[i].type,result[i].uom,result[i].quantity,result[i].needByDate,result[i].ammount,result[i].status ]);  
                             //var viewData = "<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"viewCheckList('" + result[i].tripID + "')\"><i class='fa fa-eye ' ></i></button>";
                            var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" +  result[i].poNo + "')\" >" + result[i].poNo + "</button>";
                            var status = '<span class=\"right badge badge-warning\">Pending</span>';
                            /* var statustemp_payment_success = '<span class=\"right badge badge-success\">Approved</span>';
                            var statustemp_payment_Pending = '<span class=\"right badge badge-warning\">Pending</span>';
                            var statustemp_payment_No = '<span class=\"right badge badge-primary\">NA</span>';

                            var statustemp_runststus_Intransit = '<span class=\"right badge badge-warning\">In-Transit</span>';
                            var statustemp_runststus_Closed = '<span class=\"right badge badge-success\">Closed</span>';

                           
                            var paymentStatus = "";
                            var runStatus = "";
                            var vendorTripStatus = "";
                            //var tempString = [view, result[i].route, result[i].runType, runStatus,, result[i].actualKM, result[i].standardKM,result[i].vendorTripStatus, result[i].originHub, result[i].destHub, Status,PaymnmetStatus];
                            var tempString = [view, result[i].route, result[i].runType, runStatus, status, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub, paymentStatus];

                                                       tabledata.row.add(tempString); */
                           var postatus="";                       
                         if (result[i].status == "Pending") {
                        	 postatus = status;

                              }  
                            tabledata.row.add([view ,result[i].type,result[i].uom,result[i].quantity,result[i].needByDate,result[i].amount,postatus ]);  				        	
                        }
                        tabledata.draw();
                        $("tbody").show();
                    } else {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    alert("failed, please try again");
                }
            });
        }

        function setTripStatus(poNo) {
            console.log("poNo" + poNo);
            //	 tripId =  $("#tripID").val();		

            var json = {
                "poNo": poNo
            }

            

            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.poDetailsByPoNo%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                        
                       
                        var myForm = "";
                        myForm = document.getElementById("tripForm");
                        setData(myForm, result);
                       
                        

                        
					
                       
                        $("tbody").show();
                    } else {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    //alert("failed, please try again");
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
