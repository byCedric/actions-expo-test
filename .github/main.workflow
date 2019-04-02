workflow "Build and publish on Expo" {
  on = "push"
  resolves = [
    "Publish to Expo",
  ]
}

action "Install dependencies" {
  uses = "bycedric/ci-expo/cli@master"
  runs = "npm"
  args = "ci"
  needs = ["Master Branch Only"]
}

action "Login with Expo" {
  uses = "bycedric/ci-expo/login@master"
  secrets = ["EXPO_USERNAME", "EXPO_PASSWORD"]
}

action "Publish to Expo" {
  uses = "docker://bycedric/ci-expo"
  needs = ["Login with Expo", "Install dependencies"]
  secrets = ["EXPO_USERNAME", "EXPO_PASSWORD"]
  runs = "expo publish"
}
