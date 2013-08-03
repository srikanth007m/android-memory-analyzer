# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
#LOCAL_SHARED_LIBRARIES := mylib

MY_SRC := \
../src/dlmalloc.c 

LOCAL_MODULE    := dlmalloc
LOCAL_CFLAGS    :=  -ffunction-sections -funwind-tables -DMSPACES=1 -DUSE_DL_PREFIX=1 -DHAVE_MORECORE=0 -DLOG_ON_HEAP_ERROR=1  -DUSE_LOCKS=1 -g
LOCAL_LDLIBS    := 
#LOCAL_SHARED_LIBRARIES := myfunc
LOCAL_SRC_FILES :=  $(MY_SRC)

include $(BUILD_STATIC_LIBRARY)

################################################################################

include $(CLEAR_VARS)
LOCAL_ARM_MODE := thumb
#LOCAL_SHARED_LIBRARIES := mylib

MY_SRC := \
../src/main.cpp \
../src/ChunkInfo.cpp \
../src/DumpHeap.cpp \
../src/GlobalVariable_linux.cpp \
../src/HeapInfo.cpp \
../src/HeapServer.cpp \
../src/MapParse.cpp \
../src/StopWorld_linux.cpp \
../src/ThreadData_linux.cpp  

ifeq ($(TARGET_ARCH_ABI), armeabi)
MY_SRC += \
../src/ThreadData_linux_arm.cpp  
endif

ifeq ($(TARGET_ARCH_ABI), x86)
MY_SRC += \
../src/ThreadData_linux_x86.cpp  
endif
 

LOCAL_MODULE    := memanaly
LOCAL_CFLAGS    :=  -Werror  -ffunction-sections -fno-rtti -fvisibility=hidden -funwind-tables -DUSE_DL_PREFIX=1 -DMSPACES=1 -DENABLE_HEAP_SEVER=1 -g 
LOCAL_LDLIBS    :=  -Wl,--gc-sections -lc  -llog
LOCAL_STATIC_LIBRARIES := dlmalloc
LOCAL_SRC_FILES :=  $(MY_SRC)

include $(BUILD_SHARED_LIBRARY)

################################################################################

