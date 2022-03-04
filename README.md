# latex_base
Template for latex report

## Dependancies

- podman/buildah

If you want to use docker you will just need to change the following line in the `compile.sh` file.

```diff
--- a/compile.sh
+++ b/compile.sh
@@ -23,12 +23,12 @@ main(){
     printf "${RED}* Image doesn't exist\n${DEF}"
     printf "${YEL}* Building the %s image\n${DEF}" "${image_name}"

-    buildah build -t "${image_name}" -f "${dockerfile_path}" "${context_path}"
+    docker build -t "${image_name}" -f "${dockerfile_path}" "${context_path}"
     [[ $? -ne 0 ]] && printf "${RED}* Error building the image${DEF}\n" && exit 1
   fi

        printf "${YEL}* Compiling \n${DEF}"
-  podman run --rm --volume "`pwd`:/data" --entrypoint "/data/latex_compile.sh" "${image_name}"
+  docker run --rm --volume "`pwd`:/data" --entrypoint "/data/latex_compile.sh" "${image_name}"
}
```

## Run 

```sh
./compile 
```
