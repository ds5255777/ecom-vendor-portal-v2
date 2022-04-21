<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" readonly>
<c:set var="pageName" value='<%=request.getParameter("pagename")%>' />
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="${pageContext.request.contextPath}/assets/#"><i class="fas fa-bars"></i></a></li>
        <c:choose>
            <c:when test="${pageName=='All Trips' || pageName=='All Trips (Network)'}">
                <li class="nav-item d-none d-sm-inline-block"><a class="black-text nav-link quickHelp" data-toggle="tooltip" data-placement="bottom" title="Back" href="#" onclick="history.back()" style="padding-right: 0px;"><b style="font-size: 18px;color: #12344dd6;"><i class="fa fa-fast-backward"></i></b></a></li>
                <li class="nav-item d-none d-sm-inline-block"><b><a class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
                <li class="nav-item d-none d-sm-inline-block" style="padding: 6px;" >
                    
                    <button type="button" class="btn btn-default btn-sm " id="refreshDashboardButton" > <i class="fas fa-sync-alt"></i></button>
                    
                </li>
                <div class="input-group-prepend">
                    <%-- <div class="btn-group">
						<button type="button" class="btn"
							style="font-size: 20px; font-weight: 500;"><%=request.getParameter("pagename")%></button> --%>
                    <form role="form" id="addForm" autocomplete="off">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <!-- <label>Trip Status</label> -->
                                    <select class="form-control" name="selectTripStatus" id="selectTripStatus" onchange="GetSelectedTextValue()" style="height: 34px; width: 170px">
                                         <option value="">Select Trip Status</option>
                                        <!--<option value="In-Transit">In-Transit</option>
                                        <option value="Closed">Closed</option> -->
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <!-- <label>Status</label> -->
                                    <select class="form-control" id="selectStatus" name="selectStatus" onchange="GetSelectedTextValue()" style="height: 34px; width: 170px">
                                         <option value=""  >Select Vendor Status</option>
                                        <!--<option value="Pending for Approve"  >Pending For Approvel</option>
                                        <option value="Approved">Approve</option>
                                        <option value="Invoicing">Invoicing</option> -->
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <!-- <label>Payment Status</label> -->
                                    <select class="form-control" id="selectPaymentStatus" name="selectPaymentStatus" onchange="GetSelectedTextValue()" style="height: 34px; width: 170px">
                                         <option value="" >Select Invoicing Status</option>
                                        <!--<option value="-" >-</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Approved">Approve</option> -->
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </c:when>
            <c:when test="${pageName=='Vendor Invoice'}">
            <li class="nav-item d-none d-sm-inline-block"><a class="black-text nav-link quickHelp" data-toggle="tooltip" data-placement="bottom" title="Back" href="#" onclick="history.back()" style="padding-right: 0px;"><b style="font-size: 18px;color: #12344dd6;"><i class="fa fa-fast-backward"></i></b></a></li>
                <li class="nav-item d-none d-sm-inline-block"><b><a class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
                <li class="nav-item d-none d-sm-inline-block" style="padding: 6px;" >
                    
                    <button type="button" class="btn btn-default btn-sm " id="refreshDashboardButton" > <i class="fas fa-sync-alt"></i></button>
                    
                </li>
                <div class="input-group-prepend">
                    <form role="form" id="addForm" autocomplete="off">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group" style="padding-top: .3rem">
                                    <!-- <label>Trip Status</label> -->
                                    <select class="form-control" name="selectVendorCode" id="selectVendorCode" onchange="GetSelectedInvoiceValue()" style="height: 34px; width: 170px">
                                         <option value="">Select Vendor Code</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" style="padding-top: .3rem">
                                    <!-- <label>Payment Status</label> -->
                                    <select class="form-control" id="selectInvoicingStatus" name="selectInvoicingStatus" onchange="GetSelectedInvoiceValue()" style="height: 34px; width: 170px">
                                         <option value="" >Select Invoicing Status</option>
                                         <option value="In-Review" >In-Review</option>
                                         <option value="Pending For Approval" >Pending For Approval</option>
                                         <option value="Approved" >Approved</option>
                                         <option value="Query" >Query</option>
                                    </select>
                                </div>
                            </div>
                             <!-- <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <label>Trip Status</label>
                                    <select class="form-control" name="selectTripStatus" id="selectTripStatus" onchange="GetSelectedTextValue()" style="height: 34px; width: 170px">
                                         <option value="">Select Vendor Code</option>
                                    </select>
                                </div>
                            </div> -->
                        </div>
                    </form>
                </div>
            </c:when>
            
            <c:otherwise>
                <li class="nav-item d-none d-sm-inline-block"><a class="black-text nav-link quickHelp" data-toggle="tooltip" data-placement="bottom" title="Back" href="#" onclick="history.back()" style="padding-right: 0px;"><b style="font-size: 18px;color: #12344dd6;"><i class="fa fa-fast-backward"></i></b></a></li>
                <li class="nav-item d-none d-sm-inline-block"><b><a class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
            </c:otherwise>
        </c:choose>
    </ul>
    
    <!-- Finance Navbar -->
    
    
    
    <!-- Finance Navbar -->
    
    
    
    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
        
        <li class="nav-item"><a class="nav-link">${userName}</a></li>
        
        <c:if test="${isssoEnable!='yes'}">
            <li class="nav-item"><a class="nav-link" href="logout" id="quickHelp" data-toggle="tooltip" data-placement="bottom" title="LogOut"> <i class="fa fa-power-off fa-lg"></i>
                </a></li>
        </c:if>
    </ul>
