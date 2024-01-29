-- 9. Determine the calendar date of the next occurrence of Wednesday, based on today’s date.
SELECT
    SYSDATE AS CurrentDate,
    NEXT_DAY(SYSDATE, 'WEDNESDAY') AS NextWednesday
FROM
    dual;
