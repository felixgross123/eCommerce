(* ----- CONFIGURATION -----*)
val STARTOFWORK = 540;  (*9h*)
val ENDOFWORK = 1020;   (*17h*)

(* ----- EXEMPLARY FUNCTIONS -----*)

(* exemplary function that randomly draws time - currently normal distribution with one peak: mu = 20:15h, sigma = 2h *)
fun drawTimeWeekdayEx() = Real.floor(normal(1215.0, 120.0))

(* exemplary function that draws time - currently normal distribution with two peaks, equally weighted: mu_1 = 12h, sigma_1 = 3h / mu_2 = 18h, sigma_2 = 3h *)
fun drawTimeWeekendEx() = Real.floor(0.5 * normal(720.0, 180.0) + 0.5 * normal(1080.0, 120.0))

(* ----- FUNCTIONS -----*)

(* returns true, if it is Saturday or Sunday at time(), otherwise false *)
fun nowIsWeekday() = 
    let
        val minuteOfWeek = IntInf.toInt(time()) mod (1440*7)
    in 
        minuteOfWeek < (1440*5)
    end;

(* returns true, if it is Saturday of Sunday at time(), otherwise false *)
fun isWeekdayIn(m) = 
    let
        val minuteOfWeek = (IntInf.toInt(time()) + m) mod (1440*7)
    in 
        minuteOfWeek < (1440*5)
    end;

(* 
    gives back a delay of d days - time of day is sampled randomy according to the distribution drawTime 

    days (Integer)                      - number of days to delay by (must be >0)
    drawTimeWeekday (fun: . -> Int)     - distribution of time of weekday
    drawTimeWeekend (fun: . -> Int)     - distribution of time of on a day of the weekend
*)
fun delayByDays(days, drawTimeWeekday, drawTimeWeekend) = 
    let
        val minuteOfDay = IntInf.toInt(time()) mod 1440
        val untilMidnightOfDay = 1440 - minuteOfDay

        val delayUntilMidnightOfDay = days*1440 + untilMidnightOfDay
    in
        if isWeekdayIn(days*1440)
        then delayUntilMidnightOfDay + drawTimeWeekday()
        else delayUntilMidnightOfDay + drawTimeWeekend()
    end;

(* 
    gives back a delay of days weekdays - time of day is sampled randomy according to the distribution drawTime 

    days (Integer)              - number of days to delay by (must be >0)
    drawTime (fun: . -> Int)    - distribution of time of day
*)
fun delayByWeekdayHelper(daysToDelay, daysDelayed, drawTime) = 
    let
        val minuteOfDay = IntInf.toInt(time()) mod 1440
        val untilMidnightOfDay = 1440 - minuteOfDay
        val delayUntilMidnightOfDay = daysDelayed*1440 + untilMidnightOfDay 
    in
        if daysToDelay = 0
        then delayUntilMidnightOfDay + drawTime()
        else 
            if isWeekdayIn(daysDelayed * 1440 + 1440)
            then delayByWeekdayHelper(daysToDelay-1, daysDelayed+1, drawTime)
            else delayByWeekdayHelper(daysToDelay, daysDelayed+1, drawTime)
    end;

fun delayByWeekdays(days, drawTime) = delayByWeekdayHelper(days, 0, drawTime);

(* 
    gives back a delay of hours working hours (timespan defined by STARTOFWORK, ENDOFWORK)

    hours (Integer)              - number of working hours to delay by (must be >0)
*)  
fun delayByWorkingHourHelper(minutesToDelay, minutesDelayed) =
    let
        val currentDelayedMinuteOfDay = (IntInf.toInt(time()) + minutesDelayed) mod 1440
        val currentDelayedMinuteOfWeek = (IntInf.toInt(time()) + minutesDelayed) mod (1440*7)

        val timeUntilEndOfWeek = 1440*7 - currentDelayedMinuteOfWeek
        val timeUntilNextMondayMorning = timeUntilEndOfWeek +  STARTOFWORK

        val timeUntilTodayStartOfWork = STARTOFWORK - currentDelayedMinuteOfDay
        val timeUntilMidnight = 1440 - currentDelayedMinuteOfDay
        val timeUntilTomorrowStartOfWork = timeUntilMidnight + ENDOFWORK
    in 
        if minutesToDelay = 0 then minutesDelayed
        else 
            if not (isWeekdayIn(minutesDelayed))
            then delayByWorkingHourHelper(minutesToDelay, minutesDelayed + timeUntilNextMondayMorning)
            else
                if currentDelayedMinuteOfDay < STARTOFWORK
                    then delayByWorkingHourHelper(minutesToDelay, minutesDelayed + timeUntilTodayStartOfWork)
                else if currentDelayedMinuteOfDay > ENDOFWORK
                    then delayByWorkingHourHelper(minutesToDelay, minutesDelayed + timeUntilTomorrowStartOfWork)
                else delayByWorkingHourHelper(minutesToDelay-1, minutesDelayed+1)
    end;

fun delayByWorkingMinutes(min) = delayByWorkingHourHelper(min, 0)

