package com.main.ecom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.firewall.StrictHttpFirewall;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter implements WebMvcConfigurer {

    @Autowired
    private UserDetailsService userDetailsService;

    @Value("${isssoEnable}")
	public  String isssoEnable;
    
    @Value("${allowedOrigins}")
	public  String allowedOrigins;
    
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    public void configure(WebSecurity web){
    	StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowedHostnames(hostname -> hostname.equals(allowedOrigins));
        web
            .httpFirewall(firewall);
    }
    
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	
    		http
            .authorizeRequests()
            .antMatchers("/document/**","/assets/**","/api/**","/dist/**","/js/**","/css/**","/build/**","/plugins/**","/login","/error","/autoLogin","/registrationstep6","/registration","/SaveRegistration","/getUserInfo","/getDocImage","/ajaxController/**").permitAll()
            .anyRequest().authenticated()
            .and()
            .formLogin()
            .loginPage("/login")
            .permitAll()
            .defaultSuccessUrl("/dashboard")
            .and()
            .logout()
            .permitAll()
            .and()
            .headers().xssProtection()
            .and().contentSecurityPolicy("script-src 'self'");
    		
    		http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
        
//    	http.headers().frameOptions().disable();
         http.csrf().disable();
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
    }
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        
        registry.addMapping("/**")
                .allowedOrigins(allowedOrigins.split(","));
    }
}

