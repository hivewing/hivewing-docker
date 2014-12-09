{
 :dev {
  :env {
     :hivewing-redis-uri "redis://127.0.0.1:3900/"

     :hivewing-aws-access-key "123abc",
     :hivewing-aws-secret-key "123abc",
     :hivewing-sqs-endpoint "http://127.0.0.1:4100"
     :hivewing-sqs-hive-images-queue "dev-hive-images-changes"
     :hivewing-ddb-endpoint   "http://127.0.0.1:3800",
     :hivewing-ddb-worker-config-table "HivewingWorkerConfiguration.v1"
     :hivewing-sql-connection-string "//127.0.0.1:4300/hivewing?user=hivewing&password=hivewing"
     :hivewing-gitolite-root "/home/gitolite/.gitolite"
     :hivewing-gitolite-shell-command "/home/gitolite/bin/gitolite"
     :hivewing-gitolite-repositories-root "/home/gitolite/repositories"
     :hivewing-hive-images-bucket-name "hive-images.hivewing.io"
     :hivewing-s3-endpoint "http://127.0.0.1:4200"
  }}}
