#pragma once

/* Split serial TX (PB6) is USART1_TX on AF0; the QMK default is AF7 */
#define SERIAL_USART_TX_PAL_MODE 0

/* VBUS of the host-side USB-C (J1) through a divider, used for master detection */
#define USB_VBUS_PIN B3
