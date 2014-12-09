# CORDOVA AUTO-CROSSWALK
# Copyright (c) 2014 S.Bofah

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software #without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to #permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#!/bin/bash

# Crosswalk Version
CROSSWALK_TYPE="CANARY"
CROSSWALK_VERSION="11.39.262.0"

##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################

# Script Version
VERSION="1.0.5"

# Environment
clear
IFS=$'\n'
shopt -s nullglob
export PATH=$PATH:/usr/libexec

# Generate URLs
_CROSSWALK_TYPE=($(echo "${CROSSWALK_TYPE}" | tr '[:upper:]' '[:lower:]'))
_CROSSWALK_VERSION="${CROSSWALK_VERSION}"
_URL_X86="https://download.01.org/crosswalk/releases/crosswalk/android"/"${_CROSSWALK_TYPE}"/"${_CROSSWALK_VERSION}"/"x86/crosswalk-cordova"-"${_CROSSWALK_VERSION}"-"x86.zip"
_URL_ARM="https://download.01.org/crosswalk/releases/crosswalk/android"/"${_CROSSWALK_TYPE}"/"${_CROSSWALK_VERSION}"/"arm/crosswalk-cordova"-"${_CROSSWALK_VERSION}"-"arm.zip"

# Constants
_DIR_PROJECTROOT=($(pwd))
_DIR_TEMPORARY="${_DIR_PROJECTROOT}"/.crosswalk_temp
_DIR_CROSSWALK="${_DIR_TEMPORARY}"/"_CordovaLib"
_CROSSWALK_VERSION_NAME=$(echo "${_CROSSWALK_TYPE}" | tr '[:lower:]' '[:upper:]')" (${_CROSSWALK_VERSION})"

# Prefix
PRINT_UNPREFIXED () 
{ 
while read; do
printf '\e[100m%s\e[0m\n' "$REPLY";
done
}
PRINT_PREFIXED () 
{ 
while read; do
printf '\e[100m%s\e[0m\n' "[CORDOVA AUTO-CROSSWALK] $REPLY";
done
}

# Banner
echo " ██████╗ ██████╗ ██████╗ ██████╗  ██████╗ ██╗   ██╗ █████╗                 " | PRINT_UNPREFIXED
echo "██╔════╝██╔═══██╗██╔══██╗██╔══██╗██╔═══██╗██║   ██║██╔══██╗                " | PRINT_UNPREFIXED
echo "██║     ██║   ██║██████╔╝██║  ██║██║   ██║██║   ██║███████║                " | PRINT_UNPREFIXED
echo "██║     ██║   ██║██╔══██╗██║  ██║██║   ██║╚██╗ ██╔╝██╔══██║                " | PRINT_UNPREFIXED
echo "╚██████╗╚██████╔╝██║  ██║██████╔╝╚██████╔╝ ╚████╔╝ ██║  ██║                " | PRINT_UNPREFIXED
echo " ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝   ╚═══╝  ╚═╝  ╚═╝                " | PRINT_UNPREFIXED
echo "                                                                           " | PRINT_UNPREFIXED
echo " █████╗ ██╗   ██╗████████╗ ██████╗                                         " | PRINT_UNPREFIXED
echo "██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗                                        " | PRINT_UNPREFIXED
echo "███████║██║   ██║   ██║   ██║   ██║█████╗                                  " | PRINT_UNPREFIXED
echo "██╔══██║██║   ██║   ██║   ██║   ██║╚════╝                                  " | PRINT_UNPREFIXED
echo "██║  ██║╚██████╔╝   ██║   ╚██████╔╝                                        " | PRINT_UNPREFIXED
echo "╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝                                         " | PRINT_UNPREFIXED
echo " ██████╗██████╗  ██████╗ ███████╗███████╗██╗    ██╗ █████╗ ██╗     ██╗  ██╗" | PRINT_UNPREFIXED
echo "██╔════╝██╔══██╗██╔═══██╗██╔════╝██╔════╝██║    ██║██╔══██╗██║     ██║ ██╔╝" | PRINT_UNPREFIXED
echo "██║     ██████╔╝██║   ██║███████╗███████╗██║ █╗ ██║███████║██║     █████╔╝ " | PRINT_UNPREFIXED
echo "██║     ██╔══██╗██║   ██║╚════██║╚════██║██║███╗██║██╔══██║██║     ██╔═██╗ " | PRINT_UNPREFIXED
echo "╚██████╗██║  ██║╚██████╔╝███████║███████║╚███╔███╔╝██║  ██║███████╗██║  ██╗" | PRINT_UNPREFIXED
echo " ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝" | PRINT_UNPREFIXED
echo "                                                                           " | PRINT_UNPREFIXED
echo "VERSION: ""${VERSION}""                                                             " | PRINT_UNPREFIXED
echo "PROJECT REPO:" "https://github.com/SidneyS/cordova-autocrosswalk""             " | PRINT_UNPREFIXED
echo "\n\n"

# Give Warning
echo "WARNING: THE ANDROID PLATFORM DIRECTORY WILL BE REMOVED DURING THIS PROCESS." | PRINT_PREFIXED
echo "Press any key to continue." | PRINT_PREFIXED
read -p "..." -n1 -s
echo "\n\n"

