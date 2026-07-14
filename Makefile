TARGET = iphone:clang:latest:12.2
INSTALL_TARGET_PROCESSES = iTTY

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = iTTY

iTTY_FILES = \
	Sources/AppDelegate.swift \
	Sources/RootViewController.swift

iTTY_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk
