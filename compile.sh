#!/usr/bin/env bash
# -----------------------------------
#| bgll.fullstackfullstock.com       |
#| github.com/babidiii               |
# -----------------------------------

RESET=$(tput sgr0)
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)

log(){
  color=${1}
  val=${2}
  printf "* %s\n" "${BOLD}${color}${val}${RESET}"
}

is_command_installed(){
  local command_name=${1}
  if [ ! -n "$(command -v ${command_name})" ]; then
    log "${RED}" "${command_name} command not installed"
    return 1
  else
    log "${GREEN}" "${command_name} command installed"
    return 0
  fi
}

main(){
  image_name="templex"
  dockerfile_path="./Dockerfile"
  context_path="$(dirname ${dockerfile_path})"
  build_dir="./build"

  if is_command_installed "podman" ; then 
    cmd=(podman)
    build_cmd=(podman)
    run_cmd=(podman)
  elif is_command_installed "docker"; then
    cmd=(docker)
    build_cmd=(docker)
    run_cmd=(docker)
  else 
    log "${RED}" "You need to install either docker or podman"
    exit 1
  fi

  build_cmd+=(build -t "${image_name}" -f "${dockerfile_path}" "${context_path}")
  run_cmd+=(run --rm -ti --volume "`pwd`:/data" --entrypoint "/data/latex_compile.sh" "${image_name}")

  [ -d "${build_dir}" ] || mkdir "${build_dir}" 

	log "${YEL}" "Checking if ${image_name} image exists"
  res=$($cmd images -q ${image_name} )
  if [[ -z "${res}" ]]; then
    log "${RED}" "Image doesn't exist"
	  log "${YEL}" "Building the ${image_name} image"

    ${build_cmd[@]}
    [[ $? -ne 0 ]] && log "${RED}" "Error building the image" && exit 1
  else
	  log "${YEL}" "Image  ${image_name} exist"
  fi

	log "${YEL}" "Running the container"
  ${run_cmd[@]}
}

main "${@}"


