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
<title>${titleName}| Draft Invoice Generate</title>
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
<link rel="stylesheet"
	href="plugins/daterangepicker/daterangepicker.css">
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
			<h5 style="color: white;">Invoice-Process</h5>
			<!-- Right navbar links -->
			<ul class="navbar-nav ml-auto">
				<!-- Navbar Search -->
				<h6 class="float-sm-right" style="color: white;">
					<b>Invoice Number : </b> <input type="text"
						name="ecomInvoiceNumber" id="ecomInvoiceNumber"
						value="${invoiceNumber}" readonly
						style="background: #007BFF; color: white; border: 0px; width: 210px;">
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
											<label class="col-sm-5">Supplier Invoice number (DFF)
												<span class="text-danger"></span>
											</label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="hidden"
													placeholder="Invoice Number" name="invoiceNumber"
													id="invoiceNumber" readonly maxlength="70"
													style="width: 100%;"> <input
													class="form-control-sm" type="text"
													placeholder="Invoice Number" name="vendorInvoiceNumber"
													id="vendorInvoiceNumber" maxlength="70"
													style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Type <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="Invoice Type" name="invoiceType"
													id="invoiceType" style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Po Number<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input type="text" name="poNumber" id="poNumber" readonly
													class="form-control-sm" style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Date <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input type="text" name="invoiceDate" id="invoiceDate"
													disabled="disabled" class="form-control-sm"
													style="width: 100%;">
											</div>
										</div>
									</div>



									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Currency <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="Currency" name="invoiceCurrency"
													id="invoiceCurrency" readonly style="width: 100%;">



											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">invoice Amount <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<!-- <input class="form-control-sm" type="text" placeholder="Site Name" name="siteName" id="siteName" style="width: 100%;"> -->
												<input class="form-control-sm" type="text"
													placeholder="invoice Amount"
													onkeypress="return event.charCode >= 46 && event.charCode <= 57"
													maxlength="70" name="invoiceAmount" id="invoiceAmount"
													style="width: 100%;">
											</div>
										</div>
									</div>


									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Supplier Site <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<!-- <input class="form-control-sm" type="text" placeholder="Site Name" name="siteName" id="siteName" style="width: 100%;"> -->
												<input class="form-control-sm" type="text"
													placeholder="Supplier Site" name="supplierSite"
													id="supplierSite" readonly style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Operating Unit<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input type="text" class="form-control-sm"
													name="operatingUnit" id="operatingUnit"
													placeholder="Operating Uni" readonly style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Trading partner<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="tradingPartner"
													id="tradingPartner" type="text"
													placeholder="Trading partner" style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Supplier Number<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="supplierNum"
													id="supplierNum" placeholder="Supplier Number"
													style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">GL Date <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text" name="glDate"
													id="glDate" placeholder="GL Date" max="${curentDate}" style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Payment Currency<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" readonly="readonly"
													name="paymentCurrency" id="paymentCurrency"
													placeholder="Payment Currency" style="width: 100%;" on>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Match Option <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="matchOption"
													id="matchOption" readonly="readonly"
													placeholder="Match Option" style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Terms Date<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="termsDate"
													id="termsDate" max="${curentDate}" placeholder="Terms Date"
													style="width: 100%;" >
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Terms <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="terms" id="terms"
													placeholder="Terms" style="width: 100%;">
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Payment Method<span
												class="text-danger"> </span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="paymentMethod"
													id="paymentMethod" placeholder="Payment Method"
													style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Pay Group <span
												class="text-danger"></span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="payGroup" id="payGroup"
													placeholder="Pay Group " style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Remit To bank account name<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="remitToBankAccountName"
													id="remitToBankAccountName"
													onkeypress="return event.charCode >= 65 && event.charCode <= 122 || event.charCode == 32 "
													placeholder="Remit To bank account name"
													style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Remit To bank account number
												<span class="text-danger">*</span>
											</label>
											<div class="col-sm-7">
												<input class="form-control-sm"
													name="remitToBankAccountNumber"
													onkeypress="return event.charCode >= 48 && event.charCode <= 57"
													id="remitToBankAccountNumber"
													placeholder=" Remit To bank account number"
													style="width: 100%;" maxlength="20">
											</div>
										</div>
									</div>


									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Supplier invoice date (DFF) <span
												class="text-danger"></span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" name="supplierInvoiceDate"
													id="supplierInvoiceDate"
													placeholder=" Supplier invoice date" max="${curentDate}" style="width: 100%;">
											</div>
										</div>
									</div>


								</div>
							</form>
						</div>
					</div>
					<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Invoice distribution</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>

						<div class="card-body">
							<form id="stepTwoForm" class="forms-sample">
								<div class="row">

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Line type <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="lineType" name="lineType" id="lineType"
													maxlength="70" style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Account<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="Invoice Type"
													onkeypress="return event.charCode >= 48 && event.charCode <= 57"
													name="account" id="account" maxlength="70"
													style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">GL Date<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" 
													placeholder="GL Date" name="glDateDistributionDate" id="glDateDistributionDate"
													maxlength="70" max="${curentDate}" style="width: 100%;">
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Amount <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="Invoice Type"
													onkeypress="return event.charCode >= 46 && event.charCode <= 57"
													name="amount" id="amount" maxlength="70"
													style="width: 100%;">
											</div>
										</div>
									</div>


								</div>
							</form>
						</div>
					</div>

	<div class="card card-primary">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Document Upload</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body" style="overflow: auto;">
							<form id="stepFourForm" class="forms-sample">
								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-sm-5 control-label">Upload Invoice<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												<input type="file" id="InvoiceUpload" name="InvoiceUpload"
													class="form-control-sm" accept=".jpg, .jpeg, .pdf"
													onchange="handleFileSelect(event,'InvoiceFileText'), onValidateFile('InvoiceUpload')"
													class="form-control p-input">
												<textarea id="InvoiceFileText" name="InvoiceFileText"
													rows="5" style="display: none;"></textarea>
												<label><span
													style="font-weight: 500; color: #fd7e14;">(* File
														size Max ${fileSize} MB)</span></label>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-sm-5 control-label">Summary Sheet<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input type="file" id="DocumentFileOne"
													name="DocumentFileOne" class="form-control-sm"
													accept=".pdf, .doc, .docx, .xls, .xlsx"
													onchange="handleFileSelect(event,'DocumentFileOneText'), onValidateFileOne('DocumentFileOne')"
													class="form-control p-input">
												<textarea id="DocumentFileOneText"
													name="DocumentFileOneText" rows="5" style="display: none;"></textarea>
												<label><span
													style="font-weight: 500; color: #fd7e14;">(* File
														size Max ${fileSize} MB)</span></label>
											</div>
										</div>
									</div>

								</div>
							</form>
						</div>
						<!-- /.card-body -->
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

						<div class="card-body" style="overflow: auto;">
							<form id="stepThreeForm" class="forms-sample">
								<div class="row">
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-4 control-label">Line Item</label>
											<div class="col-sm-8">
												<select id="tripList" name="tripList"
													class="form-control-sm select2"
													style="width: 100% !important;">
													<option>Select Line Item</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group">
											<button type="button" class="btn btn-primary"
												style="margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
												id="docBtn" name="docBtn" onclick="addPOLineitem()">Add</button>

										</div>
									</div>
								</div>
							</form>
						</div>





						<div class="card-body" style="overflow: auto;">
							<table id="prTable" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
											S.No</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
											Line Number</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
											Receipent Line</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Description</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Line
											Type</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">PO
											Line</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">GL
											Date</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Quantity</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Remaning
											Quantity</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Quantity
											Invoiced</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Unit
											Price</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">UOM</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Tax
											%</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Base
											Amount</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Tax
											Amount</th>

										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Total
											Amount</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Action</th>
									</tr>
								</thead>
							</table>
						</div>



						<center>
							<div class="form-group">
								<label style="visibility: hidden;">Select </label>
								<button type="button" onclick="sendToServer()"
									class="btn btn-info">Submit Invoice</button>

								<!-- <label style="visibility: hidden;">Select</label>
                            <button type="button" onclick="discardInvoice()" class="btn btn-info">Discard Invoice</button>
 -->
								<label style="visibility: hidden;">Select</label>
								<button type="button" onclick="window.close()"
									class="btn btn-info">Close</button>
							</div>
						</center>
						<!-- /.row -->
					</div>
					<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
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

	<script>
       
    var tripLineArray=[];
  
    var price1=[];
    var quntityflag=[];
    var prTable = $('#prTable').DataTable({
		"paging" : false,
		"lengthChange" : false,
		"searching" : false,
		"info" : false,
		"autoWidth" : false,
		"aaSorting" : [],
		"scrollX" : false
	});
    
    var  invoiceNumber='${invoiceNumber}';

    var lineNumberArray=[];
   var lineNum1=[];
   
   getPoDetails();
    
    function getPoDetails() {

        var obj = {
            "invoiceNumber": invoiceNumber
        }
		
        $.ajax({
            type: "POST",
            data: JSON.stringify(obj),
            url: "<%=GlobalUrl.getAllDraftPODetailsByInvoiceNo%>",
            dataType: "json",
            contentType: "application/json",
            async: false,
            success: function(data) {

                if (data.msg == 'success') {
                    var result = data.data;

                    
                    var  glDate= result[0].glDate;
                    var termsDate= result[0].termsDate;
                    var supplierInvoiceDate= result[0].supplierInvoiceDate;
                   var glDateDistributionDate=result[0].glDateDistributionDate
               
                        	if( glDate !== undefined ){
                        	
                              $('#glDate').val(glDate.split(" ")[0]);
                              $('#glDate').attr('readonly','readonly');
                            
        					}else{
        						document.getElementById("glDate").type="date"; 
                            	
                            	 
                            }
        					if( termsDate !== undefined ){
                              $('#termsDate').val(termsDate.split(" ")[0]);
                              $('#termsDate').attr('readonly','readonly');
                              } else{
                            	  document.getElementById("termsDate").type="date"; 
                              	
                              }
        					if( supplierInvoiceDate !== undefined ){
                              $('#supplierInvoiceDate').val(supplierInvoiceDate.split(" ")[0]);
                              $('#supplierInvoiceDate').attr('readonly','readonly');
                        }else{
                        	document.getElementById("supplierInvoiceDate").type="date";
                        }
        					if( glDateDistributionDate !== undefined ){
                                $('#glDateDistributionDate').val(glDateDistributionDate.split(" ")[0]);
                                $('#glDateDistributionDate').attr('readonly','readonly');
                          }else{
                          	document.getElementById("glDateDistributionDate").type="date";
                          }
          					  
                     tripLineArray=result[0].poInvoiceLine;
                     
                     for(var i=0;i<tripLineArray.length;i++){
                     	quntityflag.push("0");
                     }
                    var myForm = "";
                    myForm = document.getElementById("stepOneForm");
                    setData(myForm, result[0]);
             
                    myForm = document.getElementById("stepTwoForm");
                    setData(myForm, result[0]);
                    
                    var remaningQuat;
                
                    $('#prTable').DataTable().clear();
                    for (var i = 0; i < tripLineArray.length; i++) {
                    	
                    	 id=tripLineArray[i].id;
                       	 var lineNum11=tripLineArray[i].lineNumber;
                       	 
                       	lineNum1.push(lineNum11);
                       	 
                       	 if(tripLineArray[i].hasOwnProperty("remaningQuatity")){
                       		
                       	 }else{
                       		
                       	 }
                    	
                    	 var obj = {
                    	            "lineNumberpo": tripLineArray[i].lineNumber
                    	        }
                    	
                    	
                    	 $.ajax({
                    	        type: "POST",
                    	        data: JSON.stringify(obj),
                    	        url: "<%=GlobalUrl.getCurrentRemaningQty%>",
                    	        dataType: "json",
                    	        contentType: "application/json",
                    	        async: false,
                    	        success: function(data) {
                    	        	 if (data.msg == 'success') {
                    	        		 var result = data.data;
                    	        		 remaningQuat=result;
                    	        	 }

                    	         
                    	        }
                    		  });
                    	
                    	
                    	
                    	 tripLineArray[i].quantity=remaningQuat;
                    	 var date ='${curentDate}';
                    	 
                        var totalamot;
                        var lineNumber= "<input type=\"text\" id=\"lineNumber_"+i+"\" readonly style=\"width: 100%; height: 28px;\" value=\"" + tripLineArray[i].lineNumber + "\"  class=\"form-control-sm \" \"> ";

                        var receipentLine= "<input type=\"text\" id=\"receipentLine_"+i+"\" maxlength=\"40\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('receiptline','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
                        var description= "<input type=\"text\" id=\"description_"+i+"\" readonly style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('description','"+i+"',this.value)\" value=\"" + tripLineArray[i].description + "\" class=\"form-control-sm \" \"> ";
                        var lineType= "<input type=\"text\" id=\"lineType_"+i+"\" maxlength=\"40\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('lineType','"+i+"',this.value)\"  class=\"form-control-sm \" \"> ";
                        var poline= "<input type=\"text\" id=\"poline_"+i+"\" maxlength=\"40\" oninput=\"updatePOLineItem('poline','"+i+"',this.value)\" style=\"width: 70px; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var glDate= "<input type=\"date\" id=\"glDate_"+i+"\" max=\""+date+"\" oninput=\"updatePOLineItem('gldate','"+i+"',this.value)\" style=\"width: 100px; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var remaningQuantity= "<input type=\"text\" readonly id=\"remaningQuantity_"+i+"\" style=\"width: 100%; height: 28px;\" class=\"form-control-sm \" \"> ";
                        var quantity= "<input type=\"text\" readonly style=\"width: 100px; height: 28px;\" value=\"" + remaningQuat + "\" class=\"form-control-sm \" \"> ";
                        var quantityInvoiced= "<input type=\"text\" id=\"quantityInvoiced_"+i+"\" maxlength=\"40\" onkeypress=\"return event.charCode >= 48 && event.charCode <= 57  \" style=\"width: 100%; height: 28px;\" oninput=\"updatebaseaAmt('"+id+"','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
                        var unitPrice= "<input type=\"text\" id=\"unitPrice_"+i+"\" readonly style=\"width: 100px; height: 28x;\" value=\"" + tripLineArray[i].unitPrice + "\"  class=\"form-control-sm \" \"> ";
                        var uom= "<input type=\"text\" id=\"uom_"+i+"\" oninput=\"updatePOLineItem('uom','"+i+"',this.value)\" maxlength=\"40\" style=\"width: 100px; height: 28px;\"  class=\"form-control-sm \" \"> ";
                        var taxAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"  id=\"tax_"+i+"\" class=\"form-control-sm \" \"> ";
                        var baseAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"   id=\"baseAmt_"+i+"\"   class=\"form-control-sm \" > ";
                        var taxPercentage= "    <select  class=\"form-control-sm \" style=\"width: 67px; height: 28px;\" id=\"taxper_"+i+"\"  onchange=\"updatetotalAmount(this.value,'"+i+"')\" > <option value=\"0\" \">0%</option><option value=\"5\"  \">5%</option><option value=\"8\"  \">8%</option><option value=\"18\" \">18%</option><option value=\"28\" \">28%</option> </select > ";
                        var totalAmount= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"totamt_"+i+"\" > ";
                        var inactive = "<button type=\"button\"  class=\" btndeleterow\" style=\"color: #fff;background-color: #007bff; border-color: #007bff;box-shadow: none;\" data-placement=\"bottom\" onclick=\"inactiveActiveDeleteData(" + i + ")\"  data-original-title=\"Click To Delete\" > <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                        
						prTable.row.add([i + 1,lineNumber,receipentLine,description,lineType,poline,glDate,quantity,remaningQuantity,quantityInvoiced,unitPrice,uom,taxPercentage,baseAmount,taxAmount,totalAmount,inactive]);
				  
						
						
                         }
                    var  grossamt= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"grossAmt\" >";
                    prTable.row.add(["","","","","","","","","","","","","Total","","",grossamt,""]);
                 
                    $('#prTable').DataTable().draw();
                    $("tbody").show();
               

                    var pono =document.getElementById('poNumber').value

					for (var i = 0; i < result[0].length; i++) {
                        if (!result[0].hasOwnProperty("tripLineArray")) {
                        	 $('#uom1').val( tripLineArray[0].uom);
                             $('#description1').val( tripLineArray[0].description);
                             
                        }
					}
					
					
                   
                    var d = new Date();
                    $( "#invoiceDate" ).val(d.getFullYear()+'/'+(d.getMonth()+1)+'/'+d.getDate());
                    
                    
                   } else {
                    Toast.fire({
                        type: 'error',
                        title: 'Failed.. Try Again..'
                    })
                }
            },
            error: function(jqXHR, textStatue, errorThrown) {
                Toast.fire({
                    type: 'error',
                    title: 'Failed.. Try Again..'
                })
            }
        });
    }
    
    function addPOLineitem() {
		  var lineitemNo= $('#tripList').val();
		  
		if(lineitemNo=="Select Line Item" || lineitemNo==""){
			  
			  
			  Toast.fire({
	                type: 'error',
	                title: 'Kindly select one line number !'
	            });
			  return;
		  }
		
	        var obj = {
	            "lineNumber": lineitemNo
	        }
			
	        $.ajax({
	            type: "POST",
	            data: JSON.stringify(obj),
	            url: "<%=GlobalUrl.getAllPODetailsByLineNumber%>",
	            dataType: "json",
	            contentType: "application/json",
	            async: false,
	            success: function(data) {

	                if (data.msg == 'success') {
	                    var result = data.data;
	                    var uitprie=result.price;
	                    result.unitPrice=uitprie
	                    tripLineArray.push(result);
	                   
	                    showDatatbleData(tripLineArray);
	            
	                }else {
	                    Toast.fire({
	                        type: 'error',
	                        title: 'Failed.. Try Again..'
	                    })
	                }
	            },
	            error: function(jqXHR, textStatue, errorThrown) {
	                Toast.fire({
	                    type: 'error',
	                    title: 'Failed.. Try Again..'
	                })
	            }
	        });
	       
	           
	       
	                $('#tripList option:selected').remove();
	                
	                for( var i = 0; i < lineNumberArray.length; i++){ 
	                    
	                    if ( lineNumberArray[i] === lineitemNo) { 
	                
	                    	lineNumberArray.splice(i); 
	                    }
	                
	                }
		  
	}

  
    function showDatatbleData(tripLineArray){
  	  
  	  
  	  prTable.clear();
        for (var i = 0; i < tripLineArray.length; i++) {
        	 id=tripLineArray[i].id;
        	 price1[i]=tripLineArray[i].price;
        	
        	 if(tripLineArray[i].remaningQuatity!=null){
        		
        	 }else{
        		
        	 }
        	 
        	 var date ='${curentDate}';

            var totalamot;
            var lineNumber= "<input type=\"text\" id=\"lineNumber_"+i+"\" readonly style=\"width: 100%; height: 28px;\" value=\"" + tripLineArray[i].lineNumber + "\"  class=\"form-control-sm \" \"> ";

            var receipentLine= "<input type=\"text\" id=\"receipentLine_"+i+"\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('receiptline','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
            var description= "<input type=\"text\" id=\"description_"+i+"\" readonly style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('description','"+i+"',this.value)\" value=\"" + tripLineArray[i].description + "\" class=\"form-control-sm \" \"> ";
            var lineType= "<input type=\"text\" id=\"lineType_"+i+"\" style=\"width: 100%; height: 28px;\" oninput=\"updatePOLineItem('lineType','"+i+"',this.value)\"  class=\"form-control-sm \" \"> ";
            var poline= "<input type=\"text\" id=\"poline_"+i+"\" oninput=\"updatePOLineItem('poline','"+i+"',this.value)\" style=\"width: 70px; height: 28px;\" class=\"form-control-sm \" \"> ";
            var glDate= "<input type=\"date\" id=\"glDate_"+i+"\" max=\""+date+"\" oninput=\"updatePOLineItem('gldate','"+i+"',this.value)\" style=\"width: 100px; height: 28px;\" class=\"form-control-sm \" \"> ";
            var remaningQuantity= "<input type=\"text\" readonly id=\"remaningQuantity_"+i+"\" style=\"width: 100%; height: 28px;\" class=\"form-control-sm \" \"> ";
            var quantity= "<input type=\"text\" readonly style=\"width: 100px; height: 28px;\" value=\"" +  tripLineArray[i].quantity + "\" class=\"form-control-sm \" \"> ";
            var quantityInvoiced= "<input type=\"text\" id=\"quantityInvoiced_"+i+"\" style=\"width: 100%; height: 28px;\" oninput=\"updatebaseaAmt('"+id+"','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
            var unitPrice= "<input type=\"text\" id=\"unitPrice_"+i+"\" readonly style=\"width: 100px; height: 28x;\" value=\"" + tripLineArray[i].unitPrice + "\"  class=\"form-control-sm \" \"> ";
            var uom= "<input type=\"text\" id=\"uom_"+i+"\" oninput=\"updatePOLineItem('uom','"+i+"',this.value)\" style=\"width: 100px; height: 28px;\"  class=\"form-control-sm \" \"> ";
            var taxAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"  id=\"tax_"+i+"\" class=\"form-control-sm \" \"> ";
            var baseAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"   id=\"baseAmt_"+i+"\"   class=\"form-control-sm \" > ";
            var taxPercentage= "    <select  class=\"form-control-sm \" style=\"width: 67px; height: 28px;\" id=\"taxper_"+i+"\"  onchange=\"updatetotalAmount(this.value,'"+i+"')\" > <option value=\"0\" \">0%</option><option value=\"5\"  \">5%</option><option value=\"8\"  \">8%</option><option value=\"18\" \">18%</option><option value=\"28\" \">28%</option> </select > ";
            var totalAmount= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"totamt_"+i+"\" > ";
            var inactive = "<button type=\"button\"  class=\" btndeleterow\" style=\"color: #fff;background-color: #007bff; border-color: #007bff;box-shadow: none;\" data-placement=\"bottom\" onclick=\"inactiveActiveDeleteData(" + i + ")\"  data-original-title=\"Click To Delete\" > <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
            
  			prTable.row.add([i + 1,lineNumber,receipentLine,description,lineType,poline,glDate,quantity,remaningQuantity,quantityInvoiced,unitPrice,uom,taxPercentage,baseAmount,taxAmount,totalAmount,inactive]);
  	  }
        
      var  grossamt= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"grossAmt\" >";
        prTable.row.add(["","","","","","","","","","","","","", "","Gross Total",grossamt,""]);
     
       
        prTable.draw();
       
        $("tbody").show();
           
        
        
    }
    

    
    
    function updatePOLineItem(key,index,value){
  	  tripLineArray[index][key]=value;
  	  console.log(tripLineArray);
    }
    
    
    function updatetotalAmount(value,index){
  	  var quntity =$("#quantityInvoiced_"+index).val();
    	if(value=="" || quntity==""){
    		
    		return;
    	}
    	
    	
    	if(quntity==""){
    		
    	}
    	quntity =parseFloat($("#quantityInvoiced_"+index).val());
    	
      var unitprice =parseFloat($("#unitPrice_"+index).val());
    	var baseAmount=(parseFloat(unitprice)*parseFloat(quntity)).toFixed(2);
  	 $("#baseAmt_"+index).val(baseAmount);
  	 
  	 baseAmount=parseFloat(baseAmount); 
  	 tripLineArray[index].baseAmount=baseAmount;
  	 
    	var taxAmount=baseAmount*(parseFloat(value)/100);
    	taxAmount=parseFloat(taxAmount).toFixed(2);
    	$("#tax_"+index).val(taxAmount);
    	 
    	var totalAmount=(parseFloat(baseAmount)+parseFloat(taxAmount)).toFixed(2);
    	
    	$("#totamt_"+index).val(totalAmount);
    	 tripLineArray[index].totalAmount=totalAmount;
    	 tripLineArray[index].taxAmount=taxAmount;
    	 tripLineArray[index].taxper=value;
    	 
    	calculateGrossAmt();
	 
    }
   
    
    function calculateGrossAmt(){
  	  grosstotalamt=0;
  	  	 for(var k=0; k<tripLineArray.length; k++){
  	  		 
  	  		 if(tripLineArray[k].hasOwnProperty("totalAmount")){
  	  			grosstotalamt += parseFloat(tripLineArray[k].totalAmount);
  	  		 }
  	  	 }

  	  	$("#grossAmt").val(parseFloat(grosstotalamt).toFixed(2));
  	  	 tripLineArray.grossTotalAmt=grosstotalamt;
  		  
    }
    
    function setTripArrayDataBlankForIndex(index){
  	  
  	  $("#quantityInvoiced_"+index).val("");
  	   $("#baseAmt_"+index).val("");
  	   $("#remaningQuantity_"+index).val("");
  	   $("#tax_"+index).val("");
  	   $("#totamt_"+index).val("");
  	  
  	  tripLineArray[index].totalAmount=0;
  	  	 tripLineArray[index].taxAmount=0;
  	  	 tripLineArray[index].taxper=0;
  	  	tripLineArray[index].baseAmount=0;
  	  	tripLineArray[index].quantityInvoiced=""; 
  	  	
  	  	calculateGrossAmt();
    }
    
  
    var remaningQuatity1=[];
    var remanId1=[];
    var indx="";
   function updatebaseaAmt(reId, index,quntity){
  	 
  	 
  	 if(quntity==""){
  		 
  		 setTripArrayDataBlankForIndex(index);
  		quntityflag[index]="0";
  		 return; 
  	 }
  	quntityflag[index]="1";
  	   var allquantity =parseFloat(tripLineArray[index].quantity)
  		 quntity=parseFloat(quntity);
  		  		 if(quntity<=allquantity){
  		  			 
  		  			tripLineArray[index].quantityInvoiced=quntity; 
  		  			 var  remaningQuantity= allquantity-quntity;
  					  $("#remaningQuantity_"+index).val(remaningQuantity);
  					 var taxper = $("#taxper_"+index).val();
  					 tripLineArray[index].remaningQuatity=remaningQuantity;
  						tripLineArray[index].lineitemId=reId; 
  						if(indx==index){
  					  
  					   remanId1.splice(index);
  					   remanId1.push(reId);
  					   remaningQuatity1.splice(index);
  					   remaningQuatity1.push(remaningQuantity);			        
  					  
  						}else{
  							remaningQuatity1.push(remaningQuantity);	
  							  remanId1.push(reId);
  						}
  						indx=index;
  						
  						 updatetotalAmount(taxper,index);
  						
  				   }else{
  					  
  					  setTripArrayDataBlankForIndex(index);
  					
				}	
  	 }
   
  function sendToServer() {

			var invoiceDa = document.getElementById("invoiceType").value;
		if (invoiceDa === "" || invoiceDa === null || invoiceDa === '') {
            Toast.fire({
                type: 'error',
                title: 'Invoice Type is Mandatory !'
            });
            document.getElementById("invoiceType").focus();
            return "";
        }
    	
    	var invoiceNu = document.getElementById("invoiceAmount").value;
		if (invoiceNu === "" || invoiceNu === null || invoiceNu === '') {
            Toast.fire({
                type: 'error',
                title: 'Invoice Amount is Mandatory !'
            });
            document.getElementById("invoiceAmount").focus();
            return "";
        }
		var invoiceNu1 = document.getElementById("tradingPartner").value;
		if (invoiceNu1 === "" || invoiceNu1 === null || invoiceNu1 === '') {
            Toast.fire({
                type: 'error',
                title: 'Trading Partner is Mandatory !'
            });
            document.getElementById("tradingPartner").focus();
            return "";
        }
		var invoiceNu2 = document.getElementById("supplierNum").value;
		if (invoiceNu2 === "" || invoiceNu2 === null || invoiceNu2 === '') {
            Toast.fire({
                type: 'error',
                title: 'Supplier Number is Mandatory !'
            });
            document.getElementById("supplierNum").focus();
            return "";
        }
		var invoiceNu2 = document.getElementById("glDate").value;
		if (invoiceNu2 === "" || invoiceNu2 === null || invoiceNu2 === '') {
            Toast.fire({
                type: 'error',
                title: 'GL Date is Mandatory ! '
            });
            document.getElementById("glDate").focus();
            return "";
        }
		var invoiceNu3 = document.getElementById("termsDate").value;
		if (invoiceNu3 === "" || invoiceNu3 === null || invoiceNu3 === '') {
            Toast.fire({
                type: 'error',
                title: 'Terms Date is Mandatory !'
            });
            document.getElementById("termsDate").focus();
            return "";
        }
		var invoiceNu4 = document.getElementById("terms").value;
		if (invoiceNu4 === "" || invoiceNu4 === null || invoiceNu4 === '') {
            Toast.fire({
                type: 'error',
                title: 'Terms is Mandatory !'
            });
            document.getElementById("terms").focus();
            return "";
        }
		var invoiceNu5 = document.getElementById("remitToBankAccountName").value;
		if (invoiceNu5 === "" || invoiceNu5 === null || invoiceNu5 === '') {
            Toast.fire({
                type: 'error',
                title: 'Remit To Bank Account Name is Mandatory !'
            });
            document.getElementById("remitToBankAccountName").focus();
            return "";
        }
		var invoiceNu6 = document.getElementById("remitToBankAccountNumber").value;
		if (invoiceNu6 === "" || invoiceNu6 === null || invoiceNu6 === '') {
            Toast.fire({
                type: 'error',
                title: 'Remit To bank Account Number is Mandatory !'
            });
            document.getElementById("remitToBankAccountNumber").focus();
            return "";
        }
		
		
		var invoiceNu7 = document.getElementById("lineType").value;
		if (invoiceNu7 === "" || invoiceNu7 === null || invoiceNu7 === '') {
            Toast.fire({
                type: 'error',
                title: 'Line Type  is Mandatory !'
            });
            document.getElementById("lineType").focus();
            return "";
        }
		var invoiceNu8 = document.getElementById("account").value;
		if (invoiceNu8 === "" || invoiceNu8 === null || invoiceNu8 === '') {
            Toast.fire({
                type: 'error',
                title: 'Account  is Mandatory !'
            });
            document.getElementById("account").focus();
            return "";
        }
		var invoiceNu9 = document.getElementById("glDateDistributionDate").value;
		if (invoiceNu9 === "" || invoiceNu9 === null || invoiceNu9 === '') {
            Toast.fire({
                type: 'error',
                title: 'GL Date  is Mandatory !'
            });
            document.getElementById("glDateDistributionDate").focus();
            return "";
        }
		var invoiceNu10 = document.getElementById("amount").value;
		if (invoiceNu10 === "" || invoiceNu10 === null || invoiceNu10 === '') {
            Toast.fire({
                type: 'error',
                title: 'Amount  is Mandatory !'
            });
            document.getElementById("amount").focus();
            return "";
        }
		var invoiceNu10a = document.getElementById("InvoiceUpload").value;
		if (invoiceNu10a === "" || invoiceNu10a === null || invoiceNu10a === '') {
            Toast.fire({
                type: 'error',
                title: 'Invoice doc is Mandatory !'
            });
            document.getElementById("InvoiceUpload").focus();
            return "";
        }
		var invoiceNu10b = document.getElementById("DocumentFileOne").value;
		if (invoiceNu10b === "" || invoiceNu10b === null || invoiceNu10b === '') {
            Toast.fire({
                type: 'error',
                title: 'Summary Sheet is Mandatory !'
            });
            document.getElementById("DocumentFileOne").focus();
            return "";
        }
			
		
		  if(quntityflag.length==0){
		  		Toast.fire({
		              type: 'error',
		              title: 'Quantity Invoiced  is Mandatory !'
		         	 });	
		  		 return "";
		  	}
		  	else if(quntityflag.length!=0){
				    	for(var i=0;i<quntityflag.length;i++){
				    	if(quntityflag[i]==0  ){
				    		Toast.fire({
				                type: 'error',
				                title: 'Quantity Invoiced  is Mandatory !'
				           	 });
				    		 return "";
				    		}
				    	}
		  	}
		 
         var stepOneObj = FormDataToJSON('stepOneForm');
        var stepTwoForm = FormDataToJSON('stepTwoForm');

        const finalObj = {
            ...stepOneObj,
            ...stepTwoForm
        };
	console.log();
    

    var matchOption=$("#matchOption").val() ;
    
	var count=0;
   
    
    for(var i=0;i<tripLineArray.length;i++){
     delete tripLineArray[i].id
     delete tripLineArray[i].amount
     delete tripLineArray[i].price;
     count=parseFloat(count)+parseFloat(tripLineArray[i].quantity);
    };
     finalObj.poInvoiceLine=tripLineArray; 
     finalObj.matchOption=matchOption;
	console.log();
 
     
     console.log(finalObj);
	 flag=0;
     if(count==0){
     	flag=1;
     }
	
     
   var invoiceno= document.getElementById("invoiceNumber").value;
   var poNumber= document.getElementById("poNumber").value;
     for(var i=0;i<remaningQuatity1.length;i++){
    
		 var obj = {
		            "remaningQuatity" : remaningQuatity1[i],
		  			"poNumber" : poNumber,
		  			"lineNumberpo" : lineNum1[i],
		  			"flag" : flag
		        }
		   
    
	  $.ajax({
        type: "POST",
        data: JSON.stringify(obj),
        url: "<%=GlobalUrl.updateRemaningQuantitydraft%>",
        dataType: "json",
        contentType: "application/json",
        async: false,
        success: function(data) {

        }
	  });

 }
     
     var invoiceDate= document.getElementById("invoiceDate").value;
     finalObj.grossTotalAmt=tripLineArray.grossTotalAmt;
     finalObj.invoiceDate=invoiceDate;
     
     finalObj.glDate;
     finalObj.termsDate;
    finalObj.supplierInvoiceDate;
     
     
   
     	
    	 var glDate=  $('#glDate').val().split(" ");
    	 
    	 finalObj.glDate=glDate[0];
		
		
		var termsDate=   $('#termsDate').val().split(" ");
        
		  finalObj.termsDate=termsDate[0];
         	
        
		
       	 var supplierInvoiceDate=  $('#supplierInvoiceDate').val().split(" ");
         
  
       	 finalObj.supplierInvoiceDate=supplierInvoiceDate[0];
  
     
    
		
        
        console.log(finalObj);

		     if(count==0){
		     	swal.fire("Alert", "Expired PO Please Delete", "warning");
		     	 return "";
		     	 
		     }else{
        
			        $.ajax({
			            type: "POST",
			            data: JSON.stringify(finalObj),
			            url: "<%=GlobalUrl.savePoInvoice%>",
			            dataType: "json",
			            contentType: "application/json",
			            success: function(response) {
			
			            	 if (response.msg == 'success') {
			                     swal.fire("Thanks", "Invoice Process Sucessfully", "success", "OK").then(function() {
			                    	 window.opener.refereshList();
			                         window.close();
			                     });
			                     
			                     
			                     setTimeout(function(response) {
			
			                     }, 2000);
			                 } else {
			                    alert("failed");
			                }
			            },
			            error: function(jqXHR, textStatue, errorThrown) {
			                Swal.fire({
			                    icon: 'error',
			                    title: 'Oops...',
			                    text: 'Something went wrong!',
			                })
			            }
			        });
		     }
    }


			var poLineArray=[];
			function inactiveActiveDeleteData(indexc){
	  
	
				  lineNumberArray.push(tripLineArray[indexc].lineNumber);
				  
				  for(var i=0; i<lineNumberArray.length; i++){
					  
				  $('#tripList').empty();
				  $('#tripList').append($('<option/>').attr("value","").text("Select Line Number"));
				  for(var k=0; k<lineNumberArray.length; k++){
					  
				  $('#tripList').append($('<option value="' + k + '" />').attr("value",lineNumberArray[k]).text(lineNumberArray[k]));
				  
				  }
				  }  
				  tripLineArray.splice(indexc,1);
				  showDatatbleData(tripLineArray);
				  var taxper = $("#taxper_"+indexc).val();
				  
	
}
 

  const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000
  }); 

  function handleFileSelect(evt, id) {
      var f = evt.target.files[0]; // FileList object
      var reader = new FileReader();
      // Closure to capture the file information.
      reader.onload = (function(theFile) {
          return function(e) {
              var binaryData = e.target.result;
              //Converting Binary Data to base 64
              var base64String = window.btoa(binaryData);
              //showing file converted to base64
              $("#" + id).val(base64String);
          };
      })(f);
      reader.readAsBinaryString(f);
  }

  function onValidateFile(id) {
      var fileInput3 = document.getElementById(id).value;
      var gst = document.getElementById(id);
      var allowedExtensions = /(\.jpg|\.jpeg|\.pdf)$/i;

      if (typeof(gst.files) != "undefined") {

          const fsize = gst.files.item(0).size;
          const file = Math.round((fsize / 1024));
          if (file > ${maxFileSize}) {
              swal.fire("", "File should less than 5 MB.", "warning");
              $("#" + id).val("");
          } else {
              var ext = fileInput3.split(".")[1];
              if (ext == "pdf" || ext == "jpg" || ext == "JPEG" || ext == "JPG" || ext == "jpeg" || ext == "PDF") {} else {
                  swal.fire("", "Select Only JPEG & PDF File.", "warning");
                  $("#" + id).val("");
                  return false;
              }
          }
      } else {
          alert("This browser does not support HTML5.");
      }
  }
  
  function onValidateFileOne(id) {
      var fileInput3 = document.getElementById(id).value;
      var gst = document.getElementById(id);
      var allowedExtensions = /(\.pdf|\.doc|\.docx|\.xls|\.xlsx)$/i;

      if (typeof(gst.files) != "undefined") {

          const fsize = gst.files.item(0).size;
          const file = Math.round((fsize / 1024));
          if (file > ${maxFileSize}) {
              swal.fire("", "File should less than 5 MB.", "warning");
              $("#" + id).val("");
          } else {
              var ext = fileInput3.split(".")[1];
              if (ext == "pdf" || ext == "PDF" || ext == "docx" || ext == "DOCX" || ext == "doc" || ext == "DOC" ||  ext == "xls" || ext == "XLS" || ext == "xlsx" || ext == "XLSX") {} else {
                  swal.fire("", "Select Only DOC, XLSX & PDF File.", "warning");
                  $("#" + id).val("");
                  return false;
              }
          }
      } else {
          alert("This browser does not support HTML5.");
      }
  }

    
    </script>
</body>

</html>
