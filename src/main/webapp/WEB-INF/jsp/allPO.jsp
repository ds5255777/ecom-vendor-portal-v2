<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|All PO</title>

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
        <jsp:include page="navbar.jsp?pagename=All PO" />
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        
        <%
    	String rolename = (String) request.getSession().getAttribute("role");
        
        %>
        <c:choose>  
			    <c:when test='<%=rolename.equalsIgnoreCase("Admin")%>'>  
			      <jsp:include page="sidebar_Admin.jsp?pagename=allTrips" />  
			    </c:when>  
			    <c:otherwise>  
			       <jsp:include page="slidebar_Po.jsp?pagename=All PO" /> 
			    </c:otherwise>  
  		</c:choose>
  
  
        

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

                                            <div class="col-md-2">
                                                <input type="text" name="fromDate" placeholder="Select Starting Date" required class="form-control" id="fromDate" style="height: 34px;">
                                            </div>
                                            <div class="col-md-2">
                                                <input type="text" name="toDate" placeholder="Select End Date" required class="form-control" id="toDate" style="height: 34px;">
                                            </div>
                                            <div class="col-md-6">
                                                <label for="exampleInputserverName1" style="visibility: hidden;">Text</label>
                                                <button type="button" onclick="getFilterData()" class="btn btn-primary">Search</button>
                                            </div>
                                            <div class="dropdown">
                                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"> Export Details </button>
                                                <div class="dropdown-menu">
                                                    <a class="dropdown-item" href="#" id="exportLinkPdf">Download PDF</a>
                                                    <a class="dropdown-item" href="#" id="exportLink">Download Excel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <table class="table table-bordered table-hover" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">null</th>
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
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Lump Sum Amount (Total Trip Cost)</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="lumpsomeamount" name="lumpsomeamount" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            
                                                            <input type="hidden" class="form-control" style="height: 30px;" placeholder="Enter" id="vendorCode" name="vendorCode" value=${userName } readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
                                    <div class="container">
                                        <div class="card card-primary ">
                                            <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                                <h3 class="card-title" style="font-size: 15px;">Trips Query</h3>
                                            </div>

                                            <div class="card-body ">
                                                <form role="form" id="showQueryDetails" name="showQueryDetails">
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
                                    </div>


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
        
        
        
        $('#poListTable')
		.jqxGrid(
				{

					width :'100%',
					autoheight :true,
					source : poListDataAdapter,
					sortable : true,
					filterable : true,
					showfilterrow : true,
					rowsheight:22,
					columnsresize : true,
					enabletooltips : true,
					altrows : true,
					theme : 'ehtheme',
					pageable : true,
					showtoolbar : true,
					virtualmode : true,
					rendergridrows : function() {
						return poListDataAdapter.records;
					},
					rendertoolbar : function(toolbar) {
						var me = this;
						var container = $("<div style='margin: 5px;' align='left'></div>");
						toolbar.append(container);
						container
								.append('<input type="button" id="viewPObutton" name="viewPObutton" value="<spring:message code="poWorkbench.viewPo" text="View PO" />">');

						$("#viewPObutton").jqxButton({
							theme : 'ehtheme'
						});

						$("#viewPObutton").on('click',function() {
							
							var selIndex = $("#poListTable").jqxGrid('selectedrowindex');
							if (selIndex == -1) {
								$("#appStatusMsg").html('<div class="heading_message heading_message_error" style="color:white;font-family:Cairo;">Please select a row and click desired action!</div>');
								$("#pagestatusWindow").jqxWindow('open');
							
							}else {

								var selDataRow = $('#poListTable').jqxGrid('getrowdata',selIndex);
								jQuery("#headerId").val(selDataRow.headerId);
								
								jQuery("#po-form").attr('action', "repmgmt/genPOReportsAPI");
								jQuery("#po-form").submit();
							}
							
						});
						
						/*container
						.append('&nbsp;|&nbsp;<input type="button" id="ackPO" name="ackPO" value="Acknowledge PO">');
						
						$("#ackPO").jqxButton({
							theme : 'ehtheme'
						});
						
						$("#ackPO").on('click',function() {
							
							var selIndex = $("#poListTable").jqxGrid('selectedrowindex');
							if (selIndex == -1) {
								$("#appStatusMsg").html('<div class="heading_message heading_message_error">Please select a row and click desired action!</div>');
								$("#pagestatusWindow").jqxWindow('open');
							
							}else {

								var selDataRow = $('#poListTable').jqxGrid('getrowdata',selIndex);
								
								jQuery("#poNumber").val(selDataRow.poNumber);
								progressTimer = setTimeout( progress, 2000 );
						        $("#progressWindow").jqxWindow('open');
								jQuery("#po-form").attr('action', "invoicemgmt/poAcknowledge");
								jQuery("#po-form").submit();
							}
							
						});*/
						
						/*container
						.append('&nbsp;|&nbsp;<input type="button" id="delNotes" name="delNotes" value="Create Delivery Note">');

						$("#delNotes").jqxButton({
							theme : 'ehtheme'
						});
						
						$("#delNotes").on('click',function() {
							
							var selIndex = $("#poListTable").jqxGrid('selectedrowindex');
							if (selIndex == -1) {
								$("#appStatusMsg").html('<div class="heading_message heading_message_error">Please select a row and click desired action!</div>');
								$("#pagestatusWindow").jqxWindow('open');
							
							}else {

								var selDataRow = $('#poListTable').jqxGrid('getrowdata',selIndex);
								
								jQuery("#headerId").val(selDataRow.headerId);
								
								jQuery("#po-form").attr('action', "invoicemgmt/createDeliveryNote");
								jQuery("#po-form").submit();
							}
							
						});
						
						container
						.append('&nbsp;|&nbsp;<input type="button" id="raiseInvoice" name="raiseInvoice" value="Raise Invoice">' );

						$("#raiseInvoice").jqxButton({
							theme : 'ehtheme'
						});
						
						$("#raiseInvoice").on('click',function() {
							
							var selIndex = $("#poListTable").jqxGrid('selectedrowindex');
							if (selIndex == -1) {
								$("#appStatusMsg").html('<div class="heading_message heading_message_error">Please select a row and click desired action!</div>');
								$("#pagestatusWindow").jqxWindow('open');
							
							}else {

								var selDataRow = $('#poListTable').jqxGrid('getrowdata',selIndex);
								
								jQuery("#headerId").val(selDataRow.headerId);
								
								jQuery("#po-form").attr('action', "invoicemgmt/poBasedInvoice");
								jQuery("#po-form").submit();
							}
							
							
						});*/
						
						if($("#country").val() =='MA'){
//                                                                || $("#country").val() =='RS' ){
                                                            container.append('&nbsp;|&nbsp;<input type="button" id="raiseInvoice" name="raiseInvoice" value="Raise Invoice">' );
                                                            $("#raiseInvoice").jqxButton({theme : 'ehtheme'});
						
                                                            $("#raiseInvoice").on('click',function() {
							
                                                                var selIndex = $("#poListTable").jqxGrid('selectedrowindex');
                                                                if (selIndex == -1) {
                                                                        $("#appStatusMsg").html('<div class="heading_message heading_message_error">Please select a row and click desired action!</div>');
                                                                        $("#pagestatusWindow").jqxWindow('open');

                                                                }else {

                                                                        var selDataRow = $('#poListTable').jqxGrid('getrowdata',selIndex);

                                                                        if(selDataRow.poStatus == 'CLOSED'){
                                                                            $("#appStatusMsg").html('<div class="heading_message heading_message_error">You cannot raise invoice against closed PO</div>');
                                                                            $("#pagestatusWindow").jqxWindow('open');
                                                                        }else{
                                                                            jQuery("#headerId").val(selDataRow.headerId);

                                                                            jQuery("#po-form").attr('action', "invoicemgmt/poBasedInvoice");
                                                                            jQuery("#po-form").submit();
                                                                        }
                                                                }
							
                                                            });
                                                    } else{
						
                                                        container.append('&nbsp;|&nbsp;<input type="button" id="raiseGenInvoice" name="raiseGenInvoice" value="<spring:message code="poWorkbench.RaiseInv" text="Raise Invoice" />">');

                                                        $("#raiseGenInvoice").jqxButton({theme : 'ehtheme'});
						
                                                        $("#raiseGenInvoice").on('click',function() {

                                                                var selIndex = $("#poListTable").jqxGrid('selectedrowindex');
                                                                if (selIndex == -1) {
                                                                        $("#appStatusMsg").html('<div class="heading_message heading_message_error" style="color:white;font-family:Cairo;">Please select a row and click desired action!</div>');
                                                                        $("#pagestatusWindow").jqxWindow('open');

                                                                }else {

                                                                        var selDataRow = $('#poListTable').jqxGrid('getrowdata',selIndex);
                                                                        if(selDataRow.poStatus == 'CLOSED'){
                                                                            $("#appStatusMsg").html('<div class="heading_message heading_message_error">You cannot raise invoice against closed PO</div>');
                                                                            $("#pagestatusWindow").jqxWindow('open');
                                                                        }else{
                                                                            jQuery("#headerId").val(selDataRow.headerId);

                                                                            jQuery("#po-form").attr('action', "invoicemgmt/poLinesBasedInvoice");
                                                                            jQuery("#po-form").submit();
                                                                        }
                                                                }

                                                        });
						
						}
						container
						.append('&nbsp;|&nbsp;<input type="button" id="raisePrepayInvoice" name="raisePrepayInvoice" value="<spring:message code="poWorkbench.RaiseAdvInv" text="Raise Advance Invoice" />">');

						$("#raisePrepayInvoice").jqxButton({
							theme : 'ehtheme'
						});
						
						$("#raisePrepayInvoice").on('click',function() {
							
							var selIndex = $("#poListTable").jqxGrid('selectedrowindex');
							if (selIndex == -1) {
								$("#appStatusMsg").html('<div class="heading_message heading_message_error" style="color:white;font-family:Cairo;">Please select a row and click desired action!</div>');
								$("#pagestatusWindow").jqxWindow('open');
							
							}else {

                                                                var selDataRow = $('#poListTable').jqxGrid('getrowdata',selIndex);
                                                                if(selDataRow.poStatus == 'CLOSED'){
                                                                    $("#appStatusMsg").html('<div class="heading_message heading_message_error">You cannot raise invoice against closed PO.</div>');
                                                                    $("#pagestatusWindow").jqxWindow('open');
                                                                 }else{
								jQuery("#headerId").val(selDataRow.headerId);
								
								jQuery("#po-form").attr('action', "invoicemgmt/poLinesBasedPrepayInvoice");
								jQuery("#po-form").submit();
                                                                }   
							}
							
						});
						
						container
						.append('&nbsp;|&nbsp;<input type="button" id="exlExport" name="exlExport" value="<spring:message code="poWorkbench.ExportExc" text="Export to Excel" />">');

						$("#exlExport").jqxButton({
							theme : 'ehtheme'
						});
						
						$("#exlExport").on('click',function() {
							pageSize = $("#poListTable").jqxGrid('pagesize');
							
							$("#poListTable").jqxGrid(({ pagesize: poList.totalrecords }));
							
							exportData=true;
							
						});
						
						
					},
				
					columns : [
							{
								text : 'PO No',
								datafield : 'poNumber',
								filtertype : 'input',
								hidden : false,
								columntype : 'textbox',
								width :'10%'
							},
							{
								text : 'Description',
								datafield : 'poDescription',
								filtertype : 'none',
								width :'15%',
								filtertype : 'input',
								columntype : 'textbox'
							},
							{
								text : '<spring:message code="poWorkbench.Status" text="Status" />',
								datafield : 'poStatus',
								filtertype : 'checkedlist',
								hidden : false,
								width :'10%'
							},
							{
								text : '<spring:message code="poWorkbench.POCost" text="PO Cost" />',
								datafield : 'poTotalCost',
								columntype : 'textbox',
								cellsformat:'f2',
								filtertype : 'input',
								width :'10%',
								filterable : false
							}
							,
							{
								text : '<spring:message code="reference.Currency" text="Currency" />',
								datafield : 'poCurrency',
								filtertype : 'checkedlist',
								width :'10%'
							},
                                                             <c:if test="${propertiesService.baseCountry =='RS'}">
                                                                {
								text : 'Secondary Currency',
								datafield : 'secondLocalCurrency',
								columntype : 'textbox',
								cellsformat:'f2',
								filtertype : 'input',
								width : 135,
								filterable : true
							},
                                                                {
								text : '<spring:message code="poWorkbench.ExchRate" text="Exchange Rate (EUR to RSD)" />',
								datafield : 'secondExchangeRate',
								columntype : 'textbox',
								cellsformat:'f2',
								filtertype : 'input',
								width : 170,
								filterable : true
							},
                                                                {
								text : '<spring:message code="poWorkbench.POTotalCost" text="PO Total Cost (EUR)" />',
								datafield : 'secondLocalCurrencyAmount',
								columntype : 'textbox',
								cellsformat:'f2',
								filtertype : 'input',
								width : 150,
								filterable : true
							},
                                                             </c:if>
							{
								text : '<spring:message code="poWorkbench.PODate" text="PO Date" />',
								datafield : 'poIssueDate',
								columntype : 'textbox',
								filtertype: 'range',
								cellsformat: 'dd-MMM-yyyy',
								filterable:true,
								width :'10%'
							},
							{
								text : '<spring:message code="poWorkbench.OrdQty" text="Ord. Qty" />',
								datafield : 'orderQty',
								columntype : 'textbox',
								filtertype : 'input',
								filterable : false,
								width : '10%'
							},

							{
								text : '<spring:message code="poWorkbench.RecQty" text="Rec. Qty" />',
								datafield : 'recievedQty',
								columntype : 'textbox',
								filtertype : 'input',
								filterable : false,
								width : '10%'
							},
							{
								text : '<spring:message code="poWorkbench.RejQty" text="Rej. Qty" />',
								datafield : 'rejectedQty',
								columntype : 'textbox',
								filtertype : 'input',
								filterable : false,
								width :'10%'
							},{
								text : '<spring:message code="poWorkbench.InvAm" text="Inv. Amount" />',
								datafield : 'invoicedAmount',
								columntype : 'textbox',
								cellsformat:'f2',
								filtertype : 'input',
								width :'10%',
								filterable : false
							}
							,
							
							{
								text : 'Department',
								datafield : 'departmentName',
								filtertype : 'checkedlist',
								width :'15%',
								hidden : false
							},
							
							{
								text : '<spring:message code="poWorkbench.ReqBy" text="Requested By" />',
								datafield : 'poOwnerName',
								filtertype : 'checkedlist',
								width :'15%',
								hidden : false
							},{
								text : '<spring:message code="poWorkbench.Org" text="Organization" />',
								datafield : 'attribute6',
								filtertype : 'checkedlist',
								width : '15%',
								hidden : false
								}
							

					]

		});


        
        
        

        </script>
</body>

</html>
