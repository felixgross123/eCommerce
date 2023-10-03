(* file handling *)

val OBJECT_TYPES = ["customer", "order", "item", "package"];
val EVENT_TYPES = ["register", "login", "logout", "create order", "add item", "select shipping", "place order", "pay", "confirm payment", "cancel order", "prepare delivery", "give to carrier", "carrier confirms", "delivery", "delivered"];
val SEP = ";";

fun list2string([]) = ""|
list2string(x::l) = x ^ (if l=[] then "" else SEP) ^ list2string(l);

(* attributes *)
fun event_attrs(et) =
    if      et = "select shipping"  then ["option"]
    else if et = "pay"              then ["method"]
    else if et = "prepare delivery" then ["option"]
    else if et = "give to carrier"  then ["option"]
    else if et = "carrier confirms" then ["option"]
    else if et = "delivery"         then ["option"]
    else [];

fun object_attrs(ot) =
    if      ot = "customer" then ["gender", "year of birth", "country"]
    else if ot = "item"     then ["type", "price"]
    else [];

(* table management *)
fun event_map_type(et) = 
    if      et = "register"         then "register"
    else if et = "login"            then "login"
    else if et = "logout"           then "logout"
    else if et = "create order"     then "createOrder"
    else if et = "add item"         then "addItem"
    else if et = "select shipping"  then "selectShipping"
    else if et = "place order"      then "placeOrder"
    else if et = "pay"              then "pay"
    else if et = "confirm payment"  then "confirmPayment"
    else if et = "cancel order"     then "cancelOrder"
    else if et = "prepare delivery" then "prepareDelivery"
    else if et = "give to carrier"  then "giveToCarrier"
    else if et = "carrier confirms" then "carrierConfirms"
    else if et = "delivery"         then "delivery"
    else if et = "delivered"        then "delivered"
    else "";


fun object_map_type(ot) =
    if      ot = "customer" then "customer"
    else if ot = "order"    then "order"
    else if ot = "item"     then "item"
    else if ot = "package"  then "package"
    else "";

(* table inits *)
fun create_event_table() = 
let
   val file_id = TextIO.openOut("./output/event.csv")
   val _ = TextIO.output(file_id, list2string(["ocel_id", "ocel_type"])) 
   val _ = TextIO.output(file_id, "\n")
in
   TextIO.closeOut(file_id)
end;

fun create_object_table() = 
let
   val file_id = TextIO.openOut("./output/object.csv")
   val _ = TextIO.output(file_id, list2string(["ocel_id", "ocel_type"])) 
   val _ = TextIO.output(file_id, "\n")
in
   TextIO.closeOut(file_id)
end;

fun create_event_object_table() = 
let
   val file_id = TextIO.openOut("./output/event_object.csv")
   val _ = TextIO.output(file_id, list2string(["ocel_event_id", "ocel_object_id", "ocel_qualifier"])) 
   val _ = TextIO.output(file_id, "\n")
in
   TextIO.closeOut(file_id)
end;

fun create_object_object_table() = 
let
   val file_id = TextIO.openOut("./output/object_object.csv")
   val _ = TextIO.output(file_id, list2string(["ocel_source_id", "ocel_target_id", "ocel_qualifier"])) 
   val _ = TextIO.output(file_id, "\n")
in
   TextIO.closeOut(file_id)
end;

fun create_event_map_type_table_helper(file_id, []) = () | 
    create_event_map_type_table_helper(file_id, et::ets) = 
        (
            TextIO.output(file_id, list2string([et, event_map_type(et)])); 
            TextIO.output(file_id, "\n"); 
            create_event_map_type_table_helper(file_id, ets)
        );

fun create_object_map_type_table_helper(file_id, []) = () | 
    create_object_map_type_table_helper(file_id, ot::ots) = 
        (
            TextIO.output(file_id, list2string([ot, object_map_type(ot)])); 
            TextIO.output(file_id, "\n"); 
            create_object_map_type_table_helper(file_id, ots)
        );

fun create_event_map_type_table() = 
let
   val file_id = TextIO.openOut("./output/event_map_type.csv")
   val _ = TextIO.output(file_id, list2string(["ocel_type", "ocel_type_map"])) 
   val _ = TextIO.output(file_id, "\n")
   val _ = create_event_map_type_table_helper(file_id, EVENT_TYPES)
in
   TextIO.closeOut(file_id)
end;

fun create_object_map_type_table() = 
let
   val file_id = TextIO.openOut("./output/object_map_type.csv")
   val _ = TextIO.output(file_id, list2string(["ocel_type", "ocel_type_map"])) 
   val _ = TextIO.output(file_id, "\n")
   val _ = create_object_map_type_table_helper(file_id, OBJECT_TYPES)
in
   TextIO.closeOut(file_id)
end;

fun create_event_type_tables_helper(et) = 
let
   val emt = event_map_type(et)
   val eAttrs = event_attrs(et)
   val file_id = TextIO.openOut("./output/event_" ^ emt ^ ".csv")
   val _ = TextIO.output(file_id, list2string(["ocel_id", "ocel_time"]^^eAttrs)) 
   val _ = TextIO.output(file_id, "\n")
in
   TextIO.closeOut(file_id)
end;

fun create_object_type_tables_helper(ot) = 
let
   val omt = object_map_type(ot)
   val oAttrs = object_attrs(ot)
   val file_id = TextIO.openOut("./output/object_" ^ omt ^ ".csv")
   val _ = TextIO.output(file_id, list2string(["ocel_id", "ocel_time", "ocel_changed_field"]^^oAttrs))
   val _ = TextIO.output(file_id, "\n")
in
   TextIO.closeOut(file_id)
end;

fun create_event_type_tables([]) = () | 
    create_event_type_tables(et::ets) = 
    (
        create_event_type_tables_helper(et); 
        create_event_type_tables(ets)
    );

fun create_object_type_tables([]) = () | 
    create_object_type_tables(ot::ots) = 
    (
        create_object_type_tables_helper(ot); 
        create_object_type_tables(ots)
    );

(* create log *)

fun create_log() = 
(
    create_event_table();
    create_object_table();
    create_event_object_table();
    create_object_object_table();
    create_event_map_type_table();
    create_object_map_type_table();
    create_event_type_tables(EVENT_TYPES);
    create_object_type_tables(OBJECT_TYPES)
);