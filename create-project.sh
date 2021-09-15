#!/bin/bash
set -fueo pipefail

function readProjectName(){
    #read the name of the project 
    echo "Do not place space between the words containing the project name, for example place: test-project or testProject or test_project"
    echo " "
    echo " "
    echo "🤓 Project name directory: "
    read projectNameDirectory
}

function makeProject(){
    readProjectName
    # directory exists?
    if [ -d "$projectNameDirectory" ]
        then
            echo "The directory exists, Please enter a new name."
            echo " "
            readProjectName
            mkdir $projectNameDirectory
            echo "✅ Directory $projectNameDirectory was be created"
            sleep 6
    else
        echo " "
            mkdir $projectNameDirectory
            echo "✅ Directory $projectNameDirectory was be created"
            sleep 6
    fi    
}

function angularInit(){(
    cd $projectNameDirectory
    echo "Make a project"
    ng new $projectNameDirectory --style=scss -p a6s --routing true
    sleep 3
    proxy
)}

function scripts(){(
    echo "Scripts directory was created..."
    mkdir scripts
    cd scripts
    createShFiles
)}

function createShFiles(){(
   echo ".sh files was added to scripts box"
   #Estos archivos por practicidad y para evetirar errores a la hora de ejecución se cargaron en una nube, lo cual los permite descagar
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/services.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/readMe.md
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/git-remove.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/guard.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/common-components.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/componets.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/class.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631727489/scripts/run.sh
)}

function proxy(){(
    # create file proxy conf
    cd $projectNameDirectory
    curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631667640/scripts/proxy.conf.json
)}

# Main function.
function main(){
    cd ..
    # Create directory
    makeProject
    # Create angular project
    angularInit
    # cd to new directory
    cd $projectNameDirectory
    # cd to angular project
    cd $projectNameDirectory
    # Create script folder
    scripts
    sleep 2
    # Delete the first git repository that was create at the moment to create the angular project
    sh scripts/git-remove.sh
    echo " "
    echo "The first .git directory initialized automatically with the creation of the angular project was deleted... Now it's possible to start a new repository in your own git 😀"
}

main