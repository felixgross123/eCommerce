use "ocel_logging_init.sml";
(* ----- TIME ----- *)
(* Start of time: Monday, 03.01.2022, End of time: <= 31.12.2022*)
val daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

val startYear = 2022;
val startMonth = 1;
val startDay = 3;
val startHour = 0;
val startMinute = 0;

fun addDays(month, day, days) =
    let
        val daysInCurrentMonth = List.nth (daysInMonth, month - 1)
        val remainingDays = daysInCurrentMonth - day
    in
        if days <= remainingDays then
            (month, day + days)
        else
            addDays(
                month + 1,
                0,
                days - remainingDays
            )
    end;

fun addMinutes(hour, min, mins) =
    let
        val totalMinutes = hour * 60 + min + mins
        val newHour = totalMinutes div 60
        val newMinute = totalMinutes mod 60
    in
        (newHour, newMinute)
    end;

fun calculateDate(minutes) =
    let
        val daysToAdd = minutes div (60 * 24)
        val remainingMinutes = minutes mod (60 * 24)

        val (finalHour, finalMinute) = addMinutes(startHour, startMinute, remainingMinutes)
        val (finalMonth, finalDay) = addDays(startMonth, startDay, daysToAdd)

        fun formatNumber n =
            if n < 10 then "0" ^ Int.toString n
            else Int.toString n

        val formattedDate =
            "2022" ^ "-" ^
            formatNumber finalMonth ^ "-" ^
            formatNumber finalDay ^ " " ^
            formatNumber finalHour ^ ":" ^
            formatNumber finalMinute ^ ":00"
    in 
        formattedDate
    end;

(* ----- LOGGING ----- *)
val event_table_path = "./output/event.csv";
val object_table_path = "./output/object.csv";
val event_object_table_path = "./output/event_object.csv";