# Create vanilla Cordova Android platform folder.
echo "Cleaning Android platform folder..." | PRINT_PREFIXED
cordova platform rm android
cordova platform add android
echo "Cleaning Android platform folder....complete." | PRINT_PREFIXED

# Create working directory.
echo "Prepare temporary working directory..." | PRINT_PREFIXED
rm -rf "${_DIR_TEMPORARY}"
mkdir -p "${_DIR_CROSSWALK}"
echo "Prepare temporary working directory....complete." | PRINT_PREFIXED

# Download Cordova-Crosswalk.
echo "Downloading Cordova-Crosswalk ${_CROSSWALK_VERSION_NAME} (x86 & ARM)..." | PRINT_PREFIXED
_URLS=("${_URL_X86}" "${_URL_ARM}")
_FILE_TEMP="crosswalk_temp.zip"
for url in "${_URLS[@]}"; do
    curl --output "${_FILE_TEMP}" "${url}"
    mv "${_DIR_PROJECTROOT}"/"${_FILE_TEMP}" "${_DIR_TEMPORARY}"/"${_FILE_TEMP}"
    unzip  -q "${_DIR_TEMPORARY}"/"${_FILE_TEMP}" -d "${_DIR_TEMPORARY}"
    rm -rf "${_DIR_TEMPORARY}"/"${_FILE_TEMP}"
done
echo "Downloading Cordova-Crosswalk ${_CROSSWALK_VERSION_NAME} (x86 & ARM)....complete." | PRINT_PREFIXED

# Get names of Cordova-Crosswalk folders.
_DIR_X86=($(find ${_DIR_TEMPORARY} -type d -iname '*-x86'))
_DIR_ARM=($(find ${_DIR_TEMPORARY} -type d -iname '*-arm'))

# Prepare new 'CordovaLib' directory.
echo "Building unified Cordova-Android framework folder..." | PRINT_PREFIXED
cp -rf "${_DIR_X86}"/"framework" "${_DIR_CROSSWALK}"/"CordovaLib"
cp -rf "${_DIR_ARM}"/"framework/xwalk_core_library/libs/armeabi-v7a" "${_DIR_CROSSWALK}"/"CordovaLib/xwalk_core_library/libs/"
echo "Building unified Cordova-Android framework folder....complete." | PRINT_PREFIXED

# Copy 'VERSION' file.
echo "Copying 'VERSION' file..." | PRINT_PREFIXED
cp -rf "${_DIR_X86}"/VERSION "${_DIR_CROSSWALK}"
echo "Copying 'VERSION' file....complete." | PRINT_PREFIXED

# Add permissions to 'AndroidManifest.xml' file.
echo "Adding Crosswalk permissions to 'AndroidManifest.xml' file..." | PRINT_PREFIXED
cat "${_DIR_PROJECTROOT}"/"platforms/android/AndroidManifest.xml" | sed 's/<\/manifest>/<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" \/><uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" \/><\/manifest>/' > "${_DIR_CROSSWALK}"/"AndroidManifest.xml"
rm -rf "${_DIR_X86}"
rm -rf "${_DIR_ARM}"
echo "Adding required permissions to 'AndroidManifest.xml' file....complete." | PRINT_PREFIXED

# Delete standard 'CordovaLib' and add new 'CordovaLib' and associated files to Android platform folder
echo "Replacing 'platforms/android/CordovaLib' with Crosswalk version..." | PRINT_PREFIXED
rm -rf "${_DIR_PROJECTROOT}"/"platforms/android/CordovaLib"
cp -rf "${_DIR_CROSSWALK}"/* "${_DIR_PROJECTROOT}"/"platforms/android/"
echo "Replacing 'platforms/android/CordovaLib' with Crosswalk version....complete." | PRINT_PREFIXED

# Bump Android Minimum SDK from 10 to 14 (4.0)
echo "Bumping Android minimum API Level to 14 (4.0 /  Ice Cream Sandwich)..." | PRINT_PREFIXED
find "platforms/android" -name "AndroidManifest.xml" -type f -exec sed -i '' 's/minSdkVersion="10"/minSdkVersion="14"/g' {} \;
echo "Bumping Android minimum API Level to 14 (4.0 /  Ice Cream Sandwich)....complete." | PRINT_PREFIXED

# Update Android platform project
echo "Updating Android project..." | PRINT_PREFIXED
cd "${_DIR_PROJECTROOT}"/"platforms/android/CordovaLib"
android update project --subprojects --path . --target "android-19"
ant debug
echo "Updating Android project....complete." | PRINT_PREFIXED

# Remove working directory.
echo "Removing working directory..." | PRINT_PREFIXED
rm -rfv "${_DIR_TEMPORARY}"
echo "Removing working directory....complete." | PRINT_PREFIXED


# Give Feedback.
echo "\n\n"
echo "Migration to Crosswalk ${_CROSSWALK_VERSION_NAME} complete." | PRINT_PREFIXED

# Go back to project root
cd "${_DIR_PROJECTROOT}"

# Build
#./platforms/android/cordova/build --gradle
#echo "Build finished." | PRINT_PREFIXED