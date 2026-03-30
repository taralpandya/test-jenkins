# test-jenkins/Dockerfile

FROM alpine:3.20

WORKDIR /app

# simple test file
RUN echo "Hello from Jenkins build!" > /app/hello.txt

CMD ["sh", "-c", "echo Container running && cat /app/hello.txt"]
