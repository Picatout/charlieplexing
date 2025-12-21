;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2025/10/25
; STM8S050J3 µC registers map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.module STM8L050J3
	

; HSI clock frequency
 Fmaster = 16000000

; controller memory regions
RAM_SIZE = (1024) 
EEPROM_SIZE = (256)
FLASH_SIZE = (8192)
PAGE_SIZE= (64)

 RAM_BASE = (0)
 RAM_END = (RAM_BASE+RAM_SIZE-1)
 EEPROM_BASE = (0x1000)
 EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
OPTION_BASE = 0X4800 
OPTION_END = 0X480C 
 SFR_BASE = (0x5000)
 SFR_END = (0x5457)
 FLASH_BASE = (0x8000)
 FLASH_END = (FLASH_BASE+FLASH_SIZE-1)

; port bit
 PIN0 = (0) 
 PIN1 = (1)
 PIN2 = (2)
 PIN3 = (3)
 PIN4 = (4)
 PIN5 = (5)
 PIN6 = (6)
 PIN7 = (7)

GPIO_BASE = (0x5000)
GPIO_SIZE = (5)
; PORTS SFR OFFSET
PA = (0x5000)
PB = (0x5005)
PC = (0x500A)
PD = (0x500F)

GPIO_ODR = (0)
GPIO_IDR = (1)
GPIO_DDR = (2)
GPIO_CR1 = (3)
GPIO_CR2 = (4)

; GPIO
 PA_ODR  = (0x5000)
 PA_IDR  = (0x5001)
 PA_DDR  = (0x5002)
 PA_CR1  = (0x5003)
 PA_CR2  = (0x5004)

 PB_ODR  = (0x5005)
 PB_IDR  = (0x5006)
 PB_DDR  = (0x5007)
 PB_CR1  = (0x5008)
 PB_CR2  = (0x5009)

 PC_ODR  = (0x500A)
 PC_IDR  = (0x500B)
 PC_DDR  = (0x500C)
 PC_CR1  = (0x500D)
 PC_CR2  = (0x500E)

 PD_ODR  = (0x500F)
 PD_IDR  = (0x5010)
 PD_DDR  = (0x5011)
 PD_CR1  = (0x5012)
 PD_CR2  = (0x5013)

; input modes CR1
 INPUT_FLOAT = (0)
 INPUT_PULLUP = (1)
; output mode CR1
 OUTPUT_OD = (0)
 OUTPUT_PP = (1)
; input modes CR2
 INPUT_DI = (0)
 INPUT_EI = (1)
; output speed CR2
 OUTPUT_SLOW = (0)
 OUTPUT_FAST = (1)


; Flash
 FLASH_CR1  = (0x5050)
 FLASH_CR2  = (0x5051)
 FLASH_PUKR  = (0x5052)
 FLASH_DUKR  = (0x5034)
 FLASH_IAPSR  = (0x5054)

; data memory unlock keys
 FLASH_DUKR_KEY1 = (0xae)
 FLASH_DUKR_KEY2 = (0x56)
; flash memory unlock keys
 FLASH_PUKR_KEY1 = (0x56)
 FLASH_PUKR_KEY2 = (0xae)
; FLASH_CR1 bits
 FLASH_CR1_HALT = (3)
 FLASH_CR1_AHALT = (2)
 FLASH_CR1_IE = (1)
 FLASH_CR1_FIX = (0)
; FLASH_CR2 bits
 FLASH_CR2_OPT = (7)
 FLASH_CR2_WPRG = (6)
 FLASH_CR2_ERASE = (5)
 FLASH_CR2_FPRG = (4)
 FLASH_CR2_PRG = (0)
; FLASH_IAPSR bits
 FLASH_IAPSR_HVOFF = (6)
 FLASH_IAPSR_DUL = (3)
 FLASH_IAPSR_EOP = (2)
 FLASH_IAPSR_PUL = (1)
 FLASH_IAPSR_WR_PG_DIS = (0)

