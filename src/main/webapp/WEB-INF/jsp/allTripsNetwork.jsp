<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|AllTrips</title>

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

        div.dataTables_wrapper {
            width: 100%;
            margin: 0 auto;
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

        <jsp:include page="navBar_Network.jsp?pagename=All Trips (Network)" />

        <jsp:include page="slidebar.jsp?pagename=AllTripsNetwork" />

        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6"></div>
                    </div>
                </div>
            </div>
            <section class="content mt-2">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12" style="font-size: 14px;">
                            <div class="card">
                                <div class="card-body ">
                                    <form role="form" id="addForm" autocomplete="off">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <input type="text" name="fromDate" placeholder="Select Starting Date" class="form-control" id="fromDate" readonly style="height: 34px;">
                                            </div>
                                            <div class="col-md-2">
                                                <input type="text" name="toDate" placeholder="Select End Date" class="form-control" id="toDate" readonly style="height: 34px;">
                                            </div>
                                            <div class="col-md-2">
                                                <label for="exampleInputserverName1" style="visibility: hidden;">Text</label>
                                                <button type="button" id="searchByDate" class="btn btn-primary">Search</button>
                                            </div>
                                            <div class="col-md-3"></div>
                                            <div class="col-md-2">
                                                <div class="form-group row">
                                                    <label class="col-md-4" style="margin-top: 7px;">Search
                                                        : </label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="searchData" placeholder="search" class="form-control" id="searchData" style="height: 34px;">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-1">
                                                <div class="dropdown">
                                                    <button type="button" class="btn btn-primary dropdown-toggle" style="font-size: 14px; float: right; margin-bottom: 10px;" data-toggle="dropdown">Export Details</button>
                                                    <div class="dropdown-menu">
                                                        <a class="dropdown-item" href="#" id="exportLinkPdf">Download
                                                            PDF</a> <a class="dropdown-item" href="#" id="exportLink">Download
                                                            Excel</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <table class="display nowrap table table-bordered table-hover" id="tabledata" style="width:100%;">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip
                                                    Id</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run
                                                    Type</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
                                                    Name</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
                                                    Code</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run
                                                    Status</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
                                                    Status</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Actual
                                                    Departure</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Actual
                                                    KM</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Std.
                                                    KM</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Origin
                                                    Hub</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Destination
                                                    Hub</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Payment
                                                    Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </div>
        <div class="modal fade" id="tripValue" role="dialog">
            <div class="modal-dialog " style="max-width: 1400px;">
                <div class="modal-content">
                    <div class="modal-body" style="overflow-y: auto;">
                        <div class="container-fluid panel2" id="headerLineItemForm">
                            <div class="row">
                                <div class="col-md-12 propTableContainer" style="overflow-y: auto; height: 620px;">
                                    <input type="hidden" id="headerDetailsId" class="form-control">
                                    <div class="card card-primary">
                                        <div class="card-header" style="padding: 4px 0px 0px 4px;">
                                            <h3 class="card-title" style="font-size: 15px;">Trip
                                                Details</h3>
                                            <button type="button" class="btn btn-sm" id="closeModal" style="float: right; padding: 0 10px 0 0;" data-dismiss="modal">
                                                <i class="nav-icon far fa-window-close" style="font-size: 20px; color: white;"></i>
                                            </button>
                                        </div>
                                        <div class="card-body" style="padding-bottom: inherit;">
                                            <form role="form" id="tripForm">
                                                <div class="row">
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5">Trip Id</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="tripID" name="tripID" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5">Route</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="route" name="route" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5">Run Type</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="runType" name="runType" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5">Mode</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="mode" name="mode" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Vehicle Number">Vehicle
                                                                No.</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="vehicleNumber" name="vehicleNumber" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">

                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Vendor Name">Vendor
                                                                Name</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="vendorName" name="vendorName" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">

                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Vendor Code">Vendor
                                                                Code</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="vendorCode" name="vendorCode" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Standard Vehicle Type">Std.
                                                                Vehicle </label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="standardVechicleType" name="standardVechicleType" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Standard Payload Capacity">Payload
                                                                Cap.</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="standardPayloadCapacity" name="standardPayloadCapacity" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Standard Shipment Capacity">Shipment Cap.</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="standardShipmentCapacity" name="standardShipmentCapacity" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Run Status">Run
                                                                Status</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="runStatus" name="runStatus" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Origin Hub">Origin
                                                                Hub</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" autocomplete="off" id="originHub" name="originHub" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Origin Region">Origin
                                                                Region</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" autocomplete="off" id="originRegion" name="originRegion" disabled>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Destination Hub">Dest
                                                                Hub</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" autocomplete="off" id="destHub" name="destHub" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Actual Departure (ATD)">ATD</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" autocomplete="off" id="actualDeparture" name="actualDeparture" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Actual Arrival (ATA)">ATA</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" autocomplete="off" id="actualArrival" name="actualArrival" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Actual KM">Actual
                                                                KM</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" autocomplete="off" id="actualKM" name="actualKM" disabled>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Standard KM">Standard
                                                                KM</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" autocomplete="off" id="standardKM" name="standardKM" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Mileage">Mileage</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control numberWithDecimalcheck" autocomplete="off" id="mileage" name="mileage" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Rate per KM">Rate
                                                                per KM</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control numberWithDecimalcheck" autocomplete="off" id="ratePerKm" name="ratePerKm" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Billable KM">Billable
                                                                KM</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="routeKms" name="routeKms" disabled>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="FS Base Rate">FS
                                                                Base Rate</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control numberWithDecimalcheck" autocomplete="off" id="fsBaseRate" name="fsBaseRate" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Current Fuel Rate">Fuel
                                                                Rate</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="currentFuelRate" name="currentFuelRate" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="FS Difference">FS
                                                                Diff</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control numberWithDecimalcheck" autocomplete="off" id="fsDiff" name="fsDiff" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Basic Freight">Basic
                                                                Freight</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="basicFreight" name="basicFreight" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="FS">FS Amount</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control numberWithDecimalcheck" autocomplete="off" id="fs" name="fs" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Total Freight (Total Trip Cost)">Total
                                                                Freight</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="totalFreight" name="totalFreight" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5" title="Lump Sum Amount (Total Trip Cost)">Lump
                                                                Sum Amt.</label>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="lumpsomeamount" name="lumpsomeamount" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">

                                                            <input type="hidden" class="form-control" id="vendorCode" name="vendorCode" value="${userName }" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <div class=" card-primary">
                                        <div class="card card-primary ">
                                            <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                                <h3 class="card-title" style="font-size: 15px;">Trips
                                                    Query</h3>
                                            </div>

                                            <div class="card-body" style="padding: inherit;">
                                                <form role="form" id="showQueryDetails" name="showQueryDetails">
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
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="js/common.js"></script>
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
    <script src="js/allTripsNetwork.js"></script>

</body>

</html>
