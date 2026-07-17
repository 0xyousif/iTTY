TARGET = iphone:clang:latest:12.2
INSTALL_TARGET_PROCESSES = iTTY

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = iTTY

iTTY_FILES = \
	Sources/AppDelegate.swift \
	Sources/RootViewController.swift

iTTY_CFLAGS += \
	-IVendor/libiosexec/include \
	-IVendor/libghostty-vt/include

iTTY_LDFLAGS += \
	-LVendor/libiosexec/lib \
	-LVendor/libghostty-vt/lib \
	-lghostty-vt \
	-liosexec \
	-Wl,-rpath,/var/jb/usr/lib

iTTY_SWIFTFLAGS += \
	-import-objc-header Sources/BridgingHeader.h

iTTY_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk
