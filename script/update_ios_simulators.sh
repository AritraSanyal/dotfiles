#!/bin/zsh

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
RED='\033[1;31m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

clear

echo -e "${MAGENTA}========================================${RESET}"
echo -e "${MAGENTA}|${RESET}   📱 ${BOLD}iOS Simulator Maintenance Tool${RESET}   ${MAGENTA}|${RESET}"
echo -e "${MAGENTA}========================================${RESET}\n"

echo -e "${CYAN}==>${RESET} ${BOLD}Installed Simulators:${RESET}"
echo -e "${DIM}"
xcrun simctl list runtimes
echo -e "${RESET}"

# --- Helper Function for Safe Deletion ---
remove_runtimes() {
  # Parse the simulator list into a Zsh array, ignoring header lines
  local runtimes=("${(@f)$(xcrun simctl list runtimes | grep -E 'SimRuntime|([0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12})')}")
  local count=${#runtimes[@]}

  if [[ $count -eq 0 ]]; then
    echo -e "${YELLOW}No runtimes found to remove.${RESET}"
  elif [[ $count -eq 1 ]]; then
    echo -e "${CYAN}==>${RESET} Found 1 runtime. Removing..."
    # Extracts the bundle ID (the very last word on the line) to target the deletion
    local id=$(echo "${runtimes[1]}" | awk '{print $NF}')
    xcrun simctl runtime delete "$id" 2>/dev/null
  else
    echo -e "\n${BOLD}Multiple runtimes detected. Which would you like to remove?${RESET}"
    local i=1
    for rt in "${runtimes[@]}"; do
      echo -e "  ${CYAN}[$i]${RESET} $rt"
      ((i++))
    done
    echo -e "  ${CYAN}[a]${RESET} Remove ALL of them"
    echo -e "  ${CYAN}[c]${RESET} Cancel removal"
    
    echo -n "Enter choice (1-$count, a, or c): "
    read subchoice

    if [[ "$subchoice" == "a" || "$subchoice" == "A" ]]; then
      echo -e "${CYAN}==>${RESET} Removing ALL runtimes..."
      for rt in "${runtimes[@]}"; do
        local id=$(echo "$rt" | awk '{print $NF}')
        xcrun simctl runtime delete "$id" 2>/dev/null
      done
    elif [[ "$subchoice" =~ ^[0-9]+$ ]] && (( subchoice >= 1 && subchoice <= count )); then
      echo -e "${CYAN}==>${RESET} Removing selected runtime..."
      local id=$(echo "${runtimes[$subchoice]}" | awk '{print $NF}')
      xcrun simctl runtime delete "$id"
    else
      echo -e "${YELLOW}Skipping removal.${RESET}"
      return
    fi
  fi
  
  echo -e "${CYAN}==>${RESET} Cleaning unavailable devices..."
  xcrun simctl delete unavailable
  echo -e "${GREEN}✔ Clean-up Done!${RESET}"
}
# -----------------------------------------

echo -e "${BOLD}What would you like to do?${RESET}"
echo -e "  ${CYAN}[1]${RESET} 🗑️  Remove old simulator runtimes"
echo -e "  ${CYAN}[2]${RESET} 🔄  Remove old & download latest iOS"
echo -e "  ${CYAN}[3]${RESET} 🚪  Exit\n"

echo -n "Enter choice [1/2/3]: "
read choice
echo ""

case "$choice" in
  1)
    remove_runtimes
    ;;

  2)
    remove_runtimes
    echo -e "\n${CYAN}==>${RESET} Downloading latest iOS platform..."
    xcodebuild -downloadPlatform iOS
    echo -e "${GREEN}✔ Download Complete!${RESET}"
    ;;

  3|q|Q)
    echo -e "${YELLOW}Aborted. No changes made.${RESET}"
    exit 0
    ;;

  *)
    echo -e "${RED}Invalid choice. Exiting.${RESET}"
    exit 1
    ;;
esac

echo -e "\n${MAGENTA}========================================${RESET}"
echo -e "${CYAN}==>${RESET} ${BOLD}Active Simulators:${RESET}"
echo -e "${DIM}"
xcrun simctl list runtimes
echo -e "${RESET}"

