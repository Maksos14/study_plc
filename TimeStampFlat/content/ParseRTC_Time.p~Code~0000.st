Valid := TRUE;

// чек минимальной длины
IF LEN(sTime) < 22 THEN
    Valid := FALSE;
    RETURN;
END_IF;

// префикс дт# должен быть
IF LEFT(sTime, 3) <> 'DT#' THEN
    Valid := FALSE;
    RETURN;
END_IF;


sYear   := MID(sTime, 4, 4);
sMonth  := MID(sTime, 2, 9);
sDay    := MID(sTime, 2, 12);
sHour   := MID(sTime, 2, 15);
sMinute := MID(sTime, 2, 18);
sSecond := MID(sTime, 2, 21);


// милисекнуды
nDotPos := FIND(sTime, '.');

IF nDotPos > 0 THEN
    sMS := RIGHT(sTime, LEN(sTime) - nDotPos);
ELSE
    sMS := '0';
END_IF;


// преобразование
Year        := STRING_TO_INT(sYear);
Month       := STRING_TO_INT(sMonth);
Day         := STRING_TO_INT(sDay);
Hour        := STRING_TO_INT(sHour);
Minute      := STRING_TO_INT(sMinute);
Second      := STRING_TO_INT(sSecond);
Millisecond := STRING_TO_INT(sMS);


IF LEN(sMS) = 1 THEN
    Millisecond := Millisecond * 100;
ELSIF LEN(sMS) = 2 THEN
    Millisecond := Millisecond * 10;
END_IF;


// тесты
IF Year < 2000 OR Year > 2100 THEN
    Valid := FALSE;
END_IF;

IF Month < 1 OR Month > 12 THEN
    Valid := FALSE;
END_IF;

IF Day < 1 OR Day > 31 THEN
    Valid := FALSE;
END_IF;

IF Hour > 23 THEN
    Valid := FALSE;
END_IF;

IF Minute > 59 THEN
    Valid := FALSE;
END_IF;

IF Second > 59 THEN
    Valid := FALSE;
END_IF;