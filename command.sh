tar -zxvf kafka_2.13-2.8.2.tgz

cd kafka_2.13-2.8.2

# 주키퍼 실행
bin/zookeeper-server-start.sh config/zookeeper.properties

# 카프카 실행
bin/kafka-server-start.sh config/server.properties

# topic 생성
bin/kafka-topics.sh --create --topic topic-example1 --bootstrap-server localhost:9092

# topic 확인
bin/kafka-topics.sh --describe --topic topic-example1 --bootstrap-server localhost:9092

# producer 실행
bin/kafka-console-producer.sh --topic topic-example1 --bootstrap-server localhost:9092

# consumer 실행
bin/kafka-console-consumer.sh --topic topic-example1 --from-beginning ---bootstrap-server localhost:9092