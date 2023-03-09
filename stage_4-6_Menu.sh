#!/usr/bin/bash

echo "Welcome to the True or False Game!"

ask_action() {
echo -e "0. Exit\n1. Play a game\n2. Display scores\n3. Reset scores\nEnter an option:"
}
while true; do
    ask_action
    read answer
    case $answer in
        0 )
            echo "See you later!"
            break;;
        1 )
            echo "Playing game";;
        2 )
            echo "Displaying scores";;
        3 )
            echo "Resetting scores";;
        * )
            echo "Invalid option!";;
    esac
done
