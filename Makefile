run:
	@echo "=============starting server============="
	docker-compose -f docker-compose-dev.yml up --build

build:
	@echo "building project..."
	go build gitea.com/zsxq/jianshu/cmd/...
	@echo "build finished!"
