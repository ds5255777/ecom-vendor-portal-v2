<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">

    <!-- Brand Logo class="navbar-brand brand-logo-mini  rounded-circle" -->
    <a href="dashboard" class="brand-link"> <img src="${logoPath}" alt="AdminLTE Logo" class="brand-image navbar-brand brand-logo-mini">
        <span class="brand-text font-weight-light">${sideLogoName}</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <!-- DASHBOARD -->
                <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-link
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
                                <i class="nav-icon fas fa-truck"></i>
                                <p>All PO</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="unprocessPO" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("Unprocessed PO")) {
                                    out.print("active");
                                }%> ">
                                <i class="nav-icon fas fa fa-check"></i>
                                <p>Unprocessed PO</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="processPO" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("Processed PO")) {
                                    out.print("active");
                                }%>">
                                <i class="nav-icon fas fa-list"></i>
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
                        <li class="nav-item"><a href="#" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("All Invoice")) {
                                    out.print("active");
                                }%> ">
                                <i class="nav-icon fas fa-file-invoice"></i>
                                <p>All Invoice</p>
                            </a></li>
                    </ul>
                    <hr>
                </li>

                <li class="nav-item"><a href="#" class="nav-link
                                        <%if (request.getParameter("pagename").equalsIgnoreCase("")) {
                                    out.print("active");
                                }%>
                                        ">
                        <i class="nav-icon far fas fa-cog"></i>
                        <p>Setting</p>
                    </a>
                    <hr>
                </li>

                <li class="nav-item"><a href="#" class="nav-link
                                        <%if (request.getParameter("pagename").equalsIgnoreCase("")) {
                                    out.print("active");
                                }%>
                                        ">
                        <i class="nav-icon fas fa-chart-bar"></i>
                        <p>Reports</p>
                    </a></li>
            </ul>
        </nav>
    </div>
</aside>
