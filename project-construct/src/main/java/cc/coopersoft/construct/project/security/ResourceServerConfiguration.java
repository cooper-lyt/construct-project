package cc.coopersoft.construct.project.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;

@Configuration
@Order(1)
public class ResourceServerConfiguration extends ResourceServerConfigurerAdapter {

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/publish/**").permitAll()
                .antMatchers("/mgr/**").hasAuthority("DATA_MGR")
                .antMatchers("/view/**").hasAuthority("Master")
                .anyRequest().authenticated();

    }

}
