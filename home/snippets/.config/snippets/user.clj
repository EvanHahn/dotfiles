(ns user
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.repl :refer [doc source]]
            [clojure.tools.namespace.repl :refer [refresh refresh-all]]))

(defn t
  ([]
   (refresh-all)
   (clojure.test/run-all-tests))

  ([ns-or-test]
   (refresh)
   (if (find-ns ns-or-test)
     (clojure.test/test-ns ns-or-test)
     ((resolve ns-or-test)))))
