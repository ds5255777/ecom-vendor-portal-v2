<!DOCTYPE html>
<%@ page import="com.main.commonclasses.GlobalConstants" %>
<%@ page import="com.main.commonclasses.GlobalUrl" %>
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
                                            <strong>Invoice Status</strong>
                                        </p>
                                        <canvas id="unresolvedsts" style="min-height: 385px; max-height: 377px; max-width: 100%; display: block; width: 401px; height: 459px;"></canvas>
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
                    <button type="button" class="btn btn-primary" onclick="changePassword(document.getElementById('passwordch').value)">Change
                        Password</button>
                </div>
            </div>
        </div>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script>
        $.widget.bridge('uibutton', $.ui.button);
        $.widget.bridge('uitooltip', $.ui.tooltip);

    </script>
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
        
        
	<script>
	
	 $(document).ready(function () {
         if (${userStatus} === 3) {
             $('#changePassword').modal('show');
         }
     });
	 
	 $('#changePassword1').validate({
         rules: {
         	password: {
                 required: true
             },
             passwordConfirm: {
                 required: true
             }
         },
          errorElement: 'span',
         errorPlacement: function(error, element) {
             error.addClass('invalid-feedback');
             element.closest('.form-group').append(error);
         },
         highlight: function(element, errorClass, validClass) {
             $(element).addClass('is-invalid');
             document.getElementById("passflag").value ="1";
             
         },
         unhighlight: function(element, errorClass, validClass) {
             $(element).removeClass('is-invalid');
             document.getElementById("passflag").value ="0";
         } 
		 });
      
     $(function() {
         $("#passwordConfirm").keyup(function() {
             var password = $("#password").val();
             var passwordConfirm = $("#passwordConfirm").val();
             var passflag = $("#passflag").val();
              if ($('#password').val() == $('#passwordConfirm').val() && passflag!="1" ) {
     		    $('#divCheckPasswordMatch').html('Passwords match.').css('color', 'green');
     		    // Enable #x	
     		    $("#changePasswordButton").prop("disabled", false)
     		    
     		  } 
              else {
     		    $('#divCheckPasswordMatch').html('Passwords do not match!').css('color', 'red');
          // Disable #x
 		    $('#changePasswordButton').attr('disabled', true);
             return;
     		  }
         });
     });
	
	var userType = '${role}';
	
            var tabledata = $('#tabledata').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": true,
                "autoWidth": false,
                "aaSorting": []
            });

            if(userType == "<%=GlobalConstants.ROLE_FINANCE%>"){            
            var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
            var unresolvedstsData = {
                labels: [
                    'All Invoices',
                    'In-Review Trip Invoices',
                    'In-Review PO Invoices',
                    'Query'
                ],
                datasets: [{
                        data: [${allInvoice}, ${inReviewInvoice}, ${countForPendingForApprovalInvoice}, ${queryCount}],
                        backgroundColor: ['#FAA654', '#1F8BFF','#28a745','#3010af'],
                    }]
            }
            var unresolvedstsOptions = {
                maintainAspectRatio: false,
                responsive: true,
            }
            var unresolvedstsOptionsChart = new Chart(unresolvedsts, {
                type: 'doughnut',
                data: unresolvedstsData,
                options: unresolvedstsOptions
            })
            }
            
            if(userType == "<%=GlobalConstants.ROLE_FINANCE_HEAD%>"){            
                var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
                var unresolvedstsData = {
                    labels: [
                        'All Invoices',
                        'Pending For Approval',
                        'Approved Invoices'
                    ],
                    datasets: [{
                            data: [${allInvoice},  ${countForPendingForApprovalInvoice}, ${countForApprovedInvoice}],
                            backgroundColor: ['#6610f2', '#28a745', '#1F8BFF'],
                        }]
                }
                var unresolvedstsOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                }
                var unresolvedstsOptionsChart = new Chart(unresolvedsts, {
                    type: 'doughnut',
                    data: unresolvedstsData,
                    options: unresolvedstsOptions
                })
                }

            function changePassword(password) {
                console.log(document.getElementById('passwordch').value);
                console.log("my password" + password);

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(password),
                    url: "<%=GlobalUrl.changePassword%>",
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        if (data.msg == 'success') {

                            $("tbody").show();
                        } else {
                            Toast.fire({
                                type: 'error',
                                title: 'Failed.. Try Again..'
                            })
                        }
                    },
                    error: function (jqXHR, textStatue, errorThrown) {
                        alert("failed, please try again letter");
                    }
                });
            }
            getData();

            function getData() {

                $.ajax({
                    type: "POST",
                    data: "",
                    url: "<%=GlobalUrl.getFinanceDashBoardDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    success: function(data) {

                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();
                            for (var i = 0; i < result.length; i++) {
                            	if (!result[i].hasOwnProperty("ecomInvoiceNumber")) {
                                    result[i].ecomInvoiceNumber = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceDate")) {
                                    result[i].invoiceDate = "";
                                }
                                if (!result[i].hasOwnProperty("vendorCode")) {
                                    result[i].vendorCode = "";
                                }
                                if (!result[i].hasOwnProperty("vendorName")) {
                                    result[i].vendorName = "";
                                }
                                if (!result[i].hasOwnProperty("taxableAmount")) {
                                    result[i].taxableAmount = "";
                                }
                                if (!result[i].hasOwnProperty("taxAmount")) {
                                    result[i].taxAmount = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceAmount")) {
                                    result[i].invoiceAmount = "";
                                }
                            	tabledata.row.add([result[i].ecomInvoiceNumber,result[i].invoiceDate,result[i].vendorCode,
                                	result[i].vendorName,result[i].taxableAmount,result[i].taxAmount,result[i].invoiceAmount]);
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
        </script>

</body>

</html>
