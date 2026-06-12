BUTTON_VIRTUAL := BUTTON_VIRTUAL AND NOT bLastButtonState;

IF (BUTTON_01 OR BUTTON_VIRTUAL) AND NOT bLastButtonState AND TIMER >= 300 AND TIMER <= 5000 THEN
    bIsBlinking := NOT bIsBlinking;
    visual_counter := visual_counter + 1;  
END_IF


IF TIMER < 300 THEN    //сообщ с ошибкой
    MESSAGE := FALSE;
ELSE 
    MESSAGE := TRUE;
END_IF

bLastButtonState := BUTTON_01 OR BUTTON_VIRTUAL;

IF bIsBlinking THEN
    counter := counter + 1;
    TIMER := TIMER / 10;
    IF counter >= TIMER THEN
        LED := NOT LED;
        IF LED = TRUE THEN
            tap_counter := tap_counter + 1;
         END_IF
        counter := 0;
    END_IF
        TIMER := TIMER * 10;
ELSE
    LED := FALSE;
    counter := 0;
END_IF


BUTTON_VIRTUAL := FALSE;

