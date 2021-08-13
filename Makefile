clj_cmd = env clj

.PHONY: build
build:
	mkdir -p target
	$(clj_cmd) -X:depstar uberjar :jar target/tla-edn-module.jar :sync-pom true :version '"0.1.0"' :group-id '"io.github.pfeodrippe"' :artifact-id '"tla-edn-module"' :exclude '["clojure/.*", "tla_edn/.*", "tlc2/.*", "com/.*", "javax/.*", "org/.*", "pcal/.*", "tla2sany/.*", "tla2tex/.*", "util/.*", "kaocha/.*", "CommonsMath.*", "META_INF/.*"]'

.PHONY: deploy
deploy:
	mvn deploy:deploy-file -Dfile=target/tla-edn-module.jar -DpomFile=pom.xml -DrepositoryId=clojars -Durl=https://clojars.org/repo/
