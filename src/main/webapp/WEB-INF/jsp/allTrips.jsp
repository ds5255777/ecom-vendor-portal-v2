<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|All Trips</title>

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

 <!--    <script>
        var statusObject = {
            "In-Transit": {
                "Approve": ["-"],
                "Pending For Approvel": ["-"],
            },
            "Closed": {
                "Pending For Approvel": ["-"],
                "Approve": ["-", "Pending"],
                "Invoicing": ["-", "Pending", "Approve"],
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
            }
            status.onchange = function() {
                //empty Chapters dropdown
                paymentStatus.length = 1;
                //display correct values
                var z = statusObject[tripStatus.value][this.value];
                for (var i = 0; i < z.length; i++) {
                    paymentStatus.options[paymentStatus.options.length] = new Option(z[i], z[i]);
                }
            }
        }

    </script> -->
    <style>
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
        <jsp:include page="navbar.jsp?pagename=All Trips" />
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <jsp:include page="slidebar.jsp?pagename=allTrips" />

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
                        <div class="col-md-12">
                            <div class="col-md-12" style="font-size: 14px;">
                                <!-- general form elements -->
                                <div class="card card-primary ">
                                    <div class="card-header">
                                        <!--  <h3 class="card-title" style="font-size: 15px;">Trips
                                            List</h3> -->
                                    </div>
                                    <!-- /.card-header -->
                                    <div class="card-body" style="padding-top: 4px;">
                                        <!-- <form role="form" id="addForm" autocomplete="off">
                                            <div class="row">
                                            <div class="col-md-2">
												<label>From Date</label> <input type="text" name="fromDate"
													class="form-control" id="fromDate" style="height: 34px;">
											</div>
											<div class="col-md-2">
												<label>To Date</label> <input type="text" name="toDate"
													class="form-control" id="toDate" style="height: 34px;">
											</div>
                                                <div class="col-md-6">
												<br> <label for="exampleInputserverName1"
													style="visibility: hidden;"></label>
												<button type="submit" class="btn btn-primary">Search</button>
												&nbsp;&nbsp;
												<button type="button" id="exportLink"
													 class="btn btn-primary"
													>Download Excel</button>
													<button type="button" id="exportLinkPdf"
													 class="btn btn-primary"
													>Download Pdf</button>
											</div>

                                            </div>
                                        </form> -->
                                        <div class="dropdown" align="right">
											  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" > Export Details </button>
											  <div class="dropdown-menu">
											    <a class="dropdown-item" href="#" id="exportLinkPdf">Download PDF</a>
											    <a class="dropdown-item" href="#" id="exportLink">Download Excel</a>
											  </div>
											</div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover" id="tabledata">
                                                        <thead>
                                                            <tr>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Trip Id</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Trip Status</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Status</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Actual Departure</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Actual KM</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Origin Hub</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Destination Hub</th>
                                                                <th style="padding: 5px 5px 5px 1.5rem;">Invoicing Status</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>

                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>




                                    </div>
                                    <!-- /.card-body -->
                                </div>


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
                                <div class="col-md-12 propTableContainer" style="overflow-y: auto; height: 620px;">
                                    <input type="hidden" id="headerDetailsId" class="form-control">
                                    <!-- <table class="table " id="property-desc"> -->
                                    <div class="card card-primary">
                                        <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                            <h3 class="card-title" style="font-size: 15px;">Trip Details</h3>
                                        </div>


                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <form role="form" id="tripForm">
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Trip ID</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="tripID" name="tripID" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Route</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="route" name="route" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Run Type</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="runType" name="runType" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Mode</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="mode" name="mode" autocomplete="off" disabled>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Vehicle Number</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="vehicleNumber" name="vehicleNumber" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Vendor Name</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="vendorName" name="vendorName" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual Vehicle Type</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="actualVechicleType" name="actualVechicleType" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Standard Payload Capacity</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="standardPayloadCapacity" name="standardPayloadCapacity" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Standard Shipment Capacity</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="standardShipmentCapacity" name="standardShipmentCapacity" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Run Status</label>
                                                            <div class="form-group">
                                                                <input type="text" class="form-control" style="height: 30px;" id="runStatus" name="runStatus" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Origin Hub</label>
                                                            <div class="form-group">
                                                                <input type="text" class="form-control" autocomplete="off" style="height: 30px;" id="originHub" name="originHub" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Origin Region</label>
                                                            <input type="text" class="form-control" autocomplete="off" style="height: 30px;" placeholder="Enter" id="originRegion" name="originRegion" disabled>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Dest Hub</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="destHub" name="destHub" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual Departure (ATD)</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualDeparture" name="actualDeparture" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual Arrival (ATA)</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualArrival" name="actualArrival" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual KM</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualKM" name="actualKM" disabled>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Standard KM</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="standardKM" name="standardKM" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Mileage</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="mileage" name="mileage" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Rate per KM</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="ratePerKm" name="ratePerKm" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Bilable KM</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="routeKms" name="routeKms" disabled>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">FS Base Rate</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fsBaseRate" name="fsBaseRate" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Current Fuel Rate</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="currentFuelRate" name="currentFuelRate" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">FS Diff</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fsDiff" name="fsDiff" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Basic Freight</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="basicFreight" name="basicFreight" disabled>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">FS</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fs" name="fs" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Total Freight (Total Trip Cost)</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="totalFreight" name="totalFreight" disabled>
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
        <!-- <script src="plugins/datatables/jquery.dataTables.js"></script>
		<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script> -->
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

            /* 			var tabledata = $('#tabledata').DataTable({
            				"paging" : true,
            				"lengthChange" : false,
            				"searching" : true,
            				"info" : true,
            				"autoWidth" : false,
            				"aaSorting" : []
            			}); */

            $('#fromDate').datepicker({
                dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true,

            });

            $('#toDate').datepicker({
                dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true,

            });

            var tabledata = $('#tabledata').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": false,
                "info": true,
                "autoWidth": false,
                "aaSorting": [],
                "scrollX": true,
                "pageLength": 20,
                dom: 'Bfrtip',
                //buttons: ['excel','pdf','print'],
                buttons: [

                    {
                        extend: 'excelHtml5',

                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'A4',
                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
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

            $.validator.setDefaults({
                submitHandler: function() {
                    getFilterData();

                    //alert("insode add");
                }
            });
            $('#addForm').validate({

                rules: {
                    toDate: {
                        required: true
                    },
                    fromDate: {
                        required: true

                    }
                },

                errorElement: 'span',
                errorPlacement: function(error, element) {
                    error.addClass('invalid-feedback');
                    element.closest('.form-group').append(error);
                },
                highlight: function(element, errorClass, validClass) {
                    $(element).addClass('is-invalid');
                },
                unhighlight: function(element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                }
            });

            /* function enableStatusDiv(){
            	var selectStatus = $("#selectStatus").val();
            	alert(selectStatus);
            	if(selectStatus !=""){
            		$("#paymentStatusDiv").css("visibility","visible");
            	}else{
            		$("#paymentStatusDiv").css("visibility","hidden");
            	}
            } */
            
            function calculateTotalFreight(){
    			
            	var fs = parseFloat("0");
            	var totalFreight = parseFloat("0");
            	
            	if($.isNumeric( $("#currentFuelRate").val() )){
        			totalFreight = parseFloat($("#currentFuelRate").val());
        			console.log("Hiiii"+totalFreight);
        		}
            	var engMarks = document.getElementById('currentFuelRate').value;
            	var currentFuelRate = parseFloat($("#currentFuelRate").val());
            	var fsBaseRate = parseFloat($("#fsBaseRate").val());
            	var mileage = parseFloat($("#mileage").val());
            	var routeKms = parseFloat($("#routeKms").val());
            	/* if($.isNumeric( $("#currentFuelRate").val() )){
            		totalFreight = totalFreight+parseFloat($("#currentFuelRate").val());
				} */
            	  fs= ((currentFuelRate - fsBaseRate/mileage)*routeKms);
				
				console.log(parseFloat(fs));
				
   			 
   				
   			}

            getData();

            function getData() {

                var jsArray = [];

                $('.loader').show();

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsArray),
                    url: "<%=GlobalUrl.getAllTripsDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        $('.loader').hide();
                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();
                            //console.log("result" + result);

                            for (var i = 0; i < result.length; i++) {

                                //var viewData = "<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"viewCheckList('" + result[i].tripID + "')\"><i class='fa fa-eye ' ></i></button>";
                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";

                                var statustemp_payment_success = '<span class=\"right badge badge-success\">Approved</span>';
                                var statustemp_payment_Pending = '<span class=\"right badge badge-warning\">Pending</span>';
                                var statustemp_payment_No = '<span>-</span>';

                                var statustemp_runststus_Intransit = '<span class=\"right badge badge-warning\">In-Transit</span>';
                                var statustemp_runststus_Closed = '<span class=\"right badge badge-success\">Closed</span>';

                                var statustemp_pending = '<span class=\"right badge badge-warning\">Pending for Approval</span>';
                                var statustemp_approved = '<span class=\"right badge badge-success\">Approved</span>';
                                var statustemp_Invoicing = '<span class=\"right badge badge-primary\">Invoicing</span>';

                                var paymentStatus = "";
                                var runStatus = "";
                                var status = "";
                                //var tempString = [view, result[i].route, result[i].runType, runStatus,, result[i].actualKM, result[i].standardKM,result[i].vendorTripStatus, result[i].originHub, result[i].destHub, Status,PaymnmetStatus];
                                var tempString = [view, result[i].route, result[i].runType, runStatus, status, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub, paymentStatus];


                                if (result[i].paymentStatus == "Pending") {
                                    tempString[10] = statustemp_payment_Pending;

                                } else if (result[i].paymentStatus == "Approved") {
                                    tempString[10] = statustemp_payment_success;

                                } else if (result[i].paymentStatus == "-") {
                                    tempString[10] = statustemp_payment_No;

                                }


                                if (result[i].status == "Pending for Approve") {
                                    tempString[4] = statustemp_pending;

                                } else if (result[i].status == "Approved") {
                                    tempString[4] = statustemp_approved;

                                } else if (result[i].status == "Invoicing") {
                                    tempString[4] = statustemp_Invoicing;

                                }

                                if (result[i].runStatus == "In-Transit") {
                                    tempString[3] = statustemp_runststus_Intransit;

                                } else if (result[i].runStatus == "Closed") {
                                    tempString[3] = statustemp_runststus_Closed;

                                }
                                //console.log("tempString final  **********"+tempString);
                                tabledata.row.add(tempString);

                                //tabledata.row.add([ result[i].tripID,result[i].route,result[i].runType,result[i].paymentStatus,result[i].actualKM,result[i].mode,result[i].originHub ,result[i].destHub,result[i].runStatus,result[i].status,viewData]);  				        	
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

            /* function viewCheckList(id){
				console.log("id >> "+id );
				location.href = "tripDetailsView?type="+tripID 
				var urlOftripsDetail="tripDetailsView?type="+id;
			    window.open(urlOftripsDetail, "TripsDetails", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');

		  	} */
            function setTripStatus(tripId) {
                globalTripId = "";
                globalTripId = tripId;
                console.log("tripid : " + globalTripId);
            }

            function setTripStatus(tripId) {
                console.log("Trip od" + tripId);
                //	 tripId =  $("#tripID").val();		

                var json = {
                    "tripID": tripId
                }

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.tripDetailByTripId%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        if (data.msg == 'success') {
                            var result = data.data;

                            /* jsondata=JSON.parse(result) */
                            ;
                            var myForm = "";
                            myForm = document.getElementById("tripForm");
                            setData(myForm, result);

                            $("#tripID").val(result.tripID);


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

            function searchTripData() {

                var jsArray = [];

                $('.loader').show();

                console.log("Status" + status);
                //alert("Hiiiiiiiiiiiiii");
                $.ajax({
                    type: "POST",
                    url: "<%=GlobalUrl.status%>?status=" + status,
                    dataType: "json",
                    contentType: "application/json",
                    success: function(data) {
                        //alert("Hiiiiiiiiiiiiii");

                        $('.loader').hide();
                        if (data.msg == "success") {

                            var result = data.data;
                            tabledata.clear();

                            for (var i = 0; i < result.length; i++) {
                                var viewData = "<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"viewCheckList('" + result[i].siteQualityId + "','" + result[i].checkListId + "','" + result[i].url + "')\"><i class='fa fa-eye ' ></i></button>";

                                if (result[i].paymentStatus == "Pending" || result[i].status == "Pending for Approve" || result[i].runStatus == "In-transit") {
                                    //result[i].paymentStatus= +'<td><span class="right badge badge-warning">Pending</span></td>'
                                    var statustemp = "<span class=\"right badge badge-warning\">Pending for Approval</span>";
                                    tabledata.row.add([result[i].tripID, result[i].route, result[i].runType, "<span class=\"right badge badge-warning\">Pending</span>", result[i].actualKM, result[i].mode, result[i].originHub, result[i].destHub, "<span class=\"right badge badge-warning\">In-Transit</span>", statustemp, viewData]);

                                } else if (result[i].paymentStatus == "Approved" || result[i].status == "Invoice Process" || result[i].runStatus == "Closed") {
                                    //result[i].paymentStatus= +'<span class="right badge badge-warning">Pending</span>'
                                    var statustemp = "<span class=\"right badge badge-success\">Approved</span>";
                                    tabledata.row.add([result[i].tripID, result[i].route, result[i].runType, "<span class=\"right badge badge-success\">Approve</span>", result[i].actualKM, result[i].mode, result[i].originHub, result[i].destHub, "<span class=\"right badge badge-success\">Closed</span>", statustemp, viewData]);

                                }
                                //tabledata.row.add([ result[i].tripID,result[i].route,result[i].runType,result[i].runStatus,result[i].paymentStatus,result[i].actualKM,result[i].mode,result[i].originHub,result[i].destHub,viewData]);  				        	
                            }
                            tabledata.draw();
                            $("tbody").show();

                        } else {
                            alert("failed");
                        }
                    },
                    error: function(jqXHR, textStatue, errorThrown) {
                        alert("failed, please try again");
                    }
                });

            }

        </script>
</body>

</html>
