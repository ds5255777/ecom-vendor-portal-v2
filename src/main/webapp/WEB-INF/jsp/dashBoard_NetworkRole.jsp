<!DOCTYPE html>
<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>${titleName}|Dashboard</title>

        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <!-- Tempusdominus Bbootstrap 4 -->
        <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
        <!-- iCheck -->
        <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- JQVMap -->
        <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
        <!-- Daterange picker -->
        <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
        <!-- summernote -->
        <!-- <link rel="stylesheet" href="plugins/summernote/summernote-bs4.css"> -->
        <!-- Google Font: Source Sans Pro -->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
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
		<jsp:include page="navbar.jsp?pagename=Dashboard" />



		<!-- Right navbar links -->
		<jsp:include page="slidebar.jsp?pagename=dashboard" />

		<!-- /.navbar -->

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->

			<!-- Main content -->
			<section class="content" style="padding-top: 15px;">
				<div class="container-fluid">
					<!-- Small boxes (Stat box) -->
					<div class="row">
						<!-- ./col -->
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${totalTripCount}</h2>

									<p id="oveTickets" data-toggle="tooltip"
										data-placement="bottom" >All Trips</p>
								</div>
								<div class="icon">
									<i class="fas fa-truck"
										style="color: #FAA654; font-size: 50px;"></i>
								</div>
								<a href="allTrips" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${ApprovedTripscount}</h2>

									<p id="iamwatch" data-toggle="tooltip" data-placement="bottom"
										>Approved Trips</p>
								</div>
								<div class="icon">

									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 50px;"></i>
								</div>
								<a href="getApprovedAdhocTrips" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${yetTobeApproved}</h2>

									<p id="UnTickets" data-toggle="tooltip" data-placement="bottom"
										>Pending Approval</p>
								</div>
								<div class="icon">
									<i class="fa fa-tasks" style="color: #8d4f55; font-size: 50px;"></i>
								</div>
								<a href="pendingApprovalNetwork" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<!-- ./col -->
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${getTripCountForQueryAdhoc}</h2>

									<p id="opeTickets" data-toggle="tooltip"
										data-placement="bottom"
										>Query Trips</p>
								</div>
								<div class="icon">
									<i class="fas fa-question"
										style="color: #C422F4; font-size: 50px;"></i>
								</div>
								<a href="QueryTripsForNetwork" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<div class="col-lg-2 col-6">

							<div class="small-box bg-white">
								<div class="inner">
									<h2>${getInClosedTripCountForAdhoc}</h2>

									<p id="perTicket" data-toggle="tooltip" data-placement="bottom"
										>Closed(Adhoc) Trips</p>
								</div>
								<div class="icon">
									<i class="far fa-times-circle"
										style="color: #17a2b8; font-size: 50px;"></i>
								</div>
								<a href="ClosedAdhoc" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<!-- ./col -->
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${getAllInvoiceCount}</h2>

									<p id="invdue" data-toggle="tooltip" data-placement="bottom"
										>All Invoices</p>
								</div>
								<div class="icon">
									<i class="fas fa-file-invoice-dollar"
										style="color: #1F8BFF; font-size: 50px;"></i>
								</div>
								<a href="invoicesQueue" class="small-box-footer"
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
										data-placement="bottom">Top
										50 Pending Approval Trips</h3>
								</div>
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0"
									style="height: 420px;">
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
								<!-- /.card-body -->
							</div>
						</div>
						<div class="col-md-4">
							<!-- DONUT CHART -->
							<div class="card card-primary  card-outline ">
								<div class="card-body">
									<p>
										<strong>Trips by Status</strong>
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
        <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <!-- Summernote -->
        <!-- <script src="plugins/summernote/summernote-bs4.min.js"></script> -->
        <!-- overlayScrollbars -->
        <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
        <!-- AdminLTE App -->
        <script src="dist/js/adminlte.js"></script>
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
       <!--  <script src="dist/js/pages/dashboard.js"></script> -->
        <!-- AdminLTE for demo purposes -->
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

                            $(function () {
                                $("#conpassword").keyup(function () {
                                    var password = $("#passwordch").val();
                                    if ($('#passwordch').val() == $('#conpassword').val()) {
                                        $('#divCheckPasswordMatch').html('Passwords match.').css('color', 'green');
                                    } else
                                        $('#divCheckPasswordMatch').html('Passwords do not match!').css('color', 'red');

                                    //  $("#divCheckPasswordMatch").html(password == $(this).val() ? "Passwords match." : "Passwords do not match!");
                                });

                            });
        </script>

        <script type="text/javascript">
            $(document).ready(function () {
                var bootstrapTooltip = $.fn.tooltip.noConflict();
                $.fn.bstooltip = bootstrapTooltip;
                $('#quickHelp').bstooltip();
                $('#oveTickets').bstooltip();
                $('#invdue').bstooltip();
                $('#opeTickets').bstooltip();
                $('#UnTickets').bstooltip();
                $('#iamwatch').bstooltip();
                $('#perTicket').bstooltip();
            })

        </script>




        <!-- table Data -->
        <script>
            var tabledata = $('#tabledata').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": false,
                "info": true,
                "autoWidth": false,
                "aaSorting": []
            });

            var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
            var unresolvedstsData = {
                labels: [
                    'Approved Trips',
                    'Pending Approval',
                    'Query Trips',
                    'Closed(Adhoc) Trips'
                ],
                datasets: [{
                        data: [${ApprovedTripscount}, ${yetTobeApproved}, ${getTripCountForQueryAdhoc},${getInClosedTripCountForAdhoc} ],
                        backgroundColor: ['#00a65a', '#8d4f55', '#C422F4','#1477B0' ],
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

           

            function changePassword(password) {

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

        </script>
        <!-- table Data -->



    </body>

</html>