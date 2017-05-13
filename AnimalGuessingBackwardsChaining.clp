/*
* Neeraj Aggarwal
* 4/8/2016
* Adv Topics: Expert Systems
*
* Backward chaining implementation of the animal guessing game
*
* The user has the option to select either a dog, a cat, a panda, an eagle, 
* a hummingbird, an octopus, or an eel. The program will then prompt the user with 
* a series of questions using backwards chaining in order to determine the selected animal.
*
* Each animal has a set of conditions that must be true in order for that animal to be
* the answer. The goal of the program is to match all the conditions for one animal, thus
* identifying the animal that the user selected.
*
* Should any condition be false and eliminate the chance of an animal being a possibility,
* the program will automatically begin asking for conditions that meet another selected
* animal in order to verify or eliminate it.
*/

(clear) 
(reset)

/*
* Set up backward chaining for each characteristic used to determine the animal
* the player has chosen.
*/
(do-backward-chaining land)
(do-backward-chaining domestic)
(do-backward-chaining barking)
(do-backward-chaining blackandwhite)
(do-backward-chaining fly)
(do-backward-chaining nectar)
(do-backward-chaining mascot)
(do-backward-chaining water)
(do-backward-chaining long)
(do-backward-chaining tentacles)

/*
* Ask Prompt
* Will receive a specific prompt, then read it to
* the user. It then reads an input from the user, and convert
* the answer into yes, no, or leave it if it is not a valid input.
* If it is not a valid input, it will notify the user, and continue
* to prompt until a valid input is given and will return it.
*
* @param ?prompt: The prompt that will be read to the user.
* @return: The valid input from the user (yes or no after converting).
*/
(deffunction ask (?prompt)
   (printout t ?prompt crlf)
   (bind ?input (convert (read)))
   (while (not (validate ?input)) do    ;loop and prompt user until valid input
      (printout t "Not a valid input! Enter yes or no." crlf)
      (bind ?input (convert (read)))
   )
   (return ?input)
)

/*
* Convert Function
* Will convert the user input to yes or no if it is an accepted input, or leave it
* if it is not accepted.
* Accepted inputs: yes, y, Y, YES, no, n, N, and NO. Any other input can be considered
* unconventional and thus the user will be reprompted.
*
* The function will first will check if the input is yes, y, Y, or YES. If it is, it will
* rebind the variable to yes. Then it will check if the input is no, n, N, or NO. It will 
* rebind the variable to no if either of these is true. It then returns the variable, unchanged
* if no cases are matched.
*
* @param ?a: The input to be converted.
*/
(deffunction convert (?a)
   (if (or (= ?a "yes") (= ?a "y") (= ?a "Y") (= ?a "YES")) then
      (bind ?a yes)
   )
   (if (or (= ?a "no") (= ?a "n") (= ?a "N") (= ?a "NO")) then
      (bind ?a no)
   )
   (return ?a)
)

/*
* Validate Function
* Will validate the converted input by checking if it is yes or no. If it is valid, it
* will return true. Otherwise, it will return false.
*
* @param ?input: The input to be validated if it is yes or no.
*/
(deffunction validate (?input)
   (if (or (= ?input yes) (= ?input no)) then
      (bind ?x TRUE)
   else
      (bind ?x FALSE)
   )
   (return ?x)
)

