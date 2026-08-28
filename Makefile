TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = iTTY

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = iTTY

iTTY_FILES = main.m ittyAppDelegate.m ittyRootViewController.m
iTTY_FRAMEWORKS = UIKit CoreGraphics
iTTY_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/application.mk
