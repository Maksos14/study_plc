TON_Button(IN := BUTTON_01 OR BUTTON_VIRTUAL, PT := T#5S);

IF (BUTTON_01 OR BUTTON_VIRTUAL) AND NOT bLastButtonState AND TIMER >= 300 THEN
    bIsBlinking := NOT bIsBlinking;
    visual_counter := visual_counter + 1;
END_IF

MESSAGE := (TIMER >= 300);

bLastButtonState := BUTTON_01 OR BUTTON_VIRTUAL;


// моргание 
IF bIsBlinking THEN
    TON_Blink(IN := TRUE, PT := T#1000MS);
    IF TON_Blink.Q THEN
        LED := NOT LED;
        IF LED THEN
            tap_counter := tap_counter + 1;
        END_IF
        TON_Blink(IN := FALSE); // сброс таймера
    END_IF
ELSE
    LED := FALSE;
    TON_Blink(IN := FALSE);
END_IF




/*
FB22(
    BUTTON_01 := BUTTON_01,
    
    BUTTON_VIRTUAL := BUTTON_VIRTUAL,
    LED => LED,
    MESSAGE => MESSAGE,
    visual_counter => visual_counter,
    blinkPeriod => HMI_blinkPeriod,
    tap_counter => tap_counter
    );
*/