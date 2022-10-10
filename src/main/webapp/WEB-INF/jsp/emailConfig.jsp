<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName} | Email Configuration</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">

    <style>
        label {
            font-weight: 500;
            margin-bottom: 1px;
        }

        .form-control {
            height: 35px;
            font-size: 14px;
        }

        tbody {
            font-size: 12.9px;
        }

        .table td,
        .table th {
            padding: 5px;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }

        .select2-container--default .select2-purple .select2-selection--multiple .select2-selection__choice,
        .select2-purple .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #006fe6;
            border-color: #006fe6;
            color: #fff;
        }

        .select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected],
        .select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected]:hover,
        .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected],
        .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected]:hover {
            background-color: #006fe6;
            color: #fff;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <div class="wrapper">

        <jsp:include page="navbar.jsp?pagename=Email Configuration" />

        <jsp:include page="sidebar_Admin.jsp?pagename=emailConfig" />

        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <div class="input-group-prepend">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Add Email</h3>
                                </div>
                                <form role="form" id="addForm" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Email</label> <input type="text" name="userName" class="form-control" id="userName" maxlength="50">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Password</label> <input type="password" name="password" maxlength="50" class="form-control" id="password">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Host Name</label> <input type="text" name="serverName" maxlength="50" class="form-control" id="serverName">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Port</label> <input type="text" name="smtpPort" maxlength="5" class="form-control" id="smtpPort">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer" align="center">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Active Data</h3>
                                </div>
                                <div class="card-body">
                                    <table id="tabledata" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary">Email</th>
                                                <th class="bg-primary">SMTP Host Name</th>
                                                <th class="bg-primary">SMTP Port</th>
                                                <th class="bg-primary"> Edit</th>
                                                <th class="bg-primary">Delete</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <div class="modal fade" id="userModal" role="dialog">
        <div class="modal-dialog " style="max-width: 1300px;">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Update</h3>
                                </div>
                                <form role="form" id="updateForm" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Email</label> <input type="text" name="userName" class="form-control" id="userNameEdit">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Password</label> <input type="password" name="password" class="form-control" id="passwordEdit">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Host Name</label> <input type="text" name="serverName" class="form-control" id="serverNameEdit">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Port</label> <input type="text" name="smtpPort" class="form-control" id="smtpPortEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer" align="center">
                                        <button type="submit" class="btn btn-primary">Update</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
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

    <script src="js/emailConfig.js"></script>

</body>


</html>