; DMA1 registers 
DMA1_GCSR =0x5070 ;global configuration & status register0xFC
DMA1_GIR1 =0x5071 ;global interrupt register 1
DMA1_C0CR =0x5075 ; channel 0 configuration register
DMA1_C0SPR =0x5076 ; channel 0 status & priority register
DMA1_C0NDTR =0x5077 ; number of data to transfer register
DMA1_C0PARH =0x5078 ; peripheral address high register
DMA1_C0PARL =0x5079 ; peripheral address low register
DMA1_C0M0ARH =0x0507B ; memory 0 address high register
DMA1_C0M0ARL =0x507C; memory 0 address low register
DMA1_C1CR= 0x507F ; channel 1 configuration register
DMA1_C1SPR =0x5080 ; channel 1 status & priority register
DMA1_C1NDTR =0x5081 ; number of data to transfer register
DMA1_C1PARH =0x5082 ; peripheral address high register
DMA1_C1PARL =0x5083 ; peripheral address low register
DMA1_C1M0ARH =0x5085 ; memory 0 address high register
DMA1_C1M0ARL =0x5086 ; memory 0 address low register
DMA1_C2CR =0x5089 ; channel 2 configuration register
DMA1_C2SPR =0x508A ; channel 2 status & priority register
DMA1_C2NDTR = 0x508B ; number of data to transfer register
DMA1_C2PARH =0x508C ; peripheral address high register
DMA1_C2PARL =0x508D ; peripheral address low register
DMA1_C2M0ARH =0x508F; memory 0 address high register
DMA1_C2M0ARL =0x5090 ; memory 0 address low register
DMA1_C3CR =0x5093 ; channel 3 configuration register0x00
DMA1_C3SPR =0x5094 ; channel 3 status & priority register0x00
DMA1_C3NDTR =0x5095 ; number of data to transfer register
DMA1_C3PARH_C3M1ARH = 0x5096 ; peripheral address high 
DMA1_C3PARL_C3M1ARL = 0x5097 ; peripharal address low 
DMA1_C3M1ARH = 0X5098 ;memory 1 address high 
DMA1_C3M0CAR = 0X5998 ; channel 3 memory 0 extended address register
DMA1_C3M0ARH = 0x5999 ; memory 0 address high register
DMA1_C3M0ARL = 0x599A ; memory 0 address low register

; SYSCONFIG registers 
SYSCFG_RMPCR3 = 0x599D ; remapping register 3 
SYSCFG_RMPCR1 = 0x599E ; remapping register 1 
SYSCFG_RMPCR2 = 0x599F ; remapping register 2 

; external Interrupt control
EXTI_CR1  = (0x50A0)
EXTI_CR2  = (0x50A1)
EXTI_CR2  = (0x50A2)
EXTI_SR1 = 0X50A3 
EXTI_SR2 = 0X50A4 

; wait for event registers 
WFE_CR1 = 0X50A6 
WFE_CR2 = 0X50A7 
WFE_CR3 = 0X50A8 
WFE_CR4 = 0X50A9 

; ITC-EXTI registers 
EXTI_CR4 = 0x50AA 
EXTI_CONF2 = 0x50AB 

; Reset control and Status
RST_CR =  0X50B0 
RST_SR = (0x50B1)

;power status and control registers 
PWR_CSR1 = 0X50B2 
PWR_CSR2 = 0X50B3 

; Clock Registers
 CLK_CKDIVR = (0x50C0)
 CLK_CRTCR = 0X50C1 
 CLK_ICKR =(0x50C2)
 CLK_PCKENR1 = (0x50C3)
 CLK_PCKENR2 = (0x50C4)
 CLK_CCOR = (0x50C5)
 CLK_ECKCR =(0x50C6)
 CLK_SCSR = 0X50C7 
 CLK_SWR = 0X50C8
 CLK_SWCR =(0x50C9)
 CLK_CSSR = (0x50CA)
 CLK_CBEEPR =(0x50CB)
 CLK_HSICALR = 0X50CC 
 CLK_HSITRIMR = (0x50CD)
 CLK_HSIUNLCKR = (0x50CE)
 CLK_REGCSR = 0X50CF 
 CLK_PCKENR3 = 0X50D0 

; Peripherals clock gating
; CLK_PCKENR1 
 CLK_PCKENR1_DAC = (7)
 CLK_PCKENR1_BEEP = (6)
 CLK_PCKENR1_USART1 = (5)
 CLK_PCKENR1_SPI1 = (4)
 CLK_PCKENR1_I2C1 = (3)
 CLK_PCKENR1_TIM4 = (2)
 CLK_PCKENR1_TIM3 = (1)
 CLK_PCKENR1_TIM2 = (0)

