// время с контроллера
fbRTC(EN := TRUE, CDT => sTime, Q => bRTC_Ready);

// парс
fbParseTime(
    sTime := sTime,
    Year => nYear,
    Month => nMonth,
    Day => nDay,
    Hour => nHour,
    Minute => nMinute,
    Second => nSecond,
    Millisecond => nMS,
    Valid => bTimeValid
);



// количество дней от 1970
nDays := 0;

FOR i := 1970 TO nYear - 1 DO
    IF ((i MOD 4 = 0) AND (i MOD 100 <> 0)) OR (i MOD 400 = 0) THEN
        nDays := nDays + 366;
    ELSE
        nDays := nDays + 365;
    END_IF;
END_FOR;



// добавляем дни за полные месяцы
IF nMonth > 1 THEN nDays := nDays + 31; END_IF;
IF nMonth > 2 THEN 
    IF ((nYear MOD 4 = 0) AND (nYear MOD 100 <> 0)) OR (nYear MOD 400 = 0) THEN
        nDays := nDays + 29;
    ELSE
        nDays := nDays + 28;
    END_IF;
END_IF;
IF nMonth > 3 THEN nDays := nDays + 31; END_IF;
IF nMonth > 4 THEN nDays := nDays + 30; END_IF;
IF nMonth > 5 THEN nDays := nDays + 31; END_IF;
IF nMonth > 6 THEN nDays := nDays + 30; END_IF;
IF nMonth > 7 THEN nDays := nDays + 31; END_IF;
IF nMonth > 8 THEN nDays := nDays + 31; END_IF;
IF nMonth > 9 THEN nDays := nDays + 30; END_IF;
IF nMonth > 10 THEN nDays := nDays + 31; END_IF;
IF nMonth > 11 THEN nDays := nDays + 30; END_IF;



// добавим дни текущего месяца
nDays := nDays + (nDay - 1);

// перевод всё в мс
TimestampMs := 
    DINT_TO_ULINT(nDays) * 86400000 +
    INT_TO_ULINT(nHour) * 3600000 +
    INT_TO_ULINT(nMinute) * 60000 +
    INT_TO_ULINT(nSecond) * 1000 +
    INT_TO_ULINT(nMS);


// сброс
IF BlinkReset THEN
    bIsBlinking := FALSE;
    visual_counter := 0;  
    tap_counter := 0;     
    LED := FALSE;
    nLastBlink := 0;
    bWaitForRelease := FALSE;
    BlinkReset := FALSE;
END_IF