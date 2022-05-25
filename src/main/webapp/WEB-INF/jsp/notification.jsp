<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|MasterCheckList</title>

<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
     href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bbootstrap 4 -->
<link rel="stylesheet"
     href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- iCheck -->
<link rel="stylesheet"
     href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- JQVMap -->
<link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet"
     href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
     href="plugins/daterangepicker/daterangepicker.css">
<!-- summernote -->
<!-- <link rel="stylesheet" href="plugins/summernote/summernote-bs4.css"> -->

<!-- <link rel="stylesheet" type="text/css" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-buttons/css/buttons.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-select/css/select.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="plugins/datatables-fixedheader/css/fixedHeader.bootstrap4.css"> -->
<link rel="stylesheet" type="text/css"
     href="plugins/jquery-ui/jquery-ui.min.css">


<!-- Google Font: Source Sans Pro -->
<link
     href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
     rel="stylesheet">

<link rel="stylesheet" href="plugins/select2/css/select2.min.css">
<link rel="stylesheet"
     href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

<link rel="stylesheet"
     href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
<link rel="stylesheet"
     href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
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

.table td, .table th {
     vertical-align: top;
     border-top: 1px solid #dee2e6;
     padding: 5px 5px 0px 1.5rem;
}
</style>

<style>
/* changing select2 color  */
.select2-container--default .select2-purple .select2-selection--multiple .select2-selection__choice,
     .select2-purple .select2-container--default .select2-selection--multiple .select2-selection__choice
     {
     background-color: #006fe6;
     border-color: #006fe6;
     color: #fff;
}

.select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected],
     .select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected]:hover,
     .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected],
     .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected]:hover
     {
     background-color: #006fe6;
     color: #fff;
}
</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
<jsp:include page="loader.jsp"/>      
     <div class="wrapper">

           <!-- Navbar -->
           <jsp:include page="navbar.jsp?pagename=Notification" />
           <!-- /.navbar -->

           <!-- Main Sidebar Container -->
           <jsp:include page="sidebar_Admin.jsp?pagename=notification" />





        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <div class="input-group-prepend">

                                <!--   <div class="btn-group">
                                    <div  style="font-size: 20px;font-weight: 500;" id="shiowStatusOfTicket">Master Bank Name</div>
                                </div> -->


                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <!-- <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Dashboard v1</li> -->
                            </ol>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- general form elements -->
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Notification</h3>
                                </div>
                                </div>
                                </div>
                                </div>
                                </div>
                                </section>
                                </div>
                                </div>

     <!-- jQuery -->
     <script src="plugins/jquery/jquery.min.js"></script>
     <!-- jQuery UI 1.11.4 -->
     <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
     <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    
     <!-- Bootstrap 4 -->
     <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
     <!-- ChartJS -->

     <!-- Sparkline -->
     <script src="plugins/sparklines/sparkline.js"></script>
     <!-- JQVMap -->

     <!-- daterangepicker -->
     <script src="plugins/moment/moment.min.js"></script>
     <script src="plugins/daterangepicker/daterangepicker.js"></script>
     <!-- Tempusdominus Bootstrap 4 -->
     <script
           src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
     <!-- Summernote -->

     <!-- overlayScrollbars -->
     <script
         src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
     <!-- AdminLTE App -->
     <script src="dist/js/adminlte.js"></script>
     <!-- AdminLTE dashboard demo (This is only for demo purposes) -->

     <!-- AdminLTE for demo purposes -->
     <script src="dist/js/demo.js"></script>
     <script src="js/moment.min.js"></script>

     <script src="plugins/select2/js/select2.full.min.js"></script>

   


     <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
     <script src="plugins/jquery-validation/additional-methods.min.js"></script>

     <script src="plugins/datatables/jquery.dataTables.js"></script>
     <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
     <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
     <script src="plugins/toastr/toastr.min.js"></script>





         


</body>
</html>
