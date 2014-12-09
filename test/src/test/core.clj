(ns test.core
  (:require [clojure.test :refer :all]
            [hivewing-core.hive-manager :refer :all]
            [hivewing-core.configuration :refer :all]
            [hivewing-core.hive :refer :all]
            [hivewing-core.hive-image :refer :all]
            [hivewing-core.apiary :refer :all]
            [hivewing-core.worker :refer :all]
            [hivewing-core.worker-config :refer :all]
            [hivewing-core.pubsub :refer :all]
            [hivewing-core.public-keys :refer :all]
            [hivewing-core.beekeeper :refer :all])
  (:gen-class))

(defn -main
  "I run some startup tests"
  [& args]
  (let [bk (beekeeper-find-by-email "tester@test.com")]
      (if bk
        (public-keys-delete (:uuid bk))
        ; Delete their manager records
        (doseq [manager-uuid (hive-managers-managing (:uuid bk))]
          (hive-manager-delete manager-uuid))
        )
      ((beekeeper-create {:email "tester@test.com"}))
      )

  (let [beekeeper-uuid (:uuid (beekeeper-find-by-email "tester@test.com"))
        apiary-uuid    (:uuid (apiary-create {:beekeeper_uuid beekeeper-uuid}))
        hive-uuid      (:uuid (hive-create {:apiary_uuid apiary-uuid}))
        hive-manager-uuid (:uuid   (hive-manager-create hive-uuid beekeeper-uuid))
        worker-result  (worker-create {:apiary_uuid apiary-uuid :hive_uuid hive-uuid})
        worker-retrieval  (worker-get (:uuid worker-result))
        ]

    (println "Could create all this stuff...")
    (println "Now try to push git to the hive repo w/ this user.")
    (println "should fail!")

    (let [public-key     (slurp "tester@test.com.pub")
          pk-create-result  (public-key-create beekeeper-uuid public-key)]

      (println "Can now push to the repo! b/c we added public key")
      (println "Deleting the repo")
      (println "Now we can't push to the repo!")
    )))
