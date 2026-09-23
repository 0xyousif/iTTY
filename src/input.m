#import <UIKit/UIKit.h>
#include "ghostty/vt.h"

GhosttyKey uikit_key_to_ghostty(UIKeyboardHIDUsage usage)
{
    if (usage >= UIKeyboardHIDUsageKeyboardA && usage <= UIKeyboardHIDUsageKeyboardZ) {
        return GHOSTTY_KEY_A + (usage - UIKeyboardHIDUsageKeyboardA);
    }
    if (usage == UIKeyboardHIDUsageKeyboard0) {
        return GHOSTTY_KEY_DIGIT_0;
    }
    if (usage >= UIKeyboardHIDUsageKeyboard1 && usage <= UIKeyboardHIDUsageKeyboard9) {
        return GHOSTTY_KEY_DIGIT_1 + (usage - UIKeyboardHIDUsageKeyboard1);
    }

    switch (usage) {
    case UIKeyboardHIDUsageKeyboardSpacebar:              return GHOSTTY_KEY_SPACE;
    case UIKeyboardHIDUsageKeyboardReturnOrEnter:         return GHOSTTY_KEY_ENTER;
    case UIKeyboardHIDUsageKeyboardTab:                   return GHOSTTY_KEY_TAB;
    case UIKeyboardHIDUsageKeyboardDeleteOrBackspace:     return GHOSTTY_KEY_BACKSPACE;
    case UIKeyboardHIDUsageKeyboardDeleteForward:         return GHOSTTY_KEY_DELETE;
    case UIKeyboardHIDUsageKeyboardEscape:                return GHOSTTY_KEY_ESCAPE;
    case UIKeyboardHIDUsageKeyboardUpArrow:               return GHOSTTY_KEY_ARROW_UP;
    case UIKeyboardHIDUsageKeyboardDownArrow:             return GHOSTTY_KEY_ARROW_DOWN;
    case UIKeyboardHIDUsageKeyboardLeftArrow:             return GHOSTTY_KEY_ARROW_LEFT;
    case UIKeyboardHIDUsageKeyboardRightArrow:            return GHOSTTY_KEY_ARROW_RIGHT;
    case UIKeyboardHIDUsageKeyboardHome:                  return GHOSTTY_KEY_HOME;
    case UIKeyboardHIDUsageKeyboardEnd:                   return GHOSTTY_KEY_END;
    case UIKeyboardHIDUsageKeyboardPageUp:                return GHOSTTY_KEY_PAGE_UP;
    case UIKeyboardHIDUsageKeyboardPageDown:              return GHOSTTY_KEY_PAGE_DOWN;
    case UIKeyboardHIDUsageKeyboardInsert:                return GHOSTTY_KEY_INSERT;
    case UIKeyboardHIDUsageKeyboardHyphen:                return GHOSTTY_KEY_MINUS;
    case UIKeyboardHIDUsageKeyboardEqualSign:             return GHOSTTY_KEY_EQUAL;
    case UIKeyboardHIDUsageKeyboardOpenBracket:           return GHOSTTY_KEY_BRACKET_LEFT;
    case UIKeyboardHIDUsageKeyboardCloseBracket:          return GHOSTTY_KEY_BRACKET_RIGHT;
    case UIKeyboardHIDUsageKeyboardBackslash:             return GHOSTTY_KEY_BACKSLASH;
    case UIKeyboardHIDUsageKeyboardSemicolon:             return GHOSTTY_KEY_SEMICOLON;
    case UIKeyboardHIDUsageKeyboardQuote:                 return GHOSTTY_KEY_QUOTE;
    case UIKeyboardHIDUsageKeyboardComma:                 return GHOSTTY_KEY_COMMA;
    case UIKeyboardHIDUsageKeyboardPeriod:                return GHOSTTY_KEY_PERIOD;
    case UIKeyboardHIDUsageKeyboardSlash:                 return GHOSTTY_KEY_SLASH;
    case UIKeyboardHIDUsageKeyboardGraveAccentAndTilde:   return GHOSTTY_KEY_BACKQUOTE;
    default:                                              return GHOSTTY_KEY_UNIDENTIFIED;
    }
}