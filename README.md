Cordova Auto-Crosswalk
======================

Shell script to auto-convert Cordova-Android 3.6 projects to Cordova Crosswalk 11.
Creates a unified apk (x86 & ARM compatible.).

Tested with Cordova 3.6.4. 

Usage
----------------------
1. Add script to your Cordova project root.
2. Execute the script:
  ```shell
  sh crosswalk.sh
  ```
3. There is no step 3.

Tested with
----------------------
* Cordova CLI 4.1.2
* Cordova Android 3.6.4
* Crosswalk Canary 11.39.260.0
* Ionic Framework v1.0.0-beta.13

Dependencies
----------------------
* Cordova Android

Options
----------------------
Change the  "CROSSWALK_TYPE" / "CROSSWALK_VERSION" values to use other Crosswalk versions.
