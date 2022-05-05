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

    <script>
        var statusObject = {
            "In-Transit": {
                "Yet To Be Approved": ["NA"],
                "Query": ["NA"],
            },
            "Closed": {
                "Yet To Be Approved": ["NA"],
                "Query": ["NA"],
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
        
        <%
    	String rolename = (String) request.getSession().getAttribute("role");
        %>
        <c:choose>  
			    <c:when test='<%=rolename.equalsIgnoreCase("Admin")%>'>  
			      <jsp:include page="sidebar_Admin.jsp?pagename=allTrips" />  
			    </c:when>  
			    <c:otherwise>  
			       <jsp:include page="sidebar_Vendor.jsp?pagename=allTrips" /> 
			    </c:otherwise>  
  		</c:choose>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>

            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content mt-2">
                <div class="container-fluid">

                    <div class="row">
                        <div class="col-md-12" style="font-size: 14px;">
                            <!-- general form elements -->
                            <div class="card card-primary ">
                                <!-- /.card-header -->
                                <div class="card-body ">
                                    <form role="form" id="addForm" autocomplete="off">
										<div class="row">
											<div class="col-md-1">
												<input type="text" name="fromDate"
													placeholder="Act Dept Starting Date" class="form-control"
													id="fromDate" >
											</div>
											<div class="col-md-1">
												<input type="text" name="toDate"
													placeholder="Act Dept End Date" class="form-control"
													id="toDate" >
											</div>
											<div class="col-md-1">
												
												<button type="button" onclick="getFilterData()"
													style="imargin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
													class="btn btn-primary">Search</button>
											</div>
											
											<div class="col-md-1">
												<div class="dropdown">
													<button type="button"
														class="btn btn-primary dropdown-toggle"
														style="font-size: 14px; float: right; margin-bottom: 10px; margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
														data-toggle="dropdown">Export Details</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="#" id="exportLinkPdf">Download
															PDF</a> <a class="dropdown-item" href="#" id="exportLink">Download
															Excel</a>
													</div>
												</div>
											</div>
											<div class="col-md-6"></div>
											<div class="col-md-2">
												<div class="form-group row">
													<label class="col-md-4">Search
														: </label>
													<div class="col-md-8">
														<input type="text" name="searchData" placeholder="Search"
															class="form-control" id="searchData"
															>
													</div>
												</div>
											</div>
										</div>
									</form>
                                    <table class="table table-head-fixed table-bordered table-hover" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip Id</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Invoice Number</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run Status</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor Status</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Act Dept</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Act KM</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Stnd KM</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Ori Hub</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Dest Hub</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Pay Status</th>
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
                                                <div class="col-md-12">

									<div class="table-responsive">
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
                                                    </div>
                                                    </div>
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
        
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });

		var currentDate='${currentDate}';
		var dataLimit='${dataLimit}';
		
            var tabledata = $('#tabledata').DataTable({
            	
                "paging": true,
                "lengthChange": false,
                "searching": true,
                "info": true,
                "autoWidth": false,
                "aaSorting": [],
                "scrollX": true,
                "pageLength": dataLimit,
                dom: 'Bfrtip',
                //buttons: ['excel','pdf','print'],
                buttons: [

                    {
                        extend: 'excelHtml5',

                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'A4',
                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
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
            
            $('#searchData').on( 'keyup', function () {
            	tabledata.search( this.value ).draw();
            } );
            
            $('#tabledata_filter').css("display","none");
         

            var tabledataQuery = $('#tabledataQuery').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": false,
                "aaSorting": []
            });

             $('#fromDate').datepicker({
                dateFormat: 'dd-mm-yy',
                changeMonth: true,
                changeYear: true,
                maxDate: currentDate
            });

            $('#toDate').datepicker({
                dateFormat: 'dd-mm-yy',
                changeMonth: true,
                changeYear: true,
                maxDate: currentDate
            }); 

           /*  $.validator.setDefaults({
                submitHandler: function() {
                    getFilterData();
                }
            }); */

            $("#refreshDashboardButton").click(function(e) {
                e.preventDefault();
                $('#refreshDashboardButton').attr('disabled', 'disabled');
                getData();
                $('#refreshDashboardButton').removeAttr('disabled');
                $('#selectTripStatus').val('');
                $('#selectStatus').val('');
                $('#selectPaymentStatus').val('');
                $('#fromDate').val('');
                $('#toDate').val('');
            })
            
           getData();

            function getData() {

                $('.loader').show();

                $.ajax({
                    type: "POST",
                    data: "",
                    url: "<%=GlobalUrl.getAllTripsDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {
//return;
                        $('.loader').hide();
                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();

                            for (var i = 0; i < result.length; i++) {
                            	
                            	if(!result[i].hasOwnProperty("tripID")){
     								result[i].tripID="";
     							}
                                if(!result[i].hasOwnProperty("invoiceNumber")){
          							result[i].invoiceNumber="";
          						}
								if(!result[i].hasOwnProperty("route")){
     								result[i].route="";
     							}
                                 if(!result[i].hasOwnProperty("runType")){
     								result[i].runType="";
     							}
                                 if(!result[i].hasOwnProperty("vendorTripStatus")){
     								result[i].vendorTripStatus="";
     							}
                                 if(!result[i].hasOwnProperty("actualDeparture")){
      								result[i].actualDeparture="";
      							}
                                 if(!result[i].hasOwnProperty("actualKM")){
      								result[i].actualKM="";
      							}
                                 if(!result[i].hasOwnProperty("standardKM")){
     								result[i].standardKM="";
     							}
                                  if(!result[i].hasOwnProperty("originHub")){
      								result[i].originHub="";
      							}
                                  if(!result[i].hasOwnProperty("destHub")){
      								result[i].destHub="";
      							}
                                  if(!result[i].hasOwnProperty("paymentStatus")){
        							result[i].paymentStatus="";
        						}

                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";

                                var statustemp_payment_success = '<span class=\"right badge badge-success\">Approved</span>';
                                var statustemp_payment_Pending = '<span class=\"right badge badge-warning\">Pending</span>';
                                var statustemp_payment_No = '<span class=\"right badge badge-primary\">NA</span>';

                                var statustemp_runststus_Intransit = '<span class=\"right badge badge-warning\">In-Transit</span>';
                                var statustemp_runststus_Closed = '<span class=\"right badge badge-success\">Closed</span>';

                                var statustemp_pending = '<span class=\"right badge badge-warning\">Yet To Be Approved</span>';
                                var statustemp_approved = '<span class=\"right badge badge-success\">Approved</span>';
                                var statustemp_Invoicing = '<span class=\"right badge badge-primary\">Invoicing</span>';
                                var statustemp_Draft_Invoicing = '<span class=\"right badge badge-danger\">Draft-Invoicing</span>';
                                var statustemp_query = '<span class=\"right badge badge-warning\"  style=\"background-color: #fd7e14;\">Query</span>';

                                var paymentStatus = "";
                                var runStatus = "";
                                var vendorTripStatus = "";
                                var tempString = [view, result[i].invoiceNumber, result[i].route, result[i].runType, runStatus, status, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub,  paymentStatus];

                                if (result[i].paymentStatus == "Pending") {
                                    tempString[11] = statustemp_payment_Pending;
                                } else if (result[i].paymentStatus == "Approved") {
                                    tempString[11] = statustemp_payment_success;
                                } else if (result[i].paymentStatus == "NA") {
                                    tempString[11] = statustemp_payment_No;
                                }

                                if (result[i].vendorTripStatus == "Yet To Be Approved") {
                                    tempString[5] = statustemp_pending;
                                } else if (result[i].vendorTripStatus == "Approved") {
                                    tempString[5] = statustemp_approved;
                                } else if (result[i].vendorTripStatus == "Invoicing") {
                                    tempString[5] = statustemp_Invoicing;
                                } else if (result[i].vendorTripStatus == "Query") {
                                    tempString[5] = statustemp_query;
                                } else if (result[i].vendorTripStatus == "Draft-Invoicing") {
                                    tempString[5] = statustemp_Draft_Invoicing;
                                }

                                if (result[i].runStatus == "In-Transit") {
                                    tempString[4] = statustemp_runststus_Intransit;
                                } else if (result[i].runStatus == "Closed") {
                                    tempString[4] = statustemp_runststus_Closed;
                                }

                                tabledata.row.add(tempString);
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
           
            function setTripStatus(tripId) {
                console.log("Trip ID---" + tripId);
                getQueryData(tripId)
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
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                });
            }

            function getFilterData() {

                var fromDate = $("#fromDate").val();
                var toDate = $("#toDate").val();
                var vendorCode = $("#vendorCode").val();
                
                console.log(vendorCode,"vendorCode");
                console.log(fromDate,"fromDate");
                console.log(toDate,"toDate");


                if (fromDate == "" || fromDate == null) {
                    Toast.fire({
                        type: 'error',
                        title: 'Please Select Start Date..'
                    });
                    document.getElementById("fromDate").focus();
                    return;
                }

                if (toDate == "" || toDate == null) {
                    Toast.fire({
                        type: 'error',
                        title: 'Please Select End Date..'
                    });
                    document.getElementById("toDate").focus();
                    return;
                }
                $('.loader').show();


                $.ajax({
                    type: "GET",
                    data: {
                        "actualDeparture": fromDate.concat(" ","00:00"),
                        "actualArrival": toDate.concat(" ","23:59"),
                        "vendorCode": vendorCode
                    },
                    url: "<%=GlobalUrl.filterTripDetails%>",
                    dataType: "json",
                    contentType: "application/json",

                    success: function(data) {
                    	console.log(data);
                        $('.loader').hide();
                        if (data.msg == 'success') {
                            //alert("Hiii");
                            console.log(data);

                            var result = data.data;
                            tabledata.clear();

                            for (var i = 0; i < result.length; i++) {
                            	if(!result[i].hasOwnProperty("tripID")){
     								result[i].tripID="";
     							}
                                if(!result[i].hasOwnProperty("invoiceNumber")){
          							result[i].invoiceNumber="";
          						}
								if(!result[i].hasOwnProperty("route")){
     								result[i].route="";
     							}
                                 if(!result[i].hasOwnProperty("runType")){
     								result[i].runType="";
     							}
                                 if(!result[i].hasOwnProperty("vendorTripStatus")){
     								result[i].vendorTripStatus="";
     							}
                                 if(!result[i].hasOwnProperty("actualDeparture")){
      								result[i].actualDeparture="";
      							}
                                 if(!result[i].hasOwnProperty("actualKM")){
      								result[i].actualKM="";
      							}
                                 if(!result[i].hasOwnProperty("standardKM")){
     								result[i].standardKM="";
     							}
                                  if(!result[i].hasOwnProperty("originHub")){
      								result[i].originHub="";
      							}
                                  if(!result[i].hasOwnProperty("destHub")){
      								result[i].destHub="";
      							}
                                  if(!result[i].hasOwnProperty("paymentStatus")){
        							result[i].paymentStatus="";
        						}

                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";

                                var statustemp_payment_success = '<span class=\"right badge badge-success\">Approved</span>';
                                var statustemp_payment_Pending = '<span class=\"right badge badge-warning\">Pending</span>';
                                var statustemp_payment_No = '<span class=\"right badge badge-primary\">NA</span>';

                                var statustemp_runststus_Intransit = '<span class=\"right badge badge-warning\">In-Transit</span>';
                                var statustemp_runststus_Closed = '<span class=\"right badge badge-success\">Closed</span>';

                                var statustemp_pending = '<span class=\"right badge badge-warning\">Yet To Be Approved</span>';
                                var statustemp_approved = '<span class=\"right badge badge-success\">Approved</span>';
                                var statustemp_Invoicing = '<span class=\"right badge badge-primary\">Invoicing</span>';
                                var statustemp_Draft_Invoicing = '<span class=\"right badge badge-danger\">Draft-Invoicing</span>';
                                var statustemp_query = '<span class=\"right badge badge-warning\"  style=\"background-color: #fd7e14;\">Query</span>';

                                var paymentStatus = "";
                                var runStatus = "";
                                var vendorTripStatus = "";
                                var tempString = [view, result[i].invoiceNumber, result[i].route, result[i].runType, runStatus, status, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub,  paymentStatus];

                                if (result[i].paymentStatus == "Pending") {
                                    tempString[11] = statustemp_payment_Pending;
                                } else if (result[i].paymentStatus == "Approved") {
                                    tempString[11] = statustemp_payment_success;
                                } else if (result[i].paymentStatus == "NA") {
                                    tempString[11] = statustemp_payment_No;
                                }

                                if (result[i].vendorTripStatus == "Yet To Be Approved") {
                                    tempString[5] = statustemp_pending;
                                } else if (result[i].vendorTripStatus == "Approved") {
                                    tempString[5] = statustemp_approved;
                                } else if (result[i].vendorTripStatus == "Invoicing") {
                                    tempString[5] = statustemp_Invoicing;
                                } else if (result[i].vendorTripStatus == "Query") {
                                    tempString[5] = statustemp_query;
                                } else if (result[i].vendorTripStatus == "Draft-Invoicing") {
                                    tempString[5] = statustemp_Draft_Invoicing;
                                }

                                if (result[i].runStatus == "In-Transit") {
                                    tempString[4] = statustemp_runststus_Intransit;
                                } else if (result[i].runStatus == "Closed") {
                                    tempString[4] = statustemp_runststus_Closed;
                                }

                                tabledata.row.add(tempString);
                            }
                            tabledata.draw();
                            $("tbody").show();
                        } else {
                            console.log(data);
                            Toast.fire({
                                type: 'error',
                                title: 'Failed.. Try Again..'
                            })
                        }

                    },
                    error: function(jqXHR, textStatue, errorThrown) {
                        $('.loader').hide();
                        Toast.fire({
                            type: 'error',
                            title: '.. Try Again..'
                        })
                    }

                });

            }
            //getQueryData();
   		 
   		 function getQueryData(tripId){
   			 
   			 var obj ={
   						"referenceid": tripId,
   						"type": "Trip"
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
   				                        	count++;
   				                        	tabledataQuery.row.add([count,result[i].raisedBy, result[i].raisedOn, result[i].comment]);
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
