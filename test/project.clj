(defproject test "0.1.0-SNAPSHOT"
  :description "Integration tests for Hivewing docker"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [
                 [environ "1.0.0"]
                 [org.clojure/clojure "1.6.0"]
                 [hivewing-core "0.1.3-SNAPSHOT"]
                ]
  :repositories [["hivewing-core" {:url "s3p://clojars.hivewing.io/hivewing-core/releases"
                                   :username "AKIAJCSUM5ZFGI7DW5PA"
                                   :passphrase "UcO9VGAaGMRuJZbgZxCiz0XuHmB1J0uvzt7WIlJK"}]]

  :plugins [[s3-wagon-private "1.1.2"]
            [lein-environ "1.0.0"]
            ]
  :main ^:skip-aot test.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
