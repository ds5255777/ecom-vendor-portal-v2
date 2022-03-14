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
                                        <% if (request.getParameter("pagename").equalsIgnoreCase("dashboard")) {
                                                out.print("active");
                                            }%>
                                        ">
                        <i class="nav-icon fas fa-tachometer-alt"> </i>
                        <p>Dashboard</p>
                    </a>
                    <hr>
                </li>
                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-truck"></i>
                        <p>
                            Trips <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="allTrips" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("allTrips")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fas fa-truck"></i>
                                <p>All Trips</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="getApprovedAdhocTrips" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("Approved Trips")) {
                                    out.print("active");
                                }%>
                                                ">
                                <!-- <i class="nav-icon fas fa-times"></i> -->
                                <i class="nav-icon fas fa fa-check"></i>
                                <p>Approved Trips</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="pendingApprovalNetwork" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("Pending For Approval")) {
                                    out.print("active");
                                }%>
                                                ">
                                <!-- <i class="nav-icon fas fa-times"></i> -->
                                <i class="nav-icon fas fa-list"></i>
                                <p>Pending for Approval</p>
                            </a></li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="IntransitAndAdhoc" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("inTransitTrips")) {
                                    out.print("active");
                                }%>
                                                ">
                                <i class="nav-icon fas fa-map-marked-alt"></i>
                                <p>In-Transit (Adhoc) Trips</p>
                            </a></li>
                    </ul>


                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="ClosedAdhoc" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("Closed (Adhoc) Trips")) {
                                    out.print("active");
                                }%>
                                                ">
                                <i class="nav-icon far fa-times-circle"></i>
                                <p>Closed (Adhoc) Trips</p>
                            </a></li>
                    </ul>
                    <hr>
                </li>

                <%-- <li class="nav-item"><a
                                            href="${pageContext.request.contextPath}/allTrips"
                                            class="nav-link 
                           <% if (request.getParameter("pagename").equalsIgnoreCase("allTrips")) {
                                   out.print("active");
                               }%>
                ">
                <i class="nav-icon fas fa-circle"> </i>
                <p>All Trips</p>
                </a>
                <hr>
                </li>

            <li class="nav-item"><a href="${pageContext.request.contextPath}/closedTrips" class="nav-link 
                       <% if (request.getParameter("pagename").equalsIgnoreCase("closedTrips")) {
                               out.print("active");
                           }%>
                       ">
                    <i class="nav-icon fas fa-circle"> </i>
                    <p>Closed Trips</p>
                </a>
                <hr>
            </li>

            <li class="nav-item"><a href="${pageContext.request.contextPath}/inTransitTrips" class="nav-link 
                       <% if (request.getParameter("pagename").equalsIgnoreCase("inTransitTrips")) {
                               out.print("active");
                           }%>
                       ">
                    <i class="nav-icon fas fa-circle"> </i>
                    <p>in-Transit Trips</p>
                </a>
                <hr>
            </li> --%>

                <li class="nav-item"><a href="pendingApprovalNetwork" class="nav-link
                                        <% if (request.getParameter("pagename").equalsIgnoreCase("pendingApproval")) {
                                                out.print("active");
                                            }%>
                                        ">
                        <i class="nav-icon fas fa fa-tasks highlight-icon"> </i>
                        <p>Pending Approval Trips</p>
                    </a>
                    <hr>
                </li>

                <li class="nav-item has-treeview"><a href="#" class="nav-link">
                        <i class="nav-icon fas fa-file-invoice-dollar"></i>
                        <p>
                            Invoice <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item"><a href="invoicesQueue" class="nav-link
                                                <%if (request.getParameter("pagename").equalsIgnoreCase("invoicesQueue")) {
                                    out.print("active");
                                }%>

                                                ">
                                <i class="nav-icon fas fa-file-invoice"></i>
                                <p>All Invoice</p>
                            </a></li>
                    </ul>
                    <!--                <ul class="nav nav-treeview">
                                        <li class="nav-item"><a href="pendingInvoice" class="nav-link
                    <%if (request.getParameter("pagename").equalsIgnoreCase("pendingInvoice")) {
                                    out.print("active");
                                }%>                            
                    ">
                     <i class="nav-icon fas fa-times"></i> 
                    <i class="nav-icon far fa-file-alt"></i>
                    <p>Invoice Process</p>
                </a></li>
        </ul>-->
                    <!--                <ul class="nav nav-treeview">
                                        <li class="nav-item"><a href="approvedInvoice" class="nav-link
                    <%if (request.getParameter("pagename").equalsIgnoreCase("approvedInvoice")) {
                                    out.print("active");
                                }%>                            
                    ">
                    <i class="nav-icon fas fa-thumbs-up"></i>
                    <p>Invoice Approved</p>
                </a></li>
        </ul>-->
                    <!--                <ul class="nav nav-treeview">
                                        <li class="nav-item"><a href="rejectedInvoice" class="nav-link
                    <%if (request.getParameter("pagename").equalsIgnoreCase("rejectedInvoice")) {
                                    out.print("active");
                                }%>                            
                    ">
                     <i class="nav-icon fas fa-times"></i> 
                    <i class="nav-icon far fa-times-circle"></i>
                    <p>Invoice Rejected</p>
                </a></li>
        </ul>-->
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

                <%-- <li class="nav-item has-treeview"><a href="#" class="nav-link">
                                               <i class="nav-icon fas fa-circle"></i>
                                               <p>
                                                       Admin <i class="right fas fa-angle-left"></i>
                                               </p>
                               </a>
                                       <ul class="nav nav-treeview">
                                               <li class="nav-item"><a href="addUsers"
                                                       class="nav-link
                           <%if (request.getParameter("pagename").equalsIgnoreCase("addUsers")) {
                               out.print("active");
                       }%>

                ">
                <i class="nav-icon fas fa-user"></i>
                <p>Users</p>
                </a></li>
            </ul>
            <ul class="nav nav-treeview">
                <li class="nav-item"><a href="emailConfig" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("emailConfig")) {
                                out.print("active");
                        }%>                            
                            ">
                        <i class="nav-icon fas fa-envelope"></i>
                        <p>Email Configuration</p>
                    </a></li>
            </ul>
            <hr>
            </li> --%>



            </ul>
        </nav>
    </div>
</aside>
