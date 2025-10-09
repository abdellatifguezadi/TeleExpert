package com.example.teleexpertise.config;

import com.example.teleexpertise.util.HibernateUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class HibernateInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Initializing Hibernate...");
        HibernateUtil.getEntityManager().close();
        System.out.println("Hibernate initialized successfully!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
