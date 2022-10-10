<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<aside class="main-sidebar sidebar-dark-primary elevation-4">

    <a href="dashboard" class="brand-link"> <img src="${logoPath}" alt="AdminLTE Logo" class="brand-image navbar-brand brand-logo-mini">
        <span class="brand-text font-weight-light">${sideLogoName}</span>
    </a>

    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-link 
                       <% if (request.getParameter("pagename").equalsIgnoreCase("dashboard")) {
                               out.print("active");
                           }%>">
                        <i class="nav-icon fas fa-tachometer-alt"> </i>
                        <p>Dashboard</p>
                    </a>
                    <hr>
                </li>

                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-truck"></i>
                        <p> Trips <i class="right fas fa-angle-left"></i></p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="allTrips" class="nav-link
	                            <%if (request.getParameter("pagename").equalsIgnoreCase("allTrips")) {
					out.print("active");
				}%>">
                                <i class="nav-icon fas fa-list"></i>
                                <p>All Trips</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="closedTrips" class="nav-link
	                            <%if (request.getParameter("pagename").equalsIgnoreCase("closedTrips")) {
					out.print("active");
				}%>                            
	                            ">
                                <i class="nav-icon far fa-window-close"></i>
                                <p>Closed Trips</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="closedAndApprovedTrips" class="nav-link
	                            <%if (request.getParameter("pagename").equalsIgnoreCase("closedAndApprovedTrips")) {
					out.print("active");
				}%>                            
	                            ">
                                <i class="nav-icon far fa-window-close"></i>
                                <p>Closed & Approved Trips</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="inTransitTrips" class="nav-link
	                            <%if (request.getParameter("pagename").equalsIgnoreCase("inTransitTrips")) {
					out.print("active");
				}%>                            
	                            ">
                                <i class="nav-icon fas fa-map-marked-alt"></i>
                                <p>In-Transit Trips</p>
                            </a></li>
                    </ul>
                    <hr>
                </li>

                <li class="nav-item"><a href="${pageContext.request.contextPath}/pendingApproval" class="nav-link 
                       <% if (request.getParameter("pagename").equalsIgnoreCase("pendingApproval")) {
                               out.print("active");
                           }%>
                       ">
                        <i class="nav-icon fas fa fa-tasks highlight-icon"> </i>
                        <p>Pen. For Approvel Trips</p>
                    </a>
                    <hr>
                </li>

                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-file-invoice-dollar"></i>
                        <p>
                            Invoices <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="invoicesQueue" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("invoiceQueue")) {
				out.print("active");
			}%>">
                                <i class="nav-icon fas fa-file-invoice"></i>
                                <p>All Invoices</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="pendingInvoice" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("pendingInvoice")) {
				out.print("active");
			}%>">
                                <i class="nav-icon fas fa-file-contract"></i>
                                <p>Process Invoices</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="approvedInvoice" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("approvedInvoice")) {
				out.print("active");
			}%>">
                                <i class="nav-icon fas fa fa-check"></i>
                                <p>Approved Invoices</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="draftInvoice" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("draftInvoice")) {
				out.print("active");
			}%>">
                                <i class="nav-icon fab fa-firstdraft"></i>
                                <p>Draft Invoices</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="queryInvoice" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("queryInvoiceVendor")) {
				out.print("active");
			}%>">
                                <i class="nav-icon fas fa-question"></i>
                                <p>Query Invoices</p>
                            </a></li>
                    </ul>
                    <hr>
                </li>

            </ul>
            <hr>
        </nav>
    </div>
</aside>
