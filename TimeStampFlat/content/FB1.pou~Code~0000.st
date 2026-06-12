BUTTON_VIRTUAL := BUTTON_VIRTUAL AND NOT bLastButtonState;

// регает нажатие
IF (BUTTON_01 OR BUTTON_VIRTUAL) AND NOT bLastButtonState AND TIMER >= 300 AND TIMER <= 5000 THEN
    bIsBlinking := NOT bIsBlinking;
    visual_counter := visual_counter + 1;
END_IF;


IF TIMER < 300 THEN
    MESSAGE := FALSE;
ELSE
    MESSAGE := TRUE;
END_IF;


bLastButtonState := BUTTON_01 OR BUTTON_VIRTUAL;


// мигание
IF bIsBlinking THEN

    counter := counter + 1;

    IF counter >= (TIMER / 10) THEN
        LED := NOT LED;

        IF LED THEN
            tap_counter := tap_counter + 1;
        END_IF;

        counter := 0;
    END_IF;

ELSE
    LED := FALSE;
    counter := 0;
END_IF;


BUTTON_VIRTUAL := FALSE;