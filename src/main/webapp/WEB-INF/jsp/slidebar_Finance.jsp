<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">

    <a href="dashboard" class="brand-link"> <img src="${logoPath}" alt="AdminLTE Logo" class="brand-image navbar-brand brand-logo-mini">
        <span class="brand-text font-weight-light">${sideLogoName}</span>
    </a>
    
    <%
		String financeRole = GlobalConstants.ROLE_FINANCE;
		String financeHeadRole = GlobalConstants.ROLE_FINANCE_HEAD;
		
		request.setAttribute("financeRole", financeRole);
		request.setAttribute("financeHeadRole", financeHeadRole);
	%>

    <!-- Sidebar -->
    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-link
                                        <% if (request.getParameter("pagename").equalsIgnoreCase("dashboard")) {
                                                out.print("active");
                                            }%>
                                        ">
                        <i class="nav-icon fas fa-tachometer-alt"> </i>
                        <p>Dashboard</p>
                    </a>
                    <hr>
                </li>
				
				<c:if test="${role.equalsIgnoreCase(financeRole) }">
                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-file-invoice-dollar"></i>
                        <p>
                            Invoices <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="allInvoices_Finance" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("allInvoices_Finance")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fas fa-file-invoice"></i>
                                <p>All Invoices</p>
                            </a></li>
                    </ul>
                        
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="InProcessInvoiceFinance" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("InprocessInvoiceFinance")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fas fa-file-contract"></i>
                                <p>In-Review Trip Invoices</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="paymentRelaseInvoice" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("paymentRelaseInvoice")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fas fa-file-invoice-dollar"></i>
                                <p>In-Review PO Invoices</p>
                            </a></li>
                    </ul>
                    
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="pendingForApprovalInvoice" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("pendingForApprovalInvoice")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fas fa-receipt"></i>
                                <p>Pending For Approval</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="processInvoiceFinance" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("processInvoiceFinance")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fa fas fa fa-check"></i>
                                <p>Approved Invoices</p>
                            </a></li>
                    </ul>
                    
                    <hr>
                </li>
                        <li class="nav-item"><a href="queryInvoiceFinance" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("QueryInvoiceFinance")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fas fa-question"></i>
                                <p>Query</p>
                            </a></li>
                            </c:if>
                            
                            
                <c:if test="${role.equalsIgnoreCase(financeHeadRole) }">
                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-file-invoice-dollar"></i>
                        <p>
                            Invoices <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="allInvoices_Finance" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("allInvoices_Finance")) {
                                    out.print("active");
                                }%> ">
                                <i class="nav-icon fas fa-file-invoice"></i>
                                <p>All Invoices</p>
                            </a></li>
                    </ul>
                        
                    
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="pendingForApprovalInvoice" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("pendingForApprovalInvoice")) {
                                    out.print("active");
                                }%>">
                                <i class="nav-icon fas fa-receipt"></i>
                                <p>Pending For Approval</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="processInvoiceFinance" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("processInvoiceFinance")) {
                                    out.print("active");
                                }%>">
                                <i class="nav-icon fa fas fa fa-check"></i>
                                <p>Approved Invoices</p>
                            </a></li>
                    </ul>
                    <hr>
                </li>
                </c:if>
                    </ul>
       
        </nav>
    </div>
</aside>
