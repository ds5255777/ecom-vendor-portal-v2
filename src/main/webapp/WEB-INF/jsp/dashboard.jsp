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
    <!-- Ionicons -->
    <link rel="stylesheet" href="dist/css/ionicons.min.css">
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
    <link rel="stylesheet" href="plugins/summernote/summernote-bs4.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
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
		<jsp:include page="sidebar_Vendor.jsp?pagename=dashboard" />

		<!-- /.navbar -->

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
						</div>
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
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${totalTripCount}</h2>

									<p id="oveTickets" data-toggle="tooltip"
										data-placement="bottom" >Total No of
										Trips</p>
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

						<!-- ./col -->
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${TotalInTransitTripCount}</h2>

									<p id="opeTickets" data-toggle="tooltip"
										data-placement="bottom">In-Transit Trip</p>
								</div>
								<div class="icon">
									<i class="fas fa-map-marked-alt"
										style="color: #00a65a; font-size: 50px;"></i>
								</div>
								<a href="inTransitTrips" class="small-box-footer"
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
									<h2>${pendingInvoice}</h2>

									<p id="invdue" data-toggle="tooltip" data-placement="bottom">
										Process Invoices</p>
								</div>
								<div class="icon">
									<i class="fas fa-file-contract"
										style="color: #1F8BFF; font-size: 50px;"></i>
								</div>
								<a href="pendingInvoice" class="small-box-footer"
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
									<h2>${approveInvoice}</h2>
									<p id="iamwatch" data-toggle="tooltip" data-placement="bottom">Approved
										Invoice</p>
								</div>
								<div class="icon">

									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 50px;"></i>
								</div>
								<a href="approvedInvoice" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${draftInvoice}</h2>
									<p id="UnTickets" data-toggle="tooltip" data-placement="bottom">Draft
										Invoice</p>
								</div>
								<div class="icon">
									<i class="fab fa-firstdraft"
										style="color: #dc3545; font-size: 50px;"></i>
								</div>
								<a href="draftInvoice" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${TotalCloseTripCount}</h2>

									<p id="perTicket" data-toggle="tooltip" data-placement="bottom">Query
										Invoice</p>
								</div>
								<div class="icon">
									<i class="fas fa-question"
										style="color: #fd7e14; font-size: 50px;"></i>
								</div>
								<a href="queryInvoice" class="small-box-footer"
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
										data-placement="bottom" >Top 50 Trips</h3>
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
												<th class="bg-primary">Payment Status</th>
											</tr>
										</thead>
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
										<strong>Trip by Status</strong>
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

        <!-- Navbar -->
        
      
        <%
        String vendorType=(String)request.getAttribute("vendorType");
        
        String[] strArray =   null;
        		
      strArray = vendorType.split(",");  
       
      for (int i = 0; i< strArray.length; i++){  
      
      }  
        
      
     	   for (int i = 0; i < strArray.length; i++) {
     		   
     		  if(strArray.length == 1 && strArray[i].equalsIgnoreCase("Network")  || strArray[i].equalsIgnoreCase("Fixed Asset") || strArray[i].equalsIgnoreCase("Other")){
      	    	 System.out.println("vendor type : "+strArray[i]); 
      	    	 %>
      	    	 
      	    	 <jsp:include page="navbar.jsp?pagename=Vendor Dashboard" />>
      	    	 
      	    	 <% 
         		  	 	break;
      	    	 }
         	
     	   		else if(strArray[i].equalsIgnoreCase("Network")  && strArray[i+1].equalsIgnoreCase("Fixed Asset")){
         	    	 System.out.println("vendor type : "+strArray[i]+"and "+strArray[i+1]); 
         	    	 %>
         	    	 
         	    	 <jsp:include page="navbar_po.jsp?pagename= Dashboard" />
         	    	 
         	    	 <% 
            		  	 	break;
         	     } 
     	   }
      %>
     



        <!-- Right navbar links -->
        <jsp:include page="sidebar_Vendor.jsp?pagename=dashboard" />

        <!-- /.navbar -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                        </div>
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
                        <div class="col-lg-2 col-6">
                            <!-- small box -->
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${totalTripCount}</h2>

                                    <p id="oveTickets" data-toggle="tooltip" data-placement="bottom" title="All Trips">Total No of
                                        Trips</p>
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
                            <!-- small box -->
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${TotalCloseTripCount}</h2>

                                    <p id="perTicket" data-toggle="tooltip" data-placement="bottom" title="Complet Trip from vendor Side">Closed Trips</p>
                                </div>
                                <div class="icon">
                                    <i class="far fa-times-circle" style="color: #17a2b8; font-size: 50px;"></i>
                                </div>
                                <a href="closedTrips" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>


                        <!-- ./col -->
                        <div class="col-lg-2 col-6">
                            <!-- small box -->
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${TotalInTransitTripCount}</h2>

                                    <p id="opeTickets" data-toggle="tooltip" data-placement="bottom" title="Running Trips">In-Transit
                                        Trip</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-map-marked-alt" style="color: #00a65a; font-size: 50px;"></i>
                                </div>
                                <a href="inTransitTrips" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <!-- ./col -->
                        <div class="col-lg-2 col-6">
                            <!-- small box -->
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${pendingInvoice}</h2>

                                    <p id="invdue" data-toggle="tooltip" data-placement="bottom" title="All Invoice Due, Pending And Rejected Today and Tommorow">
                                        Process Invoices</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-file-invoice-dollar" style="color: #1F8BFF; font-size: 50px;"></i>
                                </div>
                                <a href="pendingInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <!-- ./col -->
                        <!-- <div class="col-lg-2 col-6">
              
              <div class="small-box bg-white">
                <div class="inner">
                  <h2>22</h2>

                  <p id="opeTickets" data-toggle="tooltip" data-placement="bottom" title="Open and Assigned to me" >Tickets On Hold</p>
                </div>
                <div class="icon">
                  <i class="ion ion-stats-bars"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
              </div>
            </div> -->
                        <!-- ./col -->
                        <!-- ./col -->

                        <div class="col-lg-2 col-6">
                            <!-- small box -->
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${approveInvoice}</h2>

                                    <p id="iamwatch" data-toggle="tooltip" data-placement="bottom" title="Approved Invoice">Approved Invoice</p>
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
                            <!-- small box -->
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${draftInvoice}</h2>

                                    <p id="UnTickets" data-toggle="tooltip" data-placement="bottom" title="invoice Rejected some Reasons">Draft Invoice</p>
                                </div>
                                <div class="icon">
                                    <i class="fas fa-ban" style="color: #dc3545; font-size: 50px;"></i>
                                </div>
                                <a href="draftInvoice" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
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
                                    <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom" title="Top 15 Trips">Top 15
                                        Trips</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body table-responsive p-0" style="height: 420px;">
                                    <table class="table table-head-fixed" id="tabledata">
                                        <thead>
                                            <tr>
                                                <!-- <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip
                                                    ID</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Run
                                                    Type</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip
                                                    Status</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Payment
                                                    Status</th> -->
                                                     <th class="bg-primary" >Trip ID</th>
                                                     <th class="bg-primary" >Route</th>
                                                     <th class="bg-primary" >Run Type</th>
                                                     <th class="bg-primary" >Trip Status</th>
                                                     <th class="bg-primary" >Payment Status</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>
                        </div>
                        <div class="col-md-4">
                            <!-- DONUT CHART -->
                            <div class="card card-primary  card-outline ">
                                <div class="card-body">
                                    <p><strong>Trip by Status</strong></p>
                                    <canvas id="unresolvedsts" style="min-height: 385px;  max-height: 377px; max-width: 100%;display: block;width: 401px;height: 459px;"></canvas>
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
                            <input type="password" class="form-control p-input" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm Password" >
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
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Summernote -->
    <script src="plugins/summernote/summernote-bs4.min.js"></script>
    <!-- overlayScrollbars -->
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
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
		
            $(document).ready(function () {
                //console.log(${userStatus});
                if (${userStatus} === 3) {
                    $('#changePassword').modal('show');
                }
            });
            
            var dataLimit='${dataLimit}';
    		dataLimit=parseInt(dataLimit);
            
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
                  //  $("#divCheckPasswordMatch").html(password == $(this).val() ? "Passwords match." : "Passwords do not match!");
                });
            }); 
            
            const Toast = Swal.mixin({
    			toast : true,
    			position : 'top-end',
    			showConfirmButton : false,
    			timer : 3000
    		});
        </script>


    <!-- table Data -->
    <script>
        var tabledata = $('#tabledata').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": [],
            "pageLength": dataLimit
        });

        var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
        var unresolvedstsData = {
            labels: [
                'Query Invoice',
                'In-Transit',
                'All Trips',
                'Process Invoices',
                'Approved Invoice',
                'Draft Invoice'
            ],
            datasets: [{
                data: [${TotalCloseTripCount}, ${TotalInTransitTripCount}, ${totalTripCount}, ${pendingInvoice}, ${approveInvoice}, ${draftInvoice}],
                backgroundColor: ['#17a2b8', '#00a65a', '#FAA654', '#007bff', '#dc3545', '#6f42c1'],
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

        getDashBoardInformation();

        function getDashBoardInformation() {

            var id = "";
            var obj = {
                "id": id
            }

            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getDashboardDetails%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        //console.log(data.data);
                        var result = data.data
                        var tripList = data.data.tripList;
                       // console.log(tripList);
                        tabledata.clear();
                        var count = 0;
                        //var editBtn;
                        for (var i = 0; i < result.length; i++) {

                            count++;
                            if(!result[i].hasOwnProperty("tripID")){
								result[i].tripID="";
							}
                            if(!result[i].hasOwnProperty("route")){
								result[i].route="";
							}
                            if(!result[i].hasOwnProperty("runType")){
								result[i].runType="";
							}
                            if(!result[i].hasOwnProperty("vendorTripStatus")){
								result[i].vendorTripStatus="";
							}
                            if(!result[i].hasOwnProperty("paymentStatus")){
								result[i].paymentStatus="";
							}
                            
                            tabledata.row.add([result[i].tripID,
                                result[i].route,
                                result[i].runType,
                                result[i].vendorTripStatus,
                                result[i].paymentStatus,
                            ]);
                        }
                        tabledata.draw();
                        $("tbody").show();
                    } else {
                    	Toast.fire({
                            type: 'error',
                            title: 'Failed..not Load Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    alert("failed, please try again letter");
                }
            });
        }
        
        function changePassword(password){
        	console.log(document.getElementById('password').value);
        	console.log("my password "+"<%=GlobalUrl.changePassword%>"+"?password="+password);
        	
        	
        	$.ajax({
                 type: "POST",
                 data: "",
                 url: "<%=GlobalUrl.changePassword%>"+"?password="+password,
                 dataType: "json",
                 contentType: "application/json",
                 async: false,
                 
                 success: function(data) {
                	 $('.loader').hide();
                     $("#changePassword").modal('hide');
                     if (data.msg == "success") {
                         Swal.fire({
                             type: 'success',
                             title: 'Password Updated Successfully..'
                         })
                        
                     } else {
                    	 Swal.fire({
                             type: 'error',
                             title: 'Try Again...'
                         })
                     }
                 },
                 error: function(jqXHR, textStatue, errorThrown) {
                     alert("failed, please try again letter");
                 }
             });

        }

    </script>
    <!-- table Data -->



</body>

</html>
