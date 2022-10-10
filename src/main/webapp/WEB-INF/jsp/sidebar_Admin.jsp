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
                           }%>
                       ">
                        <i class="nav-icon fas fa-tachometer-alt"> </i>
                        <p>Dashboard</p>
                    </a>
                    <hr>
                </li>

                <li class="nav-item"><a href="tripMaster" class="nav-link 
                       <% if (request.getParameter("pagename").equalsIgnoreCase("masterEvaluationCriteria")) {
                               out.print("active");
                           }%>
                       ">
                        <i class="nav-icon fas fa fa-tasks highlight-icon"> </i>
                        <p>Trip Master</p>
                    </a>
                    <hr>
                </li>

                <li class="nav-item"><a href="emailConfig" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("emailConfig")) {
				out.print("active");
			}%>                            
                            ">
                        <i class="nav-icon fas fa-envelope"></i>
                        <p>Email Configuration</p>
                    </a></li>


                <li class="nav-item"><a href="notification" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("notification")) {
				out.print("active");
			}%>                            
                            ">

                        <i class="nav-icon fa fa-bell"></i>

                        <p>Notification</p>
                    </a></li>


                <li class="nav nav-treeview">
                <li class="nav-item"><a href="addUsers" class="nav-link
                           <%if (request.getParameter("pagename").equalsIgnoreCase("addUsers")) {
                               out.print("active");
                       }%>

                ">
                        <i class="nav-icon fas fa-user"></i>
                        <p>Users</p>
                    </a></li>

                <li class="nav-item"><a href="vendorRegistrastion" target="_blank" rel="noopener noreferrer" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("vendorRegistrastion")) {
				out.print("active");
			}%>                            
                            ">


                        <i class="nav-icon fas fa-registered"></i>

                        <p>Vendor Registrastion</p>
                    </a></li>

                <li class="nav-item"><a href="vendorReports" rel="noopener noreferrer" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("vendorReports")) {
				out.print("active");
			}%>                            
                            ">

                        <i class="nav-icon fas fa-download"></i>
                        <p>Vendor Reports</p>
                    </a></li>

                <li class="nav-item"><a href="vendorDetails" class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("Vendor Details")) {
				out.print("active");
			}%>                            
                            ">
                        <i class="nav-icon fa fa-user-circle"></i>
                        <p>Vendor Details</p>
                    </a>
                    <hr>
                </li>

            </ul>
            <hr>

        </nav>
    </div>
</aside>
