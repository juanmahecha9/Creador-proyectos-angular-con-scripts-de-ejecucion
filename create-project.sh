#!/bin/bash
set -fueo pipefail

function main(){
    cd ..
    makeProject
    angularInit
    cd $projectNameDirectory
    scripts
    sleep 2
    # Delete the first git repository that was create at the moment to create the angular project
    sh git-remove.sh
}

function makeProject(){
    echo "Project name directory: "
    read projectNameDirectory
    mkdir $projectNameDirectory
    echo "Directory $projectNameDirectory was be created"
}

function angularInit(){
    cd $projectNameDirectory
    echo "Make a project"
    ng new $projectNameDirectory --style=scss -p a6s --routing true
}

function scripts(){
    echo "Scripts directory was created..."
    mkdir scripts
    cd scripts
    createShFiles
}

function createShFiles(){
   echo ".sh files was added to scripts box"
   #Estos archivos por practicidad y para evetirar errores a la hora de ejecución se cargaron en una nube, lo cual los permite descagar
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/services.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/run.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/readMe.md
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/git-remove.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/guard.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/common-components.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/componets.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/class.sh
}

main