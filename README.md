# Microservice for looking up Norwegian postal codes

## How to run

### Development

`morbo script/postnr`

### Production

#### Build

`docker build -t postnr .`

#### Run

`docker run -it --init -p 8080:8080 postnr`

## Usage, best practice

You typically want to run this service and have it restart once per day, so that it
automatically fetches the updated postal code list from Bring. Once per day is
overkill of course, but it doesn't do any harm.

If the application fails to download updated data from Bring, it will refuse to start.
