package org.example.springboothospitalsystem.utils;

import org.example.springboothospitalsystem.service.PatientService;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
public class KafkaConsumer {
    private final PatientService patientService;

    public KafkaConsumer(PatientService patientService) {
        this.patientService = patientService;
    }

    @KafkaListener(topics = "guahao-topic", groupId = "group-id")
    public void receive(String message) {
        try {
            // 解析消息内容
            String[] parts = message.split(",");
            if (parts.length == 2) {
                Long id = Long.parseLong(parts[0]); // 获取 id 部分
                String account = parts[1]; // 获取 account 部分
                // 调用 patientService 的 guahao 方法处理挂号逻辑
                patientService.guahao(id, account);
                System.out.println("Processed guahao request: " + message);
            } else {
                System.err.println("Invalid message format: " + message);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid message format: " + message);
        } catch (Exception e) {
            System.err.println("Error processing message: " + message);
            e.printStackTrace();
        }
    }
}