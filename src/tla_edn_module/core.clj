(ns tla-edn-module.core
  (:gen-class)
  (:require
   [clojure.edn :as edn]
   [tla-edn.core :as tla-edn]
   [tla-edn.spec :as spec]))

(spec/defop serialize {:module "Edn" :identifier "EdnSerialize"}
  [path value]
  (spit (tla-edn/to-edn path) (pr-str (tla-edn/to-edn value)))
  (tla-edn/to-tla-value true))

(spec/defop deserialize {:module "Edn" :identifier "EdnDeserialize"}
  [path]
  (tla-edn/to-tla-value (edn/read-string (slurp (tla-edn/to-edn path)))))

(spec/defop ToEdn {:module "Edn" :identifier "ToEdn"}
  [value]
  (tla-edn/to-tla-value (pr-str (tla-edn/to-edn value))))

(gen-class
 :name TlaEdnModule.Overrides
 :implements [tlc2.overrides.ITLCOverrides]
 :prefix "impl-"
 :main false)

(defn impl-get
  [_this]
  (into-array Class (map resolve (or (keys @spec/classes-to-be-loaded) []))))

(comment

  ;; Run tests.
  (spec/run
    (str (System/getProperty "user.dir") "/test/EdnTests.tla")
    (str (System/getProperty "user.dir") "/test/EdnTests.tla"))

  ())
