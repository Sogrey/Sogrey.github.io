---
title: Springboot跨域请求
date: 2020-12-26 22:18:03
tags: [Java,Spring boot]
categories: Java
comments: true
toc: true
---

Spring Boot部署起来可以很简单，但是只要部署在网络就存在跨域问题，Springboot添加跨域请求的处理也有好几种方法。

<!--more-->

## 增加注解@CrossOrigin

在需要跨域的类或方法上方增加注解`@CrossOrigin`，只针对单个方法或类有效，适用于只有个别方法需要跨域的情况。

``` java
@Controller // 标明这是一个SpringMVC的Controller控制器
@CrossOrigin
@RequestMapping(value = "/api")
public class HelloController {
	@Autowired
	private Environment env;

	@RequestMapping("/")
	@ResponseBody
	@CrossOrigin
	public String hello() {
		return "hello world";
	}
}
```

## 支持跨域请求的 Configuration

``` java
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * 处理AJAX请求跨域的问题
 */
@Configuration
public class CorsConfig extends WebMvcConfigurerAdapter {
    static final String ORIGINS[] = new String[] { "GET", "POST", "PUT", "DELETE" };
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**").allowedOrigins("*").allowCredentials(true).allowedMethods(ORIGINS)
                .maxAge(3600);
    }
}
```

## 跨域过滤器
    
此法亲测可用。

``` java
@SpringBootApplication
@ComponentScan
@EnableDiscoveryClient
public class ManagementApplication {

    public static void main(String[] args) {
        SpringApplication.run(ManagementApplication.class, args);
    }

    private CorsConfiguration buildConfig() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.addAllowedOrigin("*");
        corsConfiguration.addAllowedHeader("*");
        corsConfiguration.addAllowedMethod("*");
        return corsConfiguration;
    }

    /**
     * 跨域过滤器
     */
    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", buildConfig()); 
        return new CorsFilter(source);
    }
}
```
也可以单独出来一个加注解`@Configuration`的类：
``` java
import org.springframework.context.annotation.Bean;  
import org.springframework.context.annotation.Configuration;  
import org.springframework.web.cors.CorsConfiguration;  
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;  
import org.springframework.web.filter.CorsFilter;  
  
@Configuration  
public class CorsConfig {  
    private CorsConfiguration buildConfig() {  
        CorsConfiguration corsConfiguration = new CorsConfiguration();  
        corsConfiguration.addAllowedOrigin("*"); // 1  
        corsConfiguration.addAllowedHeader("*"); // 2  
        corsConfiguration.addAllowedMethod("*"); // 3  
        return corsConfiguration;  
    }  
  
    @Bean  
    public CorsFilter corsFilter() {  
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();  
        source.registerCorsConfiguration("/**", buildConfig()); // 4  
        return new CorsFilter(source);  
    }  
}
```

## Filter过滤器

``` java
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

/**
 * 处理跨域问题
 */
@Component
public class OriginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
            FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) res;
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE,PUT");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
    }
}
```

## 参考

- [Springboot 处理跨域请求](https://my.oschina.net/u/2351298/blog/1813710)