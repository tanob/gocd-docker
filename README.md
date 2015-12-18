# gocd-docker
Minimal GoCD Server and Agent for Docker

## Best Practices

These Docker images were created following the [Best practices for writing Dockerfiles](https://docs.docker.com/engine/articles/dockerfile_best-practices/) and some others collected by looking Dockerfiles from Docker official repositories.

Here's a summary of the practices followed by these images:

* they are "minimal" (from "Avoid installing unnecessary packages"), they have only the basic requirements for GoCD (Java JRE) and GoCD itself so you get a really slim image to be used as a base, fostering composability and leading to small images.
* they use the option `--no-install-recommends` for `apt-get` so only the main dependencies are installed.
* they have a small number of layers (by grouping `RUN` commands) and the commands are done in a way to minimize the number of things that are added to the layers, e.g. we don't add temporary files - they are downloaded, used and removed in the same `RUN`.
* they run the start scripts directly, instead of having another layer of indirection like an init system.
* they rely on start script default values. The Dockerfiles only define environment variables that are really necessary. Sub-images can of course define any other environment variable to control the containerized app.
* for any package that the Dockerfile downloads there's an expected SHA1 checksum in order to confirm the packages were not corrupted and/or tampered.

## TODO

The `docker-compose.yml` at the root will start the server and one agent (if just running `docker-compose up`) but the agent won't auto-register because the server doesn't have the same agent key defined in its configuration.

To define the auto-register agent key in the server you will need to use `docker exec -it <server container id> /set-agent-key.sh <key>`.

Until `docker-compose` doesn't provide a way to [hook scripts](https://github.com/docker/compose/issues/1341) into Docker events you'll need to coordinate that by using some script, Makefile, etc.

## Feedback

Any feedback is welcome! Please open an issue or send a pull request :-)
