.PHONY: build

# TAG := yusukeito/swift-basic:nightly-swift-grpc-1

build:
	docker buildx build --pull --platform linux/amd64,linux/arm64 -t ${TAG} --push .