<p align="center">
  <img align="center" alt="logo" src=".assets/templex.gif" />
</p>

# Templex

Templex is a template for latex report without installing anything on your machine. It works with containerization.  
The project is based on [TinyTex](https://yihui.org/tinytex/) a lightweight and easy to maintain LaTeX distribution.

## Dependancies

You will need either 
- **docker**
- **podman** and **buildah**

The output result will be a container defined as the following schema.

```sh
podman run --rm -ti --volume "`pwd`:/data" --entrypoint "/data/latex_compile.sh" "templex"

               Templex container
              ┌─────────────────────┐
              │      - TinyTex      │
              │      - entr      ┌──────────┐
              │      - ...       │ENTRYPOINT│─┐
              │                  └──────────┘ │
              │  ┌───────────────┐  │         │
              │  │ VOLUME (/data)│  │         │
              │  └───────┬───────┘  │         │
              └──────────┼──────────┘         │
                         │                    │
             ┌───────────┴────────────┐       │
             │  ./                    │       │
             │  ├── build/            │       │
             │  ├── images/           │       │
             │  ├── src/              │       │
             │  ├── Dockerfile        │       │
             │  ├── compile.sh*       │       │
             │  ├── latex_compile.sh* ◄───────┘
             │  ├── LICENSE           │
             │  └── README.md         │
             └────────────────────────┘
```

## Installation & usage

Run the `compile.sh` script which will use either podman or docker.  
If the image doesn't exist yet it will build it before running it within a container.

```sh
./compile
```

The latex compilation chain is made in order to provide autoreload with `entr` command.
If you want to customize your compilation you can change the `latex_compilation.sh` script

Here is what `latex_compilation` does
```sh
find -name *.tex | entr xelatex -shell-escape -output-directory=./build ./src/rapport.tex 
# on each files given bu the find command if any change happend then entr will trigger the xeltex command
# The xelatex command will take your source code from /src directory 
# And the output will be found in the build directory
```

If you need a package that is not installed you will have to add it within the Dockerfile and rebuild your image.

```yml
RUN tlmgr install packages ... yourpackage
# then rebuild the image
```

## Things to do

- I will soon add the image to a registry.
- Add some utils scripts for latex
