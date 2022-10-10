<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.Arrays,java.util.List"%>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Dashboard</title>
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
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

        <%
		String vendorType = (String) request.getAttribute("vendorType");
		String[] strArray = null;
		strArray = vendorType.split(",");
		for (int i = 0; i < strArray.length; i++) {
		}
		if (Arrays.asList(strArray).contains("Network") && Arrays.asList(strArray).contains("FIXED ASSETS")) {
			System.out.println("vendor type1 : " + strArray);
		%>
        <jsp:include page="navbar_po.jsp?pagename= Dashboard" />
        <%
		} else if (Arrays.asList(strArray).contains("Network")) {
		System.out.println("vendor type 2: " + strArray);
		%>
        <jsp:include page="navbar.jsp?pagename=Dashboard" />
        <%
		}
		%>

        <jsp:include page="sidebar_Vendor.jsp?pagename=dashboard" />

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
                                    <h2>${TotalInTransitTripCount}</h2>

                                    <p id="opeTickets" data-toggle="tooltip" data-placement="bottom">In-Transit Trips</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-map-marked-alt" style="color: #ffc107; font-size: 50px;"></i>
                                </div>
                                <a href="inTransitTrips" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${pendingInvoice}</h2>

                                    <p id="invdue" data-toggle="tooltip" data-placement="bottom">
                                        Process Invoices</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-file-contract" style="color: #1F8BFF; font-size: 50px;"></i>
                                </div>
                                <a href="pendingInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${approveInvoice}</h2>
                                    <p id="iamwatch" data-toggle="tooltip" data-placement="bottom">Approved
                                        Invoices</p>
                                </div>
                                <div class="icon">

                                    <i class="fas fa fa-check" style="color: #28a745; font-size: 50px;"></i>
                                </div>
                                <a href="approvedInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${draftInvoice}</h2>
                                    <p id="UnTickets" data-toggle="tooltip" data-placement="bottom">Draft
                                        Invoices</p>
                                </div>
                                <div class="icon">
                                    <i class="fab fa-firstdraft" style="color: #1F8BFF; font-size: 50px;"></i>
                                </div>
                                <a href="draftInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${TotalCloseTripCount}</h2>

                                    <p id="perTicket" data-toggle="tooltip" data-placement="bottom">Query
                                        Invoices</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-question" style="color: #3010af; font-size: 50px;"></i>
                                </div>
                                <a href="queryInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
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
                                    <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom">Top 50 Invoice</h3>
                                </div>
                                <div class="card-body table-responsive p-0" style="height: 420px;">
                                    <table class="table table-head-fixed" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary">ECOM Inv-Num</th>
                                                <th class="bg-primary">Inv-Rec Date</th>
                                                <th class="bg-primary">Ven Inv-Num</th>
                                                <th class="bg-primary">Invoice Amount</th>
                                                <th class="bg-primary">Invoice Status</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card card-primary  card-outline ">
                                <div class="card-body">
                                    <p>Trips by Status</p>
                                    <canvas id="unresolvedsts" style="min-height: 385px; max-height: 377px; max-width: 100%; display: block; width: 401px; height: 459px;"></canvas>

                                    <input type="hidden" id="inTransitCount" value="${ TotalInTransitTripCount }">
                                    <input type="hidden" id="closedCount" value="${ closedTripCount }">
                                    <input type="hidden" id="queryCount" value="${ queryTripCount }">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </div>

        <aside class="control-sidebar control-sidebar-dark"></aside>
    </div>



    <form role="form" id="changePassword1" autocomplete="off">
        <div class="modal fade" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Change
                            Password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="exampleInputEmail1">New Password</label> <input type="hidden" id="passflag"> <input type="password" class="form-control p-input" id="password" name="password" placeholder="New Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Confirm Password </label> <input type="password" class="form-control p-input" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm Password">
                        </div>
                        <div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="changePasswordButton" class="btn btn-primary" onclick="changePassword(document.getElementById('passwordConfirm').value)" disabled>Change Password</button>
                    </div>
                </div>
            </div>
        </div>
    </form>


    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
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
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>
    <script src="js/dashboard.js"></script>
</body>

</html>