; CLK_PCKENR2
 CLK_PCKENR2_ROM = (7)
 CLK_PCKENR2_COMP = (5)
 CLK_PCKENR2_DMA1 = (4)
 CLK_PCKENR2_LCD = (3)
 CLK_PCKENR2_RTC = (2) 
 CLK_PCKENR2_TIM1 = (1)
 CLK_PCKENR2_ADC1 = (0) 

; CLK_PCKENR3 
 CLK_PCKENR3_CSS_LSE = (5)
 CLK_PCKENR3_USART3 = (4)
 CLK_PCKENR3_USART2 = (3)
 CLK_PCKENR3_SPI2 = (2)
 CLK_PCKENR3_TIM5 = (1)
 CLK_PCKENR3_AES = (0)  


; window watchdog timer 
 WWDG_CR = (0x50D3)
 WWDG_WR = (0x50D4)

; independant watchdog 
IWDG_KR =(0x50E0)
IWDG_PR =(0x50E1)
IWDG_RLR =(0x50E2)

; BEEP registers 
BEEP_CSR1 = 0X50F0 
BEEP_SCR2 = 0X50F3

; RTC registers 0x5140 - 0x5190 

; SPI registers 0x5200 - 0x5207 
 SPI_CR1  = (0x5200)
 SPI_CR2  = (0x5201)
 SPI_ICR  = (0x5202)
 SPI_SR  = (0x5203)
 SPI_DR  = (0x5204)
 SPI_CRCPR = (0x5205)
 SPI_RXCRCR = (0x5206)
 SPI_TXCRCR = (0x5207)

; I2C registers 0x5210 - 0x521E 
 I2C_CR1  = (0x5210)
 I2C_CR2  = (0x5211)
 I2C_FREQR  = (0x5212)
 I2C_OARL  = (0x5213)
 I2C_OARH  = (0x5214)
 I2C_OAR2 = (0X5215)
 I2C_DR  = (0x5216)
 I2C_SR1  = (0x5217)
 I2C_SR2  = (0x5218)
 I2C_SR3  = (0x5219)
 I2C_ITR  = (0x521A)
 I2C_CCRL  = (0x521B)
 I2C_CCRH  = (0x521C)
 I2C_TRISER  = (0x521D)
 I2C_PECR = (0x521E)

 I2C_STD = 0 
 I2C_FAST = 1 

 I2C_CR1_NOSTRETCH = (7)
 I2C_CR1_ENGC = (6)
 I2C_CR1_PE = (0)

 I2C_CR2_SWRST = (7)
 I2C_CR2_POS = (3)
 I2C_CR2_ACK = (2)
 I2C_CR2_STOP = (1)
 I2C_CR2_START = (0)

 I2C_OARL_ADD=(1)
 I2C_OARL_ADD0 = (0)

 I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
 I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))

 I2C_OARH_ADDMODE = (7)
 I2C_OARH_ADDCONF = (6)
 I2C_OARH_ADD9 = (2)
 I2C_OARH_ADD8 = (1)

 I2C_SR1_TXE = (7)
 I2C_SR1_RXNE = (6)
 I2C_SR1_STOPF = (4)
 I2C_SR1_ADD10 = (3)
 I2C_SR1_BTF = (2)
 I2C_SR1_ADDR = (1)
 I2C_SR1_SB = (0)

 I2C_SR2_WUFH = (5)
 I2C_SR2_OVR = (3)
 I2C_SR2_AF = (2)
 I2C_SR2_ARLO = (1)
 I2C_SR2_BERR = (0)

 I2C_SR3_DUALF = (7)
 I2C_SR3_GENCALL = (4)
 I2C_SR3_TRA = (2)
 I2C_SR3_BUSY = (1)
 I2C_SR3_MSL = (0)

 I2C_ITR_ITBUFEN = (2)
 I2C_ITR_ITEVTEN = (1)
 I2C_ITR_ITERREN = (0)

; Precalculated values, all in KHz
 I2C_CCRH_16MHZ_FAST_400 = 0x80
 I2C_CCRL_16MHZ_FAST_400 = 0x0D
;
; Fast I2C mode max rise time = 300ns
; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.

 I2C_TRISER_16MHZ_FAST_400 = 0x05

 I2C_CCRH_16MHZ_FAST_320 = 0xC0
 I2C_CCRL_16MHZ_FAST_320 = 0x02
 I2C_TRISER_16MHZ_FAST_320 = 0x05

 I2C_CCRH_16MHZ_FAST_200 = 0x80
 I2C_CCRL_16MHZ_FAST_200 = 0x1A
 I2C_TRISER_16MHZ_FAST_200 = 0x05

 I2C_CCRH_16MHZ_STD_100 = 0x00
 I2C_CCRL_16MHZ_STD_100 = 0x50
