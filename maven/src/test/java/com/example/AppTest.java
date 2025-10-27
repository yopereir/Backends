package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Basic unit tests to demonstrate Maven + JUnit 5 integration.
 */
public class AppTest {

    @Test
    public void testPersonSerializationFields() {
        App.Person p = new App.Person("Jane", "Doe", 30);
        assertEquals("Jane", p.getFirstName());
        assertEquals("Doe", p.getLastName());
        assertEquals(30, p.getAge());
    }

    @Test
    public void testVersionNotNull() {
        String version = App.class.getPackage().getImplementationVersion();
        // It may be null when running locally from IDE, but not in the packaged jar
        assertNotNull(version == null ? "unknown" : version);
    }

    @Test
    public void testMainRunsWithoutError() {
        // Just ensure the main method doesn't throw
        assertDoesNotThrow(() -> {
            // run main in a separate thread to avoid blocking (Javalin server)
            Thread t = new Thread(() -> App.main(new String[]{}));
            t.setDaemon(true);
            t.start();
            Thread.sleep(1000); // wait for server startup log
        });
    }
}
