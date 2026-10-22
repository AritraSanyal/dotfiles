#!/bin/zsh

echo "Checking currently installed simulators..."
xcrun simctl list runtimes

echo "\nWhat would you like to do?"
echo "\n1) Just remove the old ios simulator files"
echo "\n2) Remove old simulator AND new iOS platform"
echo "\n3) Do nothing AND exit"
echo -n "Enter your choice 1/2/3 : "
read choice

if [["$choice" == "3" || -z "$choice"]]; then
  echo "Aborthing."
  exit 0
fi

if [["$choice" == "1" || "$choice" == "2"]]; then
  echo "\nRemoving old simulator files..."
  xcrun simctl runtime list | grep -E -o "([0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12})" | xargs -I {} xcrun simctl runtime delete {}

  echo "Cleaning up disconnected and unavailable virtual devices..."
  xcrun simctl delete unavailable
fi

if [["$choice" == "2"]]; then
  echo "Instructing Xcode to download the required iOS platform..."
  xcodebuild -downloadPlatform iOS
fi

echo"\nUpdate Complete!!! Here are your active simulators:\n"
xcrun simctl list runtimes
