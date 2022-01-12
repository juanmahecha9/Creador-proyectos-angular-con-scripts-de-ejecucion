#!/bin/bash
set -fueo pipefail

function readProjectName(){
    #read the name of the project 
    echo "Do not place space between the words containing the project name and underlines, for example place: test-project or testProject"
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
            echo ""
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
    echo "Proxy was created"
    sleep 2
    bootstrap
    echo "bootstrap dependencies was intalled"
    sleep 2
    angularMaterial
    echo "angular material dependencies was intalled"
    sleep 2
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
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631807053/scripts/components.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631665657/scripts/class.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1642025716/scripts/run.sh
   curl -O https://res.cloudinary.com/yuem1/raw/upload/v1632945626/scripts/modules.sh
)}

function proxy(){(
    # create file proxy conf
    cd $projectNameDirectory
    curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631667640/scripts/proxy.conf.json
)}

function bootstrap(){(
    cd $projectNameDirectory
    ### instalar bootstrap
    sleep 2
    npm i bootstrap jquery @popperjs/core
)}

function angularMaterial(){(
    cd $projectNameDirectory
    ### instalar bootstrap
    sleep 2
    ng add @angular/material
)}

function files(){(
    rm readMe.md
    curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631803567/scripts/readme%20angular/readMe.md
    sleep 1
    mkdir bootstrap-info
    cd bootstrap-info
    curl -O https://res.cloudinary.com/yuem1/raw/upload/v1631804273/scripts/bootstrap-info.txt
)}

function downloadImg(){(
    cd src/assets
    mkdir img
    cd img
    curl -O https://res.cloudinary.com/yuem1/image/upload/v1618457945/LOGO_YUEM.jpg
)}

function removeInfo(){(
    cd src/app
    cat /dev/null > app.component.html
    #Colocar nueva informacion
    sleep 1
    tee -a app.component.html << EOF
<h1 style="text-align: center;">Created by:</h1>
<h3 style="text-align: center;"><a href="https://github.com/juanmahecha9" target="_blank">Juanmahecha9</a></h3>
<hr>
<br>
<img style="display:block; margin:auto; " src="../assets/img/LOGO_YUEM.jpg" alt="Logo juanmahecha9">
EOF
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

    # New ReadMe
    files

    #download img
    downloadImg
    sleep 1

    # Eliminar informacion del archivo html principal
    removeInfo
    sleep 1
    # Delete the first git repository that was create at the moment to create the angular project
    sh scripts/git-remove.sh   
    echo " "
    echo "The first .git directory initialized automatically with the creation of the angular project was deleted... Now it's possible to start a new repository in your own git 😀"
    echo " "
    echo "function maked by: juanmahecha9"
    echo " "
    cd ..
    code $projectNameDirectory
}

main