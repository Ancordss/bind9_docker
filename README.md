# BIND9-DOCKER

## Description

This is a simple BIND9 DNS server running in a Docker container. It is intended to be used as a local DNS server for development purposes. It is not intended to be used in a production environment.

## Table of Contents

- [BIND9-DOCKER](#bind9-docker)
  - [Description](#description)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Contributing](#contributing)


## Installation

requiriments:
- docker
- Makefile
  
Clone this repository

## Usage

run the following command

```bash
make createNW
```

```bash
make build
```

To start the container run the following command
```bash
make start
```

to test the container run the following command
```bash
make start_test
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request
6. Please don't forget to update the README with usage instructions
  


