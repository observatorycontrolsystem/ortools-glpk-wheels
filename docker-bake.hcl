variable "OUTPUT" {
  default = "./"
}

group "default" {
  targets = ["manylinux-x86_64", "manylinux-aarch64"]
}

group "manylinux-x86_64" {
  targets = ["310-manylinux-x86_64", "39-manylinux-x86_64", "38-manylinux-x86_64"]
}

group "manylinux-aarch64" {
  targets = ["310-manylinux-aarch64", "39-manylinux-aarch64", "38-manylinux-aarch64"]
}

target "_manylinux" {
  dockerfile = "Dockerfile.manylinux"
  output = ["${OUTPUT}"]
}

target "_x86_64" {
  platforms = ["linux/amd64"]
  args = {
    WHEEL_ARCH = "x86_64"
  }
}

target "_aarch64" {
  platforms = ["linux/arm64"]
  args = {
    WHEEL_ARCH = "aarch64"
  }
}

target "_python-310" {
  args = {
    PYTHON_VERSION = "3.10"
  }
}

target "_python-39" {
  args = {
    PYTHON_VERSION = "3.9"
  }
}

target "_python-38" {
  args = {
    PYTHON_VERSION = "3.8"
  }
}

target "310-manylinux-x86_64" {
  inherits = ["_manylinux", "_python-310", "_x86_64"]
}

target "39-manylinux-x86_64" {
  inherits = ["_manylinux", "_python-39", "_x86_64"]
}

target "38-manylinux-x86_64" {
  inherits = ["_manylinux", "_python-38", "_x86_64"]
}

target "310-manylinux-aarch64" {
  inherits = ["_manylinux", "_python-310", "_aarch64"]
}

target "39-manylinux-aarch64" {
  inherits = ["_manylinux", "_python-39", "_aarch64"]
}

target "38-manylinux-aarch64" {
  inherits = ["_manylinux", "_python-38", "_aarch64"]
}
