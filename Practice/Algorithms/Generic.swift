//
//  Helper.swift
//  Test
//
//  Created by Ajith Anthony on 5/9/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation


func topNCompetitors(numCompetitors:Int,topNCompetitors:Int,
                            competitors:[String], numReviews:Int,
                            reviews:[String]) -> [String] {
    // Result HashMap dictionary
    var competitorsDictionary = [String: Int]()
    
    // Sort array competitors in Alphabetical order
    let sortedCompetitorsArray = competitors.sorted { $0 > $1 }
    print(sortedCompetitorsArray)
    // Initialize competitorsDictionary with default reviews as 0
    // Also, check for each reviews and see whether it has current competitor
    for competitor in sortedCompetitorsArray {
        var competitorCount = 0
        for review in reviews {
            if review.lowercased().contains(competitor.lowercased()) {
                competitorCount += 1
            }
        }
        competitorsDictionary[competitor] = competitorCount
        print(competitorsDictionary)
    }
    
    // Sort competitorsDictionary based on competitor review count
    let competitorsSortedDictionary = competitorsDictionary.sorted { $0.1 > $1.1 }
    print("TOP: \(competitorsSortedDictionary)")
    
    var competitorsList = [String]()
    for (key, _) in competitorsSortedDictionary {
        competitorsList.append(key)
    }
    
    
    if topNCompetitors < competitorsSortedDictionary.count {
        return Array(competitorsList[..<topNCompetitors])
    } else {
        return competitorsList
    }
}

func breakingRecords(scores: [Int]) -> [Int] {
    guard !scores.isEmpty else {
        return [0, 0]
    }
    var minScore = scores[0]
    var maxScore = scores[0]
    var minScoreCount = 0
    var maxScoreCount = 0
    
    for score in scores {
        if score < minScore {
            minScore = score
            minScoreCount += 1
            print("minScore: \(minScore)")
        }
        if score > maxScore {
            maxScore = score
            maxScoreCount += 1
            print("maxScore: \(maxScore)")
        }
    }
    return [maxScoreCount, minScoreCount]
}

func birthday(s: [Int], d: Int, m: Int) -> Int {
    var numberOfWays = 0
    for i in 0..<s.count {
        let sliceLimit = i + m
        if sliceLimit <= s.count {
            let subArray = Array(s[i..<sliceLimit])
            let sum = subArray.reduce(0, +)
            if sum == d {
                numberOfWays += 1
            }
        }
    }
    return numberOfWays
}

func kangaroo(x1: Int, v1: Int, x2: Int, v2: Int) -> String {
    var firstKangarooPositions = Set<Int>()
    var secindKangarooPositions = Set<Int>()
    var position = x1
    
    while position < 100 {
        firstKangarooPositions.insert(position)
        position += v1
    }
    print(firstKangarooPositions.sorted())
    position = x2
    
    while position < 100 {
        secindKangarooPositions.insert(position)
        position += v2
    }
    print("\n############\n")
    print(secindKangarooPositions.sorted())
    let status = firstKangarooPositions.intersection(secindKangarooPositions)
    print(status.sorted())
    
    for item in status {
        let firstIndex = Array(firstKangarooPositions).firstIndex(of: item)
        let secondIndex = Array(secindKangarooPositions).firstIndex(of: item)
        if firstIndex == secondIndex {
            print("### ITEM: \(item)")
            return "YES"
        }
    }
    
    return "NO"
}

func reverseWords(_ s: String) -> String {
    var wordsArray = s.split(separator: " ")
    wordsArray = wordsArray.filter { $0 != "" }.reversed()
    return wordsArray.joined(separator: " ")
}


func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
    guard !nums.isEmpty, nums.count > 1 else {
        return false
    }
    
    for i in 0...nums.count - 2 {
        for j in i+1...nums.count - 1 {
            print(abs(nums[i] - nums[j]))
            print(abs(i-j))
            print("#######")
            if abs(nums[i] - nums[j]) <= t && abs(i-j) <= k {
                
                  return true
            }
        }
    }
    return false
}

func removeComments(_ source: [String]) -> [String] {
    print(source)
    var resultArray = [String]()
    var blockCommentStarted = false
    for item in source {
        if item.contains("/*") {
            let codeBeforeComment = item.components(separatedBy: "/*").first
            if !(codeBeforeComment?.isEmpty ?? true) {
                resultArray.append(codeBeforeComment!)
            }
            blockCommentStarted = true
        }
        if item.contains("*/") {
            let codeBeforeComment = item.components(separatedBy: "*/").last
            if !(codeBeforeComment?.isEmpty ?? true) {
                resultArray.append(codeBeforeComment!)
            }
            blockCommentStarted = false
            continue
        }
        if !item.contains("//"), !blockCommentStarted {
            resultArray.append(item)
        }
    }
    return resultArray.filter { !$0.isEmpty }
}

// MARK: Insert Delete GetRandom O(1)
/*Design a data structure that supports all following operations in average O(1) time.

insert(val): Inserts an item val to the set if not already present.
remove(val): Removes an item val from the set if present.
getRandom: Returns a random element from current set of elements. Each element must have the same probability of being returned.*/
class RandomizedSet {

