package com.main.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.repo.SupDetailsRepo;
import com.main.db.bpaas.repo.UserRepository;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	HttpServletRequest request;
	
	@Autowired
	SupDetailsRepo supDetailsRepo;

	@Value("${isssoEnable}")
	public String isssoEnable;

	@Value("${titleName}")
	public String titleName;

	@Value("${logoPath}")
	public String logoPath;

	@Value("${sideLogoName}")
	public String sideLogoName;

	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String username) {

		List<String> userStatusList = new ArrayList<>();

		userStatusList.add(GlobalConstants.ACTIVE_STATUS);
		userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);

		User user = userRepository.findByUsernameAndStatusIn(username, userStatusList);
		if (user == null) {
			throw new UsernameNotFoundException(username);
		}

		// Http requst= request.get

		request.getSession().setAttribute("userName", user.getUsername());
		request.getSession().setAttribute("userEmail", user.getEmailId());
		request.getSession().setAttribute("userId", user.getId());
		request.getSession().setAttribute("firstName", user.getFirstName());
		request.getSession().setAttribute("lastName", user.getLastName());
		request.getSession().setAttribute("role", user.getRolesObj().getRoleName());
		request.getSession().setAttribute("mobileNo", user.getContactNo());
		request.getSession().setAttribute("status", user.getStatus());
		if (user.getLastName() == null) {
			request.getSession().setAttribute("fullName", user.getFirstName());
		} else {
			request.getSession().setAttribute("fullName", user.getFirstName() + " " + user.getLastName());
		}

		request.getSession().setAttribute("titleName", titleName);
		request.getSession().setAttribute("logoPath", logoPath);
		request.getSession().setAttribute("sideLogoName", sideLogoName);

		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
//        for (Role role : user.getRoles()) {
//            grantedAuthorities.add(new SimpleGrantedAuthority(role.getName()));
//        }

		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
				grantedAuthorities);
	}

}
