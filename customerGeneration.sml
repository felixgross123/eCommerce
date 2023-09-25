(* ----- CONFIGURATION -----*)
(* REGISTRATION *)
val GLOBAL_REGISTRATION_DELAY_LOWER_DAYS = 1; (*lower limit on how long to wait until a new customer registers*)
val GLOBAL_REGISTRATION_DELAY_UPPER_DAYS = 1; (*upper limit on how long to wait until a new customer registers*)

val GROWTH_COEFF = 30; (*chance of which a newly registered customer will "recruit" a second one*)

(* LOGIN *)
val LOCAL_LOGIN_DELAY_LOWER_DAYS = 7; (*lower limit on how long to wait until the same customer logs in again*)
val LOCAL_LOGIN_DELAY_UPPER_DAYS = 30; (*upper limit on how long to wait until the same customer logs in again*)

(* ORDER *)
val CHANCE_OF_ORDER = 60

fun drawGender() = if discrete(0,1) = 0 then "Male" else "Female";

fun drawYoB() = 
    let 
        val rand = Real.floor(normal(30.0, 10.0))
    in
        if rand < 18 then drawYoB()
        else if rand > 100 then drawYoB()
        else 2021 - rand
    end;

fun drawCountry() =
    let 
        val rand = discrete(0,10000)
    in
        if rand <= 1881 then "Germany"
        else if rand <= 3399 then "France"
        else if rand <= 4711 then "Italy"
        else if rand <= 5783 then "Spain"
        else if rand <= 6603 then "Poland"
        else if rand <= 7028 then "Romania"
        else if rand <= 7425 then "Netherlands"
        else if rand <= 7687 then "Belgium"
        else if rand <= 7928 then "Czech Republic"
        else if rand <= 8163 then "Sweden"
        else if rand <= 8396 then "Portugal"
        else if rand <= 8628 then "Greece"
        else if rand <= 8842 then "Hungary"
        else if rand <= 9045 then "Austria"
        else if rand <= 9189 then "Bulgaria"
        else if rand <= 9321 then "Denmark"
        else if rand <= 9445 then "Finland"
        else if rand <= 9566 then "Slovakia"
        else if rand <= 9682 then "Ireland"
        else if rand <= 9768 then "Croatia"
        else if rand <= 9832 then "Lithuania"
        else if rand <= 9879 then "Slovenia"
        else if rand <= 9921 then "Lativa"
        else if rand <= 9951 then "Estonia"
        else if rand <= 9972 then "Cyprus"
        else if rand <= 9987 then "Luxembourg"
        else "Malta"
    end;

fun drawCustomerAttr() = (drawGender(), drawYoB(), drawCountry());

fun drawIDLEDelay() = discrete(0,10);