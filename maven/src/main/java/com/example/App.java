package com.example;

import com.google.gson.Gson;
import io.javalin.Javalin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A small demo web app showcasing key Maven features:
 * - Uses Gson for JSON serialization
 * - Uses SLF4J + Logback for logging
 * - Reads Implementation-Version from JAR Manifest
 * - Exposes REST endpoints using Javalin
 */
public class App {

    private static final Logger logger = LoggerFactory.getLogger(App.class);
    private static final Gson gson = new Gson();

    public static void main(String[] args) {
        String env = System.getProperty("env", "dev");

        // Fix: make version final for use inside lambdas
        String rawVersion = App.class.getPackage().getImplementationVersion();
        final String version = (rawVersion != null) ? rawVersion : "unknown";

        logger.info("Starting Maven Demo App in {} mode", env);
        logger.info("App version: {}", version);

        // Example object
        Person person = new Person("Don", "Jon", 35);
        logger.info("Serialized example JSON: {}", gson.toJson(person));

        // Start lightweight REST server
        Javalin app = Javalin.create(config -> {
            config.showJavalinBanner = false;
        }).start(8080);

        app.get("/", ctx -> ctx.result("Maven Demo App is running!"));
        app.get("/health", ctx -> ctx.result("OK"));
        app.get("/version", ctx -> ctx.result(version));
        app.get("/person", ctx -> ctx.result(gson.toJson(person)));

        logger.info("Server started on port 8080. Endpoints: /, /health, /version, /person");
    }

    // Simple POJO
    static class Person {
        private final String firstName;
        private final String lastName;
        private final int age;

        public Person(String firstName, String lastName, int age) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.age = age;
        }

        public String getFirstName() { return firstName; }
        public String getLastName() { return lastName; }
        public int getAge() { return age; }
    }
}
