#!/usr/bin/env bash

echo "Welcome to the True or False Game!"
curl --silent --output ID_card.txt http://127.0.0.1:8000/download/file.txt
read line < ID_card.txt
username=$(echo $line | cut -d '"' -f 4 )
password=$(echo $line | cut -d '"' -f 8 )
message=$(curl --silent --cookie-jar cookie.txt --user $username:$password http://127.0.0.1:8000/login)
echo "Login message: $message"
