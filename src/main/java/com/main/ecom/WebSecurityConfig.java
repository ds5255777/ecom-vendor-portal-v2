package com.main.ecom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.context.request.RequestContextListener;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserDetailsService userDetailsService;

    @Value("${isssoEnable}")
	public  String isssoEnable;
    
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	
    	if(isssoEnable.equalsIgnoreCase("yes")) {
    		http
            .authorizeRequests()
            .antMatchers("/assets/**","/api/**","/dist/**","/js/**","/build/**","/plugins/**","/login","/autoLogin","/registration","/SaveRegistration","/getUserInfo","/getDocImage","/ajaxController/**").permitAll()
            .anyRequest().authenticated()
            .and()
            .formLogin()
            .loginPage("/autoLogin")
            .permitAll()
            .defaultSuccessUrl("/dashboard")
            .and()
            .logout()
            .permitAll();
    	}
    	else {
    		http
            .authorizeRequests()
            .antMatchers("/assets/**","/api/**","/dist/**","/js/**","/build/**","/plugins/**","/login","/autoLogin","/registrationstep6","/registration","/SaveRegistration","/getUserInfo","/getDocImage","/ajaxController/**").permitAll()
            .anyRequest().authenticated()
            .and()
            .formLogin()
            .loginPage("/login")
            .permitAll()
            .defaultSuccessUrl("/dashboard")
            .and()
            .logout()
            .permitAll();
    	}
    	
        
    	http.headers().frameOptions().disable();
         http.cors().and().csrf().disable();
    }
    
 
    @Bean
    public AuthenticationManager customAuthenticationManager() throws Exception {
        return authenticationManager();
    }

    @Bean 
	public RequestContextListener requestContextListener(){
	    return new RequestContextListener();
	}
    
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder());
        System.out.println("auth.."+auth);
    }
}

