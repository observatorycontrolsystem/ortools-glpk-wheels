variable "OUTPUT" {
  default = "./output"
}

variable "CCACHE" {
  default = ""
}

variable "CACHE_TO_IMAGE" {
  default = ""
}

variable "CACHE_FROM_IMAGE" {
  default = "${CACHE_TO_IMAGE}"
}

variable "CACHE_TAG_PREFIX" {
  default = "cache-"
}

function "cacheFromReg" {
  params = [name]
  result = notequal("", CACHE_FROM_IMAGE) ? "type=registry,ref=${CACHE_FROM_IMAGE}:${CACHE_TAG_PREFIX}${name}": ""
}

function "cacheToReg" {
  params = [name]
  result = notequal("", CACHE_TO_IMAGE) ? "type=registry,ref=${CACHE_TO_IMAGE}:${CACHE_TAG_PREFIX}${name}": ""
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
  contexts = {
    cmake = "target:cmake"
    swig = "target:swig"
    ortools-src = "target:ortools-src"
    ccache = notequal("", CCACHE) ? "${CCACHE}": ""
  }
  cache-from = [
    cacheFromReg("ortools-src"),
    cacheFromReg("cmake"),
    cacheFromReg("swig"),
  ]
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

target "cmake" {
  dockerfile = "Dockerfile.manylinux-buildtools"
  target = "cmake"
  contexts = {
    cmake-src = "target:cmake-src"
  }
  cache-to = [
    cacheToReg("cmake")
  ]
  cache-from = [
    cacheFromReg("cmake")
  ]
}

target "swig" {
  dockerfile = "Dockerfile.manylinux-buildtools"
  target = "swig"
  contexts = {
    swig-src = "target:swig-src"
  }
  cache-to = [
    cacheToReg("swig")
  ]
  cache-from = [
    cacheFromReg("swig")
  ]
}

target "ortools-src" {
  dockerfile = "Dockerfile.buildsrc"
  target = "ortools-src"
  cache-to = [
    cacheToReg("ortools-src")
  ]
  cache-from = [
    cacheFromReg("ortools-src")
  ]
}

target "cmake-src" {
  dockerfile = "Dockerfile.buildsrc"
  target = "cmake-src"
  cache-to = [
    cacheToReg("cmake-src")
  ]
  cache-from = [
    cacheFromReg("cmake-src")
  ]
}

target "swig-src" {
  dockerfile = "Dockerfile.buildsrc"
  target = "swig-src"
  cache-to = [
    cacheToReg("swig-src")
  ]
  cache-from = [
    cacheFromReg("swig-src")
  ]
}
