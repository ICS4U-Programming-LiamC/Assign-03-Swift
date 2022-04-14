//
//  recursionAssign.swift
//
//  Created by Liam Csiffary
//  Created on 2022-04-14
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  The recursionAssign program does one option of the assignments
//  This is the option I chose: 
//  1
//  121
//  1213121
//  121312141213121 ... line break at every number greater than 5 if at the end
//  of the line
//

import Foundation

// reads the txt file
// code from
// https://forums.swift.org/t/read-text-file-line-by-line/28852/4
func readFile(_ path: String) -> [String] {
  var arrayOfStrings: [String] = []
  if freopen(path, "r", stdin) == nil {
    perror(path)
    return []
  }
  while let line = readLine() {
    arrayOfStrings.append(String(line))
    //do something with lines..
  }
  return arrayOfStrings
}

// writes the txt file
func writeTxt(from recArray:[String]) {

  // turns the contents of the array into a string
  var str = ""
  for info in recArray {
    str += info + "\n"
  }

  // https://stackoverflow.com/questions/55870174/how-to-create-a-csv-file-using-swift
  let filePath = NSHomeDirectory() + "/Assigns/Assign-03-Swift/expandedNumbers.txt"
  if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)) {
    print("File created successfully.")
  } else {
    print("File not created.")
  }

  // https://stackoverflow.com/questions/24410473/how-to-convert-this-var-string-to-url-in-swift
  let filename = URL(fileURLWithPath: filePath)
  print(filename)

  // https://www.hackingwithswift.com/example-code/strings/how-to-save-a-string-to-a-file-on-disk-with-writeto
  do {
    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
  } catch {
    // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    print("failed")
  } 
}

// expands the condensed string
func numberExpander(numToGoToo: Int, currentNum: Int, finalString: String) -> String {
  // base case
  if (numToGoToo == currentNum) {
    return finalString;

    // if the number is greater than 5 also add a new line
  } else if (currentNum > 5) {
    return numberExpander(numToGoToo: numToGoToo, currentNum: currentNum + 1, finalString: finalString + String(currentNum) + "\n" + finalString);

    // otherwise just send the numToGoToo, the current num + 1, and the current number 
    // sandwiched between two of the current strings
  } else {
    return numberExpander(numToGoToo: numToGoToo, currentNum: currentNum + 1, finalString: finalString + String(currentNum) + finalString);
  }
}

// main function
func main() {
  // gets the arrays from the txt files
  let file = "testCases.txt"
  let condensedNums: [String] = readFile(file)

  // empty array to be populated
  var expandedNumbers: [String] = []

  // passes each in the array to the expander function
  for each in condensedNums {
    // gets and adds the result to the formerly
    // empty array
    let expandedString = numberExpander(numToGoToo: (Int(each) ?? 1) + 1, currentNum: 1, finalString: "")
    expandedNumbers.append("Expanded number:\n" + expandedString + "\n")
    print("Original number:", each)
    print("Expanded numbers:\n" + expandedString, "\n")
  }

  // writes it all to a txt file
  writeTxt(from: expandedNumbers)
}

// starts the program
main()
