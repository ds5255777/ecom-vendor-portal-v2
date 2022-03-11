<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>${titleName}|Pending Approval Trips</title>

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
            <jsp:include page="navbar.jsp?pagename=Pending For Approvel Trips" />
            <!-- /.navbar -->

            <!-- Main Sidebar Container -->
            <jsp:include page="slidebar.jsp?pagename=pendingApproval" />

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
                            <div class="col-md-12" style="font-size: 14px;">
                                <!-- general form elements -->
                                <div class="card card-primary ">
                                    <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                        <h3 class="card-title" style="font-size: 15px;">Pending Approval Trips List</h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <div class="card-body table-responsive p-0" style="height: 420px;">
                                        <table class="table table-head-fixed" id="tabledata1">
                                            <thead>
                                                <tr>

                                                    <th class="bg-primary" >Trip ID</th>
                                                    <th class="bg-primary" >Route</th>
                                                    <th class="bg-primary" >Run Type</th>
                                                    <th class="bg-primary" >Trip Status</th>
                                                    <th class="bg-primary" >Vehicle Number</th>

                                                </tr>
                                            </thead>

                                            <tbody>
                                                <c:forEach var="yetTobeApprovedAllDetails" items="${yetTobeApprovedAllDetails}">
                                                    <tr>
                                                        <td><a href="javascript:setTripStatus(${yetTobeApprovedAllDetails.tripID})">${yetTobeApprovedAllDetails.tripID}</a></td>
                                                        <td>${yetTobeApprovedAllDetails.route}</td>
                                                        <td>${yetTobeApprovedAllDetails.runType}</td>
                                                        <td>${yetTobeApprovedAllDetails.runStatus}</td>
                                                        <td>${yetTobeApprovedAllDetails.vehicleNumber}</td>


                                                    </tr>
                                                </c:forEach>
                                            </tbody>


                                        </table>
                                    </div>
                                    <!-- /.card-body -->
                                </div>


                            </div>
                        </div>
                    </div>
                </section>



                <!-- Modal -->
                <div class="modal fade" id="tripValue" role="dialog">
                    <div class="modal-dialog " style="max-width: 1200px;">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-body" style="overflow-y: auto;">
                                <div class="container-fluid panel2" id="headerLineItemForm">
                                    <div class="row">
                                        <div class="col-md-7 propTableContainer" style="overflow-y: auto; height: 650px;">
                                            <input type="hidden" id="headerDetailsId" class="form-control">
                                            <table class="table table-striped" id="tripDetailsTable">
                                                <div class="card card-primary">
                                                    <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                                        <h3 class="card-title" style="font-size: 15px;">Trip Details</h3>
                                                    </div>


                                                    <!-- /.card-header -->
                                                    <div class="card-body">
                                                        <form role="form" id="tripForm1">

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <div class="row"> <label style="margin-top: 5px; margin-left: 10px;">Trip ID</label></div>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="tripID" name="tripID" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Route</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="route" name="route" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Run Type</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="runType" name="runType" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Mode</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="mode" name="mode" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Vehicle Number</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="vehicleNumber" name="vehicleNumber" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                                <!-- <div class="col-sm-6">
                                                                    text input
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Vendor Name</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="vendorName" name="vendorName" autocomplete="off" d>
                                                                    </div>
                                                                </div> -->
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Actual Vehicle Type</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="actualVechicleType" name="actualVechicleType" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Standard Shipment Capacity</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="standardShipmentCapacity" name="standardShipmentCapacity" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Standard Payload Capacity</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="standardPayloadCapacity" name="standardPayloadCapacity" autocomplete="off" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Run Status</label>
                                                                        <div class="form-group">
                                                                            <input type="text" class="form-control" style="height: 30px;" id="runStatus" name="runStatus" autocomplete="off" d>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Origin Hub</label>
                                                                        <div class="form-group">
                                                                            <input type="text" class="form-control" autocomplete="off" style="height: 30px;" id="originHub" name="originHub" d>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Origin Region</label>
                                                                        <input type="text" class="form-control" autocomplete="off" style="height: 30px;" placeholder="Enter" id="originRegion" name="originRegion" d>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Dest Hub</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="destHub" name="destHub" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Actual Departure (ATD)</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualDeparture" name="actualDeparture" d>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Actual Arrival (ATA)</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualArrival" name="actualArrival" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Actual KM</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualKM" name="actualKM" d>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Standard KM</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="standardKM" name="standardKM" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Mileage</label>
                                                                        <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="mileage" name="mileage" d>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Rate per KM</label>
                                                                        <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="ratePerKm" name="ratePerKm" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Billable KM</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="routeKms" name="routeKms" d>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">FS Base Rate</label>
                                                                        <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fsBaseRate" name="fsBaseRate" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Current Fuel Rate</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="currentFuelRate" name="currentFuelRate" d>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">FS Diff</label>
                                                                        <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fsDiff" name="fsDiff" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Basic Freight</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="basicFreight" name="basicFreight" d>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">FS</label>
                                                                        <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fs" name="fs" d>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Total Freight (Total Trip Cost)</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="totalFreight" name="totalFreight" d>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Opening Reading</label>
                                                                        <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="openingReading" name="openingReading" >
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <label style="margin-bottom: 1px;">Closing Reading</label>
                                                                        <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="closingReading" name="closingReading" >
                                                                    </div>
                                                                </div>

                                                                <div class="col-sm-6">
                                                                    <!-- text input -->
                                                                    <div class="form-group">
                                                                        <input type="checkbox" id="lumpsum" name="lumpsum" class="messageCheckbox" value="" onclick="lumpsomePropertyChange()">
                                                                        <label for="lumsum"> If Lump Some amount is applicable</label><br> 
                                                                        <div class="form-group">
                                                                            <label style="margin-bottom: 1px;">Amount</label>
                                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="AmountLumpSum" name="AmountLumpSum" disabled>
                                                                        </div>
                                                                    </div>
                                                                </div>



                                                            </div>
                                                        </form>
                                                    </div>
                                                    <!-- /.card-body -->
                                                </div>
                                                <!-- /.card -->
                                            </table>

                                            <form role="form" id="queryDetails" name="queryDetails">
                                                <textarea class="form-control" id="comment" name="comment" maxlength="250" placeholder="If any Query Regardin in This Trip Comment..." rows="3"></textarea>
                                                `
                                            </form>
                                            <div class="row" style="padding: 15px;">
                                                <button id="saveCoaDetails" type="button" class="btn btn-success" style="margin-right:10px;" onclick="updateTripDataByNetworkTeam()">Submit to Vendor</button>
                                                <button id="openCoaDetails" type="button" class="btn btn-success" style="margin-right:10px;" onclick="saveQuery()">Query</button>
                                                <button type="button" class="btn btn-secondary" id="closeModal" data-dismiss="modal">Close</button>
                                            </div>

                                        </div>
                                        <div class="col-md-5">
                                            <%-- <a href="${pageContext.request.contextPath}/getDoc" target="_blank">Click Here to open doc in new window</a> --%>
                                            <!-- <iframe id="pdfLink" style="height:100%; width:100%"> -->

                                            <!-- Comment History window -->
                                            <div class="card card-primary ">
                                                <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                                    <h3 class="card-title" style="font-size: 15px;">Ad-Hoc Trips Query</h3>
                                                </div>
                                                <!-- /.card-header -->
                                                <div class="card-body ">
                                                    <form role="form" id="showQueryDetails" name="showQueryDetails">
                                                        <table class="table table-bordered table-hover" id="tabledata">
                                                            <thead>
                                                                <tr>
                                                                    <th style="padding: 5px 5px 5px 1.5rem;">S.No</th>
                                                                    <th style="padding: 5px 5px 5px 1.5rem;">Date</th>
                                                                    <th style="padding: 5px 5px 5px 1.5rem;">Comment</th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>

                                                            </tbody>
                                                        </table>
                                                    </form>
                                                </div>
                                                <!-- /.card-body -->
                                            </div>

                                            <!-- Comment History window -->


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

                <script type="text/javascript">
                                                    console.log("hello");
                                                    $('#tripValue').modal("hide");
                                                    const Toast = Swal.mixin({
                                                    toast: true,
                                                            position: 'top-end',
                                                            showConfirmButton: false,
                                                            timer: 3000
                                                    });
                                                    var tabledata = $('#tabledata1').DataTable({
                                                    "paging": true,
                                                            "lengthChange": false,
                                                            "searching": true,
                                                            "info": true,
                                                            "autoWidth": true,
                                                            "aaSorting": []
                                                    });
                                                    console.log(document.getElementById("mode").value);
                                                    //alert(document.getElementById("mode").value);
                                                    if (document.getElementById("mode").value === "Line Haul") {
                                                    document.getElementById("openingReading").d = 'true';
                                                    document.getElementById("closingReading").d = 'true';
                                                    //    document.getElementById("tdsRate").val()="";
                                                    //            	    document.getElementById("tdsSection").value()="";
                                                    $("#tdsSection").val("");
                                                    $("#tdsRate").val("");
                                                    } else {
                                                    document.getElementById("openingReading").d = '';
                                                    document.getElementById("closingReading").d = '';
                                                    }


                                                    var globalTripId = "";
                                                    function setTripStatus(tripId) {

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
                                                            success: function (data) {
                                                            console.log("data.msg" + data.msg);
                                                            if (data.msg == 'success') {
                                                            var result = data.data;
                                                            var myForm = "";
                                                            myForm = document.getElementById("tripForm1");
                                                            console.log("result " + result.innerHTML);
                                                            setData(myForm, result);
                                                            $('#tripValue').modal('show');
                                                            } else {
                                                            Toast.fire({
                                                            type: 'error',
                                                                    title: 'Error in getting values. Please Try Again after sometime'
                                                            })
                                                            }
                                                            },
                                                            error: function (jqXHR, textStatue, errorThrown) {
                                                            //alert("failed, please try again");
                                                            Toast.fire({
                                                            type: 'error',
                                                                    title: 'Failed.. Try Again..'
                                                            })
                                                            }

                                                    });
                                                   
                                                    }



                                                    function lumpsomePropertyChange() {
                                                    var checkedValue = $('.messageCheckbox:checked').val();
                                                    console.log("checkedValue " + checkedValue);
                                                    $("#AmountLumpSum").prop('disabled', true);
                                                    $("#fs").prop('disabled', false);
                                                    $("#totalFreight").prop('disabled', false);
                                                    $("#basicFreight").prop('disabled', false);
                                                    if (checkedValue == '') {
                                                    $("#AmountLumpSum").prop('disabled', false);
                                                    $('#fs').val('');
                                                    $('#totalFreight').val('');
                                                    $('#basicFreight').val('');
                                                    $("#fs").prop('disabled', true);
                                                    $("#totalFreight").prop('disabled', true);
                                                    $("#basicFreight").prop('disabled', true);
                                                    }



                                                    }



                                                    function updateTripDataByNetworkTeam() {
                                                    var today = new Date();
                                                    var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
                                                    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                                                    var dateTime = date + ' ' + time;
                                                    var checkedValue = $('.messageCheckbox:checked').val();
                                                    var fs = document.getElementById("fs").value;
                                                    console.log("fs"+fs);
                                                    var totalFreight = document.getElementById("totalFreight").value;
                                                    var basicFreight = document.getElementById("basicFreight").value;
                                                    var obj = {
                                                    "tripID": document.getElementById("tripID").value,
                                                            "processedBy": "NetworkTeam",
                                                            "processedOn": dateTime,
                                                            "LumpSomeCheckBox": checkedValue,
                                                            "LumpSomeAmount": document.getElementById("AmountLumpSum"),
                                                            "AssigenedTo": "Vendor",
                                                            "fs": fs,
                                                            "totalFreight": totalFreight,
                                                            "basicFreight": basicFreight

                                                    }
                                                    
                                                    
                                                    
                                                    $.ajax({
                                                    type: "POST",
                                                            data: JSON.stringify(obj),
                                                            url: "<%=GlobalUrl.updateDetailsforNetwork%>",
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            async: false,
                                                            success: function (data) {
                                                            console.log("data.msg" + data.msg);
                                                            if (data.msg == 'success') {
                                                            var result = data.data;
                                                            
                                                            } else {
                                                            Toast.fire({
                                                            type: 'error',
                                                                    title: 'Error in getting values. Please Try Again after sometime'
                                                            })
                                                            }
                                                            },
                                                            error: function (jqXHR, textStatue, errorThrown) {
                                                            //alert("failed, please try again");
                                                            Toast.fire({
                                                            type: 'error',
                                                                    title: 'Action Performed'
                                                            })
                                                            }

                                                    });
                                                    
                                                    
                                                    $('#tripValue').modal('hide');
                                                    

                                                    }

                </script>
                </body>

                </html>
