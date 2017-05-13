/*
* Neeraj Aggarwal
* 2/18/2016
*
* This program will generate an anagram from a word inputted from the user,
* by asserting the independent characters and dynamially creating rules.
* First, the console will prompt the user for a word. It will then add spaces
* in between each character and explode the string, such that it can be returned in
* the list with each character as a value, ordered in the list with the corresponding
* index as in the string. From there it will assert all the characters in the list,
* and then dependent on the size of the list will dynamically create a rule base, such that
* all variations of the word will be printed without any duplicates.
*
* Function to call: createAnagram
*/

(clear) 
(reset)

/*
* Template for asserting letters and their position. slot c represents the character added,
* and slot p represents the position of the character.
*/
(deftemplate Letter (slot c) (slot p)) 

/*
* Ask Prompt
* Will receive a specific prompt, then read it to
* the user. It then reads an input from the user and returns it.
*
* @param ?prompt: The prompt that will be read to the user.
* @return: The input from the user.
*/
(deffunction ask (?prompt)
   (printout t ?prompt)
   (return (read))
)

/*
* Space String
* Will add spaces in between each character in a given string by creating a new string,
* spacedString, and iterate over the given string and adding each character followed with a space
* afterwards. Then, it returns the newly created spacedString.
*
* @param ?string: The string in which spaces should be added between each character
* @return: The given string with spaces in between each character.
*/
(deffunction addSpaces (?string)
   (bind ?spacedString "")
   (for (bind ?i 1) (<= ?i (str-length ?string)) (++ ?i)
      (bind ?spacedString (str-cat ?spacedString (sub-string ?i ?i ?string) " "))
   )
   (return ?spacedString)
)

/*
* Will assert a given letter and position, using the Letter template defined.
* 
* @param ?c: The character to be asserted.
* @param ?p: The index in which is should be asserted.
*/
(deffunction assertLetter (?c ?p)
   (return (assert (Letter (c ?c) (p ?p))))
) 

/*
* Will assert an entire given list, with each value in the list
* being asserted with their respective position. 
* It iterates over the list, and calls assertLetter with the current character and its
* index. It then returns the length of the list that was given.
*
* @param ?list: The list of characters to be asserted.
* @return: The length of the list given.
*/
(deffunction assertList (?list)
   (for (bind ?i 1) (<= ?i (length$ ?list)) (++ ?i)
      (assertLetter (nth$ ?i ?list) ?i)   ; assert each value in the list with its index
   )
   (return (length$ ?list))
)

/*
* Generate the code for part of a rule, regarding the letter and its placement
* in the rule. For example, if this function was called with 2 as a parameter,
* it would return:
* (Letter (c ?c2) (p ?p2 &~ ?p1))
*
* It does this by intializing a new string with "(Letter (c ?c[given number]) (p ?p[given number]," 
* right before the exclusion of the other positions. Then, it will loop over each number
* up to the provided number, and add " &~ ?p" along with the iterative number to the string, thus
* excluding every previous position already provided.
*
* @param ?l: the number of the letter, such that the code part can be generated 
* accordingly.
* @return: a string, which is a rule checking for a certain character at a position, yet excluding
* any position before.
*/
(deffunction rulePart (?l)
   (bind ?newstring (str-cat "(Letter (c ?c" ?l ") (p ?p" ?l))  ; create base and add current letter
   (for (bind ?i 1) (< ?i ?l ) (++ ?i)
      (bind ?newstring (str-cat ?newstring " &~ ?p" ?i))        ; add exclusion of any previous position
   )
   (bind ?newstring (str-cat ?newstring "))"))
   (return ?newstring)
)

/*
* Will build an entire rule, defrule anagram, for letters and its positions.
* It will begin by creating a string, begining with the definition of the rule "(defrule anagram " 
* From there it will create the rule parts with the corresponding character and position, excluding
* any position before hand by iterativley calling rulePart and concatinating it with the current rule.
* From there, it will add "=> (printout t" to the string, thus forming the right hand side of the rule.
* It will then generate the print function, including all given characters in the list. Example rule 
* for parameter 2:
* (defrule anagram (Letter (c ?c1) (p ?p1))(Letter (c ?c2) (p ?p2 &~ ?p1))=> (printout t ?c1 ?c2 " ")) 
*
* @param ?number: the number in which the rule should be created upon, and generate
* the respective letter positions and exclusions, along with printing all the characters.
* @return: string which will run as executable code as a rule.
*/
(deffunction buildRule (?number)
   (bind ?rule "(defrule anagram ")                 ; define rule header
   (for (bind ?i 1) (<= ?i ?number) (++ ?i)
      (bind ?rule (str-cat ?rule (rulePart ?i)))    ; add parts of letters including exclusion
   )
   (bind ?rule (str-cat ?rule "=> (printout t"))    ; define right hand side of rule
   (for (bind ?i 1) (<= ?i ?number) (++ ?i)
      (bind ?rule (str-cat ?rule " ?c" ?i))         ; add each variable to print
   )
   (bind ?rule (str-cat ?rule " \" \"))"))
   (return ?rule)
)

/*
* Build Anagram
* Will create an Anagram out of a word the user inputs, by using dynamically
* created rules and assertions.
*
* Will prompt the user for a word to create an Anagram using the ask function,
* and then create a new variable with spaces in between each character in the word
* inputted. From there, the function will call explode on the string, and save the newly created
* list. It will then assert each value in the list with the function assertList,
* and then build a rule dependent on how many characters the given string has using buildRule.
* It will then  build the dynamically created rule, and run the program. Once the program has 
* finished executing, it will reset all asserted values.
*
*/
(deffunction createAnagram ()
   (bind ?string (ask "Enter a word: "))
   (bind ?spacedString (addSpaces ?string))
   (bind ?list (explode$ ?spacedString))
   (bind ?number (assertList ?list))
   (build (buildRule ?number))
   (printout t (run) crlf)   ; print how many rules fired for verification
   (reset)
   (return)
)
