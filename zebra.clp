;;;======================================================
;;;   Who Drinks Water? And Who owns the Zebra?
;;;     
;;;     Another puzzle problem in which there are five 
;;;     houses, each of a different color, inhabited by 
;;;     men of different nationalities, with different 
;;;     pets, drinks, and cigarettes. Given the initial
;;;     set of conditions, it must be determined which
;;;     attributes are assigned to each man.
;;;
;;;     Jess version 4.1 example
;;;
;;;     To execute, merely load, reset and run.
;;;
;;;     Components commented by Neeraj Aggarwal
;;;======================================================

;(set-node-index-hash 13)
    
/**
* Template for asserting facts of the riddle.
* slot a: differentiation (color, nationality, pet, drink, or cigarettes)
* slot v: option (specific of differentiation)
* slot h: number to be able to exclude any future assertions in provided category
* to find solution.
*/
(deftemplate avh  (slot a)  (slot v)  (slot h (type INTEGER)))

/**
* Rule: find-solution
* Will assert the given facts from the problem and what is being told on the 
* left hand side of the rule. On the right hand side, the solution facts are asserted.
*/
(defrule find-solution
  ; The Englishman lives in the red house.

  (avh (a nationality) (v englishman) (h ?n1))
  (avh (a color) (v red) (h ?c1 & ?n1))

  ; The Spaniard owns the dog.

  (avh (a nationality) (v spaniard) (h ?n2 & ~?n1))
  (avh (a pet) (v dog) (h ?p1 & ?n2))

  ; The ivory house is immediately to the left of the green house,
  ; where the coffee drinker lives.

  (avh (a color) (v ivory) (h ?c2&~?c1))
  (avh (a color) (v green) (h ?c3&~?c2&~?c1&:(= (+ ?c2 1) ?c3)))
  (avh (a drink) (v coffee) (h ?d1&?c3))

  ; The milk drinker lives in the middle house.

  (avh (a drink) (v milk) (h ?d2&~?d1&3))

  ; The man who smokes Old Golds also keeps snails.

  (avh (a smokes) (v old-golds) (h ?s1))
  (avh (a pet) (v snails) (h ?p2&~?p1&?s1))

  ; The Ukrainian drinks tea.

  (avh (a nationality) (v ukrainian) (h ?n3&~?n2&~?n1))
  (avh (a drink) (v tea) (h ?d3&~?d2&~?d1&?n3))

  ; The Norwegian resides in the first house on the left.

  (avh (a nationality) (v norwegian) (h ?n4&~?n3&~?n2&~?n1&1))

  ; Chesterslots smoker lives next door to the fox owner.

  (avh (a smokes) (v chesterfields) (h ?s2&~?s1))
  (avh (a pet) (v fox) (h ?p3&~?p2&~?p1&:(or (= ?s2 (- ?p3 1)) (= ?s2 (+ ?p3 1)))))

  ; The Lucky Strike smoker drinks orange juice.

  (avh (a smokes) (v lucky-strikes) (h ?s3&~?s2&~?s1))
  (avh (a drink) (v orange-juice) (h ?d4&~?d3&~?d2&~?d1&?s3)) 

  ; The Japanese smokes Parliaments

  (avh (a nationality) (v japanese) (h ?n5&~?n4&~?n3&~?n2&~?n1))
  (avh (a smokes) (v parliaments) (h ?s4&~?s3&~?s2&~?s1&?n5))

  ; The horse owner lives next to the Kools smoker, 
  ; whose house is yellow.

  (avh (a pet) (v horse) (h ?p4&~?p3&~?p2p4 (- ?s5 1)) (= ?p4 (+ ?s5 1)))))
  (avh (a color) (v yellow) (h ?c4&~?c3&~?c2&~?c1&?s5))&~?p1))
  (avh (a smokes) (v kools) (h ?s5&~?s4&~?s3&~?s2&~?s1&:(or (= ?

  ; The Norwegian lives next to the blue house.

  (avh (a color) (v blue) (h ?c5&~?c4&~?c3&~?c2&~?c1&:(or (= ?c5 (- ?n4 1)) (= ?c5 (+ ?n4 1)))))
  
  ; Who drinks water?  And Who owns the zebra?

  (avh (a drink) (v water) (h ?d5&~?d4&~?d3&~?d2&~?d1))
  (avh (a pet) (v zebra) (h ?p5&~?p4&~?p3&~?p2&~?p1))

  => 
  (assert (solution nationality englishman ?n1)
          (solution color red ?c1)
          (solution nationality spaniard ?n2)
          (solution pet dog ?p1)
          (solution color ivory ?c2)
          (solution color green ?c3)
          (solution drink coffee ?d1)
          (solution drink milk ?d2) 
          (solution smokes old-golds ?s1)
          (solution pet snails ?p2)
          (solution nationality ukrainian ?n3)
          (solution drink tea ?d3)
          (solution nationality norwegian ?n4)
          (solution smokes chesterfields ?s2)
          (solution pet fox ?p3)
          (solution smokes lucky-strikes ?s3)
          (solution drink orange-juice ?d4) 
          (solution nationality japanese ?n5)
          (solution smokes parliaments ?s4)
          (solution pet horse ?p4) 
          (solution smokes kools ?s5)
          (solution color yellow ?c4)
          (solution color blue ?c5)
          (solution drink water ?d5)
          (solution pet zebra ?p5))
  )

/**
* Rule: print-solution
* Will compare different generated combinations to the asserted solution facts.
* If it is incorrect, the facts will be retracted and a new cominbation will be 
* generated using generate-combinations to create and test a new combination.
* If it is correct, then the program will print the solution to the riddle.
*/
(defrule print-solution
  ?f1 <- (solution nationality ?n1 1)
  ?f2 <- (solution color ?c1 1)
  ?f3 <- (solution pet ?p1 1)
  ?f4 <- (solution drink ?d1 1)
  ?f5 <- (solution smokes ?s1 1)
  ?f6 <- (solution nationality ?n2 2)
  ?f7 <- (solution color ?c2 2)
  ?f8 <- (solution pet ?p2 2)
  ?f9 <- (solution drink ?d2 2)
  ?f10 <- (solution smokes ?s2 2)
  ?f11 <- (solution nationality ?n3 3)
  ?f12 <- (solution color ?c3 3)
  ?f13 <- (solution pet ?p3 3)
  ?f14 <- (solution drink ?d3 3)
  ?f15 <- (solution smokes ?s3 3)
  ?f16 <- (solution nationality ?n4 4)
  ?f17 <- (solution color ?c4 4)
  ?f18 <- (solution pet ?p4 4)
  ?f19 <- (solution drink ?d4 4)
  ?f20 <- (solution smokes ?s4 4)
  ?f21 <- (solution nationality ?n5 5)
  ?f22 <- (solution color ?c5 5)
  ?f23 <- (solution pet ?p5 5)
  ?f24 <- (solution drink ?d5 5)
  ?f25 <- (solution smokes ?s5 5)
  =>
  (retract ?f1 ?f2 ?f3 ?f4 ?f5 ?f6 ?f7 ?f8 ?f9 ?f10 ?f11 ?f12 ?f13 ?f14
           ?f15 ?f16 ?f17 ?f18 ?f19 ?f20 ?f21 ?f22 ?f23 ?f24 ?f25)
  (printout t "HOUSE | Nationality Color Pet Drink Smokes" crlf)
  (printout t "--------------------------------------------------------------------" crlf)
  (printout t "  1   |" ?n1 " " ?c1 " " ?p1 " " ?d1 " " ?s1 crlf)
  (printout t "  2   |" ?n2 " " ?c2 " " ?p2 " " ?d2 " " ?s2 crlf)
  (printout t "  3   |" ?n3 " " ?c3 " " ?p3 " " ?d3 " " ?s3 crlf)
  (printout t "  4   |" ?n4 " " ?c4 " " ?p4 " " ?d4 " " ?s4 crlf)
  (printout t "  5   |" ?n5 " " ?c5 " " ?p5 " " ?d5 " " ?s5 crlf)
  (printout t crlf crlf))

/**
* Rule: startup
* A rule that will initially will print the riddle, and then ask the user to find the solution.
* From there, it will assert the different options as facts representing the different options
* for each category possible: color, nationality, pet, drink, and smokes.
*/
(defrule startup
   =>
   (printout t
    "There are five houses, each of a different color, inhabited by men of"  crlf
    "different nationalities, with different pets, drinks, and cigarettes."  crlf
    crlf
    "The Englishman lives in the red house.  The Spaniard owns the dog."     crlf
    "The ivory house is immediately to the left of the green house, where"   crlf
    "the coffee drinker lives.  The milk drinker lives in the middle house." crlf
    "The man who smokes Old Golds also keeps snails.  The Ukrainian drinks"  crlf
    "tea.  The Norwegian resides in the first house on the left.  The"       crlf)
   (printout t
    "Chesterfields smoker lives next door to the fox owner.  The Lucky"      crlf
    "Strike smoker drinks orange juice.  The Japanese smokes Parliaments."   crlf
    "The horse owner lives next to the Kools smoker, whose house is yellow." crlf
    "The Norwegian lives next to the blue house."			     crlf
    crlf
    "Now, who drinks water?  And who owns the zebra?" crlf crlf)
   (assert (value color red) 
           (value color green) 
           (value color ivory)
           (value color yellow)
           (value color blue)
           (value nationality englishman)
           (value nationality spaniard)
           (value nationality ukrainian) 
           (value nationality norwegian)
           (value nationality japanese)
           (value pet dog)
           (value pet snails)
           (value pet fox)
           (value pet horse)
           (value pet zebra)
           (value drink water)
           (value drink coffee)
           (value drink milk)
           (value drink orange-juice)
           (value drink tea)
           (value smokes old-golds)
           (value smokes kools)
           (value smokes chesterfields)
           (value smokes lucky-strikes)
           (value smokes parliaments)) 
   )

/**
* Rule: generate-combinations
* Will generate a new cominbation between the different categories
* and options per category to be tested.
*/
(defrule generate-combinations
   ?f <- (value ?s ?e)
   =>
   (retract ?f)
   (assert (avh (a ?s) (v ?e) (h 1))
           (avh (a ?s) (v ?e) (h 2))
           (avh (a ?s) (v ?e) (h 3))
           (avh (a ?s) (v ?e) (h 4))
           (avh (a ?s) (v ?e) (h 5))))


/**
* Capture the time at start.
*/
(defglobal ?*time* = (time))
(set-reset-globals FALSE)

/**
* Run the program a given number of times.
* @param ?n: the number of times to run the program.
*/
(deffunction run-n-times (?n)
  (while (> ?n 0) do
         (reset)
         (run)
         (bind ?n (- ?n 1))))


(run-n-times 1)   ; Run the program once

(printout t "Elapsed time: " (integer (- (time) ?*time*)) crlf) ; Print the time elapsed

