/**
 * Neeraj Aggarwal
 * 23 January 2016
 * This program takes in a a paragraph of ASCII text (hard-coded in as inputText), and outputs
 * an alphabetic histogram showing how many times each letter in the alphabet is used. It runs
 * independent of case, and will output only alphabetic characters.
 */

import java.util.TreeMap;
import java.util.Set;

public class Main
{

    public static void main(String[] args)
    {
       /**
       * inputText is designed to test its ability to parse strings and interpret how many times
       * each letter in the alphabet appears. It includes various ASCII characters (which are not
       * letters) as well as different cases. By including   the sentence"The quick brown fox jumps
       * over the lazy dog," each letter is guaranteed to appear once.
       */
       String inputText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod" +
             " tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis " +
             "nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." +
             "!#$%&'()*+,-./0123456789:;<=>?@[]^_{|}~" +          //Test other ASCII characters
             "The quick brown fox jumps over the lazy dog";       //Ensure all letters

       TreeMap<String, Integer> characterMap = new TreeMap<String, Integer>();

       //Iterate through string and add letters to TreeMap as key, with their count as value
       for (int i=0;i<inputText.length();i++)
       {
          String s = inputText.substring(i,i+1);

          //Prepare string for check - remove non-alphabetic characters and spaces
          s = s.toLowerCase();                                     //Makes alphabetic characters lowercase
          s = s.replaceAll("\\s","");                              //Replace spaces with an empty string
          s = s.replaceAll("[^a-z ]", "");                         //Replace non-alphabetic characters with an empty string

          if (!s.equals(""))
          {
             if (characterMap.get(s) == null)
                characterMap.put(s, 1);
             else
                characterMap.put(s, characterMap.get(s) + 1);
          }
       }

       //Retrieve the set of keys from the map
       Set<String> keys = characterMap.keySet();

       //Print the letters and how many times they appear in the input
       for (String letter : keys)
       {
          System.out.println("Letter "+letter +
                  " is found "+ characterMap.get(letter)+" times.");
       }

       return;
    }

}
