//
//  String.swift
//  Practice
//
//  Created by Ajith Anthony on 5/24/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: 1. Palindrom string check
// Eg: MALAYALAM
func isPalindrom(_ string: String) -> Bool {
    let strArray = Array(string)
    var i = 0
    let n = strArray.count
    while i < n/2 {
        if strArray[i] != strArray[(n - 1) - i] {
            return false
        }
        i += 1
    }
    return true
}

// MARK: 2. Palindrome Permutation
// If a set of characters can form a palindrome if at most one character
// occurs odd number of times and all characters occur even number of times.
// Eg: MALAYALAM -> Count of M,A,L is 2 and Y is 1.
func isPalindromPermutation(_ string: String) -> Bool {
    var hashMap = [Character: Int]()
    if string.isEmpty {
        return false
    }
    
    let strArray = Array(string)
    for char in strArray {
        if let count = hashMap[char] {
            hashMap[char] = count + 1
        } else {
            hashMap[char] = 1
        }
    }
    
    if (hashMap.values.filter { $0 > 2 }).count > 0 {
        return false
    }
    if (hashMap.values.filter { $0 == 1 }).count != 1 {
        return false
    }
    return true
}

// MARK: 3. Valid Anagram
// Input: s = "anagram", t = "nagaram"
// Output: true
func isAnagram(_ s: String, _ t: String) -> Bool {
    return s.sorted() == t.sorted()
}

// MARK: 4. Find All Anagrams in a String
// The idea is to get each substring of size p.count and check the sorted S string
// is matching to the sorted P string
/*Input:
s: "cbaebabacd" p: "abc"

Output:
[0, 6]

Explanation:
The substring with start index = 0 is "cba", which is an anagram of "abc".
The substring with start index = 6 is "bac", which is an anagram of "abc".
*/
func findAnagrams(_ s: String, _ p: String) -> [Int] {
    let charArray = Array(s)
    let pArray = Array(p)
    var outPut = [Int]()
    var i = 0
    let count = pArray.count - 1
    while (i + count) < charArray.count {
        let subArray = charArray[i...(i + count)]
        if pArray.sorted() == subArray.sorted() {
            outPut.append(i)
        }
        i += 1
    }
    return outPut
}

// MARK: 5. Check Substring of a String -> string contains in another string
func isSubString1(_ substring: String, in string: String) -> Bool {
    let strArray = Array(string)
    for i in 0..<strArray.count {
        for j in i..<strArray.count {
            if String(strArray[i...j]) == substring {
                return true
            }
        }
    }
    
    return false
}
func isSubstring2(_ substring: String, in string: String) -> Bool {
    let charArray = Array(string)
    let charSubstringArray = Array(substring)
    var i = 0, j = 0
    
    while j < charArray.count && i < charSubstringArray.count {
        if charSubstringArray[i] == charArray[j] {
            i += 1
        } else {
            i = 0
        }
        j += 1
        
        if i == charSubstringArray.count {
            return true
        }
    }
    return false
}

// MARK: 6. Length Of Longest Substring
func lengthOfLongestSubstring(_ string: String) -> Int {
    var result = [Character]()
    //var subStringArray = [String]()
    let charArray = Array(string)
    var max = 0
    for i in 0..<charArray.count {
        if result.contains(charArray[i]) {
            //let subString = String(result)
            //subStringArray.append(subString)
            guard let index = result.firstIndex(of: charArray[i]) else { return 0 }
            result.removeSubrange(0...index)
        }
        result.append(charArray[i])
        if result.count > max {
            max = result.count
        }
    }
    return max
}

// MARK: 7. Verifying an Alien Dictionary
/*
 * Given a sequence of words written in the alien language, and the order of the alphabet,
 * return true if and only if the given words are sorted lexicographicaly in this alien language.
 */
func isAlienSorted(_ words: [String], _ order: String) -> Bool {
    var hashMap = [Character: Int]()
    var i = 0
    // Creating a hashmap
    for char in order {
        hashMap[char] = i
        i += 1
    }
    
    // Looping each words using sliding window approach and compare each char
    // to see they are in order
    for i in 0..<words.count - 1 {
        let word1 = Array(words[i])
        let word2 = Array(words[i + 1])
        var flag = false
        for i in 0..<min(word1.count, word2.count) {
            if hashMap[word1[i]] ?? 0 < hashMap[word2[i]] ?? 0 {
                flag = true
                break
            } else if hashMap[word1[i]] ?? 0 == hashMap[word2[i]] ?? 0 {
                continue
            } else {
                return false
            }
        }
        if word1.count > word2.count && !flag {
            return false
        }
    }
    return true
}

// MARK: 8. Longest Palindromic Substring
func longestPalindrome(_ s: String) -> String {
    var maxPalimdrome = 0
    var maxPalimdromeString = ""
    let charArray = Array(s)
    for i in 0..<charArray.count {
        for j in i..<charArray.count {
            let subString = String(charArray[i...j])
            if isPalindrome(string: subString) {
                if subString.count > maxPalimdrome {
                    maxPalimdrome = subString.count
                    maxPalimdromeString = subString
                }
            }
        }
    }
    print("Ajith: \(maxPalimdromeString)")
    return maxPalimdromeString
}

func isPalindrome(string: String) -> Bool {
    let charArray = Array(string)
    let strLen = charArray.count
    var i = 0, j = strLen - 1
    while i < strLen/2 {
        if charArray[i] != charArray[j] {
            return false
        }
        i += 1
        j -= 1
    }
    return true
}

// MARK:
func getAllComments(for adID: Int) {
    let data = ["1": "test comment1",
                "2": "test comment2",
                "3": "test comment3",
                "4": "test comment4",
                "5": "test comment5"]
    let keys = data.keys
    let values = data.values
    print(Array(keys)[adID])
    print(Array(values)[adID])
}

// MARK: 9. 680 - Valid Palindrome II
/*Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.

Example 1:
Input: "aba"
Output: True
Example 2:
Input: "abca"
Output: True
Explanation: You could delete the character 'c'.*/
func validPalindrome(_ s: String) -> Bool {
    var charArray = Array(s)
    var i = 0
    if charArray.count <= 2 {
        return true
    }
    while i < charArray.count {
        if charArray[i] != charArray[charArray.count - 1 - i] {
            var tempArray = charArray
            tempArray.remove(at: i)
            charArray.remove(at: charArray.count - 1 - i)
            return isPalindrom(tempArray) || isPalindrom(charArray)
        }
        i += 1
    }
    return true
}

func isPalindrom(_ charArray: [Character]) -> Bool {
    if charArray.count < 3 {
        return false
    }
    var i = 0
    while i < charArray.count {
        if charArray[i] != charArray[charArray.count - 1 - i] {
            return false
        }
        i += 1
    }
    return true
}
