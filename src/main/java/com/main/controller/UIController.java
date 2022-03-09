package com.main.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.RolesEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.repo.InvoiceDetailsRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.main.service.UserService;
import com.main.serviceManager.ServiceManager;

@Controller
public class UIController {

	@Value("${maxFileSize}")
	public String maxFileSize;

	@Autowired
	ServiceManager serviceManager;

	@Autowired
	UserService userService;

	@Autowired
	TripDetailsRepo tripDetailsRepo;

	@Autowired
	InvoiceDetailsRepo invoiceDetailsRepo;

	@GetMapping({ "/login" })
	public String login(Model model, String error, String logout) {
//		  RolesEntity r=new RolesEntity();
//		  r.setIsActive(GlobalConstants.ACTIVE_STATUS); 
//		  r.setRoleName("Admin");
//		  RolesEntity r2=serviceManager.rolesRepository.save(r);
//		  User u= new User();
//		  u.setPassword("admin"); u.setUsername("admin");
//		  u.setStatus(GlobalConstants.ACTIVE_STATUS); 
//		  u.setRoleId(r2.getId());
//		  userService.save(u);
		model.addAttribute("userForm", new User());

		if (error != null) {
			model.addAttribute("error", "Your username and password is invalid.");
		}

		if (logout != null) {
			model.addAttribute("message", "You have been logged out successfully.");
		}

		return "login";
	}

	@GetMapping("/registration")
	public String registration(Model model) {

		model.addAttribute("maxFileSize", maxFileSize);

		/*
		 * String regNo="ECOM-".concat(new
		 * SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
		 * model.addAttribute("regNo", regNo);
		 * 
		 * System.out.println(regNo);
		 */
		return "registration";
	}

