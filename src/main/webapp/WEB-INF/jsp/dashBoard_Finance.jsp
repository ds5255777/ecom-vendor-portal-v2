<!DOCTYPE html>
<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.Arrays,java.util.List" %>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Dashboard</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="dist/css/ionicons.min.css">
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
    <%
String financeRole = GlobalConstants.ROLE_FINANCE;
String financeHeadRole = GlobalConstants.ROLE_FINANCE_HEAD;

request.setAttribute("financeRole", financeRole);
request.setAttribute("financeHeadRole", financeHeadRole);


%>
    <div class="wrapper">

        <jsp:include page="navbar.jsp?pagename=Finance Dashboard" />

        <jsp:include page="slidebar_Finance.jsp?pagename=dashboard" />

        <div class="content-wrapper">

            <section class="content" style="padding-top: 15px;">
                <div class="container-fluid">

                    <c:if test="${role.equalsIgnoreCase(financeRole) }">
                        <div class="row">
                            <div class="col-lg-2 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${allInvoice}</h2>

                                        <p id="iamwatch" data-toggle="tooltip" data-placement="bottom">All
                                            Invoices</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-file-invoice" style="color: #FAA654; font-size: 50px;"></i>

                                    </div>
                                    <a href="allInvoices_Finance" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${inReviewInvoice}</h2>

                                        <p id="UnTickets" data-toggle="tooltip" data-placement="bottom">In-Review Trip Invoices</p>
                                    </div>
                                    <div class="icon">

                                        <i class="fas fa-file-contract" style="color: #1F8BFF; font-size: 50px;"></i>
                                    </div>
                                    <a href="InProcessInvoiceFinance" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${countForPaymentrelaseInvoice}</h2>

                                        <p id="UnTickets" data-toggle="tooltip" data-placement="bottom">In-Review PO Invoices</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-rupee-sign" style="color: #1F8BFF; font-size: 50px;"></i>
                                    </div>
                                    <a href="paymentRelaseInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>

                            <div class="col-lg-2 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${countForPendingForApprovalInvoice}</h2>

                                        <p id="UnTickets" data-toggle="tooltip" data-placement="bottom">Pending For Approval</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-receipt" style="color: #1F8BFF; font-size: 50px;"></i>
                                    </div>
                                    <a href="pendingForApprovalInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${countForApprovedInvoice }</h2>

                                        <p id="opeTickets" data-toggle="tooltip" data-placement="bottom">Approved Invoices</p>
                                    </div>
                                    <div class="icon">

                                        <i class="fa fas fa fa-check" style="color: #28a745; font-size: 50px;"></i>
                                    </div>
                                    <a href="processInvoiceFinance" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${queryCount }</h2>

                                        <p id="perTicket" data-toggle="tooltip" data-placement="bottom">Query</p>
                                    </div>
                                    <div class="icon">

                                        <i class="fas fa-question" style="color: #3010af; font-size: 50px;"></i>
                                    </div>
                                    <a href="queryInvoiceFinance" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${role.equalsIgnoreCase(financeHeadRole) }">

                        <div class="row">
                            <div class="col-lg-4 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${allInvoice}</h2>

                                        <p id="iamwatch" data-toggle="tooltip" data-placement="bottom">All
                                            Invoices</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-file-invoice" style="color: #FAA654; font-size: 75px;"></i>
                                    </div>
                                    <a href="allInvoices_Finance" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>

                            <div class="col-lg-4 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${countForPendingForApprovalInvoice}</h2>

                                        <p id="UnTickets" data-toggle="tooltip" data-placement="bottom">Pending For Approval</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-receipt" style="color: #1F8BFF; font-size: 75px;"></i>
                                    </div>
                                    <a href="pendingForApprovalInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>

                            <div class="col-lg-4 col-6">
                                <div class="small-box bg-white">
                                    <div class="inner">
                                        <h2>${countForApprovedInvoice }</h2>

                                        <p id="opeTickets" data-toggle="tooltip" data-placement="bottom">Approved Invoices</p>
                                    </div>
                                    <div class="icon">

                                        <i class="fa fas fa fa-check" style="color: #28a745; font-size: 75px;"></i>
                                    </div>
                                    <a href="processInvoiceFinance" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                        info <i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>


                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                    <c:if test="${role.equalsIgnoreCase(financeRole) }">
                        <div class="row">
                            <div class="col-md-8">

                                <div class="card card-primary  card-outline ">
                                    <div class="card-header">
                                        <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom">Top
                                            50 In-Review Invoices</h3>
                                    </div>
                                    <div class="card-body table-responsive p-0" style="height: 420px;">
                                        <table class="table table-head-fixed" id="tabledata">
                                            <thead>
                                                <tr>
                                                    <th class="bg-primary">Invoice Number</th>
                                                    <th class="bg-primary">Invoice Date</th>
                                                    <th class="bg-primary">Vendor Code</th>
                                                    <th class="bg-primary">Vendor name</th>
                                                    <th class="bg-primary">Amount</th>
                                                    <th class="bg-primary">Tax</th>
                                                    <th class="bg-primary">Total Amount</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card card-primary  card-outline ">
                                    <div class="card-body">
                                        <p>
                                            <strong>Finance Side Invoice Status</strong>
                                        </p>
                                        <canvas id="unresolvedsts" style="min-height: 385px; max-height: 377px; max-width: 100%; display: block; width: 401px; height: 459px;"></canvas>
                                        <input type="hidden" id="vendorRole" value="${role}">
                                        <input type="hidden" id="allInvoice" value="${ allInvoice }">
                                        <input type="hidden" id="inReviewInvoice" value="${ inReviewInvoice }">
                                        <input type="hidden" id="countForPendingForApprovalInvoice" value="${ countForPendingForApprovalInvoice }">
                                        <input type="hidden" id="queryCount" value="${ queryCount }">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${role.equalsIgnoreCase(financeHeadRole) }">
                        <div class="row">
                            <div class="col-md-8">

                                <div class="card card-primary  card-outline ">
                                    <div class="card-header">
                                        <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom">Top
                                            50 Pending For Approval Invoices</h3>
                                    </div>
                                    <div class="card-body table-responsive p-0" style="height: 420px;">
                                        <table class="table table-head-fixed" id="tabledata">
                                            <thead>
                                                <tr>
                                                    <th class="bg-primary">Invoice Number</th>
                                                    <th class="bg-primary">Invoice Date</th>
                                                    <th class="bg-primary">Vendor Code</th>
                                                    <th class="bg-primary">Vendor name</th>
                                                    <th class="bg-primary">Amount</th>
                                                    <th class="bg-primary">Tax</th>
                                                    <th class="bg-primary">Total Amount</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card card-primary  card-outline ">
                                    <div class="card-body">
                                        <p>
                                            <strong>Invoice Status</strong>
                                        </p>
                                        <canvas id="unresolvedsts" style="min-height: 385px; max-height: 377px; max-width: 100%; display: block; width: 401px; height: 459px;"></canvas>
                                        <input type="hidden" id="allInvoice" value="${ allInvoice }">
                                        <input type="hidden" id="inReviewInvoice" value="${ inReviewInvoice }">
                                        <input type="hidden" id="countForPendingForApprovalInvoice" value="${ countForPendingForApprovalInvoice }">
                                        <input type="hidden" id="queryCount" value="${ queryCount }">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </section>
        </div>

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
                        <label for="exampleInputEmail1">New Password</label> <input type="password" class="form-control p-input" id="passwordch" placeholder="New Password">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Confirm Password </label> <input type="password" class="form-control p-input" id="conpassword" placeholder="Confirm Password">
                    </div>
                    <div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="chngpass" class="btn btn-primary">Change
                        Password</button>
                </div>
            </div>
        </div>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
    <script src="plugins/chart.js/Chart.min.js"></script>
    <script src="plugins/sparklines/sparkline.js"></script>
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


    <script src="js/dashBoard_Finance.js"></script>

</body>

</html>
