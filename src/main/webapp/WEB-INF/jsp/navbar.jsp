<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" readonly>
<c:set var="pageName" value='<%=request.getParameter("pagename")%>' />
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="${pageContext.request.contextPath}/assets/#"><i class="fas fa-bars"></i></a></li>
        <c:choose>
			<c:when
				test="${pageName=='All Trips' || pageName=='All Trips (Network)'}">
				<li class="nav-item d-none d-sm-inline-block"><a
					class="black-text nav-link quickHelp" data-toggle="tooltip"
					data-placement="bottom" title="Back" href="#"
					onclick="history.back()" style="padding-right: 0px;"><b
						style="font-size: 18px; color: #12344dd6;"><i
							class="fa fa-fast-backward"></i></b></a></li>
				<li class="nav-item d-none d-sm-inline-block"><b><a
						class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
				<li class="nav-item d-none d-sm-inline-block" style="padding: 6px;">

					<button type="button" class="btn btn-default btn-sm "
						id="refreshDashboardButton">
						<i class="fas fa-sync-alt"></i>
					</button>

				</li>
				<div class="input-group-prepend">
					<form role="form" id="addForm" autocomplete="off">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group" style="padding-top: .3rem">
									<select class="form-control" name="selectTripStatus"
										id="selectTripStatus" onchange="GetSelectedTextValue()"
										style="height: 34px; width: 170px">
										<option value="">Select Trip Status</option>
									</select>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group" style="padding-top: .3rem">
									<select class="form-control" id="selectStatus"
										name="selectStatus" onchange="GetSelectedTextValue()"
										style="height: 34px; width: 170px">
										<option value="">Select Vendor Status</option>
									</select>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group" style="padding-top: .3rem">
									<select class="form-control" id="selectPaymentStatus"
										name="selectPaymentStatus" onchange="GetSelectedTextValue()"
										style="height: 34px; width: 170px">
										<option value="">Select Invoicing Status</option>
									</select>
								</div>
							</div>
						</div>
					</form>
				</div>
			</c:when>
			<c:when test="${pageName=='Vendor Invoice'}">
				<li class="nav-item d-none d-sm-inline-block"><a
					class="black-text nav-link quickHelp" data-toggle="tooltip"
					data-placement="bottom" title="Back" href="#"
					onclick="history.back()" style="padding-right: 0px;"><b
						style="font-size: 18px; color: #12344dd6;"><i
							class="fa fa-fast-backward"></i></b></a></li>
				<li class="nav-item d-none d-sm-inline-block"><b><a
						class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
				<li class="nav-item d-none d-sm-inline-block" style="padding: 6px;">

					<button type="button" class="btn btn-default btn-sm "
						id="refreshDashboardButton">
						<i class="fas fa-sync-alt"></i>
					</button>

				</li>
				<div class="input-group-prepend">
					<form role="form" id="addForm" autocomplete="off">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group" style="padding-top: .3rem">
									<select class="form-control" name="selectVendorCode"
										id="selectVendorCode" onchange="GetSelectedInvoiceValue()"
										style="height: 34px; width: 170px">
										<option value="">Select Vendor Code</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group" style="padding-top: .3rem">
									<select class="form-control" id="selectInvoicingStatus"
										name="selectInvoicingStatus"
										onchange="GetSelectedInvoiceValue()"
										style="height: 34px; width: 170px">
										<option value="">Select Invoicing Status</option>
										<option value="In-Review">In-Review</option>
										<option value="Pending For Approval">Pending For
											Approval</option>
										<option value="Approved">Approved</option>
										<option value="Query">Query</option>
									</select>
								</div>
							</div>
						</div>
					</form>
				</div>
			</c:when>
			
			<c:when test="${pageName=='Closed And Approved Trips'}">
				<li class="nav-item d-none d-sm-inline-block"><a class="black-text nav-link quickHelp" data-toggle="tooltip" data-placement="bottom" title="Back" href="#" onclick="history.back()" style="padding-right: 0px;"><b style="font-size: 18px;color: #12344dd6;"><i class="fa fa-fast-backward"></i></b></a></li>
                <li class="nav-item d-none d-sm-inline-block"><b><a class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
                
                <button type="button" class="btn btn-default btn-sm "
						id="refreshDashboardButton">
						<i class="fas fa-sync-alt"></i>
					</button>
			
			</c:when>

			<c:when test="${pageName=='All PO'}">
				<li class="nav-item d-none d-sm-inline-block"><a
					class="black-text nav-link quickHelp" data-toggle="tooltip"
					data-placement="bottom" title="Back" href="#"
					onclick="history.back()" style="padding-right: 0px;">
					<b style="font-size: 18px; color: #12344dd6;"><i
							class="fa fa-fast-backward"></i></b></a></li>
				<li class="nav-item d-none d-sm-inline-block"><b><a
						class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
				<li class="nav-item d-none d-sm-inline-block" style="padding: 6px;">

					<button type="button" class="btn btn-default btn-sm "
						id="refreshDashboardButton">
						<i class="fas fa-sync-alt"></i>
					</button>

				</li>
				<li class="nav-item d-none d-sm-inline-block" style="padding: 6px;">
					<form role="form" id="addForm" autocomplete="off">
						<div class="row">
							<div class="col-md-4">
								<input type="text" name="fromDate" placeholder="Start Date"
									class="form-control" id="fromDate">
							</div>
							<div class="col-md-4">
								<input type="text" name="toDate" placeholder="End Date"
									class="form-control" id="toDate">
							</div>
							<div class="col-md-4">

								<button type="button" onclick="getFilterData()"
									style="imargin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
									class="btn btn-primary">Search</button>
							</div>
						</div>
					</form>
				</li>
			</c:when>
			<c:when test="${pageName=='Dashboard' || pageName=='PO Dashboard'}">
                <li class="nav-item d-none d-sm-inline-block"><b><a class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
			</c:when>

			<c:otherwise>
                <li class="nav-item d-none d-sm-inline-block"><a class="black-text nav-link quickHelp" data-toggle="tooltip" data-placement="bottom" title="Back" href="#" onclick="history.back()" style="padding-right: 0px;"><b style="font-size: 18px;color: #12344dd6;"><i class="fa fa-fast-backward"></i></b></a></li>
                <li class="nav-item d-none d-sm-inline-block"><b><a class="nav-link"><%=request.getParameter("pagename")%></a></b></li>
            </c:otherwise>
        </c:choose>
    </ul>
    
    <!-- Right navbar links -->
	<ul class="navbar-nav ml-auto">

		<li class="nav-item"><a class="nav-link">${userName}</a></li>

		<c:if test="${isssoEnable!='yes'}">
			<li class="nav-item"><a class="nav-link" href="logout"
				id="quickHelp" data-toggle="tooltip" data-placement="bottom"
				title="LogOut"> <i class="fa fa-power-off fa-lg" style="color: #C62625;"></i>
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
	$('#fromDate').val('');
    $('#toDate').val('');
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
                    if(!result[i].hasOwnProperty("invoiceNumber")){
							result[i].invoiceNumber="";
						}
					if(!result[i].hasOwnProperty("route")){
							result[i].route="";
						}
                     if(!result[i].hasOwnProperty("runType")){
							result[i].runType="";
						}
                     if(!result[i].hasOwnProperty("runStatus")){
							result[i].runStatus="";
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
                      if(!result[i].hasOwnProperty("paymentStatus")){
						result[i].paymentStatus="";
					}

                    var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";
                   
                    tabledata.row.add([view, result[i].invoiceNumber, result[i].route, result[i].runType, result[i].runStatus, result[i].vendorTripStatus, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub,  result[i].paymentStatus]);
               
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