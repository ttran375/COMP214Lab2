-- 5. Display the current day of the week, hour, minutes, and seconds of the current date setting on the computer you’re using.
SELECT
    TO_CHAR(SYSDATE, 'Day') AS DayOfWeek,
    TO_CHAR(SYSDATE, 'HH24') AS Hour,
    TO_CHAR(SYSDATE, 'MI') AS Minutes,
    TO_CHAR(SYSDATE, 'SS') AS Seconds
FROM
    dual;
