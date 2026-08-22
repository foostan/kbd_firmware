#include "quantum.h"

void board_init(void) {
    /*
     * The PCB uses the reset-default USB FS mapping: PA11 is USB_DM and PA12
     * is USB_DP. No explicit remap write is needed because this firmware does
     * not set SYSCFG_CFGR1.PA11_RMP or PA12_RMP.
     *
     * The ChibiOS NUCLEO-G0B1RE board definition initially configures both
     * pins as GPIO inputs with pull-ups. Put them in analog mode before QMK
     * connects USB so the GPIO input buffers and pulls cannot load D- or D+.
     * Analog mode does not select the ADC here; it only disconnects the GPIO
     * digital path and leaves the pins available to the USB peripheral.
     */
    palSetPadMode(GPIOA, GPIOA_PIN11, PAL_MODE_INPUT_ANALOG);
    palSetPadMode(GPIOA, GPIOA_PIN12, PAL_MODE_INPUT_ANALOG);

    /*
     * The board has no external HSE crystal and uses HSI48 as the USB clock.
     * ChibiOS enables and selects HSI48, but it does not enable CRS automatic
     * trimming for this target. CRS uses the host's 1 kHz USB SOF stream to
     * measure HSI48 drift and adjust its trim value automatically. Enable the
     * CRS peripheral clock, read the clock-enable register back before using
     * CRS, select USB SOF as the synchronization source, and then start the
     * frequency error counter and automatic trimming. USB starts from the
     * factory-calibrated HSI48 value until SOF packets become available.
     */
    RCC->APBENR1 |= RCC_APBENR1_CRSEN;
    (void)RCC->APBENR1;

    CRS->CFGR =
        (CRS->CFGR & ~CRS_CFGR_SYNCSRC_Msk) |
        CRS_CFGR_SYNCSRC_1;

    CRS->CR |= CRS_CR_AUTOTRIMEN | CRS_CR_CEN;
}