;
; Standard I2C mode max rise time = 1000ns
; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.

 I2C_TRISER_16MHZ_STD_100 = 0x11

 I2C_CCRH_16MHZ_STD_50 = 0x00
 I2C_CCRL_16MHZ_STD_50 = 0xA0
 I2C_TRISER_16MHZ_STD_50 = 0x11

 I2C_CCRH_16MHZ_STD_20 = 0x01
 I2C_CCRL_16MHZ_STD_20 = 0x90
 I2C_TRISER_16MHZ_STD_20 = 0x11;

 I2C_READ = 1
 I2C_WRITE = 0

;   USART1 constants and resgisters 0x5230 - 0x523A 
; baudrate constant for brr_value table access
B2400=0
B4800=1
B9600=2
B19200=3
B38400=4
B57600=5
B115200=6
B230400=7
B460800=8
B921600=9

; UART1
 UART1_SR    = (0x5230)
 UART1_DR    = (0x5231)
 UART1_BRR1  = (0x5232)
 UART1_BRR2  = (0x5233)
 UART1_CR1   = (0x5234)
 UART1_CR2   = (0x5235)
 UART1_CR3   = (0x5236)
 UART1_CR4   = (0x5237)
 UART1_CR5   = (0x5238)
 UART1_GTR   = (0x5239)
 UART1_PSCR  = (0x523A)

; USART Status Register bits
 UART1_SR_TXE = (7)
 UART1_SR_TC = (6)
 UART1_SR_RXNE = (5)
 UART1_SR_IDLE = (4)
 UART1_SR_OR = (3)
 UART1_SR_NF = (2)
 UART1_SR_FE = (1)
 UART1_SR_PE = (0)

; Uart Control Register bits
 UART1_CR1_R8 = (7)
 UART1_CR1_T8 = (6)
 UART1_CR1_USARTD = (5)
 UART1_CR1_M = (4)
 UART1_CR1_WAKE = (3)
 UART1_CR1_PCEN = (2)
 UART1_CR1_PS = (1)
 UART1_CR1_PIEN = (0)

 UART1_CR2_TIEN = (7)
 UART1_CR2_TCIEN = (6)
 UART1_CR2_RIEN = (5)
 UART1_CR2_ILIEN = (4)
 UART1_CR2_TEN = (3)
 UART1_CR2_REN = (2)
 UART1_CR2_RWU = (1)
 UART1_CR2_SBK = (0)

 UART1_CR3_LINEN = (6)
 UART1_CR3_STOP1 = (5)
 UART1_CR3_STOP0 = (4)
 UART1_CR3_CLKEN = (3)
 UART1_CR3_CPOL = (2)
 UART1_CR3_CPHA = (1)
 UART1_CR3_LBCL = (0)

 UART1_CR4_LBDIEN = (6)
 UART1_CR4_LBDL = (5)
 UART1_CR4_LBDF = (4)
 UART1_CR4_ADD3 = (3)
 UART1_CR4_ADD2 = (2)
 UART1_CR4_ADD1 = (1)
 UART1_CR4_ADD0 = (0)

;;;;;;;;;;
; TIMERS
;;;;;;;;;;

; Timer 2 - 16-bit timer 0x5250 - 0x5266
TIM2_CR1 = (0x5250)
TIM2_CR2 = (0X5251)
TIM2_SMCR = (0X5252)
TIM2_ETR = (0X5253)
TIM2_DER = (0X5254)
TIM2_IER = (0x5255)
TIM2_SR1 = (0x5256)
TIM2_SR2 = (0x5257)
TIM2_EGR = (0x5258)
TIM2_CCMR1 = (0x5259)
TIM2_CCMR2 = (0x525A)
TIM2_CCER1 = (0x525B)
TIM2_CNTRH = (0x525C)
TIM2_CNTRL = (0x525D)
TIM2_PSCR = (0x525E)
TIM2_ARRH = (0x525F)
TIM2_ARRL = (0x5260)
TIM2_CCR1H = (0x5261)
TIM2_CCR1L = (0x5262)
TIM2_CCR2H = (0x5263)
TIM2_CCR2L = (0x5264)
TIM2_BKR = (0x5265)
TIM2_OISR = (0x5266)