	@GetMapping("/getUserInfo")
	@ResponseBody
	public String getUserInfo(HttpServletRequest request, HttpServletResponse response) {
//      			request.getRequestURL();
		String auth = request.getHeader("Authorization");
		if (auth == null) {
			response.setStatus(response.SC_UNAUTHORIZED);
			response.setHeader("WWW-Authenticate", "NTLM");
			try {
				response.flushBuffer();
			} catch (IOException e) {
				// e.printStackTrace();
			}
		} else if (auth.startsWith("NTLM ")) {
			byte[] msg = new byte[0];
			try {
				msg = new sun.misc.BASE64Decoder().decodeBuffer(auth.substring(5));
			} catch (IOException e) {
				e.printStackTrace();
			}
			int off = 0, length, offset;
			if (msg[8] == 1) {
				byte z = 0;
				byte[] msg1 = { (byte) 'N', (byte) 'T', (byte) 'L', (byte) 'M', (byte) 'S', (byte) 'S', (byte) 'P', z,
						(byte) 2, z, z, z, z, z, z, z, (byte) 40, z, z, z, (byte) 1, (byte) 130, z, z, z, (byte) 2,
						(byte) 2, (byte) 2, z, z, z, z, z, z, z, z, z, z, z, z };
				System.out.println(msg1);
				System.out.println(new sun.misc.BASE64Encoder().encodeBuffer(msg1));
				response.setHeader("WWW-Authenticate",
						"NTLM " + new sun.misc.BASE64Encoder().encodeBuffer(msg1).trim());
				try {
					response.sendError(response.SC_UNAUTHORIZED);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else if (msg[8] == 3) {
				off = 30;

				length = msg[off + 17] * 256 + msg[off + 16];
				offset = msg[off + 19] * 256 + msg[off + 18];
				// String remoteHost = new String(msg, offset, length);

				length = msg[off + 1] * 256 + msg[off];
				offset = msg[off + 3] * 256 + msg[off + 2];
				String domain = "";
				for (int i = offset; i < offset + length; i++) {
					System.out.println(msg[i]);
					if (msg[i] != 0) {
						domain = domain + new Character((char) msg[i]).toString();
					}

				}

				length = msg[off + 9] * 256 + msg[off + 8];
				offset = msg[off + 11] * 256 + msg[off + 10];
				// String username = new String(msg, offset, length);

				String username = "";
//      	              = new String(msg, offset, length);

				String newUser = "";
				for (int i = offset; i < offset + length; i++) {
					System.out.println(msg[i]);
					if (msg[i] != 0) {
						username = username + new Character((char) msg[i]).toString();
					}

				}
				System.out.println("asdfsad---> " + username + ", domain: " + domain);
				return " name:" + username + ", domain: " + domain;

				// Check With DB if USerNAme and Damain Exists
				// Set Session for User - check this session in every controller "validUser"
				// if user Does not exists "USer is not Authorised"
//      	                return "redirect:autoLogin";

			}
		}
		return "error";
	}

	@GetMapping({ "/autoLogin" })
	public String authWithHttpServletRequest(HttpServletRequest request, HttpServletResponse response) {

		String auth = request.getHeader("Authorization");
		if (auth == null) {
			response.setStatus(response.SC_UNAUTHORIZED);
			response.setHeader("WWW-Authenticate", "NTLM");
			try {
				response.flushBuffer();
			} catch (IOException e) {
				// e.printStackTrace();
			}
		} else if (auth.startsWith("NTLM ")) {
			byte[] msg = new byte[0];
			try {
				msg = new sun.misc.BASE64Decoder().decodeBuffer(auth.substring(5));
			} catch (IOException e) {
				e.printStackTrace();
			}
			int off = 0, length, offset;
			if (msg[8] == 1) {
				byte z = 0;
				byte[] msg1 = { (byte) 'N', (byte) 'T', (byte) 'L', (byte) 'M', (byte) 'S', (byte) 'S', (byte) 'P', z,
						(byte) 2, z, z, z, z, z, z, z, (byte) 40, z, z, z, (byte) 1, (byte) 130, z, z, z, (byte) 2,
						(byte) 2, (byte) 2, z, z, z, z, z, z, z, z, z, z, z, z };
				response.setHeader("WWW-Authenticate",
						"NTLM " + new sun.misc.BASE64Encoder().encodeBuffer(msg1).trim());
				try {
					response.sendError(response.SC_UNAUTHORIZED);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else if (msg[8] == 3) {
				off = 30;

				length = msg[off + 17] * 256 + msg[off + 16];
				offset = msg[off + 19] * 256 + msg[off + 18];
				// String remoteHost = new String(msg, offset, length);

				length = msg[off + 1] * 256 + msg[off];
				offset = msg[off + 3] * 256 + msg[off + 2];
				// String domain = new String(msg, offset, length);
				String domain = "";
				for (int i = offset; i < offset + length; i++) {
					System.out.println(msg[i]);
					if (msg[i] != 0) {
						domain = domain + new Character((char) msg[i]).toString();
					}

				}

				length = msg[off + 9] * 256 + msg[off + 8];
				offset = msg[off + 11] * 256 + msg[off + 10];
				System.out.println("asdasdasd+++>>>> " + new sun.misc.BASE64Encoder().encodeBuffer(msg));
				String username = "";
//      	                = new String(msg, offset, length);

				String newUser = "";
				for (int i = offset; i < offset + length; i++) {
					System.out.println(msg[i]);
					if (msg[i] != 0) {
						username = username + new Character((char) msg[i]).toString();
					}

				}

				// return remoteHost + " name:" + username + ", domain: " + domain;
				System.out.println("name: " + username + ", domain: " + domain);
				// System.out.println("name: " + username + ", domain: " + domain);
				DefaultSavedRequest savedRequest = (DefaultSavedRequest) request.getSession()
						.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
				System.out.println(savedRequest.getRequestURI());
				System.out.println(savedRequest.getRequestURL());

				String uri = savedRequest.getRequestURI().toString();
				String forwardREQ = "redirect:" + uri.split("/")[uri.split("/").length - 1];

				String contextPath = request.getContextPath();
				System.out.println("contextPath...." + contextPath);
				contextPath = "redirect:" + contextPath.replaceAll("/", "");

				String dashboard = forwardREQ.replaceAll("/", "");
				if (contextPath.equalsIgnoreCase(dashboard)) {
					forwardREQ = "/dashboard";
				}

				// if conp == yniTcketingSystem if app name forwardURL dashboard

				// System.out.println(savedRequest.getParameterMap());
				/*
				 * Map<String, String[]> values= savedRequest.getParameterMap();
				 * 
				 * for (Entry<String, String[]> entry : values.entrySet()) {
				 * System.out.println(entry.getKey() + "/" + entry.getValue()[0]); }
				 */

				Collection<String> parameterNameArray = savedRequest.getParameterNames();
				List<String> allList = new ArrayList<>();
				String paramNameAndValue = "";
				if (parameterNameArray.size() > 0) {

					for (String name : parameterNameArray) {

						paramNameAndValue = name + "=" + savedRequest.getParameterValues(name)[0];
						allList.add(paramNameAndValue);
					}
				}
				if (allList.size() > 0) {

					String delim = "&";
					String paramNameAndValueAll = String.join(delim, allList);
					System.out.println("paramNameAndValueAll..." + paramNameAndValueAll);
					forwardREQ = forwardREQ + "?" + paramNameAndValueAll;
					System.out.println("final url is...." + forwardREQ);
				}

				// forwardREQ= "redirect:"+forwardREQ;

				// System.out.println(savedRequest.getParameterValues("ticketQueId")[0]);
				// for getParameterNames

				try {

					System.out.println(request.getSession().getAttribute("url_prior_login"));
					System.out.println(request.getSession().getAttribute("REDIRECT_URL"));
					System.out.println(request.getAttribute(RequestDispatcher.FORWARD_REQUEST_URI));

					// if for domain and username

					/*
					 * String
					 * check=serviceManager.userRepository.getUserNameAndDomainName(username,domain)
					 * ; if(check!=null) {
					 * 
					 * request.login(username, "ldapPassword"); System.out.println("forwardREQ " +
					 * forwardREQ); return forwardREQ; } else { return "error"; }
					 */

				} catch (Exception e) {
					System.out.println("Error while login " + e);
					return "error";

				}

			}
		}

		return "login";
	}

	@GetMapping({ "/", "/dashboard" })
	public String dashboard(Model model, Principal principal, String error, String logout, HttpServletRequest request) {
		String actionType = "View";
		String action = "Viewed DashBoard";
		String rolename = (String) request.getSession().getAttribute("role");

		User us = userService.findByUsername(principal.getName());

		int totalTripCount = tripDetailsRepo.getTripCount();
		int TotalCloseTripCount = tripDetailsRepo.getCloseTripCount();
		int TotalInTransitTripCount = tripDetailsRepo.getInTransitTripCount();
		int TotalApprovedAdHocTrips = tripDetailsRepo.getApproveAdHocTripCount();

		int pendingInvoice = invoiceDetailsRepo.getPendingInvoiceCount();
		int approveInvoice = invoiceDetailsRepo.getApproveInvoiceCount();
		int rejectInvoice = invoiceDetailsRepo.getRejecteInvoiceCount();

		model.addAttribute("role", rolename);
		model.addAttribute("totalTripCount", totalTripCount);
		model.addAttribute("TotalCloseTripCount", TotalCloseTripCount);
		model.addAttribute("TotalInTransitTripCount", TotalInTransitTripCount);
		model.addAttribute("pendingInvoice", pendingInvoice);
		model.addAttribute("approveInvoice", approveInvoice);
		model.addAttribute("rejectInvoice", rejectInvoice);
		model.addAttribute("TotalApprovedAdHocTrips", TotalApprovedAdHocTrips);

		model.addAttribute("userStatus", us.getStatus());
		// System.out.println("User Status : "+us.getStatus());

		return "dashboard";
	}

	@GetMapping({ "/addUsers" })
	public String addUsers(Model model, String error, String logout, HttpServletRequest request) {

		List<RolesEntity> roleList = serviceManager.rolesRepository.findByIsActive("1");
		model.addAttribute("rolesList", roleList);

		String actionType = "View";
		String action = "Viewed All Users";

//		      serviceManager.insertAddUpdateInMaster(request, action, actionType, null, null, null);

		return "addUsers";

	}

	@GetMapping({ "/emailConfig" })
	public String emailConfig(Model model, String error, String logout, HttpServletRequest request) {

		String actionType = "View";
		String action = "Viewed Email Configuration";

//		      serviceManager.insertAddUpdateInMaster(request, action, actionType, null, null, null);

		return "emailConfig";

	}

	@GetMapping("/logout")
	public String logout(Model model, String error, String logout, HttpServletRequest request, HttpSession session) {

		session.removeAttribute("titleName");
		session.removeAttribute("logoPath");
		session.removeAttribute("sideLogoName");
		session.removeAttribute("userName");
		session.removeAttribute("userId");
		session.removeAttribute("firstName");
		session.removeAttribute("lastName");
		session.removeAttribute("role");
		session.removeAttribute("fullName");

		session.invalidate();

		return "login";

	}

	// vendor ui

	@GetMapping("/allTrips")
	public String allTrips(Model model, Principal principal, HttpServletRequest request) {

		return "allTrips";
	}

	@GetMapping("/tripDetailsView")
	public String tripDetailsView(Model model, Principal principal, HttpServletRequest request) {

		String id = request.getParameter("id");

		List<TripDetails> getTripDetailsById = tripDetailsRepo.getTripDetailsById(id);

		model.addAttribute("id", id);
		model.addAttribute("getTripDetailsById", getTripDetailsById);

		return "tripDetailsView";

	}

	@GetMapping("/closedTrips")
	public String closedTrips(Model model, Principal principal) {

		return "closedTrips";
	}

	@GetMapping("/closedAndApprovedTrips")
	public String closedAndApprovedTrips(Model model, Principal principal) {

		return "closedAndApprovedTrips";
	}

	@GetMapping("/inTransitTrips")
	public String inTransitTrips(Model model, Principal principal) {

		return "inTransitTrips";
	}

	@GetMapping("/pendingApproval")
	public String pendingApproval(Model model, Principal principal, HttpServletRequest request) {

		return "pendingApproval";
	}

	@GetMapping("/invoicesQueue")
	public String invoicesQueue(Model model, Principal principal) {

		return "invoicesQueue";
	}

	@GetMapping("/rejectedInvoice")
	public String rejectedInvoice(Model model, Principal principal) {

		return "rejectedInvoice";
	}

	@GetMapping("/approvedInvoice")
	public String approvedInvoice(Model model, Principal principal) {

		return "approvedInvoice";
	}

	@GetMapping("/pendingInvoice")
	public String pendingInvoice(Model model, Principal principal) {

		return "pendingInvoice";
	}

	@GetMapping("/tripsInvoiceGenerate")
	@ResponseBody
	public ModelAndView tripsInvoiceGenerate(Principal principal, HttpServletRequest request) {

		String tripId = request.getParameter("id");

		tripId = tripId.replaceAll(",", " ");
		
		String[] split = tripId.split(" ");

		ModelAndView modelAndView = new ModelAndView("tripsInvoiceGenerate");
		List<Object> listof = new ArrayList<>();
		TripDetails findByTripID = null;
		try {
			for (String str : split) {
				findByTripID = tripDetailsRepo.findByTripID(str);
				listof.add(findByTripID);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView.addObject("listof", listof);
	}
}
