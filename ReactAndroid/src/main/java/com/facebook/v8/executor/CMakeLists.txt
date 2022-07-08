# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

cmake_minimum_required(VERSION 3.13)
set(CMAKE_VERBOSE_MAKEFILE on)

add_compile_options(-Wno-pessimizing-move)

file(GLOB v8executor_SRC CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
add_library(v8executor SHARED ${v8executor_SRC})

target_include_directories(v8executor
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${REACT_COMMON_DIR}/jsi)

target_link_libraries(v8executor
        jsireact
        v8runtime
        fb
        fbjni
        folly_runtime
        v8
        jsi
        reactnativejni)

target_compile_options(v8executor
        PRIVATE
        -fexceptions
        -Wno-pessimizing-move)

# arm64-v8a, x86_64
if(${ANDROID_ABI} MATCHES "64(-v8a)?$")
        target_compile_options(v8executor PRIVATE -DV8_COMPRESS_POINTERS)
endif()
