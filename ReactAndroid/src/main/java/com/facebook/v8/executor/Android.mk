# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := v8executor

LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/*.cpp)

LOCAL_CFLAGS := -Wno-pessimizing-move

ifeq ($(TARGET_ARCH_ABI), arm64-v8a)
  LOCAL_CFLAGS += -DV8_COMPRESS_POINTERS
else ifeq ($(TARGET_ARCH_ABI), x86_64)
  LOCAL_CFLAGS += -DV8_COMPRESS_POINTERS
endif

LOCAL_C_INCLUDES := $(LOCAL_PATH) $(REACT_COMMON_DIR)/jsi

LOCAL_CPP_FEATURES := exceptions

LOCAL_STATIC_LIBRARIES := libjsireact libjsi v8runtime
LOCAL_SHARED_LIBRARIES := \
  libfb \
  libfbjni \
  libfolly_json \
  libv8 \
  libreactnativejni

include $(BUILD_SHARED_LIBRARY)
