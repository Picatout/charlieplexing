;---------------------------------------
;  STM8L001J3  vectors table 
;---------------------------------------

;;--------------------------------------
;; interrupt vector table at 0x8000
;;--------------------------------------
    .area HOME 

	int cold_start	        ; reset
	int NonHandledInterrupt	; trap
	int 0               	; irq0 not used 
	int NonHandledInterrupt	; irq1 FLASH  
	int 0               	; irq2 DMA1 0/1
	int 0               	; irq3 DMA1 2/3
	int NonHandledInterrupt	; irq4 AWU 
	int 0               	; irq5 PVD  
	int NonHandledInterrupt	; irq6 EXTIB
	int NonHandledInterrupt	; irq7 EXTID 
	int NonHandledInterrupt	; irq8 EXTI0  
	int NonHandledInterrupt	; irq9 EXTI1 
	int NonHandledInterrupt	; irq10 EXTI2  
	int NonHandledInterrupt	; irq11 EXTI3  
	int NonHandledInterrupt	; irq12 EXTI4  
	int NonHandledInterrupt	; irq13 EXTI5 
	int NonHandledInterrupt	; irq14 EXTI6  
	int NonHandledInterrupt	; irq15 EXTI7  
	int 0               	; irq16 reserved 
	int 0               	; irq17 reserved 
	int NonHandledInterrupt	; irq18 COMP   
	int NonHandledInterrupt	; irq19 TIM2 OVF  
	int NonHandledInterrupt	; irq20 TIM2 CAP/COMP 
    int NonHandledInterrupt	; irq21 TIM3 OVF 
	int NonHandledInterrupt	; irq22 TIM3 CAP/COMP
	int 0                   ; irq23 reserved 
	int 0               	; irq24 reserved  
	int Timer4UpdateHandler	; irq25 TIM4 OVF 
	int NonHandledInterrupt	; irq26 SPI1 
	int NonHandledInterrupt	; irq27 USART TX 
	int NonHandledInterrupt	; irq28 USART1 RX 
	int NonHandledInterrupt	; irq29 I2C1 
 
