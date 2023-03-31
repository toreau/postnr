# Microservice for looking up Norwegian postal codes

## How to run

### Development

`morbo script/postnr`

### Production

#### Build

`docker build -t postnr .`

#### Run

`docker run -it --init -p 8080:8080 postnr`