</nav>
<script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>

<script>
function GetSelectedTextValue() {
	var tripStatus=$("#selectTripStatus").val();
	var selectStatus=$("#selectStatus").val();
	var selectPaymentStatus=$("#selectPaymentStatus").val();
	var vendorCode = $("#vendorCode").val();
    var obj={
    		"runStatus":tripStatus,
    		"vendorTripStatus":selectStatus,
    		"paymentStatus":selectPaymentStatus,
    		"vendorCode": vendorCode
    }
 console.log("Select Status : ",obj);

    $('.loader').show();
    $.ajax({
        type: "POST",
        url:"<%=GlobalUrl.status%>",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(obj),
        success: function(data) {

        	console.log("data : ",data);

            $('.loader').hide();
            if (data.msg == "success") {
                var result = data.data;
                tabledata.clear();
                for (var i = 0; i < result.length; i++) {
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
                     if(!result[i].hasOwnProperty("actualDeparture")){
							result[i].actualDeparture="";
						}
                     if(!result[i].hasOwnProperty("actualKM")){
							result[i].actualKM="";
						}
                     if(!result[i].hasOwnProperty("standardKM")){
							result[i].standardKM="";
						}
                      if(!result[i].hasOwnProperty("originHub")){
							result[i].originHub="";
						}
                      if(!result[i].hasOwnProperty("destHub")){
							result[i].destHub="";
						}
                      if(!result[i].hasOwnProperty("invoiceNumber")){
							result[i].invoiceNumber="";
						}
                      if(!result[i].hasOwnProperty("paymentStatus")){
						result[i].paymentStatus="";
					}
                	
                	var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";
                    var statustemp_payment_success = '<span class=\"right badge badge-success\">Approved</span>';
                    var statustemp_payment_Pending = '<span class=\"right badge badge-warning\">Pending</span>';
                    var statustemp_payment_No = '<span class=\"right badge badge-primary\">NA</span>';

                    var statustemp_runststus_Intransit = '<span class=\"right badge badge-warning\">In-Transit</span>';
                    var statustemp_runststus_Closed = '<span class=\"right badge badge-success\">Closed</span>';

                    var statustemp_pending = '<span class=\"right badge badge-warning\">Yet To Be Approved</span>';
                    var statustemp_approved = '<span class=\"right badge badge-success\">Approved</span>';
                    var statustemp_Invoicing = '<span class=\"right badge badge-primary\">Invoicing</span>';
                    var statustemp_Draft_Invoicing = '<span class=\"right badge badge-danger\">Draft-Invoicing</span>';
                    var statustemp_query = '<span class=\"right badge badge-warning\"  style=\"background-color: violet;\">Query</span>';

                    var paymentStatus = "";
                    var runStatus = "";
                    var vendorTripStatus = "";

                    var tempString = [view, result[i].route, result[i].runType, runStatus, status, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub,result[i].invoiceNumber, paymentStatus];

                    if (result[i].paymentStatus == "Pending") {
                        tempString[11] = statustemp_payment_Pending;
                    } else if (result[i].paymentStatus == "Approved") {
                        tempString[11] = statustemp_payment_success;
                    } else if (result[i].paymentStatus == "NA") {
                        tempString[11] = statustemp_payment_No;
                    }

                    if (result[i].vendorTripStatus == "Yet To Be Approved") {
                        tempString[4] = statustemp_pending;
                    } else if (result[i].vendorTripStatus == "Approved") {
                        tempString[4] = statustemp_approved;
                    } else if (result[i].vendorTripStatus == "Invoicing") {
                        tempString[4] = statustemp_Invoicing;
                    } else if (result[i].vendorTripStatus == "Query") {
                        tempString[4] = statustemp_query;
                    } else if (result[i].vendorTripStatus == "Draft-Invoicing") {
                        tempString[4] = statustemp_Draft_Invoicing;
                    }

                    if (result[i].runStatus == "In-Transit") {
                        tempString[3] = statustemp_runststus_Intransit;
                    } else if (result[i].runStatus == "Closed") {
                        tempString[3] = statustemp_runststus_Closed;
                    }
                    
                    tabledata.row.add(tempString);
                }
                tabledata.draw();
                $("tbody").show();
            } else {
                alert("failed");
            }
        },
        error: function(jqXHR, textStatue, errorThrown) {
            alert("failed, please try again");
        }
    });
}

