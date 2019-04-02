workflow "Build and publish on Expo" {
  on = "push"
  resolves = [
    "Master Branch Only",
    "Publish to Expo",
  ]
}

action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

action "Test" {
  needs = ["Build"]
  uses = "actions/npm@master"
  args = "test"
}

action "Master Branch Only" {
  uses = "actions/bin/filter@master"
  args = "branch master"
  needs = ["Test"]
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
