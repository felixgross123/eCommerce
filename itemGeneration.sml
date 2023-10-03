(* --- CONFIGURATION --- *)
val ASSOCIATION_STRENGTH = 90; (* Chance that, if chosen to buy a camera, the user also picks batteries *)
fun drawNoItems() = discrete(1,10) (* Range of number of items that are picked per order *)

(* DISTRIBUTIONS OF ITEMS *) 
(* there are different distributions based on whether the customer is old, young and comes from a sunny/rainy country *)
fun drawItemAttrYoung() = 
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,4)
        val rand3 = discrete(1,16)
    in
        if rand1 <= 0
        then 
            if rand2 <= 1 then ("Laptop", discrete(300,3000))
            else if rand2 <= 2 then ("Smartphone", discrete(200,1500))
            else if rand2 <= 3 then ("Headphones", discrete(20,300))
            else ("Printer", discrete(50,300))
        else
            if rand3 <= 1 then ("Sunscreen", discrete(2,10))
            else if rand3 <= 2 then ("Umbrella", discrete(5,40))
            else if rand3 <= 3 then ("TShirt", discrete(20,50))
            else if rand3 <= 4 then ("Swimwear", discrete(10,50))
            else if rand3 <= 5 then ("Jeans", discrete(30,80))
            else if rand3 <= 6 then ("Coffee maker", discrete(20,200))
            else if rand3 <= 7 then ("Sneakers", discrete(30,150))
            else if rand3 <= 8 then ("Camera", discrete(200,2000))
            else if rand3 <= 9 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 10 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 11 then ("Pet food", discrete(10,50))
            else if rand3 <= 12 then ("Jacket", discrete(70,300))
            else if rand3 <= 13 then ("Car battery", discrete(50, 150))
            else if rand3 <= 14 then ("Multivitamin", discrete(5,20))
            else if rand3 <= 15 then ("Necklace", discrete(20,100))
            else ("Tent", discrete(50,300))
    end;


fun drawItemAttrOld() =
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,3)
        val rand3 = discrete(1,17)
    in
        if rand1 <= 0
        then 
            if rand2 <= 1 then ("Multivitamin", discrete(5,20))
            else if rand2 <= 2 then ("Pet food", discrete(10,50))
            else ("Coffee maker", discrete(20,200))
        else
            if rand3 <= 1 then ("Sunscreen", discrete(2,10))
            else if rand3 <= 2 then ("Umbrella", discrete(5,40))
            else if rand3 <= 3 then ("Laptop", discrete(300,3000))
            else if rand3 <= 4 then ("Smartphone", discrete(200,1500))
            else if rand3 <= 5 then ("TShirt", discrete(20,50))
            else if rand3 <= 6 then ("Swimwear", discrete(10,50))
            else if rand3 <= 7 then ("Jeans", discrete(30,80))
            else if rand3 <= 8 then ("Headphones", discrete(20,300))
            else if rand3 <= 9 then ("Sneakers", discrete(30,150))
            else if rand3 <= 10 then ("Camera", discrete(200,2000))
            else if rand3 <= 11 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 12 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 13 then ("Jacket", discrete(70,300))
            else if rand3 <= 14 then ("Car battery", discrete(50, 150))
            else if rand3 <= 15 then ("Necklace", discrete(20,100))
            else if rand3 <= 16 then ("Printer", discrete(50,300))
            else ("Tent", discrete(50,300))
    end;

