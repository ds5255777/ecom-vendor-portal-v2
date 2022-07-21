<!DOCTYPE html>
<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|Dashboard</title>

<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<!-- Ionicons -->
<link rel="stylesheet" href="dist/css/ionicons.min.css">
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
<link rel="stylesheet" href="plugins/toastr/toastr.min.css">
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
		<jsp:include page="slidebar_Finance.jsp?pagename=dashboard" />

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
						<div class="col-lg-3 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${pendingRequest }</h2>
									<p id="iamwatch" data-toggle="tooltip" data-placement="bottom">
										Pending Request</p>
								</div>
								<div class="icon">

									<i class="fa fa-tasks"
										style="color: chocolate; font-size: 50px;"></i>

								</div>
								<a href="#" class="small-box-footer" onclick="pendingRequest();"
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
									<h2>${approvedRequest}</h2>

									<p id="oveTickets" data-toggle="tooltip"
										data-placement="bottom">Approved Request</p>
								</div>
								<div class="icon">
									<i class="fa fa-user" style="color: #FAA654; font-size: 50px;"true" ></i>
								</div>
								<a href="#" class="small-box-footer" onclick="approvedRequest();"
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
									<h2>${ rejectedRequest}</h2>

									<p id="opeTickets" data-toggle="tooltip"
										data-placement="bottom">Rejected Request</p>
								</div>
								<div class="icon">
									<i class="fas fas fa-user-times"
										style="color: #f44336ab; font-size: 50px;"></i>

								</div>
								<a href="#" class="small-box-footer" onclick="rejectedRequest();"
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
									<h2>${queryRequest }</h2>

									<p id="invdue" data-toggle="tooltip" data-placement="bottom">
										Query</p>
								</div>
								<div class="icon">
									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 50px;"></i>
								</div>
								<a href="#" class="small-box-footer" onclick="queryRequest();"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>
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
						<div class="col-md-12">

							<!-- All request -->
							<div class="card card-primary  card-outline " id="allRequest" style="display: none">
								<div class="card-header">
									<h3 class="card-title" id="lastInvoice" data-toggle="tooltip"
										data-placement="bottom">Pending Request</h3>
								</div>
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0"
									style="height: 420px;">
									<table class="table table-head-fixed" id="tabledata">
										<thead>
											<tr>
												<th class="bg-primary">Process Id</th>
												<th class="bg-primary">introduced by email id</th>
												<th class="bg-primary">Introduced By Name</th>
												<th class="bg-primary">Business Partner Name</th>
												<th class="bg-primary">Business Partner Type</th>
												<th class="bg-primary">Status</th>
											</tr>
										</thead>
									</table>
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
	
	<div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title">Confirmation</h3>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <p>Are You Sure to Confirm This Invoice....</p>
                                </div>
                                <div class="modal-footer">

                                    <button type="button" onclick="approveInvoice()" id="updateBtnBtn" name="updateBtnBtn" class="btn btn-primary">Approve</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
	
	<form role="form" id="changePassword1" autocomplete="off">
		<div class="modal fade" id="changePassword" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Change
							Password</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="exampleInputEmail1">New Password</label> <input
								type="hidden" id="passflag"> <input type="password"
								class="form-control p-input" id="password" name="password"
								placeholder="New Password"
								pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
								title="Must contain at least one number and one uppercase and lowercase letter"
								required>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Confirm Password </label> <input
								type="password" class="form-control p-input"
								id="passwordConfirm" name="passwordConfirm"
								placeholder="Confirm Password">
						</div>
						<div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
					</div>
					<div class="modal-footer">
						<button type="button" id="changePasswordButton"
							class="btn btn-primary"
							onclick="changePassword(document.getElementById('passwordConfirm').value)"
							disabled>Change Password</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	<!-- Control Sidebar -->
	<aside class="control-sidebar control-sidebar-dark">
		<!-- Control sidebar content goes here -->
	</aside>
	<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- Modal -->


	<!-- jQuery -->

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
	<!-- AdminLTE for demo purposes -->
	<script src="dist/js/demo.js"></script>
	<script src="plugins/datatables/jquery.dataTables.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
	<script src="dist/js/chart2.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<script>
		const Toast = Swal.mixin({
			toast : true,
			position : 'top-end',
			showConfirmButton : false,
			timer : 3000
		});

		var tabledata = $('#tabledata').DataTable({
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"info" : false,
			"autoWidth" : false,
			"aaSorting" : []
		});
		
		var globalProcessId = "";
		//getData();