; TIM3 registers 0x5280 - 0x5296 
TIM3_CR1 = (0x5280)
TIM3_CR2 = (0X5281)
TIM3_SMCR = (0X5282)
TIM3_ETR = (0X5283)
TIM3_DER = (0X5284)
TIM3_IER = (0x5285)
TIM3_SR1 = (0x5286)
TIM3_SR2 = (0x5287)
TIM3_EGR = (0x5288)
TIM3_CCMR1 = (0x5289)
TIM3_CCMR2 = (0x528A)
TIM3_CCER1 = (0x528B)
TIM3_CNTRH = (0x528C)
TIM3_CNTRL = (0x528D)
TIM3_PSCR = (0x528E)
TIM3_ARRH = (0x528F)
TIM3_ARRL = (0x5290)
TIM3_CCR1H = (0x5291)
TIM3_CCR1L = (0x5292)
TIM3_CCR2H = (0x5293)
TIM3_CCR2L = (0x5294)
TIM3_BKR = (0x5295)
TIM3_OISR = (0x5296)

; TIM2 and TIM3 registers bits fields 
; Timer Control 1 
 TIM_CR1_ARPE = (7)
 TIM_CR1_CMS = (5) ; field 6:5
 TIM_CR1_DIR = (4)
 TIM_CR1_OPM = (3)
 TIM_CR1_URS = (2)
 TIM_CR1_UDIS = (1)
 TIM_CR1_CEN = (0)

 TIM_CR2_MMS = (4) ; field 6:4

; Timer Slave Mode Control bits
 TIM_SMCR_MSM = (7)
 TIM_SMCR_TS = (4) ; filed 6:4
 TIM_SMCR_SMS = (0) ; filed 2:0

; Timer External Trigger Enable bits
 TIM_ETR_ETP = (7)
 TIM_ETR_ECE = (6)
 TIM_ETR_ETPS = (4) ; field 5:4
 TIM_ETR_ETF = (0) ; field 3:0

; Timer Interrupt Enable bits
 TIM_IER_BIE = (7)
 TIM_IER_TIE = (6)
 TIM_IER_CC2IE = (2)
 TIM_IER_CC1IE = (1)
 TIM_IER_UIE = (0)

; Timer Status Register 1 bits
 TIM_SR1_BIF = (7)
 TIM_SR1_TIF = (6)
 TIM_SR1_CC2IF = (2)
 TIM_SR1_CC1IF = (1)
 TIM_SR1_UIF = (0)

; Timer status register 2 bits 
 TIM_SR2_CC2OF = (2)
 TIM_SR2_CC1OF = (1)

; Timer Event Generation Register bits
 TIM_EGR_BG = (7)
 TIM_EGR_TG = (6)
 TIM_EGR_CC2G = (2)
 TIM_EGR_CC1G = (1)
 TIM_EGR_UG = (0)

; Capture/Compare Mode Register 1 - channel configured in output
 TIM_CCMR1_OC1M = (4) ; field 6:4
 TIM_CCMR1_OC1PE = (3)
 TIM_CCMR1_OC1FE = (2)
 TIM_CCMR1_CC1S = (0) ; field 1:0

; Capture/Compare Mode Register 1 - channel configured in input
 TIM_CCMR1_IC1F = (4) ; field 7:4
 TIM_CCMR1_IC1PSC = (2) ; field 3:2
 TIM_CCMR1_CC1S = (0) ; field 1:0

; Capture/Compare Mode Register 2 - channel configured in output
 TIM_CCMR2_OC2M = (4) ; field 6:4
 TIM_CCMR2_OC2PE = (3)
 TIM_CCMR2_OC2FE = (2)
 TIM_CCMR2_CC2S0 = (0) ; field 1:0

; Capture/Compare Mode Register 2 - channel configured in input
 TIM_CCMR2_IC2F = (4) ; field 7:4 
 TIM_CCMR2_IC2PSC = (2) ; field 3:2 
 TIM_CCMR2_CC2S = (0) ; field 1:0

; Capture/compare enable register 1 (TIM_CCER1)
TIM_CCER1_CC2P = (5)
TIM_CCER1_CC2E = (4)
TIM_CCER1_CC1P = (1)
TIM_CCER1_CC1E = (0)

; Prescaler register (TIM_PSCR)
TIM_PSCR = (0) ; field 2:0

