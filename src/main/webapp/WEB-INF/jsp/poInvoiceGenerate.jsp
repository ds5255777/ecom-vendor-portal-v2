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
<title>${titleName}|PO Invoice Generate</title>
<!-- Google Font: Source Sans Pro -->
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet" href="dist/css/ionicons.min.css">
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
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
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
#ui-datepicker-div {
	z-index: 1000 !important;
}
</style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse text-sm"
	onunload="javascript:refreshParent()">
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
							<h4 class="card-title">Basic Details</h4>
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
											<label class="col-sm-5">Supplier Invoice Number 
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
											<label class="col-sm-5">Invoice Type<span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												
													<select class="form-control-sm select2" style="width: 100%;"
													id="invoiceType" name="invoiceType" readonly>
													<option value="Standard" readonly>Standard</option>
													<option value="Credit Memo" readonly>Credit Memo</option>

												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">PO Number<span
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
													 class="form-control-sm" onchange="invoiceDateValidate()" placeholder="DD-MM-YYYY" style="width: 100%;">
											</div>
										</div>
									</div>



									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Currency <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<select class="form-control-sm select2" style="width: 100%;"
													id="invoiceCurrency" name="invoiceCurrency" readonly>
													<option value="INR" readonly>INR</option>

												</select>
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Invoice Amount <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												<input class="form-control-sm" type="text"
													placeholder="invoice Amount"
													onkeypress="return event.charCode >= 46 && event.charCode <= 57"
													maxlength="70" name="invoiceAmount" id="invoiceAmount"
													style="width: 100%;" readonly>
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
									<div class="col-md-3" style="display: none;">
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
											<label class="col-sm-5">Payment Currency<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">

												<select class="form-control-sm select2" style="width: 100%;"
													id="paymentCurrency" name="paymentCurrency" readonly>
													<option value="INR" readonly>INR</option>

												</select>
											</div>

										</div>
									</div>
									

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Terms Date<span
												class="text-danger"> *</span></label>
											<div class="col-sm-7">
												
													
												<input type="text" name="termsDate" id="termsDate" readonly
													 class="form-control-sm"  placeholder="DD-MM-YYYY" style="width: 100%;">
											
											</div>
										</div>
									</div>
									<div class="col-md-3"  >
										<div class="form-group row">
											<label class="col-sm-5">Payment / Credit
															Terms <span
												class="text-danger">*</span></label>
											<div class="col-sm-7">
												
													<select id="terms" name="terms" style="width: 100%;" 
														class="form-control-sm select2" 
														placeholder="Payment / Credit Terms" onchange="calTermsDate()"
														>
															<option value="">Select</option>
															<c:forEach items="${payment}" var="pay">

																<option value="${pay}">${pay}</option>
															</c:forEach>

													</select>
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5">Payment Method</label>
											<div class="col-sm-7">
											
													<select class="form-control-sm select2" style="width: 100%;"
													id="paymentMethod" name="paymentMethod" readonly>
													<option value="NEFT" readonly>NEFT</option>
													<option value="Cheque" readonly>Cheque</option>
													<option value="Online" readonly>Online</option>

												</select>
											</div>
										</div>
									</div>
									
									
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5" title="Remit To Bank Account Number">Remit To Bank Account
												<span class="text-danger">*</span>
											</label>
											<div class="col-sm-7">
												<select id="remitToBankAccountNumber" name="remitToBankAccountNumber" style="width: 100%;" onchange="calTermsDate()"
														class="form-control-sm select2" 
														placeholder=" Remit To bank account number"
														>
															<option value="">Select</option>
															<c:forEach items="${accountNumber}" var="pay">

																<option value="${pay}">${pay}</option>
															</c:forEach>

													</select>
											</div>
										</div>
									</div>


								


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
								<input type="hidden" id="grossamt">
							</div>
						</div>


						<!-- <div class="card-body" style="overflow: auto;"> -->

						<!-- </div> -->




						<div class="card-body" style="overflow: auto;">
						
													<form id="stepTwoForm" class="forms-sample">
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
						
						
							<table id="prTable" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
											S.No</th>
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
											Line Number</th>
									
										<th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Description</th>
										
										
										
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
								
									<div class="col-md-3">
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
									<div class="col-md-3">
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
									
							

									<div class="col-md-6">
										<div class="form-group row">
											<label class="col-sm-3">Remarks <span
												class="text-danger">*</span></label>
											<div class="col-sm-6">
												<textarea class="form-control" id="comment" name="comment"
													rows="1" placeholder="Remarks if Any"></textarea>
											</div>
											
											
											<div class="col-sm-3" id="raiseQueryDiv">
												<button type="button" id="raiseQuery" value="raiseQuery"
													onclick="raiseQueryModel()" class="btn btn-primary">Replay
												</button>
											</div>
										
											
										</div>
									</div>



								</div>
							</form>
						</div>
						<!-- /.card-body -->
					</div>	

					<div class="card card-primary" style="margin-top: 1rem; ">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Remarks List</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="queryForm" class="forms-sample">
								<table class="table table-bordered table-hover"
									id="tabledataQuery">
									<thead>
										<tr>
											<th style="padding: 5px 5px 5px 1.5rem;">S.No</th>
											<th style="padding: 5px 5px 5px 1.5rem;">Raised By</th>
											<th style="padding: 5px 5px 5px 1.5rem;">Raised On</th>
											<th style="padding: 5px 5px 5px 1.5rem;">Role</th>
											<th style="padding: 5px 5px 5px 1.5rem;">Remarks</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</form>
						</div>
					</div>

						<center>
							<div class="form-group">
								<label style="visibility: hidden;">Select </label>
								<button type="button" onclick="sendToServer()"
									class="btn btn-info">Submit Invoice</button>

								<label style="visibility: hidden;">Select</label>
								<button type="button" onclick="savedraftinvoice();"
									class="btn btn-info">Discard Invoice</button>

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
		<!-- /.content-wrapper -->

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>

	<script src="plugins/jquery/jquery.min.js"></script>
		<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
		<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
		<script>
			$.widget.bridge('uibutton', $.ui.button);
			$.widget.bridge('uitooltip', $.ui.tooltip);
		</script>
		<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
		<script src="js/commonFunctions.js"></script>
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

		<script src="plugins/datatables/jquery.dataTables.js"></script>
		<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
		<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
		<script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
		<script src="plugins/jszip/jszip.min.js"></script>
		<script src="plugins/pdfmake/pdfmake.min.js"></script>
		<script src="plugins/pdfmake/vfs_fonts.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
		<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
		

	<script>
	  const Toast = Swal.mixin({
          toast: true,
          position: 'top-end',
          showConfirmButton: false,
          timer: 3000
      }); 
	
	var currentDate="${invoiceDate}";
	
	
	  $('#invoiceDate').datepicker({
          dateFormat: 'dd-mm-yy',
          changeMonth: true,
          changeYear: true,
          maxDate: currentDate
      });
	
	  
	  
  var tripLineArray=[];
  var price1=[];
  var quanttty=[];
  var invoiceDate="${invoiceDate}";
  
    
    var  poNo='${PoNumber}';
    var  grosstotalamt=0;
  
   var quntityflag=[];
   
   var prTable = $('#prTable').DataTable({
		"paging" : false,
		"lengthChange" : false,
		"searching" : false,
		"info" : false,
		"autoWidth" : false,
		"aaSorting" : [],
		"scrollX" : false,
		"bSort" : false
		
	});
   

   var prTable1 = $("#tabledataQuery").DataTable({
       "paging": false,
       "lengthChange": false,
       "searching": false,
       "info": true,
       "autoWidth": false,
       "aaSorting": [],
       "scrollX": true,
       "pageLength": 15,
   });
   var lineNumberArray=[];
   
   getPoDetails();
   var id; 
   var lineNumber;
   var remaningQuat;
   
    function getPoDetails() {
    	var creidtTerms="${creidtTerms}"; 
    	$("#terms").val(creidtTerms);
    	
   	 var currentDate='${curentDate}';
 	
	 
  	  var terms =  $("#terms").val();
  	  
  	  
  	  if(terms=="Immediate Payments"){
	    		
			 var days=30;
				  var ts = new Date(currentDate);
				   
				  ts.setDate(ts.getDate());
				var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
            $("#termsDate").val(datestring);
        	
   	 } else if(terms=="NET 30 Days"){
  		
				 var days=30;
			   var ts = new Date(currentDate);
			   
			  ts.setDate(ts.getDate() + days);
			var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
			
           $("#termsDate").val(datestring);
       	
  	 }else if(terms=="NET 45 Days"){
  		 
 				 var days=45;
				   var ts = new Date(currentDate);
				   
				  ts.setDate(ts.getDate() + days);
				var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
				
				
	             $("#termsDate").val(datestring);
	         	
	    	
  	 }else if(terms=="NET 60 Days"){
  		 
				 var days=60;
			   var ts = new Date(currentDate);
			   
			  ts.setDate(ts.getDate() + days);
			var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
			
			
           $("#termsDate").val(datestring);
		 }else if(terms==""){
			 $("#termsDate").val("");
		 }

   	

    	
    	
    	
    	
    	
    	
    	
    	tripLineArray=[];
        var obj = {
            "poNo": poNo
        }
		
        $.ajax({
            type: "POST",
            data: JSON.stringify(obj),
            url: "<%=GlobalUrl.getAllPODetailsByPoNo%>",
            dataType: "json",
            contentType: "application/json",
            async: false,
            success: function(data) {

                if (data.msg == 'success') {
                    var result = data.data;
                    tripLineArray=result[0].poline;
                    for(var i=0;i<tripLineArray.length;i++){
                    	quntityflag.push("0");
                    }
                  
                 
                    
                    $('#supplierSite').val(result[0].supplierSite)
                     $('#operatingUnit').val(result[0].supplierSite)
                    
                    
                    
                     lineNumber= tripLineArray.lineNumber;
               
                 
        
                    
              
                 $('#poNumber').val('${PoNumber}'); 
                  
                    
                    $('#uom1').val( tripLineArray[0].uom);
                    $('#description1').val( tripLineArray[0].description);
                  
                    $('#invoiceCurrency').val(result[0].currency);  
                    $('#paymentCurrency').val(result[0].currency); 
                
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
	              // delete  lineNumberArray.[lineitemNo]
			
		  
	}

    
    
    
    
    
    
  function updatePOLineItem(key,index,value){
	  tripLineArray[index][key]=value;
	  console.log(tripLineArray);
  }
  
  function showDatatbleData(tripLineArray){
	  
	  
	  prTable.clear();
      for (var i = 0; i < tripLineArray.length; i++) {
      	 id=tripLineArray[i].id;
      	 price1[i]=tripLineArray[i].price;
      	 tripLineArray[i].unitPrice=tripLineArray[i].price;
      	quanttty[i]=tripLineArray[i].remaningQuatity;
      	// var remaningQuat;
      	 if(tripLineArray[i].remaningQuatity!=null){
      		 remaningQuat= tripLineArray[i].remaningQuatity;
      		 tripLineArray[i].quantity=tripLineArray[i].remaningQuatity;
      	 }else{
      		 remaningQuat=tripLineArray[i].quantity;
      	 }
      	 
      
		var date ='${curentDate}';
          var totalamot;
          var lineNumber= "<input type=\"text\" id=\"lineNumber_"+i+"\" readonly style=\"width: 80px; height: 28px;\" value=\"" + tripLineArray[i].lineNumber + "\"  class=\"form-control-sm \" \"> ";

          var description= "<input type=\"text\" id=\"description_"+i+"\" readonly style=\"width: 300px; height: 28px;\" oninput=\"updatePOLineItem('description','"+i+"',this.value)\" value=\"" + tripLineArray[i].description + "\" class=\"form-control-sm \" \"> ";
          var remaningQuantity= "<input type=\"text\" readonly id=\"remaningQuantity_"+i+"\" style=\"width: 120px; height: 28px;\" class=\"form-control-sm \" \"> ";
          var quantity= "<input type=\"text\" readonly style=\"width: 100px; height: 28px;\" value=\"" + remaningQuat + "\" class=\"form-control-sm \" \"> ";
          var quantityInvoiced= "<input type=\"text\" id=\"quantityInvoiced_"+i+"\" maxlength=\"40\" onkeypress=\"return event.charCode >= 48 && event.charCode <= 57  \" style=\"width: 120px; height: 28px;\" oninput=\"updatebaseaAmt('"+id+"','"+i+"',this.value)\" class=\"form-control-sm \" \"> ";
          var unitPrice= "<input type=\"text\" id=\"unitPrice_"+i+"\" readonly style=\"width: 100px; height: 28x;\" value=\"" + tripLineArray[i].price + "\"  class=\"form-control-sm \" \"> ";
          var uom= "<input type=\"text\" id=\"uom_"+i+"\" maxlength=\"40\" oninput=\"updatePOLineItem('uom','"+i+"',this.value)\" value=\"" + tripLineArray[i].uom + "\" style=\"width: 100px; height: 28px;\"  class=\"form-control-sm \" \"> ";
          var taxAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"  id=\"tax_"+i+"\" class=\"form-control-sm \" \"> ";
          var baseAmount= "<input type=\"text\" readonly style=\"width: 110px; height: 28px;\"   id=\"baseAmt_"+i+"\"   class=\"form-control-sm \" > ";
          var taxPercentage= "    <select  class=\"form-control-sm \" style=\"width: 67px; height: 28px;\" id=\"taxper_"+i+"\"  onchange=\"updatetotalAmount(this.value,'"+i+"')\" > <option value=\"0\" \">0%</option><option value=\"5\"  \">5%</option><option value=\"8\"  \">8%</option><option value=\"18\" \">18%</option><option value=\"28\" \">28%</option> </select > ";
          var totalAmount= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"totamt_"+i+"\" > ";
          var inactive = "<button type=\"button\"  class=\" btndeleterow\" style=\"color: #fff;background-color: #007bff; border-color: #007bff;box-shadow: none;\" data-placement=\"bottom\" onclick=\"inactiveActiveDeleteData(" + i + ")\"  data-original-title=\"Click To Delete\" > <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
          
			prTable.row.add([i + 1,lineNumber,description,quantity,remaningQuantity,quantityInvoiced,unitPrice,uom,taxPercentage,baseAmount,taxAmount,totalAmount,inactive]);
	  }
      
    var  grossamt= "<input type=\"text\" readonly class=\"form-control-sm \" style=\"width: 110px; height: 28px;\" id=\"grossAmt\" >";
      prTable.row.add(["","","","","","","","","","","Gross Total",grossamt,""]);
   
     
      prTable.draw();
     
      $("tbody").show();
         
      
      
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
  	
  	 tripLineArray[index].unitPrice=unitprice;
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
	  	$("#amount").val(grosstotalamt);
		$("#invoiceAmount").val(grosstotalamt);
	  	
	  	
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
	   //var allquantity = remaningQuat;
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
	  
  
  
  
  
  
    function setDraftInvoice() {

        var matchOption=$("#invoiceMatchoption").val() ;
 
         var stepOneObj = FormDataToJSON('stepOneForm');

        const finalObj = {
            ...stepOneObj,
            ...stepThreeObj
            
        };
        for(var i=0;i<tripLineArray.length;i++){
            delete tripLineArray[i].id
            delete tripLineArray[i].amount
            tripLineArray[i].quntity=quanttty[i];
           
           };
           
           
            finalObj.poInvoiceLine=tripLineArray;
            finalObj.invoiceNumber='${invoiceNumber}';
        	finalObj.matchOption=matchOption;

        
       		 console.log(finalObj);

        
				        $.ajax({
				            type: "POST",
				            data: JSON.stringify(finalObj),
				            url: "<%=GlobalUrl.saveDraftInvoice%>",
				            dataType: "json",
				            contentType: "application/json",
				            success: function(response) {
				
				            	
				
				            	 if (response.msg == 'success') {
				                     
				                    
				                     
				                     
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

   
    function sendToServer() {
    	
    	
    	
    	
    	console.log("..."+tripLineArray);
    	
    	var invoicedate = document.getElementById("invoiceDate").value;
		if (invoicedate === "" || invoicedate === null || invoicedate === '') {
            Toast.fire({
                type: 'error',
                title: 'Invoice Date is Mandatory !'
            });
            document.getElementById("invoiceDate").focus();
            return "";
        }
	
		var invoiceNu4 = document.getElementById("terms").value;
		if (invoiceNu4 === "" || invoiceNu4 === null || invoiceNu4 === '') {
            Toast.fire({
                type: 'error',
                title: 'Payment / Credit Terms is Mandatory !'
            });
            document.getElementById("terms").focus();
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
		
		
		var invoiceNu10a = document.getElementById("InvoiceUpload").value;
		if (invoiceNu10a === "" || invoiceNu10a === null || invoiceNu10a === '') {
            Toast.fire({
                type: 'error',
                title: 'Invoice doc is Mandatory !'
            });
            document.getElementById("InvoiceUpload").focus();
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
		
        
        var matchOption=$("#invoiceMatchoption").val() ;
       
        
        //itrDetailsArray.push(obj);

         var stepOneObj = FormDataToJSON('stepOneForm');
       // var stepThreeObj = FormDataToJSON('stepThreeForm');

        const finalObj = {
            ...stepOneObj
           
            
        };
        
       // var obj={};
       // obj.poInvoiceLine=tripLineArray;
        
       for(var i=0;i<tripLineArray.length;i++){
        delete tripLineArray[i].id
        delete tripLineArray[i].amount
        delete tripLineArray[i].price
       };
        finalObj.poInvoiceLine=tripLineArray;
        
        
    	var count=0;
        
        
        for(var i=0;i<tripLineArray.length;i++){
        	var receiptline=tripLineArray[i].receiptline;
        	
        	count=parseFloat(count)+parseFloat(tripLineArray[i].quantity);
        	
    		if (receiptline === "" || receiptline === null || receiptline === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Please Fill Receipt line'
                });
                document.getElementById("invoiceAmount").focus();
                return "";
            }

        }

        finalObj.matchOption=matchOption;
        
	console.log();
    
        
        console.log(finalObj);
        
        var terrDAte=$("#termsDate").val();
        
        var ts = new Date(terrDAte);
        
        finalObj.termsDate=ts;
//return;
	flag=0;
        if(count==0){
        	flag=1;
        }
		
      var invoiceno= document.getElementById("invoiceNumber").value;
      var poNumber= document.getElementById("poNumber").value;
        for(var i=0;i<remaningQuatity1.length;i++){
       
		 var obj = {
		            "remaningQuatity" : remaningQuatity1[i],
		            
		  			"id"  : remanId1[i],
		  			"poNumber" : poNumber,
		  			"flag" : flag
		        }
		   
        
	  $.ajax({
           type: "POST",
           data: JSON.stringify(obj),
            url: "<%=GlobalUrl.updateRemaningQuantity%>" , 
           dataType: "json",
           contentType: "application/json",
           async: false,
           success: function(data) {

            
           }
	  });
   
    }
    


        
        finalObj.grossTotalAmt=tripLineArray.grossTotalAmt;
        finalObj.invoiceNumber='${invoiceNumber}';
        
        
        for(var i=0;i<tripLineArray.length;i++){
            delete tripLineArray[i].id
            delete tripLineArray[i].amount
            tripLineArray[i].quntity=quanttty[i];
           
           };
           
           
            finalObj.poInvoiceLine=tripLineArray;
            finalObj.invoiceNumber='${invoiceNumber}';
        	finalObj.matchOption=matchOption;

        	   if (document.getElementById("InvoiceUpload").files.length > 0) {
                   finalObj.invoiceFileName = document.getElementById("InvoiceUpload").files.item(0).name;
                   finalObj.invoiceFileText = $("#InvoiceFileText").val();
               }
               if (document.getElementById("DocumentFileOne").files.length > 0) {
                   finalObj.documentFileOneName = document.getElementById("DocumentFileOne").files.item(0).name;
                   finalObj.documentFileOneText = $("#DocumentFileOneText").val();
               }
        
        
        if(count==0){
        	swal.fire("Alert", "Expired PO.", "warning");
        	
        	 return "";
        	 
        }else{
        
        
        $.ajax({
            type: "POST",
            data: JSON.stringify(finalObj),
             url: "<%=GlobalUrl.savePoInvoice%>" , 
            dataType: "json",
            contentType: "application/json",
            success: function(response) {

            	 if (response.msg == 'success') {
                     
                     swal.fire("Invoice Process Sucessfully", "Invoice Number : ${invoiceNumber} "  , "success", "OK").then(function() {
                    	 successflag=1;
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
  			  Discardinvoice();
    		function Discardinvoice(){

    		    
    	      
    	        var matchOption=$("#invoiceMatchoption").val() ;
    	       
    	        
    	       // itrDetailsArray.push(obj);

    	         var stepOneObj = FormDataToJSON('stepOneForm');
    	       
    	        const finalObj = {
    	            ...stepOneObj
    	           
    	            
    	        };
    	        finalObj.invoiceNumber='${invoiceNumber}';
    	        
    	        for(var i=0;i<tripLineArray.length;i++){
    	            delete tripLineArray[i].id
    	           // delete tripLineArray[i].amount
    	            tripLineArray[i].quntity=quanttty[i];
    	           
    	           };
    	        
    	        finalObj.poInvoiceLine=tripLineArray;
    	        
    	        var invoDate=$("#invoiceDate").val();
    	       
    	        var ts = new Date(invoDate);
    	        
    	        finalObj.termsDate=ts;
    	               
	        console.log(finalObj);
	
	        
	        $.ajax({
	            type: "POST",
	            data: JSON.stringify(finalObj),
	            url: "<%=GlobalUrl.saveDraftInvoice%>",
	            dataType: "json",
	            contentType: "application/json",
	            success: function(response) {

	            	

	            	 if (response.msg == 'success') {
	                     
	            		
	            		 
	                     
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
    
    		function savedraftinvoice(){
    			Discardinvoice();
    		 swal.fire("Save To Draft","Invoice Number : ${invoiceNumber} ", "success", "OK").then(function() {
            	
                 window.close();
                 
             });
    		}
    		
    		 function refreshParent() 
    	        {
    	            window.opener.location.reload(true);
    	        }
    	
    		 

    		  $(document).ready(function(){
    			  $('.btndeleterow').click(function(){
    			  $(this).closest('tr').remove();
    			  });
    			  });
    		  
    		   var poLineArray=[];
    		   var descriptionArray=[];
    		  function inactiveActiveDeleteData(indexc){
    			  
    		
    				  lineNumberArray.push(tripLineArray[indexc].lineNumber);
    				  descriptionArray.push(tripLineArray[indexc].description);
        			  
        			  for(var i=0; i<lineNumberArray.length; i++){
        				  
        			  $('#tripList').empty();
        			  $('#tripList').append($('<option/>').attr("value","").text("Select Line Number"));
        			  for(var k=0; k<lineNumberArray.length; k++){
        				  
        			  $('#tripList').append($('<option value="' + k + '" />').attr("value",lineNumberArray[k]).text(descriptionArray[k]));
        			  
        			  }
        			  }  
        			  tripLineArray.splice(indexc,1);
        			  showDatatbleData(tripLineArray);
        			  var taxper = $("#taxper_"+indexc).val();
    				  
    			 
            }
    		 
    		  
    		  

    	      
    		  
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
    	       function invoiceDateValidate(){
    	        	
    	    	   
    	    	   var inputvalues =  $("#invoiceDate").val();
   	            
    	           var length= inputvalues.length;
    	           if(length<10 || length>10 ){
    	        	   swal.fire("","Invalid Invoice Date", "warning");
    	        	   $("#invoiceDate").val("");
   	                return ;
    	           }
    	        }
    	      
    	       
    	  
    	      function calTermsDate(){
    	    	  var currentDate='${curentDate}';
    	    	
    	    	 
    	    	  var terms =  $("#terms").val();
    	    	  
    	    	  
    	    	  if(terms=="Immediate Payments"){
      	    		
        			 var days=30;
      				  var ts = new Date(currentDate);
      				   
      				  ts.setDate(ts.getDate());
      				var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
     	             $("#termsDate").val(datestring);
     	         	
     	    	 } else if(terms=="NET 30 Days"){
    	    		
       				 var days=30;
     				   var ts = new Date(currentDate);
     				   
     				  ts.setDate(ts.getDate() + days);
     				var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
     				
    	             $("#termsDate").val(datestring);
    	         	
    	    	 }else if(terms=="NET 45 Days"){
    	    		 
           				 var days=45;
         				   var ts = new Date(currentDate);
         				   
         				  ts.setDate(ts.getDate() + days);
         				var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
         				
         				
        	             $("#termsDate").val(datestring);
        	         	
        	    	
    	    	 }else if(terms=="NET 60 Days"){
    	    		 
       				 var days=60;
     				   var ts = new Date(currentDate);
     				   
     				  ts.setDate(ts.getDate() + days);
     				var datestring = ts.getDate()  + "-" + (ts.getMonth()+1) + "-" + ts.getFullYear() ;
     				
     				
    	             $("#termsDate").val(datestring);
	    		 }else if(terms==""){
	    			 $("#termsDate").val("");
	    		 }
    	    	  
    	      }
    	      
    	      var referenceid='${invoiceNumber}';
    	        function raiseQueryModel(){
    				var comment = document.getElementById("comment").value;
    				
    	            if (comment === "" || comment === null || comment === '') {
    	                Toast.fire({
    	                    type: 'error',
    	                    title: 'Please Insert Remarks'
    	                });
    	                document.getElementById("comment").focus();
    	                return "";
    	            }
    	            
    	            var obj = {
    	                    "comment": comment,
    	                    "referenceid": referenceid,
    	                    "role" : "Vendor"
    	                }
    	            
    	            $.ajax({
    	                type: "POST",
    	                data: JSON.stringify(obj),
    	                url: "<%=GlobalUrl.savePoInvoiceQuery%>",
    	                dataType: "json",
    	                contentType: "application/json",
    	                async: false,
    	                success: function(data) {

    	                    if (data.msg == 'success') {

    	                    	document.getElementById("comment").value='';
    	                        $('.loader').hide();
    	                        swal.fire("Thanks", "Sucessfully Submitted", "success", "OK")
    	                      
    						
    	                        getData();
    	                    } else {
    	                        $("#submitBtn").prop("disabled", false);
    	                        $('.loader').hide();

    	                        Toast.fire({
    	                            type: 'error',
    	                            title: 'Failed.. Try Again..'
    	                        })
    	                    }

    	                },
    	                error: function(jqXHR, textStatue, errorThrown) {
    	                    $("#submitBtn").prop("disabled", false);
    	                    $('.loader').hide();
    	                    alert("failed, please try again");
    	                }

    	            });
    	            
    	            
    	        } 
    	        
    	        getData();
    	         var referenceid='${invoiceNumber}';
    	        function getData(){
    	        	
    	        	 var obj = {
    	                    
    	                     "referenceid": referenceid
    	                 }
    	             
    	             $.ajax({
    	                 type: "POST",
    	                 data: JSON.stringify(obj),
    	                 url: "<%=GlobalUrl.getPoQueryData%>",
    	                 dataType: "json",
    	                 contentType: "application/json",
    	                 async: false,
    	                 success: function(data) {
    	                	 
    	                	

    	                     if (data.msg == 'success') {

    	                    	 $('#tabledataQuery').DataTable().clear();
    	                    	 var result = data.data;

                               	if(!result.hasOwnProperty("role")){
                               		result.role="";
        							}
                                   if(!result.hasOwnProperty("comment")){
                                	   result.comment="";
             						}
   								if(!result.hasOwnProperty("raisedOn")){
   									result.raisedOn="";
        							}
   								if(!result.hasOwnProperty("raisedBy")){
   									result.raisedBy="";
    							}
    	                    	 
    	                    	 for (var i = 0; i < result.length; i++) {
    	                    	 $('#tabledataQuery').DataTable().row.add([i+1,result[i].raisedBy, result[i].raisedOn,result[i].role ,result[i].comment]);
    	                    	 }
    	                    	   $('#tabledataQuery').DataTable().draw();
    	                           $("tbody").show();
    	                    	 
    	                     } else {
    	                         $("#submitBtn").prop("disabled", false);
    	                         $('.loader').hide();

    	                         Toast.fire({
    	                             type: 'error',
    	                             title: 'Failed.. Try Again..'
    	                         })
    	                     }

    	                 },
    	                 error: function(jqXHR, textStatue, errorThrown) {
    	                     $("#submitBtn").prop("disabled", false);
    	                     $('.loader').hide();
    	                     alert("failed, please try again");
    	                 }

    	             });
    	             

    	        }
    	       

    	      
    </script>
</body>

</html>