pendingRequest();
        function pendingRequest() {

            $('.loader').show();
            document.getElementById("lastInvoice").innerHTML = "Pending Request";
            document.getElementById("allRequest").style.display = "block";
            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getPendingRequest%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {
                    $('.loader').hide();
                    if (data.msg == 'success') {
                        var result = data.data;
                        tabledata.clear();
                        for (var i = 0; i < result.length; i++) {
                            var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" onclick=\"setVenRegStatus('" + result[i][0] + "','Pending Vendor')\" >" + result[i][0] + "</button>";
                            tabledata.row.add([
                            	view, 
                            	result[i][1],
                            	result[i][2], 
                            	result[i][3],
                            	result[i][4],
                            	result[i][5]]);
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
        
        function setVenRegStatus(pid){
        	globalProcessId = "";
        	globalProcessId = pid;
        	console.log(globalProcessId);
        }
        
        function setVenRegStatus(pid, status) {
            $('.loader').show();
            var urlOftripsDetail = "vendorView?pid=" +btoa(pid)+"&status="+btoa(status);
            window.open(urlOftripsDetail, "vendorView", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
            $('.loader').hide();
        }
        
        function refereshList() {
        	pendingRequest();
        	location.reload();
        	$('.loader').hide();
        }
        
        function approvedRequest(){
        	$('.loader').show();
        	
        	document.getElementById("lastInvoice").innerHTML = "Approved Request";
        	document.getElementById("allRequest").style.display = "block";
            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getApprovedRequest%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {
                    $('.loader').hide();
                    if (data.msg == 'success') {
                        var result = data.data;
                        tabledata.clear();
                        for (var i = 0; i < result.length; i++) {
                            var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" onclick=\"setVenRegStatus('" + result[i][0] + "','Approved Vendor')\" >" + result[i][0] + "</button>";
                            tabledata.row.add([
                            	view, 
                            	result[i][1],
                            	result[i][2], 
                            	result[i][3],
                            	result[i][4],
                            	result[i][5]]);
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
        
        function rejectedRequest(){
        	$('.loader').show();
        	document.getElementById("lastInvoice").innerHTML = "Rejected Request";
        	document.getElementById("allRequest").style.display = "block";
            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getRejectedRequest%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {
                    $('.loader').hide();
                    if (data.msg == 'success') {
                        var result = data.data;
                        tabledata.clear();
                        for (var i = 0; i < result.length; i++) {
                            var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" onclick=\"setVenRegStatus('" + result[i][0] + "','Rejected Vendor')\" >" + result[i][0] + "</button>";
                            tabledata.row.add([
                            	view, 
                            	result[i][1],
                            	result[i][2], 
                            	result[i][3],
                            	result[i][4],
                            	result[i][5]]);
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
        
		function queryRequest(){
			$('.loader').show();
			document.getElementById("lastInvoice").innerHTML = "Query";
			document.getElementById("allRequest").style.display = "block";
            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getQueryRequest%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {
                    $('.loader').hide();
                    if (data.msg == 'success') {
                        var result = data.data;
                        tabledata.clear();
                        for (var i = 0; i < result.length; i++) {
                            var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" onclick=\"setVenRegStatus('" + result[i][0] + "','Query Vendor')\" >" + result[i][0] + "</button>";
                            tabledata.row.add([
                            	view, 
                            	result[i][1],
                            	result[i][2], 
                            	result[i][3],
                            	result[i][4],
                            	result[i][5]]);
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
