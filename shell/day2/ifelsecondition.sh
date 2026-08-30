#!/bin/bash

function is_married() {
    read -p "Enter the unmarried person's name: " banda
    read -p "How old are they? " age

    if [[ $banda == "Prashant" ]]; then
        echo "Yes"
    elif [[ $age -ge 30 ]]; then
        echo "He will get married"
    else
        echo "No"
    fi
}

is_married
