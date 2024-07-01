package com.example.StudyKafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.stereotype.Service;

import java.util.concurrent.CompletableFuture;

@Service
public class KafkaProducerService {
    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    @Autowired
    private KafkaTemplate<String, MyMessage> newKafkaTemplate;

    private static final String TOPIC_NAME = "topic5";

    public void sendJson(MyMessage message) {
//        System.out.println("published a message :" + message.getName() + ", " + message.getMessage());
        newKafkaTemplate.send(TOPIC_NAME, message);
    }

    public void send(String message) {
        kafkaTemplate.send(TOPIC_NAME, message);
    }

    public void sendWithCallBack(String message) {
        CompletableFuture<SendResult<String, String>> future = kafkaTemplate.send(TOPIC_NAME, message);
        future.whenComplete((result, ex) -> {
            if (ex == null) {
                // 성공 시 로직
                System.out.println("Sent message=[" + message +
                        "] with offset=[" + result.getRecordMetadata().offset() + "]");
            } else {
                // 실패 시 로직
                System.err.println("Unable to send message=["
                        + message + "] due to : " + ex.getMessage());
            }
        });
    }
}
