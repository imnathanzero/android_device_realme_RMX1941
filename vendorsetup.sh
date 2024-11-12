#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Script Description
echo -e "${GREEN}Device Setup${NC}"
echo "---------------------------------------------"

# Apply Patches
deviceDir=$(gettop)/device/realme/RMX1941/

${deviceDir}/applypatch.sh ${deviceDir}/patches

# Initialize clone counter
CLONED_COUNT=0

# Function to remove a directory
remove_directory() {
  TARGET_DIR="$1"
  if [ -d "$TARGET_DIR" ]; then
    echo "Removing existing directory: $TARGET_DIR"
    rm -rf "$TARGET_DIR"
    if [ $? -eq 0 ]; then
      echo "Successfully removed directory: $TARGET_DIR"
    else
      echo "Error removing directory: $TARGET_DIR. Aborting."
      exit 1 # Exit the script if removal fails
    fi
  fi
}

# Function to clone a repo, checking for directory existence
clone_repo() {
  REPO_URL="$1"
  BRANCH="$2"
  TARGET_DIR="$3"

  # Remove the directory if it exists
  remove_directory "$TARGET_DIR"

  echo "Cloning $REPO_URL (branch: $BRANCH) into $TARGET_DIR..."
  git clone --depth=1 -b "$BRANCH" "$REPO_URL" "$TARGET_DIR"
  CLONE_STATUS=$? # Get the exit code of the git clone command

  if [ $CLONE_STATUS -eq 0 ]; then
    # Get current timestamp
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${GREEN}Cloned $REPO_URL successfully at $TIMESTAMP${NC}"
    CLONED_COUNT=$((CLONED_COUNT + 1)) # Increment the counter
  else
    echo "Error cloning $REPO_URL.  Check the logs."
  fi
}

# Repos to clone
REPOS=(
  "https://github.com/imnathanzero/kernel_realme_RMX1941 RUI kernel/realme/RMX1941"
  "https://github.com/imnathanzero/android_vendor_realme_RMX1941 tiramsu vendor/realme/RMX1941"
  "https://github.com/imnathanzero/vendor_mtk-ims 12 vendor/mtk-ims"
  "https://github.com/P-Salik/android_prebuilts_clang_host_linux-x86_clang-5484270.git 9.0.3 prebuilts/clang/host/linux-x86/clang-r353983c"
  "https://github.com/P-Salik/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-gnu-7.5.git master prebuilts/gcc/linux-x86/aarch64/aarch64-linux-gnu-7.5"
  "https://github.com/ArrowOS/android_device_mediatek_sepolicy_vndr.git arrow-13.0 device/mediatek/sepolicy_vndr"
)

# Now, loop through the repos and clone them:
for REPO in "${REPOS[@]}"; do
  REPO_URL=$(echo "$REPO" | awk '{print $1}')
  BRANCH=$(echo "$REPO" | awk '{print $2}')
  TARGET_DIR=$(echo "$REPO" | awk '{print $3}')
  clone_repo "$REPO_URL" "$BRANCH" "$TARGET_DIR"
done

# Display the number of repos cloned
echo -e "${GREEN}Successfully cloned $CLONED_COUNT repositories.${NC}"
echo "---------------------------------------------"
