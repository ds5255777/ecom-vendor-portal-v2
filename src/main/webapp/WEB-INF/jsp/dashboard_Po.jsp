<!DOCTYPE html>
<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html  lang="en">

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
		<jsp:include page="navbar.jsp?pagename=Po Dashboard" />



		<!-- Right navbar links -->
		<jsp:include page="slidebar_Po.jsp?pagename=dashboard_Po" />

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
					
							<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${allPOcount}</h2>

									<p id="iamwatch" data-toggle="tooltip" data-placement="bottom"
										>All PO</p>
								</div>
								<div class="icon">

									<i class="nav-icon fas fa-list" style="color: aquamarine; font-size: 70px;"></i>
								</div>
								<a href="allPO" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>
								
								
								
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${totalUnprocessPOCount}</h2>

									<p id="iamwatch" data-toggle="tooltip" data-placement="bottom"
										>Unprocessed PO</p>
								</div>
								<div class="icon">

									<i class="fa fa-tasks" style="color: chocolate; font-size: 70px;"></i>
								</div>
								<a href="unprocessPO" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>

						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${totalProcessPoCount}</h2>

									<p id="UnTickets" data-toggle="tooltip" data-placement="bottom"
										>Processed PO</p>
								</div>
								<div class="icon">

									<i class="fas fa fa-check"
										style="color: #28a745; font-size: 70px;"></i>
								</div>
								<a href="processPO" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>


							
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${totalQueryCount}</h2>

									<p id="allInactive" data-toggle="tooltip"
										data-placement="bottom" >Query</p>
								</div>
								<div class="icon">




									<i class="fas fa-question"
										style="color: #fd7e14; font-size: 70px;"></i>
								</div>
								<a href="QueryPo" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>
							
						<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${totalInvoiceCount}</h2>

								

									<p id="invdue" data-toggle="tooltip" data-placement="bottom"
										>All Invoice</p>
								</div>
								<div class="icon">

									<i class="fas fa-file-invoice-dollar"
										style="color: #007bff; font-size: 75px;"></i>
								</div>
								<a href="poInvoiceDetails" class="small-box-footer"
									style="background: #007bffe0; color: white !important;">More
									info <i class="fas fa-arrow-circle-right"></i>
								</a>
							</div>
						</div>
						
												<div class="col-lg-2 col-6">
							<!-- small box -->
							<div class="small-box bg-white">
								<div class="inner">
									<h2>${totalDraftInvoiceCount}</h2>

									<%-- <%Object totalProcessPoCount=request.getAttribute("totalProcessPoCount"); %>
									<h2><%=totalProcessPoCount %></h2> --%>

									<p id="invdue" data-toggle="tooltip" data-placement="bottom"
										>Draft Invoice</p>
								</div>
								<div class="icon">

									<i class="nav-icon fab fa-firstdraft"
										style="color: #dc3545; font-size: 75px;"></i>
								</div>
								<a href="draftPO" class="small-box-footer"
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
										data-placement="bottom" title="Top 15 Users">Top 50
										Unprocessed PO</h3>
								</div>
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0"
									style="height: 420px;">
									<table class="table table-head-fixed" id="tabledata">
										<thead>
											<tr>
												<th class="bg-primary">PO Number</th>
												<th class="bg-primary">Type</th>
												<th class="bg-primary">UOM</th>
												<th class="bg-primary">Quantity</th>
												<th class="bg-primary">Need By Date</th>
												<th class="bg-primary">Amount</th>

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
										<strong>PO Status</strong>
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

	<script type="text/javascript">
        $(document).ready(function() {
            var bootstrapTooltip = $.fn.tooltip.noConflict();
            $.fn.bstooltip = bootstrapTooltip;
            $('#quickHelp').bstooltip();
            $('#oveTickets').bstooltip();
            $('#invdue').bstooltip();
            $('#opeTickets').bstooltip();
            $('#UnTickets').bstooltip();
            $('#iamwatch').bstooltip();
            $('#perTicket').bstooltip();
            $('#allActive').bstooltip();
            
            $('#allInactive').bstooltip();
            $('#noofinvoice').bstooltip();
            $('#proinvoice').bstooltip();
            $('#appinvoice').bstooltip();
            $('#vendors').bstooltip();
            $('#Actvendors').bstooltip();
            $('#inactVendor').bstooltip();
           
            
            
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
            "aaSorting": [],
            "pageLength": dataLimit
        });

        var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
        var unresolvedstsData = {
            labels: [
                'All PO',
                'Unprocessed PO',
                'Processed PO',
                'Query',
                'Invoices',
                'Draft Invoices'
                
            ],//#FF0000(red),00a65a(inactive)
            datasets: [{
                data: [${allPOcount}, ${totalUnprocessPOCount},${totalProcessPoCount},${totalQueryCount},${totalInvoiceCount},${totalDraftInvoiceCount}],
                backgroundColor: ['aquamarine',  'chocolate','#28a745',  '#fd7e14','#007bff','#dc3545'],
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
                url: "<%=GlobalUrl.getAllUnProcessPo%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                	 if (data.msg == 'success') {

                         var result = data.data;
                         tabledata.clear();
                         
                         var poLineDetails = result[0].poLineDetails;
                    
                         for (var i = 0; i < result.length; i++) {
                         	
                         	if(!result[i].hasOwnProperty("id")){
  								result[i].id="";
  							}
                         	if(!result[i].hasOwnProperty("poNo")){
  								result[i].poNo="";
  							}
                              if(!result[i].hasOwnProperty("type")){
  								result[i].type="";
  							}
                               if(!result[i].hasOwnProperty("uom")){
  								result[i].uom="";
  							}
                              if(!result[i].hasOwnProperty("quantity")){
  								result[i].quantity="";
  							}
                              if(!result[i].hasOwnProperty("needByDate")){
   								result[i].needByDate="";
   							} 
                              if(!result[i].hasOwnProperty("amount")){
   								result[i].amount="";
   							}
                              if(!result[i].hasOwnProperty("status")){
  								result[i].status="";
  							}
                              
 				
                             tabledata.row.add([result[i].poNo ,result[i].type,result[i].uom,result[i].quantity,result[i].needByDate,result[i].amount ]);  				        	
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
                    alert("failed, please try again letter1");
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
</body>

</html>
