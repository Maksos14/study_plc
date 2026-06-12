// ---------------------------------------------------------------------
// Тело функционального блока
// ---------------------------------------------------------------------

// 1. Получение времени

IF UseManualRTC THEN
    sTime := ManualRTC;
    bRTC_Ready := TRUE;
ELSE
    fbRTC(EN := TRUE, CDT => sTime, Q => bRTC_Ready);
END_IF;

// 2. Парсинг строки времени

bTimeValid := TRUE;

IF LEN(sTime) < 22 THEN
    bTimeValid := FALSE;
ELSE
    IF LEFT(sTime, 3) <> 'DT#' THEN
        bTimeValid := FALSE;
    ELSE
        sYear   := MID(sTime, 4, 4);
        sMonth  := MID(sTime, 2, 9);
        sDay    := MID(sTime, 2, 12);
        sHour   := MID(sTime, 2, 15);
        sMinute := MID(sTime, 2, 18);
        sSecond := MID(sTime, 2, 21);

        nDotPos := FIND(sTime, '.');

        IF nDotPos > 0 THEN
            sMS := RIGHT(sTime, LEN(sTime) - nDotPos);
        ELSE
            sMS := '0';
        END_IF;

        nYear   := STRING_TO_INT(sYear);
        nMonth  := STRING_TO_INT(sMonth);
        nDay    := STRING_TO_INT(sDay);
        nHour   := STRING_TO_INT(sHour);
        nMinute := STRING_TO_INT(sMinute);
        nSecond := STRING_TO_INT(sSecond);
        nMS     := STRING_TO_INT(sMS);

        IF LEN(sMS) = 1 THEN
            nMS := nMS * 100;
        ELSIF LEN(sMS) = 2 THEN
            nMS := nMS * 10;
        END_IF;

        IF nYear < 2000 OR nYear > 2100 THEN bTimeValid := FALSE; END_IF;
        IF nMonth < 1 OR nMonth > 12 THEN bTimeValid := FALSE; END_IF;
        IF nDay < 1 OR nDay > 31 THEN bTimeValid := FALSE; END_IF;
        IF nHour > 23 THEN bTimeValid := FALSE; END_IF;
        IF nMinute > 59 THEN bTimeValid := FALSE; END_IF;
        IF nSecond > 59 THEN bTimeValid := FALSE; END_IF;
    END_IF;
END_IF;

// 3. Расчет дней от 1970

nDays := 0;

FOR i := 1970 TO nYear - 1 DO
    IF ((i MOD 4 = 0) AND (i MOD 100 <> 0)) OR (i MOD 400 = 0) THEN
        nDays := nDays + 366;
    ELSE
        nDays := nDays + 365;
    END_IF;
END_FOR;

IF ((nYear MOD 4 = 0) AND (nYear MOD 100 <> 0)) OR (nYear MOD 400 = 0) THEN
    nMonthDays2 := 29;
ELSE
    nMonthDays2 := 28;
END_IF;

IF nMonth > 1 THEN nDays := nDays + nMonthDays1; END_IF;
IF nMonth > 2 THEN nDays := nDays + nMonthDays2; END_IF;
IF nMonth > 3 THEN nDays := nDays + nMonthDays3; END_IF;
IF nMonth > 4 THEN nDays := nDays + nMonthDays4; END_IF;
IF nMonth > 5 THEN nDays := nDays + nMonthDays5; END_IF;
IF nMonth > 6 THEN nDays := nDays + nMonthDays6; END_IF;
IF nMonth > 7 THEN nDays := nDays + nMonthDays7; END_IF;
IF nMonth > 8 THEN nDays := nDays + nMonthDays8; END_IF;
IF nMonth > 9 THEN nDays := nDays + nMonthDays9; END_IF;
IF nMonth > 10 THEN nDays := nDays + nMonthDays10; END_IF;
IF nMonth > 11 THEN nDays := nDays + nMonthDays11; END_IF;

nDays := nDays + (nDay - 1);

// 4. Перевод в миллисекунды

IF bTimeValid THEN

    TimestampMs :=
        DINT_TO_ULINT(nDays) * 86400000 +
        INT_TO_ULINT(nHour) * 3600000 +
        INT_TO_ULINT(nMinute) * 60000 +
        INT_TO_ULINT(nSecond) * 1000 +
        INT_TO_ULINT(nMS);

    // Часовой пояс (в часах)
IF TimezoneOffset > 0 THEN
    TimestampMs := TimestampMs + INT_TO_ULINT(TimezoneOffset) * 3600000;
ELSIF TimezoneOffset < 0 THEN
    TimestampMs := TimestampMs - INT_TO_ULINT(ABS(TimezoneOffset)) * 3600000;
END_IF;

    Valid := TRUE;

ELSE

    TimestampMs := 0;
    Valid := FALSE;

END_IF;

// 5. Обработка мигания

IF BlinkReset THEN
    bIsBlinking := FALSE;
    visual_counter := 0;
    tap_counter := 0;
    LED := FALSE;
    nLastBlink := 0;
    bWaitForRelease := FALSE;
END_IF;