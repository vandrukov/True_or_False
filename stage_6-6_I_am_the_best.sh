#!/usr/bin/bash

file_name="scores.txt"
echo "Welcome to the True or False Game!"

ask_action() {
echo -e "0. Exit\n1. Play a game\n2. Display scores\n3. Reset scores\nEnter an option:"
}


score() {
if [[ -f "$file_name" && -s $file_name ]]; then
    #file exists and not empty
    echo "Player scores"
    cat $file_name
else 
    echo "File not found or no scores in it!"
fi
}

delete() {
if [[ -f "$file_name" && -s $file_name ]]; then
    #file exists and not empty
    rm $file_name
    echo "File deleted successfully!"
else 
    echo "File not found or no scores in it!"
fi
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
echo "User: $name, Score: $(( $number_of_correct_answers * 10 )), Date: $(date +'%Y-%m-%d')" >> "$file_name"
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
            score;;
        3 )
            delete;;
        * )
            echo "Invalid option!";;
    esac
done
