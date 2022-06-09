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
                                    <select class="form-control" name="selectTripStatus" id="selectTripStatus" onchange="GetSelectedTextValue1()"  style="height: 34px; width: 170px">
                                         <option value="">Select Trip Status</option>
                                        <!--<option value="In-Transit">In-Transit</option>
                                        <option value="Closed">Closed</option> -->
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <!-- <label>Status</label> -->
                                    <select class="form-control" id="selectStatus" name="selectStatus" onchange="GetSelectedTextValue1()"  style="height: 34px; width: 170px">
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
                                    <select class="form-control" id="selectPaymentStatus" name="selectPaymentStatus" onchange="GetSelectedTextValue1()" style="height: 34px; width: 170px">
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
            <li class="nav-item"><a class="nav-link" href="logout" id="quickHelp" data-toggle="tooltip" data-placement="bottom" title="LogOut"> <i class="fa fa-power-off fa-lg" style="color: #C62625;"></i>
                </a></li>
        </c:if>
    </ul>
</nav>
<script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>

<script>
    
    
                                                      
</script>