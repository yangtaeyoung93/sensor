package com.seoulsi.configuration;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.CorsUtils;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.seoulsi.handler.AuthLoginFail;
import com.seoulsi.handler.AuthLoginSuccess;
import com.seoulsi.handler.AuthLogout;

import lombok.RequiredArgsConstructor;

@EnableWebSecurity
@EnableGlobalAuthentication
@RequiredArgsConstructor
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	AuthProvider authProvider;

	@Autowired
	AuthLoginSuccess authLoginSucess;

	@Autowired
	AuthLogout authLogout;

	@Autowired
	AuthLoginFail authLoginFail;

	@Autowired
	SecurityRestConfig securityRestConfig;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().requestMatchers(CorsUtils::isPreFlightRequest).permitAll().antMatchers("/**")
				.permitAll().antMatchers("/**/**").permitAll().and().httpBasic();
		// .and()
		// .formLogin()
		// .loginPage("/login")
		// .loginProcessingUrl("/login/member")
		// .defaultSuccessUrl("/sensor/map")
		// .failureHandler(authLoginFail)
		// // .failureUrl("/login?error")
		// .usernameParameter("username")
		// .passwordParameter("pass")
		// .and()
		// .logout().logoutUrl("/logout")
		// .logoutSuccessHandler(authLogout)
		// .invalidateHttpSession(true)
		// .deleteCookies("JSESSIONID")
		// .permitAll()
		// .and()
		// .authenticationProvider(authProvider);

		http.csrf().disable();
	}

	@Bean
	public HttpFirewall defaultHttpFirewall() {
		return new DefaultHttpFirewall();
	}
}
