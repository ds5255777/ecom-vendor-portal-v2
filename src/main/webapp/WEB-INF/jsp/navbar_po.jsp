<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" readonly>
<c:set var="pageName" value='<%=request.getParameter("pagename")%>' />
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="${pageContext.request.contextPath}/assets/#"><i class="fas fa-bars"></i></a></li>
        <c:choose>
            <c:when test="${pageName=='All Trips' || pageName=='All Trips (Network)'}">
                <li class="nav-item d-none d-sm-inline-block"><a class="black-text nav-link quickHelp" data-toggle="tooltip" data-placement="bottom" title="Back" href="#" onclick="history.back()" style="padding-right: 0px;"><b style="font-size: 18px; color: #12344dd6;"><i class="fa fa-fast-backward"></i></b></a></li>
                <li class="nav-item d-none d-sm-inline-block"><b><a class="nav-link"> <%=request.getParameter("pagename")%>
                        </a></b></li>
                <li class="nav-item d-none d-sm-inline-block" style="padding: 6px;">
                    <button type="button" class="btn btn-default btn-sm " id="refreshDashboardButton">
                        <i class="fas fa-sync-alt"></i>
                    </button>
                </li>
                <div class="input-group-prepend">
                    <form role="form" id="addForm" autocomplete="off">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <select class="form-control" name="selectTripStatus" id="selectTripStatus" onchange="GetSelectedTextValue()" style="height: 34px; width: 170px">
                                        <option value="">Select Trip Status</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <select class="form-control" id="selectStatus" name="selectStatus" onchange="GetSelectedTextValue()" style="height: 34px; width: 170px">
                                        <option value="">Select Vendor Status</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: .3rem">
                                    <select class="form-control" id="selectPaymentStatus" name="selectPaymentStatus" onchange="GetSelectedTextValue()" style="height: 34px; width: 170px">
                                        <option value="">Select Invoicing Status</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </c:when>

            <c:otherwise>
                <li class="nav-item d-none d-sm-inline-block"><a class="nav-link"> <%=request.getParameter("pagename")%>
                    </a></li>
                <li>
                    <form>
                        <select name="list" id="list" accesskey="target" onchange="goToNewPage()" style="height: 34px; font-size: 17px;">
                            <option value="">-- Please select --</option>
                            <option value="dashboard">Network Dashboard</option>
                            <option value="dashboard_Po">Po Dashboard</option>
                        </select>
                    </form>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
    <ul class="navbar-nav ml-auto">

        <li class="nav-item"><a class="nav-link">${vendorName}</a></li>

        <li class="nav-item">
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <form id="logoutForm" method="POST" action="${pageContext.request.contextPath}/logout">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>

                <a href="#" class="nav-link" data-toggle="dropdown" id="invalidateForm"> <i class="fa fa-power-off fa-lg" style="color: #C62625;"></i>
                </a>
            </c:if>
        </li>
    </ul>
</nav>
<script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>

<script src="js/navbar_po.js"></script>
