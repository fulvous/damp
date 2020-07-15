#!/bin/bash

## change
project_name="ejemx"
project_type="dev"
project_version="1.0"

real_path=$(dirname $(readlink -f $0))
path="$(dirname "$real_path")"

#include herramientax
for i in $( find ${real_path}/herramientax/libs -type f ) ; do
  source $i
done

filename="stack.${project_type}.yml"
stack_path="${path}/files/${filename}"
network_name="${project_name}_${project_type}_net"
image_name="${project_name}-${project_type}:${project_version}"
db_container_name="${project_name}_${project_type}_db"
web_container_name="${project_name}_${project_type}"

exec_cmd() {
  cmd="$@"
  ERROR=$( $cmd 2>&1 /dev/null )
  [ $? -eq 0 ] || res_err "$cmd" "$ERROR" "ERROR"
}

deleteImages(){
  informa "Delete docker image" "($project_type)" "START"
  #exec_cmd "docker rmi $image_name"
  docker rmi $image_name
}

deleteContainers(){
  informa "Delete docker containers" "($project_type)" "START"
  #exec_cmd "docker rm -f $db_container_name $web_container_name"
  docker rm -f $db_container_name $web_container_name
}

deleteNet(){
  informa "Delete docker network" "($project_type)" "START"
  #exec_cmd "docker network rm $network_name"
  docker network rm $network_name
}

buildDockerCompose(){
  informa "Docker compose build" "($project_type)" "START"
  #exec_cmd "docker-compose -f $stack_path build"
  docker-compose -f $stack_path build
}

runDockerCompose(){
  informa "Docker compose up" "($project_type)" "START"
  #exec_cmd "docker-compose -f $stack_path up -d"
  docker-compose -f $stack_path up -d
}

deleteAll(){
  deleteContainers
  deleteNet
  deleteImages
  quit
}

runAll(){
  deleteContainers
  deleteNet
  deleteImages
  buildDockerCompose
  runDockerCompose
  quit
}

quit(){
  exit 0
}

selectType() {
  jumbotron \
    "Select your project type:" \
    " 1. Development (DEFAULT)" \
    " 2. Production"
}

readType () {
  local choice
  read -p "Select type: " choice
  if [ "$choice" == "2" ] ; then
    project_type="prod"
  else
    project_type="dev"
  fi
  res_ok "Project type selected" "$project_type" "OK"
}

showMenu() {
	jumbotron \
	 "Options (DEV):" \
	 "1. Delete docker containers" \
	 "2. Delete docker network" \
	 "3. Delete docker images" \
	 "4. Run build" \
	 "5. Run docker compose" \
	 "6. Run all" \
	 "7. Delete all" \
   "8. Exit"
}

readOptions(){
	local choice
	read -p "Enter choice: " choice
	case $choice in
		1) 
      deleteContainers
      quit
      ;;
		2) 
      deleteNet
      quit
      ;;
		3) 
      deleteImages
      quit
      ;;
		4) 
      buildDockerCompose
      quit
      ;;
		5) 
      runDockerCompose
      quit
      ;;
		6) runAll ;;
		7) deleteAll ;;
		8) exit 0;;
		*) informa "Invalid option" "$choice" "Please retry" && sleep 2
	esac
}

selectType
readType

while true
do
	showMenu
	readOptions
done

