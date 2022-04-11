<!DOCTYPE html>
<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|Dashboard</title>

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
<link rel="stylesheet" href="plugins/summernote/summernote-bs4.css">
<!-- Google Font: Source Sans Pro -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
	rel="stylesheet">
<style>
tbody {
	font-size: 12.9px;
}

.table td, .table th {
	padding: 5px;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}
</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
	<div class="wrapper">

		<!-- Navbar -->
		<jsp:include page="navbar.jsp?pagename=Finance Dashboard " />

		<!-- Right navbar links -->
		<jsp:include page="slidebar_Finance.jsp?pagename=dashboard" />

		<!-- /.navbar -->

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6"></div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
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
					<!-- Small boxes (Stat box) -->
					<div class="row">
						<!-- ./col -->
						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${count}</h2>

									<p id="iamwatch" data-toggle="tooltip" data-placement="bottom"
										title="All Processed and Unprocessed Invoice">All Invoice</p>
								</div>
								<div class="icon">

									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 50px;"></i>
								</div>
								<a href="allInvoices_Finance" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<!-- ./col -->
						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>10</h2>

									<p id="opeTickets" data-toggle="tooltip"
										data-placement="bottom" title="Processed Invoice Only">Processed
										Invoice</p>
								</div>
								<div class="icon">

									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 50px;"></i>
								</div>
								<a href="#" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>12</h2>

									<p id="UnTickets" data-toggle="tooltip" data-placement="bottom"
										title="Unprocessed Invoice">In-Processed Invoice</p>
								</div>
								<div class="icon">

									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 50px;"></i>
								</div>
								<a href="#" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>3</h2>

									<p id="perTicket" data-toggle="tooltip" data-placement="bottom"
										title="Invoice Regarding Query For Vendor or Finance Team">Query</p>
								</div>
								<div class="icon">

									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 50px;"></i>
								</div>
								<a href="#" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>
						<!-- ./col -->
					</div>
					<!-- /.row -->
					<!-- Main row -->

					<!-- /.row (main row) -->
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-8">

							<div class="card card-primary  card-outline ">
								<div class="card-header">
									<h3 class="card-title" id="lastInvoice" data-toggle="tooltip"
										data-placement="bottom" title="Top 50 Pending Trips">Top
										50 In-Processed Invoice</h3>
								</div>
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0"
									style="height: 420px;">
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
											<!-- body -->
										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
							</div>
						</div>
						<div class="col-md-4">
							<!-- DONUT CHART -->
							<div class="card card-primary  card-outline ">
								<div class="card-body">
									<p>
										<strong>Invoice Status</strong>
									</p>
									<canvas id="unresolvedsts"
										style="min-height: 385px; max-height: 377px; max-width: 100%; display: block; width: 401px; height: 459px;"></canvas>
								</div>
								<!-- /.card-body -->
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- /.content -->
		</div>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- Modal -->
	<div class="modal fade" id="changePassword" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Change Password</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="exampleInputEmail1">New Password</label> <input
							type="password" class="form-control p-input" id="passwordch"
							placeholder="New Password">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Confirm Password </label> <input
							type="password" class="form-control p-input" id="conpassword"
							placeholder="Confirm Password">
					</div>
					<div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="changePassword(document.getElementById('passwordch').value)">Change
						Password</button>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery -->
	<script src="plugins/jquery/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
                            $.widget.bridge('uibutton', $.ui.button);
                            $.widget.bridge('uitooltip', $.ui.tooltip);

        </script>
	<!-- Bootstrap 4 -->
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- ChartJS -->
	<script src="plugins/chart.js/Chart.min.js"></script>
	<!-- Sparkline -->
	<script src="plugins/sparklines/sparkline.js"></script>
	<!-- JQVMap -->
	<script src="plugins/jqvmap/jquery.vmap.min.js"></script>
	<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
	<!-- jQuery Knob Chart -->
	<script src="plugins/jquery-knob/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script src="plugins/moment/moment.min.js"></script>
	<script src="plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script
		src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Summernote -->
	<script src="plugins/summernote/summernote-bs4.min.js"></script>
	<!-- overlayScrollbars -->
	<script
		src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE App -->
	<script src="dist/js/adminlte.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="dist/js/pages/dashboard.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="dist/js/demo.js"></script>
	<script src="plugins/datatables/jquery.dataTables.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
	<script src="dist/js/chart2.js"></script>
	
	<script type="text/javascript">
            $(document).ready(function () {
                var bootstrapTooltip = $.fn.tooltip.noConflict();
                $.fn.bstooltip = bootstrapTooltip;
                $('#opeTickets').bstooltip();
                $('#UnTickets').bstooltip();
                $('#iamwatch').bstooltip();
                $('#perTicket').bstooltip();
            })

        </script>

	<!-- table Data -->
	<script>
            var tabledata = $('#tabledata').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": true,
                "autoWidth": false,
                "aaSorting": []
            });

            var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
            var unresolvedstsData = {
                labels: [
                    'Approved',
                    'Yet To be Approved',
                    'Total'
                ],
                datasets: [{
                        data: [${count}, ${yetTobeApproved}, ${totalTripCount}],
                        backgroundColor: ['#17a2b8', '#00a65a', '#faa654'],
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

		 /* change Password */ 
            function changePassword(password) {
                console.log(document.getElementById('passwordch').value);
                console.log("my password" + password);

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(password),
                    url: "<%=GlobalUrl.changePassword%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
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
            /* Top 50 Invoice */
            getData();

            function getData() {

                $.ajax({
                    type: "POST",
                    data: "",
                    url: "<%=GlobalUrl.getFinanceDashBoardDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();
                            for (var i = 0; i < result.length; i++) {
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