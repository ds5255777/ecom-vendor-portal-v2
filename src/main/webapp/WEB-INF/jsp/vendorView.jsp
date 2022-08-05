<%@ page import="com.main.commonclasses.GlobalConstants" %>
<%@ page import="com.main.commonclasses.GlobalUrl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head lang="en">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titleName}|VendorView</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/sweetalert2/sweetalert2.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
    <style>
    	 .split {
                height: 100%;
                width: 50%;
                position: fixed;
                z-index: 1;
                top: 0;
                overflow-x: hidden;
            }

            .left {
                left: 0;
            }

            .right {
                right: 0;
            }
            
            div.fixed {
                position: fixed;
                bottom: 10px;
                width:50%;
                border: 1px solid black;
            } 

            .modalLoad {
                display:    none;
                position:   fixed;
                z-index:    1000;
                top:        0;
                left:       0;
                height:     100%;
                width:      100%;
                background: rgba( 255, 255, 255, .8 ) 
                    url('http://i.stack.imgur.com/FhHRx.gif') 
                    50% 50% 
                    no-repeat;
            }

            body.loading .modal {
                overflow: hidden;   
            }

            body.loading .modal {
                display: block;
            }
    
        .table td,
        .table th {
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
    <div class="split left wrapper">
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
			<h5 style=" color: white;">Vendor Onboarding Process</h5>
            <ul class="navbar-nav ml-auto">
                <p class="float-sm-right" style="color: white;">
                    <b>Process ID : </b> <input type="text" id="pid" name="pid" readonly style="background: #007BFF; color: white; border: 0px;">
                </p>
            </ul>
        </nav>

        <div class="content-wrapper" style="margin-left: 0px !important;">
            <section class="content" style="overflow: hidden;">
                <div class="container-fluid">
                    <div class="card card-primary" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Basic Details</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="stepOneForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Introducer Name<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="introducedByName" id="introducedByName" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Introducer Email ID<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text"  name="introducedByEmailID" id="introducedByEmailID" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Business Partner Name<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="suppName" id="suppName" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Business Classification<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                            <input type="text" class="form-control-sm" name="businessClassification" id="businessClassification" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">MESME Certificate Number</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="mesmeNumber" id="mesmeNumber" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Aadhar Number</label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="aadharNumber" id="aadharNumber" type="text"  style="width: 100%;" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Pan Number<span class="text-danger"> </span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="panNumber" id="panNumber" type="text"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">TAN Number<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="tanNumber" id="tanNumber" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Aadhar Link Status<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="adharLinkStatus" id="adharLinkStatus" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Section Type<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="sectionType" id="sectionType" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Address Book</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                            <div class="card-body" style="overflow: auto;">
								<div class="col-md-12">
									<div class="table-responsive">
										<table id="addTable" class="display nowrap table table-bordered" style="width:100%">
		                                    <thead>
											<tr>
												<th class="bg-primary">Vendor Type</th>
												<th class="bg-primary">Vendor Category</th>
												<th class="bg-primary">Country</th>
												<th class="bg-primary">State</th>
												<th class="bg-primary">District</th>
												<th class="bg-primary">Postal Code/ ZIP Code</th>
												<th class="bg-primary">Address Details</th>
												<th class="bg-primary">GSTN Number</th>
												<th class="bg-primary">Supplier Site Code</th>
												<th class="bg-primary">GL Code</th>
											</tr>
										</thead>
		                                </table>
									</div>
								</div>
                            </div>
                    </div>
                    
                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Contact Details</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                            <div class="card-body" style="overflow: auto;">
								<div class="col-md-12">
									<div class="table-responsive">
										<table id="contactTable" class="display nowrap table table-bordered" style="width:100%">
		                                    <thead>
											<tr>
												<th class="bg-primary">First Name</th>
												<th class="bg-primary">Last Name</th>
												<th class="bg-primary">Phone Number</th>
												<th class="bg-primary">Email ID</th>
											</tr>
										</thead>
		                                </table>
									</div>
								</div>
                            </div>
                    </div>
                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Bank Details</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                            <div class="card-body" style="overflow: auto;">
								<div class="col-md-12">
									<div class="table-responsive">
										<table id="bankTable" class="display nowrap table table-bordered" style="width:100%">
		                                    <thead>
											<tr>
												<th class="bg-primary">Bank Name</th>
												<th class="bg-primary">Account Number</th>
												<th class="bg-primary">Beneficiary Name</th>
												<th class="bg-primary">IFSC Code</th>
												<th class="bg-primary">Currency</th>
											</tr>
										</thead>
		                                </table>
									</div>
								</div>
                            </div>
                    </div>
                    
                    
                    <div class="card card-primary" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Invoice Payment Terms</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="stepTwoForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Currency<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="invoiceCurrency" id="invoiceCurrency" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Currency<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="paymentCurrency" id="paymentCurrency" style="width: 100%;"> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment / Credit Terms<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                            <input type="hidden" id="id" name="id" disabled>
                                                <input type="text" name="creditTerms" id="creditTerms" readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Payment Method<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text"  name="paymentMethod" id="paymentMethod" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Terms Date Basis<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text"  name="dateBasis" id="dateBasis" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Delivery Terms<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="deliveryTerms" id="deliveryTerms" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="card card-primary" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">TDS Details</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="stepThreeForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">TDS Applicable<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="tdsApplication" id="tdsApplication" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">TDS Section<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="tdsSection" id="tdsSection" style="width: 100%;"> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">TDS Exemption Rate %<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="tdsRate" id="tdsRate" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    
                    <div class="card card-primary" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">ITR Details</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="stepFourForm" class="forms-sample">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Financial Year1<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="fyYear1" id="fyYear1" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Acknowledgement Number1<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text"  name="acknowledgementNumber1" id="acknowledgementNumber1" style="width: 100%;"> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Financial Year2<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="fyYear2" id="fyYear2" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Acknowledgement Number2<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="acknowledgementNumber2" id="acknowledgementNumber2" style="width: 100%;"> 
                                            </div>
                                        </div>
                                    </div><div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Financial Year3<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly name="fyYear3" id="fyYear3" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Acknowledgement Number3<span class="text-danger"></span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="acknowledgementNumber3" id="acknowledgementNumber3" style="width: 100%;"> 
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                </div>
                            </form>
                        </div>
                    </div>

					<div class="card card-primary" id="queryWindow"
						style="display: block;" style="margin-top: 1rem;">
						<div class="card-header" style="padding: 5px 5px 0px 5px;">
							<h4 class="card-title">Remarks</h4>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" style="margin-right: 10px;">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<form id="queryForm" class="forms-sample">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row">
											<label class="col-sm-3">Remarks <span
												class="text-danger"></span></label>
											<div class="col-sm-9">
												<textarea class="form-control" id="comment" name="comment"
													rows="3" maxlength="250" placeholder="Remarks if Any"></textarea>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					
                    <div class="row">
                        <div class="col-md-3" style="display: no	ne;" id="prosInvBtn">
                            <button type="button" id="approve" style="margin-right: 10px; width: inherit" class="btn btn-success btn-lg" >Approve Request</button>
                        </div>
                        
                        <div class="col-md-3" style="display: none;" id="rejectInvBtn">
                            <button type="button" id="rejected" style="margin-right: 10px; width: inherit"  class="btn btn-danger btn-lg" >Rejected Request</button>
                        </div>

                        <div class="col-md-3" style="display: none;" id="raiseQueryDiv">
                            <button type="button" id="raiseQuery" style="margin-right: 10px; width: inherit" value="raiseQuery" onclick="raiseQueryModel()" class="btn btn-warning btn-lg">Raise
                                Query</button>
                        </div>

                        <div class="col-md-3" >
                            <button type="button" onclick="closeWin()" style="margin-right: 10px; width: inherit" class="btn btn-info btn-lg">Close</button>
                        </div>
                    </div>
                    
                    <div class="card card-primary" style="margin-top: 1rem;">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Remarks List</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
							<form id="queryForm" class="forms-sample">
								<div class="col-md-12">

									<div class="table-responsive">
										<table
											class="table table-bordered table-hover"
											id="tabledataQuery">
											<thead>
												<tr>
													<th class="bg-primary"  >S.No</th>
													<th class="bg-primary"  >Raised By</th>
													<th class="bg-primary">Role/Department</th>
													<th class="bg-primary" >Raised On</th>
													<th class="bg-primary" >Remarks</th>
												</tr>
											</thead>
											<tbody>

											</tbody>
										</table>
									</div>
								</div>
							</form>
						</div>
                    </div>
                </div>
            </section>
        </div>

        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>
    
		<div class="split right">
        	 <div class="form-group">
            <label for="doc">Document Details</label>
                <select class="form-control" id="multipleAttachment" onchange="displayAttachmentForPoDetails()" style="height: 35px;" >
                                                
                                            </select>
                                            </div>
                <a id="ifrmameHref"   target="_blank">Click Here to open doc in new window</a>
                <iframe id="pdfLink" style="height:90%; width:100%" title="Navigation menu" ></iframe>
   		 </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="dist/js/adminlte.min.js"></script>
    <script src="dist/js/demo.js"></script>
    <script src="js/commonFunctions.js"></script>
     <script src="js/common.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>
    <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
    <script src="plugins/jquery-validation/additional-methods.min.js"></script>
    <script src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
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
    <script src="plugins/select2/js/select2.full.min.js"></script>

    <script>
    
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
    });
        var addTable = $("#addTable").DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });
        
        var contactTable = $("#contactTable").DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });
        
        var bankTable = $("#bankTable").DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });
        
        var tabledataQuery = $('#tabledataQuery').DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": []
        });
        
        var processId = '${pid}';
        
        console.log(processId);
        
        var vendorType = '${vendorType}';
        
        console.log(vendorType);
        
        $("input[type=text]").prop('disabled', true);
        
        showHideButton();
        function showHideButton(){
        	if( vendorType =="Approved Vendor" || vendorType =="Rejected Vendor" || vendorType =="Vendor View"){
        		$("#prosInvBtn").css("display","none");
        		$("#queryWindow").css("display","none");
        		$("#viewAttachmentDiv").css("display","block");
        		
        	}
        	else if( vendorType =="Pending Vendor" || vendorType =="Query Vendor"  ){
        		$("#prosInvBtn").css("display","block");
        		$("#raiseQueryDiv").css("display","block");
        		$("#rejectInvBtn").css("display","block");
        		$("#queryWindow").css("display","block");
        		$("#viewAttachmentDiv").css("display","block"); 
        	}
        }

        function closeWin() {
            window.close()
        }
        
        loadVendorDetails();
        function loadVendorDetails() {
        	

            var obj = {
                "pid": processId,
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.updateVendorRegistrationStatus%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {
                    if (data.msg == 'success') {
                        var result = data.data;
                        var accountDetail=result.accountDetails;
                        var addressDetails=result.addressDetails;
                        var contactDetails=result.contactDetails;
                        var myForm = "";
                        var myFormOne = "";
                        var myFormTwo = "";
                        var myFormThree = "";
                        
                        
                        myForm = document.getElementById("stepOneForm");
                        myFormOne = document.getElementById("stepTwoForm");
                        myFormTwo = document.getElementById("stepThreeForm");
                        myFormThree = document.getElementById("stepFourForm");
                        
                        setData(myForm, result);
                        setData(myFormOne, result);
                        setData(myFormTwo, result);
                        setData(myFormThree, result);
                        
                        $("#tanNumber").val(result.tanNumber);
                        $("#pid").val(result.pid);
                        $("#acknowledgementNumber1").val(result.acknowledgementNumber1);
                        addTable.clear();
                        for (var i = 0; i < addressDetails.length; i++) {
                        	
                        	if(!addressDetails[i].hasOwnProperty("vendorType")){
       							addressDetails[i].vendorType="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("partnerType")){
       							addressDetails[i].partnerType="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("addCountry")){
       							addressDetails[i].addCountry="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("state")){
       							addressDetails[i].state="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("city")){
       							addressDetails[i].city="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("pinCode")){
       							addressDetails[i].pinCode="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("addDetails")){
       							addressDetails[i].addDetails="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("compGstn")){
       							addressDetails[i].compGstn="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("supplierSiteCode")){
       							addressDetails[i].supplierSiteCode="-";
       						}
                        	if(!addressDetails[i].hasOwnProperty("glCode")){
       							addressDetails[i].glCode="-";
       						}
                           
                        	addTable.row.add([
                        		addressDetails[i].vendorType,
                        		addressDetails[i].partnerType,
                        		addressDetails[i].addCountry,
                        		addressDetails[i].state, 
                        		addressDetails[i].city, 
                        		addressDetails[i].pinCode,
                        		addressDetails[i].addDetails,
                        		addressDetails[i].compGstn,
                        		addressDetails[i].supplierSiteCode,
                        		addressDetails[i].glCode 
                        		]);
                        }
                        addTable.draw();
                        $("tbody").show();
                        
                        bankTable.clear();
                        for (var i = 0; i < accountDetail.length; i++) {
                        	
                        	if(!accountDetail[i].hasOwnProperty("bankName")){
       							accountDetail[i].bankName="-";
       						}
                        	if(!accountDetail[i].hasOwnProperty("accoutNumber")){
       							accountDetail[i].accoutNumber="-";
       						}
                        	if(!accountDetail[i].hasOwnProperty("beneficiaryName")){
       							accountDetail[i].beneficiaryName="-";
       						}
                        	if(!accountDetail[i].hasOwnProperty("ifscCode")){
       							accountDetail[i].ifscCode="-";
       						}
                        	if(!accountDetail[i].hasOwnProperty("accoutCurrency")){
       							accountDetail[i].accoutCurrency="-";
       						}
                           
                        	bankTable.row.add([
                        		accountDetail[i].bankName,
                        		accountDetail[i].accoutNumber,
                        		accountDetail[i].beneficiaryName,
                        		accountDetail[i].ifscCode, 
                        		accountDetail[i].accoutCurrency 
                        		]);
                        }
                        bankTable.draw();
                        $("tbody").show();
                        
                        contactTable.clear();
                        for (var i = 0; i < contactDetails.length; i++) {
                           
                        	if(!contactDetails[i].hasOwnProperty("conFname")){
       							contactDetails[i].conFname="-";
       						}
                        	if(!contactDetails[i].hasOwnProperty("conLname")){
       							contactDetails[i].conLname="-";
       						}
                        	if(!contactDetails[i].hasOwnProperty("conPhone")){
       							contactDetails[i].conPhone="-";
       						}
                        	if(!contactDetails[i].hasOwnProperty("conEmail")){
       							contactDetails[i].conEmail="-";
       						}
                        	
                        	contactTable.row.add([
                        		contactDetails[i].conFname,
                        		contactDetails[i].conLname, 
                        		contactDetails[i].conPhone, 
                        		contactDetails[i].conEmail]);
                        }
                        contactTable.draw();
                        $("tbody").show();
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
        
        getQueryData();
		 
		 function getQueryData(){
			 
			 var obj ={
						"referenceid": processId,
						"type": "Registration"
				}
				
				$.ajax({
					type : "POST",
					url : "<%=GlobalUrl.getQueryByTypeAndForeignKey%>",
					data :JSON.stringify(obj),
					dataType : "json",
					contentType : "application/json",
					success : function(response) {
						if (response.msg == "success") {
						
							if("data" in response){
							
								var result = response.data;												
								
							     	tabledataQuery.clear();
							     	var count=0;
				                        for (var i = 0; i < result.length; i++) {
				                        	if(!result[i].hasOwnProperty("raisedBy")){
				                               	result[i].raisedBy="";
				                               }
				                                             if(!result[i].hasOwnProperty("role")){
				                               	result[i].role="";
				                               }
				                                             if(!result[i].hasOwnProperty("raisedOn")){
				                               	result[i].raisedOn="";
				                               }
				                                             if(!result[i].hasOwnProperty("comment")){
				                               	result[i].comment="";
				                               }                    
				                        count++;
				                        tabledataQuery.row.add([count,result[i].raisedBy, result[i].role, result[i].raisedOn, result[i].comment]);
				                        }
				                        tabledataQuery.draw();
				                        $("tbody").show();
								}
						} else {
							Toast.fire({
								type : 'error',
								title : 'Failed ..'
							})
						}
					},
					error : function(jqXHR, textStatue, errorThrown) {
						
						Toast.fire({
							type : 'error',
							title : 'Failed Added try again..'
						})

					}
				}); 
		 }
		 
		 function raiseQueryModel(){
				var query = document.getElementById("comment").value;
	            if (query === "" || query === null || query === '') {
	                Toast.fire({
	                    type: 'error',
	                    title: 'Please Insert Remarks'
	                });
	                document.getElementById("comment").focus();
	                return "";
	            }
	            
	            var finalObj={
	                    "comment": $("#comment").val(),
	                    "raisedAgainQuery": $("#pid").val(),
	                    "id": $("#id").val(),
	                    "type":"Registration"
	                    }
	            
	            console.log(finalObj);
	            $.ajax({
	                type: "POST",
	                data: JSON.stringify(finalObj),
	                url: "<%=GlobalUrl.saveQuery%>",
	                dataType: "json",
	                contentType: "application/json",
	                success: function(response) {

	                    if (response.msg == 'success') {
	                        swal.fire("", "Remarks Sucessfully Submitted", "success", "OK").then(function() {
	                        	window.opener.refereshList();
	                            window.close(); 
	                        });
	                        setTimeout(function(response) {}, 2000);
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
		 
		 $("#approve").click(function() {
	            var pid=  $("#pid").val();
	             Swal.fire({
	                      title: 'Are you sure to approve?',
	                            text: ""+pid,
	                      icon: 'warning',
	                      showCancelButton: true,
	                      confirmButtonColor: '#3085d6',
	                      cancelButtonColor: '#d33',
	                      confirmButtonText: 'Yes'
	                    }).then((result) => {
	                          let test=[1];
	                          test[0]=result;
	                          var val=Object.values(test[0])
	                      if (val=="true") {
	                            approveVendor(pid);
	                            
	                            
	                      }
	                    })
	       
	      });
		 
		 $("#rejected").click(function() {
	            var pid=  $("#pid").val();
	             Swal.fire({
	                      title: 'Are you sure to reject?',
	                            text: ""+pid,
	                      icon: 'warning',
	                      showCancelButton: true,
	                      confirmButtonColor: '#3085d6',
	                      cancelButtonColor: '#d33',
	                      confirmButtonText: 'Yes'
	                    }).then((result) => {
	                          let test=[1];
	                          test[0]=result;
	                          var val=Object.values(test[0])
	                      if (val=="true") {
	                    	  rejectedVendor(pid);
	                            
	                            
	                      }
	                    })
	       
	      });
		 
		  function approveVendor(pid){
			 
			 var finalObj={
					 "pid":pid
			 }
			 
			 $.ajax({
	                type: "POST",
	                data: JSON.stringify(finalObj),
	                url: "<%=GlobalUrl.approveRequest%>",
	                dataType: "json",
	                contentType: "application/json",
	                success: function(response) {

	                    if (response.msg == 'success') {
	                        swal.fire("", "Approved Vendor Request", "success", "OK").then(function() {
	                        	window.opener.refereshList();
	                            window.close(); 
	                        });
	                        setTimeout(function(response) {}, 2000);
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
		  
		 
		 function rejectedVendor(pid){
			 var finalObj={
					 "pid":pid
			 }
			 
			 $.ajax({
	                type: "POST",
	                data: JSON.stringify(finalObj),
	                url: "<%=GlobalUrl.rejectedRequest%>",
	                dataType: "json",
	                contentType: "application/json",
	                success: function(response) {

	                    if (response.msg == 'success') {
	                        swal.fire("", "Rejected Vendor Request", "success", "OK").then(function() {
	                        	window.opener.refereshList();
	                            window.close(); 
	                        });
	                        setTimeout(function(response) {}, 2000);
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

		 
		 function displayAttachmentForPoDetails(){
				
			 $('#multipleAttachment').empty();
			 
			 var obj ={
						"foreignKey": processId,
						"type": "Registration"
				}
			console.log(obj);
				$.ajax({
					type : "POST",
					url : "<%=GlobalUrl.getDocumentByTypeAndForeignKey%>",
					data :JSON.stringify(obj),
					dataType : "json",
					async: false,
					contentType : "application/json",
					success : function(response) {
						if (response.msg == "success") {
						
							if("data" in response){
							
								var result = response.data;												
								
								$('#multipleAttachment').append($('<option/>').attr("value", '').text("Select"));
								
								for (var i = 0; i < result.length; i++) {																						
									$('#multipleAttachment').append($('<option/>').attr("value", result[i].docPath).text(result[i].docName));			
								}
								 $("#viewAttachmentPopUp").modal('show'); 
								
							}else{
								Toast.fire({
									type : 'error',
									title : 'Attachment Not Available..'
								})
							}
						} else {
							Toast.fire({
								type : 'error',
								title : 'Failed ..'
							})
						}
					},
					error : function(jqXHR, textStatue, errorThrown) {
						
						Toast.fire({
							type : 'error',
							title : 'Failed Added try again..'
						})

					}
				}); 								 
			}
		
		 $("#multipleAttachment").change(function () {
			 
			 $("#pdfLink").contents().find("body").html(" ");
			    var fileName = $("#multipleAttachment option:selected").text();
			    
			    console.log("fileName from drop down >> " + fileName);
				var filePath = $("#multipleAttachment").val();
			    
				 fileName = encodeURIComponent(fileName);
			     filePath = encodeURIComponent(filePath);
					var urlpath = "getDoc" + "?name=" + fileName+ "&path=" + filePath;

					$('#pdfLink').attr('src', urlpath);
					$('#ifrmameHref').attr('href', urlpath);

				});
			
    </script>
</body>

</html>
