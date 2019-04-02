workflow "Test Expo Action" {
  on = "push"
  resolves = [
    "Install dependencies",
    "Login with Expo",
    "Build Android app",
  ]
}

action "Install dependencies" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  runs = "npm"
  args = "ci"
}

action "Login with Expo" {
  uses = "bycedric/ci-expo/login@master"
  secrets = ["EXPO_USERNAME", "EXPO_PASSWORD"]
  needs = ["Install dependencies"]
  args = "login --username $EXPO_USERNAME --password $EXPO_PASSWORD"
}

action "Build Android app" {
  uses = "bycedric/ci-expo/build-web@build"
  needs = ["Login with Expo"]
}