    /** Initialize your data structure here. */
    var array: [Int]
    init() {
        array = [Int]()
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if array.contains(val) {
            return false
        }
        array.append(val)
        return true
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        guard let index = array.index(of: val) else {
            return false
        }
        array.remove(at: index)
        return true
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        return array.randomElement() ?? 0
    }
}

func isSplitPossible(for array: [Int]) -> Bool {
    let sum = array.reduce(0, +)
    for i in 0..<array.count {
        for j in i..<array.count {
            print(array[i...j])
            if array[i...j].reduce(0, +) == sum/2 {
                print(array[i...j])
            }
        }
    }
    return false
}


// MARK: K Closest Points to Origin
/*
 We have a list of points on the plane.  Find the K closest points to the origin (0, 0).

 (Here, the distance between two points on a plane is the Euclidean distance.)

 You may return the answer in any order.  The answer is guaranteed to be unique (except for the order that it is in.)
 Example 1:
 Input: points = [[1,3],[-2,2]], K = 1
 Output: [[-2,2]]
 */
func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
    var result = [Int: Int]()
    var closestPoint = [[Int]]()
    for (index, value) in points.enumerated() {
        result[index] = (value[0] * value[0]) + (value[1] * value[1])
    }
    let sortedResult = result.sorted { $0.1 < $1.1 }
    var i = 0
    for (key, _) in sortedResult where i < K {
        closestPoint.append(points[key])
        i += 1
    }
    return closestPoint
}

// MARK: String contains a substring
func isSubstring(_ substring: String, in string: String) -> Bool {
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

// MARK: Number Between The Duplicates
//Given [2, 3, 4, 2, 3] return [3, 4, 4, 2]
//Given [2, 3, 4, 2, 3, 2] return [3, 4, 4, 2, 3]
func numberBetweenTheDuplicates(_ nums: [Int]) -> [Int] {
    print(nums)
    var hashMap = [Int: [Int]]()
    var result = [Int]()
    // Building a hashmap with number and its indexes
    for (index, num) in nums.enumerated() {
        if var indexArray = hashMap[num] {
            indexArray.append(index)
            hashMap[num] = indexArray
        } else {
            hashMap[num] = [index]
        }
    }
    print(hashMap)
    // If a number has more than one index, its a duplicate number.
    // Then we will figure out the index position of this number and find the numbers between each indexes.
    for (_, values) in hashMap where values.count >= 2 {
        var i = 0
        while i < values.count - 1 {
            let firstIndex = values[i] + 1
            let lastIndex = values[i+1] - 1
            result.append(contentsOf: nums[firstIndex...lastIndex])
            i += 1
        }
    }
    
    return result
}

// MARK: Subdomain Visit Count
/*A website domain like "discuss.leetcode.com" consists of various subdomains. At the top level, we have "com", at the next level, we have "leetcode.com", and at the lowest level, "discuss.leetcode.com". When we visit a domain like "discuss.leetcode.com", we will also visit the parent domains "leetcode.com" and "com" implicitly.

Now, call a "count-paired domain" to be a count (representing the number of visits this domain received), followed by a space, followed by the address. An example of a count-paired domain might be "9001 discuss.leetcode.com".

We are given a list cpdomains of count-paired domains. We would like a list of count-paired domains, (in the same format as the input, and in any order), that explicitly counts the number of visits to each subdomain.

 Example 1:
 Input:
 ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
 Output:
 ["901 mail.com","50 yahoo.com","900 google.mail.com","5 wiki.org","5 org","1 intel.mail.com","951 com"]

 */
func subdomainVisits(_ cpdomains: [String]) -> [String] {
    var hashMap = [String: Int]()
    
    // Build a hasp map for each sub domain with count as its value.
    for domains in cpdomains {
        let array = domains.split(separator: " ")
        let count = Int(array.first ?? "") ?? 0
        let domain = (array.last ?? "").split(separator: ".")
        var i = 0
        while i < domain.count {
            let subDomain = domain[i..<domain.count]
            let key = subDomain.joined(separator: ".")
            if let totalCount = hashMap[key] {
                hashMap[key] = totalCount + count
            } else {
                hashMap[key] = count
            }
            i += 1
        }
    }
    var resultArray = [String]()
    for (key, value) in hashMap {
        resultArray.append("\(value) \(key)")
    }
    return resultArray
}

// MARK: Merge Intervals

///Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

///Example 1:

///Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
///Output: [[1,6],[8,10],[15,18]]
///Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].

func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {
    var result = [[Int]]()
    guard intervals.count > 0 else {
        return result
    }
    let intervals = intervals.sorted { $0[0] < $1[0] }
    for interval in intervals {
        if result.count == 0 {
            result.append([interval[0], interval[1]])
        } else {
            let lastMax = result.last![1]
            let lastMin = result.last![0]
            if interval[0] > lastMax {
                result.append([interval[0], interval[1]])
            } else if interval[1] > lastMax {
                result.removeLast()
                result.append([lastMin, interval[1]])
            }
        }
    }
    return result
}