fun drawItemAttrSunny() =
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,2)
        val rand3 = discrete(1,18)
    in
        if rand1 <= 0
        then
            if rand2 <= 1 then ("Sunscreen", discrete(2,10))
            else ("Swimwear", discrete(10,50))
        else
            if rand3 <= 1 then ("Umbrella", discrete(5,40))
            else if rand3 <= 2 then ("Laptop", discrete(300,3000))
            else if rand3 <= 3 then ("Smartphone", discrete(200,1500))
            else if rand3 <= 4 then ("TShirt", discrete(20,50))
            else if rand3 <= 5 then ("Jeans", discrete(30,80))
            else if rand3 <= 6 then ("Coffee maker", discrete(20,200))
            else if rand3 <= 7 then ("Headphones", discrete(20,300))
            else if rand3 <= 8 then ("Sneakers", discrete(30,150))
            else if rand3 <= 9 then ("Camera", discrete(200,2000))
            else if rand3 <= 10 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 11 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 12 then ("Pet food", discrete(10,50))
            else if rand3 <= 13 then ("Jacket", discrete(70,300))
            else if rand3 <= 14 then ("Car battery", discrete(50, 150))
            else if rand3 <= 15 then ("Multivitamin", discrete(5,20))
            else if rand3 <= 16 then ("Necklace", discrete(20,100))
            else if rand3 <= 17 then ("Printer", discrete(50,300))
            else ("Tent", discrete(50,300))
    end;


fun drawItemAttrRainy() = 
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,2)
        val rand3 = discrete(1,18)
    in
        if rand1 <= 0
        then
            if rand2 <= 1 then ("Umbrella", discrete(5,40))
            else ("Jacket", discrete(70,300))
        else
            if rand3 <= 1 then ("Sunscreen", discrete(2,10))
            else if rand3 <= 2 then ("Laptop", discrete(300,3000))
            else if rand3 <= 3 then ("Smartphone", discrete(200,1500))
            else if rand3 <= 4 then ("TShirt", discrete(20,50))
            else if rand3 <= 5 then ("Swimwear", discrete(10,50))
            else if rand3 <= 6 then ("Jeans", discrete(30,80))
            else if rand3 <= 7 then ("Coffee maker", discrete(20,200))
            else if rand3 <= 8 then ("Headphones", discrete(20,300))
            else if rand3 <= 9 then ("Sneakers", discrete(30,150))
            else if rand3 <= 10 then ("Camera", discrete(200,2000))
            else if rand3 <= 11 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 12 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 13 then ("Pet food", discrete(10,50))
            else if rand3 <= 14 then ("Car battery", discrete(50, 150))
            else if rand3 <= 15 then ("Multivitamin", discrete(5,20))
            else if rand3 <= 16 then ("Necklace", discrete(20,100))
            else if rand3 <= 17 then ("Printer", discrete(50,300))
            else ("Tent", discrete(50,300))
    end;


fun drawItemAttrYoungSunny() = 
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,6)
        val rand3 = discrete(1,14)
    in 
        if rand1 <= 0
        then
            if rand2 <= 1 then ("Laptop", discrete(300,3000))
            else if rand2 <= 2 then ("Smartphone", discrete(200,1500))
            else if rand2 <= 3 then ("Headphones", discrete(20,300))
            else if rand2 <= 4 then ("Printer", discrete(50,300))
            else if rand2 <= 5 then ("Sunscreen", discrete(2,10))
            else ("Swimwear", discrete(10,50))
        else
            if rand3 <= 1 then ("Umbrella", discrete(5,40))
            else if rand3 <= 2 then ("TShirt", discrete(20,50))
            else if rand3 <= 3 then ("Jeans", discrete(30,80))
            else if rand3 <= 4 then ("Coffee maker", discrete(20,200))
            else if rand3 <= 5 then ("Sneakers", discrete(30,150))
            else if rand3 <= 6 then ("Camera", discrete(200,2000))
            else if rand3 <= 7 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 8 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 9 then ("Pet food", discrete(10,50))
            else if rand3 <= 10 then ("Jacket", discrete(70,300))
            else if rand3 <= 11 then ("Car battery", discrete(50, 150))
            else if rand3 <= 12 then ("Multivitamin", discrete(5,20))
            else if rand3 <= 13 then ("Necklace", discrete(20,100))
            else ("Tent", discrete(50,300))
    end;

