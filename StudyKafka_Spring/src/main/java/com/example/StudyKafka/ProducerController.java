package com.example.StudyKafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ProducerController {

    @Autowired
    private KafkaProducerService kafkaProducerService;

    @RequestMapping("/publish")
    public String publish(String message) {
        kafkaProducerService.send(message);
        return "published a message :" + message;
    }

    @RequestMapping("/publish2")
    public String publishWithCallBack(String message) {
        kafkaProducerService.sendWithCallBack(message);
        return "published a message :" + message;
    }

    @RequestMapping("/publish3")
    public String publishWithJson(MyMessage message) {
        kafkaProducerService.sendJson(message);
        return "published a message :" + message.getName() + ", " + message.getMessage();
    }
}
