<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Dashboard</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <style>
        tbody {
            font-size: 12.9px;
        }

        .table td,
        .table th {
            padding: 5px;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <div class="wrapper">

        <jsp:include page="navbar.jsp?pagename=Dashboard" />
        <jsp:include page="slidebar.jsp?pagename=dashboard" />
        <div class="content-wrapper">
            <section class="content" style="padding-top: 15px;">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-2 col-6">
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${totalTripCount}</h2>

                                    <p id="oveTickets" data-toggle="tooltip" data-placement="bottom">All Trips</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-truck" style="color: #FAA654; font-size: 50px;"></i>
                                </div>
                                <a href="allTrips" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${ApprovedTripscount}</h2>

                                    <p id="iamwatch" data-toggle="tooltip" data-placement="bottom">Approved Trips</p>
                                </div>
                                <div class="icon">

                                    <i class="fas fa fa-check" style="color: #28a745; font-size: 50px;"></i>
                                </div>
                                <a href="getApprovedAdhocTrips" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${yetTobeApproved}</h2>

                                    <p id="UnTickets" data-toggle="tooltip" data-placement="bottom">Pending Approval</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-tasks" style="color: #8d4f55; font-size: 50px;"></i>
                                </div>
                                <a href="pendingApprovalNetwork" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>


                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${getTripCountForQueryAdhoc}</h2>

                                    <p id="opeTickets" data-toggle="tooltip" data-placement="bottom">Query Trips</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-question" style="color: #C422F4; font-size: 50px;"></i>
                                </div>
                                <a href="QueryTripsForNetwork" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${getInClosedTripCountForAdhoc}</h2>

                                    <p id="perTicket" data-toggle="tooltip" data-placement="bottom">Closed(Adhoc) Trips</p>
                                </div>
                                <div class="icon">
                                    <i class="far fa-times-circle" style="color: #17a2b8; font-size: 50px;"></i>
                                </div>
                                <a href="ClosedAdhoc" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>


                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${getAllInvoiceCount}</h2>

                                    <p id="invdue" data-toggle="tooltip" data-placement="bottom">All Invoices</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-file-invoice-dollar" style="color: #1F8BFF; font-size: 50px;"></i>
                                </div>
                                <a href="invoicesQueue" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>


                    </div>




                </div>

            </section>


            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-8">

                            <div class="card card-primary  card-outline ">
                                <div class="card-header">
                                    <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom">Top
                                        50 Pending Approval Trips</h3>
                                </div>

                                <div class="card-body table-responsive p-0" style="height: 420px;">
                                    <table class="table table-head-fixed" id="tabledata">
                                        <thead>
                                            <tr>

                                                <th class="bg-primary">Trip ID</th>
                                                <th class="bg-primary">Route</th>
                                                <th class="bg-primary">Run Type</th>
                                                <th class="bg-primary">Trip Status</th>
                                                <th class="bg-primary">Vehicle Number</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <c:forEach var="details" items="${yetTobeApprovedAllDetails}">
                                                <tr>
                                                    <td>${details.tripID}</td>
                                                    <td>${details.route}</td>
                                                    <td>${details.runType}</td>
                                                    <td>${details.runStatus}</td>
                                                    <td>${details.vehicleNumber}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card card-primary  card-outline ">
                                <div class="card-body">
                                    <p>
                                        <strong>Trips by Status</strong>
                                    </p>
                                    <canvas id="unresolvedsts" style="min-height: 385px; max-height: 377px; max-width: 100%; display: block; width: 401px; height: 459px;"></canvas>

                                    <input type="hidden" id="TripsCount" value="${ ApprovedTripscount }">
                                    <input type="hidden" id="ToBeApproved" value="${ yetTobeApproved }">
                                    <input type="hidden" id="TripCountForQueryAdhoc" value="${ getTripCountForQueryAdhoc }">
                                    <input type="hidden" id="ClosedTripCountForAdhoc" value="${ getInClosedTripCountForAdhoc }">


                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </div>

        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>

    <div class="modal fade" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Change Password</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="exampleInputEmail1">New Password</label>
                        <input type="password" class="form-control p-input" id="passwordch" placeholder="New Password">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Confirm Password </label>
                        <input type="password" class="form-control p-input" id="conpassword" placeholder="Confirm Password">
                    </div>
                    <div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="changePassword(document.getElementById('passwordch').value)">Change Password</button>
                </div>
            </div>
        </div>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/chart.js/Chart.min.js"></script>
    <script src="plugins/sparklines/sparkline.js"></script>
    <script src="plugins/jqvmap/jquery.vmap.min.js"></script>
    <script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
    <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <script src="dist/js/adminlte.js"></script>
    <script src="dist/js/demo.js"></script>
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <script src="dist/js/chart2.js"></script>
    <script src="js/dashBoard_NetworkRole.js"></script>
</body>

</html>
