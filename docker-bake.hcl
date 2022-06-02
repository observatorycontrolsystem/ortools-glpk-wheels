variable "WHEELHOUSE" {
  default = "./wheelhouse"
}

group "default" {
  targets = ["manylinux"]
}

group "manylinux" {
  targets = ["manylinux-x86_64", "manylinux-aarch64"]
}

group "manylinux-x86_64" {
  targets = [
    "310-manylinux-x86_64",
    "39-manylinux-x86_64",
    "38-manylinux-x86_64",
  ]
}

group "manylinux-aarch64" {
  targets = [
    "310-manylinux-aarch64",
    "39-manylinux-aarch64",
    "38-manylinux-aarch64",
  ]
}

target "310-manylinux-x86_64" {
  dockerfile = "Dockerfile.manylinux"
  platforms = ["linux/amd64"]
  args = {
    PYTHON_VERSION = "3.10"
    WHEEL_PLATFORM = "manylinux_2_27_x86_64"
  }
  output = ["${WHEELHOUSE}"]
}

target "39-manylinux-x86_64" {
  inherits = ["310-manylinux-x86_64"]
  args = {
    PYTHON_VERSION = "3.9"
  }
}

target "38-manylinux-x86_64" {
  inherits = ["39-manylinux-x86_64"]
  args = {
    PYTHON_VERSION = "3.8"
  }
}

target "310-manylinux-aarch64" {
  dockerfile = "Dockerfile.manylinux"
  platforms = ["linux/arm64"]
  args = {
    PYTHON_VERSION = "3.10"
    WHEEL_PLATFORM = "manylinux_2_27_aarch64"
  }
  output = ["${WHEELHOUSE}"]
}

target "39-manylinux-aarch64" {
  inherits = ["310-manylinux-aarch64"]
  args = {
    PYTHON_VERSION = "3.9"
  }
}

target "38-manylinux-aarch64" {
  inherits = ["39-manylinux-aarch64"]
  args = {
    PYTHON_VERSION = "3.8"
  }
}