; Break register (TIM_BKR)
TIM_BKR_MOE = (7)
TIM_BKR_AOE = (6)
TIM_BKR_BKP = (5)
TIM_BKR_BKE = (4)
TIM_BKR_OSSI = (2)
TIM_BKR_LOCK = (0) ; field 1:0 

; Output idle state register (TIM_OISR) 
TIM_OISR_OIS2 = (2)
TIM_OISR_OIS1 = (0)


; Timer 4 registers 0x52E0 - 0X52E9 
TIM4_CR1 = (0x52E0)
TIM4_CR2 = (0X52E1)
TIM2_SMCR = (0X52E2)
TIM2_DER = (0X52E3)
TIM4_IER = (0x52E4)
TIM4_SR = (0x52E5)
TIM4_EGR = (0x52E6)
TIM4_CNTR = (0x52E7)
TIM4_PSCR = (0x52E8)
TIM4_ARR = (0x52E9)

; Timer 4 bitmasks

 TIM4_CR1_ARPE = (7)
 TIM4_CR1_OPM = (3)
 TIM4_CR1_URS = (2)
 TIM4_CR1_UDIS = (1)
 TIM4_CR1_CEN = (0)

 TIM4_IER_UIE = (0)

 TIM4_SR_UIF = (0)

 TIM4_EGR_UG = (0)

 TIM4_PSCR_PSC2 = (2)
 TIM4_PSCR_PSC1 = (1)
 TIM4_PSCR_PSC0 = (0)

 TIM4_PSCR_1 = 0
 TIM4_PSCR_2 = 1
 TIM4_PSCR_4 = 2
 TIM4_PSCR_8 = 3
 TIM4_PSCR_16 = 4
 TIM4_PSCR_32 = 5
 TIM4_PSCR_64 = 6
 TIM4_PSCR_128 = 7

; infrared register
IR_CR = 0X52FF ; control register 

; ADC1 registers 0x5340 - 0x5351 
 ADC_CR1 = (0X5340)
 ADC_CR2 = (0X5341)
 ADC_CR3 = (0X5342)
 ADC_SR = (0X5343) 
 ADC_DRH  = (0x5344)
 ADC_DRL  = (0x5345)
 ADC_HTRH  = (0x5346)
 ADC_HTRL  = (0x5347)
 ADC_LTRH  = (0x5348)
 ADC_LTRL  = (0x5349)
 ADC_SQR1 = (0X534A)
 ADC_SQR2 = (0X534B)
 ADC_SQR3 = (0X534C)
 ADC_SQR4 = (0X534D)
 ADC_TRIGR1 = (0X534E)
 ADC_TRIGR2 = (0X534F)
 ADC_TRIGR3 = (0X5350)
 ADC_TRIGR4 = (0X5351)

; ADC1 bitmasks
 ADC_CR1_OVERIE = (7)
 ADC_CR1_RES = (5) ; 6:5 bits field 
 ADC_CR1_AWDIE = (4)
 ADC_CR1_EOCIE = (3)
 ADC_CR1_CONT = (2)
 ADC_CR1_START = (1)
 ADC_CR1_ADON = (0)

 ADC_CR2_PRESC = (7)
 ADC_CR2_TRIG_EDGE1 = (6)
 ADC_CR2_TRIG_EDG2 = (5)
 ADC_CR2_EXTSEL1 = (4)
 ADC_CR2_EXTSEL0 = (3)
 ADC_CR2_SMTP1 = (0) ; 2:0 bits field 

 ADC_CR3_SMTP2 = (7) ; 7:5 bits field 
 ADC_CR3_CHSEL= (0) ; 4:0 bits field 

 ADC_SR_OVER = (2)
 ADC_SR_AWD = (1)
 ADC_SR_EOC = (0)


; Routing Interface registers  0x5431 - 0x543F
 RI_ICR1 = 0X5431
 RI_ICR2 = 0X5432
 RI_IOIR1 = 0X5433
 RI_IOIR2 = 0X5434
 RI_IOIR3 = 0X5435
 RI_IOCMR1 = 0X5436 
 RI_IOCMR2 = 0X5437 
 RI_IOCMR3 = 0X5438 
 RI_IOSR1 = 0X5439
 RI_IOSR2 = 0X543A
 RI_IOSR3 = 0X543B 
 RI_IOGCR = 0X543C
 RI_ASCR1 = 0X543D
 RI_ASCR2 = 0X543E
 RI_RCR = 0X543F

