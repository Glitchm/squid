workflow "Build/deploy docker image" {
  on = "push"
  resolves = ["Docker Registry"]
}

action "Build docker image" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  args = "build -t glitchm/squid ."
}

action "Docker Tag" {
  uses = "actions/docker/tag@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  args = "base glitchm/squid:$SQUID_VERSION"
  env = {
    SQUID_VERSION = "3.5.27-r2"
  }
  needs = ["Build docker image"]
}

action "Docker Registry" {
  uses = "actions/docker/login@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  needs = ["Docker Tag"]
  secrets = ["DOCKER_PASSWORD", "DOCKER_USERNAME"]
}
