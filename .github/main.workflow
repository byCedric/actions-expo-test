workflow "Build and publish on Expo" {
  on = "push"
  resolves = ["Publish to Expo"]
}

action "Install dependencies" {
  uses = "bycedric/ci-expo/cli@master"
  runs = "npm"
  args = "ci"
}

action "Publish to Expo" {
  uses = "bycedric/ci-expo/cli@master"
  needs = ["Install dependencies"]
  runs = "/entrypoint.sh login -u $EXPO_USERNAME $EXPO_PASSWORD && /entrypoint.sh publish"
}
