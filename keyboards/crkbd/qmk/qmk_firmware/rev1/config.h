#pragma once

/* Select hand configuration */
#define MASTER_LEFT
// #define MASTER_RIGHT
// #define EE_HANDS

#ifdef RGB_MATRIX_ENABLE
#  define RGB_MATRIX_LED_COUNT 54
#  define SPLIT_TRANSPORT_MIRROR
#endif

#ifndef OLED_FONT_H
#  define OLED_FONT_H "keyboards/crkbd/lib/glcdfont.c"
#endif
