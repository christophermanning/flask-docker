FROM alpine:3.19

# install python
RUN apk add --no-cache python3

# "activate" venv
ENV PATH="/src/.venv/bin:$PATH"

WORKDIR /src

EXPOSE 5000
