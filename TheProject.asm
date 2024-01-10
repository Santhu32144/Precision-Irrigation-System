
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TheProject.c,30 :: 		void interrupt() {
;TheProject.c,33 :: 		if(INTCON.b0 ==1)
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt0
;TheProject.c,35 :: 		turnON=1;
	MOVLW      1
	MOVWF      _turnON+0
	MOVLW      0
	MOVWF      _turnON+1
;TheProject.c,36 :: 		if(portb.b7==1)
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt1
;TheProject.c,38 :: 		if(SetMoist==99)
	MOVLW      0
	XORWF      _SetMoist+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt49
	MOVLW      99
	XORWF      _SetMoist+0, 0
L__interrupt49:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;TheProject.c,39 :: 		{}
	GOTO       L_interrupt3
L_interrupt2:
;TheProject.c,42 :: 		SetMoist++;
	INCF       _SetMoist+0, 1
	BTFSC      STATUS+0, 2
	INCF       _SetMoist+1, 1
;TheProject.c,43 :: 		cset=0;
	CLRF       _cset+0
	CLRF       _cset+1
;TheProject.c,44 :: 		}
L_interrupt3:
;TheProject.c,45 :: 		}
L_interrupt1:
;TheProject.c,47 :: 		if(portb.b6==1)
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt4
;TheProject.c,49 :: 		turnON=1;
	MOVLW      1
	MOVWF      _turnON+0
	MOVLW      0
	MOVWF      _turnON+1
;TheProject.c,50 :: 		if(SetMoist==5)
	MOVLW      0
	XORWF      _SetMoist+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt50
	MOVLW      5
	XORWF      _SetMoist+0, 0
L__interrupt50:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;TheProject.c,51 :: 		{}
	GOTO       L_interrupt6
L_interrupt5:
;TheProject.c,54 :: 		SetMoist--;
	MOVLW      1
	SUBWF      _SetMoist+0, 1
	BTFSS      STATUS+0, 0
	DECF       _SetMoist+1, 1
;TheProject.c,55 :: 		cset=0;
	CLRF       _cset+0
	CLRF       _cset+1
;TheProject.c,56 :: 		}
L_interrupt6:
;TheProject.c,57 :: 		}
L_interrupt4:
;TheProject.c,59 :: 		if(portb.b5==1)
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt7
;TheProject.c,61 :: 		turnON=1;
	MOVLW      1
	MOVWF      _turnON+0
	MOVLW      0
	MOVWF      _turnON+1
;TheProject.c,62 :: 		portc.b0 =!portc.b0;
	MOVLW      1
	XORWF      PORTC+0, 1
;TheProject.c,63 :: 		}
L_interrupt7:
;TheProject.c,64 :: 		intcon.b0=0;
	BCF        INTCON+0, 0
;TheProject.c,65 :: 		}
L_interrupt0:
;TheProject.c,67 :: 		if(portb.b4==1)
	BTFSS      PORTB+0, 4
	GOTO       L_interrupt8
;TheProject.c,69 :: 		turnON=1;
	MOVLW      1
	MOVWF      _turnON+0
	MOVLW      0
	MOVWF      _turnON+1
;TheProject.c,70 :: 		}
L_interrupt8:
;TheProject.c,73 :: 		if(INTCON.b2 ==1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt9
;TheProject.c,75 :: 		sensingCounter++;
	INCF       _sensingCounter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sensingCounter+1, 1
;TheProject.c,76 :: 		screenCounter++;
	INCF       _screenCounter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _screenCounter+1, 1
;TheProject.c,79 :: 		if(sensingCounter==50)
	MOVLW      0
	XORWF      _sensingCounter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt51
	MOVLW      50
	XORWF      _sensingCounter+0, 0
L__interrupt51:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt10
;TheProject.c,81 :: 		sensingCounter=0;
	CLRF       _sensingCounter+0
	CLRF       _sensingCounter+1
;TheProject.c,82 :: 		getMoist=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _getMoist+0
	MOVF       R0+1, 0
	MOVWF      _getMoist+1
;TheProject.c,83 :: 		getMoist=(getMoist/1024.0)*100.0;
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _getMoist+0
	MOVF       R0+1, 0
	MOVWF      _getMoist+1
;TheProject.c,84 :: 		if(getMoist<setMoist)
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      _SetMoist+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt52
	MOVF       _SetMoist+0, 0
	SUBWF      R0+0, 0
L__interrupt52:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt11
;TheProject.c,86 :: 		portc.b0=0b1;
	BSF        PORTC+0, 0
;TheProject.c,87 :: 		}
	GOTO       L_interrupt12
L_interrupt11:
;TheProject.c,88 :: 		else if(getMoist>setMoist)
	MOVLW      128
	XORWF      _SetMoist+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _getMoist+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt53
	MOVF       _getMoist+0, 0
	SUBWF      _SetMoist+0, 0
L__interrupt53:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt13
;TheProject.c,90 :: 		portc.b0=0b0;
	BCF        PORTC+0, 0
