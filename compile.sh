#!/usr/bin/env bash
# -----------------------------------
#| bgll.fullstackfullstock.com       |
#| github.com/babidiii               |
# -----------------------------------

DEF='\033[0m'
RED='\033[01;31m'
GRN='\033[01;32m'
YEL='\033[01;33m'

main(){
  image_name="babidiiitex"
  dockerfile_path="./Dockerfile"
  context_path="$(dirname ${dockerfile_path})"
  build_dir="./build"

  [ -d "${build_dir}" ] || mkdir "${build_dir}" 

	printf "${YEL}* Checking if %s image exists\n${DEF}" "${image_name}"
  res=$(podman images -q ${image_name} )
  if [[ -z "${res}" ]]; then
    printf "${RED}* Image doesn't exist\n${DEF}"
	  printf "${YEL}* Building the %s image\n${DEF}" "${image_name}"

    buildah build -t "${image_name}" -f "${dockerfile_path}" "${context_path}"
    [[ $? -ne 0 ]] && printf "${RED}* Error building the image${DEF}\n" && exit 1
  fi

	printf "${YEL}* Compiling \n${DEF}"
  podman run --rm --volume "`pwd`:/data" --entrypoint "/data/latex_compile.sh" "${image_name}" 
}

main "${@}"


