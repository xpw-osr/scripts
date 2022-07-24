TARGET_MODE=$1

echo "Current Boot Mode: $(systemctl get-default)"

if [ "${TARGET_MODE}" == "" ]; then
    echo 'Following boot mode are supported'
    echo '--------------------------------------------'
    systemctl list-units --type target
    echo '--------------------------------------------'
    read -p 'Please choose one of: ' TARGET_MODE
fi

if [ "${TARGET_MODE}" == '' ]; then
    exit 0
fi

CONFIRMED='n'
read -p "Confirm change boot mode to '${TARGET_MODE}'? [Y/n]: " CONFIRMED
CONFIRMED=$(echo "${CONFIRMED}" | awk '{print tolower($0)}')
if [ "${CONFIRMED}" == 'y' ] || [ "${CONFIRMED}" == 'yes' ]; then
    sudo systemctl set-default ${TARGET_MODE}
    if [ $? -eq 0 ]; then
        echo "Boot mode has been changed to '${TARGET_MODE}'"

        REBOOT_NOW='n'
        read -p "Reboot now? [Y/n]: " REBOOT_NOW
        REBOOT_NOW=$(echo "${REBOOT_NOW}" | awk '{print tolower($0)}')
        if [ "${REBOOT_NOW}" == 'y' ] || [ "${REBOOT_NOW}" == 'yes' ]; then
            echo 'Rebooting ...'
            sudo systemctl reboot
        fi
    else
        echo 'Failed to change boot mode'
    fi
fi 


