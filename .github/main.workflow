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
  runs = "sh -c \"expo login -u $EXPO_USERNAME -p $EXPO_PASSWORD && expo publish\""
}
