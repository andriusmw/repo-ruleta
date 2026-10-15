#!/bin/bash

function ctrl_c(){
    echo -e "\n\n [!] Exitting ... \n"
    exit 1
}


# Ctrl+C
trap ctrl_c INT

# Help Panel
function helpPanel(){
    echo -e "\n [!] Instructions ...\n \n"
    echo -e "\n -m) Money playing with "
    echo -e "\n -t) Technique playing with "
    

}


function martingala(){
    echo -e "\n [+] Actual money: $money"
    echo -ne "\n [?] How much money to bet ? -->" && read initial_bet
    echo -ne "\n [?] Select Even or Odd: -->" && read even_odd

    echo -e "\n Playing with initial bet: $initial_bet and selecting: $even_odd"

    while true; do
        random_number="$(($RANDOM % 37))"
        # Creates a random number from 0 to 36
        echo -e "\n [-] Number: $random_number"

        sleep 10
    done


}








while getopts "m:t:h" arg; do
    case $arg in
    m) money=$OPTARG;;
    t) technique=$OPTARG;;
    h) helpPanel;;
    esac
done 

# if else to check which option is active
if [ $money ] && [ $technique ]; then
    echo -e "Playing with $money money and $technique technique"
    if [ $technique == "martingala" ]; then
        echo -e "Accepted : $technique technique"
        martingala
    elif [ $technique == "Binverse" ]; then
         echo -e "Accepted : $technique technique"
    else
         echo -e "Rejected : $technique technique. "
         echo -e "Accepted techniques are \""martingala"\" and \""Binverse"\" (Labrouchere Inverse)"
    fi
else
    echo -e "going to the else"
fi 