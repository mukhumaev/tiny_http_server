# tiny_http_server

#### tiny HTTP server written in Go

[Features](#features) • [Usage](#usage) • [Installation](#installing-simplehttpserver) • [Run tiny_http_server](#running-http_server-in-the-current-folder) • [Docker](#Docker) 

* * *

tiny_http_server - simple HTTP server written in Go. Originally written as a simple HTTP server for Mikrotik RouterOS operating system containers 

# Features

- File Server with arbitrary directory support
- Configurable ip address and listening port

# Building tiny_http_server

tiny_http_server requires **go1.18+** to building successfully. Run the following command:

```sh
$ git clone https://github.com/mukhumaev/tiny_http_server
$ cd tiny_http_server
$ make build
```

# Usage

```sh
$ tiny_http_server -dir [PATH] -port [PORT]
```

This will display help for the tool. Here are all the switches it supports.

| Flag | Description | Example |
| --- | --- | --- |
| `-port` | Configure listening port (default 8080) | `tiny_http_server -port 8080` |
| `-dir` | Fileserver folder (default current directory) | `tiny_http_server -dir /data` |

### Running tiny_http_server in the current folder

This will run the tool exposing the current directory on default port 8080

```sh
$ tiny_http_server
2023/12/10 19:54:08 The HTTP server is running at 'http://localhost:8080' in the '.' directory.
2023/12/10 19:54:16 [::1]:49318 GET /
```

### Running tiny_http_server in a custom folder and on a custom port

This will run the tool exposing the `/distro` directory on port `9000` :

```sh
$ tiny_http_server -dir /distro -port 9000
2023/12/10 19:56:45 The HTTP server is running at 'http://localhost:9000' in the '/distro' directory.
2023/12/10 19:57:27 [::1]:48302 GET /
```

# Docker
### tiny_http_server is also available as a docker image for amd64, arm64 and arm/v7 architectures

Available ENV's for docker containers
| Flag | Description | Example |
| --- | --- | --- |
| `PORT` | Configure listening port (default 8080) | `docker run --env PORT=8080 mukhumaev/tiny_http_server` |
| `DIR` | Fileserver folder (default `/data` directory) | `docker run --env DIR=/data mukhumaev/tiny_http_server` |

The default in docker container `tiny_http_server` is started with the command:
```sh
$ tiny_http_server -dir /data -port 8080
```

This will run the tool using docker exposing the `/custom` directory on port `80` using `--env`:

```sh
$ docker run -d \
             -h tiny_http_server \
             --name tiny_http_server \
             --env DIR=/custom \
             --env PORT=80 \
             mukhumaev/tiny_http_server

$ docker logs tiny_http_server
2023/12/10 20:12:09 The HTTP server is running at 'http://localhost:80' in the '/custom' directory.
2023/12/10 20:12:42 [::1]:48302 GET /
```

# Note

- This project is intended for development purposes only; it should not be used in production.