/*
* Initial method to be called. Will print out the available animals, and notify the user
* of the inputs. It will then initiate the inference process in order to determine the
* animal the user has selected. 
*/
(deffunction play ()
   (printout t "Choose between a dog, a cat, a panda, an eagle, a hummingbird, 
      an eel, or an octopus. Use 'yes' or 'no' as input" crlf)
   (run)
)



/*
* The animal definitions containing the certain conditions that will be true for each animal.
* Should all the conditions of one animal be met, it will print out the animal.
*/

/*
* Animal definition for dog. A dog lives on land, is domestic, and barks. If 
* conditions are met, it will identify the animal as a dog.
*/
(defrule dog
   (land yes)
   (domestic yes)
   (barking yes)
   =>
   (printout t "The animal is a dog." crlf)
)

/*
* Animal definition for cat. A cat lives on land, is domestic, and does not bark. If 
* conditions are met, it will identify the animal as a cat.
*/
(defrule cat
   (land yes)
   (domestic yes)
   (barking no)
   =>
   (printout t "The animal is a cat." crlf)
)

/*
* Animal definition for panda. A panda lives on land, is not domestic, and is black and white. If 
* conditions are met, it will identify the animal as a panda.
*/
(defrule panda
   (land yes)
   (domestic no)
   (blackandwhite yes)
   =>
   (printout t "The animal is a panda." crlf)
)

/*
* Animal definition for eagle. An eagle flies, and is the mascot of America. If conditions
* are met, it will identify the animal as an eagle.
*/
(defrule eagle
   (fly yes)
   (mascot yes)
   =>
   (printout t "The animal is an eagle." crlf)
)

/*
* Animal definition for hummingbird. A hummingbird flies, and drinks nectar. If conditions
* are met, it will identify the animal as a hummingbird.
*/
(defrule hummingbird
   (fly yes)
   (nectar yes)
   =>
   (printout t "The animal is a hummingbird." crlf)
)

/*
* Animal definition for eel. An eel lives in water, and is long. If conditions
* are met, it will identify the animal as an eel.
*/
(defrule eel
   (water yes)
   (long yes)
   =>
   (printout t "The animal is a eel." crlf)
)

/*
* Animal definition for octopus. An octopus lives in water, and has tentacles. If conditions
* are met, it will identify the animal as an octopus.
*/
(defrule octupus
   (water yes)
   (tentacles yes)
   =>
   (printout t "The animal is an octopus." crlf)
)



/*
* Backward chaining implementation of rules to find the 
* characteristics in order to determine the animal.
*/

/*
* If the characteristic of land is needed, ask the user if the animal lives on land and assert the
* answer with land as a fact.
*/
(defrule need-land-rule
   (need-land ?)
   =>
   (assert (land (ask "Does the animal live on land?")))
)

/*
* If the characteristic of domestic is needed, ask the user if the animal is domestic and assert the
* answer with domestic as a fact.
*/
(defrule need-domestic-rule
   (need-domestic ?)
   =>
   (assert (domestic (ask "domestic?")))
)

/*
* If the characteristic of barking is needed, ask the user if the animal barks and assert the
* answer with barking as a fact.
*/
(defrule need-barking-rule
   (need-barking ?)
   =>
   (assert (barking (ask "barking?")))
)

/*
* If the characteristic of being black and white is needed, ask the user if the animal 
* is black and white and assert the answer with blackandwhite as a fact.
*/
(defrule need-blackandwhite-rule
   (need-blackandwhite ?)
   =>
   (assert (blackandwhite (ask "blackandwhite?")))
)

/*
* If the characteristic of flying is needed, ask the user if the animal flies and assert the
* answer with fly as a fact. The animal may not live on land to fly, thus land must be false in order
* to ask the user for this condition.
*/
(defrule need-fly-rule
   (need-fly ?)
   (land no)
   =>
   (assert (fly (ask "does it fly?")))
)

/*
* If the characteristic of nectar is needed, ask the user if the animal drinks nectar and assert the
* answer with nectar as a fact.
*/
(defrule need-nectar-rule
   (need-nectar ?)
   =>
   (assert (nectar (ask "nectar?")))
)

/*
* If the characteristic of mascot is needed, ask the user if the animal is a mascot and assert the
* answer with mascot as a fact. The animal may not be a mascot and drink nectar, thus nectar must be
* false in order to ask the user for this condition.
*/
(defrule need-mascot-rule
   (need-mascot ?)
   (nectar no)
   =>
   (assert (mascot (ask "mascot?")))
)

/*
* If the characteristic of water is needed, ask the user if the animal lives in water and assert the
* answer with water as a fact. The animal may not live on land or fly to live in water, thus land and fly
* must be false in order to ask the user for this condition.
*/
(defrule need-water-rule
   (need-water ?)
   (land no)
   (fly no)
   =>
   (assert (water (ask "water?")))
)

/*
* If the characteristic of being long is needed, ask the user if the animal is long and assert the
* answer with long as a fact.
*/
(defrule need-long-rule
   (need-long ?)
   =>
   (assert (long (ask "long?")))
)

/*
* If the characteristic of having tentacles is needed, ask the user if the animal has tentcales and assert the
* answer with tentacles as a fact. The animal may not have tentacles or be long, thus long must be false in order
* to ask the user for this condition.
*/
(defrule need-tentacles-rule
   (need-tentacles ?)
   (long no)
   =>
   (assert (tentacles (ask "tentacles?")))
)

(play)
