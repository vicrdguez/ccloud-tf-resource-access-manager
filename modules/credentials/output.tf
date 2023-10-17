output "app_config" {
  value = <<-EOT
  ##### Configuration for ${var.app_name} #####
  # Required connection configs for Kafka producer, consumer, and admin
  bootstrap.servers=${data.confluent_kafka_cluster.cluster.bootstrap_endpoint}
  security.protocol=SASL_SSL
  sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username='${confluent_api_key.ak.id}' password='${confluent_api_key.ak.secret}';
  sl.mechanism=PLAIN
  # Required for correctness in Apache Kafka clients prior to 2.6
  client.dns.lookup=use_all_dns_ips
  # Best practice for higher availability in Apache Kafka clients prior to 3.0
  session.timeout.ms=45000
  # Best practice for Kafka producer to prevent data loss
  acks=all
  EOT
}

output "service_account_id" {
  value = confluent_service_account.sa.id
}
