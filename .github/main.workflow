workflow "Test Expo Action" {
  on = "push"
  resolves = [
    "Publish to Expo",
    "bycedric/ci-expo/cli@master",
  ]
}

action "Install dependencies" {
  uses = "bycedric/ci-expo/cli@master"
  runs = "npm"
  args = "ci"
}

action "Login with Expo" {
  uses = "bycedric/ci-expo/cli@master"
  secrets = ["EXPO_USERNAME", "EXPO_PASSWORD"]
  needs = ["Install dependencies"]
  args = "login --username $EXPO_USERNAME --password $EXPO_PASSWORD"
}

action "Publish to Expo" {
  uses = "bycedric/ci-expo/cli@master"
  needs = ["Login with Expo"]
  args = "publish"
}

action "bycedric/ci-expo/cli@master" {
  uses = "bycedric/ci-expo/cli@master"
  runs = "sysctl -a"
}
