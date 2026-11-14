#include "quantum.h"

void board_init(void) {
    /*
     * USB FS uses the reset-default PA11/USB_DM and PA12/USB_DP mapping.
     * The ChibiOS NUCLEO-G0B1RE board definition configures both pins as
     * GPIO inputs with pull-ups, so put them in analog mode before USB
     * starts to keep the GPIO buffers and pulls off D- and D+.
     */
    palSetPadMode(GPIOA, GPIOA_PIN11, PAL_MODE_INPUT_ANALOG);
    palSetPadMode(GPIOA, GPIOA_PIN12, PAL_MODE_INPUT_ANALOG);

    /*
     * PA8 is UCPD1_CC1 and its USB-C dead-battery pull-down (~5.1 kOhm) can
     * be active after reset, which overpowers the GPIO pull-up and holds the
     * left COL5 low. Strobe UCPD1/UCPD2 to hand the pins over to GPIO.
     */
    RCC->APBENR2 |= RCC_APBENR2_SYSCFGEN;
    (void)RCC->APBENR2;
    SYSCFG->CFGR1 |= SYSCFG_CFGR1_UCPD1_STROBE | SYSCFG_CFGR1_UCPD2_STROBE;

    /*
     * There is no HSE crystal and USB is clocked from HSI48. Enable CRS and
     * trim HSI48 automatically against the host's 1 kHz USB SOF.
     */
    RCC->APBENR1 |= RCC_APBENR1_CRSEN;
    (void)RCC->APBENR1;

    CRS->CFGR =
        (CRS->CFGR & ~CRS_CFGR_SYNCSRC_Msk) |
        CRS_CFGR_SYNCSRC_1;

    CRS->CR |= CRS_CR_AUTOTRIMEN | CRS_CR_CEN;
}
