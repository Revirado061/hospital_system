package org.example.springboothospitalsystem.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;

import java.util.HashMap;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class HighConcurrencyTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    public void testGuahaoConcurrency() throws Exception {
        // 创建两个线程模拟并发请求
        Thread thread1 = new Thread(() -> {
            String url = "http://localhost:8081/patient/guahao?id=1&account=yantan";

            // 发送 POST 请求，不带请求体
            String response = restTemplate.postForObject(url, null, String.class);

            // 打印响应结果
            System.out.println("Response: " + response);
        });

        Thread thread2 = new Thread(() -> {
            String url = "http://localhost:8081/patient/guahao?id=1&account=bxue";

            // 发送 POST 请求，不带请求体
            String response = restTemplate.postForObject(url, null, String.class);

            // 打印响应结果
            System.out.println("Response: " + response);
        });

        thread1.start();
        thread2.start();

        thread1.join();
        thread2.join();

        // 验证结果，检查数据库中挂号记录的数量等
    }
}