fun drawItemAttrYoungRainy() =
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,6)
        val rand3 = discrete(1,14)
    in 
        if rand1 <= 0
        then
            if rand2 <= 1 then ("Laptop", discrete(300,3000))
            else if rand2 <= 2 then ("Smartphone", discrete(200,1500))
            else if rand2 <= 3 then ("Headphones", discrete(20,300))
            else if rand2 <= 4 then ("Printer", discrete(50,300))
            else if rand2 <= 5 then  ("Umbrella", discrete(5,40))
            else ("Jacket", discrete(70,300))
        else
            if rand3 <= 1 then ("Sunscreen", discrete(2,10))
            else if rand3 <= 2 then ("TShirt", discrete(20,50))
            else if rand3 <= 3 then ("Swimwear", discrete(10,50))
            else if rand3 <= 4 then ("Jeans", discrete(30,80))
            else if rand3 <= 5 then ("Coffee maker", discrete(20,200))
            else if rand3 <= 6 then ("Sneakers", discrete(30,150))
            else if rand3 <= 7 then ("Camera", discrete(200,2000))
            else if rand3 <= 8 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 9 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 10 then ("Pet food", discrete(10,50))
            else if rand3 <= 11 then ("Car battery", discrete(50, 150))
            else if rand3 <= 12 then ("Multivitamin", discrete(5,20))
            else if rand3 <= 13 then ("Necklace", discrete(20,100))
            else ("Tent", discrete(50,300))
    end;

fun drawItemAttrOldSunny() = 
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,5)
        val rand3 = discrete(1,15)
    in 
        if rand1 <= 0
        then
            if rand2 <= 1 then ("Multivitamin", discrete(5,20))
            else if rand2 <= 2 then ("Pet food", discrete(10,50))
            else if rand2 <= 3 then ("Coffee maker", discrete(20,200))
            else if rand2 <= 4 then ("Sunscreen", discrete(2,10))
            else ("Swimwear", discrete(10,50))
        else
            if rand3 <= 1 then ("Umbrella", discrete(5,40))
            else if rand3 <= 2 then ("Laptop", discrete(300,3000))
            else if rand3 <= 3 then ("Smartphone", discrete(200,1500))
            else if rand3 <= 4 then ("TShirt", discrete(20,50))
            else if rand3 <= 5 then ("Jeans", discrete(30,80))
            else if rand3 <= 6 then ("Headphones", discrete(20,300))
            else if rand3 <= 7 then ("Sneakers", discrete(30,150))
            else if rand3 <= 8 then ("Camera", discrete(200,2000))
            else if rand3 <= 9 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 10 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 11 then ("Jacket", discrete(70,300))
            else if rand3 <= 12 then ("Car battery", discrete(50, 150))
            else if rand3 <= 13 then ("Necklace", discrete(20,100))
            else if rand3 <= 14 then ("Printer", discrete(50,300))
            else ("Tent", discrete(50,300))
    end;

fun drawItemAttrOldRainy() =
    let 
        val rand1 = discrete(0,1)
        val rand2 = discrete(1,5)
        val rand3 = discrete(1,15)
    in 
        if rand1 <= 0
        then
            if rand2 <= 1 then ("Multivitamin", discrete(5,20))
            else if rand2 <= 2 then ("Pet food", discrete(10,50))
            else if rand2 <= 3 then ("Coffee maker", discrete(20,200))
            else if rand2 <= 4 then ("Umbrella", discrete(5,40))
            else ("Jacket", discrete(70,300))
        else
            if rand3 <= 1 then ("Sunscreen", discrete(2,10))
            else if rand3 <= 2 then ("Laptop", discrete(300,3000))
            else if rand3 <= 3 then ("Smartphone", discrete(200,1500))
            else if rand3 <= 4 then ("TShirt", discrete(20,50))
            else if rand3 <= 5 then ("Swimwear", discrete(10,50))
            else if rand3 <= 6 then ("Jeans", discrete(30,80))
            else if rand3 <= 7 then ("Headphones", discrete(20,300))
            else if rand3 <= 8 then ("Sneakers", discrete(30,150))
            else if rand3 <= 9 then ("Camera", discrete(200,2000))
            else if rand3 <= 10 then ("Camera Bag", discrete(5,50))
            else if rand3 <= 11 then ("Tennis Racket", discrete(20,200))
            else if rand3 <= 12 then ("Car battery", discrete(50, 150))
            else if rand3 <= 13 then ("Necklace", discrete(20,100))
            else if rand3 <= 14 then ("Printer", discrete(50,300))
            else ("Tent", discrete(50,300))
    end;

