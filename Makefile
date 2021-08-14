clj_cmd = env clj

.PHONY: build
build:
	mkdir -p target
	mkdir -p classes
	clj -e "(compile 'tla-edn-module.core)"
	$(clj_cmd) -X:depstar uberjar :jar target/tla-edn-module.jar :sync-pom true :version '"0.2.0-SNAPSHOT"' :group-id '"io.github.pfeodrippe"' :artifact-id '"tla-edn-module"' :exclude '["clojure/.*", "com/.*", "javax/.*", "org/.*", "pcal/.*", "tla2sany/.*", "tla2tex/.*", "util/.*", "kaocha/.*", "CommonsMath.*", "META_INF/.*", "dynapath/.*", "babashka/.*", "tlc2/util/.*", "tlc2/tool/.*", "tlc2/value/.*", "tlc2/debug/.*", "tlc2/model/.*", "tlc2/output/.*", "tlc2/module/.*", "tlc2/pprint/.*"]'

.PHONY: deploy
deploy:
	mvn deploy:deploy-file -Dfile=target/tla-edn-module.jar -DpomFile=pom.xml -DrepositoryId=clojars -Durl=https://clojars.org/repo/
