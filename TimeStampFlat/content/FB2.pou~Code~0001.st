TON_Blink(IN := bIsBlinking, PT := T#500ms);

BUTTON_VIRTUAL := BUTTON_VIRTUAL AND NOT bLastButtonState;

IF (BUTTON_01 OR BUTTON_VIRTUAL) AND NOT bLastButtonState AND TIMER >= 300 AND TIMER <= 5000 THEN
    bIsBlinking := NOT bIsBlinking;
    visual_counter := visual_counter + 1;  
END_IF

IF TIMER < 300 THEN
    MESSAGE := FALSE;
ELSE 
    MESSAGE := TRUE;
END_IF

bLastButtonState := BUTTON_01 OR BUTTON_VIRTUAL;

IF bIsBlinking THEN
    IF TON_Blink.Q THEN
        LED := NOT LED;
        IF LED = TRUE THEN 
            tap_counter := tap_counter + 1;
        END_IF
        TON_Blink(IN := FALSE);
        TON_Blink(IN := TRUE);
    END_IF
ELSE
    LED := FALSE;
    TON_Blink(IN := FALSE);
END_IF

BUTTON_VIRTUAL := FALSE;