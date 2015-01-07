{
 :dev {
   :ragtime { :database "jdbc:postgresql://127.0.0.1:4300/hivewing?user=hivewing&password=hivewing"}
   :env {
     :hivewing-redis-uri "redis://127.0.0.1:3900/"

     :hivewing-aws-access-key "123abc",
     :hivewing-aws-secret-key "123abc",
     :hivewing-sqs-endpoint "http://127.0.0.1:4100"
     :hivewing-sqs-hive-images-queue "dev-hive-images-changes"
     :hivewing-sql-connection-string "//127.0.0.1:4300/hivewing?user=hivewing&password=hivewing"
     :hivewing-gitolite-root "/home/gitolite/.gitolite"
     :hivewing-gitolite-shell-command "/home/gitolite/bin/gitolite"
     :hivewing-gitolite-repositories-root "/home/gitolite/repositories"
     :hivewing-hive-images-bucket-name "hive-images.hivewing.io"
     :hivewing-s3-endpoint "http://127.0.0.1:4200"
    },
   },
 :test {
   :ragtime { :database "jdbc:postgresql://127.0.0.1:4301/hivewing?user=hivewing&password=hivewing" }
    :env {
     :hivewing-redis-uri "redis://127.0.0.1:3901/"
     :hivewing-aws-access-key "123abc",
     :hivewing-aws-secret-key "123abc",
     :hivewing-sqs-endpoint "http://127.0.0.1:4101/"
     :hivewing-sqs-hive-images-queue "test-hive-images-changes"
     :hivewing-sql-connection-string "//127.0.0.1:4301/hivewing?user=hivewing&password=hivewing"
     :hivewing-gitolite-shell-command "/home/gitolite/bin/gitolite"
     :hivewing-gitolite-root "/home/gitolite/.gitolite"
     :hivewing-gitolite-repositories-root "/home/gitolite/repositories"
     :hivewing-hive-images-bucket-name "hive-images.hivewing.io"
     :hivewing-s3-endpoint "http://127.0.0.1:4201"
    }
  }
}
