#!/bin/bash

echo "Type in a username you want to be created: \n"
read username
echo "Type in the full name of that user. First- and lastname: \n" 
read fullname

if [[ "$username" =~ ^[a-zA-Z]+$ ]]
then
    echo "username works"
    if [[ "$fullname" =~ ^[A-Z]{1}[a-z]*[[:space:]][A-Z]{1}[a-z]*$ ]]
    then
        first_name=${fullname%%[[:space:]]*}
        echo $first_name "\n"
        last_name=${fullname##*[[:space:]]}
        echo $last_name
    else
        echo "Invalid fullname. The Firstname has to start with a capital letter, as well as the lastname.\n Inbetween there also should be a space."
    fi
else
    echo "Invalid username. Please use only lowercase or capital letters."
fi