; comparators registers 0x5440 - 0x5444
 COMP_CSR1 = 0X5440
 COMP_CSR2 = 0X5441
 COMP_CSR3 = 0X5442
 COMP_CSR4 = 0X5443
 COMP_CSR5 = 0X5444

; RI registers group 2  0x5450 - 0x5457
 RI_CR = 0X5450 
 RI_MASKR1 = 0X5451
 RI_MASKR2 = 0X5452
 RI_MASKR3 = 0X5453
 RI_MASKR4 = 0X5454
 RI_IOIR4 = 0X5455 
 RI_IOCMR4 = 0X5456 
 RI_IOSR4 = 0X5457 

; CPU
 CPU_A  = (0x7F00)
 CPU_PCE  = (0x7F01)
 CPU_PCH  = (0x7F02)
 CPU_PCL  = (0x7F03)
 CPU_XH  = (0x7F04)
 CPU_XL  = (0x7F05)
 CPU_YH  = (0x7F06)
 CPU_YL  = (0x7F07)
 CPU_SPH  = (0x7F08)
 CPU_SPL   = (0x7F09)
 CPU_CCR   = (0x7F0A)

; global configuration register
 CFG_GCR   = (0x7F60)
 CFG_GCR_SWD = (0)
 CFG_GCR_HALT = (1)	

; interrupt control registers
 ITC_SPR1   = (0x7F70)
 ITC_SPR2   = (0x7F71)
 ITC_SPR3   = (0x7F72)
 ITC_SPR4   = (0x7F73)
 ITC_SPR5   = (0x7F74)
 ITC_SPR6   = (0x7F75)
 ITC_SPR7   = (0x7F76)
 ITC_SPR8   = (0x7F77)

ITC_SPR_LEVEL1=1 
ITC_SPR_LEVEL2=0
ITC_SPR_LEVEL3=3 


; SWIM, control and status register
 SWIM_CSR   = (0x7F80)
; debug registers
 DM_BK1RE   = (0x7F90)
 DM_BK1RH   = (0x7F91)
 DM_BK1RL   = (0x7F92)
 DM_BK2RE   = (0x7F93)
 DM_BK2RH   = (0x7F94)
 DM_BK2RL   = (0x7F95)
 DM_CR1   = (0x7F96)
 DM_CR2   = (0x7F97)
 DM_CSR1   = (0x7F98)
 DM_CSR2   = (0x7F99)
 DM_ENFCTR   = (0x7F9A)

; vector 0 is reset 
; vector 1 is TRAP 
; Interrupt Numbers begin at vector 3
INT_TLI = 0 
INT_AWU = 1
INT_CLK = 2 
INT_EXTI0 = 3
INT_EXTI1 = 4
INT_EXTI2 = 5
INT_EXTI3 = 6
INT_EXTI4 = 7
INT_SPI  = 10
INT_TIM1_OVF = 11
INT_TIM1_CC = 12
INT_TIM2_OVF = 13
INT_TIM2_CC = 14
INT_UART1_TX = 17 
INT_UART1_RX = 18 
INT_I2C = 19
INT_ADC1 = 22 
INT_TIM4_OVF = 23
INT_FLASH = 24

; Interrupt Vectors
INT_VECTOR_RESET = 0x8000
INT_VECTOR_TRAP = 0x8004
INT_VECTOR_TLI = 0x8008 
INT_VECTOR_AWU = 0x800C
INT_VECTOR_CLK = 0x8010
INT_VECTOR_EXTI0 = 0x8014
INT_VECTOR_EXTI1 = 0x8018
INT_VECTOR_EXTI2 = 0x801C
INT_VECTOR_EXTI3 = 0x8020
INT_VECTOR_EXTI4 = 0x8024
INT_VECTOR_SPI  = 0x8030
INT_VECTOR_TIM1_OVF = 0x8034
INT_VECTOR_TIM1_CCM = 0x8038
INT_VECTOR_TIM2_OVF = 0x803C
INT_VECTOR_TIM2_CCM = 0x8040
INT_VECTOR_UART1_TX_COMPLETE = 0x804C
INT_VECTOR_UART1_RX_FULL = 0x8050
INT_VECTOR_I2C = 0x8054
INT_VECTOR_ADC1 = 0x8060
INT_VECTOR_TIM4_OVF = 0x8064
INT_VECTOR_FLASH = 0x8068
