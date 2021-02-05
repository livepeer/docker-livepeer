# vast-livepeer

This is a base image for use with vast.ai. It adds vast-aware sugar to the
livepeer base image to make it more compatible and convenient.

# usage

1. create a "start command" in a file on machine provisioning the instance

```sh
# ./my-start-command

# configure container
export PAPERTRAIL_HOST="<HOST>"
export PAPERTRAIL_PORT="<PORT>"
export GEO_RESOLVER=<URL>
export LIVEPEER_ARGS="-transcoder -orchAddr "{{ORCH_ADDR}}:8935" -orchSecret <SECRET> -nvidia=0"

# run custom start script in the image
start
```

2. Find an available vast instance:

```sh
vast search offers 'rentable=true rented=false cuda_vers=10.1'
```

3. Launch new transcoders using this image by running:

```sh
vast create instance <instance-id> --image thedeeno/vast-livepeer:0.11.0 --onstart ./my-start-command
```
