<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${titleName}|InvoiceProcess</title>
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- daterange picker -->
<link rel="stylesheet"
	href="plugins/daterangepicker/daterangepicker.css">
<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet"
	href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- Bootstrap Color Picker -->
<link rel="stylesheet"
	href="plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- Select2 -->
<link rel="stylesheet" href="plugins/select2/css/select2.min.css">
<link rel="stylesheet"
	href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<!-- Bootstrap4 Duallistbox -->
<link rel="stylesheet"
	href="plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
<!-- BS Stepper -->
<link rel="stylesheet" href="plugins/bs-stepper/css/bs-stepper.min.css">
<!-- dropzonejs -->
<link rel="stylesheet" href="plugins/dropzone/min/dropzone.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="dist/css/adminlte.min.css">
<link rel="stylesheet"
	href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet"
	href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
<link rel="stylesheet" href="plugins/sweetalert2/sweetalert2.min.css">
<style>
.table td, .table th {
	padding: 1px !important;
}

.form-control-sm {
	border-width: 1px;
	border-color: #e3e6ea;
}

.card-body {
	padding: 0.5rem 1.25rem 0.5rem 1.25rem;
}

.row {
	margin-bottom: 0.5rem !important;
}
</style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm">
	<div class="wrapper">
		<!-- Navbar -->
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light"
			style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;"" >
			<!-- Left navbar links -->
			<%-- <ul class="navbar-nav d-flex align-items-center flex-row"
					style="margin-left: 30px;">
					<li class="nav-item"><a class="nav-link profile-pic" href="#">
							<img class="rounded-circle"
							src="${pageContext.request.contextPath}/assets/images/bpaasLogo.png"
							alt="">
							
					</a></li>
				</ul> --%>
			<h5 style="color: white;">Invoice-Process</h5>
			<!-- Right navbar links -->
			<ul class="navbar-nav ml-auto">
				<!-- Navbar Search -->
				<h6 class="float-sm-right" style="color: white;">
					<b>Invoice Number : </b> ECOM-INV-1001
				</h6>
			</ul>
		</nav>

		<!-- /.navbar -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="margin-left: 0px !important;">
			<!-- Main content -->
			<section class="content" style="overflow: hidden;">
				<div class="container-fluid">
					<!-- SELECT2 EXAMPLE -->
					<div class="card card-primary" style="margin-top: 1rem;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">BASIC DETAILS</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="stepOneForm" class="forms-sample">
								<div class="row">

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Partner Name <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text" readonly
													value="${userName}" name="suppName" id="suppName"
													style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Partner Code <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="Business Partner Code" name="bpCode"
													id="bpCode" readonly style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Site Name <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<!-- <input class="form-control-sm" type="text" placeholder="Site Name" name="siteName" id="siteName" style="width: 100%;"> -->
												<select class="form-control-sm select2"  style="width: 100%;"
													id="siteName" name="siteName">
													<option value="Site_1">Site 1</option>
													<option value="Site_2">Site 2</option>
													<option value="Site_3">Site 3</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Date <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input type="date" name="invoiceDate" id="invoiceDate"
													readonly class="form-control-sm" style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Number <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="Invoice Number" name="invoiceNumber"
													id="invoiceNumber" readonly style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Currency <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<select class="form-control-sm select2" style="width: 100%;"
													id="invoiceCurrency" name="invoiceCurrency">
													<option value="INR">INR</option>
													<option value="USD">USD</option>
													<option value="KES">KES</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Amount <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="number"
													name="invoiceAmount" readonly id="invoiceAmount"
													placeholder="Invoice Amount" style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Receiving Date</label>
											<div class="col-sm-7">
												<input type="text" class="form-control-sm"
													name="invoiceReceivingDate" id="invoiceReceivingDate"
													readonly
													value="<%=(new java.util.Date()).toLocaleString()%>"
													style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Vehicle Number<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													name="vehicleNumber" readonly id="vehicleNumber"
													placeholder="vehicleNumber" style="width: 100%;">
											</div>
										</div>
									</div>

									<!--  -->
								</div>
							</form>
						</div>
					</div>
					<!-- /.card -->
					<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Line Item's</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<!-- /.card-header -->
						<form id="stepTwoForm" class="forms-sample">
						<div class="card-body" style="overflow: auto;">
							<table id="prTable" class="table table-bordered table-striped">
								<thead>
									<tr>
										<!-- <th style="padding: 5px 5px 5px 1.5rem;">Number</th> -->
										<th style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
										<th style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
										<th style="padding: 5px 5px 5px 1.5rem;">Rate per km</th>
										<th style="padding: 5px 5px 5px 1.5rem;">Current Fuel Rate</th>
										<th style="padding: 5px 5px 5px 1.5rem;">FS Base Rate</th>
										<th style="padding: 5px 5px 5px 1.5rem;">FS Diff</th>
										<th style="padding: 5px 5px 5px 1.5rem;">Basic Freight</th>
										<th style="padding: 5px 5px 5px 1.5rem;">FS</th>
										<th style="padding: 5px 5px 5px 1.5rem;">Actual KM</th>
										<th style="padding: 5px 5px 5px 1.5rem;">Total Freight</th>
										<th style="padding: 5px 5px 5px 1.5rem;">Line level Description</th>
									</tr>
								</thead>
							</table>
						</div>
						</form>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->

					<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">GST Details</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>

							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body" style="overflow: auto;">
							<form id="stepThreeForm" class="forms-sample">
								<div class="row">
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Taxable Amount</label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="taxableAmount"
													id="taxableAmount" type="text" readonly placeholder="Taxable Amount"
													style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Tax Amount</label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="taxAmount"
													id="taxAmount" type="text" readonly placeholder="Tax Amount"
													style="width: 100%;">
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
						<!-- /.card-body -->
					</div>
					<!--<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Document Upload</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>

							</div>
						</div>
						
						 <div class="card-body" style="overflow: auto;">
							<form id="stepFourForm" class="forms-sample">
								<div class="row">

									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-sm-5 control-label">Upload Invoice<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input type="file" id="InvoiceUpload" name="InvoiceUpload"
													class="form-control-sm"
													onchange="handleFileSelect(event,'InvoiceFileText')"
													class="form-control p-input">
												<textarea id="InvoiceFileText" name="InvoiceFileText"
													rows="5" style="display: none;"></textarea>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-sm-5 control-label">Document1<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input type="file" id="DocumentFileOne"
													name="DocumentFileOne" class="form-control-sm"
													onchange="handleFileSelect(event,'DocumentFileOneText')"
													class="form-control p-input">
												<textarea id="DocumentFileOneText"
													name="DocumentFileOneText" rows="5" style="display: none;"></textarea>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-sm-5 control-label">Document2<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input type="file" id="DocumentFileTwo"
													name="DocumentFileTwo" class="form-control-sm"
													onchange="handleFileSelect(event,'DocumentFileTwoText')"
													class="form-control p-input">
												<textarea id="DocumentFileTwoText"
													name="DocumentFileTwoText" rows="5" style="display: none;"></textarea>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
						/.card-body
					</div> -->
					<center>
						<div class="form-group">
							<label style="visibility: hidden;">Select </label> <br>
							 <button type="button" class="btn btn-primary" id="closeModal" onclick="closeWin()">Close</button>
						</div>
					</center>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>

	<!-- jQuery -->
	<script src="plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Bootstrap4 Duallistbox -->
	<script
		src="plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
	<!-- InputMask -->
	<script src="plugins/moment/moment.min.js"></script>
	<script src="plugins/inputmask/jquery.inputmask.min.js"></script>
	<!-- date-range-picker -->
	<script src="plugins/daterangepicker/daterangepicker.js"></script>
	<!-- bootstrap color picker -->
	<script
		src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script
		src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Bootstrap Switch -->
	<script src="plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
	<!-- BS-Stepper -->
	<script src="plugins/bs-stepper/js/bs-stepper.min.js"></script>
	<!-- dropzonejs -->
	<script src="plugins/dropzone/min/dropzone.min.js"></script>
	<!-- AdminLTE App -->
	<script src="dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="dist/js/demo.js"></script>
	<!-- Page specific script -->
	<!-- DataTables  & Plugins -->
	<script src="js/commonFunctions.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<script src="plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
	<script 
		src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
	<script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
	<script src="plugins/jszip/jszip.min.js"></script>
	<script src="plugins/pdfmake/pdfmake.min.js"></script>
	<script src="plugins/pdfmake/vfs_fonts.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
	<script src="plugins/select2/js/select2.full.min.js"></script>
        <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
        <script src="plugins/jquery-validation/additional-methods.min.js"></script>
	<!-- Select2 -->
	<script src="plugins/select2/js/select2.full.min.js"></script>

	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script> -->

	<script>
	var prTable = $("#prTable").DataTable({
    	"paging": false,
        "lengthChange": false,
        "searching": false,
        "info": true,
        "autoWidth": false,
        "aaSorting": [],
        "scrollX": true,
        "pageLength": 15,
        });
	
	function closeWin(){
		window.close()  
	}
  		
  		var invoiceNumber='${invoiceNumber}';
  		
  		var tripLineArray=[];
  
 		console.log("invoiceNumber : ",invoiceNumber);
 		
        setInvoiceDetails();
        
        function setInvoiceDetails() {

        	var obj={
        			"invoiceNumber":invoiceNumber
        	}
        	
        	$.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getSelectInvoiceDetails%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                        /* jsondata=JSON.parse(result) */
                        //console.log(result);
                         tripLineArray = data.data.invoiceLineItem;
                         console.log(tripLineArray);
                        var myForm = "";
                        var myFormOne ="";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result);
                        myFormOne = document.getElementById("stepThreeForm");
                        setData(myFormOne, result);
                        $('#prTable').DataTable().clear();
                        for (var i = 0; i < tripLineArray.length; i++) {
                            console.log(tripLineArray[i].runType);
                      	 $('#prTable').DataTable().row.add([  tripLineArray[i].runType, tripLineArray[i].standardKM, tripLineArray[i].ratePerKm, tripLineArray[i].currentFuelRate, tripLineArray[i].fsBaseRate,  tripLineArray[i].fsDiff, tripLineArray[i].basicFreight, tripLineArray[i].fs, tripLineArray[i].actualKM, tripLineArray[i].totalFreight, tripLineArray[i].lineLevelDescription ]);                         
                       console.log(tripLineArray[i].totalFreight);
                       }
                        $("#invoiceNumber").val(result.invoiceNumber);
                        
                       $('#prTable').DataTable().draw();
                       $("tbody").show();
                       
                        
                    } else {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    //alert("failed, please try again");
                    Toast.fire({
                        type: 'error',
                        title: 'Failed.. Try Again..'
                    })
                }
            });
            
        }
        
    </script>

</body>

</html>
