IMAGE=openwrt-builder

.PHONY: .build
.build:
	docker build . -t ${IMAGE}

.PHONY: run
run: .build
	docker run -v $(PWD)/rom:/home/builder/rom -it ${IMAGE}