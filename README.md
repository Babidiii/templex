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

## Installation & usage

Run the `compile.sh` script which will use either podman or docker.  
If the image doesn't exist yet it will build it before running it within a container.

```sh
./compile
```

The latex compilation chain is made in order to provide autoreload with `entr` command.
If you want to customize your compilation you can change the `latex_compilation.sh` script

```sh
./compile 
```

If you need a package that is not installed you will have to add it within the Dockerfile and rebuild your image
