workflow "Test Expo Action" {
  on = "push"
  resolves = [
    "Publish to Expo",
    "Run Expo doctor",
  ]
}

action "Install dependencies" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  runs = "npm"
  args = "ci"
}

action "Login with Expo" {
  uses = "bycedric/ci-expo/login@stable"
  secrets = ["EXPO_USERNAME", "EXPO_PASSWORD"]
  needs = ["Install dependencies"]
  args = "login --username $EXPO_USERNAME --password $EXPO_PASSWORD"
}

action "Publish to Expo" {
  uses = "bycedric/ci-expo/publish@stable"
  needs = ["Login with Expo"]
  args = "publish"
}

action "Run Expo doctor" {
  uses = "bycedric/ci-expo@stable"
  args = "doctor"
}
