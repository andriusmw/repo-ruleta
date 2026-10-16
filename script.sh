#!/bin/bash

# -------------------------------------------- FUNCTIONS -----------------------------------------
# ------------------------------------------------------------------------------------------------

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

function checkBet(){
    # receive even_odd , initial_bet , evenOddEvaluation
    local even_odd=$1
    local Linitial_bet=$2
    local evenOddEvaluation=$3

    if [ "$even_odd" == "$evenOddEvaluation" ]; then
    # checks if our bet is the same as the evenOddEvaluation value
        echo -e "\n Congratulations, you win! "
        reward=$(($Linitial_bet*2))
        money=$(($money+$reward))
        echo -e "\n Your reward is: $reward , your actual money is: $money "
        initial_bet=$backup_bet
        
    else
        echo -e "\n You Loose..."
        initial_bet=$((Linitial_bet*2))
    fi

}

#------------------------------------- BETTING ON MARTINGALA ----------------------------------
# ---------------------------------------------------------------------------------------------


function martingala(){
    echo -e "\n [+] Actual money: $money"
    echo -ne "\n [?] How much money to bet? (number_only) -->" && read initial_bet
    echo -ne "\n [?] Select type of bet: (Even/Odd) -->" && read even_odd

    echo -e "\n Playing with initial bet: $initial_bet and selecting: $even_odd"
    backup_bet=$initial_bet

    while true; do
        money=$(($money-$initial_bet))
        echo -e "\n  you bet $initial_bet , your money is: $money "

        random_number="$(($RANDOM % 37))"
        # Creates a random number from 0 to 36
        echo -e "\n [-] Number: $random_number"
            if [ $random_number == "0" ]; then
                echo -e " [-] Number is : $random_number the House wins..."
                initial_bet=$((initial_bet*2))
            elif [ "$(($random_number % 2))" -eq 0 ]; then
                # checks if the number is even 
                echo -e " [-] the number is Even"
                evenOddEvaluation="Even"
                checkBet "$even_odd" "$initial_bet" "$evenOddEvaluation"
                # checks if our bet is the same as "Even"
            else
                echo -e " [-] the number is Odd"
                evenOddEvaluation="Odd"
                checkBet "$even_odd" "$initial_bet" "$evenOddEvaluation"
                # checks if our bet is the same as "Odd"

            fi

        sleep 0.4
    done


}



# ----------------------------------- PROGRAM RUNNING --------------------------------------------
# ------------------------------------------------------------------------------------------------




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