fun log_register(eventID, customerID, gender, yob, country) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_register_table = TextIO.openAppend("./output/event_register.csv")

        val object_table = TextIO.openAppend(object_table_path)
        val object_customer_table = TextIO.openAppend("./output/object_customer.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "register"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_register_table, list2string([eventID, date]));
            TextIO.output(event_register_table, "\n");
            TextIO.closeOut(event_register_table);

            (* object *)
            TextIO.output(object_table, list2string([customerID, "customer"]));
            TextIO.output(object_table, "\n");
            TextIO.closeOut(object_table);

            TextIO.output(object_customer_table, list2string([customerID, date, "", gender, Int.toString yob, country]));
            TextIO.output(object_customer_table, "\n");
            TextIO.closeOut(object_customer_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_login(eventID, customerID) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_login_table = TextIO.openAppend("./output/event_login.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "login"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_login_table, list2string([eventID, date]));
            TextIO.output(event_login_table, "\n");
            TextIO.closeOut(event_login_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_logout(eventID, customerID) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_logout_table = TextIO.openAppend("./output/event_logout.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "logout"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_logout_table, list2string([eventID, date]));
            TextIO.output(event_logout_table, "\n");
            TextIO.closeOut(event_logout_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_createOrder(eventID, customerID, orderID) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_createOrder_table = TextIO.openAppend("./output/event_createOrder.csv")

        val object_table = TextIO.openAppend(object_table_path)
        val object_order_table = TextIO.openAppend("./output/object_order.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "create order"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_createOrder_table, list2string([eventID, date]));
            TextIO.output(event_createOrder_table, "\n");
            TextIO.closeOut(event_createOrder_table);

            (* object *)
            TextIO.output(object_table, list2string([orderID, "order"]));
            TextIO.output(object_table, "\n");
            TextIO.closeOut(object_table);

            TextIO.output(object_order_table, list2string([orderID, date, ""]));
            TextIO.output(object_order_table, "\n");
            TextIO.closeOut(object_order_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_addItem(eventID, customerID, orderID, itemID, itemType, price) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_addItem_table = TextIO.openAppend("./output/event_addItem.csv")

        val object_table = TextIO.openAppend(object_table_path)
        val object_item_table = TextIO.openAppend("./output/object_item.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "add item"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_addItem_table, list2string([eventID, date]));
            TextIO.output(event_addItem_table, "\n");
            TextIO.closeOut(event_addItem_table);

            (* object *)
            TextIO.output(object_table, list2string([itemID, "item"]));
            TextIO.output(object_table, "\n");
            TextIO.closeOut(object_table);

            TextIO.output(object_item_table, list2string([itemID, date, "", itemType, Int.toString price]));
            TextIO.output(object_item_table, "\n");
            TextIO.closeOut(object_item_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, itemID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_selectShipping(eventID, customerID, orderID, option) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_selectShipping_table = TextIO.openAppend("./output/event_selectShipping.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "select shipping"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_selectShipping_table, list2string([eventID, date, option]));
            TextIO.output(event_selectShipping_table, "\n");
            TextIO.closeOut(event_selectShipping_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_pay(eventID, customerID, orderID, method) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_pay_table = TextIO.openAppend("./output/event_pay.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "pay"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_pay_table, list2string([eventID, date, method]));
            TextIO.output(event_pay_table, "\n");
            TextIO.closeOut(event_pay_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_sendInvoice(eventID, customerID, orderID) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_sendInvoice_table = TextIO.openAppend("./output/event_sendInvoice.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "send invoice"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_sendInvoice_table, list2string([eventID, date]));
            TextIO.output(event_sendInvoice_table, "\n");
            TextIO.closeOut(event_sendInvoice_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_confirmPayment(eventID, customerID, orderID, method) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_confirmPayment_table = TextIO.openAppend("./output/event_confirmPayment.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "confirm payment"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_confirmPayment_table, list2string([eventID, date, method]));
            TextIO.output(event_confirmPayment_table, "\n");
            TextIO.closeOut(event_confirmPayment_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_cancelOrder(eventID, customerID, orderID) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_cancelOrder_table = TextIO.openAppend("./output/event_cancelOrder.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "cancel order"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_cancelOrder_table, list2string([eventID, date]));
            TextIO.output(event_cancelOrder_table, "\n");
            TextIO.closeOut(event_cancelOrder_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_sendInvoice(eventID, customerID, orderID) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_sendInvoice_table = TextIO.openAppend("./output/event_sendInvoice.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "send invoice"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_sendInvoice_table, list2string([eventID, date]));
            TextIO.output(event_sendInvoice_table, "\n");
            TextIO.closeOut(event_sendInvoice_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_placeOrder(eventID, customerID, orderID) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_placeOrder_table = TextIO.openAppend("./output/event_placeOrder.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "place order"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_placeOrder_table, list2string([eventID, date]));
            TextIO.output(event_placeOrder_table, "\n");
            TextIO.closeOut(event_placeOrder_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.closeOut(event_object_table)
        )
    end;


fun log_packages_event_object_table_helper(event_object_table, eventID, []) = () |
    log_packages_event_object_table_helper(event_object_table, eventID, itemID::itemIDs) =
        (
            TextIO.output(event_object_table, list2string([eventID, itemID, ""]));
            TextIO.output(event_object_table, "\n");
            log_packages_event_object_table_helper(event_object_table, eventID, itemIDs)
        );

fun log_prepareDelivery(eventID, packageID, orderID, itemIDs, option) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_prepareDelivery_table = TextIO.openAppend("./output/event_prepareDelivery.csv")

        val object_table = TextIO.openAppend(object_table_path)
        val object_package_table = TextIO.openAppend("./output/object_package.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "prepare delivery"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_prepareDelivery_table, list2string([eventID, date, option]));
            TextIO.output(event_prepareDelivery_table, "\n");
            TextIO.closeOut(event_prepareDelivery_table);

            (* object *)
            TextIO.output(object_table, list2string([packageID, "package"]));
            TextIO.output(object_table, "\n");
            TextIO.closeOut(object_table);

            TextIO.output(object_package_table, list2string([packageID, date, ""]));
            TextIO.output(object_package_table, "\n");
            TextIO.closeOut(object_package_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, packageID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            log_packages_event_object_table_helper(event_object_table, eventID, itemIDs);
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_giveToCarrier(eventID, packageID, orderID, itemIDs, option) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_giveToCarrier_table = TextIO.openAppend("./output/event_giveToCarrier.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "give to carrier"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_giveToCarrier_table, list2string([eventID, date, option]));
            TextIO.output(event_giveToCarrier_table, "\n");
            TextIO.closeOut(event_giveToCarrier_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, packageID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            log_packages_event_object_table_helper(event_object_table, eventID, itemIDs);
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_carrierConfirms(eventID, packageID, orderID, itemIDs, option) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_carrierConfirms_table = TextIO.openAppend("./output/event_carrierConfirms.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "carrier confirms"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_carrierConfirms_table, list2string([eventID, date, option]));
            TextIO.output(event_carrierConfirms_table, "\n");
            TextIO.closeOut(event_carrierConfirms_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, packageID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            log_packages_event_object_table_helper(event_object_table, eventID, itemIDs);
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_delivery(eventID, packageID, orderID, itemIDs, option) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_delivery_table = TextIO.openAppend("./output/event_delivery.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "delivery"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_delivery_table, list2string([eventID, date, option]));
            TextIO.output(event_delivery_table, "\n");
            TextIO.closeOut(event_delivery_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, packageID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            log_packages_event_object_table_helper(event_object_table, eventID, itemIDs);
            TextIO.closeOut(event_object_table)
        )
    end;

fun log_delivered(eventID, customerID, packageID, orderID, itemIDs) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val event_table = TextIO.openAppend(event_table_path)
        val event_delivered_table = TextIO.openAppend("./output/event_delivered.csv")

        val event_object_table = TextIO.openAppend(event_object_table_path)
        
    in
        (
            (* event *)
            TextIO.output(event_table, list2string([eventID, "delivered"]));
            TextIO.output(event_table, "\n");
            TextIO.closeOut(event_table);

            TextIO.output(event_delivered_table, list2string([eventID, date]));
            TextIO.output(event_delivered_table, "\n");
            TextIO.closeOut(event_delivered_table);

            (* event-object *)
            TextIO.output(event_object_table, list2string([eventID, customerID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, packageID, ""]));
            TextIO.output(event_object_table, "\n");
            TextIO.output(event_object_table, list2string([eventID, orderID, ""]));
            TextIO.output(event_object_table, "\n");
            log_packages_event_object_table_helper(event_object_table, eventID, itemIDs);
            TextIO.closeOut(event_object_table)
        )
    end;

    (* edge case - log additional item object for package deviation *)
    fun log_additionalItem(itemID, itemType, price) =
    let 
        val date = calculateDate(IntInf.toInt(time()))

        val object_table = TextIO.openAppend(object_table_path)
        val object_item_table = TextIO.openAppend("./output/object_item.csv")

    in
        (
            (* object *)
            TextIO.output(object_table, list2string([itemID, "item"]));
            TextIO.output(object_table, "\n");
            TextIO.closeOut(object_table);

            TextIO.output(object_item_table, list2string([itemID, date, "", itemType, Int.toString price]));
            TextIO.output(object_item_table, "\n");
            TextIO.closeOut(object_item_table)
        )
    end;

