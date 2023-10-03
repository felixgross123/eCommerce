(* ----- CONFIGURATION ----- *)
val CHANCE_PACKAGING_DEVIATION = 1; (*Chance that a package is prepared wrongfully (either duplicate or missing item) *)
val CHANCE_WRONG_DELIVERY_OPTION = 5; (*Chance that although fast delivery chosen, mormal delivery happens (or vice versa) *)

(* CHANCE_ITEM_ADD + CHANCE_ITEM_MISSING = 1 *)
val CHANCE_ITEM_ADD = 50;       (* Chance that if there is a deviation in packaging, an item is missing *)  
(* val CHANCE_ITEM_MISSING = 100-CHANCE_ITEM_ADD : Chance that if thgere is a deviation in packaging, a random item is addedCHANCE_ITEM *)


fun removeRandom(list) = 
let
    val len = length list
    val rand = discrete(1,len)
    val randElem = List.nth(list, rand)
in 
    rm randElem list
end;