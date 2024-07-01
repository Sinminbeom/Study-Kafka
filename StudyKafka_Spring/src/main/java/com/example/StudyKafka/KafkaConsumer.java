package com.example.StudyKafka;


import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
public class KafkaConsumer {
    private static final String TOPIC_NAME = "topic5";

    ObjectMapper objectMapper = new ObjectMapper();

    @KafkaListener(topics = TOPIC_NAME)
    public void listenerMessage(String jsonMessage) {
        try {
            MyMessage myMessage = objectMapper.readValue(jsonMessage, MyMessage.class);
            System.out.println(">>> " + myMessage.getName() + ", " + myMessage.getMessage());
        } catch (Exception e) {
            System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!");
            e.printStackTrace();
        }
    }

}
