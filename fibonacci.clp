/*
* Neeraj Aggarwal
* 2/1/2016
* This module will find a given number of integers
* in the Fibonacci sequence by using a list to store
* the integers in the sequence in order with increasing
* index.
*/
(clear) 
(reset)

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
* Fibonacci
*    Will prompt the user to input a valid integer representing how
* many numbers of the Fibonacci sequence they want. The function will validate
* it by checking if it is an integer and greater than 0.
*    If it passes, then it will pass the input on to fib, and print the list
* of the fibonacci numbers calculated which are returned by the calculator.
*    If not, then it will alert the user, and then re-prompt by calling
* itself afterwards. This is possible because the only executable code after
* this check is a return statement which does not affect user interface.
*/
(deffunction fibonacci ()
   (bind ?number (ask "Enter a positive integer representing how many numbers of the Fibonacci sequence you want: "))
   (if (and (integerp ?number) (> ?number 0)) then
      (printout t (fib ?number) crlf)
   else
      (printout t "This input did not meet the requirements. Try again." crlf)
      (fibonacci)
   )
   (return)
)

/*
* Fibonacci Calculator
* Calculates a given number of integers in the Fibonacci sequence.
*    It will first create a list, and then store value 1 and index 1. It then checks
* if the number given is 1.
*    If it is, then it will return the list, which consists of only 1 (the first number in the
* sequence. If its not, then it will store 1 at index two.
*    From there (if ?n > 1), it iterates from 3 to the provided number, using the iterative counter in
* the loop as an index. It calculates the sum of the value 1 index previous to the current with
* the the value 2 indices previous to the current, and inserts it in the list with the current index.
*
* @param ?n: The number of integers in the fibonacci sequence to calculate.
* @return: a list of size ?n consisting of the fibonacci sequence with the first two integers being 1 and 1.
*/
(deffunction fib (?n)
   (bind ?values (list))
   (bind ?values (insert$ ?values 1 1)) 
   (if (= ?n 1) then      ; Check if number wanted is 1, so list can be returned now
      (return ?values)
   )
   (bind ?values (insert$ ?values 2 1))
   (for (bind ?i 3) (<= ?i ?n) (++ ?i)
      (bind ?values (insert$ ?values ?i (+ (nth$ (- ?i 1) ?values) (nth$ (- ?i 2) ?values))))
   )
   (return ?values)
)
