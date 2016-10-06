#!/bin/bash
# Move to the Protractor test project folder
cd $HOME


# X11 for Ubuntu is not configured! The following configurations are needed for XVFB.
# Make a new display :21 with virtual screen 0 with resolution 1024x768 24dpi
Xvfb :10 -screen 0 1920x1080x24 2>&1 >/dev/null &
# Export the previously created display
# export DISPLAY=:10.0

# Right now this is not necessary, because of 'directConnect: true' in the 'e2e.conf.js'
#echo "Starting webdriver"
#webdriver-manager start &
#echo "Finished starting webdriver"
#sleep 20

echo "Running Protractor tests"
DISPLAY=:10 protractor $@
export RESULT=$?

echo "Protractor tests have done"
# Close the XVFB display
killall Xvfb
# Remove temporary folders
rm -rf .config .local .pki .cache .dbus .gconf .mozilla
# Set the file access permissions (read, write and access) recursively for the result folders
chmod -Rf 777 allure-results test-results

exit $RESULT
