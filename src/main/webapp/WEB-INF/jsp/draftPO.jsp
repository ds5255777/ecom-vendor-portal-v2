<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName} | Draft Invoice</title>

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
        <jsp:include page="navbar.jsp?pagename=Draft Invoice" />
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <jsp:include page="slidebar_Po.jsp?pagename=draftInvoice" />

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
                                <div class="card-header">
                                    <h3 class="card-title" style="font-size: 15px;">Draft Invoice List</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body ">
                                    <table class="table table-bordered table-hover" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Invoice Number</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Supplier Name</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Supplier Number</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Action</th>
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
        </div>
        <!-- ./wrapper -->
        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
            $.widget.bridge('uibutton', $.ui.button);
            $.widget.bridge('uitooltip', $.ui.tooltip);
        </script>
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

        <script type="text/javascript">
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });

            var tabledata = $('#tabledata').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": true,
                "info": true,
                "autoWidth": false,
                "aaSorting": [],
                "pageLength": 25
            });

            getData();

            function getData() {
                var jsArray = [];
                $('.loader').show();
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsArray),
                    url: "<%=GlobalUrl.getAllDraftInvoicePO%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        $('.loader').hide();
                        if (data.msg == 'success') {
                            var result = data.data;
                            tabledata.clear();
                            for (var i = 0; i < result.length; i++) {
                                if (!result[i].hasOwnProperty("invoiceNumber")) {
                                    result[i].invoiceNumber = "";
                                }
                                if (!result[i].hasOwnProperty("vendorName")) {
                                    result[i].vendorName = "";
                                }
                                if (!result[i].hasOwnProperty("vendorCode")) {
                                    result[i].vendorCode = "";
                                }
                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getInvoiceDataFormDataByInvoiceNumber('" + result[i].invoiceNumber + "')\" >" + result[i].invoiceNumber + "</button>";
                                var action = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"deleteInvoice('" + result[i].id + "','" + result[i].invoiceNumber + "')\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                                tabledata.row.add([view, result[i].vendorName, result[i].vendorCode, action]);
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
                        alert("failed, please try again leter");
                    }
                });
            }

             function getInvoiceDataFormDataByInvoiceNumber(invoiceNumber) {
                $('.loader').show();
                var urlOftripsDetail = "draftPoInvoiceGenerate?id=" + invoiceNumber;
                window.open(urlOftripsDetail, "draftPoInvoiceGenerate", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
               // $('.loader').hide()
               window.location.reload()
            } 

            function deleteInvoice(invoiceID, ecomInvoiceNumber) {

            	var invoiceNumber =ecomInvoiceNumber;
                var json = {
                  //  "id": invoiceID,
                    "invoiceNumber": invoiceNumber,
                }
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.deleteDraftPoInvoice%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        if (data.msg == 'success') {
                            Toast.fire({
                                type: 'success',
                                title: 'Deleted Successfully..'
                            })
                            getData();
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

            function refereshList() {
                getData();
                $('.loader').hide();
            }
        </script>
</body>

</html>
