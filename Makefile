ARCHS = arm64
TARGET := iphone:clang:latest:13.4
INSTALL_TARGET_PROCESSES = iTTY

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = iTTY

iTTY_FILES = \
	src/main.m \
	src/ittyRootViewController.m \
	src/ittyAppDelegate.m \
	src/pty.c \
	src/input.m

iTTY_FRAMEWORKS = UIKit CoreGraphics
iTTY_CFLAGS = -fobjc-arc

iTTY_CFLAGS += \
	-IVendor/libiosexec/include \
	-IVendor/libghostty-vt/include

iTTY_LDFLAGS += \
	-LVendor/libiosexec/lib \
	-LVendor/libghostty-vt/lib \
	-lghostty-vt \
	-liosexec \
	-Wl,-rpath,/var/jb/usr/lib

include $(THEOS_MAKE_PATH)/application.mk
