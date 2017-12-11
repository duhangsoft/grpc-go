all: test testrace

deps:
	go get -d -v github.com/duhangsoft/grpc-go/...

updatedeps:
	go get -d -v -u -f github.com/duhangsoft/grpc-go/...

testdeps:
	go get -d -v -t github.com/duhangsoft/grpc-go/...

updatetestdeps:
	go get -d -v -t -u -f github.com/duhangsoft/grpc-go/...

build: deps
	go build github.com/duhangsoft/grpc-go/...

proto:
	@ if ! which protoc > /dev/null; then \
		echo "error: protoc not installed" >&2; \
		exit 1; \
	fi
	go generate github.com/duhangsoft/grpc-go/...

test: testdeps
	go test -cpu 1,4 -timeout 5m github.com/duhangsoft/grpc-go/...

testrace: testdeps
	go test -race -cpu 1,4 -timeout 7m github.com/duhangsoft/grpc-go/...

clean:
	go clean -i github.com/duhangsoft/grpc-go/...

.PHONY: \
	all \
	deps \
	updatedeps \
	testdeps \
	updatetestdeps \
	build \
	proto \
	test \
	testrace \
	clean \
	coverage
