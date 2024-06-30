package com.example.StudyKafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class KafkaProducerService {
    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    private static final String TOPIC_NAME = "topic5";

    public void send(String message) {
        kafkaTemplate.send(TOPIC_NAME, message);
    }
}
