<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">

    <a href="dashboard" class="brand-link"> <img src="${logoPath}" alt="AdminLTE Logo" class="brand-image navbar-brand brand-logo-mini">
        <span class="brand-text font-weight-light">${sideLogoName}</span>
    </a>

    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <li class="nav-item"><a href="dashboard_Po" class="nav-link
                                        <% if (request.getParameter("pagename").equalsIgnoreCase("dashboard_Po")) {
                                                out.print("active");
                                            }%>
                                        ">
                        <i class="nav-icon fas fa-tachometer-alt"> </i>
                        <p>Dashboard</p>
                    </a>
                    <hr>
                </li>
                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-shopping-cart"></i>
                        <p>
                            POs <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="allPO" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("all Po")) {
                                    out.print("active");
                                }%>

                                                ">
                               <i class="nav-icon fas fa-list"></i>
                                <p>All PO</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="unprocessPO" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("Unprocess PO")) {
                                    out.print("active");
                                }%> ">
                                
                                 
                                 <i class="nav-icon fa fa-tasks"></i>
                                <p>Unprocessed PO</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="processPO" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("Process PO")) {
                                    out.print("active");
                                }%>">
                                <i class="nav-icon fas fa fa-check"></i>
                                <p>Processed PO</p>
                            </a></li>
                    </ul>
                    
                    <hr>
                </li>

                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-file-invoice-dollar"></i>
                        <p>
                            Invoice <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="poInvoiceDetails" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("poInvoiceDetails")) {
                                    out.print("active");
                                }%> ">
                                <i class="nav-icon fas fa-file-invoice"></i>
                                <p>All Invoice</p>
                            </a></li>
                    </ul>
                     <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="draftPO" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("draftInvoice")) {
                                    out.print("active");
                                }%>">
                                <i class="nav-icon fab fa-firstdraft"></i>
                                <p>Draft invoice</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                    <li class="nav-item"><a href="QueryPo" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("queryInvoicePO")) {
				out.print("active");
			}%>">
                            <i class="nav-icon fas fa-question"></i>
                            <p>Query Invoice</p>
                        </a></li>
                </ul>
                    <hr>
                </li>

            </ul>
        </nav>
    </div>
</aside>
