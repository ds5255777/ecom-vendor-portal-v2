<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Dashboard</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
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

        <jsp:include page="navbar.jsp?pagename=Admin Dashboard" />

        <jsp:include page="sidebar_Admin.jsp?pagename=dashboard" />

        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <input type="hidden" id=uname value="${uname}" />
                        </div>
                        <div class="col-sm-6"></div>
                    </div>
                </div>
            </div>

            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6 col-6">
                            <div class="small-box bg-white">
                                <div class="inner" style="height: 200px;">
                                    <p id="invdue" data-toggle="tooltip" data-placement="bottom">
                                        <a style="font-size: 30px;"> Total No of Users : </a><b style="font-size: 30px;">${getAllUserCount}</b>
                                    </p>

                                    <p id="allActive" data-toggle="tooltip" data-placement="bottom" style="font-size: 20px;">
                                        Active Users : <b>${totalActiveUser}</b></p>

                                    <p id="allInactive" data-toggle="tooltip" data-placement="bottom" style="font-size: 20px;">
                                        In-Active Users : <b>${totalInActiveUser}</b></p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-user" style="color: #FAA654;font-size: 150px;"></i>
                                </div>
                                <a href="addUsers" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-6 col-6">
                            <div class="small-box bg-white">
                                <div class="inner" style="height: 200px;">
                                    <p id="vendors" data-toggle="tooltip" data-placement="bottom">
                                        <a style="font-size: 30px;">Total No of Vendors : </a><b style="font-size: 30px;">${getAllVendorCount}</b>
                                    </p>

                                    <p id="Actvendors" data-toggle="tooltip" data-placement="bottom" style="font-size: 20px;">
                                        Active Vendors : <b>${allActiveVendorCount}</b></p>

                                    <p id="inactVendor" data-toggle="tooltip" data-placement="bottom" style="font-size: 20px;">
                                        In-Active Vendors : <b>${allInActiveVendorCount}</b></p>


                                </div>
                                <div class="icon">
                                    <i class="fa fa-user-circle" aria-hidden="true" style="color: #1F8BFF;font-size: 160px; "></i>
                                </div>
                                <a href="vendorDetails" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
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
                                    <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom" title="Top 15 Users">Top 15
                                        Users</h3>
                                </div>
                                <div class="card-body table-responsive p-0" style="height: 420px;">
                                    <table class="table table-head-fixed" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary">User Name</th>
                                                <th class="bg-primary">First Name</th>
                                                <th class="bg-primary">Last Name</th>
                                                <th class="bg-primary">Role</th>
                                                <th class="bg-primary">Email</th>
                                                <th class="bg-primary">Contact No</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card card-primary  card-outline ">
                                <div class="card-body">
                                    <p><strong>User By Status</strong></p>
                                    <canvas id="unresolvedsts" style="min-height: 385px;  max-height: 377px; max-width: 100%;display: block;width: 401px;height: 459px;"></canvas>

                                    <input type="hidden" id="activeUser" value="${ totalActiveUser }">
                                    <input type="hidden" id="inactiveUser" value="${ totalInActiveUser }">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <form role="form" id="changePassword1" autocomplete="off">
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
                            <input type="hidden" id="passflag">
                            <input type="password" class="form-control p-input" id="password" name="password" placeholder="New Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Confirm Password </label>
                            <input type="password" class="form-control p-input" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm Password">
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
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <script src="dist/js/chart2.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>
    <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
    <script src="plugins/jquery-validation/additional-methods.min.js"></script>

    <script src="js/dashBoard_AdminRole.js"></script>


</body>

</html>
