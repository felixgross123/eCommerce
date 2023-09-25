val LOGFILENAME = "ecommerce-log.csv";
val CSV_SEP = ";";
val LIST_SEP = ",";

fun create_event_table() = 
let
    val file_id = TextIO.openOut("./"^LOGFILENAME)
    val _ = TextIO.output(file_id, "time;activity;objects") 
    val _ = TextIO.output(file_id, "\n")
in
    TextIO.closeOut(file_id)
end;

fun enumerate_list_elements([], str) = str|
    enumerate_list_elements([x], str) = str^x|
    enumerate_list_elements(x::xs, str) = str^x^LIST_SEP^enumerate_list_elements(xs, str);

fun list_to_str(ls:STRINGS) = "["^enumerate_list_elements(ls,"")^"]";


fun log_event(ac:STRING, objs:STRINGS) =
let
    val file_id = TextIO.openAppend("./"^LOGFILENAME)
    val _ = TextIO.output(file_id, ""^ModelTime.toString(time())^CSV_SEP^ac^CSV_SEP^list_to_str(objs)) 
    val _ = TextIO.output(file_id, "\n")
in
    TextIO.closeOut(file_id)
end;