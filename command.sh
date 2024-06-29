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

# topic1 생성
bin/kafka-topics.sh --create --topic topic-example1 --bootstrap-server localhost:9092

bin/kafka-console-producer.sh --topic topic1 --bootstrap-server localhost:9092

bin/kafka-console-consumer.sh --topic topic1 --group team-a --from-beginning --bootstrap-server localhost:9092

bin/kafka-consumer-groups.sh --group team-a --describe --bootstrap-server localhost:9092

# 카프카 클러스터 구성 후 topic 생성
bin/kafka-topics.sh --create --topic topic2 --bootstrap-server localhost:9093 --partitions 3 --replication-factor 2

bin/kafka-topics.sh --describe --topic topic2 --bootstrap-server localhost:9093

#############################################
bin/kafka-topics.sh --create --topic topic3 --partitions 1 --bootstrap-server localhost:9093
bin/kafka-topics.sh --describe --topic topic3 --bootstrap-server localhost:9093

# 운영중인 topic에 파티션 추가
bin/kafka-topics.sh --alter --topic topic3 --partitions 3 --bootstrap-server localhost:9093

# topic의 record가 삭제되기 까지의 시간을 수정
bin/kafka-configs.sh --alter --entity-type topics --entity-name topic3 --add-config retention.ms=86400000 --bootstrap-server localhost:9092

# acks = producer가 broker로 메세지를 보낸 후 브로커의 수신응답 메세지를 어떤식으로 처리하겟다
# 0, 1, all
# 0 = 브로커로 메세지를 보낸후 카프카의 응답메세지를 듣지 않고 성공으로 처리(가장 빠른속도, 그순간에 브로커가 장애가 난다면 매세지가 유실될수도 있다.)
# 1 = 리더파티션의 성공응답값을 확인한다. 장애상황시 메세지 유실 가능성은 조금은 있지만 꽤 많은 토픽에서 설정할 수 잇다.
# all = 하나 이상의 팔로우 파티션의 성공 응답도 확인한다. 메세지 유실 가능성은 거의 사라진다. 중요한 유즈케이스에 자주 사용, min.insync.replicas 옵션과 결합하여 성공적인 전송여부를 확인
# message-send-max-retries = 브로커장애와 같은 상황에서 프로듀서에서 몇번이나 재전송할지 
bin/kafka-console-producer.sh --topic topic3 --request-required-acks 1 --message-send-max-retries 50 --bootstrap-server

# verifiable 프로듀서는 string 타입의 넘버를 반복적으로 발행해준다.(테스트용도)
bin/kafka-verifiable-producer.sh --topic topic3 --max-messages 100 --bootstrap-server localhost:9092

# from-beginning 옵션은 current offset이 없을 경우 토픽이 가지고 있는 첫 레코드부터 가져오겟다
# 컨슈머가 접속한 이유 신규로 생성된 메세지부터 컨슘을 하게 된다
# group이 잇으면 current offset 생기는데 
bin/kafka-console-consumer.sh --topic topic3 --from-beginning --bootstrap-server localhost:9092
bin/kafka-console-consumer.sh --topic topic3 --from-beginning --group group1 --bootstrap-server localhost:9092

# property 옵션 = 메세지의 키값도 표시가능
bin/kafka-console-consumer.sh --topic topic3 --from-beginning --group group2 --property print.key=true --property key.separator="-" --bootstrap-server localhost:9092

bin/kafka-consumer-groups.sh --list --bootstrap-server localhost:9092
bin/kafka-consumer-groups.sh --describe --group group1 --bootstrap-server localhost:9092



bin/connect-standalone.sh config/connect-standalone.properties config/connect-file-sink.properties
