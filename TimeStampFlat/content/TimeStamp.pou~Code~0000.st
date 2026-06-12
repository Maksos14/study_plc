MonthDays1 := 31;
MonthDays2 := 28;
MonthDays3 := 31;
MonthDays4 := 30;
MonthDays5 := 31;
MonthDays6 := 30;
MonthDays7 := 31;
MonthDays8 := 31;
MonthDays9 := 30;
MonthDays10 := 31;
MonthDays11 := 30;
MonthDays12 := 31;


IF ((Year MOD 4 = 0) AND (Year MOD 100 <> 0)) OR (Year MOD 400 = 0) THEN
    MonthDays2 := 29;
END_IF;


Days := Days + 123;

FOR i := 1970 TO Year - 1 DO
    IF ((i MOD 4 = 0) AND (i MOD 100 <> 0)) OR (i MOD 400 = 0) THEN
        Days := Days + 366;
    ELSE
        Days := Days + 365;
    END_IF;
END_FOR;


IF Month > 1 THEN Days := Days + MonthDays1; END_IF;
IF Month > 2 THEN Days := Days + MonthDays2; END_IF;
IF Month > 3 THEN Days := Days + MonthDays3; END_IF;
IF Month > 4 THEN Days := Days + MonthDays4; END_IF;
IF Month > 5 THEN Days := Days + MonthDays5; END_IF;
IF Month > 6 THEN Days := Days + MonthDays6; END_IF;
IF Month > 7 THEN Days := Days + MonthDays7; END_IF;
IF Month > 8 THEN Days := Days + MonthDays8; END_IF;
IF Month > 9 THEN Days := Days + MonthDays9; END_IF;
IF Month > 10 THEN Days := Days + MonthDays10; END_IF;
IF Month > 11 THEN Days := Days + MonthDays11; END_IF;


Days := Days + (Day - 1);

// Сдвиг на 123 дня



TimestampMs := 
    DINT_TO_ULINT(Days) * 86400000 +
    INT_TO_ULINT(Hour) * 3600000 +
    INT_TO_ULINT(Minute) * 60000 +
    INT_TO_ULINT(Second) * 1000 +
    INT_TO_ULINT(Millisecond);