;TheProject.c,91 :: 		}
L_interrupt13:
L_interrupt12:
;TheProject.c,92 :: 		} //end moisture
L_interrupt10:
;TheProject.c,94 :: 		if(screenCounter==500)
	MOVF       _screenCounter+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt54
	MOVLW      244
	XORWF      _screenCounter+0, 0
L__interrupt54:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt14
;TheProject.c,96 :: 		screenCounter=0;
	CLRF       _screenCounter+0
	CLRF       _screenCounter+1
;TheProject.c,97 :: 		turnON=0;
	CLRF       _turnON+0
	CLRF       _turnON+1
;TheProject.c,98 :: 		}
L_interrupt14:
;TheProject.c,100 :: 		intcon.b2=0;
	BCF        INTCON+0, 2
;TheProject.c,101 :: 		}
L_interrupt9:
;TheProject.c,104 :: 		}
L_end_interrupt:
L__interrupt48:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TheProject.c,106 :: 		void main() {
;TheProject.c,107 :: 		INTCON = 0b10101000;
	MOVLW      168
	MOVWF      INTCON+0
;TheProject.c,109 :: 		option_reg= 0b10000111;
	MOVLW      135
	MOVWF      OPTION_REG+0
;TheProject.c,112 :: 		trisb= 0b11111111;
	MOVLW      255
	MOVWF      TRISB+0
;TheProject.c,113 :: 		trisd = 0b00000000;
	CLRF       TRISD+0
;TheProject.c,114 :: 		trisc.b7 =0;
	BCF        TRISC+0, 7
;TheProject.c,115 :: 		trisc.b0=0;
	BCF        TRISC+0, 0
;TheProject.c,116 :: 		portc.b0=0;
	BCF        PORTC+0, 0
;TheProject.c,117 :: 		portd.b7=1;
	BSF        PORTD+0, 7
;TheProject.c,118 :: 		portc.b7= 1;
	BSF        PORTC+0, 7
;TheProject.c,119 :: 		trisa.b0=1;
	BSF        TRISA+0, 0
;TheProject.c,120 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;TheProject.c,122 :: 		lcd_out(1,1,"Calculating");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_TheProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TheProject.c,123 :: 		lcd_out(2,1,"Moisture...");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_TheProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TheProject.c,124 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
	NOP
;TheProject.c,125 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TheProject.c,126 :: 		lcd_out(1,5,"Moisture:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_TheProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TheProject.c,128 :: 		while(1)
L_main16:
;TheProject.c,130 :: 		if(cset==0)
	MOVLW      0
	XORWF      _cset+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      0
	XORWF      _cset+0, 0
L__main56:
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;TheProject.c,132 :: 		cset=1;
	MOVLW      1
	MOVWF      _cset+0
	MOVLW      0
	MOVWF      _cset+1
;TheProject.c,134 :: 		SetMoistR= SetMoist % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _SetMoist+0, 0
	MOVWF      R0+0
	MOVF       _SetMoist+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _SetMoistR+0
	MOVF       R0+1, 0
	MOVWF      _SetMoistR+1
;TheProject.c,135 :: 		switch (SetMoistR) {
	GOTO       L_main19
;TheProject.c,136 :: 		case 0: SetMoistR=0x3F; break;
L_main21:
	MOVLW      63
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,137 :: 		case 1: SetMoistR=0x06; break;
L_main22:
	MOVLW      6
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,138 :: 		case 2: SetMoistR=0x5B; break;
L_main23:
	MOVLW      91
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,139 :: 		case 3: SetmoistR=0x4F; break;
L_main24:
	MOVLW      79
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,140 :: 		case 4: SetmoistR=0x66; break;
L_main25:
	MOVLW      102
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,141 :: 		case 5: SetmoistR=0x6D; break;
L_main26:
	MOVLW      109
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,142 :: 		case 6: SetmoistR=0x7D; break;
L_main27:
	MOVLW      125
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,143 :: 		case 7: SetmoistR=0x07; break;
L_main28:
	MOVLW      7
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,144 :: 		case 8: SetmoistR=0x7F; break;
L_main29:
	MOVLW      127
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,145 :: 		case 9: SetmoistR=0x6F; break;
L_main30:
	MOVLW      111
	MOVWF      _SetMoistR+0
	MOVLW      0
	MOVWF      _SetMoistR+1
	GOTO       L_main20
;TheProject.c,146 :: 		}
L_main19:
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      0
	XORWF      _SetMoistR+0, 0
L__main57:
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVLW      1
	XORWF      _SetMoistR+0, 0
L__main58:
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      2
	XORWF      _SetMoistR+0, 0
L__main59:
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      3
	XORWF      _SetMoistR+0, 0
L__main60:
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      4
	XORWF      _SetMoistR+0, 0
L__main61:
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      5
	XORWF      _SetMoistR+0, 0
L__main62:
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      6
	XORWF      _SetMoistR+0, 0
L__main63:
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      7
	XORWF      _SetMoistR+0, 0
L__main64:
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVLW      8
	XORWF      _SetMoistR+0, 0
L__main65:
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVLW      0
	XORWF      _SetMoistR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      9
	XORWF      _SetMoistR+0, 0
L__main66:
	BTFSC      STATUS+0, 2
	GOTO       L_main30
L_main20:
;TheProject.c,150 :: 		SetMoistL= (SetMoist/10) % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _SetMoist+0, 0
	MOVWF      R0+0
	MOVF       _SetMoist+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _SetMoistL+0
	MOVF       R0+1, 0
	MOVWF      _SetMoistL+1
;TheProject.c,151 :: 		switch (SetMoistL) {
	GOTO       L_main31
;TheProject.c,152 :: 		case 0: SetMoistL=0x3F; break;
L_main33:
	MOVLW      63
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,153 :: 		case 1: SetMoistL=0x06; break;
L_main34:
	MOVLW      6
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,154 :: 		case 2: SetMoistL=0x5B; break;
L_main35:
	MOVLW      91
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,155 :: 		case 3: SetmoistL=0x4F; break;
L_main36:
	MOVLW      79
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,156 :: 		case 4: SetmoistL=0x66; break;
L_main37:
	MOVLW      102
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,157 :: 		case 5: SetmoistL=0x6D; break;
L_main38:
	MOVLW      109
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,158 :: 		case 6: SetmoistL=0x7D; break;
L_main39:
	MOVLW      125
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,159 :: 		case 7: SetmoistL=0x07; break;
L_main40:
	MOVLW      7
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,160 :: 		case 8: SetmoistL=0x7F; break;
L_main41:
	MOVLW      127
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,161 :: 		case 9: SetmoistL=0x6F; break;
L_main42:
	MOVLW      111
	MOVWF      _SetMoistL+0
	MOVLW      0
	MOVWF      _SetMoistL+1
	GOTO       L_main32
;TheProject.c,162 :: 		}
L_main31:
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main67
	MOVLW      0
	XORWF      _SetMoistL+0, 0
L__main67:
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVLW      1
	XORWF      _SetMoistL+0, 0
L__main68:
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVLW      2
	XORWF      _SetMoistL+0, 0
L__main69:
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVLW      3
	XORWF      _SetMoistL+0, 0
L__main70:
	BTFSC      STATUS+0, 2
	GOTO       L_main36
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVLW      4
	XORWF      _SetMoistL+0, 0
L__main71:
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVLW      5
	XORWF      _SetMoistL+0, 0
L__main72:
	BTFSC      STATUS+0, 2
	GOTO       L_main38
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      6
	XORWF      _SetMoistL+0, 0
L__main73:
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVLW      7
	XORWF      _SetMoistL+0, 0
L__main74:
	BTFSC      STATUS+0, 2
	GOTO       L_main40
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVLW      8
	XORWF      _SetMoistL+0, 0
L__main75:
	BTFSC      STATUS+0, 2
	GOTO       L_main41
	MOVLW      0
	XORWF      _SetMoistL+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVLW      9
	XORWF      _SetMoistL+0, 0
L__main76:
	BTFSC      STATUS+0, 2
	GOTO       L_main42
L_main32:
;TheProject.c,164 :: 		}
L_main18:
;TheProject.c,166 :: 		portd=SetmoistR;
	MOVF       _SetMoistR+0, 0
	MOVWF      PORTD+0
;TheProject.c,167 :: 		portc.b7=0;
	BCF        PORTC+0, 7
;TheProject.c,168 :: 		portd.b7=1;
	BSF        PORTD+0, 7
;TheProject.c,169 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
;TheProject.c,170 :: 		portd=SetmoistL;
	MOVF       _SetMoistL+0, 0
	MOVWF      PORTD+0
;TheProject.c,171 :: 		portd.b7=0;
	BCF        PORTD+0, 7
;TheProject.c,172 :: 		portc.b7=1;
	BSF        PORTC+0, 7
;TheProject.c,173 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	NOP
	NOP
;TheProject.c,177 :: 		buffer[0] = (getMoist/10)%10 +48;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _getMoist+0, 0
	MOVWF      R0+0
	MOVF       _getMoist+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       _buffer+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;TheProject.c,178 :: 		buffer[1] = (getMoist)%10+48;
	INCF       _buffer+0, 0
	MOVWF      FLOC__main+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _getMoist+0, 0
	MOVWF      R0+0
	MOVF       _getMoist+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;TheProject.c,179 :: 		lcd_chr(2,8,buffer[0]);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;TheProject.c,180 :: 		lcd_chr(2,9,buffer[1]);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	INCF       _buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;TheProject.c,181 :: 		lcd_chr(2,11,'%');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      37
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;TheProject.c,183 :: 		if(turnON==1)
	MOVLW      0
	XORWF      _turnON+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main77
	MOVLW      1
	XORWF      _turnON+0, 0
L__main77:
	BTFSS      STATUS+0, 2
	GOTO       L_main45
;TheProject.c,185 :: 		LCD_ON;
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TheProject.c,186 :: 		}
	GOTO       L_main46
L_main45:
;TheProject.c,189 :: 		LCD_OFF;
	MOVLW      8
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TheProject.c,190 :: 		}
L_main46:
;TheProject.c,192 :: 		} //while
	GOTO       L_main16
;TheProject.c,195 :: 		}       //main
L_end_main:
	GOTO       $+0
; end of _main
