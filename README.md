# dockerfile-container-linux-config-transpiler
For official ct-examples, you can check [here](https://github.com/coreos/container-linux-config-transpiler/blob/master/doc/examples.md)

## Basic Examples for using this image
#### Output to stdout
```bash
docker run --rm -it -v $PWD/examples/example.yml:/tmp/example.yml aiqu/container-linux-config-transpiler:latest -in-file /tmp/example.yml
```
#### Output to file on host
```bash
docker run --rm -it --mount type=bind,source=$PWD/examples/,target=/tmp/ aiqu/container-linux-config-transpiler:latest -in-file /tmp/example.yml -out-file /tmp/outfile.json
```
example.yml:
```yaml
storage:
  files:
    - path: /opt/file1
      filesystem: root
      contents:
        inline: Hello, world!
      mode: 0644
      user:
        id: 500
      group:
        id: 501
```
resulting output (with '-pretty')
```json
{
  "ignition": {
    "config": {},
    "security": {
      "tls": {}
    },
    "timeouts": {},
    "version": "2.2.0"
  },
  "networkd": {},
  "passwd": {},
  "storage": {
    "files": [
      {
        "filesystem": "root",
        "group": {
          "id": 501
        },
        "path": "/opt/file1",
        "user": {
          "id": 500
        },
        "contents": {
          "source": "data:,Hello%2C%20world!",
          "verification": {}
        },
        "mode": 420
      }
    ]
  },
  "systemd": {}
}
```
Resulting output (without '-pretty'):
```json
{"ignition":{"config":{},"security":{"tls":{}},"timeouts":{},"version":"2.2.0"},"networkd":{},"passwd":{},"storage":{"files":[{"filesystem":"root","group":{"id":501},"path":"/opt/file1","user":{"id":500},"contents":{"source":"data:,Hello%2C%20world!","verification":{}},"mode":420}]},"systemd":{}}
```
