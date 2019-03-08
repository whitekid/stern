TARGET=bin/stern
SRC=$(shell find . -type f -name '*.go' -not -path "./vendor/*" -not -path "./hack/*" -not -path "*_test.go" -not -path ".direnv/*")
GO?=go

.PHONEY: clean dep

all: build
build: $(TARGET)

$(TARGET): $(SRC)
	@${GO} build -v -o $(TARGET) ${BUILD_FLAGS} .

clean:
	@rm -f $(TARGET)

linux: $(SRC)
	@${MAKE} build GOOS=linux GOARCH=amd64

dep:
	@rm -f go.mod go.sum
	@${GO} mod init github.com/wercker/stern
	-@${GO} get k8s.io/api@kubernetes-1.13.4
	@${GO} mod tidy
