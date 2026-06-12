FUNCTI F_ButtonHandler : BOOL
VAR_INPUT
    BUTTON_01      : BOOL;
    BUTTON_VIRTUAL : BOOL;
    TIMER_IN       : INT;
END_VAR
VAR_OUTPUT
    bIsBlinking    : BOOL;
    LED            : BOOL;
    MESSAGE        : BOOL;
    visual_counter : INT;
    tap_counter    : INT;
    TIMER_OUT      : INT;
END_VAR
VAR
    bLastButtonState : BOOL;
    counter          : INT;
    btn_virt         : BOOL;
END_VAR

(* Тело функции *)
btn_virt := BUTTON_VIRTUAL;
btn_virt := btn_virt AND NOT bLastButtonState;

IF (BUTTON_01 OR btn_virt) AND NOT bLastButtonState AND TIMER_IN >= 300 AND TIMER_IN <= 5000 THEN
    bIsBlinking := NOT bIsBlinking;
    visual_counter := visual_counter + 1;
    F_ButtonHandler := TRUE;
ELSE
    F_ButtonHandler := FALSE;
END_IF

IF TIMER_IN < 300 THEN
    MESSAGE := FALSE;
ELSE 
    MESSAGE := TRUE;
END_IF

bLastButtonState := BUTTON_01 OR btn_virt;

IF bIsBlinking THEN
    counter := counter + 1;
    TIMER_OUT := TIMER_IN / 10;
    IF counter >= TIMER_OUT THEN
        LED := NOT LED;
        IF LED = TRUE THEN
            tap_counter := tap_counter + 1;
        END_IF
        counter := 0;
    END_IF
    TIMER_OUT := TIMER_OUT * 10;
ELSE
    LED := FALSE;
    counter := 0;
    TIMER_OUT := TIMER_IN;
END_IF

btn_virt := FALSE;