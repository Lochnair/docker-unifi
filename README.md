# Unifi
Unifi image for Docker, based on Alpine Linux.

## Usage

```bash
docker create \
  --name=unifi \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid> \
  -e TZ=<timezone> \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8443:8443 \
  -p 8843:8843 \
  -p 8880:8880 \
  lochnair/unifi
```