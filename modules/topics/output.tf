output "created_topic" {
  value = {
          cluster_id = var.cluster_id
          topic = confluent_kafka_topic.topic.topic_name
      }
}