getSelectTripList();

function getSelectTripList() {

	$("#selectVendorCode ").empty();
	$('#selectVendorCode').append($('<option/>').attr("value", "").text("Select Vendor Code"));
	
    $.ajax({
        type: "POST",
        data: "",
        url: "<%=GlobalUrl.getFilterInvoiceByVendorCode%>",
        dataType: "json",
        contentType: "application/json",
        
        success: function(data) {

            if (data.msg == 'success') {
                var result = data.data;
                
                if (result.length !== 0) {
                    for (var i = 0; i < result.length; i++) {
                        $('#selectVendorCode').append($('<option/>').attr("value", result[i]).text(result[i]));
                    }
                }
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

function GetSelectedInvoiceValue(){
	var vendorCode=$("#selectVendorCode").val();
	var invoiceStatus=$("#selectInvoicingStatus").val();
    var obj={
    		"vendorCode":vendorCode,
    		"invoiceStatus":invoiceStatus
    }
 console.log("Select Status : ",obj);

    $('.loader').show();
    $.ajax({
        type: "POST",
        data: JSON.stringify(obj),
        url: "<%=GlobalUrl.viewInvoiceForFinanceTeam%>",
        dataType: "json",
        contentType: "application/json",
        async: false,
        success: function(data) {

            $('.loader').hide();
            if (data.msg == 'success') {
                var result = data.data;
                tabledata.clear();
                for (var i = 0; i < result.length; i++) {
                    if (!result[i].hasOwnProperty("invoiceNumber")) {
                        result[i].invoiceNumber = "";
                    }
                    if (!result[i].hasOwnProperty("invoiceDate")) {
                        result[i].invoiceDate = "";
                    }
                    if (!result[i].hasOwnProperty("invoiceAmount")) {
                        result[i].invoiceAmount = "";
                    }
                    if (!result[i].hasOwnProperty("invoiceReceivingDate")) {
                        result[i].vehicleNumber = "";
                    }
                    if (!result[i].hasOwnProperty("invoiceStatus")) {
                        result[i].invoiceStatus = "";
                    }
                    if (!result[i].hasOwnProperty("ecomInvoiceNumber")) {
                        result[i].invoiceStatus = "";
                    }
                    var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getInvoiceDataFormDataByInvoiceNumber('" + result[i].invoiceNumber + "','All Invoices')\" >" + result[i].ecomInvoiceNumber + "</button>";

                    tabledata.row.add([view, result[i].invoiceNumber, result[i].vendorCode, result[i].vendorName, result[i].invoiceReceivingDate,  result[i].invoiceDate, result[i].invoiceAmount, result[i].invoiceStatus]);
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
            alert("failed, please try again leter");
        }
    });
}
</script>