workflow "Build and publish on Expo" {
  on = "push"
  resolves = ["Publish to Expo"]
}

action "Install dependencies" {
  uses = "bycedric/ci-expo/cli@master"
  runs = "npm"
  args = "ci"
}

action "Login with Expo" {
  uses = "bycedric/ci-expo/login@master"
  needs = ["Install dependencies"]
  secrets = ["EXPO_USERNAME", "EXPO_PASSWORD"]
}

action "Publish to Expo" {
  uses = "bycedric/ci-expo/cli@master"
  needs = ["Login with Expo"]
  args = "publish"
}
