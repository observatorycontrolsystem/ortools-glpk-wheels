# ortools-glpk-wheels

or-tools wheels with GLPK support

## Build

Build wheels using buildx:

```shell
$ docker buildx bake manylinux
$ tree  wheelhouse/
wheelhouse/
├── ortools-9.3.9999-cp310-cp310-manylinux_2_27_aarch64.whl
├── ortools-9.3.9999-cp310-cp310-manylinux_2_27_x86_64.whl
├── ortools-9.3.9999-cp38-cp38-manylinux_2_27_aarch64.whl
├── ortools-9.3.9999-cp38-cp38-manylinux_2_27_x86_64.whl
├── ortools-9.3.9999-cp39-cp39-manylinux_2_27_aarch64.whl
└── ortools-9.3.9999-cp39-cp39-manylinux_2_27_x86_64.whl

0 directories, 6 files
```
