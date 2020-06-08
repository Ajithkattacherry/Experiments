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
