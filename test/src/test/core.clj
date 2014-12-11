(ns test.core
  (:require [clojure.test :refer :all]
            [clojure.java.shell]
            [hivewing-core.hive-manager :refer :all]
            [hivewing-core.configuration :refer :all]
            [hivewing-core.hive :refer :all]
            [hivewing-core.hive-image :refer :all]
            [hivewing-core.hive-image-notification :refer :all]
            [hivewing-core.apiary :refer :all]
            [hivewing-core.worker :refer :all]
            [hivewing-core.worker-config :refer :all]
            [hivewing-core.pubsub :refer :all]
            [hivewing-core.public-keys :refer :all]
            [hivewing-core.beekeeper :refer :all])
  (:gen-class))

(comment
  (cleanup-beekeeper "testing1@gmail.com")
  (def res (create-beekeeper "testing1@gmail.com"))
  (def hive-uuid (:hive-uuid res))
  (def pk (slurp "./testuser.public"))
  (public-key-create (:bk-uuid res) pk)
  (push-repo (str "ssh://git@localhost:5022/" hive-uuid) "./tester@test.com")
  (def beekeeper-uuid (:uuid (beekeeper-find-by-email "testing1@gmail.com")))
  (hive-images-notification-send-hive-update-message hive-uuid)

  )


(defn cleanup-beekeeper
  [email]
  (if-let [bk (beekeeper-find-by-email email)]
    (let [apiary (apiary-find-by-beekeeper (:uuid bk))
          hives  (apiary-get-hives (:uuid apiary))]
      (doseq [{hive-uuid :uuid} hives]
        ; Delete all the workers in hive
        (doseq [{worker-uuid :uuid} (worker-list hive-uuid :page 1 :per-page 100)]
          (println "Deleting worker" worker-uuid)
          (worker-delete worker-uuid))
        ; Delete hive managers for hive

        (doseq [{hive-manager-uuid :uuid} (hive-managers-get hive-uuid)]
          (println "Deleting hivemgr " hive-manager-uuid)
            (hive-manager-delete hive-manager-uuid))
        ; Delete hive
        (println "Delete hive")
        (hive-delete hive-uuid))
      ; Delete the apiary
      (apiary-delete (:uuid apiary))
      ; Delete the beekeeper
      (beekeeper-delete (:uuid bk)))))

(defn create-beekeeper
  [email]
  (do
    (cleanup-beekeeper email)
    (let [beekeeper-uuid (:uuid (beekeeper-create {:email email}))
        apiary-uuid    (:uuid (apiary-create {:beekeeper_uuid beekeeper-uuid}))
        hive-uuid      (:uuid (hive-create {:apiary_uuid apiary-uuid}))
        hive-manager-uuid (:uuid   (hive-manager-create hive-uuid beekeeper-uuid))
        worker-result  (worker-create {:apiary_uuid apiary-uuid :hive_uuid hive-uuid})
        worker-retrieval  (worker-get (:uuid worker-result))
        ]
      (println "Created user " email)

      (hash-map :bk-uuid beekeeper-uuid
                :apiary-uuid apiary-uuid
                :hive-uuid hive-uuid
                :worker-uuid (:uuid worker-retrieval)))))
(defn push-repo
  "Push a repo locally to the target"
  [repo-path target-url]
  (clojure.java.shell/sh "./push-repo.sh" target-url))

(defn -main
  "I run some startup tests"
  [& args]

  (let [data (create-beekeeper "tester@test.com")
        beekeeper-uuid (:bk-uuid data)]
    (println "Could create all this user stuff...")

    (println "Now try to push git to the hive repo w/ this user.")

    (println "should fail!")

    (let [public-key     (slurp "testuser.public")
          pk-create-result  (public-key-create beekeeper-uuid public-key)]

      (println "Can now push to the repo! b/c we added public key")
      (println "Deleting the repo")
      (println "Now we can't push to the repo!")
    )))
