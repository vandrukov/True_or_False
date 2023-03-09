#!/usr/bin/bash

echo "Welcome to the True or False Game!"

ask_action() {
echo -e "0. Exit\n1. Play a game\n2. Display scores\n3. Reset scores\nEnter an option:"
}

question() {
curl --silent --output ID_card.txt http://127.0.0.1:8000/download/file.txt
read line < ID_card.txt
username=$(echo $line | cut -d '"' -f 4 )
password=$(echo $line | cut -d '"' -f 8 )
message=$(curl --silent --cookie-jar cookie.txt --user $username:$password http://127.0.0.1:8000/login)
echo "Login message: $message"
answer=$(curl --silent --cookie cookie.txt http://127.0.0.1:8000/game)
question_ask=$(echo $answer | cut -d '"' -f 4 )
answer_ask=$(echo $answer | cut -d '"' -f 8 )
echo $question_ask
}

random_phrase() {
array[0]="Perfect!"
array[1]="Awesome!"
array[2]="You are a genius!"
array[3]="Wow!"
array[4]="Wonderful!"
echo "${array[$((RANDOM % 5))]}"
}

play() {
number_of_correct_answers=0
echo "What is your name?"
read name
while true; do
    question
    echo "True or False?"
    read response
    if [[ "$response" = $answer_ask ]]; then
        (( number_of_correct_answers++ ))
        random_phrase
    else
        break
    fi
done
echo "Wrong answer, sorry!"
echo "$name you have $number_of_correct_answers correct answer(s)."
echo "Your score is $(( $number_of_correct_answers * 10 )) points."
}

while true; do
    ask_action
    read answer
    case $answer in
        0 )
            echo "See you later!"
            break;;
        1 )
            play;;
        2 )
            echo "Displaying scores";;
        3 )
            echo "Resetting scores";;
        * )
            echo "Invalid option!";;
    esac
done
