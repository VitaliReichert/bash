#!/bin/bash

echo "Type in a username you want to be created: \n"
read username
echo "Type in the full name of that user. First- and lastname: \n" 
read fullname
echo "Type in a password for the user.\n"
read password

if [[ "$username" =~ ^[a-zA-Z]+$ ]]
then
    echo "username works"
    if [[ "$fullname" =~ ^[A-Z]{1}[a-z]*[[:space:]][A-Z]{1}[a-z]*$ ]]
    then
        first_name=${fullname%%[[:space:]]*}
        echo $first_name "\n"
        last_name=${fullname##*[[:space:]]}
        echo $last_name
        sudo dscl . -create /Users/"$username"
        sudo dscl . -create /Users/"$username" UserShell /bin/bash
        sudo dscl . -create /Users/"$username" RealName ""$fullname""
        uid=$(grep -E '^UID_MIN' /etc/login.defs | cut -f 4)
        uid=$((uid+1))
        echo "creating user with the uid: $uid ..."
        sudo dscl . -create/Users/"$username" PrimaryGroupID 1000
        sudo dscl . -create /Users/"$username" NFSHomeDirectory /Local/Users/"$username"
        sudo dscl . -passwd /Users/username "$password"
        sudo dscl . -append /Groups/admin GroupMembership "$username"
    else
        echo "Invalid fullname. The Firstname has to start with a capital letter, as well as the lastname.\n Inbetween there also should be a space."
    fi
else
    echo "Invalid username. Please use only lowercase or capital letters."
fi
