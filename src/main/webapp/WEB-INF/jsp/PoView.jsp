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
    <title>${titleName}|Po Process</title>
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
    <style>
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

<body class="hold-transition sidebar-mini sidebar-collapse text-sm" onunload="javascript:refreshParent(); window.close();">
<jsp:include page="loader.jsp" />
    <div class="wrapper">
        <nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left: 0px !important; background: #007BFF; padding: 0px 4px 0px 0px;">
			<h5 style=" color: white;">&nbsp;  PO Details</h5>
            <ul class="navbar-nav ml-auto">
                <li>    PO Number :  <input type="text" id="ecomInvoiceNumber" name="ecomInvoiceNumber" value="${poNumber}" readonly style="background: #007BFF; color: white; border: 0px;"></li>
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
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">PO Number <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="PO Number" name="poNo" id="poNo" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Supplier Site <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" readonly placeholder="Supplier Site " name="supplierSite" id="supplierSite"   style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Ship To<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" placeholder="Ship To" name="shipTo" id="shipTo"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Bill To <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" placeholder="Bill To" name="billTo" id="billTo"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                 
                                    
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Buyer <span class="text-danger">*</span></label>
                                           <div class="col-sm-7">
                                                <input type="text" placeholder="Buyer" name="buyer" id="buyer"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Currency <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                          <input class="form-control-sm" type="text" placeholder="Currency" readonly name="currency" id="currency"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">UOM <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                          <input class="form-control-sm" type="text" placeholder="UOM" name="uom" id="uom" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Quantity<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="quantity" id="quantity"  placeholder="Quantity"readonly  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Need By Date<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="needByDate" id="needByDate" type="text" placeholder="Need By Date" readonly style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Charge Account<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="chargeAccount" id="chargeAccount" placeholder="Charge Account" readonly style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Org <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="org" id="org" placeholder="org" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Deliver To<span class="text-danger"> *</span></label>
                                          <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" name="deliverTo" id="deliverTo" readonly placeholder="Deliver To"  style="width: 100%;">
                                            </div>
                                            
                                        </div>
                                                                       

                                </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="card card-primary collapsed-card">
                    <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">PO Shipments</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool"  data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </div>
                        </div>
                        
                     <div class="card-body">
                            <form id="stepTwoForm" class="forms-sample">
                            
                            
                          		   <div class="row">
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Org <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Org" name="org2" id="org2" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">UOM <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="UOM" name="uom2" id="uom2"  readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Ship To<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" placeholder="Ship To" name="shipTo2" id="shipTo2"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                     <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Quantity <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" placeholder="Quantity" name="quantity2" id="quantity2"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                 
                                    
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Need By Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" placeholder="Need By Date" name="needByDate2" id="needByDate2"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Charge Account <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                      <input class="form-control-sm" type="text" placeholder="Charge Account" readonly="readonly" name="chargeAccount2" id="chargeAccount2"  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Amount <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                     <input class="form-control-sm" type="text" placeholder="Amount" name="amount" id="amount" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Match Approval Level<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="matchApprovalLevel" id="matchApprovalLevel"  placeholder="Match Approval Level" readonly  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Invoice Match option<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" name="invoiceMatchoption" id="invoiceMatchoption" type="text" readonly placeholder="Invoice Match option" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Accrue at Receipt flag<span class="text-danger"> *</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control-sm" name="accrueatReceiptflag" id="accrueatReceiptflag" readonly placeholder="Accrue at Receipt flag" style="width: 100%;" >
                                            </div>
                                        </div>
                                    </div>
                             
                                </div>					
                          			
                          							
                          		 </form>
                          </div>
                          </div>
                    
                    
                     <div class="card card-primary collapsed-card">
                    <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">PO Distribution</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </div>
                        </div>
                    
                    
                     <div class="card-body">
                            <form id="stepThreeForm" class="forms-sample">
                            
                            
                          							        
                          		   <div class="row">
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Item Type <span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Item Type " name="itemType" id="itemType" readonly style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                   
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Deliver To<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input class="form-control-sm" type="text" placeholder="Deliver To" name="deliverTo3" id="deliverTo3" readonly  style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group row">
                                            <label class="col-sm-5">Charge Account<span class="text-danger">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="poNumber" id="chargeAccount3"  readonly class="form-control-sm" style="width: 100%;">
                                            </div>
                                        </div>
                                    </div>
                               
                                 
                                </div>
                            </form>
                           </div>
                    
                    </div>
                    <div class="card card-primary">
                        <div class="card-header" style="padding: 5px 5px 0px 5px;">
                            <h4 class="card-title">Line Item's</h4>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" style="margin-right: 10px;">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                        <form id="stepThreeForm" class="forms-sample">
                            <div class="card-body" style="overflow: auto;">
                                <table id="prTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Line Number</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Item Type</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Item</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Category</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Description</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">UOM</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Quantity</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Remaning Quatity</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Price</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Need By Date</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Amount</th>
                                            <th style="padding: 5px 5px 5px 1.5rem;">Charge Account</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </form>
                        <!-- /.card-body -->
                    </div></div>
                    <!-- /.card -->
                    <center>
                        <div class="form-group">
                            
                            <button type="button" class="btn btn-primary" id="closeModal" onclick="closeWin()">Close</button>
                            
                             <c:choose>
                             <c:when test="${viewPage=='UnProcess'}">
                             <input id="flipToInvoice" type="submit" class="btn btn-primary" onclick="invoiceProcessing()" value="Flip to Invoice " />
                             </c:when>
                            </c:choose>
                        </div>
                         
                    </center>
                </div>
            </section>
        </div>
        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="dist/js/adminlte.min.js"></script>
    <script src="dist/js/demo.js"></script>
    <script src="js/commonFunctions.js"></script>
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
        
        function closeWin() {
            window.close()
        }
        var poNo = '${poNumber}';
        var tripLineArray = [];
        setInvoiceDetails();

        function setInvoiceDetails() {

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
                       var tripLineArray=result[0].poline;
                        var myForm = "";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result[0]);
                    
                        myForm = document.getElementById("stepTwoForm");
                        setData(myForm, result[0]);
                        
                        $('#org2').val(result[0].org)
                         $('#uom2').val(result[0].uom)
                          $('#shipTo2').val(result[0].shipTo)
                           $('#quantity2').val(result[0].quantity);
                        
                        $('#needByDate2').val(result[0].needByDate)
                        $('#chargeAccount2').val(result[0].chargeAccount)
                     
                        myForm = document.getElementById("stepThreeForm");
                        setData(myForm, result[0]);
                        $('#deliverTo3').val(result[0].deliverTo)
                        $('#chargeAccount3').val(result[0].chargeAccount)
                        
                  
                      
                        $('#prTable').DataTable().clear();
                         for (var i = 0; i < tripLineArray.length; i++) {
                            if (!tripLineArray[i].hasOwnProperty("lineNumber")) {
                                tripLineArray[i].lineNumber = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("itemType")) {
                                tripLineArray[i].itemType = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("item")) {
                                tripLineArray[i].item = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("category")) {
                                tripLineArray[i].category = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("description")) {
                                tripLineArray[i].description = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("uom")) {
                                tripLineArray[i].uom = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("quantity")) {
                                tripLineArray[i].quantity = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("price")) {
                                tripLineArray[i].price = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("needByDate")) {
                                tripLineArray[i].needByDate = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("amount")) {
                                tripLineArray[i].amount = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("chargeAccount")) {
                                tripLineArray[i].chargeAccount = "";
                            } if (!tripLineArray[i].hasOwnProperty("remaningQuatity")) {
                                tripLineArray[i].remaningQuatity = "";
                            }
                            
                            $('#prTable').DataTable().row.add([tripLineArray[i].lineNumber, tripLineArray[i].itemType, tripLineArray[i].item, tripLineArray[i].category, tripLineArray[i].description, tripLineArray[i].uom, tripLineArray[i].quantity,tripLineArray[i].remaningQuatity ,tripLineArray[i].price, tripLineArray[i].needByDate, tripLineArray[i].amount, tripLineArray[i].chargeAccount]);
                        }
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
                    Toast.fire({
                        type: 'error',
                        title: 'Failed.. Try Again..'
                    })
                }
            });
        }
        
        function invoiceProcessing() {
        	
        	var a=$("#poNo").val();
        	var b=$("#supplierSite").val();
        	var c=$("#shipTo").val();
        	var d=$("#billTo").val();
        	var e=$("#buyer").val();
        	var f=$("#currency").val();
        	
        	var g=$("#uom").val();
        	var h=$("#quantity").val();
        	var i=$("#needByDate").val();
        	var j=$("#chargeAccount").val();
        	var k=$("#org").val();
        	var l=$("#deliverTo").val();
        	
        	var m=$("#amount").val();
        	var n=$("#matchApprovalLevel").val();
        	var o=$("#invoiceMatchoption").val();
        	var p=$("#accrueatReceiptflag").val();
        	var q=$("#itemType").val();
        
        	
        	if(a==""|| a==null){
        		 a="Po Number,";	
        	}else{
        		a="";
        	}if(b==""|| b==null){
        		 b="Supplier Site,";	
        	}else{
        		b="";
        	}if(c==""|| c==null){
        		 c="Ship To,";
        	}else{
        		c="";
        	}if(d==""|| d==null){
        		d="Bill To,";
        	}else{
        		d="";
        	}if(e==""|| e==null){
        		e="Buyer,";	
        	}else{
        		e="";
        	}if(f==""|| f==null){
        		 f="Currency,";	
        	}else{
        		f="";
        	}if(g==""|| g==null){
        		g="UOM,";;	
        	}else{
        		g="";
        	}if(h==""|| h==null){
        		 h="Quantity,";	
        	}else{
        		h="";
        	}if(i==""|| i==null){
        		i="Need By Date,";	
        	}else{
        		i="";
        	}if(j==""|| j==null){
        		j="Charge Account,";
        	}else{
        		j="";
        	}if(k==""|| k==null){
        		 k="Org,";	
        	}else{
        		k="";
        	}if(l==""|| l==null){
        		l="Deliver To,";
        	}else{
        		l="";
        	}if(m==""|| m==null){
        		 m="Amount,";
        	}else{
        		m="";
        	}if(n==""|| n==null){
        		 n="Match Approval Level,";
        	}else{
        		n="";
        	}if(o==""|| o==null){
        		 o="Invoice Match Option,";
        	}else{
        		o="";
        	}if(p==""|| p==null){
        		p="Accrueat Receipt Flag,";
        	}else{
        		p="";
        	}if(q==""|| q==null){
        		q="Item Type,";
        	}else{
        		q="";
        	}
        	
        	
	        	if(a==""|| a==null || b=="" || b==null  || c==""|| c==null || d=="" || d==null || e==""|| e==null || f=="" || f==null ||
	        			g==""|| g==null || h=="" || h==null  || i==""|| i==null || j=="" || j==null || k==""|| k==null || l=="" || l==null ||
	        			m==""|| m==null || n=="" || n==null  || o==""|| o==null || p=="" || p==null || q==""|| q==null ){
	        		
	        		
	        			 
	        			 Swal.fire({
	        				  title: 'Are you sure to Confirm?',
	        		  		  text: ""+a+""+b+""+c+""+d+""+e+""+f+""+g+""+h+""+i+""+j+""+k+""+l+""+m+""+n+""+o+""+p+""+q+" Field(s) Vales Are Blank",
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
	        					  
	        					  $('#flipToInvoice').attr('disabled', false);
	        			        	
	        			            var table = document.getElementById('tabledata');
	        			            
	        			            $('.loader').hide();
	        			            var urlOftripsDetail = "poInvoiceGenerate?id=" + poNo;
	        			            window.open(urlOftripsDetail, "poInvoiceGenerate", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	        			      		
	        			            $('#flipToInvoice').attr('disabled', true);
	        				  }
	        		 });
	        	}
        }
        
        function refreshParent() 
        {
            window.opener.location.reload(true);
            window.close();
        }
          
    </script>
</body>

</html>