fun drawItemAttrNormal() = 
    let 
        val rand = discrete(1,20)
    in
        if rand <= 1 then ("Sunscreen", discrete(2,10))
        else if rand <= 2 then ("Umbrella", discrete(5,40))
        else if rand <= 3 then ("Laptop", discrete(300,3000))
        else if rand <= 4 then ("Smartphone", discrete(200,1500))
        else if rand <= 5 then ("TShirt", discrete(20,50))
        else if rand <= 6 then ("Swimwear", discrete(10,50))
        else if rand <= 7 then ("Jeans", discrete(30,80))
        else if rand <= 8 then ("Coffee maker", discrete(20,200))
        else if rand <= 9 then ("Headphones", discrete(20,300))
        else if rand <= 10 then ("Sneakers", discrete(30,150))
        else if rand <= 11 then ("Camera", discrete(200,2000))
        else if rand <= 12 then ("Camera Bag", discrete(5,50))
        else if rand <= 13 then ("Tennis Racket", discrete(20,200))
        else if rand <= 14 then ("Pet food", discrete(10,50))
        else if rand <= 15 then ("Jacket", discrete(70,300))
        else if rand <= 16 then ("Car battery", discrete(50, 150))
        else if rand <= 17 then ("Multivitamin", discrete(5,20))
        else if rand <= 18 then ("Necklace", discrete(20,100))
        else if rand <= 19 then ("Printer", discrete(50,300))
        else ("Tent", discrete(50,300))
    end;



fun drawItemAttr(customerYoB, customerCountry) =
    if customerYoB > 1998
    then
        if customerCountry="Spain" orelse customerCountry="Portugal" orelse customerCountry="Greece" orelse customerCountry="Cyprus" orelse customerCountry="Malta"
            then drawItemAttrYoungSunny()
        else if customerCountry="Ireland" orelse customerCountry="Belgium" orelse customerCountry="Luxembourg" orelse customerCountry="Netherlands" orelse customerCountry="Denmark"
            then drawItemAttrYoungRainy()
        else drawItemAttrYoung()
    else if customerYoB < 1988
    then 
        if customerCountry="Spain" orelse customerCountry="Portugal" orelse customerCountry="Greece" orelse customerCountry="Cyprus" orelse customerCountry="Malta"
            then drawItemAttrOldSunny()
        else if customerCountry="Ireland" orelse customerCountry="Belgium" orelse customerCountry="Luxembourg" orelse customerCountry="Netherlands" orelse customerCountry="Denmark"
            then drawItemAttrOldRainy()
        else drawItemAttrOld()
    else 
        if customerCountry="Spain" orelse customerCountry="Portugal" orelse customerCountry="Greece" orelse customerCountry="Cyprus" orelse customerCountry="Malta"
            then drawItemAttrSunny()
        else if customerCountry="Ireland" orelse customerCountry="Belgium" orelse customerCountry="Luxembourg" orelse customerCountry="Netherlands" orelse customerCountry="Denmark"
            then drawItemAttrRainy()
        else drawItemAttrNormal();

fun drawCameraBag() = ("Camera Bag", discrete(5,50))
