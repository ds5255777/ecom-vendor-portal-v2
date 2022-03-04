<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${titleName}|All Invoice</title>

<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<link rel="stylesheet"
	href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
<link rel="stylesheet" href="dist/css/adminlte.min.css">
<link rel="stylesheet"
	href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<link rel="stylesheet"
	href="plugins/daterangepicker/daterangepicker.css">
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="plugins/jquery-ui/jquery-ui.min.css">
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

.table td, .table th {
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
<jsp:include page="loader.jsp"/>  	
	<div class="wrapper">

		<!-- Navbar -->
		<jsp:include page="navbar.jsp?pagename=All Invoice" />
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="slidebar.jsp?pagename=invoiceQueue" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<div class="content-header" style="padding: 0px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6"></div>
						<div class="col-sm-6">
							<!-- <ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Dashboard v1</li>
						</ol> -->
						</div>

					</div>
				</div>
			</div>

			<!-- /.content-header -->


			<!-- Main content -->
			<section class="content ">
				<div class="row">

						<div class="col-md-12" style="font-size: 14px;">
							<!-- general form elements -->
							<div class="card card-primary card-outline">
								<div class="mailbox-controls">
                                    <!-- Check all button -->
                                    
                                    <!-- /.btn-group -->

                                    <div class="btn-group">
                                        <button type="button" class="btn">Sort by
                                            - Date Created</button>
                                        <button type="button" class="btn dropdown-toggle dropdown-toggle-split"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="sr-only"></span>
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#">Due By time</a>
                                            <a class="dropdown-item" href="#">Last Modify</a>
                                            <a class="dropdown-item" href="#">Priority</a>
                                            <a class="dropdown-item" href="#">Status</a>
                                        </div>
                                    </div>

                                    <div class="float-right">
                                       
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-default btn-sm"><i
                                                    class="fas fa-chevron-left"></i></button>
                                            <button type="button" class="btn btn-default btn-sm"><i
                                                    class="fas fa-chevron-right"></i></button>
                                        </div>
                                        <!-- /.btn-group -->
                                    </div>
                                    <!-- /.float-right -->
                                </div>
								<!-- /.card-header -->
								<!-- <div class="card-body "> -->
																		
									<div class="table-responsive mailbox-messages"
									id="tableQueueDetails"></div>
									
								<!-- </div> -->
								<!-- /.card-body -->
							</div>


						</div>
					</div>
				</div>
			</section>
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
		<script
			src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
		<script
			src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
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
			

		  	getData();	  
			  
		  	function getData(){
		  		
		  		var jsArray=[];
		  		
		  		$('.loader').show();
		  		
		  		$.ajax({
		  	      	type: "POST",
		  	      	data:  JSON.stringify(jsArray),
		  	          url: "<%=GlobalUrl.getAllInvoice%>",
		  					dataType : "json",
		  					contentType : "application/json",
		  					async : false,
		  					success : function(data) {

		  						$('.loader').hide();
		  						if (data.msg == 'success') {
		  							
		  							var result=data.data;
		  						//	tabledata.clear();
		  							
		  						var tbody="";
		  						var statusSpan="";
		  						var onlySubject="";
		  						var attchmentFlag="";
		  						
		  						var subStatusOfTicket="";
		  						var assigned_closedBy="";
		  						var project="";
		  						var emailStatusSpan="";
		  							for(var i=0; i< result.length; i++){
		  								console.log(result[i].invoiceDate);
		  								var count=i+1
		  								
		  							//	var viewData = "<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"viewCheckList('" + result[i].siteQualityId + "','" + result[i].checkListId + "','"+result[i].url+"')\"><i class='fa fa-eye ' ></i></button>";
		  					        	
		  							//	tabledata.row.add([ result[i].invoiceNumber,result[i].supplierName,result[i].supplierNumber,result[i].invoiceDate,result[i].invoiceAmount,result[i].paymentCurrency,result[i].paymentMethod,result[i].routeName,result[i].vehicleNumber,result[i].invoiceStatus,viewData]);
		  							
		  								tbody += '<tr>' + '<td style="padding: 0px 0px 0px 20px;">'
		  								+ '<div class="icheck-primary">'
		  								+ '<label>'+count+'</label>' + '</div>' + '</td>'
		  							
		  								+'<td class="mailbox-name" style="padding: 0px;width: 400px;">'						
		  								+ '<p style="margin-bottom: 0px;">'
		  								+ '<a href="ticketDetails?ticketQueId='
		  								+ i
		  								+ '">'
		  								+ '<strong>'+result[i].invoiceNumber+'</strong>'
		  								+ '</a>'
		  								+ ' &ensp;'
		  								+ statusSpan
		  								+ attchmentFlag
		  								+'<br>'
		  								+ onlySubject
		  								+'</p>'
		  								
		  								+'</td>'
		  								+'<td class="mailbox-subject" style="padding: 0px;">'
		  								+ '<p class="text-muted well well-sm shadow-none">'
		  								+ '<b>From :</b> '
		  								+ result[i].supplierName
		  								+ ' '
		  								+

		  								' <br><b>Created On :</b> '
		  								+ result[i].invoiceDate
		  								+ ' </p>'
		  								+ ' </td>'
		  								+'<td class="mailbox-subject" style="padding: 0px;">'
		  								+'<p class="text-muted well well-sm shadow-none">'
		  								+'<b>Status :</b> '+result[i].invoiceStatus+' <br><b>Payment Currency :</b> '+result[i].paymentCurrency+''
		  								+'</p>'
		  								+'</td>'
		  								+'<td class="mailbox-subject" style="padding: 0px;">'
		  								+'<p class="text-muted well well-sm shadow-none">'
		  								+''+assigned_closedBy+' <br><b>Project :</b> '+project+''						
		  								+'</p>'
		  								+'</td>'
		  								/* + ' <td class="mailbox-subject" style="padding: 0px;">'
		  								+ ' <p class="text-muted well well-sm shadow-none">'
		  								+ ' <b>SCN INV NO :</b> '+scnInvNo+' '
		  								
		  								+ ' '
		  								+ ' <br><b>SCN DUE DT :</b> '+scnDueDate+'</p>'
		  								+ ' </td>' */
		  								+ ' <td class="mailbox-date" align="Right" '+
		  		             '  style="padding: 0px 20px 0px 0px;">'
		  								+ ' <p class="text-muted well well-sm shadow-none" '+
		  		                  ' style="margin-top: 10px;"> '
		  								+ emailStatusSpan + '  ' +

		  								'</p>' + '</td>' + '</tr>'
		  					}
		  							
		  							$("#tableQueueDetails").html('');
				  				var	complete = '<table class="table table-hover table-striped"><tbody style="font-size: 12.9px;">'
				  							+ tbody + '</tbody> </table>'

				  					$("#tableQueueDetails").html(complete);
		  							
		  							
		  							
		  							//tabledata.draw();
		  					        //$("tbody").show();
		  						} else {
		  							Toast.fire({
		  	                    	        type: 'error',
		  	                    	        title: 'Failed.. Try Again..'
		  	                    	      })			                    		
		  						}
		  					},
		  					error : function(jqXHR, textStatue, errorThrown) {
		  						alert("failed, please try again leter");
		  					}
		  				});
		  	}
		  	
		  	function viewCheckList(id , type){
				console.log("id >> "+id +" >> "+type);
				location.href = "vendorDashBoadinfo?type="+type+"&id="+id
		  	}
		</script>
</body>
</html>