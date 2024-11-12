LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := nuke-apps
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := DevicePolicyPrebuilt Maps MyVerizonServices SafetyHubPrebuilt ScribePrebuilt Showcase YouTube YouTubeMusicPrebuilt obdm_stub Snap GoogleTTS LocationHistoryPrebuilt MarkupGoogle Velvet WellbeingPrebuilt PrebuiltGmail talkback Videos Chrome-Stub Chrome PartnerSetupPrebuilt DuckDuckGo SimpleCalendar Seedvault SimpleGallery
LOCAL_UNINSTALLABLE_MODULE := true
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := /dev/null
include $(BUILD_PREBUILT)
