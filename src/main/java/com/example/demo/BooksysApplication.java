package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@ServletComponentScan
@EnableCaching
public class BooksysApplication {

	public static void main(String[] args) {
		SpringApplication.run(BooksysApplication.class, args);
	}

}
