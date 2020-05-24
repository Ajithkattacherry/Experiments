//
//  Collections_Docs.swift
//  Practice
//
//  Created by Ajith Anthony on 5/24/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

/*
/// An unordered collection of unique elements.
///
/// You use a set instead of an array when you need to test efficiently for
/// membership and you aren't concerned with the order of the elements in the
/// collection, or when you need to ensure that each element appears only once
/// in a collection.
///
/// You can create a set with any element type that conforms to the `Hashable`
/// protocol. By default, most types in the standard library are hashable,
/// including strings, numeric and Boolean types, enumeration cases without
/// associated values, and even sets themselves.
///
/// Swift makes it as easy to create a new set as to create a new array. Simply
/// assign an array literal to a variable or constant with the `Set` type
/// specified.
///
///     let ingredients: Set = ["cocoa beans", "sugar", "cocoa butter", "salt"]
///     if ingredients.contains("sugar") {
///         print("No thanks, too sweet.")
///     }
///     // Prints "No thanks, too sweet."
///
/// Set Operations
/// ==============
///
/// Sets provide a suite of mathematical set operations. For example, you can
/// efficiently test a set for membership of an element or check its
/// intersection with another set:
///
/// - Use the `contains(_:)` method to test whether a set contains a specific
///   element.
/// - Use the "equal to" operator (`==`) to test whether two sets contain the
///   same elements.
/// - Use the `isSubset(of:)` method to test whether a set contains all the
///   elements of another set or sequence.
/// - Use the `isSuperset(of:)` method to test whether all elements of a set
///   are contained in another set or sequence.
/// - Use the `isStrictSubset(of:)` and `isStrictSuperset(of:)` methods to test
///   whether a set is a subset or superset of, but not equal to, another set.
/// - Use the `isDisjoint(with:)` method to test whether a set has any elements
///   in common with another set.
///
/// You can also combine, exclude, or subtract the elements of two sets:
///
/// - Use the `union(_:)` method to create a new set with the elements of a set
///   and another set or sequence.
/// - Use the `intersection(_:)` method to create a new set with only the
///   elements common to a set and another set or sequence.
/// - Use the `symmetricDifference(_:)` method to create a new set with the
///   elements that are in either a set or another set or sequence, but not in
///   both.
/// - Use the `subtracting(_:)` method to create a new set with the elements of
///   a set that are not also in another set or sequence.
///
/// You can modify a set in place by using these methods' mutating
/// counterparts: `formUnion(_:)`, `formIntersection(_:)`,
/// `formSymmetricDifference(_:)`, and `subtract(_:)`.
///
/// Set operations are not limited to use with other sets. Instead, you can
/// perform set operations with another set, an array, or any other sequence
/// type.
///
///     var primes: Set = [2, 3, 5, 7]
///
///     // Tests whether primes is a subset of a Range<Int>
///     print(primes.isSubset(of: 0..<10))
///     // Prints "true"
///
///     // Performs an intersection with an Array<Int>
///     let favoriteNumbers = [5, 7, 15, 21]
///     print(primes.intersection(favoriteNumbers))
///     // Prints "[5, 7]"
///
/// Sequence and Collection Operations
/// ==================================
///
/// In addition to the `Set` type's set operations, you can use any nonmutating
/// sequence or collection methods with a set.
///
///     if primes.isEmpty {
///         print("No primes!")
///     } else {
///         print("We have \(primes.count) primes.")
///     }
///     // Prints "We have 4 primes."
///
///     let primesSum = primes.reduce(0, +)
///     // 'primesSum' == 17
///
///     let primeStrings = primes.sorted().map(String.init)
///     // 'primeStrings' == ["2", "3", "5", "7"]
///
/// You can iterate through a set's unordered elements with a `for`-`in` loop.
///
///     for number in primes {
///         print(number)
///     }
///     // Prints "5"
///     // Prints "7"
///     // Prints "2"
///     // Prints "3"
///
/// Many sequence and collection operations return an array or a type-erasing
/// collection wrapper instead of a set. To restore efficient set operations,
/// create a new set from the result.
///
///     let morePrimes = primes.union([11, 13, 17, 19])
///
///     let laterPrimes = morePrimes.filter { $0 > 10 }
///     // 'laterPrimes' is of type Array<Int>
///
///     let laterPrimesSet = Set(morePrimes.filter { $0 > 10 })
///     // 'laterPrimesSet' is of type Set<Int>
///
/// Bridging Between Set and NSSet
/// ==============================
///
/// You can bridge between `Set` and `NSSet` using the `as` operator. For
/// bridging to be possible, the `Element` type of a set must be a class, an
/// `@objc` protocol (a protocol imported from Objective-C or marked with the
/// `@objc` attribute), or a type that bridges to a Foundation type.
///
/// Bridging from `Set` to `NSSet` always takes O(1) time and space. When the
/// set's `Element` type is neither a class nor an `@objc` protocol, any
/// required bridging of elements occurs at the first access of each element,
/// so the first operation that uses the contents of the set (for example, a
/// membership test) can take O(*n*).
///
/// Bridging from `NSSet` to `Set` first calls the `copy(with:)` method
/// (`- copyWithZone:` in Objective-C) on the set to get an immutable copy and
/// then performs additional Swift bookkeeping work that takes O(1) time. For
/// instances of `NSSet` that are already immutable, `copy(with:)` returns the
/// same set in constant time; otherwise, the copying performance is
/// unspecified. The instances of `NSSet` and `Set` share buffer using the
/// same copy-on-write optimization that is used when two instances of `Set`
/// share buffer.
public struct Set<Element> where Element : Hashable {

    /// Creates an empty set with preallocated space for at least the specified
    /// number of elements.
    ///
    /// Use this initializer to avoid intermediate reallocations of a set's
    /// storage buffer when you know how many elements you'll insert into the set
    /// after creation.
    ///
    /// - Parameter minimumCapacity: The minimum number of elements that the
    ///   newly created set should be able to store without reallocating its
    ///   storage buffer.
    public init(minimumCapacity: Int)

    /// Returns a new set containing the elements of the set that satisfy the
    /// given predicate.
    ///
    /// In this example, `filter(_:)` is used to include only names shorter than
    /// five characters.
    ///
    ///     let cast: Set = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let shortNames = cast.filter { $0.count < 5 }
    ///
    ///     shortNames.isSubset(of: cast)
    ///     // true
    ///     shortNames.contains("Vivien")
    ///     // false
    ///
    /// - Parameter isIncluded: A closure that takes an element as its argument
    ///   and returns a Boolean value indicating whether the element should be
    ///   included in the returned set.
    /// - Returns: A set of the elements that `isIncluded` allows.
    @available(swift 4.0)
    @inlinable public func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> Set<Element>

    /// Removes the elements of the given set from this set.
    ///
    /// In the following example, the elements of the `employees` set that are
    /// also members of the `neighbors` set are removed. In particular, the
    /// names `"Bethany"` and `"Eric"` are removed from `employees`.
    ///
    ///     var employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     employees.subtract(neighbors)
    ///     print(employees)
    ///     // Prints "["Diana", "Chris", "Alicia"]"
    ///
    /// - Parameter other: Another set.
    @inlinable public mutating func subtract(_ other: Set<Element>)

    /// Returns a Boolean value that indicates whether this set is a subset of
    /// the given set.
    ///
    /// Set *A* is a subset of another set *B* if every member of *A* is also a
    /// member of *B*.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     print(attendees.isSubset(of: employees))
    ///     // Prints "true"
    ///
    /// - Parameter other: Another set.
    /// - Returns: `true` if the set is a subset of `other`; otherwise, `false`.
    @inlinable public func isSubset(of other: Set<Element>) -> Bool

    /// Returns a Boolean value that indicates whether this set is a superset of
    /// the given set.
    ///
    /// Set *A* is a superset of another set *B* if every member of *B* is also a
    /// member of *A*.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     print(employees.isSuperset(of: attendees))
    ///     // Prints "true"
    ///
    /// - Parameter other: Another set.
    /// - Returns: `true` if the set is a superset of `other`; otherwise,
    ///   `false`.
    @inlinable public func isSuperset(of other: Set<Element>) -> Bool

    /// Returns a Boolean value that indicates whether this set has no members in
    /// common with the given set.
    ///
    /// In the following example, the `employees` set is disjoint with the
    /// `visitors` set because no name appears in both sets.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let visitors: Set = ["Marcia", "Nathaniel", "Olivia"]
    ///     print(employees.isDisjoint(with: visitors))
    ///     // Prints "true"
    ///
    /// - Parameter other: Another set.
    /// - Returns: `true` if the set has no elements in common with `other`;
    ///   otherwise, `false`.
    @inlinable public func isDisjoint(with other: Set<Element>) -> Bool

    /// Returns a new set containing the elements of this set that do not occur
    /// in the given set.
    ///
    /// In the following example, the `nonNeighbors` set is made up of the
    /// elements of the `employees` set that are not elements of `neighbors`:
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     let nonNeighbors = employees.subtracting(neighbors)
    ///     print(nonNeighbors)
    ///     // Prints "["Diana", "Chris", "Alicia"]"
    ///
    /// - Parameter other: Another set.
    /// - Returns: A new set.
    @inlinable public func subtracting(_ other: Set<Element>) -> Set<Element>

    /// Returns a Boolean value that indicates whether the set is a strict
    /// superset of the given sequence.
    ///
    /// Set *A* is a strict superset of another set *B* if every member of *B* is
    /// also a member of *A* and *A* contains at least one element that is *not*
    /// a member of *B*.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     print(employees.isStrictSuperset(of: attendees))
    ///     // Prints "true"
    ///     print(employees.isStrictSuperset(of: employees))
    ///     // Prints "false"
    ///
    /// - Parameter other: Another set.
    /// - Returns: `true` if the set is a strict superset of
    ///   `other`; otherwise, `false`.
    @inlinable public func isStrictSuperset(of other: Set<Element>) -> Bool

    /// Returns a Boolean value that indicates whether the set is a strict subset
    /// of the given sequence.
    ///
    /// Set *A* is a strict subset of another set *B* if every member of *A* is
    /// also a member of *B* and *B* contains at least one element that is not a
    /// member of *A*.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     print(attendees.isStrictSubset(of: employees))
    ///     // Prints "true"
    ///
    ///     // A set is never a strict subset of itself:
    ///     print(attendees.isStrictSubset(of: attendees))
    ///     // Prints "false"
    ///
    /// - Parameter other: Another set.
    /// - Returns: `true` if the set is a strict subset of
    ///   `other`; otherwise, `false`.
    @inlinable public func isStrictSubset(of other: Set<Element>) -> Bool

    /// Returns a new set with the elements that are common to both this set and
    /// the given sequence.
    ///
    /// In the following example, the `bothNeighborsAndEmployees` set is made up
    /// of the elements that are in *both* the `employees` and `neighbors` sets.
    /// Elements that are in only one or the other are left out of the result of
    /// the intersection.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     let bothNeighborsAndEmployees = employees.intersection(neighbors)
    ///     print(bothNeighborsAndEmployees)
    ///     // Prints "["Bethany", "Eric"]"
    ///
    /// - Parameter other: Another set.
    /// - Returns: A new set.
    @inlinable public func intersection(_ other: Set<Element>) -> Set<Element>

    /// Removes the elements of the set that are also in the given sequence and
    /// adds the members of the sequence that are not already in the set.
    ///
    /// In the following example, the elements of the `employees` set that are
    /// also members of `neighbors` are removed from `employees`, while the
    /// elements of `neighbors` that are not members of `employees` are added to
    /// `employees`. In particular, the names `"Alicia"`, `"Chris"`, and
    /// `"Diana"` are removed from `employees` while the names `"Forlani"` and
    /// `"Greta"` are added.
    ///
    ///     var employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     employees.formSymmetricDifference(neighbors)
    ///     print(employees)
    ///     // Prints "["Diana", "Chris", "Forlani", "Alicia", "Greta"]"
    ///
    /// - Parameter other: Another set.
    @inlinable public mutating func formSymmetricDifference(_ other: Set<Element>)

    /// The position of an element in a set.
    public struct Index {
    }

    /// An iterator over the members of a `Set<Element>`.
    public struct Iterator {
    }

    /// Removes and returns the first element of the set.
    ///
    /// Because a set is not an ordered collection, the "first" element may not
    /// be the first element that was added to the set.
    ///
    /// - Returns: A member of the set. If the set is empty, returns `nil`.
    @inlinable public mutating func popFirst() -> Element?

    /// The total number of elements that the set can contain without
    /// allocating new storage.
    @inlinable public var capacity: Int { get }

    /// Reserves enough space to store the specified number of elements.
    ///
    /// If you are adding a known number of elements to a set, use this
    /// method to avoid multiple reallocations. This method ensures that the
    /// set has unique, mutable, contiguous storage, with space allocated
    /// for at least the requested number of elements.
    ///
    /// Calling the `reserveCapacity(_:)` method on a set with bridged
    /// storage triggers a copy to contiguous storage even if the existing
    /// storage has room to store `minimumCapacity` elements.
    ///
    /// - Parameter minimumCapacity: The requested number of elements to
    ///   store.
    public mutating func reserveCapacity(_ minimumCapacity: Int)

    @inlinable public mutating func insert<ConcreteElement>(_ newMember: ConcreteElement) -> (inserted: Bool, memberAfterInsert: ConcreteElement) where ConcreteElement : Hashable

    @inlinable public mutating func update<ConcreteElement>(with newMember: ConcreteElement) -> ConcreteElement? where ConcreteElement : Hashable

    @inlinable public mutating func remove<ConcreteElement>(_ member: ConcreteElement) -> ConcreteElement? where ConcreteElement : Hashable

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    @inlinable public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]

    /// Returns a subsequence containing all but the given number of initial
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in
    /// the collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropFirst(2))
    ///     // Prints "[3, 4, 5]"
    ///     print(numbers.dropFirst(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop from the beginning of
    ///   the collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence starting after the specified number of
    ///   elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to drop from the beginning of the collection.
    @inlinable public func dropFirst(_ k: Int = 1) -> Slice<Set<Element>>

    /// Returns a subsequence containing all but the specified number of final
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in the
    /// collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropLast(2))
    ///     // Prints "[1, 2, 3]"
    ///     print(numbers.dropLast(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop off the end of the
    ///   collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence that leaves off the specified number of elements
    ///   at the end.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func dropLast(_ k: Int = 1) -> Slice<Set<Element>>

    /// Returns a subsequence by skipping elements while `predicate` returns
    /// `true` and returning the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be skipped or `false` if it should be included. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func drop(while predicate: (Element) throws -> Bool) rethrows -> Slice<Set<Element>>

    /// Returns a subsequence, up to the specified maximum length, containing
    /// the initial elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.prefix(2))
    ///     // Prints "[1, 2]"
    ///     print(numbers.prefix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return.
    ///   `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence starting at the beginning of this collection
    ///   with at most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to select from the beginning of the collection.
    @inlinable public func prefix(_ maxLength: Int) -> Slice<Set<Element>>

    /// Returns a subsequence containing the initial elements until `predicate`
    /// returns `false` and skipping the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be included or `false` if it should be excluded. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func prefix(while predicate: (Element) throws -> Bool) rethrows -> Slice<Set<Element>>

    /// Returns a subsequence, up to the given maximum length, containing the
    /// final elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.suffix(2))
    ///     // Prints "[4, 5]"
    ///     print(numbers.suffix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return. The
    ///   value of `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence terminating at the end of the collection with at
    ///   most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func suffix(_ maxLength: Int) -> Slice<Set<Element>>

    /// Returns a subsequence from the start of the collection up to, but not
    /// including, the specified position.
    ///
    /// The resulting subsequence *does not include* the element at the position
    /// `end`. The following example searches for the index of the number `40`
    /// in an array of integers, and then prints the prefix of the array up to,
    /// but not including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(upTo: i))
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// Passing the collection's starting index as the `end` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.prefix(upTo: numbers.startIndex))
    ///     // Prints "[]"
    ///
    /// Using the `prefix(upTo:)` method is equivalent to using a partial
    /// half-open range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(upTo:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[..<i])
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// - Parameter end: The "past the end" index of the resulting subsequence.
    ///   `end` must be a valid index of the collection.
    /// - Returns: A subsequence up to, but not including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(upTo end: Set<Element>.Index) -> Slice<Set<Element>>

    /// Returns a subsequence from the specified position to the end of the
    /// collection.
    ///
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the suffix of the array starting at
    /// that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.suffix(from: i))
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// Passing the collection's `endIndex` as the `start` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.suffix(from: numbers.endIndex))
    ///     // Prints "[]"
    ///
    /// Using the `suffix(from:)` method is equivalent to using a partial range
    /// from the index as the collection's subscript. The subscript notation is
    /// preferred over `suffix(from:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[i...])
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// - Parameter start: The index at which to start the resulting subsequence.
    ///   `start` must be a valid index of the collection.
    /// - Returns: A subsequence starting at the `start` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func suffix(from start: Set<Element>.Index) -> Slice<Set<Element>>

    /// Returns a subsequence from the start of the collection through the
    /// specified position.
    ///
    /// The resulting subsequence *includes* the element at the position `end`.
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the prefix of the array up to, and
    /// including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(through: i))
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// Using the `prefix(through:)` method is equivalent to using a partial
    /// closed range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(through:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[...i])
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// - Parameter end: The index of the last element to include in the
    ///   resulting subsequence. `end` must be a valid index of the collection
    ///   that is not equal to the `endIndex` property.
    /// - Returns: A subsequence up to, and including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(through position: Set<Element>.Index) -> Slice<Set<Element>>

    /// Returns the longest possible subsequences of the collection, in order,
    /// that don't contain elements satisfying the given predicate.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the sequence are not returned as part of
    /// any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string using a
    /// closure that matches spaces. The first use of `split` returns each word
    /// that was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(maxSplits: 1, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(omittingEmptySubsequences: false, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - maxSplits: The maximum number of times to split the collection, or
    ///     one less than the number of subsequences to return. If
    ///     `maxSplits + 1` subsequences are returned, the last one is a suffix
    ///     of the original collection containing the remaining elements.
    ///     `maxSplits` must be greater than or equal to zero. The default value
    ///     is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each pair of consecutive elements
    ///     satisfying the `isSeparator` predicate and for each element at the
    ///     start or end of the collection satisfying the `isSeparator`
    ///     predicate. The default value is `true`.
    ///   - isSeparator: A closure that takes an element as an argument and
    ///     returns a Boolean value indicating whether the collection should be
    ///     split at that element.
    /// - Returns: An array of subsequences, split from this collection's
    ///   elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Element) throws -> Bool) rethrows -> [Slice<Set<Element>>]

    /// Returns the first index in which an element of the collection satisfies
    /// the given predicate.
    ///
    /// You can use the predicate to find an element of a type that doesn't
    /// conform to the `Equatable` protocol or to find an element that matches
    /// particular criteria. Here's an example that finds a student name that
    /// begins with the letter "A":
    ///
    ///     let students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     if let i = students.firstIndex(where: { $0.hasPrefix("A") }) {
    ///         print("\(students[i]) starts with 'A'!")
    ///     }
    ///     // Prints "Abena starts with 'A'!"
    ///
    /// - Parameter predicate: A closure that takes an element as its argument
    ///   and returns a Boolean value that indicates whether the passed element
    ///   represents a match.
    /// - Returns: The index of the first element for which `predicate` returns
    ///   `true`. If no elements in the collection satisfy the given predicate,
    ///   returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Set<Element>.Index?

    /// Returns the elements of the sequence, shuffled using the given generator
    /// as a source for randomness.
    ///
    /// You use this method to randomize the elements of a sequence when you are
    /// using a custom random number generator. For example, you can shuffle the
    /// numbers between `0` and `9` by calling the `shuffled(using:)` method on
    /// that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled(using: &myGenerator)
    ///     // shuffledNumbers == [8, 9, 4, 3, 2, 6, 7, 0, 5, 1]
    ///
    /// - Parameter generator: The random number generator to use when shuffling
    ///   the sequence.
    /// - Returns: An array of this sequence's elements in a shuffled order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    /// - Note: The algorithm used to shuffle a sequence may change in a future
    ///   version of Swift. If you're passing a generator that results in the
    ///   same shuffled order each time you run your program, that sequence may
    ///   change when your program is compiled using a different version of
    ///   Swift.
    @inlinable public func shuffled<T>(using generator: inout T) -> [Element] where T : RandomNumberGenerator

    /// Returns the elements of the sequence, shuffled.
    ///
    /// For example, you can shuffle the numbers between `0` and `9` by calling
    /// the `shuffled()` method on that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled()
    ///     // shuffledNumbers == [1, 7, 6, 2, 8, 9, 4, 3, 5, 0]
    ///
    /// This method is equivalent to calling `shuffled(using:)`, passing in the
    /// system's default random generator.
    ///
    /// - Returns: A shuffled array of this sequence's elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func shuffled() -> [Element]

    public static func != (lhs: Set<Element>, rhs: Set<Element>) -> Bool

    /// The indices that are valid for subscripting the collection, in ascending
    /// order.
    ///
    /// A collection's `indices` property can hold a strong reference to the
    /// collection itself, causing the collection to be non-uniquely referenced.
    /// If you mutate the collection while iterating over its indices, a strong
    /// reference can cause an unexpected copy of the collection. To avoid the
    /// unexpected copy, use the `index(after:)` method starting with
    /// `startIndex` to produce indices instead.
    ///
    ///     var c = MyFancyCollection([10, 20, 30, 40, 50])
    ///     var i = c.startIndex
    ///     while i != c.endIndex {
    ///         c[i] /= 5
    ///         i = c.index(after: i)
    ///     }
    ///     // c == MyFancyCollection([2, 4, 6, 8, 10])
    @inlinable public var indices: DefaultIndices<Set<Element>> { get }

    /// A sequence containing the same elements as this sequence,
    /// but on which some operations, such as `map` and `filter`, are
    /// implemented lazily.
    @inlinable public var lazy: LazySequence<Set<Element>> { get }

    @available(swift, deprecated: 4.1, renamed: "compactMap(_:)", message: "Please use compactMap(_:) for the case where closure returns an optional value")
    public func flatMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Accesses the contiguous subrange of the collection's elements specified
    /// by a range expression.
    ///
    /// The range expression is converted to a concrete subrange relative to this
    /// collection. For example, using a `PartialRangeFrom` range expression
    /// with an array accesses the subrange from the start of the range
    /// expression until the end of the array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2...]
    ///     print(streetsSlice)
    ///     // ["Channing", "Douglas", "Evarts"]
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection uses. This example searches `streetsSlice` for one
    /// of the strings in the slice, and then uses that index in the original
    /// array.
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // "Evarts"
    ///
    /// Always use the slice's `startIndex` property instead of assuming that its
    /// indices start at a particular value. Attempting to access an element by
    /// using an index outside the bounds of the slice's indices may result in a
    /// runtime error, even if that index is valid for the original collection.
    ///
    ///     print(streetsSlice.startIndex)
    ///     // 2
    ///     print(streetsSlice[2])
    ///     // "Channing"
    ///
    ///     print(streetsSlice[0])
    ///     // error: Index out of bounds
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript<R>(r: R) -> Slice<Set<Element>> where R : RangeExpression, Self.Index == R.Bound { get }

    @inlinable public subscript(x: (UnboundedRange_) -> ()) -> Slice<Set<Element>> { get }

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]

    /// A value less than or equal to the number of elements in the sequence,
    /// calculated nondestructively.
    ///
    /// The default implementation returns 0. If you provide your own
    /// implementation, make sure to compute the value nondestructively.
    ///
    /// - Complexity: O(1), except if the sequence also conforms to `Collection`.
    ///   In this case, see the documentation of `Collection.underestimatedCount`.
    @inlinable public var underestimatedCount: Int { get }

    /// Calls the given closure on each element in the sequence in the same order
    /// as a `for`-`in` loop.
    ///
    /// The two loops in the following example produce the same output:
    ///
    ///     let numberWords = ["one", "two", "three"]
    ///     for word in numberWords {
    ///         print(word)
    ///     }
    ///     // Prints "one"
    ///     // Prints "two"
    ///     // Prints "three"
    ///
    ///     numberWords.forEach { word in
    ///         print(word)
    ///     }
    ///     // Same as above
    ///
    /// Using the `forEach` method is distinct from a `for`-`in` loop in two
    /// important ways:
    ///
    /// 1. You cannot use a `break` or `continue` statement to exit the current
    ///    call of the `body` closure or skip subsequent calls.
    /// 2. Using the `return` statement in the `body` closure will exit only from
    ///    the current call to `body`, not from any outer scope, and won't skip
    ///    subsequent calls.
    ///
    /// - Parameter body: A closure that takes an element of the sequence as a
    ///   parameter.
    @inlinable public func forEach(_ body: (Element) throws -> Void) rethrows

    /// Returns the first element of the sequence that satisfies the given
    /// predicate.
    ///
    /// The following example uses the `first(where:)` method to find the first
    /// negative number in an array of integers:
    ///
    ///     let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
    ///     if let firstNegative = numbers.first(where: { $0 < 0 }) {
    ///         print("The first negative number is \(firstNegative).")
    ///     }
    ///     // Prints "The first negative number is -2."
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence as
    ///   its argument and returns a Boolean value indicating whether the
    ///   element is a match.
    /// - Returns: The first element of the sequence that satisfies `predicate`,
    ///   or `nil` if there is no element that satisfies `predicate`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func first(where predicate: (Element) throws -> Bool) rethrows -> Element?

    /// Call `body(p)`, where `p` is a pointer to the collection's
    /// contiguous storage.  If no such storage exists, it is
    /// first created.  If the collection does not support an internal
    /// representation in a form of contiguous storage, `body` is not
    /// called and `nil` is returned.
    ///
    /// A `Collection` that provides its own implementation of this method
    /// must also guarantee that an equivalent buffer of its `SubSequence`
    /// can be generated by advancing the pointer by the distance to the
    /// slice's `startIndex`.
    @inlinable public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R?

    /// Returns a sequence of pairs (*n*, *x*), where *n* represents a
    /// consecutive integer starting at zero and *x* represents an element of
    /// the sequence.
    ///
    /// This example enumerates the characters of the string "Swift" and prints
    /// each character along with its place in the string.
    ///
    ///     for (n, c) in "Swift".enumerated() {
    ///         print("\(n): '\(c)'")
    ///     }
    ///     // Prints "0: 'S'"
    ///     // Prints "1: 'w'"
    ///     // Prints "2: 'i'"
    ///     // Prints "3: 'f'"
    ///     // Prints "4: 't'"
    ///
    /// When you enumerate a collection, the integer part of each pair is a counter
    /// for the enumeration, but is not necessarily the index of the paired value.
    /// These counters can be used as indices only in instances of zero-based,
    /// integer-indexed collections, such as `Array` and `ContiguousArray`. For
    /// other collections the counters may be out of range or of the wrong type
    /// to use as an index. To iterate over the elements of a collection with its
    /// indices, use the `zip(_:_:)` function.
    ///
    /// This example iterates over the indices and elements of a set, building a
    /// list consisting of indices of names with five or fewer letters.
    ///
    ///     let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     var shorterIndices: [Set<String>.Index] = []
    ///     for (i, name) in zip(names.indices, names) {
    ///         if name.count <= 5 {
    ///             shorterIndices.append(i)
    ///         }
    ///     }
    ///
    /// Now that the `shorterIndices` array holds the indices of the shorter
    /// names in the `names` set, you can use those indices to access elements in
    /// the set.
    ///
    ///     for i in shorterIndices {
    ///         print(names[i])
    ///     }
    ///     // Prints "Sofia"
    ///     // Prints "Mateo"
    ///
    /// - Returns: A sequence of pairs enumerating the sequence.
    ///
    /// - Complexity: O(1)
    @inlinable public func enumerated() -> EnumeratedSequence<Set<Element>>

    /// Returns the minimum element in the sequence, using the given predicate as
    /// the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `min(by:)` method on a
    /// dictionary to find the key-value pair with the lowest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let leastHue = hues.min { a, b in a.value < b.value }
    ///     print(leastHue)
    ///     // Prints "Optional(("Coral", 16))"
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true`
    ///   if its first argument should be ordered before its second
    ///   argument; otherwise, `false`.
    /// - Returns: The sequence's minimum element, according to
    ///   `areInIncreasingOrder`. If the sequence has no elements, returns
    ///   `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element?

    /// Returns the maximum element in the sequence, using the given predicate
    /// as the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `max(by:)` method on a
    /// dictionary to find the key-value pair with the highest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let greatestHue = hues.max { a, b in a.value < b.value }
    ///     print(greatestHue)
    ///     // Prints "Optional(("Heliotrope", 296))"
    ///
    /// - Parameter areInIncreasingOrder:  A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: The sequence's maximum element if the sequence is not empty;
    ///   otherwise, `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element?

    /// Returns a Boolean value indicating whether the initial elements of the
    /// sequence are equivalent to the elements in another sequence, using
    /// the given predicate as the equivalence test.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - possiblePrefix: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if the initial elements of the sequence are equivalent
    ///   to the elements of `possiblePrefix`; otherwise, `false`. If
    ///   `possiblePrefix` has no elements, the return value is `true`.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `possiblePrefix`.
    @inlinable public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: (Element, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool where PossiblePrefix : Sequence

    /// Returns a Boolean value indicating whether this sequence and another
    /// sequence contain equivalent elements in the same order, using the given
    /// predicate as the equivalence test.
    ///
    /// At least one of the sequences must be finite.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if this sequence and `other` contain equivalent items,
    ///   using `areEquivalent` as the equivalence test; otherwise, `false.`
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: (Element, OtherSequence.Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence

    /// Returns a Boolean value indicating whether the sequence precedes another
    /// sequence in a lexicographical (dictionary) ordering, using the given
    /// predicate to compare elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areInIncreasingOrder:  A predicate that returns `true` if its first
    ///     argument should be ordered before its second argument; otherwise,
    ///     `false`.
    /// - Returns: `true` if this sequence precedes `other` in a dictionary
    ///   ordering as ordered by `areInIncreasingOrder`; otherwise, `false`.
    ///
    /// - Note: This method implements the mathematical notion of lexicographical
    ///   ordering, which has no connection to Unicode.  If you are sorting
    ///   strings to present to the end user, use `String` APIs that perform
    ///   localized comparison instead.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns a Boolean value indicating whether the sequence contains an
    /// element that satisfies the given predicate.
    ///
    /// You can use the predicate to check for an element of a type that
    /// doesn't conform to the `Equatable` protocol, such as the
    /// `HTTPResponse` enumeration in this example.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let lastThreeResponses: [HTTPResponse] = [.ok, .ok, .error(404)]
    ///     let hadError = lastThreeResponses.contains { element in
    ///         if case .error = element {
    ///             return true
    ///         } else {
    ///             return false
    ///         }
    ///     }
    ///     // 'hadError' == true
    ///
    /// Alternatively, a predicate can be satisfied by a range of `Equatable`
    /// elements or a general condition. This example shows how you can check an
    /// array for an expense greater than $100.
    ///
    ///     let expenses = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
    ///     let hasBigPurchase = expenses.contains { $0 > 100 }
    ///     // 'hasBigPurchase' == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element represents a match.
    /// - Returns: `true` if the sequence contains an element that satisfies
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool

    /// Returns a Boolean value indicating whether every element of a sequence
    /// satisfies a given predicate.
    ///
    /// The following code uses this method to test whether all the names in an
    /// array have at least five characters:
    ///
    ///     let names = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     let allHaveAtLeastFive = names.allSatisfy({ $0.count >= 5 })
    ///     // allHaveAtLeastFive == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element satisfies a condition.
    /// - Returns: `true` if the sequence contains only elements that satisfy
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(_:_:)` method to produce a single value from the elements
    /// of an entire sequence. For example, you can use this method on an array
    /// of numbers to find their sum or product.
    ///
    /// The `nextPartialResult` closure is called sequentially with an
    /// accumulating value initialized to `initialResult` and each element of
    /// the sequence. This example shows how to find the sum of an array of
    /// numbers.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///     let numberSum = numbers.reduce(0, { x, y in
    ///         x + y
    ///     })
    ///     // numberSum == 10
    ///
    /// When `numbers.reduce(_:_:)` is called, the following steps occur:
    ///
    /// 1. The `nextPartialResult` closure is called with `initialResult`---`0`
    ///    in this case---and the first element of `numbers`, returning the sum:
    ///    `1`.
    /// 2. The closure is called again repeatedly with the previous call's return
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the last value returned from the
    ///    closure is returned to the caller.
    ///
    /// If the sequence has no elements, `nextPartialResult` is never executed
    /// and `initialResult` is the result of the call to `reduce(_:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(into:_:)` method to produce a single value from the
    /// elements of an entire sequence. For example, you can use this method on an
    /// array of integers to filter adjacent equal entries or count frequencies.
    ///
    /// This method is preferred over `reduce(_:_:)` for efficiency when the
    /// result is a copy-on-write type, for example an Array or a Dictionary.
    ///
    /// The `updateAccumulatingResult` closure is called sequentially with a
    /// mutable accumulating value initialized to `initialResult` and each element
    /// of the sequence. This example shows how to build a dictionary of letter
    /// frequencies of a string.
    ///
    ///     let letters = "abracadabra"
    ///     let letterCount = letters.reduce(into: [:]) { counts, letter in
    ///         counts[letter, default: 0] += 1
    ///     }
    ///     // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]
    ///
    /// When `letters.reduce(into:_:)` is called, the following steps occur:
    ///
    /// 1. The `updateAccumulatingResult` closure is called with the initial
    ///    accumulating value---`[:]` in this case---and the first character of
    ///    `letters`, modifying the accumulating value by setting `1` for the key
    ///    `"a"`.
    /// 2. The closure is called again repeatedly with the updated accumulating
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the accumulating value is returned to
    ///    the caller.
    ///
    /// If the sequence has no elements, `updateAccumulatingResult` is never
    /// executed and `initialResult` is the result of the call to
    /// `reduce(into:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element of the sequence.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Element) throws -> ()) rethrows -> Result

    /// Returns an array containing the elements of this sequence in reverse
    /// order.
    ///
    /// The sequence must be finite.
    ///
    /// - Returns: An array containing the elements of this sequence in
    ///   reverse order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reversed() -> [Element]

    /// Returns an array containing the concatenated results of calling the
    /// given transformation with each element of this sequence.
    ///
    /// Use this method to receive a single-level collection when your
    /// transformation produces a sequence or collection for each element.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `flatMap` with a transformation that returns an array.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///
    ///     let mapped = numbers.map { Array(repeating: $0, count: $0) }
    ///     // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
    ///
    ///     let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
    ///     // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    ///
    /// In fact, `s.flatMap(transform)`  is equivalent to
    /// `Array(s.map(transform).joined())`.
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns a sequence or collection.
    /// - Returns: The resulting flattened array.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func flatMap<SegmentOfResult>(_ transform: (Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence

    /// Returns an array containing the non-`nil` results of calling the given
    /// transformation with each element of this sequence.
    ///
    /// Use this method to receive an array of non-optional values when your
    /// transformation produces an optional value.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `compactMap` with a transformation that returns an optional `Int` value.
    ///
    ///     let possibleNumbers = ["1", "2", "three", "///4///", "5"]
    ///
    ///     let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
    ///     // [1, 2, nil, nil, 5]
    ///
    ///     let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
    ///     // [1, 2, 5]
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns an optional value.
    /// - Returns: An array of the non-`nil` results of calling `transform`
    ///   with each element of the sequence.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Creates a set containing the elements of the given array literal.
    ///
    /// Do not call this initializer directly. It is used by the compiler when
    /// you use an array literal. Instead, create a new set using an array
    /// literal as its value by enclosing a comma-separated list of values in
    /// square brackets. You can use an array literal anywhere a set is expected
    /// by the type context.
    ///
    /// Here, a set of strings is created from an array literal holding only
    /// strings:
    ///
    ///     let ingredients: Set = ["cocoa beans", "sugar", "cocoa butter", "salt"]
    ///     if ingredients.isSuperset(of: ["sugar", "salt"]) {
    ///         print("Whatever it is, it's bound to be delicious!")
    ///     }
    ///     // Prints "Whatever it is, it's bound to be delicious!"
    ///
    /// - Parameter arrayLiteral: A list of elements of the new set.
    @inlinable public init(arrayLiteral: Element...)

    /// Returns the elements of the sequence, sorted using the given predicate as
    /// the comparison between elements.
    ///
    /// When you want to sort a sequence of elements that don't conform to the
    /// `Comparable` protocol, pass a predicate to this method that returns
    /// `true` when the first element should be ordered before the second. The
    /// elements of the resulting array are ordered according to the given
    /// predicate.
    ///
    /// In the following example, the predicate provides an ordering for an array
    /// of a custom `HTTPResponse` type. The predicate orders errors before
    /// successes and sorts the error responses by their error code.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]
    ///     let sortedResponses = responses.sorted {
    ///         switch ($0, $1) {
    ///         // Order errors by code
    ///         case let (.error(aCode), .error(bCode)):
    ///             return aCode < bCode
    ///
    ///         // All successes are equivalent, so none is before any other
    ///         case (.ok, .ok): return false
    ///
    ///         // Order errors before successes
    ///         case (.error, .ok): return true
    ///         case (.ok, .error): return false
    ///         }
    ///     }
    ///     print(sortedResponses)
    ///     // Prints "[.error(403), .error(404), .error(500), .ok, .ok]"
    ///
    /// You also use this method to sort elements that conform to the
    /// `Comparable` protocol in descending order. To sort your sequence in
    /// descending order, pass the greater-than operator (`>`) as the
    /// `areInIncreasingOrder` parameter.
    ///
    ///     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     let descendingStudents = students.sorted(by: >)
    ///     print(descendingStudents)
    ///     // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"
    ///
    /// Calling the related `sorted()` method is equivalent to calling this
    /// method and passing the less-than operator (`<`) as the predicate.
    ///
    ///     print(students.sorted())
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///     print(students.sorted(by: <))
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also `true`.
    ///   (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// The sorting algorithm is not guaranteed to be stable. A stable sort
    /// preserves the relative order of elements for which
    /// `areInIncreasingOrder` does not establish an order.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: A sorted array of the sequence's elements.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    @inlinable public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element]
}

/// `SetAlgebra` requirements for which default implementations
/// are supplied.
///
/// - Note: A type conforming to `SetAlgebra` can implement any of
///   these initializers or methods, and those implementations will be
///   used in lieu of these defaults.
extension Set {

    /// Creates a new set from a finite sequence of items.
    ///
    /// Use this initializer to create a new set from an existing sequence, like
    /// an array or a range:
    ///
    ///     let validIndices = Set(0..<7).subtracting([2, 4, 5])
    ///     print(validIndices)
    ///     // Prints "[6, 0, 1, 3]"
    ///
    /// - Parameter sequence: The elements to use as members of the new set.
    @inlinable public init<S>(_ sequence: S) where S : Sequence, Self.Element == S.Element

    /// Removes the elements of the given set from this set.
    ///
    /// In the following example, the elements of the `employees` set that are
    /// also members of the `neighbors` set are removed. In particular, the
    /// names `"Bethany"` and `"Eric"` are removed from `employees`.
    ///
    ///     var employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     employees.subtract(neighbors)
    ///     print(employees)
    ///     // Prints "["Diana", "Chris", "Alicia"]"
    ///
    /// - Parameter other: A set of the same type as the current set.
    @inlinable public mutating func subtract(_ other: Set<Element>)

    /// A Boolean value that indicates whether the set has no elements.
    @inlinable public var isEmpty: Bool { get }
}

/// Default implementations of core requirements
extension Set {

    /// A Boolean value indicating whether the collection is empty.
    ///
    /// When you need to check whether your collection is empty, use the
    /// `isEmpty` property instead of checking that the `count` property is
    /// equal to zero. For collections that don't conform to
    /// `RandomAccessCollection`, accessing the `count` property iterates
    /// through the elements of the collection.
    ///
    ///     let horseName = "Silver"
    ///     if horseName.isEmpty {
    ///         print("I've been through the desert on a horse with no name.")
    ///     } else {
    ///         print("Hi ho, \(horseName)!")
    ///     }
    ///     // Prints "Hi ho, Silver!")
    ///
    /// - Complexity: O(1)
    @inlinable public var isEmpty: Bool { get }

    /// The first element of the collection.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let firstNumber = numbers.first {
    ///         print(firstNumber)
    ///     }
    ///     // Prints "10"
    @inlinable public var first: Element? { get }

    /// A value less than or equal to the number of elements in the collection.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var underestimatedCount: Int { get }

    /// The number of elements in the collection.
    ///
    /// To check whether a collection is empty, use its `isEmpty` property
    /// instead of comparing `count` to zero. Unless the collection guarantees
    /// random-access performance, calculating `count` can be an O(*n*)
    /// operation.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var count: Int { get }
}

/// Supply the default "slicing" `subscript` for `Collection` models
/// that accept the default associated `SubSequence`, `Slice<Self>`.
extension Set {

    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection. Always use the slice's `startIndex` property
    /// instead of assuming that its indices start at a particular value.
    ///
    /// This example demonstrates getting a slice of an array of strings, finding
    /// the index of one of the strings in the slice, and then using that index
    /// in the original array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2 ..< streets.endIndex]
    ///     print(streetsSlice)
    ///     // Prints "["Channing", "Douglas", "Evarts"]"
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // Prints "Evarts"
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript(bounds: Range<Set<Element>.Index>) -> Slice<Set<Element>> { get }
}

/// Default implementation for forward collections.
extension Set {

    /// Returns an index that is the specified distance from the given index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    ///
    ///     let s = "Swift"
    ///     let i = s.index(s.startIndex, offsetBy: 4)
    ///     print(s[i])
    ///     // Prints "t"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    /// - Returns: An index offset by `distance` from the index `i`. If
    ///   `distance` is positive, this is the same value as the result of
    ///   `distance` calls to `index(after:)`. If `distance` is negative, this
    ///   is the same value as the result of `abs(distance)` calls to
    ///   `index(before:)`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Set<Element>.Index, offsetBy distance: Int) -> Set<Element>.Index

    /// Returns an index that is the specified distance from the given index,
    /// unless that distance is beyond a given limiting index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    /// The operation doesn't require going beyond the limiting `s.endIndex`
    /// value, so it succeeds.
    ///
    ///     let s = "Swift"
    ///     if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    ///         print(s[i])
    ///     }
    ///     // Prints "t"
    ///
    /// The next example attempts to retrieve an index six positions from
    /// `s.startIndex` but fails, because that distance is beyond the index
    /// passed as `limit`.
    ///
    ///     let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
    ///     print(j)
    ///     // Prints "nil"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: An index offset by `distance` from the index `i`, unless that
    ///   index would be beyond `limit` in the direction of movement. In that
    ///   case, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Set<Element>.Index, offsetBy distance: Int, limitedBy limit: Set<Element>.Index) -> Set<Element>.Index?

    /// Offsets the given index by the specified distance.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Set<Element>.Index, offsetBy distance: Int)

    /// Offsets the given index by the specified distance, or so that it equals
    /// the given limiting index.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: `true` if `i` has been offset by exactly `distance` steps
    ///   without going beyond `limit`; otherwise, `false`. When the return
    ///   value is `false`, the value of `i` is equal to `limit`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Set<Element>.Index, offsetBy distance: Int, limitedBy limit: Set<Element>.Index) -> Bool

    /// Returns the distance between two indices.
    ///
    /// Unless the collection conforms to the `BidirectionalCollection` protocol,
    /// `start` must be less than or equal to `end`.
    ///
    /// - Parameters:
    ///   - start: A valid index of the collection.
    ///   - end: Another valid index of the collection. If `end` is equal to
    ///     `start`, the result is zero.
    /// - Returns: The distance between `start` and `end`. The result can be
    ///   negative only if the collection conforms to the
    ///   `BidirectionalCollection` protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the
    ///   resulting distance.
    @inlinable public func distance(from start: Set<Element>.Index, to end: Set<Element>.Index) -> Int

    /// Returns a random element of the collection, using the given generator as
    /// a source for randomness.
    ///
    /// Call `randomElement(using:)` to select a random element from an array or
    /// another collection when you are using a custom random number generator.
    /// This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement(using: &myGenerator)!
    ///     // randomName == "Amani"
    ///
    /// - Parameter generator: The random number generator to use when choosing a
    ///   random element.
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    /// - Note: The algorithm used to select a random element may change in a
    ///   future version of Swift. If you're passing a generator that results in
    ///   the same sequence of elements each time you run your program, that
    ///   sequence may change when your program is compiled using a different
    ///   version of Swift.
    @inlinable public func randomElement<T>(using generator: inout T) -> Element? where T : RandomNumberGenerator

    /// Returns a random element of the collection.
    ///
    /// Call `randomElement()` to select a random element from an array or
    /// another collection. This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement()!
    ///     // randomName == "Amani"
    ///
    /// This method is equivalent to calling `randomElement(using:)`, passing in
    /// the system's default random generator.
    ///
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public func randomElement() -> Element?
}

extension Set : CustomReflectable {

    /// A mirror that reflects the set.
    public var customMirror: Mirror { get }
}

extension Set : ExpressibleByArrayLiteral {

    /// Creates a set containing the elements of the given array literal.
    ///
    /// Do not call this initializer directly. It is used by the compiler when
    /// you use an array literal. Instead, create a new set using an array
    /// literal as its value by enclosing a comma-separated list of values in
    /// square brackets. You can use an array literal anywhere a set is expected
    /// by the type context.
    ///
    /// Here, a set of strings is created from an array literal holding only
    /// strings.
    ///
    ///     let ingredients: Set = ["cocoa beans", "sugar", "cocoa butter", "salt"]
    ///     if ingredients.isSuperset(of: ["sugar", "salt"]) {
    ///         print("Whatever it is, it's bound to be delicious!")
    ///     }
    ///     // Prints "Whatever it is, it's bound to be delicious!"
    ///
    /// - Parameter elements: A variadic list of elements of the new set.
    @inlinable public init(arrayLiteral elements: Element...)

    /// The type of the elements of an array literal.
    public typealias ArrayLiteralElement = Element
}

extension Set : SetAlgebra {

    /// Inserts the given element in the set if it is not already present.
    ///
    /// If an element equal to `newMember` is already contained in the set, this
    /// method has no effect. In the following example, a new element is
    /// inserted into `classDays`, a set of days of the week. When an existing
    /// element is inserted, the `classDays` set does not change.
    ///
    ///     enum DayOfTheWeek: Int {
    ///         case sunday, monday, tuesday, wednesday, thursday,
    ///             friday, saturday
    ///     }
    ///
    ///     var classDays: Set<DayOfTheWeek> = [.wednesday, .friday]
    ///     print(classDays.insert(.monday))
    ///     // Prints "(true, .monday)"
    ///     print(classDays)
    ///     // Prints "[.friday, .wednesday, .monday]"
    ///
    ///     print(classDays.insert(.friday))
    ///     // Prints "(false, .friday)"
    ///     print(classDays)
    ///     // Prints "[.friday, .wednesday, .monday]"
    ///
    /// - Parameter newMember: An element to insert into the set.
    /// - Returns: `(true, newMember)` if `newMember` was not contained in the
    ///   set. If an element equal to `newMember` was already contained in the
    ///   set, the method returns `(false, oldMember)`, where `oldMember` is the
    ///   element that was equal to `newMember`. In some cases, `oldMember` may
    ///   be distinguishable from `newMember` by identity comparison or some
    ///   other means.
    @inlinable public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element)

    /// Inserts the given element into the set unconditionally.
    ///
    /// If an element equal to `newMember` is already contained in the set,
    /// `newMember` replaces the existing element. In this example, an existing
    /// element is inserted into `classDays`, a set of days of the week.
    ///
    ///     enum DayOfTheWeek: Int {
    ///         case sunday, monday, tuesday, wednesday, thursday,
    ///             friday, saturday
    ///     }
    ///
    ///     var classDays: Set<DayOfTheWeek> = [.monday, .wednesday, .friday]
    ///     print(classDays.update(with: .monday))
    ///     // Prints "Optional(.monday)"
    ///
    /// - Parameter newMember: An element to insert into the set.
    /// - Returns: An element equal to `newMember` if the set already contained
    ///   such a member; otherwise, `nil`. In some cases, the returned element
    ///   may be distinguishable from `newMember` by identity comparison or some
    ///   other means.
    @inlinable public mutating func update(with newMember: Element) -> Element?

    /// Removes the specified element from the set.
    ///
    /// This example removes the element `"sugar"` from a set of ingredients.
    ///
    ///     var ingredients: Set = ["cocoa beans", "sugar", "cocoa butter", "salt"]
    ///     let toRemove = "sugar"
    ///     if let removed = ingredients.remove(toRemove) {
    ///         print("The recipe is now \(removed)-free.")
    ///     }
    ///     // Prints "The recipe is now sugar-free."
    ///
    /// - Parameter member: The element to remove from the set.
    /// - Returns: The value of the `member` parameter if it was a member of the
    ///   set; otherwise, `nil`.
    @inlinable public mutating func remove(_ member: Element) -> Element?

    /// Removes the element at the given index of the set.
    ///
    /// - Parameter position: The index of the member to remove. `position` must
    ///   be a valid index of the set, and must not be equal to the set's end
    ///   index.
    /// - Returns: The element that was removed from the set.
    @inlinable public mutating func remove(at position: Set<Element>.Index) -> Element

    /// Removes all members from the set.
    ///
    /// - Parameter keepingCapacity: If `true`, the set's buffer capacity is
    ///   preserved; if `false`, the underlying buffer is released. The
    ///   default is `false`.
    @inlinable public mutating func removeAll(keepingCapacity keepCapacity: Bool = false)

    /// Removes the first element of the set.
    ///
    /// Because a set is not an ordered collection, the "first" element may not
    /// be the first element that was added to the set. The set must not be
    /// empty.
    ///
    /// - Complexity: Amortized O(1) if the set does not wrap a bridged `NSSet`.
    ///   If the set wraps a bridged `NSSet`, the performance is unspecified.
    ///
    /// - Returns: A member of the set.
    @inlinable public mutating func removeFirst() -> Element

    /// Creates an empty set.
    ///
    /// This is equivalent to initializing with an empty array literal. For
    /// example:
    ///
    ///     var emptySet = Set<Int>()
    ///     print(emptySet.isEmpty)
    ///     // Prints "true"
    ///
    ///     emptySet = []
    ///     print(emptySet.isEmpty)
    ///     // Prints "true"
    @inlinable public init()

    /// Creates a new set from a finite sequence of items.
    ///
    /// Use this initializer to create a new set from an existing sequence, for
    /// example, an array or a range.
    ///
    ///     let validIndices = Set(0..<7).subtracting([2, 4, 5])
    ///     print(validIndices)
    ///     // Prints "[6, 0, 1, 3]"
    ///
    /// This initializer can also be used to restore set methods after performing
    /// sequence operations such as `filter(_:)` or `map(_:)` on a set. For
    /// example, after filtering a set of prime numbers to remove any below 10,
    /// you can create a new set by using this initializer.
    ///
    ///     let primes: Set = [2, 3, 5, 7, 11, 13, 17, 19, 23]
    ///     let laterPrimes = Set(primes.lazy.filter { $0 > 10 })
    ///     print(laterPrimes)
    ///     // Prints "[17, 19, 23, 11, 13]"
    ///
    /// - Parameter sequence: The elements to use as members of the new set.
    @inlinable public init<Source>(_ sequence: Source) where Element == Source.Element, Source : Sequence

    /// Returns a Boolean value that indicates whether the set is a subset of the
    /// given sequence.
    ///
    /// Set *A* is a subset of another set *B* if every member of *A* is also a
    /// member of *B*.
    ///
    ///     let employees = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     print(attendees.isSubset(of: employees))
    ///     // Prints "true"
    ///
    /// - Parameter possibleSuperset: A sequence of elements. `possibleSuperset`
    ///   must be finite.
    /// - Returns: `true` if the set is a subset of `possibleSuperset`;
    ///   otherwise, `false`.
    @inlinable public func isSubset<S>(of possibleSuperset: S) -> Bool where Element == S.Element, S : Sequence

    /// Returns a Boolean value that indicates whether the set is a strict subset
    /// of the given sequence.
    ///
    /// Set *A* is a strict subset of another set *B* if every member of *A* is
    /// also a member of *B* and *B* contains at least one element that is not a
    /// member of *A*.
    ///
    ///     let employees = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     print(attendees.isStrictSubset(of: employees))
    ///     // Prints "true"
    ///
    ///     // A set is never a strict subset of itself:
    ///     print(attendees.isStrictSubset(of: attendees))
    ///     // Prints "false"
    ///
    /// - Parameter possibleStrictSuperset: A sequence of elements.
    ///   `possibleStrictSuperset` must be finite.
    /// - Returns: `true` is the set is strict subset of
    ///   `possibleStrictSuperset`; otherwise, `false`.
    @inlinable public func isStrictSubset<S>(of possibleStrictSuperset: S) -> Bool where Element == S.Element, S : Sequence

    /// Returns a Boolean value that indicates whether the set is a superset of
    /// the given sequence.
    ///
    /// Set *A* is a superset of another set *B* if every member of *B* is also a
    /// member of *A*.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees = ["Alicia", "Bethany", "Diana"]
    ///     print(employees.isSuperset(of: attendees))
    ///     // Prints "true"
    ///
    /// - Parameter possibleSubset: A sequence of elements. `possibleSubset` must
    ///   be finite.
    /// - Returns: `true` if the set is a superset of `possibleSubset`;
    ///   otherwise, `false`.
    @inlinable public func isSuperset<S>(of possibleSubset: S) -> Bool where Element == S.Element, S : Sequence

    /// Returns a Boolean value that indicates whether the set is a strict
    /// superset of the given sequence.
    ///
    /// Set *A* is a strict superset of another set *B* if every member of *B* is
    /// also a member of *A* and *A* contains at least one element that is *not*
    /// a member of *B*.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let attendees = ["Alicia", "Bethany", "Diana"]
    ///     print(employees.isStrictSuperset(of: attendees))
    ///     // Prints "true"
    ///     print(employees.isStrictSuperset(of: employees))
    ///     // Prints "false"
    ///
    /// - Parameter possibleStrictSubset: A sequence of elements.
    ///   `possibleStrictSubset` must be finite.
    /// - Returns: `true` if the set is a strict superset of
    ///   `possibleStrictSubset`; otherwise, `false`.
    @inlinable public func isStrictSuperset<S>(of possibleStrictSubset: S) -> Bool where Element == S.Element, S : Sequence

    /// Returns a Boolean value that indicates whether the set has no members in
    /// common with the given sequence.
    ///
    /// In the following example, the `employees` set is disjoint with the
    /// elements of the `visitors` array because no name appears in both.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let visitors = ["Marcia", "Nathaniel", "Olivia"]
    ///     print(employees.isDisjoint(with: visitors))
    ///     // Prints "true"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    /// - Returns: `true` if the set has no elements in common with `other`;
    ///   otherwise, `false`.
    @inlinable public func isDisjoint<S>(with other: S) -> Bool where Element == S.Element, S : Sequence

    /// Returns a new set with the elements of both this set and the given
    /// sequence.
    ///
    /// In the following example, the `attendeesAndVisitors` set is made up
    /// of the elements of the `attendees` set and the `visitors` array:
    ///
    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     let visitors = ["Marcia", "Nathaniel"]
    ///     let attendeesAndVisitors = attendees.union(visitors)
    ///     print(attendeesAndVisitors)
    ///     // Prints "["Diana", "Nathaniel", "Bethany", "Alicia", "Marcia"]"
    ///
    /// If the set already contains one or more elements that are also in
    /// `other`, the existing members are kept. If `other` contains multiple
    /// instances of equivalent elements, only the first instance is kept.
    ///
    ///     let initialIndices = Set(0..<5)
    ///     let expandedIndices = initialIndices.union([2, 3, 6, 6, 7, 7])
    ///     print(expandedIndices)
    ///     // Prints "[2, 4, 6, 7, 0, 1, 3]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    /// - Returns: A new set with the unique elements of this set and `other`.
    @inlinable public func union<S>(_ other: S) -> Set<Element> where Element == S.Element, S : Sequence

    /// Inserts the elements of the given sequence into the set.
    ///
    /// If the set already contains one or more elements that are also in
    /// `other`, the existing members are kept. If `other` contains multiple
    /// instances of equivalent elements, only the first instance is kept.
    ///
    ///     var attendees: Set = ["Alicia", "Bethany", "Diana"]
    ///     let visitors = ["Diana", "Marcia", "Nathaniel"]
    ///     attendees.formUnion(visitors)
    ///     print(attendees)
    ///     // Prints "["Diana", "Nathaniel", "Bethany", "Alicia", "Marcia"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    @inlinable public mutating func formUnion<S>(_ other: S) where Element == S.Element, S : Sequence

    /// Returns a new set containing the elements of this set that do not occur
    /// in the given sequence.
    ///
    /// In the following example, the `nonNeighbors` set is made up of the
    /// elements of the `employees` set that are not elements of `neighbors`:
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     let nonNeighbors = employees.subtracting(neighbors)
    ///     print(nonNeighbors)
    ///     // Prints "["Chris", "Diana", "Alicia"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    /// - Returns: A new set.
    @inlinable public func subtracting<S>(_ other: S) -> Set<Element> where Element == S.Element, S : Sequence

    /// Removes the elements of the given sequence from the set.
    ///
    /// In the following example, the elements of the `employees` set that are
    /// also elements of the `neighbors` array are removed. In particular, the
    /// names `"Bethany"` and `"Eric"` are removed from `employees`.
    ///
    ///     var employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     employees.subtract(neighbors)
    ///     print(employees)
    ///     // Prints "["Chris", "Diana", "Alicia"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    @inlinable public mutating func subtract<S>(_ other: S) where Element == S.Element, S : Sequence

    /// Returns a new set with the elements that are common to both this set and
    /// the given sequence.
    ///
    /// In the following example, the `bothNeighborsAndEmployees` set is made up
    /// of the elements that are in *both* the `employees` and `neighbors` sets.
    /// Elements that are in only one or the other are left out of the result of
    /// the intersection.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     let bothNeighborsAndEmployees = employees.intersection(neighbors)
    ///     print(bothNeighborsAndEmployees)
    ///     // Prints "["Bethany", "Eric"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    /// - Returns: A new set.
    @inlinable public func intersection<S>(_ other: S) -> Set<Element> where Element == S.Element, S : Sequence

    /// Removes the elements of the set that aren't also in the given sequence.
    ///
    /// In the following example, the elements of the `employees` set that are
    /// not also members of the `neighbors` set are removed. In particular, the
    /// names `"Alicia"`, `"Chris"`, and `"Diana"` are removed.
    ///
    ///     var employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
    ///     let neighbors = ["Bethany", "Eric", "Forlani", "Greta"]
    ///     employees.formIntersection(neighbors)
    ///     print(employees)
    ///     // Prints "["Bethany", "Eric"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    @inlinable public mutating func formIntersection<S>(_ other: S) where Element == S.Element, S : Sequence

    /// Returns a new set with the elements that are either in this set or in the
    /// given sequence, but not in both.
    ///
    /// In the following example, the `eitherNeighborsOrEmployees` set is made up
    /// of the elements of the `employees` and `neighbors` sets that are not in
    /// both `employees` *and* `neighbors`. In particular, the names `"Bethany"`
    /// and `"Eric"` do not appear in `eitherNeighborsOrEmployees`.
    ///
    ///     let employees: Set = ["Alicia", "Bethany", "Diana", "Eric"]
    ///     let neighbors = ["Bethany", "Eric", "Forlani"]
    ///     let eitherNeighborsOrEmployees = employees.symmetricDifference(neighbors)
    ///     print(eitherNeighborsOrEmployees)
    ///     // Prints "["Diana", "Forlani", "Alicia"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    /// - Returns: A new set.
    @inlinable public func symmetricDifference<S>(_ other: S) -> Set<Element> where Element == S.Element, S : Sequence

    /// Replace this set with the elements contained in this set or the given
    /// set, but not both.
    ///
    /// In the following example, the elements of the `employees` set that are
    /// also members of `neighbors` are removed from `employees`, while the
    /// elements of `neighbors` that are not members of `employees` are added to
    /// `employees`. In particular, the names `"Bethany"` and `"Eric"` are
    /// removed from `employees` while the name `"Forlani"` is added.
    ///
    ///     var employees: Set = ["Alicia", "Bethany", "Diana", "Eric"]
    ///     let neighbors = ["Bethany", "Eric", "Forlani"]
    ///     employees.formSymmetricDifference(neighbors)
    ///     print(employees)
    ///     // Prints "["Diana", "Forlani", "Alicia"]"
    ///
    /// - Parameter other: A sequence of elements. `other` must be finite.
    @inlinable public mutating func formSymmetricDifference<S>(_ other: S) where Element == S.Element, S : Sequence
}

extension Set : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    @inlinable public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension Set : Equatable {

    /// Returns a Boolean value indicating whether two sets have equal elements.
    ///
    /// - Parameters:
    ///   - lhs: A set.
    ///   - rhs: Another set.
    /// - Returns: `true` if the `lhs` and `rhs` have the same elements; otherwise,
    ///   `false`.
    @inlinable public static func == (lhs: Set<Element>, rhs: Set<Element>) -> Bool
}

extension Set : Sequence {

    /// Returns an iterator over the members of the set.
    @inlinable public func makeIterator() -> Set<Element>.Iterator

    /// Returns a Boolean value that indicates whether the given element exists
    /// in the set.
    ///
    /// This example uses the `contains(_:)` method to test whether an integer is
    /// a member of a set of prime numbers.
    ///
    ///     let primes: Set = [2, 3, 5, 7]
    ///     let x = 5
    ///     if primes.contains(x) {
    ///         print("\(x) is prime!")
    ///     } else {
    ///         print("\(x). Not prime.")
    ///     }
    ///     // Prints "5 is prime!"
    ///
    /// - Parameter member: An element to look for in the set.
    /// - Returns: `true` if `member` exists in the set; otherwise, `false`.
    ///
    /// - Complexity: O(1)
    @inlinable public func contains(_ member: Element) -> Bool
}

extension Set : Collection {

    /// The starting position for iterating members of the set.
    ///
    /// If the set is empty, `startIndex` is equal to `endIndex`.
    @inlinable public var startIndex: Set<Element>.Index { get }

    /// The "past the end" position for the set---that is, the position one
    /// greater than the last valid subscript argument.
    ///
    /// If the set is empty, `endIndex` is equal to `startIndex`.
    @inlinable public var endIndex: Set<Element>.Index { get }

    /// Accesses the member at the given position.
    @inlinable public subscript(position: Set<Element>.Index) -> Element { get }

    /// Returns the position immediately after the given index.
    ///
    /// The successor of an index must be well defined. For an index `i` into a
    /// collection `c`, calling `c.index(after: i)` returns the same index every
    /// time.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    @inlinable public func index(after i: Set<Element>.Index) -> Set<Element>.Index

    /// Replaces the given index with its successor.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    @inlinable public func formIndex(after i: inout Set<Element>.Index)

    /// Returns the index of the given element in the set, or `nil` if the
    /// element is not a member of the set.
    ///
    /// - Parameter member: An element to search for in the set.
    /// - Returns: The index of `member` if it exists in the set; otherwise,
    ///   `nil`.
    ///
    /// - Complexity: O(1)
    @inlinable public func firstIndex(of member: Element) -> Set<Element>.Index?

    /// The number of elements in the set.
    ///
    /// - Complexity: O(1).
    @inlinable public var count: Int { get }

    /// A Boolean value that indicates whether the set is empty.
    @inlinable public var isEmpty: Bool { get }

    /// A sequence that represents a contiguous subrange of the collection's
    /// elements.
    ///
    /// This associated type appears as a requirement in the `Sequence`
    /// protocol, but it is restated here with stricter constraints. In a
    /// collection, the subsequence should also conform to `Collection`.
    public typealias SubSequence = Slice<Set<Element>>

    /// A type that represents the indices that are valid for subscripting the
    /// collection, in ascending order.
    public typealias Indices = DefaultIndices<Set<Element>>
}

extension Set : CustomStringConvertible, CustomDebugStringConvertible {

    /// A string that represents the contents of the set.
    public var description: String { get }

    /// A string that represents the contents of the set, suitable for debugging.
    public var debugDescription: String { get }
}

extension Set where Self.Element : Sequence {

    /// Returns the elements of this sequence of sequences, concatenated.
    ///
    /// In this example, an array of three ranges is flattened so that the
    /// elements of each range can be iterated in turn.
    ///
    ///     let ranges = [0..<3, 8..<10, 15..<17]
    ///
    ///     // A for-in loop over 'ranges' accesses each range:
    ///     for range in ranges {
    ///       print(range)
    ///     }
    ///     // Prints "0..<3"
    ///     // Prints "8..<10"
    ///     // Prints "15..<17"
    ///
    ///     // Use 'joined()' to access each element of each range:
    ///     for index in ranges.joined() {
    ///         print(index, terminator: " ")
    ///     }
    ///     // Prints: "0 1 2 8 9 15 16"
    ///
    /// - Returns: A flattened view of the elements of this
    ///   sequence of sequences.
    @inlinable public func joined() -> FlattenSequence<Set<Element>>

    /// Returns the concatenated elements of this sequence of sequences,
    /// inserting the given separator between each element.
    ///
    /// This example shows how an array of `[Int]` instances can be joined, using
    /// another `[Int]` instance as the separator:
    ///
    ///     let nestedNumbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    ///     let joined = nestedNumbers.joined(separator: [-1, -2])
    ///     print(Array(joined))
    ///     // Prints "[1, 2, 3, -1, -2, 4, 5, 6, -1, -2, 7, 8, 9]"
    ///
    /// - Parameter separator: A sequence to insert between each of this
    ///   sequence's elements.
    /// - Returns: The joined sequence of elements.
    @inlinable public func joined<Separator>(separator: Separator) -> JoinedSequence<Set<Element>> where Separator : Sequence, Separator.Element == Self.Element.Element
}

extension Set where Self.Element : StringProtocol {

    /// Returns a new string by concatenating the elements of the sequence,
    /// adding the given separator between each element.
    ///
    /// The following example shows how an array of strings can be joined to a
    /// single, comma-separated string:
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let list = cast.joined(separator: ", ")
    ///     print(list)
    ///     // Prints "Vivien, Marlon, Kim, Karl"
    ///
    /// - Parameter separator: A string to insert between each of the elements
    ///   in this sequence. The default separator is an empty string.
    /// - Returns: A single, concatenated string.
    public func joined(separator: String = "") -> String
}

extension Set where Self.Element : Comparable {

    /// Returns the minimum element in the sequence.
    ///
    /// This example finds the smallest value in an array of height measurements.
    ///
    ///     let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
    ///     let lowestHeight = heights.min()
    ///     print(lowestHeight)
    ///     // Prints "Optional(58.5)"
    ///
    /// - Returns: The sequence's minimum element. If the sequence has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func min() -> Element?

    /// Returns the maximum element in the sequence.
    ///
    /// This example finds the largest value in an array of height measurements.
    ///
    ///     let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
    ///     let greatestHeight = heights.max()
    ///     print(greatestHeight)
    ///     // Prints "Optional(67.5)"
    ///
    /// - Returns: The sequence's maximum element. If the sequence has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func max() -> Element?

    /// Returns a Boolean value indicating whether the sequence precedes another
    /// sequence in a lexicographical (dictionary) ordering, using the
    /// less-than operator (`<`) to compare elements.
    ///
    /// This example uses the `lexicographicallyPrecedes` method to test which
    /// array of integers comes first in a lexicographical ordering.
    ///
    ///     let a = [1, 2, 2, 2]
    ///     let b = [1, 2, 3, 4]
    ///
    ///     print(a.lexicographicallyPrecedes(b))
    ///     // Prints "true"
    ///     print(b.lexicographicallyPrecedes(b))
    ///     // Prints "false"
    ///
    /// - Parameter other: A sequence to compare to this sequence.
    /// - Returns: `true` if this sequence precedes `other` in a dictionary
    ///   ordering; otherwise, `false`.
    ///
    /// - Note: This method implements the mathematical notion of lexicographical
    ///   ordering, which has no connection to Unicode.  If you are sorting
    ///   strings to present to the end user, use `String` APIs that
    ///   perform localized comparison.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns the elements of the sequence, sorted.
    ///
    /// You can sort any sequence of elements that conform to the `Comparable`
    /// protocol by calling this method. Elements are sorted in ascending order.
    ///
    /// Here's an example of sorting a list of students' names. Strings in Swift
    /// conform to the `Comparable` protocol, so the names are sorted in
    /// ascending order according to the less-than operator (`<`).
    ///
    ///     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     let sortedStudents = students.sorted()
    ///     print(sortedStudents)
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///
    /// To sort the elements of your sequence in descending order, pass the
    /// greater-than operator (`>`) to the `sorted(by:)` method.
    ///
    ///     let descendingStudents = students.sorted(by: >)
    ///     print(descendingStudents)
    ///     // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"
    ///
    /// The sorting algorithm is not guaranteed to be stable. A stable sort
    /// preserves the relative order of elements that compare equal.
    ///
    /// - Returns: A sorted array of the sequence's elements.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    @inlinable public func sorted() -> [Element]
}

extension Set where Self.Element : Equatable {

    /// Returns the longest possible subsequences of the collection, in order,
    /// around elements equal to the given element.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the collection are not returned as part
    /// of any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string at each
    /// space character (" "). The first use of `split` returns each word that
    /// was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(separator: " "))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(separator: " ", maxSplits: 1))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(separator: " ", omittingEmptySubsequences: false))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - separator: The element that should be split upon.
    ///   - maxSplits: The maximum number of times to split the collection, or
    ///     one less than the number of subsequences to return. If
    ///     `maxSplits + 1` subsequences are returned, the last one is a suffix
    ///     of the original collection containing the remaining elements.
    ///     `maxSplits` must be greater than or equal to zero. The default value
    ///     is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each consecutive pair of `separator`
    ///     elements in the collection and for each instance of `separator` at
    ///     the start or end of the collection. If `true`, only nonempty
    ///     subsequences are returned. The default value is `true`.
    /// - Returns: An array of subsequences, split from this collection's
    ///   elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func split(separator: Element, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [Slice<Set<Element>>]

    /// Returns the first index where the specified value appears in the
    /// collection.
    @available(swift, deprecated: 5.0, renamed: "firstIndex(of:)")
    @inlinable public func index(of element: Element) -> Set<Element>.Index?

    /// Returns a Boolean value indicating whether the initial elements of the
    /// sequence are the same as the elements in another sequence.
    ///
    /// This example tests whether one countable range begins with the elements
    /// of another countable range.
    ///
    ///     let a = 1...3
    ///     let b = 1...10
    ///
    ///     print(b.starts(with: a))
    ///     // Prints "true"
    ///
    /// Passing a sequence with no elements or an empty collection as
    /// `possiblePrefix` always results in `true`.
    ///
    ///     print(b.starts(with: []))
    ///     // Prints "true"
    ///
    /// - Parameter possiblePrefix: A sequence to compare to this sequence.
    /// - Returns: `true` if the initial elements of the sequence are the same as
    ///   the elements of `possiblePrefix`; otherwise, `false`. If
    ///   `possiblePrefix` has no elements, the return value is `true`.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `possiblePrefix`.
    @inlinable public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool where PossiblePrefix : Sequence, Self.Element == PossiblePrefix.Element

    /// Returns a Boolean value indicating whether this sequence and another
    /// sequence contain the same elements in the same order.
    ///
    /// At least one of the sequences must be finite.
    ///
    /// This example tests whether one countable range shares the same elements
    /// as another countable range and an array.
    ///
    ///     let a = 1...3
    ///     let b = 1...10
    ///
    ///     print(a.elementsEqual(b))
    ///     // Prints "false"
    ///     print(a.elementsEqual([1, 2, 3]))
    ///     // Prints "true"
    ///
    /// - Parameter other: A sequence to compare to this sequence.
    /// - Returns: `true` if this sequence and `other` contain the same elements
    ///   in the same order.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element
}

extension Set : Decodable where Element : Decodable {

    /// Creates a new set by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

extension Set : Encodable where Element : Encodable {

    /// Encodes the elements of this set into the given encoder in an unkeyed
    /// container.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws
}

extension Set.Index {

    /// Returns a closed range that contains both of its bounds.
    ///
    /// Use the closed range operator (`...`) to create a closed range of any type
    /// that conforms to the `Comparable` protocol. This example creates a
    /// `ClosedRange<Character>` from "a" up to, and including, "z".
    ///
    ///     let lowercase = "a"..."z"
    ///     print(lowercase.contains("z"))
    ///     // Prints "true"
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    public static func ... (minimum: Set<Element>.Index, maximum: Set<Element>.Index) -> ClosedRange<Set<Element>.Index>

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is greater than that of the second argument.
    ///
    /// This is the default implementation of the greater-than operator (`>`) for
    /// any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func > (lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is less than or equal to that of the second argument.
    ///
    /// This is the default implementation of the less-than-or-equal-to
    /// operator (`<=`) for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func <= (lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is greater than or equal to that of the second argument.
    ///
    /// This is the default implementation of the greater-than-or-equal-to operator
    /// (`>=`) for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    /// - Returns: `true` if `lhs` is greater than or equal to `rhs`; otherwise,
    ///   `false`.
    @inlinable public static func >= (lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool

    public static func != (lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool

    /// Returns a half-open range that contains its lower bound but not its upper
    /// bound.
    ///
    /// Use the half-open range operator (`..<`) to create a range of any type
    /// that conforms to the `Comparable` protocol. This example creates a
    /// `Range<Double>` from zero up to, but not including, 5.0.
    ///
    ///     let lessThanFive = 0.0..<5.0
    ///     print(lessThanFive.contains(3.14))  // Prints "true"
    ///     print(lessThanFive.contains(5.0))   // Prints "false"
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    public static func ..< (minimum: Set<Element>.Index, maximum: Set<Element>.Index) -> Range<Set<Element>.Index>

    /// Returns a partial range up to, but not including, its upper bound.
    ///
    /// Use the prefix half-open range operator (prefix `..<`) to create a
    /// partial range of any type that conforms to the `Comparable` protocol.
    /// This example creates a `PartialRangeUpTo<Double>` instance that includes
    /// any value less than `5.0`.
    ///
    ///     let upToFive = ..<5.0
    ///
    ///     upToFive.contains(3.14)       // true
    ///     upToFive.contains(6.28)       // false
    ///     upToFive.contains(5.0)        // false
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the start of the collection up to, but not
    /// including, the partial range's upper bound.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[..<3])
    ///     // Prints "[10, 20, 30]"
    ///
    /// - Parameter maximum: The upper bound for the range.
    prefix public static func ..< (maximum: Set<Element>.Index) -> PartialRangeUpTo<Set<Element>.Index>

    /// Returns a partial range up to, and including, its upper bound.
    ///
    /// Use the prefix closed range operator (prefix `...`) to create a partial
    /// range of any type that conforms to the `Comparable` protocol. This
    /// example creates a `PartialRangeThrough<Double>` instance that includes
    /// any value less than or equal to `5.0`.
    ///
    ///     let throughFive = ...5.0
    ///
    ///     throughFive.contains(4.0)     // true
    ///     throughFive.contains(5.0)     // true
    ///     throughFive.contains(6.0)     // false
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the start of the collection up to, and
    /// including, the partial range's upper bound.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[...3])
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// - Parameter maximum: The upper bound for the range.
    prefix public static func ... (maximum: Set<Element>.Index) -> PartialRangeThrough<Set<Element>.Index>

    /// Returns a partial range extending upward from a lower bound.
    ///
    /// Use the postfix range operator (postfix `...`) to create a partial range
    /// of any type that conforms to the `Comparable` protocol. This example
    /// creates a `PartialRangeFrom<Double>` instance that includes any value
    /// greater than or equal to `5.0`.
    ///
    ///     let atLeastFive = 5.0...
    ///
    ///     atLeastFive.contains(4.0)     // false
    ///     atLeastFive.contains(5.0)     // true
    ///     atLeastFive.contains(6.0)     // true
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the partial range's lower bound up to the end
    /// of the collection.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[3...])
    ///     // Prints "[40, 50, 60, 70]"
    ///
    /// - Parameter minimum: The lower bound for the range.
    postfix public static func ... (minimum: Set<Element>.Index) -> PartialRangeFrom<Set<Element>.Index>
}

extension Set.Index : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func == (lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool
}

extension Set.Index : Comparable {

    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func < (lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool
}

extension Set.Index : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension Set.Iterator : IteratorProtocol {

    /// Advances to the next element and returns it, or `nil` if no next element
    /// exists.
    ///
    /// Once `nil` has been returned, all subsequent calls return `nil`.
    @inlinable public mutating func next() -> Element?
}

extension Set.Iterator : CustomReflectable {

    /// A mirror that reflects the iterator.
    public var customMirror: Mirror { get }
}

public typealias SetIndex<Element> = Set<Element>.Index where Element : Hashable

public typealias SetIterator<Element> = Set<Element>.Iterator where Element : Hashable

/// A collection whose elements are key-value pairs.
///
/// A dictionary is a type of hash table, providing fast access to the entries
/// it contains. Each entry in the table is identified using its key, which is
/// a hashable type such as a string or number. You use that key to retrieve
/// the corresponding value, which can be any object. In other languages,
/// similar data types are known as hashes or associated arrays.
///
/// Create a new dictionary by using a dictionary literal. A dictionary literal
/// is a comma-separated list of key-value pairs, in which a colon separates
/// each key from its associated value, surrounded by square brackets. You can
/// assign a dictionary literal to a variable or constant or pass it to a
/// function that expects a dictionary.
///
/// Here's how you would create a dictionary of HTTP response codes and their
/// related messages:
///
///     var responseMessages = [200: "OK",
///                             403: "Access forbidden",
///                             404: "File not found",
///                             500: "Internal server error"]
///
/// The `responseMessages` variable is inferred to have type `[Int: String]`.
/// The `Key` type of the dictionary is `Int`, and the `Value` type of the
/// dictionary is `String`.
///
/// To create a dictionary with no key-value pairs, use an empty dictionary
/// literal (`[:]`).
///
///     var emptyDict: [String: String] = [:]
///
/// Any type that conforms to the `Hashable` protocol can be used as a
/// dictionary's `Key` type, including all of Swift's basic types. You can use
/// your own custom types as dictionary keys by making them conform to the
/// `Hashable` protocol.
///
/// Getting and Setting Dictionary Values
/// =====================================
///
/// The most common way to access values in a dictionary is to use a key as a
/// subscript. Subscripting with a key takes the following form:
///
///     print(responseMessages[200])
///     // Prints "Optional("OK")"
///
/// Subscripting a dictionary with a key returns an optional value, because a
/// dictionary might not hold a value for the key that you use in the
/// subscript.
///
/// The next example uses key-based subscripting of the `responseMessages`
/// dictionary with two keys that exist in the dictionary and one that does
/// not.
///
///     let httpResponseCodes = [200, 403, 301]
///     for code in httpResponseCodes {
///         if let message = responseMessages[code] {
///             print("Response \(code): \(message)")
///         } else {
///             print("Unknown response \(code)")
///         }
///     }
///     // Prints "Response 200: OK"
///     // Prints "Response 403: Access Forbidden"
///     // Prints "Unknown response 301"
///
/// You can also update, modify, or remove keys and values from a dictionary
/// using the key-based subscript. To add a new key-value pair, assign a value
/// to a key that isn't yet a part of the dictionary.
///
///     responseMessages[301] = "Moved permanently"
///     print(responseMessages[301])
///     // Prints "Optional("Moved permanently")"
///
/// Update an existing value by assigning a new value to a key that already
/// exists in the dictionary. If you assign `nil` to an existing key, the key
/// and its associated value are removed. The following example updates the
/// value for the `404` code to be simply "Not found" and removes the
/// key-value pair for the `500` code entirely.
///
///     responseMessages[404] = "Not found"
///     responseMessages[500] = nil
///     print(responseMessages)
///     // Prints "[301: "Moved permanently", 200: "OK", 403: "Access forbidden", 404: "Not found"]"
///
/// In a mutable `Dictionary` instance, you can modify in place a value that
/// you've accessed through a keyed subscript. The code sample below declares a
/// dictionary called `interestingNumbers` with string keys and values that
/// are integer arrays, then sorts each array in-place in descending order.
///
///     var interestingNumbers = ["primes": [2, 3, 5, 7, 11, 13, 17],
///                               "triangular": [1, 3, 6, 10, 15, 21, 28],
///                               "hexagonal": [1, 6, 15, 28, 45, 66, 91]]
///     for key in interestingNumbers.keys {
///         interestingNumbers[key]?.sort(by: >)
///     }
///
///     print(interestingNumbers["primes"]!)
///     // Prints "[17, 13, 11, 7, 5, 3, 2]"
///
/// Iterating Over the Contents of a Dictionary
/// ===========================================
///
/// Every dictionary is an unordered collection of key-value pairs. You can
/// iterate over a dictionary using a `for`-`in` loop, decomposing each
/// key-value pair into the elements of a tuple.
///
///     let imagePaths = ["star": "/glyphs/star.png",
///                       "portrait": "/images/content/portrait.jpg",
///                       "spacer": "/images/shared/spacer.gif"]
///
///     for (name, path) in imagePaths {
///         print("The path to '\(name)' is '\(path)'.")
///     }
///     // Prints "The path to 'star' is '/glyphs/star.png'."
///     // Prints "The path to 'portrait' is '/images/content/portrait.jpg'."
///     // Prints "The path to 'spacer' is '/images/shared/spacer.gif'."
///
/// The order of key-value pairs in a dictionary is stable between mutations
/// but is otherwise unpredictable. If you need an ordered collection of
/// key-value pairs and don't need the fast key lookup that `Dictionary`
/// provides, see the `KeyValuePairs` type for an alternative.
///
/// You can search a dictionary's contents for a particular value using the
/// `contains(where:)` or `firstIndex(where:)` methods supplied by default
/// implementation. The following example checks to see if `imagePaths` contains
/// any paths in the `"/glyphs"` directory:
///
///     let glyphIndex = imagePaths.firstIndex(where: { $0.value.hasPrefix("/glyphs") })
///     if let index = glyphIndex {
///         print("The '\(imagePaths[index].key)' image is a glyph.")
///     } else {
///         print("No glyphs found!")
///     }
///     // Prints "The 'star' image is a glyph.")
///
/// Note that in this example, `imagePaths` is subscripted using a dictionary
/// index. Unlike the key-based subscript, the index-based subscript returns
/// the corresponding key-value pair as a non-optional tuple.
///
///     print(imagePaths[glyphIndex!])
///     // Prints "("star", "/glyphs/star.png")"
///
/// A dictionary's indices stay valid across additions to the dictionary as
/// long as the dictionary has enough capacity to store the added values
/// without allocating more buffer. When a dictionary outgrows its buffer,
/// existing indices may be invalidated without any notification.
///
/// When you know how many new values you're adding to a dictionary, use the
/// `init(minimumCapacity:)` initializer to allocate the correct amount of
/// buffer.
///
/// Bridging Between Dictionary and NSDictionary
/// ============================================
///
/// You can bridge between `Dictionary` and `NSDictionary` using the `as`
/// operator. For bridging to be possible, the `Key` and `Value` types of a
/// dictionary must be classes, `@objc` protocols, or types that bridge to
/// Foundation types.
///
/// Bridging from `Dictionary` to `NSDictionary` always takes O(1) time and
/// space. When the dictionary's `Key` and `Value` types are neither classes
/// nor `@objc` protocols, any required bridging of elements occurs at the
/// first access of each element. For this reason, the first operation that
/// uses the contents of the dictionary may take O(*n*).
///
/// Bridging from `NSDictionary` to `Dictionary` first calls the `copy(with:)`
/// method (`- copyWithZone:` in Objective-C) on the dictionary to get an
/// immutable copy and then performs additional Swift bookkeeping work that
/// takes O(1) time. For instances of `NSDictionary` that are already
/// immutable, `copy(with:)` usually returns the same dictionary in O(1) time;
/// otherwise, the copying performance is unspecified. The instances of
/// `NSDictionary` and `Dictionary` share buffer using the same copy-on-write
/// optimization that is used when two instances of `Dictionary` share
/// buffer.
public struct Dictionary<Key, Value> where Key : Hashable {

    /// The element type of a dictionary: a tuple containing an individual
    /// key-value pair.
    public typealias Element = (key: Key, value: Value)

    /// Creates an empty dictionary.
    @inlinable public init()

    /// Creates an empty dictionary with preallocated space for at least the
    /// specified number of elements.
    ///
    /// Use this initializer to avoid intermediate reallocations of a dictionary's
    /// storage buffer when you know how many key-value pairs you are adding to a
    /// dictionary after creation.
    ///
    /// - Parameter minimumCapacity: The minimum number of key-value pairs that
    ///   the newly created dictionary should be able to store without
    ///   reallocating its storage buffer.
    public init(minimumCapacity: Int)

    /// Creates a new dictionary from the key-value pairs in the given sequence.
    ///
    /// You use this initializer to create a dictionary when you have a sequence
    /// of key-value tuples with unique keys. Passing a sequence with duplicate
    /// keys to this initializer results in a runtime error. If your
    /// sequence might have duplicate keys, use the
    /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
    ///
    /// The following example creates a new dictionary using an array of strings
    /// as the keys and the integers in a countable range as the values:
    ///
    ///     let digitWords = ["one", "two", "three", "four", "five"]
    ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
    ///     print(wordToValue["three"]!)
    ///     // Prints "3"
    ///     print(wordToValue)
    ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
    ///
    /// - Parameter keysAndValues: A sequence of key-value pairs to use for
    ///   the new dictionary. Every key in `keysAndValues` must be unique.
    /// - Returns: A new dictionary initialized with the elements of
    ///   `keysAndValues`.
    /// - Precondition: The sequence must not have duplicate keys.
    @inlinable public init<S>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, S.Element == (Key, Value)

    /// Creates a new dictionary from the key-value pairs in the given sequence,
    /// using a combining closure to determine the value for any duplicate keys.
    ///
    /// You use this initializer to create a dictionary when you have a sequence
    /// of key-value tuples that might have duplicate keys. As the dictionary is
    /// built, the initializer calls the `combine` closure with the current and
    /// new values for any duplicate keys. Pass a closure as `combine` that
    /// returns the value to use in the resulting dictionary: The closure can
    /// choose between the two values, combine them to produce a new value, or
    /// even throw an error.
    ///
    /// The following example shows how to choose the first and last values for
    /// any duplicate keys:
    ///
    ///     let pairsWithDuplicateKeys = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
    ///
    ///     let firstValues = Dictionary(pairsWithDuplicateKeys,
    ///                                  uniquingKeysWith: { (first, _) in first })
    ///     // ["b": 2, "a": 1]
    ///
    ///     let lastValues = Dictionary(pairsWithDuplicateKeys,
    ///                                 uniquingKeysWith: { (_, last) in last })
    ///     // ["b": 4, "a": 3]
    ///
    /// - Parameters:
    ///   - keysAndValues: A sequence of key-value pairs to use for the new
    ///     dictionary.
    ///   - combine: A closure that is called with the values for any duplicate
    ///     keys that are encountered. The closure returns the desired value for
    ///     the final dictionary.
    @inlinable public init<S>(_ keysAndValues: S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows where S : Sequence, S.Element == (Key, Value)

    /// Creates a new dictionary whose keys are the groupings returned by the
    /// given closure and whose values are arrays of the elements that returned
    /// each key.
    ///
    /// The arrays in the "values" position of the new dictionary each contain at
    /// least one element, with the elements in the same order as the source
    /// sequence.
    ///
    /// The following example declares an array of names, and then creates a
    /// dictionary from that array by grouping the names by first letter:
    ///
    ///     let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
    ///     let studentsByLetter = Dictionary(grouping: students, by: { $0.first! })
    ///     // ["E": ["Efua"], "K": ["Kofi", "Kweku"], "A": ["Abena", "Akosua"]]
    ///
    /// The new `studentsByLetter` dictionary has three entries, with students'
    /// names grouped by the keys `"E"`, `"K"`, and `"A"`.
    ///
    /// - Parameters:
    ///   - values: A sequence of values to group into a dictionary.
    ///   - keyForValue: A closure that returns a key for each element in
    ///     `values`.
    @inlinable public init<S>(grouping values: S, by keyForValue: (S.Element) throws -> Key) rethrows where Value == [S.Element], S : Sequence

    /// Returns a new dictionary containing the key-value pairs of the dictionary
    /// that satisfy the given predicate.
    ///
    /// - Parameter isIncluded: A closure that takes a key-value pair as its
    ///   argument and returns a Boolean value indicating whether the pair
    ///   should be included in the returned dictionary.
    /// - Returns: A dictionary of the key-value pairs that `isIncluded` allows.
    @available(swift 4.0)
    @inlinable public func filter(_ isIncluded: ([Key : Value].Element) throws -> Bool) rethrows -> [Key : Value]

    /// Accesses the value associated with the given key for reading and writing.
    ///
    /// This *key-based* subscript returns the value for the given key if the key
    /// is found in the dictionary, or `nil` if the key is not found.
    ///
    /// The following example creates a new dictionary and prints the value of a
    /// key found in the dictionary (`"Coral"`) and a key not found in the
    /// dictionary (`"Cerise"`).
    ///
    ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     print(hues["Coral"])
    ///     // Prints "Optional(16)"
    ///     print(hues["Cerise"])
    ///     // Prints "nil"
    ///
    /// When you assign a value for a key and that key already exists, the
    /// dictionary overwrites the existing value. If the dictionary doesn't
    /// contain the key, the key and value are added as a new key-value pair.
    ///
    /// Here, the value for the key `"Coral"` is updated from `16` to `18` and a
    /// new key-value pair is added for the key `"Cerise"`.
    ///
    ///     hues["Coral"] = 18
    ///     print(hues["Coral"])
    ///     // Prints "Optional(18)"
    ///
    ///     hues["Cerise"] = 330
    ///     print(hues["Cerise"])
    ///     // Prints "Optional(330)"
    ///
    /// If you assign `nil` as the value for the given key, the dictionary
    /// removes that key and its associated value.
    ///
    /// In the following example, the key-value pair for the key `"Aquamarine"`
    /// is removed from the dictionary by assigning `nil` to the key-based
    /// subscript.
    ///
    ///     hues["Aquamarine"] = nil
    ///     print(hues)
    ///     // Prints "["Coral": 18, "Heliotrope": 296, "Cerise": 330]"
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Returns: The value associated with `key` if `key` is in the dictionary;
    ///   otherwise, `nil`.
    @inlinable public subscript(key: Key) -> Value?

    /// Accesses the value with the given key. If the dictionary doesn't contain
    /// the given key, accesses the provided default value as if the key and
    /// default value existed in the dictionary.
    ///
    /// Use this subscript when you want either the value for a particular key
    /// or, when that key is not present in the dictionary, a default value. This
    /// example uses the subscript with a message to use in case an HTTP response
    /// code isn't recognized:
    ///
    ///     var responseMessages = [200: "OK",
    ///                             403: "Access forbidden",
    ///                             404: "File not found",
    ///                             500: "Internal server error"]
    ///
    ///     let httpResponseCodes = [200, 403, 301]
    ///     for code in httpResponseCodes {
    ///         let message = responseMessages[code, default: "Unknown response"]
    ///         print("Response \(code): \(message)")
    ///     }
    ///     // Prints "Response 200: OK"
    ///     // Prints "Response 403: Access Forbidden"
    ///     // Prints "Response 301: Unknown response"
    ///
    /// When a dictionary's `Value` type has value semantics, you can use this
    /// subscript to perform in-place operations on values in the dictionary.
    /// The following example uses this subscript while counting the occurences
    /// of each letter in a string:
    ///
    ///     let message = "Hello, Elle!"
    ///     var letterCounts: [Character: Int] = [:]
    ///     for letter in message {
    ///         letterCounts[letter, defaultValue: 0] += 1
    ///     }
    ///     // letterCounts == ["H": 1, "e": 2, "l": 4, "o": 1, ...]
    ///
    /// When `letterCounts[letter, defaultValue: 0] += 1` is executed with a
    /// value of `letter` that isn't already a key in `letterCounts`, the
    /// specified default value (`0`) is returned from the subscript,
    /// incremented, and then added to the dictionary under that key.
    ///
    /// - Note: Do not use this subscript to modify dictionary values if the
    ///   dictionary's `Value` type is a class. In that case, the default value
    ///   and key are not written back to the dictionary after an operation.
    ///
    /// - Parameters:
    ///   - key: The key the look up in the dictionary.
    ///   - defaultValue: The default value to use if `key` doesn't exist in the
    ///     dictionary.
    /// - Returns: The value associated with `key` in the dictionary`; otherwise,
    ///   `defaultValue`.
    @inlinable public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value

    /// Returns a new dictionary containing the keys of this dictionary with the
    /// values transformed by the given closure.
    ///
    /// - Parameter transform: A closure that transforms a value. `transform`
    ///   accepts each value of the dictionary as its parameter and returns a
    ///   transformed value of the same or of a different type.
    /// - Returns: A dictionary containing the keys and transformed values of
    ///   this dictionary.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the dictionary.
    @inlinable public func mapValues<T>(_ transform: (Value) throws -> T) rethrows -> [Key : T]

    /// Returns a new dictionary containing only the key-value pairs that have
    /// non-`nil` values as the result of transformation by the given closure.
    ///
    /// Use this method to receive a dictionary with non-optional values when
    /// your transformation produces optional values.
    ///
    /// In this example, note the difference in the result of using `mapValues`
    /// and `compactMapValues` with a transformation that returns an optional
    /// `Int` value.
    ///
    ///     let data = ["a": "1", "b": "three", "c": "///4///"]
    ///
    ///     let m: [String: Int?] = data.mapValues { str in Int(str) }
    ///     // ["a": 1, "b": nil, "c": nil]
    ///
    ///     let c: [String: Int] = data.compactMapValues { str in Int(str) }
    ///     // ["a": 1]
    ///
    /// - Parameter transform: A closure that transforms a value. `transform`
    ///   accepts each value of the dictionary as its parameter and returns an
    ///   optional transformed value of the same or of a different type.
    /// - Returns: A dictionary containing the keys and non-`nil` transformed
    ///   values of this dictionary.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of the original
    ///   dictionary and *m* is the length of the resulting dictionary.
    @inlinable public func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> [Key : T]

    /// Updates the value stored in the dictionary for the given key, or adds a
    /// new key-value pair if the key does not exist.
    ///
    /// Use this method instead of key-based subscripting when you need to know
    /// whether the new value supplants the value of an existing key. If the
    /// value of an existing key is updated, `updateValue(_:forKey:)` returns
    /// the original value.
    ///
    ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///
    ///     if let oldValue = hues.updateValue(18, forKey: "Coral") {
    ///         print("The old value of \(oldValue) was replaced with a new one.")
    ///     }
    ///     // Prints "The old value of 16 was replaced with a new one."
    ///
    /// If the given key is not present in the dictionary, this method adds the
    /// key-value pair and returns `nil`.
    ///
    ///     if let oldValue = hues.updateValue(330, forKey: "Cerise") {
    ///         print("The old value of \(oldValue) was replaced with a new one.")
    ///     } else {
    ///         print("No value was found in the dictionary for that key.")
    ///     }
    ///     // Prints "No value was found in the dictionary for that key."
    ///
    /// - Parameters:
    ///   - value: The new value to add to the dictionary.
    ///   - key: The key to associate with `value`. If `key` already exists in
    ///     the dictionary, `value` replaces the existing associated value. If
    ///     `key` isn't already a key of the dictionary, the `(key, value)` pair
    ///     is added.
    /// - Returns: The value that was replaced, or `nil` if a new key-value pair
    ///   was added.
    @inlinable public mutating func updateValue(_ value: Value, forKey key: Key) -> Value?

    /// Merges the key-value pairs in the given sequence into the dictionary,
    /// using a combining closure to determine the value for any duplicate keys.
    ///
    /// Use the `combine` closure to select a value to use in the updated
    /// dictionary, or to combine existing and new values. As the key-value
    /// pairs are merged with the dictionary, the `combine` closure is called
    /// with the current and new values for any duplicate keys that are
    /// encountered.
    ///
    /// This example shows how to choose the current or new values for any
    /// duplicate keys:
    ///
    ///     var dictionary = ["a": 1, "b": 2]
    ///
    ///     // Keeping existing value for key "a":
    ///     dictionary.merge(zip(["a", "c"], [3, 4])) { (current, _) in current }
    ///     // ["b": 2, "a": 1, "c": 4]
    ///
    ///     // Taking the new value for key "a":
    ///     dictionary.merge(zip(["a", "d"], [5, 6])) { (_, new) in new }
    ///     // ["b": 2, "a": 5, "c": 4, "d": 6]
    ///
    /// - Parameters:
    ///   - other:  A sequence of key-value pairs.
    ///   - combine: A closure that takes the current and new values for any
    ///     duplicate keys. The closure returns the desired value for the final
    ///     dictionary.
    @inlinable public mutating func merge<S>(_ other: S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows where S : Sequence, S.Element == (Key, Value)

    /// Merges the given dictionary into this dictionary, using a combining
    /// closure to determine the value for any duplicate keys.
    ///
    /// Use the `combine` closure to select a value to use in the updated
    /// dictionary, or to combine existing and new values. As the key-values
    /// pairs in `other` are merged with this dictionary, the `combine` closure
    /// is called with the current and new values for any duplicate keys that
    /// are encountered.
    ///
    /// This example shows how to choose the current or new values for any
    /// duplicate keys:
    ///
    ///     var dictionary = ["a": 1, "b": 2]
    ///
    ///     // Keeping existing value for key "a":
    ///     dictionary.merge(["a": 3, "c": 4]) { (current, _) in current }
    ///     // ["b": 2, "a": 1, "c": 4]
    ///
    ///     // Taking the new value for key "a":
    ///     dictionary.merge(["a": 5, "d": 6]) { (_, new) in new }
    ///     // ["b": 2, "a": 5, "c": 4, "d": 6]
    ///
    /// - Parameters:
    ///   - other:  A dictionary to merge.
    ///   - combine: A closure that takes the current and new values for any
    ///     duplicate keys. The closure returns the desired value for the final
    ///     dictionary.
    @inlinable public mutating func merge(_ other: [Key : Value], uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows

    /// Creates a dictionary by merging key-value pairs in a sequence into the
    /// dictionary, using a combining closure to determine the value for
    /// duplicate keys.
    ///
    /// Use the `combine` closure to select a value to use in the returned
    /// dictionary, or to combine existing and new values. As the key-value
    /// pairs are merged with the dictionary, the `combine` closure is called
    /// with the current and new values for any duplicate keys that are
    /// encountered.
    ///
    /// This example shows how to choose the current or new values for any
    /// duplicate keys:
    ///
    ///     let dictionary = ["a": 1, "b": 2]
    ///     let newKeyValues = zip(["a", "b"], [3, 4])
    ///
    ///     let keepingCurrent = dictionary.merging(newKeyValues) { (current, _) in current }
    ///     // ["b": 2, "a": 1]
    ///     let replacingCurrent = dictionary.merging(newKeyValues) { (_, new) in new }
    ///     // ["b": 4, "a": 3]
    ///
    /// - Parameters:
    ///   - other:  A sequence of key-value pairs.
    ///   - combine: A closure that takes the current and new values for any
    ///     duplicate keys. The closure returns the desired value for the final
    ///     dictionary.
    /// - Returns: A new dictionary with the combined keys and values of this
    ///   dictionary and `other`.
    @inlinable public func merging<S>(_ other: S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows -> [Key : Value] where S : Sequence, S.Element == (Key, Value)

    /// Creates a dictionary by merging the given dictionary into this
    /// dictionary, using a combining closure to determine the value for
    /// duplicate keys.
    ///
    /// Use the `combine` closure to select a value to use in the returned
    /// dictionary, or to combine existing and new values. As the key-value
    /// pairs in `other` are merged with this dictionary, the `combine` closure
    /// is called with the current and new values for any duplicate keys that
    /// are encountered.
    ///
    /// This example shows how to choose the current or new values for any
    /// duplicate keys:
    ///
    ///     let dictionary = ["a": 1, "b": 2]
    ///     let otherDictionary = ["a": 3, "b": 4]
    ///
    ///     let keepingCurrent = dictionary.merging(otherDictionary)
    ///           { (current, _) in current }
    ///     // ["b": 2, "a": 1]
    ///     let replacingCurrent = dictionary.merging(otherDictionary)
    ///           { (_, new) in new }
    ///     // ["b": 4, "a": 3]
    ///
    /// - Parameters:
    ///   - other:  A dictionary to merge.
    ///   - combine: A closure that takes the current and new values for any
    ///     duplicate keys. The closure returns the desired value for the final
    ///     dictionary.
    /// - Returns: A new dictionary with the combined keys and values of this
    ///   dictionary and `other`.
    @inlinable public func merging(_ other: [Key : Value], uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows -> [Key : Value]

    /// Removes and returns the key-value pair at the specified index.
    ///
    /// Calling this method invalidates any existing indices for use with this
    /// dictionary.
    ///
    /// - Parameter index: The position of the key-value pair to remove. `index`
    ///   must be a valid index of the dictionary, and must not equal the
    ///   dictionary's end index.
    /// - Returns: The key-value pair that correspond to `index`.
    ///
    /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the
    ///   dictionary.
    @inlinable public mutating func remove(at index: Dictionary<Key, Value>.Index) -> [Key : Value].Element

    /// Removes the given key and its associated value from the dictionary.
    ///
    /// If the key is found in the dictionary, this method returns the key's
    /// associated value. On removal, this method invalidates all indices with
    /// respect to the dictionary.
    ///
    ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     if let value = hues.removeValue(forKey: "Coral") {
    ///         print("The value \(value) was removed.")
    ///     }
    ///     // Prints "The value 16 was removed."
    ///
    /// If the key isn't found in the dictionary, `removeValue(forKey:)` returns
    /// `nil`.
    ///
    ///     if let value = hues.removeValueForKey("Cerise") {
    ///         print("The value \(value) was removed.")
    ///     } else {
    ///         print("No value found for that key.")
    ///     }
    ///     // Prints "No value found for that key.""
    ///
    /// - Parameter key: The key to remove along with its associated value.
    /// - Returns: The value that was removed, or `nil` if the key was not
    ///   present in the dictionary.
    ///
    /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the
    ///   dictionary.
    @inlinable public mutating func removeValue(forKey key: Key) -> Value?

    /// Removes all key-value pairs from the dictionary.
    ///
    /// Calling this method invalidates all indices with respect to the
    /// dictionary.
    ///
    /// - Parameter keepCapacity: Whether the dictionary should keep its
    ///   underlying buffer. If you pass `true`, the operation preserves the
    ///   buffer capacity that the collection has, otherwise the underlying
    ///   buffer is released.  The default is `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the
    ///   dictionary.
    @inlinable public mutating func removeAll(keepingCapacity keepCapacity: Bool = false)

    /// A collection containing just the keys of the dictionary.
    ///
    /// When iterated over, keys appear in this collection in the same order as
    /// they occur in the dictionary's key-value pairs. Each key in the keys
    /// collection has a unique value.
    ///
    ///     let countryCodes = ["BR": "Brazil", "GH": "Ghana", "JP": "Japan"]
    ///     print(countryCodes)
    ///     // Prints "["BR": "Brazil", "JP": "Japan", "GH": "Ghana"]"
    ///
    ///     for k in countryCodes.keys {
    ///         print(k)
    ///     }
    ///     // Prints "BR"
    ///     // Prints "JP"
    ///     // Prints "GH"
    @available(swift 4.0)
    @inlinable public var keys: Dictionary<Key, Value>.Keys { get }

    /// A collection containing just the values of the dictionary.
    ///
    /// When iterated over, values appear in this collection in the same order as
    /// they occur in the dictionary's key-value pairs.
    ///
    ///     let countryCodes = ["BR": "Brazil", "GH": "Ghana", "JP": "Japan"]
    ///     print(countryCodes)
    ///     // Prints "["BR": "Brazil", "JP": "Japan", "GH": "Ghana"]"
    ///
    ///     for v in countryCodes.values {
    ///         print(v)
    ///     }
    ///     // Prints "Brazil"
    ///     // Prints "Japan"
    ///     // Prints "Ghana"
    @available(swift 4.0)
    @inlinable public var values: Dictionary<Key, Value>.Values

    /// A view of a dictionary's keys.
    public struct Keys : Collection, Equatable, CustomStringConvertible, CustomDebugStringConvertible {

        /// A type representing the sequence's elements.
        public typealias Element = Key

        /// A sequence that represents a contiguous subrange of the collection's
        /// elements.
        ///
        /// This associated type appears as a requirement in the `Sequence`
        /// protocol, but it is restated here with stricter constraints. In a
        /// collection, the subsequence should also conform to `Collection`.
        public typealias SubSequence = Slice<Dictionary<Key, Value>.Keys>

        /// The position of the first element in a nonempty collection.
        ///
        /// If the collection is empty, `startIndex` is equal to `endIndex`.
        @inlinable public var startIndex: Dictionary<Key, Value>.Index { get }

        /// The collection's "past the end" position---that is, the position one
        /// greater than the last valid subscript argument.
        ///
        /// When you need a range that includes the last element of a collection, use
        /// the half-open range operator (`..<`) with `endIndex`. The `..<` operator
        /// creates a range that doesn't include the upper bound, so it's always
        /// safe to use with `endIndex`. For example:
        ///
        ///     let numbers = [10, 20, 30, 40, 50]
        ///     if let index = numbers.firstIndex(of: 30) {
        ///         print(numbers[index ..< numbers.endIndex])
        ///     }
        ///     // Prints "[30, 40, 50]"
        ///
        /// If the collection is empty, `endIndex` is equal to `startIndex`.
        @inlinable public var endIndex: Dictionary<Key, Value>.Index { get }

        /// Returns the position immediately after the given index.
        ///
        /// The successor of an index must be well defined. For an index `i` into a
        /// collection `c`, calling `c.index(after: i)` returns the same index every
        /// time.
        ///
        /// - Parameter i: A valid index of the collection. `i` must be less than
        ///   `endIndex`.
        /// - Returns: The index value immediately after `i`.
        @inlinable public func index(after i: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Index

        /// Replaces the given index with its successor.
        ///
        /// - Parameter i: A valid index of the collection. `i` must be less than
        ///   `endIndex`.
        @inlinable public func formIndex(after i: inout Dictionary<Key, Value>.Index)

        /// Accesses the element at the specified position.
        ///
        /// The following example accesses an element of an array through its
        /// subscript to print its value:
        ///
        ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
        ///     print(streets[1])
        ///     // Prints "Bryant"
        ///
        /// You can subscript a collection with any valid index other than the
        /// collection's end index. The end index refers to the position one past
        /// the last element of a collection, so it doesn't correspond with an
        /// element.
        ///
        /// - Parameter position: The position of the element to access. `position`
        ///   must be a valid index of the collection that is not equal to the
        ///   `endIndex` property.
        ///
        /// - Complexity: O(1)
        @inlinable public subscript(position: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Keys.Element { get }

        /// The number of keys in the dictionary.
        ///
        /// - Complexity: O(1).
        @inlinable public var count: Int { get }

        /// A Boolean value indicating whether the collection is empty.
        ///
        /// When you need to check whether your collection is empty, use the
        /// `isEmpty` property instead of checking that the `count` property is
        /// equal to zero. For collections that don't conform to
        /// `RandomAccessCollection`, accessing the `count` property iterates
        /// through the elements of the collection.
        ///
        ///     let horseName = "Silver"
        ///     if horseName.isEmpty {
        ///         print("I've been through the desert on a horse with no name.")
        ///     } else {
        ///         print("Hi ho, \(horseName)!")
        ///     }
        ///     // Prints "Hi ho, Silver!"
        ///
        /// - Complexity: O(1)
        @inlinable public var isEmpty: Bool { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        @inlinable public static func == (lhs: Dictionary<Key, Value>.Keys, rhs: Dictionary<Key, Value>.Keys) -> Bool

        /// A textual representation of this instance.
        ///
        /// Calling this property directly is discouraged. Instead, convert an
        /// instance of any type to a string by using the `String(describing:)`
        /// initializer. This initializer works with any type, and uses the custom
        /// `description` property for types that conform to
        /// `CustomStringConvertible`:
        ///
        ///     struct Point: CustomStringConvertible {
        ///         let x: Int, y: Int
        ///
        ///         var description: String {
        ///             return "(\(x), \(y))"
        ///         }
        ///     }
        ///
        ///     let p = Point(x: 21, y: 30)
        ///     let s = String(describing: p)
        ///     print(s)
        ///     // Prints "(21, 30)"
        ///
        /// The conversion of `p` to a string in the assignment to `s` uses the
        /// `Point` type's `description` property.
        public var description: String { get }

        /// A textual representation of this instance, suitable for debugging.
        ///
        /// Calling this property directly is discouraged. Instead, convert an
        /// instance of any type to a string by using the `String(reflecting:)`
        /// initializer. This initializer works with any type, and uses the custom
        /// `debugDescription` property for types that conform to
        /// `CustomDebugStringConvertible`:
        ///
        ///     struct Point: CustomDebugStringConvertible {
        ///         let x: Int, y: Int
        ///
        ///         var debugDescription: String {
        ///             return "(\(x), \(y))"
        ///         }
        ///     }
        ///
        ///     let p = Point(x: 21, y: 30)
        ///     let s = String(reflecting: p)
        ///     print(s)
        ///     // Prints "(21, 30)"
        ///
        /// The conversion of `p` to a string in the assignment to `s` uses the
        /// `Point` type's `debugDescription` property.
        public var debugDescription: String { get }

        /// A type that represents a position in the collection.
        ///
        /// Valid indices consist of the position of every element and a
        /// "past the end" position that's not valid for use as a subscript
        /// argument.
        public typealias Index = Dictionary<Key, Value>.Index

        /// A type that represents the indices that are valid for subscripting the
        /// collection, in ascending order.
        public typealias Indices = DefaultIndices<Dictionary<Key, Value>.Keys>
    }

    /// A view of a dictionary's values.
    public struct Values : MutableCollection, CustomStringConvertible, CustomDebugStringConvertible {

        /// A type representing the sequence's elements.
        public typealias Element = Value

        /// The position of the first element in a nonempty collection.
        ///
        /// If the collection is empty, `startIndex` is equal to `endIndex`.
        @inlinable public var startIndex: Dictionary<Key, Value>.Index { get }

        /// The collection's "past the end" position---that is, the position one
        /// greater than the last valid subscript argument.
        ///
        /// When you need a range that includes the last element of a collection, use
        /// the half-open range operator (`..<`) with `endIndex`. The `..<` operator
        /// creates a range that doesn't include the upper bound, so it's always
        /// safe to use with `endIndex`. For example:
        ///
        ///     let numbers = [10, 20, 30, 40, 50]
        ///     if let index = numbers.firstIndex(of: 30) {
        ///         print(numbers[index ..< numbers.endIndex])
        ///     }
        ///     // Prints "[30, 40, 50]"
        ///
        /// If the collection is empty, `endIndex` is equal to `startIndex`.
        @inlinable public var endIndex: Dictionary<Key, Value>.Index { get }

        /// Returns the position immediately after the given index.
        ///
        /// The successor of an index must be well defined. For an index `i` into a
        /// collection `c`, calling `c.index(after: i)` returns the same index every
        /// time.
        ///
        /// - Parameter i: A valid index of the collection. `i` must be less than
        ///   `endIndex`.
        /// - Returns: The index value immediately after `i`.
        @inlinable public func index(after i: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Index

        /// Replaces the given index with its successor.
        ///
        /// - Parameter i: A valid index of the collection. `i` must be less than
        ///   `endIndex`.
        @inlinable public func formIndex(after i: inout Dictionary<Key, Value>.Index)

        /// Accesses the element at the specified position.
        ///
        /// For example, you can replace an element of an array by using its
        /// subscript.
        ///
        ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
        ///     streets[1] = "Butler"
        ///     print(streets[1])
        ///     // Prints "Butler"
        ///
        /// You can subscript a collection with any valid index other than the
        /// collection's end index. The end index refers to the position one
        /// past the last element of a collection, so it doesn't correspond with an
        /// element.
        ///
        /// - Parameter position: The position of the element to access. `position`
        ///   must be a valid index of the collection that is not equal to the
        ///   `endIndex` property.
        ///
        /// - Complexity: O(1)
        @inlinable public subscript(position: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Values.Element

        /// The number of values in the dictionary.
        ///
        /// - Complexity: O(1).
        @inlinable public var count: Int { get }

        /// A Boolean value indicating whether the collection is empty.
        ///
        /// When you need to check whether your collection is empty, use the
        /// `isEmpty` property instead of checking that the `count` property is
        /// equal to zero. For collections that don't conform to
        /// `RandomAccessCollection`, accessing the `count` property iterates
        /// through the elements of the collection.
        ///
        ///     let horseName = "Silver"
        ///     if horseName.isEmpty {
        ///         print("I've been through the desert on a horse with no name.")
        ///     } else {
        ///         print("Hi ho, \(horseName)!")
        ///     }
        ///     // Prints "Hi ho, Silver!"
        ///
        /// - Complexity: O(1)
        @inlinable public var isEmpty: Bool { get }

        /// A textual representation of this instance.
        ///
        /// Calling this property directly is discouraged. Instead, convert an
        /// instance of any type to a string by using the `String(describing:)`
        /// initializer. This initializer works with any type, and uses the custom
        /// `description` property for types that conform to
        /// `CustomStringConvertible`:
        ///
        ///     struct Point: CustomStringConvertible {
        ///         let x: Int, y: Int
        ///
        ///         var description: String {
        ///             return "(\(x), \(y))"
        ///         }
        ///     }
        ///
        ///     let p = Point(x: 21, y: 30)
        ///     let s = String(describing: p)
        ///     print(s)
        ///     // Prints "(21, 30)"
        ///
        /// The conversion of `p` to a string in the assignment to `s` uses the
        /// `Point` type's `description` property.
        public var description: String { get }

        /// A textual representation of this instance, suitable for debugging.
        ///
        /// Calling this property directly is discouraged. Instead, convert an
        /// instance of any type to a string by using the `String(reflecting:)`
        /// initializer. This initializer works with any type, and uses the custom
        /// `debugDescription` property for types that conform to
        /// `CustomDebugStringConvertible`:
        ///
        ///     struct Point: CustomDebugStringConvertible {
        ///         let x: Int, y: Int
        ///
        ///         var debugDescription: String {
        ///             return "(\(x), \(y))"
        ///         }
        ///     }
        ///
        ///     let p = Point(x: 21, y: 30)
        ///     let s = String(reflecting: p)
        ///     print(s)
        ///     // Prints "(21, 30)"
        ///
        /// The conversion of `p` to a string in the assignment to `s` uses the
        /// `Point` type's `debugDescription` property.
        public var debugDescription: String { get }

        /// Exchanges the values at the specified indices of the collection.
        ///
        /// Both parameters must be valid indices of the collection and not
        /// equal to `endIndex`. Passing the same index as both `i` and `j` has no
        /// effect.
        ///
        /// - Parameters:
        ///   - i: The index of the first value to swap.
        ///   - j: The index of the second value to swap.
        ///
        /// - Complexity: O(1)
        @inlinable public mutating func swapAt(_ i: Dictionary<Key, Value>.Index, _ j: Dictionary<Key, Value>.Index)

        /// A type that represents a position in the collection.
        ///
        /// Valid indices consist of the position of every element and a
        /// "past the end" position that's not valid for use as a subscript
        /// argument.
        public typealias Index = Dictionary<Key, Value>.Index

        /// A sequence that represents a contiguous subrange of the collection's
        /// elements.
        ///
        /// This associated type appears as a requirement in the `Sequence`
        /// protocol, but it is restated here with stricter constraints. In a
        /// collection, the subsequence should also conform to `Collection`.
        public typealias SubSequence = Slice<Dictionary<Key, Value>.Values>

        /// A type that represents the indices that are valid for subscripting the
        /// collection, in ascending order.
        public typealias Indices = DefaultIndices<Dictionary<Key, Value>.Values>
    }

    /// The position of a key-value pair in a dictionary.
    ///
    /// Dictionary has two subscripting interfaces:
    ///
    /// 1. Subscripting with a key, yielding an optional value:
    ///
    ///        v = d[k]!
    ///
    /// 2. Subscripting with an index, yielding a key-value pair:
    ///
    ///        (k, v) = d[i]
    public struct Index {
    }

    /// An iterator over the members of a `Dictionary<Key, Value>`.
    public struct Iterator {
    }

    /// Removes and returns the first key-value pair of the dictionary if the
    /// dictionary isn't empty.
    ///
    /// The first element of the dictionary is not necessarily the first element
    /// added. Don't expect any particular ordering of key-value pairs.
    ///
    /// - Returns: The first key-value pair of the dictionary if the dictionary
    ///   is not empty; otherwise, `nil`.
    ///
    /// - Complexity: Averages to O(1) over many calls to `popFirst()`.
    @inlinable public mutating func popFirst() -> [Key : Value].Element?

    /// The total number of key-value pairs that the dictionary can contain without
    /// allocating new storage.
    @inlinable public var capacity: Int { get }

    /// Reserves enough space to store the specified number of key-value pairs.
    ///
    /// If you are adding a known number of key-value pairs to a dictionary, use this
    /// method to avoid multiple reallocations. This method ensures that the
    /// dictionary has unique, mutable, contiguous storage, with space allocated
    /// for at least the requested number of key-value pairs.
    ///
    /// Calling the `reserveCapacity(_:)` method on a dictionary with bridged
    /// storage triggers a copy to contiguous storage even if the existing
    /// storage has room to store `minimumCapacity` key-value pairs.
    ///
    /// - Parameter minimumCapacity: The requested number of key-value pairs to
    ///   store.
    public mutating func reserveCapacity(_ minimumCapacity: Int)

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    @inlinable public func map<T>(_ transform: ((key: Key, value: Value)) throws -> T) rethrows -> [T]

    /// Returns a subsequence containing all but the given number of initial
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in
    /// the collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropFirst(2))
    ///     // Prints "[3, 4, 5]"
    ///     print(numbers.dropFirst(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop from the beginning of
    ///   the collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence starting after the specified number of
    ///   elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to drop from the beginning of the collection.
    @inlinable public func dropFirst(_ k: Int = 1) -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence containing all but the specified number of final
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in the
    /// collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropLast(2))
    ///     // Prints "[1, 2, 3]"
    ///     print(numbers.dropLast(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop off the end of the
    ///   collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence that leaves off the specified number of elements
    ///   at the end.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func dropLast(_ k: Int = 1) -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence by skipping elements while `predicate` returns
    /// `true` and returning the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be skipped or `false` if it should be included. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func drop(while predicate: ((key: Key, value: Value)) throws -> Bool) rethrows -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence, up to the specified maximum length, containing
    /// the initial elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.prefix(2))
    ///     // Prints "[1, 2]"
    ///     print(numbers.prefix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return.
    ///   `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence starting at the beginning of this collection
    ///   with at most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to select from the beginning of the collection.
    @inlinable public func prefix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence containing the initial elements until `predicate`
    /// returns `false` and skipping the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be included or `false` if it should be excluded. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func prefix(while predicate: ((key: Key, value: Value)) throws -> Bool) rethrows -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence, up to the given maximum length, containing the
    /// final elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.suffix(2))
    ///     // Prints "[4, 5]"
    ///     print(numbers.suffix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return. The
    ///   value of `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence terminating at the end of the collection with at
    ///   most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func suffix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence from the start of the collection up to, but not
    /// including, the specified position.
    ///
    /// The resulting subsequence *does not include* the element at the position
    /// `end`. The following example searches for the index of the number `40`
    /// in an array of integers, and then prints the prefix of the array up to,
    /// but not including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(upTo: i))
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// Passing the collection's starting index as the `end` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.prefix(upTo: numbers.startIndex))
    ///     // Prints "[]"
    ///
    /// Using the `prefix(upTo:)` method is equivalent to using a partial
    /// half-open range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(upTo:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[..<i])
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// - Parameter end: The "past the end" index of the resulting subsequence.
    ///   `end` must be a valid index of the collection.
    /// - Returns: A subsequence up to, but not including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(upTo end: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence from the specified position to the end of the
    /// collection.
    ///
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the suffix of the array starting at
    /// that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.suffix(from: i))
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// Passing the collection's `endIndex` as the `start` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.suffix(from: numbers.endIndex))
    ///     // Prints "[]"
    ///
    /// Using the `suffix(from:)` method is equivalent to using a partial range
    /// from the index as the collection's subscript. The subscript notation is
    /// preferred over `suffix(from:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[i...])
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// - Parameter start: The index at which to start the resulting subsequence.
    ///   `start` must be a valid index of the collection.
    /// - Returns: A subsequence starting at the `start` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func suffix(from start: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>>

    /// Returns a subsequence from the start of the collection through the
    /// specified position.
    ///
    /// The resulting subsequence *includes* the element at the position `end`.
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the prefix of the array up to, and
    /// including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(through: i))
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// Using the `prefix(through:)` method is equivalent to using a partial
    /// closed range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(through:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[...i])
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// - Parameter end: The index of the last element to include in the
    ///   resulting subsequence. `end` must be a valid index of the collection
    ///   that is not equal to the `endIndex` property.
    /// - Returns: A subsequence up to, and including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(through position: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>>

    /// Returns the longest possible subsequences of the collection, in order,
    /// that don't contain elements satisfying the given predicate.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the sequence are not returned as part of
    /// any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string using a
    /// closure that matches spaces. The first use of `split` returns each word
    /// that was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(maxSplits: 1, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(omittingEmptySubsequences: false, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - maxSplits: The maximum number of times to split the collection, or
    ///     one less than the number of subsequences to return. If
    ///     `maxSplits + 1` subsequences are returned, the last one is a suffix
    ///     of the original collection containing the remaining elements.
    ///     `maxSplits` must be greater than or equal to zero. The default value
    ///     is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each pair of consecutive elements
    ///     satisfying the `isSeparator` predicate and for each element at the
    ///     start or end of the collection satisfying the `isSeparator`
    ///     predicate. The default value is `true`.
    ///   - isSeparator: A closure that takes an element as an argument and
    ///     returns a Boolean value indicating whether the collection should be
    ///     split at that element.
    /// - Returns: An array of subsequences, split from this collection's
    ///   elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: ((key: Key, value: Value)) throws -> Bool) rethrows -> [Slice<Dictionary<Key, Value>>]

    /// Returns the first index in which an element of the collection satisfies
    /// the given predicate.
    ///
    /// You can use the predicate to find an element of a type that doesn't
    /// conform to the `Equatable` protocol or to find an element that matches
    /// particular criteria. Here's an example that finds a student name that
    /// begins with the letter "A":
    ///
    ///     let students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     if let i = students.firstIndex(where: { $0.hasPrefix("A") }) {
    ///         print("\(students[i]) starts with 'A'!")
    ///     }
    ///     // Prints "Abena starts with 'A'!"
    ///
    /// - Parameter predicate: A closure that takes an element as its argument
    ///   and returns a Boolean value that indicates whether the passed element
    ///   represents a match.
    /// - Returns: The index of the first element for which `predicate` returns
    ///   `true`. If no elements in the collection satisfy the given predicate,
    ///   returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func firstIndex(where predicate: ((key: Key, value: Value)) throws -> Bool) rethrows -> Dictionary<Key, Value>.Index?

    /// Returns the elements of the sequence, shuffled using the given generator
    /// as a source for randomness.
    ///
    /// You use this method to randomize the elements of a sequence when you are
    /// using a custom random number generator. For example, you can shuffle the
    /// numbers between `0` and `9` by calling the `shuffled(using:)` method on
    /// that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled(using: &myGenerator)
    ///     // shuffledNumbers == [8, 9, 4, 3, 2, 6, 7, 0, 5, 1]
    ///
    /// - Parameter generator: The random number generator to use when shuffling
    ///   the sequence.
    /// - Returns: An array of this sequence's elements in a shuffled order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    /// - Note: The algorithm used to shuffle a sequence may change in a future
    ///   version of Swift. If you're passing a generator that results in the
    ///   same shuffled order each time you run your program, that sequence may
    ///   change when your program is compiled using a different version of
    ///   Swift.
    @inlinable public func shuffled<T>(using generator: inout T) -> [(key: Key, value: Value)] where T : RandomNumberGenerator

    /// Returns the elements of the sequence, shuffled.
    ///
    /// For example, you can shuffle the numbers between `0` and `9` by calling
    /// the `shuffled()` method on that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled()
    ///     // shuffledNumbers == [1, 7, 6, 2, 8, 9, 4, 3, 5, 0]
    ///
    /// This method is equivalent to calling `shuffled(using:)`, passing in the
    /// system's default random generator.
    ///
    /// - Returns: A shuffled array of this sequence's elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func shuffled() -> [(key: Key, value: Value)]

    /// The indices that are valid for subscripting the collection, in ascending
    /// order.
    ///
    /// A collection's `indices` property can hold a strong reference to the
    /// collection itself, causing the collection to be non-uniquely referenced.
    /// If you mutate the collection while iterating over its indices, a strong
    /// reference can cause an unexpected copy of the collection. To avoid the
    /// unexpected copy, use the `index(after:)` method starting with
    /// `startIndex` to produce indices instead.
    ///
    ///     var c = MyFancyCollection([10, 20, 30, 40, 50])
    ///     var i = c.startIndex
    ///     while i != c.endIndex {
    ///         c[i] /= 5
    ///         i = c.index(after: i)
    ///     }
    ///     // c == MyFancyCollection([2, 4, 6, 8, 10])
    @inlinable public var indices: DefaultIndices<Dictionary<Key, Value>> { get }

    /// A sequence containing the same elements as this sequence,
    /// but on which some operations, such as `map` and `filter`, are
    /// implemented lazily.
    @inlinable public var lazy: LazySequence<Dictionary<Key, Value>> { get }

    @available(swift, deprecated: 4.1, renamed: "compactMap(_:)", message: "Please use compactMap(_:) for the case where closure returns an optional value")
    public func flatMap<ElementOfResult>(_ transform: ((key: Key, value: Value)) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Accesses the contiguous subrange of the collection's elements specified
    /// by a range expression.
    ///
    /// The range expression is converted to a concrete subrange relative to this
    /// collection. For example, using a `PartialRangeFrom` range expression
    /// with an array accesses the subrange from the start of the range
    /// expression until the end of the array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2...]
    ///     print(streetsSlice)
    ///     // ["Channing", "Douglas", "Evarts"]
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection uses. This example searches `streetsSlice` for one
    /// of the strings in the slice, and then uses that index in the original
    /// array.
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // "Evarts"
    ///
    /// Always use the slice's `startIndex` property instead of assuming that its
    /// indices start at a particular value. Attempting to access an element by
    /// using an index outside the bounds of the slice's indices may result in a
    /// runtime error, even if that index is valid for the original collection.
    ///
    ///     print(streetsSlice.startIndex)
    ///     // 2
    ///     print(streetsSlice[2])
    ///     // "Channing"
    ///
    ///     print(streetsSlice[0])
    ///     // error: Index out of bounds
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript<R>(r: R) -> Slice<Dictionary<Key, Value>> where R : RangeExpression, Self.Index == R.Bound { get }

    @inlinable public subscript(x: (UnboundedRange_) -> ()) -> Slice<Dictionary<Key, Value>> { get }

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func map<T>(_ transform: ((key: Key, value: Value)) throws -> T) rethrows -> [T]

    /// A value less than or equal to the number of elements in the sequence,
    /// calculated nondestructively.
    ///
    /// The default implementation returns 0. If you provide your own
    /// implementation, make sure to compute the value nondestructively.
    ///
    /// - Complexity: O(1), except if the sequence also conforms to `Collection`.
    ///   In this case, see the documentation of `Collection.underestimatedCount`.
    @inlinable public var underestimatedCount: Int { get }

    /// Calls the given closure on each element in the sequence in the same order
    /// as a `for`-`in` loop.
    ///
    /// The two loops in the following example produce the same output:
    ///
    ///     let numberWords = ["one", "two", "three"]
    ///     for word in numberWords {
    ///         print(word)
    ///     }
    ///     // Prints "one"
    ///     // Prints "two"
    ///     // Prints "three"
    ///
    ///     numberWords.forEach { word in
    ///         print(word)
    ///     }
    ///     // Same as above
    ///
    /// Using the `forEach` method is distinct from a `for`-`in` loop in two
    /// important ways:
    ///
    /// 1. You cannot use a `break` or `continue` statement to exit the current
    ///    call of the `body` closure or skip subsequent calls.
    /// 2. Using the `return` statement in the `body` closure will exit only from
    ///    the current call to `body`, not from any outer scope, and won't skip
    ///    subsequent calls.
    ///
    /// - Parameter body: A closure that takes an element of the sequence as a
    ///   parameter.
    @inlinable public func forEach(_ body: ((key: Key, value: Value)) throws -> Void) rethrows

    /// Returns the first element of the sequence that satisfies the given
    /// predicate.
    ///
    /// The following example uses the `first(where:)` method to find the first
    /// negative number in an array of integers:
    ///
    ///     let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
    ///     if let firstNegative = numbers.first(where: { $0 < 0 }) {
    ///         print("The first negative number is \(firstNegative).")
    ///     }
    ///     // Prints "The first negative number is -2."
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence as
    ///   its argument and returns a Boolean value indicating whether the
    ///   element is a match.
    /// - Returns: The first element of the sequence that satisfies `predicate`,
    ///   or `nil` if there is no element that satisfies `predicate`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func first(where predicate: ((key: Key, value: Value)) throws -> Bool) rethrows -> (key: Key, value: Value)?

    /// Call `body(p)`, where `p` is a pointer to the collection's
    /// contiguous storage.  If no such storage exists, it is
    /// first created.  If the collection does not support an internal
    /// representation in a form of contiguous storage, `body` is not
    /// called and `nil` is returned.
    ///
    /// A `Collection` that provides its own implementation of this method
    /// must also guarantee that an equivalent buffer of its `SubSequence`
    /// can be generated by advancing the pointer by the distance to the
    /// slice's `startIndex`.
    @inlinable public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<(key: Key, value: Value)>) throws -> R) rethrows -> R?

    /// Returns a sequence of pairs (*n*, *x*), where *n* represents a
    /// consecutive integer starting at zero and *x* represents an element of
    /// the sequence.
    ///
    /// This example enumerates the characters of the string "Swift" and prints
    /// each character along with its place in the string.
    ///
    ///     for (n, c) in "Swift".enumerated() {
    ///         print("\(n): '\(c)'")
    ///     }
    ///     // Prints "0: 'S'"
    ///     // Prints "1: 'w'"
    ///     // Prints "2: 'i'"
    ///     // Prints "3: 'f'"
    ///     // Prints "4: 't'"
    ///
    /// When you enumerate a collection, the integer part of each pair is a counter
    /// for the enumeration, but is not necessarily the index of the paired value.
    /// These counters can be used as indices only in instances of zero-based,
    /// integer-indexed collections, such as `Array` and `ContiguousArray`. For
    /// other collections the counters may be out of range or of the wrong type
    /// to use as an index. To iterate over the elements of a collection with its
    /// indices, use the `zip(_:_:)` function.
    ///
    /// This example iterates over the indices and elements of a set, building a
    /// list consisting of indices of names with five or fewer letters.
    ///
    ///     let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     var shorterIndices: [Set<String>.Index] = []
    ///     for (i, name) in zip(names.indices, names) {
    ///         if name.count <= 5 {
    ///             shorterIndices.append(i)
    ///         }
    ///     }
    ///
    /// Now that the `shorterIndices` array holds the indices of the shorter
    /// names in the `names` set, you can use those indices to access elements in
    /// the set.
    ///
    ///     for i in shorterIndices {
    ///         print(names[i])
    ///     }
    ///     // Prints "Sofia"
    ///     // Prints "Mateo"
    ///
    /// - Returns: A sequence of pairs enumerating the sequence.
    ///
    /// - Complexity: O(1)
    @inlinable public func enumerated() -> EnumeratedSequence<Dictionary<Key, Value>>

    /// Returns the minimum element in the sequence, using the given predicate as
    /// the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `min(by:)` method on a
    /// dictionary to find the key-value pair with the lowest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let leastHue = hues.min { a, b in a.value < b.value }
    ///     print(leastHue)
    ///     // Prints "Optional(("Coral", 16))"
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true`
    ///   if its first argument should be ordered before its second
    ///   argument; otherwise, `false`.
    /// - Returns: The sequence's minimum element, according to
    ///   `areInIncreasingOrder`. If the sequence has no elements, returns
    ///   `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func min(by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> (key: Key, value: Value)?

    /// Returns the maximum element in the sequence, using the given predicate
    /// as the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `max(by:)` method on a
    /// dictionary to find the key-value pair with the highest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let greatestHue = hues.max { a, b in a.value < b.value }
    ///     print(greatestHue)
    ///     // Prints "Optional(("Heliotrope", 296))"
    ///
    /// - Parameter areInIncreasingOrder:  A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: The sequence's maximum element if the sequence is not empty;
    ///   otherwise, `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func max(by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> (key: Key, value: Value)?

    /// Returns a Boolean value indicating whether the initial elements of the
    /// sequence are equivalent to the elements in another sequence, using
    /// the given predicate as the equivalence test.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - possiblePrefix: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if the initial elements of the sequence are equivalent
    ///   to the elements of `possiblePrefix`; otherwise, `false`. If
    ///   `possiblePrefix` has no elements, the return value is `true`.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `possiblePrefix`.
    @inlinable public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: ((key: Key, value: Value), PossiblePrefix.Element) throws -> Bool) rethrows -> Bool where PossiblePrefix : Sequence

    /// Returns a Boolean value indicating whether this sequence and another
    /// sequence contain equivalent elements in the same order, using the given
    /// predicate as the equivalence test.
    ///
    /// At least one of the sequences must be finite.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if this sequence and `other` contain equivalent items,
    ///   using `areEquivalent` as the equivalence test; otherwise, `false.`
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: ((key: Key, value: Value), OtherSequence.Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence

    /// Returns a Boolean value indicating whether the sequence precedes another
    /// sequence in a lexicographical (dictionary) ordering, using the given
    /// predicate to compare elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areInIncreasingOrder:  A predicate that returns `true` if its first
    ///     argument should be ordered before its second argument; otherwise,
    ///     `false`.
    /// - Returns: `true` if this sequence precedes `other` in a dictionary
    ///   ordering as ordered by `areInIncreasingOrder`; otherwise, `false`.
    ///
    /// - Note: This method implements the mathematical notion of lexicographical
    ///   ordering, which has no connection to Unicode.  If you are sorting
    ///   strings to present to the end user, use `String` APIs that perform
    ///   localized comparison instead.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns a Boolean value indicating whether the sequence contains an
    /// element that satisfies the given predicate.
    ///
    /// You can use the predicate to check for an element of a type that
    /// doesn't conform to the `Equatable` protocol, such as the
    /// `HTTPResponse` enumeration in this example.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let lastThreeResponses: [HTTPResponse] = [.ok, .ok, .error(404)]
    ///     let hadError = lastThreeResponses.contains { element in
    ///         if case .error = element {
    ///             return true
    ///         } else {
    ///             return false
    ///         }
    ///     }
    ///     // 'hadError' == true
    ///
    /// Alternatively, a predicate can be satisfied by a range of `Equatable`
    /// elements or a general condition. This example shows how you can check an
    /// array for an expense greater than $100.
    ///
    ///     let expenses = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
    ///     let hasBigPurchase = expenses.contains { $0 > 100 }
    ///     // 'hasBigPurchase' == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element represents a match.
    /// - Returns: `true` if the sequence contains an element that satisfies
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func contains(where predicate: ((key: Key, value: Value)) throws -> Bool) rethrows -> Bool

    /// Returns a Boolean value indicating whether every element of a sequence
    /// satisfies a given predicate.
    ///
    /// The following code uses this method to test whether all the names in an
    /// array have at least five characters:
    ///
    ///     let names = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     let allHaveAtLeastFive = names.allSatisfy({ $0.count >= 5 })
    ///     // allHaveAtLeastFive == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element satisfies a condition.
    /// - Returns: `true` if the sequence contains only elements that satisfy
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func allSatisfy(_ predicate: ((key: Key, value: Value)) throws -> Bool) rethrows -> Bool

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(_:_:)` method to produce a single value from the elements
    /// of an entire sequence. For example, you can use this method on an array
    /// of numbers to find their sum or product.
    ///
    /// The `nextPartialResult` closure is called sequentially with an
    /// accumulating value initialized to `initialResult` and each element of
    /// the sequence. This example shows how to find the sum of an array of
    /// numbers.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///     let numberSum = numbers.reduce(0, { x, y in
    ///         x + y
    ///     })
    ///     // numberSum == 10
    ///
    /// When `numbers.reduce(_:_:)` is called, the following steps occur:
    ///
    /// 1. The `nextPartialResult` closure is called with `initialResult`---`0`
    ///    in this case---and the first element of `numbers`, returning the sum:
    ///    `1`.
    /// 2. The closure is called again repeatedly with the previous call's return
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the last value returned from the
    ///    closure is returned to the caller.
    ///
    /// If the sequence has no elements, `nextPartialResult` is never executed
    /// and `initialResult` is the result of the call to `reduce(_:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, (key: Key, value: Value)) throws -> Result) rethrows -> Result

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(into:_:)` method to produce a single value from the
    /// elements of an entire sequence. For example, you can use this method on an
    /// array of integers to filter adjacent equal entries or count frequencies.
    ///
    /// This method is preferred over `reduce(_:_:)` for efficiency when the
    /// result is a copy-on-write type, for example an Array or a Dictionary.
    ///
    /// The `updateAccumulatingResult` closure is called sequentially with a
    /// mutable accumulating value initialized to `initialResult` and each element
    /// of the sequence. This example shows how to build a dictionary of letter
    /// frequencies of a string.
    ///
    ///     let letters = "abracadabra"
    ///     let letterCount = letters.reduce(into: [:]) { counts, letter in
    ///         counts[letter, default: 0] += 1
    ///     }
    ///     // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]
    ///
    /// When `letters.reduce(into:_:)` is called, the following steps occur:
    ///
    /// 1. The `updateAccumulatingResult` closure is called with the initial
    ///    accumulating value---`[:]` in this case---and the first character of
    ///    `letters`, modifying the accumulating value by setting `1` for the key
    ///    `"a"`.
    /// 2. The closure is called again repeatedly with the updated accumulating
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the accumulating value is returned to
    ///    the caller.
    ///
    /// If the sequence has no elements, `updateAccumulatingResult` is never
    /// executed and `initialResult` is the result of the call to
    /// `reduce(into:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element of the sequence.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, (key: Key, value: Value)) throws -> ()) rethrows -> Result

    /// Returns an array containing the elements of this sequence in reverse
    /// order.
    ///
    /// The sequence must be finite.
    ///
    /// - Returns: An array containing the elements of this sequence in
    ///   reverse order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reversed() -> [(key: Key, value: Value)]

    /// Returns an array containing the concatenated results of calling the
    /// given transformation with each element of this sequence.
    ///
    /// Use this method to receive a single-level collection when your
    /// transformation produces a sequence or collection for each element.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `flatMap` with a transformation that returns an array.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///
    ///     let mapped = numbers.map { Array(repeating: $0, count: $0) }
    ///     // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
    ///
    ///     let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
    ///     // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    ///
    /// In fact, `s.flatMap(transform)`  is equivalent to
    /// `Array(s.map(transform).joined())`.
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns a sequence or collection.
    /// - Returns: The resulting flattened array.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func flatMap<SegmentOfResult>(_ transform: ((key: Key, value: Value)) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence

    /// Returns an array containing the non-`nil` results of calling the given
    /// transformation with each element of this sequence.
    ///
    /// Use this method to receive an array of non-optional values when your
    /// transformation produces an optional value.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `compactMap` with a transformation that returns an optional `Int` value.
    ///
    ///     let possibleNumbers = ["1", "2", "three", "///4///", "5"]
    ///
    ///     let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
    ///     // [1, 2, nil, nil, 5]
    ///
    ///     let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
    ///     // [1, 2, 5]
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns an optional value.
    /// - Returns: An array of the non-`nil` results of calling `transform`
    ///   with each element of the sequence.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func compactMap<ElementOfResult>(_ transform: ((key: Key, value: Value)) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Returns the elements of the sequence, sorted using the given predicate as
    /// the comparison between elements.
    ///
    /// When you want to sort a sequence of elements that don't conform to the
    /// `Comparable` protocol, pass a predicate to this method that returns
    /// `true` when the first element should be ordered before the second. The
    /// elements of the resulting array are ordered according to the given
    /// predicate.
    ///
    /// In the following example, the predicate provides an ordering for an array
    /// of a custom `HTTPResponse` type. The predicate orders errors before
    /// successes and sorts the error responses by their error code.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]
    ///     let sortedResponses = responses.sorted {
    ///         switch ($0, $1) {
    ///         // Order errors by code
    ///         case let (.error(aCode), .error(bCode)):
    ///             return aCode < bCode
    ///
    ///         // All successes are equivalent, so none is before any other
    ///         case (.ok, .ok): return false
    ///
    ///         // Order errors before successes
    ///         case (.error, .ok): return true
    ///         case (.ok, .error): return false
    ///         }
    ///     }
    ///     print(sortedResponses)
    ///     // Prints "[.error(403), .error(404), .error(500), .ok, .ok]"
    ///
    /// You also use this method to sort elements that conform to the
    /// `Comparable` protocol in descending order. To sort your sequence in
    /// descending order, pass the greater-than operator (`>`) as the
    /// `areInIncreasingOrder` parameter.
    ///
    ///     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     let descendingStudents = students.sorted(by: >)
    ///     print(descendingStudents)
    ///     // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"
    ///
    /// Calling the related `sorted()` method is equivalent to calling this
    /// method and passing the less-than operator (`<`) as the predicate.
    ///
    ///     print(students.sorted())
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///     print(students.sorted(by: <))
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also `true`.
    ///   (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// The sorting algorithm is not guaranteed to be stable. A stable sort
    /// preserves the relative order of elements for which
    /// `areInIncreasingOrder` does not establish an order.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: A sorted array of the sequence's elements.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    @inlinable public func sorted(by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> [(key: Key, value: Value)]
}

/// Default implementations of core requirements
extension Dictionary {

    /// A Boolean value indicating whether the collection is empty.
    ///
    /// When you need to check whether your collection is empty, use the
    /// `isEmpty` property instead of checking that the `count` property is
    /// equal to zero. For collections that don't conform to
    /// `RandomAccessCollection`, accessing the `count` property iterates
    /// through the elements of the collection.
    ///
    ///     let horseName = "Silver"
    ///     if horseName.isEmpty {
    ///         print("I've been through the desert on a horse with no name.")
    ///     } else {
    ///         print("Hi ho, \(horseName)!")
    ///     }
    ///     // Prints "Hi ho, Silver!")
    ///
    /// - Complexity: O(1)
    @inlinable public var isEmpty: Bool { get }

    /// The first element of the collection.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let firstNumber = numbers.first {
    ///         print(firstNumber)
    ///     }
    ///     // Prints "10"
    @inlinable public var first: (key: Key, value: Value)? { get }

    /// A value less than or equal to the number of elements in the collection.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var underestimatedCount: Int { get }

    /// The number of elements in the collection.
    ///
    /// To check whether a collection is empty, use its `isEmpty` property
    /// instead of comparing `count` to zero. Unless the collection guarantees
    /// random-access performance, calculating `count` can be an O(*n*)
    /// operation.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var count: Int { get }
}

/// Supply the default "slicing" `subscript` for `Collection` models
/// that accept the default associated `SubSequence`, `Slice<Self>`.
extension Dictionary {

    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection. Always use the slice's `startIndex` property
    /// instead of assuming that its indices start at a particular value.
    ///
    /// This example demonstrates getting a slice of an array of strings, finding
    /// the index of one of the strings in the slice, and then using that index
    /// in the original array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2 ..< streets.endIndex]
    ///     print(streetsSlice)
    ///     // Prints "["Channing", "Douglas", "Evarts"]"
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // Prints "Evarts"
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript(bounds: Range<Dictionary<Key, Value>.Index>) -> Slice<Dictionary<Key, Value>> { get }
}

/// Default implementation for forward collections.
extension Dictionary {

    /// Returns an index that is the specified distance from the given index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    ///
    ///     let s = "Swift"
    ///     let i = s.index(s.startIndex, offsetBy: 4)
    ///     print(s[i])
    ///     // Prints "t"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    /// - Returns: An index offset by `distance` from the index `i`. If
    ///   `distance` is positive, this is the same value as the result of
    ///   `distance` calls to `index(after:)`. If `distance` is negative, this
    ///   is the same value as the result of `abs(distance)` calls to
    ///   `index(before:)`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Dictionary<Key, Value>.Index, offsetBy distance: Int) -> Dictionary<Key, Value>.Index

    /// Returns an index that is the specified distance from the given index,
    /// unless that distance is beyond a given limiting index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    /// The operation doesn't require going beyond the limiting `s.endIndex`
    /// value, so it succeeds.
    ///
    ///     let s = "Swift"
    ///     if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    ///         print(s[i])
    ///     }
    ///     // Prints "t"
    ///
    /// The next example attempts to retrieve an index six positions from
    /// `s.startIndex` but fails, because that distance is beyond the index
    /// passed as `limit`.
    ///
    ///     let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
    ///     print(j)
    ///     // Prints "nil"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: An index offset by `distance` from the index `i`, unless that
    ///   index would be beyond `limit` in the direction of movement. In that
    ///   case, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Dictionary<Key, Value>.Index, offsetBy distance: Int, limitedBy limit: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Index?

    /// Offsets the given index by the specified distance.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Dictionary<Key, Value>.Index, offsetBy distance: Int)

    /// Offsets the given index by the specified distance, or so that it equals
    /// the given limiting index.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: `true` if `i` has been offset by exactly `distance` steps
    ///   without going beyond `limit`; otherwise, `false`. When the return
    ///   value is `false`, the value of `i` is equal to `limit`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Dictionary<Key, Value>.Index, offsetBy distance: Int, limitedBy limit: Dictionary<Key, Value>.Index) -> Bool

    /// Returns the distance between two indices.
    ///
    /// Unless the collection conforms to the `BidirectionalCollection` protocol,
    /// `start` must be less than or equal to `end`.
    ///
    /// - Parameters:
    ///   - start: A valid index of the collection.
    ///   - end: Another valid index of the collection. If `end` is equal to
    ///     `start`, the result is zero.
    /// - Returns: The distance between `start` and `end`. The result can be
    ///   negative only if the collection conforms to the
    ///   `BidirectionalCollection` protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the
    ///   resulting distance.
    @inlinable public func distance(from start: Dictionary<Key, Value>.Index, to end: Dictionary<Key, Value>.Index) -> Int

    /// Returns a random element of the collection, using the given generator as
    /// a source for randomness.
    ///
    /// Call `randomElement(using:)` to select a random element from an array or
    /// another collection when you are using a custom random number generator.
    /// This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement(using: &myGenerator)!
    ///     // randomName == "Amani"
    ///
    /// - Parameter generator: The random number generator to use when choosing a
    ///   random element.
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    /// - Note: The algorithm used to select a random element may change in a
    ///   future version of Swift. If you're passing a generator that results in
    ///   the same sequence of elements each time you run your program, that
    ///   sequence may change when your program is compiled using a different
    ///   version of Swift.
    @inlinable public func randomElement<T>(using generator: inout T) -> (key: Key, value: Value)? where T : RandomNumberGenerator

    /// Returns a random element of the collection.
    ///
    /// Call `randomElement()` to select a random element from an array or
    /// another collection. This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement()!
    ///     // randomName == "Amani"
    ///
    /// This method is equivalent to calling `randomElement(using:)`, passing in
    /// the system's default random generator.
    ///
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public func randomElement() -> (key: Key, value: Value)?
}

extension Dictionary : Collection {

    /// A sequence that represents a contiguous subrange of the collection's
    /// elements.
    ///
    /// This associated type appears as a requirement in the `Sequence`
    /// protocol, but it is restated here with stricter constraints. In a
    /// collection, the subsequence should also conform to `Collection`.
    public typealias SubSequence = Slice<[Key : Value]>

    /// The position of the first element in a nonempty dictionary.
    ///
    /// If the collection is empty, `startIndex` is equal to `endIndex`.
    ///
    /// - Complexity: Amortized O(1) if the dictionary does not wrap a bridged
    ///   `NSDictionary`. If the dictionary wraps a bridged `NSDictionary`, the
    ///   performance is unspecified.
    @inlinable public var startIndex: Dictionary<Key, Value>.Index { get }

    /// The dictionary's "past the end" position---that is, the position one
    /// greater than the last valid subscript argument.
    ///
    /// If the collection is empty, `endIndex` is equal to `startIndex`.
    ///
    /// - Complexity: Amortized O(1) if the dictionary does not wrap a bridged
    ///   `NSDictionary`; otherwise, the performance is unspecified.
    @inlinable public var endIndex: Dictionary<Key, Value>.Index { get }

    /// Returns the position immediately after the given index.
    ///
    /// The successor of an index must be well defined. For an index `i` into a
    /// collection `c`, calling `c.index(after: i)` returns the same index every
    /// time.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    @inlinable public func index(after i: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Index

    /// Replaces the given index with its successor.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    @inlinable public func formIndex(after i: inout Dictionary<Key, Value>.Index)

    /// Returns the index for the given key.
    ///
    /// If the given key is found in the dictionary, this method returns an index
    /// into the dictionary that corresponds with the key-value pair.
    ///
    ///     let countryCodes = ["BR": "Brazil", "GH": "Ghana", "JP": "Japan"]
    ///     let index = countryCodes.index(forKey: "JP")
    ///
    ///     print("Country code for \(countryCodes[index!].value): '\(countryCodes[index!].key)'.")
    ///     // Prints "Country code for Japan: 'JP'."
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Returns: The index for `key` and its associated value if `key` is in
    ///   the dictionary; otherwise, `nil`.
    @inlinable public func index(forKey key: Key) -> Dictionary<Key, Value>.Index?

    /// Accesses the key-value pair at the specified position.
    ///
    /// This subscript takes an index into the dictionary, instead of a key, and
    /// returns the corresponding key-value pair as a tuple. When performing
    /// collection-based operations that return an index into a dictionary, use
    /// this subscript with the resulting value.
    ///
    /// For example, to find the key for a particular value in a dictionary, use
    /// the `firstIndex(where:)` method.
    ///
    ///     let countryCodes = ["BR": "Brazil", "GH": "Ghana", "JP": "Japan"]
    ///     if let index = countryCodes.firstIndex(where: { $0.value == "Japan" }) {
    ///         print(countryCodes[index])
    ///         print("Japan's country code is '\(countryCodes[index].key)'.")
    ///     } else {
    ///         print("Didn't find 'Japan' as a value in the dictionary.")
    ///     }
    ///     // Prints "("JP", "Japan")"
    ///     // Prints "Japan's country code is 'JP'."
    ///
    /// - Parameter position: The position of the key-value pair to access.
    ///   `position` must be a valid index of the dictionary and not equal to
    ///   `endIndex`.
    /// - Returns: A two-element tuple with the key and value corresponding to
    ///   `position`.
    @inlinable public subscript(position: Dictionary<Key, Value>.Index) -> [Key : Value].Element { get }

    /// The number of key-value pairs in the dictionary.
    ///
    /// - Complexity: O(1).
    @inlinable public var count: Int { get }

    /// A Boolean value that indicates whether the dictionary is empty.
    ///
    /// Dictionaries are empty when created with an initializer or an empty
    /// dictionary literal.
    ///
    ///     var frequencies: [String: Int] = [:]
    ///     print(frequencies.isEmpty)
    ///     // Prints "true"
    @inlinable public var isEmpty: Bool { get }

    /// A type that represents the indices that are valid for subscripting the
    /// collection, in ascending order.
    public typealias Indices = DefaultIndices<[Key : Value]>
}

extension Dictionary : Sequence {

    /// Returns an iterator over the dictionary's key-value pairs.
    ///
    /// Iterating over a dictionary yields the key-value pairs as two-element
    /// tuples. You can decompose the tuple in a `for`-`in` loop, which calls
    /// `makeIterator()` behind the scenes, or when calling the iterator's
    /// `next()` method directly.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     for (name, hueValue) in hues {
    ///         print("The hue of \(name) is \(hueValue).")
    ///     }
    ///     // Prints "The hue of Heliotrope is 296."
    ///     // Prints "The hue of Coral is 16."
    ///     // Prints "The hue of Aquamarine is 156."
    ///
    /// - Returns: An iterator over the dictionary with elements of type
    ///   `(key: Key, value: Value)`.
    @inlinable public func makeIterator() -> Dictionary<Key, Value>.Iterator
}

extension Dictionary : CustomReflectable {

    /// A mirror that reflects the dictionary.
    public var customMirror: Mirror { get }
}

extension Dictionary : ExpressibleByDictionaryLiteral {

    /// Creates a dictionary initialized with a dictionary literal.
    ///
    /// Do not call this initializer directly. It is called by the compiler to
    /// handle dictionary literals. To use a dictionary literal as the initial
    /// value of a dictionary, enclose a comma-separated list of key-value pairs
    /// in square brackets.
    ///
    /// For example, the code sample below creates a dictionary with string keys
    /// and values.
    ///
    ///     let countryCodes = ["BR": "Brazil", "GH": "Ghana", "JP": "Japan"]
    ///     print(countryCodes)
    ///     // Prints "["BR": "Brazil", "JP": "Japan", "GH": "Ghana"]"
    ///
    /// - Parameter elements: The key-value pairs that will make up the new
    ///   dictionary. Each key in `elements` must be unique.
    @inlinable public init(dictionaryLiteral elements: (Key, Value)...)
}

extension Dictionary : CustomStringConvertible, CustomDebugStringConvertible {

    /// A string that represents the contents of the dictionary.
    public var description: String { get }

    /// A string that represents the contents of the dictionary, suitable for
    /// debugging.
    public var debugDescription: String { get }
}

extension Dictionary {

    public static func != (lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Bool
}

extension Dictionary : Equatable where Value : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func == (lhs: [Key : Value], rhs: [Key : Value]) -> Bool
}

extension Dictionary : Hashable where Value : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    @inlinable public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension Dictionary : Decodable where Key : Decodable, Value : Decodable {

    /// Creates a new dictionary by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

extension Dictionary : Encodable where Key : Encodable, Value : Encodable {

    /// Encodes the contents of this dictionary into the given encoder.
    ///
    /// If the dictionary uses `String` or `Int` keys, the contents are encoded
    /// in a keyed container. Otherwise, the contents are encoded as alternating
    /// key-value pairs in an unkeyed container.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws
}

extension Dictionary.Keys {

    /// A type that provides the collection's iteration interface and
    /// encapsulates its iteration state.
    ///
    /// By default, a collection conforms to the `Sequence` protocol by
    /// supplying `IndexingIterator` as its associated `Iterator`
    /// type.
    public struct Iterator : IteratorProtocol {

        /// Advances to the next element and returns it, or `nil` if no next element
        /// exists.
        ///
        /// Repeatedly calling this method returns, in order, all the elements of the
        /// underlying sequence. As soon as the sequence has run out of elements, all
        /// subsequent calls return `nil`.
        ///
        /// You must not call this method if any other copy of this iterator has been
        /// advanced with a call to its `next()` method.
        ///
        /// The following example shows how an iterator can be used explicitly to
        /// emulate a `for`-`in` loop. First, retrieve a sequence's iterator, and
        /// then call the iterator's `next()` method until it returns `nil`.
        ///
        ///     let numbers = [2, 3, 5, 7]
        ///     var numbersIterator = numbers.makeIterator()
        ///
        ///     while let num = numbersIterator.next() {
        ///         print(num)
        ///     }
        ///     // Prints "2"
        ///     // Prints "3"
        ///     // Prints "5"
        ///     // Prints "7"
        ///
        /// - Returns: The next element in the underlying sequence, if a next element
        ///   exists; otherwise, `nil`.
        @inlinable public mutating func next() -> Key?

        /// The type of element traversed by the iterator.
        public typealias Element = Key
    }

    /// Returns an iterator over the elements of the collection.
    @inlinable public func makeIterator() -> Dictionary<Key, Value>.Keys.Iterator

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    @inlinable public func map<T>(_ transform: (Key) throws -> T) rethrows -> [T]

    /// Returns a subsequence containing all but the given number of initial
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in
    /// the collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropFirst(2))
    ///     // Prints "[3, 4, 5]"
    ///     print(numbers.dropFirst(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop from the beginning of
    ///   the collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence starting after the specified number of
    ///   elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to drop from the beginning of the collection.
    @inlinable public func dropFirst(_ k: Int = 1) -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence containing all but the specified number of final
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in the
    /// collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropLast(2))
    ///     // Prints "[1, 2, 3]"
    ///     print(numbers.dropLast(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop off the end of the
    ///   collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence that leaves off the specified number of elements
    ///   at the end.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func dropLast(_ k: Int = 1) -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence by skipping elements while `predicate` returns
    /// `true` and returning the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be skipped or `false` if it should be included. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func drop(while predicate: (Key) throws -> Bool) rethrows -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence, up to the specified maximum length, containing
    /// the initial elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.prefix(2))
    ///     // Prints "[1, 2]"
    ///     print(numbers.prefix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return.
    ///   `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence starting at the beginning of this collection
    ///   with at most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to select from the beginning of the collection.
    @inlinable public func prefix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence containing the initial elements until `predicate`
    /// returns `false` and skipping the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be included or `false` if it should be excluded. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func prefix(while predicate: (Key) throws -> Bool) rethrows -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence, up to the given maximum length, containing the
    /// final elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.suffix(2))
    ///     // Prints "[4, 5]"
    ///     print(numbers.suffix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return. The
    ///   value of `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence terminating at the end of the collection with at
    ///   most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func suffix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence from the start of the collection up to, but not
    /// including, the specified position.
    ///
    /// The resulting subsequence *does not include* the element at the position
    /// `end`. The following example searches for the index of the number `40`
    /// in an array of integers, and then prints the prefix of the array up to,
    /// but not including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(upTo: i))
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// Passing the collection's starting index as the `end` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.prefix(upTo: numbers.startIndex))
    ///     // Prints "[]"
    ///
    /// Using the `prefix(upTo:)` method is equivalent to using a partial
    /// half-open range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(upTo:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[..<i])
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// - Parameter end: The "past the end" index of the resulting subsequence.
    ///   `end` must be a valid index of the collection.
    /// - Returns: A subsequence up to, but not including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(upTo end: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence from the specified position to the end of the
    /// collection.
    ///
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the suffix of the array starting at
    /// that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.suffix(from: i))
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// Passing the collection's `endIndex` as the `start` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.suffix(from: numbers.endIndex))
    ///     // Prints "[]"
    ///
    /// Using the `suffix(from:)` method is equivalent to using a partial range
    /// from the index as the collection's subscript. The subscript notation is
    /// preferred over `suffix(from:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[i...])
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// - Parameter start: The index at which to start the resulting subsequence.
    ///   `start` must be a valid index of the collection.
    /// - Returns: A subsequence starting at the `start` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func suffix(from start: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns a subsequence from the start of the collection through the
    /// specified position.
    ///
    /// The resulting subsequence *includes* the element at the position `end`.
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the prefix of the array up to, and
    /// including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(through: i))
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// Using the `prefix(through:)` method is equivalent to using a partial
    /// closed range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(through:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[...i])
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// - Parameter end: The index of the last element to include in the
    ///   resulting subsequence. `end` must be a valid index of the collection
    ///   that is not equal to the `endIndex` property.
    /// - Returns: A subsequence up to, and including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(through position: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>.Keys>

    /// Returns the longest possible subsequences of the collection, in order,
    /// that don't contain elements satisfying the given predicate.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the sequence are not returned as part of
    /// any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string using a
    /// closure that matches spaces. The first use of `split` returns each word
    /// that was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(maxSplits: 1, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(omittingEmptySubsequences: false, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - maxSplits: The maximum number of times to split the collection, or
    ///     one less than the number of subsequences to return. If
    ///     `maxSplits + 1` subsequences are returned, the last one is a suffix
    ///     of the original collection containing the remaining elements.
    ///     `maxSplits` must be greater than or equal to zero. The default value
    ///     is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each pair of consecutive elements
    ///     satisfying the `isSeparator` predicate and for each element at the
    ///     start or end of the collection satisfying the `isSeparator`
    ///     predicate. The default value is `true`.
    ///   - isSeparator: A closure that takes an element as an argument and
    ///     returns a Boolean value indicating whether the collection should be
    ///     split at that element.
    /// - Returns: An array of subsequences, split from this collection's
    ///   elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Key) throws -> Bool) rethrows -> [Slice<Dictionary<Key, Value>.Keys>]

    /// Returns the first index in which an element of the collection satisfies
    /// the given predicate.
    ///
    /// You can use the predicate to find an element of a type that doesn't
    /// conform to the `Equatable` protocol or to find an element that matches
    /// particular criteria. Here's an example that finds a student name that
    /// begins with the letter "A":
    ///
    ///     let students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     if let i = students.firstIndex(where: { $0.hasPrefix("A") }) {
    ///         print("\(students[i]) starts with 'A'!")
    ///     }
    ///     // Prints "Abena starts with 'A'!"
    ///
    /// - Parameter predicate: A closure that takes an element as its argument
    ///   and returns a Boolean value that indicates whether the passed element
    ///   represents a match.
    /// - Returns: The index of the first element for which `predicate` returns
    ///   `true`. If no elements in the collection satisfy the given predicate,
    ///   returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func firstIndex(where predicate: (Key) throws -> Bool) rethrows -> Dictionary<Key, Value>.Index?

    /// Returns the elements of the sequence, shuffled using the given generator
    /// as a source for randomness.
    ///
    /// You use this method to randomize the elements of a sequence when you are
    /// using a custom random number generator. For example, you can shuffle the
    /// numbers between `0` and `9` by calling the `shuffled(using:)` method on
    /// that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled(using: &myGenerator)
    ///     // shuffledNumbers == [8, 9, 4, 3, 2, 6, 7, 0, 5, 1]
    ///
    /// - Parameter generator: The random number generator to use when shuffling
    ///   the sequence.
    /// - Returns: An array of this sequence's elements in a shuffled order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    /// - Note: The algorithm used to shuffle a sequence may change in a future
    ///   version of Swift. If you're passing a generator that results in the
    ///   same shuffled order each time you run your program, that sequence may
    ///   change when your program is compiled using a different version of
    ///   Swift.
    @inlinable public func shuffled<T>(using generator: inout T) -> [Key] where T : RandomNumberGenerator

    /// Returns the elements of the sequence, shuffled.
    ///
    /// For example, you can shuffle the numbers between `0` and `9` by calling
    /// the `shuffled()` method on that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled()
    ///     // shuffledNumbers == [1, 7, 6, 2, 8, 9, 4, 3, 5, 0]
    ///
    /// This method is equivalent to calling `shuffled(using:)`, passing in the
    /// system's default random generator.
    ///
    /// - Returns: A shuffled array of this sequence's elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func shuffled() -> [Key]

    public static func != (lhs: Dictionary<Key, Value>.Keys, rhs: Dictionary<Key, Value>.Keys) -> Bool

    /// The indices that are valid for subscripting the collection, in ascending
    /// order.
    ///
    /// A collection's `indices` property can hold a strong reference to the
    /// collection itself, causing the collection to be non-uniquely referenced.
    /// If you mutate the collection while iterating over its indices, a strong
    /// reference can cause an unexpected copy of the collection. To avoid the
    /// unexpected copy, use the `index(after:)` method starting with
    /// `startIndex` to produce indices instead.
    ///
    ///     var c = MyFancyCollection([10, 20, 30, 40, 50])
    ///     var i = c.startIndex
    ///     while i != c.endIndex {
    ///         c[i] /= 5
    ///         i = c.index(after: i)
    ///     }
    ///     // c == MyFancyCollection([2, 4, 6, 8, 10])
    @inlinable public var indices: DefaultIndices<Dictionary<Key, Value>.Keys> { get }

    /// A sequence containing the same elements as this sequence,
    /// but on which some operations, such as `map` and `filter`, are
    /// implemented lazily.
    @inlinable public var lazy: LazySequence<Dictionary<Key, Value>.Keys> { get }

    @available(swift, deprecated: 4.1, renamed: "compactMap(_:)", message: "Please use compactMap(_:) for the case where closure returns an optional value")
    public func flatMap<ElementOfResult>(_ transform: (Key) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Accesses the contiguous subrange of the collection's elements specified
    /// by a range expression.
    ///
    /// The range expression is converted to a concrete subrange relative to this
    /// collection. For example, using a `PartialRangeFrom` range expression
    /// with an array accesses the subrange from the start of the range
    /// expression until the end of the array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2...]
    ///     print(streetsSlice)
    ///     // ["Channing", "Douglas", "Evarts"]
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection uses. This example searches `streetsSlice` for one
    /// of the strings in the slice, and then uses that index in the original
    /// array.
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // "Evarts"
    ///
    /// Always use the slice's `startIndex` property instead of assuming that its
    /// indices start at a particular value. Attempting to access an element by
    /// using an index outside the bounds of the slice's indices may result in a
    /// runtime error, even if that index is valid for the original collection.
    ///
    ///     print(streetsSlice.startIndex)
    ///     // 2
    ///     print(streetsSlice[2])
    ///     // "Channing"
    ///
    ///     print(streetsSlice[0])
    ///     // error: Index out of bounds
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript<R>(r: R) -> Slice<Dictionary<Key, Value>.Keys> where R : RangeExpression, Self.Index == R.Bound { get }

    @inlinable public subscript(x: (UnboundedRange_) -> ()) -> Slice<Dictionary<Key, Value>.Keys> { get }

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func map<T>(_ transform: (Key) throws -> T) rethrows -> [T]

    /// Returns an array containing, in order, the elements of the sequence
    /// that satisfy the given predicate.
    ///
    /// In this example, `filter(_:)` is used to include only names shorter than
    /// five characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let shortNames = cast.filter { $0.count < 5 }
    ///     print(shortNames)
    ///     // Prints "["Kim", "Karl"]"
    ///
    /// - Parameter isIncluded: A closure that takes an element of the
    ///   sequence as its argument and returns a Boolean value indicating
    ///   whether the element should be included in the returned array.
    /// - Returns: An array of the elements that `isIncluded` allowed.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func filter(_ isIncluded: (Key) throws -> Bool) rethrows -> [Key]

    /// A value less than or equal to the number of elements in the sequence,
    /// calculated nondestructively.
    ///
    /// The default implementation returns 0. If you provide your own
    /// implementation, make sure to compute the value nondestructively.
    ///
    /// - Complexity: O(1), except if the sequence also conforms to `Collection`.
    ///   In this case, see the documentation of `Collection.underestimatedCount`.
    @inlinable public var underestimatedCount: Int { get }

    /// Calls the given closure on each element in the sequence in the same order
    /// as a `for`-`in` loop.
    ///
    /// The two loops in the following example produce the same output:
    ///
    ///     let numberWords = ["one", "two", "three"]
    ///     for word in numberWords {
    ///         print(word)
    ///     }
    ///     // Prints "one"
    ///     // Prints "two"
    ///     // Prints "three"
    ///
    ///     numberWords.forEach { word in
    ///         print(word)
    ///     }
    ///     // Same as above
    ///
    /// Using the `forEach` method is distinct from a `for`-`in` loop in two
    /// important ways:
    ///
    /// 1. You cannot use a `break` or `continue` statement to exit the current
    ///    call of the `body` closure or skip subsequent calls.
    /// 2. Using the `return` statement in the `body` closure will exit only from
    ///    the current call to `body`, not from any outer scope, and won't skip
    ///    subsequent calls.
    ///
    /// - Parameter body: A closure that takes an element of the sequence as a
    ///   parameter.
    @inlinable public func forEach(_ body: (Key) throws -> Void) rethrows

    /// Returns the first element of the sequence that satisfies the given
    /// predicate.
    ///
    /// The following example uses the `first(where:)` method to find the first
    /// negative number in an array of integers:
    ///
    ///     let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
    ///     if let firstNegative = numbers.first(where: { $0 < 0 }) {
    ///         print("The first negative number is \(firstNegative).")
    ///     }
    ///     // Prints "The first negative number is -2."
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence as
    ///   its argument and returns a Boolean value indicating whether the
    ///   element is a match.
    /// - Returns: The first element of the sequence that satisfies `predicate`,
    ///   or `nil` if there is no element that satisfies `predicate`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func first(where predicate: (Key) throws -> Bool) rethrows -> Key?

    /// Call `body(p)`, where `p` is a pointer to the collection's
    /// contiguous storage.  If no such storage exists, it is
    /// first created.  If the collection does not support an internal
    /// representation in a form of contiguous storage, `body` is not
    /// called and `nil` is returned.
    ///
    /// A `Collection` that provides its own implementation of this method
    /// must also guarantee that an equivalent buffer of its `SubSequence`
    /// can be generated by advancing the pointer by the distance to the
    /// slice's `startIndex`.
    @inlinable public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Key>) throws -> R) rethrows -> R?

    /// Returns a sequence of pairs (*n*, *x*), where *n* represents a
    /// consecutive integer starting at zero and *x* represents an element of
    /// the sequence.
    ///
    /// This example enumerates the characters of the string "Swift" and prints
    /// each character along with its place in the string.
    ///
    ///     for (n, c) in "Swift".enumerated() {
    ///         print("\(n): '\(c)'")
    ///     }
    ///     // Prints "0: 'S'"
    ///     // Prints "1: 'w'"
    ///     // Prints "2: 'i'"
    ///     // Prints "3: 'f'"
    ///     // Prints "4: 't'"
    ///
    /// When you enumerate a collection, the integer part of each pair is a counter
    /// for the enumeration, but is not necessarily the index of the paired value.
    /// These counters can be used as indices only in instances of zero-based,
    /// integer-indexed collections, such as `Array` and `ContiguousArray`. For
    /// other collections the counters may be out of range or of the wrong type
    /// to use as an index. To iterate over the elements of a collection with its
    /// indices, use the `zip(_:_:)` function.
    ///
    /// This example iterates over the indices and elements of a set, building a
    /// list consisting of indices of names with five or fewer letters.
    ///
    ///     let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     var shorterIndices: [Set<String>.Index] = []
    ///     for (i, name) in zip(names.indices, names) {
    ///         if name.count <= 5 {
    ///             shorterIndices.append(i)
    ///         }
    ///     }
    ///
    /// Now that the `shorterIndices` array holds the indices of the shorter
    /// names in the `names` set, you can use those indices to access elements in
    /// the set.
    ///
    ///     for i in shorterIndices {
    ///         print(names[i])
    ///     }
    ///     // Prints "Sofia"
    ///     // Prints "Mateo"
    ///
    /// - Returns: A sequence of pairs enumerating the sequence.
    ///
    /// - Complexity: O(1)
    @inlinable public func enumerated() -> EnumeratedSequence<Dictionary<Key, Value>.Keys>

    /// Returns the minimum element in the sequence, using the given predicate as
    /// the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `min(by:)` method on a
    /// dictionary to find the key-value pair with the lowest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let leastHue = hues.min { a, b in a.value < b.value }
    ///     print(leastHue)
    ///     // Prints "Optional(("Coral", 16))"
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true`
    ///   if its first argument should be ordered before its second
    ///   argument; otherwise, `false`.
    /// - Returns: The sequence's minimum element, according to
    ///   `areInIncreasingOrder`. If the sequence has no elements, returns
    ///   `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func min(by areInIncreasingOrder: (Key, Key) throws -> Bool) rethrows -> Key?

    /// Returns the maximum element in the sequence, using the given predicate
    /// as the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `max(by:)` method on a
    /// dictionary to find the key-value pair with the highest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let greatestHue = hues.max { a, b in a.value < b.value }
    ///     print(greatestHue)
    ///     // Prints "Optional(("Heliotrope", 296))"
    ///
    /// - Parameter areInIncreasingOrder:  A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: The sequence's maximum element if the sequence is not empty;
    ///   otherwise, `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func max(by areInIncreasingOrder: (Key, Key) throws -> Bool) rethrows -> Key?

    /// Returns a Boolean value indicating whether the initial elements of the
    /// sequence are equivalent to the elements in another sequence, using
    /// the given predicate as the equivalence test.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - possiblePrefix: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if the initial elements of the sequence are equivalent
    ///   to the elements of `possiblePrefix`; otherwise, `false`. If
    ///   `possiblePrefix` has no elements, the return value is `true`.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `possiblePrefix`.
    @inlinable public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: (Key, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool where PossiblePrefix : Sequence

    /// Returns a Boolean value indicating whether this sequence and another
    /// sequence contain equivalent elements in the same order, using the given
    /// predicate as the equivalence test.
    ///
    /// At least one of the sequences must be finite.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if this sequence and `other` contain equivalent items,
    ///   using `areEquivalent` as the equivalence test; otherwise, `false.`
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: (Key, OtherSequence.Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence

    /// Returns a Boolean value indicating whether the sequence precedes another
    /// sequence in a lexicographical (dictionary) ordering, using the given
    /// predicate to compare elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areInIncreasingOrder:  A predicate that returns `true` if its first
    ///     argument should be ordered before its second argument; otherwise,
    ///     `false`.
    /// - Returns: `true` if this sequence precedes `other` in a dictionary
    ///   ordering as ordered by `areInIncreasingOrder`; otherwise, `false`.
    ///
    /// - Note: This method implements the mathematical notion of lexicographical
    ///   ordering, which has no connection to Unicode.  If you are sorting
    ///   strings to present to the end user, use `String` APIs that perform
    ///   localized comparison instead.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: (Key, Key) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns a Boolean value indicating whether the sequence contains an
    /// element that satisfies the given predicate.
    ///
    /// You can use the predicate to check for an element of a type that
    /// doesn't conform to the `Equatable` protocol, such as the
    /// `HTTPResponse` enumeration in this example.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let lastThreeResponses: [HTTPResponse] = [.ok, .ok, .error(404)]
    ///     let hadError = lastThreeResponses.contains { element in
    ///         if case .error = element {
    ///             return true
    ///         } else {
    ///             return false
    ///         }
    ///     }
    ///     // 'hadError' == true
    ///
    /// Alternatively, a predicate can be satisfied by a range of `Equatable`
    /// elements or a general condition. This example shows how you can check an
    /// array for an expense greater than $100.
    ///
    ///     let expenses = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
    ///     let hasBigPurchase = expenses.contains { $0 > 100 }
    ///     // 'hasBigPurchase' == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element represents a match.
    /// - Returns: `true` if the sequence contains an element that satisfies
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func contains(where predicate: (Key) throws -> Bool) rethrows -> Bool

    /// Returns a Boolean value indicating whether every element of a sequence
    /// satisfies a given predicate.
    ///
    /// The following code uses this method to test whether all the names in an
    /// array have at least five characters:
    ///
    ///     let names = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     let allHaveAtLeastFive = names.allSatisfy({ $0.count >= 5 })
    ///     // allHaveAtLeastFive == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element satisfies a condition.
    /// - Returns: `true` if the sequence contains only elements that satisfy
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func allSatisfy(_ predicate: (Key) throws -> Bool) rethrows -> Bool

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(_:_:)` method to produce a single value from the elements
    /// of an entire sequence. For example, you can use this method on an array
    /// of numbers to find their sum or product.
    ///
    /// The `nextPartialResult` closure is called sequentially with an
    /// accumulating value initialized to `initialResult` and each element of
    /// the sequence. This example shows how to find the sum of an array of
    /// numbers.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///     let numberSum = numbers.reduce(0, { x, y in
    ///         x + y
    ///     })
    ///     // numberSum == 10
    ///
    /// When `numbers.reduce(_:_:)` is called, the following steps occur:
    ///
    /// 1. The `nextPartialResult` closure is called with `initialResult`---`0`
    ///    in this case---and the first element of `numbers`, returning the sum:
    ///    `1`.
    /// 2. The closure is called again repeatedly with the previous call's return
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the last value returned from the
    ///    closure is returned to the caller.
    ///
    /// If the sequence has no elements, `nextPartialResult` is never executed
    /// and `initialResult` is the result of the call to `reduce(_:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Key) throws -> Result) rethrows -> Result

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(into:_:)` method to produce a single value from the
    /// elements of an entire sequence. For example, you can use this method on an
    /// array of integers to filter adjacent equal entries or count frequencies.
    ///
    /// This method is preferred over `reduce(_:_:)` for efficiency when the
    /// result is a copy-on-write type, for example an Array or a Dictionary.
    ///
    /// The `updateAccumulatingResult` closure is called sequentially with a
    /// mutable accumulating value initialized to `initialResult` and each element
    /// of the sequence. This example shows how to build a dictionary of letter
    /// frequencies of a string.
    ///
    ///     let letters = "abracadabra"
    ///     let letterCount = letters.reduce(into: [:]) { counts, letter in
    ///         counts[letter, default: 0] += 1
    ///     }
    ///     // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]
    ///
    /// When `letters.reduce(into:_:)` is called, the following steps occur:
    ///
    /// 1. The `updateAccumulatingResult` closure is called with the initial
    ///    accumulating value---`[:]` in this case---and the first character of
    ///    `letters`, modifying the accumulating value by setting `1` for the key
    ///    `"a"`.
    /// 2. The closure is called again repeatedly with the updated accumulating
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the accumulating value is returned to
    ///    the caller.
    ///
    /// If the sequence has no elements, `updateAccumulatingResult` is never
    /// executed and `initialResult` is the result of the call to
    /// `reduce(into:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element of the sequence.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Key) throws -> ()) rethrows -> Result

    /// Returns an array containing the elements of this sequence in reverse
    /// order.
    ///
    /// The sequence must be finite.
    ///
    /// - Returns: An array containing the elements of this sequence in
    ///   reverse order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reversed() -> [Key]

    /// Returns an array containing the concatenated results of calling the
    /// given transformation with each element of this sequence.
    ///
    /// Use this method to receive a single-level collection when your
    /// transformation produces a sequence or collection for each element.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `flatMap` with a transformation that returns an array.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///
    ///     let mapped = numbers.map { Array(repeating: $0, count: $0) }
    ///     // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
    ///
    ///     let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
    ///     // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    ///
    /// In fact, `s.flatMap(transform)`  is equivalent to
    /// `Array(s.map(transform).joined())`.
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns a sequence or collection.
    /// - Returns: The resulting flattened array.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func flatMap<SegmentOfResult>(_ transform: (Key) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence

    /// Returns an array containing the non-`nil` results of calling the given
    /// transformation with each element of this sequence.
    ///
    /// Use this method to receive an array of non-optional values when your
    /// transformation produces an optional value.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `compactMap` with a transformation that returns an optional `Int` value.
    ///
    ///     let possibleNumbers = ["1", "2", "three", "///4///", "5"]
    ///
    ///     let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
    ///     // [1, 2, nil, nil, 5]
    ///
    ///     let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
    ///     // [1, 2, 5]
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns an optional value.
    /// - Returns: An array of the non-`nil` results of calling `transform`
    ///   with each element of the sequence.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func compactMap<ElementOfResult>(_ transform: (Key) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Returns the elements of the sequence, sorted using the given predicate as
    /// the comparison between elements.
    ///
    /// When you want to sort a sequence of elements that don't conform to the
    /// `Comparable` protocol, pass a predicate to this method that returns
    /// `true` when the first element should be ordered before the second. The
    /// elements of the resulting array are ordered according to the given
    /// predicate.
    ///
    /// In the following example, the predicate provides an ordering for an array
    /// of a custom `HTTPResponse` type. The predicate orders errors before
    /// successes and sorts the error responses by their error code.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]
    ///     let sortedResponses = responses.sorted {
    ///         switch ($0, $1) {
    ///         // Order errors by code
    ///         case let (.error(aCode), .error(bCode)):
    ///             return aCode < bCode
    ///
    ///         // All successes are equivalent, so none is before any other
    ///         case (.ok, .ok): return false
    ///
    ///         // Order errors before successes
    ///         case (.error, .ok): return true
    ///         case (.ok, .error): return false
    ///         }
    ///     }
    ///     print(sortedResponses)
    ///     // Prints "[.error(403), .error(404), .error(500), .ok, .ok]"
    ///
    /// You also use this method to sort elements that conform to the
    /// `Comparable` protocol in descending order. To sort your sequence in
    /// descending order, pass the greater-than operator (`>`) as the
    /// `areInIncreasingOrder` parameter.
    ///
    ///     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     let descendingStudents = students.sorted(by: >)
    ///     print(descendingStudents)
    ///     // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"
    ///
    /// Calling the related `sorted()` method is equivalent to calling this
    /// method and passing the less-than operator (`<`) as the predicate.
    ///
    ///     print(students.sorted())
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///     print(students.sorted(by: <))
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also `true`.
    ///   (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// The sorting algorithm is not guaranteed to be stable. A stable sort
    /// preserves the relative order of elements for which
    /// `areInIncreasingOrder` does not establish an order.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: A sorted array of the sequence's elements.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    @inlinable public func sorted(by areInIncreasingOrder: (Key, Key) throws -> Bool) rethrows -> [Key]
}

/// Supply the default "slicing" `subscript` for `Collection` models
/// that accept the default associated `SubSequence`, `Slice<Self>`.
extension Dictionary.Keys {

    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection. Always use the slice's `startIndex` property
    /// instead of assuming that its indices start at a particular value.
    ///
    /// This example demonstrates getting a slice of an array of strings, finding
    /// the index of one of the strings in the slice, and then using that index
    /// in the original array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2 ..< streets.endIndex]
    ///     print(streetsSlice)
    ///     // Prints "["Channing", "Douglas", "Evarts"]"
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // Prints "Evarts"
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript(bounds: Range<Dictionary<Key, Value>.Index>) -> Slice<Dictionary<Key, Value>.Keys> { get }
}

/// Default implementation for forward collections.
extension Dictionary.Keys {

    /// Returns an index that is the specified distance from the given index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    ///
    ///     let s = "Swift"
    ///     let i = s.index(s.startIndex, offsetBy: 4)
    ///     print(s[i])
    ///     // Prints "t"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    /// - Returns: An index offset by `distance` from the index `i`. If
    ///   `distance` is positive, this is the same value as the result of
    ///   `distance` calls to `index(after:)`. If `distance` is negative, this
    ///   is the same value as the result of `abs(distance)` calls to
    ///   `index(before:)`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Dictionary<Key, Value>.Index, offsetBy distance: Int) -> Dictionary<Key, Value>.Index

    /// Returns an index that is the specified distance from the given index,
    /// unless that distance is beyond a given limiting index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    /// The operation doesn't require going beyond the limiting `s.endIndex`
    /// value, so it succeeds.
    ///
    ///     let s = "Swift"
    ///     if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    ///         print(s[i])
    ///     }
    ///     // Prints "t"
    ///
    /// The next example attempts to retrieve an index six positions from
    /// `s.startIndex` but fails, because that distance is beyond the index
    /// passed as `limit`.
    ///
    ///     let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
    ///     print(j)
    ///     // Prints "nil"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: An index offset by `distance` from the index `i`, unless that
    ///   index would be beyond `limit` in the direction of movement. In that
    ///   case, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Dictionary<Key, Value>.Index, offsetBy distance: Int, limitedBy limit: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Index?

    /// Offsets the given index by the specified distance.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Dictionary<Key, Value>.Index, offsetBy distance: Int)

    /// Offsets the given index by the specified distance, or so that it equals
    /// the given limiting index.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: `true` if `i` has been offset by exactly `distance` steps
    ///   without going beyond `limit`; otherwise, `false`. When the return
    ///   value is `false`, the value of `i` is equal to `limit`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Dictionary<Key, Value>.Index, offsetBy distance: Int, limitedBy limit: Dictionary<Key, Value>.Index) -> Bool

    /// Returns the distance between two indices.
    ///
    /// Unless the collection conforms to the `BidirectionalCollection` protocol,
    /// `start` must be less than or equal to `end`.
    ///
    /// - Parameters:
    ///   - start: A valid index of the collection.
    ///   - end: Another valid index of the collection. If `end` is equal to
    ///     `start`, the result is zero.
    /// - Returns: The distance between `start` and `end`. The result can be
    ///   negative only if the collection conforms to the
    ///   `BidirectionalCollection` protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the
    ///   resulting distance.
    @inlinable public func distance(from start: Dictionary<Key, Value>.Index, to end: Dictionary<Key, Value>.Index) -> Int

    /// Returns a random element of the collection, using the given generator as
    /// a source for randomness.
    ///
    /// Call `randomElement(using:)` to select a random element from an array or
    /// another collection when you are using a custom random number generator.
    /// This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement(using: &myGenerator)!
    ///     // randomName == "Amani"
    ///
    /// - Parameter generator: The random number generator to use when choosing a
    ///   random element.
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    /// - Note: The algorithm used to select a random element may change in a
    ///   future version of Swift. If you're passing a generator that results in
    ///   the same sequence of elements each time you run your program, that
    ///   sequence may change when your program is compiled using a different
    ///   version of Swift.
    @inlinable public func randomElement<T>(using generator: inout T) -> Key? where T : RandomNumberGenerator

    /// Returns a random element of the collection.
    ///
    /// Call `randomElement()` to select a random element from an array or
    /// another collection. This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement()!
    ///     // randomName == "Amani"
    ///
    /// This method is equivalent to calling `randomElement(using:)`, passing in
    /// the system's default random generator.
    ///
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public func randomElement() -> Key?
}

/// Default implementations of core requirements
extension Dictionary.Keys {

    /// A Boolean value indicating whether the collection is empty.
    ///
    /// When you need to check whether your collection is empty, use the
    /// `isEmpty` property instead of checking that the `count` property is
    /// equal to zero. For collections that don't conform to
    /// `RandomAccessCollection`, accessing the `count` property iterates
    /// through the elements of the collection.
    ///
    ///     let horseName = "Silver"
    ///     if horseName.isEmpty {
    ///         print("I've been through the desert on a horse with no name.")
    ///     } else {
    ///         print("Hi ho, \(horseName)!")
    ///     }
    ///     // Prints "Hi ho, Silver!")
    ///
    /// - Complexity: O(1)
    @inlinable public var isEmpty: Bool { get }

    /// The first element of the collection.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let firstNumber = numbers.first {
    ///         print(firstNumber)
    ///     }
    ///     // Prints "10"
    @inlinable public var first: Key? { get }

    /// A value less than or equal to the number of elements in the collection.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var underestimatedCount: Int { get }

    /// The number of elements in the collection.
    ///
    /// To check whether a collection is empty, use its `isEmpty` property
    /// instead of comparing `count` to zero. Unless the collection guarantees
    /// random-access performance, calculating `count` can be an O(*n*)
    /// operation.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var count: Int { get }
}

extension Dictionary.Keys where Self.Element : Comparable {

    /// Returns the minimum element in the sequence.
    ///
    /// This example finds the smallest value in an array of height measurements.
    ///
    ///     let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
    ///     let lowestHeight = heights.min()
    ///     print(lowestHeight)
    ///     // Prints "Optional(58.5)"
    ///
    /// - Returns: The sequence's minimum element. If the sequence has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func min() -> Key?

    /// Returns the maximum element in the sequence.
    ///
    /// This example finds the largest value in an array of height measurements.
    ///
    ///     let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
    ///     let greatestHeight = heights.max()
    ///     print(greatestHeight)
    ///     // Prints "Optional(67.5)"
    ///
    /// - Returns: The sequence's maximum element. If the sequence has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func max() -> Key?

    /// Returns a Boolean value indicating whether the sequence precedes another
    /// sequence in a lexicographical (dictionary) ordering, using the
    /// less-than operator (`<`) to compare elements.
    ///
    /// This example uses the `lexicographicallyPrecedes` method to test which
    /// array of integers comes first in a lexicographical ordering.
    ///
    ///     let a = [1, 2, 2, 2]
    ///     let b = [1, 2, 3, 4]
    ///
    ///     print(a.lexicographicallyPrecedes(b))
    ///     // Prints "true"
    ///     print(b.lexicographicallyPrecedes(b))
    ///     // Prints "false"
    ///
    /// - Parameter other: A sequence to compare to this sequence.
    /// - Returns: `true` if this sequence precedes `other` in a dictionary
    ///   ordering; otherwise, `false`.
    ///
    /// - Note: This method implements the mathematical notion of lexicographical
    ///   ordering, which has no connection to Unicode.  If you are sorting
    ///   strings to present to the end user, use `String` APIs that
    ///   perform localized comparison.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns the elements of the sequence, sorted.
    ///
    /// You can sort any sequence of elements that conform to the `Comparable`
    /// protocol by calling this method. Elements are sorted in ascending order.
    ///
    /// Here's an example of sorting a list of students' names. Strings in Swift
    /// conform to the `Comparable` protocol, so the names are sorted in
    /// ascending order according to the less-than operator (`<`).
    ///
    ///     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     let sortedStudents = students.sorted()
    ///     print(sortedStudents)
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///
    /// To sort the elements of your sequence in descending order, pass the
    /// greater-than operator (`>`) to the `sorted(by:)` method.
    ///
    ///     let descendingStudents = students.sorted(by: >)
    ///     print(descendingStudents)
    ///     // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"
    ///
    /// The sorting algorithm is not guaranteed to be stable. A stable sort
    /// preserves the relative order of elements that compare equal.
    ///
    /// - Returns: A sorted array of the sequence's elements.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    @inlinable public func sorted() -> [Key]
}

extension Dictionary.Keys where Self.Element : Equatable {

    /// Returns the longest possible subsequences of the collection, in order,
    /// around elements equal to the given element.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the collection are not returned as part
    /// of any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string at each
    /// space character (" "). The first use of `split` returns each word that
    /// was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(separator: " "))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(separator: " ", maxSplits: 1))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(separator: " ", omittingEmptySubsequences: false))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - separator: The element that should be split upon.
    ///   - maxSplits: The maximum number of times to split the collection, or
    ///     one less than the number of subsequences to return. If
    ///     `maxSplits + 1` subsequences are returned, the last one is a suffix
    ///     of the original collection containing the remaining elements.
    ///     `maxSplits` must be greater than or equal to zero. The default value
    ///     is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each consecutive pair of `separator`
    ///     elements in the collection and for each instance of `separator` at
    ///     the start or end of the collection. If `true`, only nonempty
    ///     subsequences are returned. The default value is `true`.
    /// - Returns: An array of subsequences, split from this collection's
    ///   elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func split(separator: Key, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [Slice<Dictionary<Key, Value>.Keys>]

    /// Returns the first index where the specified value appears in the
    /// collection.
    ///
    /// After using `firstIndex(of:)` to find the position of a particular element
    /// in a collection, you can use it to access the element by subscripting.
    /// This example shows how you can modify one of the names in an array of
    /// students.
    ///
    ///     var students = ["Ben", "Ivy", "Jordell", "Maxime"]
    ///     if let i = students.firstIndex(of: "Maxime") {
    ///         students[i] = "Max"
    ///     }
    ///     print(students)
    ///     // Prints "["Ben", "Ivy", "Jordell", "Max"]"
    ///
    /// - Parameter element: An element to search for in the collection.
    /// - Returns: The first index where `element` is found. If `element` is not
    ///   found in the collection, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func firstIndex(of element: Key) -> Dictionary<Key, Value>.Index?

    /// Returns the first index where the specified value appears in the
    /// collection.
    @available(swift, deprecated: 5.0, renamed: "firstIndex(of:)")
    @inlinable public func index(of element: Key) -> Dictionary<Key, Value>.Index?

    /// Returns a Boolean value indicating whether the initial elements of the
    /// sequence are the same as the elements in another sequence.
    ///
    /// This example tests whether one countable range begins with the elements
    /// of another countable range.
    ///
    ///     let a = 1...3
    ///     let b = 1...10
    ///
    ///     print(b.starts(with: a))
    ///     // Prints "true"
    ///
    /// Passing a sequence with no elements or an empty collection as
    /// `possiblePrefix` always results in `true`.
    ///
    ///     print(b.starts(with: []))
    ///     // Prints "true"
    ///
    /// - Parameter possiblePrefix: A sequence to compare to this sequence.
    /// - Returns: `true` if the initial elements of the sequence are the same as
    ///   the elements of `possiblePrefix`; otherwise, `false`. If
    ///   `possiblePrefix` has no elements, the return value is `true`.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `possiblePrefix`.
    @inlinable public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool where PossiblePrefix : Sequence, Self.Element == PossiblePrefix.Element

    /// Returns a Boolean value indicating whether this sequence and another
    /// sequence contain the same elements in the same order.
    ///
    /// At least one of the sequences must be finite.
    ///
    /// This example tests whether one countable range shares the same elements
    /// as another countable range and an array.
    ///
    ///     let a = 1...3
    ///     let b = 1...10
    ///
    ///     print(a.elementsEqual(b))
    ///     // Prints "false"
    ///     print(a.elementsEqual([1, 2, 3]))
    ///     // Prints "true"
    ///
    /// - Parameter other: A sequence to compare to this sequence.
    /// - Returns: `true` if this sequence and `other` contain the same elements
    ///   in the same order.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns a Boolean value indicating whether the sequence contains the
    /// given element.
    ///
    /// This example checks to see whether a favorite actor is in an array
    /// storing a movie's cast.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     print(cast.contains("Marlon"))
    ///     // Prints "true"
    ///     print(cast.contains("James"))
    ///     // Prints "false"
    ///
    /// - Parameter element: The element to find in the sequence.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func contains(_ element: Key) -> Bool
}

extension Dictionary.Keys where Self.Element : Sequence {

    /// Returns the elements of this sequence of sequences, concatenated.
    ///
    /// In this example, an array of three ranges is flattened so that the
    /// elements of each range can be iterated in turn.
    ///
    ///     let ranges = [0..<3, 8..<10, 15..<17]
    ///
    ///     // A for-in loop over 'ranges' accesses each range:
    ///     for range in ranges {
    ///       print(range)
    ///     }
    ///     // Prints "0..<3"
    ///     // Prints "8..<10"
    ///     // Prints "15..<17"
    ///
    ///     // Use 'joined()' to access each element of each range:
    ///     for index in ranges.joined() {
    ///         print(index, terminator: " ")
    ///     }
    ///     // Prints: "0 1 2 8 9 15 16"
    ///
    /// - Returns: A flattened view of the elements of this
    ///   sequence of sequences.
    @inlinable public func joined() -> FlattenSequence<Dictionary<Key, Value>.Keys>

    /// Returns the concatenated elements of this sequence of sequences,
    /// inserting the given separator between each element.
    ///
    /// This example shows how an array of `[Int]` instances can be joined, using
    /// another `[Int]` instance as the separator:
    ///
    ///     let nestedNumbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    ///     let joined = nestedNumbers.joined(separator: [-1, -2])
    ///     print(Array(joined))
    ///     // Prints "[1, 2, 3, -1, -2, 4, 5, 6, -1, -2, 7, 8, 9]"
    ///
    /// - Parameter separator: A sequence to insert between each of this
    ///   sequence's elements.
    /// - Returns: The joined sequence of elements.
    @inlinable public func joined<Separator>(separator: Separator) -> JoinedSequence<Dictionary<Key, Value>.Keys> where Separator : Sequence, Separator.Element == Self.Element.Element
}

extension Dictionary.Keys where Self.Element : StringProtocol {

    /// Returns a new string by concatenating the elements of the sequence,
    /// adding the given separator between each element.
    ///
    /// The following example shows how an array of strings can be joined to a
    /// single, comma-separated string:
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let list = cast.joined(separator: ", ")
    ///     print(list)
    ///     // Prints "Vivien, Marlon, Kim, Karl"
    ///
    /// - Parameter separator: A string to insert between each of the elements
    ///   in this sequence. The default separator is an empty string.
    /// - Returns: A single, concatenated string.
    public func joined(separator: String = "") -> String
}

extension Dictionary.Values {

    /// A type that provides the collection's iteration interface and
    /// encapsulates its iteration state.
    ///
    /// By default, a collection conforms to the `Sequence` protocol by
    /// supplying `IndexingIterator` as its associated `Iterator`
    /// type.
    public struct Iterator : IteratorProtocol {

        /// Advances to the next element and returns it, or `nil` if no next element
        /// exists.
        ///
        /// Repeatedly calling this method returns, in order, all the elements of the
        /// underlying sequence. As soon as the sequence has run out of elements, all
        /// subsequent calls return `nil`.
        ///
        /// You must not call this method if any other copy of this iterator has been
        /// advanced with a call to its `next()` method.
        ///
        /// The following example shows how an iterator can be used explicitly to
        /// emulate a `for`-`in` loop. First, retrieve a sequence's iterator, and
        /// then call the iterator's `next()` method until it returns `nil`.
        ///
        ///     let numbers = [2, 3, 5, 7]
        ///     var numbersIterator = numbers.makeIterator()
        ///
        ///     while let num = numbersIterator.next() {
        ///         print(num)
        ///     }
        ///     // Prints "2"
        ///     // Prints "3"
        ///     // Prints "5"
        ///     // Prints "7"
        ///
        /// - Returns: The next element in the underlying sequence, if a next element
        ///   exists; otherwise, `nil`.
        @inlinable public mutating func next() -> Value?

        /// The type of element traversed by the iterator.
        public typealias Element = Value
    }

    /// Returns an iterator over the elements of the collection.
    @inlinable public func makeIterator() -> Dictionary<Key, Value>.Values.Iterator

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    @inlinable public func map<T>(_ transform: (Value) throws -> T) rethrows -> [T]

    /// Returns a subsequence containing all but the given number of initial
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in
    /// the collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropFirst(2))
    ///     // Prints "[3, 4, 5]"
    ///     print(numbers.dropFirst(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop from the beginning of
    ///   the collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence starting after the specified number of
    ///   elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to drop from the beginning of the collection.
    @inlinable public func dropFirst(_ k: Int = 1) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence containing all but the specified number of final
    /// elements.
    ///
    /// If the number of elements to drop exceeds the number of elements in the
    /// collection, the result is an empty subsequence.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.dropLast(2))
    ///     // Prints "[1, 2, 3]"
    ///     print(numbers.dropLast(10))
    ///     // Prints "[]"
    ///
    /// - Parameter k: The number of elements to drop off the end of the
    ///   collection. `k` must be greater than or equal to zero.
    /// - Returns: A subsequence that leaves off the specified number of elements
    ///   at the end.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func dropLast(_ k: Int = 1) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence by skipping elements while `predicate` returns
    /// `true` and returning the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be skipped or `false` if it should be included. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func drop(while predicate: (Value) throws -> Bool) rethrows -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence, up to the specified maximum length, containing
    /// the initial elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.prefix(2))
    ///     // Prints "[1, 2]"
    ///     print(numbers.prefix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return.
    ///   `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence starting at the beginning of this collection
    ///   with at most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to select from the beginning of the collection.
    @inlinable public func prefix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence containing the initial elements until `predicate`
    /// returns `false` and skipping the remaining elements.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns `true` if the element should
    ///   be included or `false` if it should be excluded. Once the predicate
    ///   returns `false` it will not be called again.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func prefix(while predicate: (Value) throws -> Bool) rethrows -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence, up to the given maximum length, containing the
    /// final elements of the collection.
    ///
    /// If the maximum length exceeds the number of elements in the collection,
    /// the result contains all the elements in the collection.
    ///
    ///     let numbers = [1, 2, 3, 4, 5]
    ///     print(numbers.suffix(2))
    ///     // Prints "[4, 5]"
    ///     print(numbers.suffix(10))
    ///     // Prints "[1, 2, 3, 4, 5]"
    ///
    /// - Parameter maxLength: The maximum number of elements to return. The
    ///   value of `maxLength` must be greater than or equal to zero.
    /// - Returns: A subsequence terminating at the end of the collection with at
    ///   most `maxLength` elements.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length of
    ///   the collection.
    @inlinable public func suffix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence from the start of the collection up to, but not
    /// including, the specified position.
    ///
    /// The resulting subsequence *does not include* the element at the position
    /// `end`. The following example searches for the index of the number `40`
    /// in an array of integers, and then prints the prefix of the array up to,
    /// but not including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(upTo: i))
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// Passing the collection's starting index as the `end` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.prefix(upTo: numbers.startIndex))
    ///     // Prints "[]"
    ///
    /// Using the `prefix(upTo:)` method is equivalent to using a partial
    /// half-open range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(upTo:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[..<i])
    ///     }
    ///     // Prints "[10, 20, 30]"
    ///
    /// - Parameter end: The "past the end" index of the resulting subsequence.
    ///   `end` must be a valid index of the collection.
    /// - Returns: A subsequence up to, but not including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(upTo end: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence from the specified position to the end of the
    /// collection.
    ///
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the suffix of the array starting at
    /// that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.suffix(from: i))
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// Passing the collection's `endIndex` as the `start` parameter results in
    /// an empty subsequence.
    ///
    ///     print(numbers.suffix(from: numbers.endIndex))
    ///     // Prints "[]"
    ///
    /// Using the `suffix(from:)` method is equivalent to using a partial range
    /// from the index as the collection's subscript. The subscript notation is
    /// preferred over `suffix(from:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[i...])
    ///     }
    ///     // Prints "[40, 50, 60]"
    ///
    /// - Parameter start: The index at which to start the resulting subsequence.
    ///   `start` must be a valid index of the collection.
    /// - Returns: A subsequence starting at the `start` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func suffix(from start: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns a subsequence from the start of the collection through the
    /// specified position.
    ///
    /// The resulting subsequence *includes* the element at the position `end`.
    /// The following example searches for the index of the number `40` in an
    /// array of integers, and then prints the prefix of the array up to, and
    /// including, that index:
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60]
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers.prefix(through: i))
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// Using the `prefix(through:)` method is equivalent to using a partial
    /// closed range as the collection's subscript. The subscript notation is
    /// preferred over `prefix(through:)`.
    ///
    ///     if let i = numbers.firstIndex(of: 40) {
    ///         print(numbers[...i])
    ///     }
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// - Parameter end: The index of the last element to include in the
    ///   resulting subsequence. `end` must be a valid index of the collection
    ///   that is not equal to the `endIndex` property.
    /// - Returns: A subsequence up to, and including, the `end` position.
    ///
    /// - Complexity: O(1)
    @inlinable public func prefix(through position: Dictionary<Key, Value>.Index) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns the longest possible subsequences of the collection, in order,
    /// that don't contain elements satisfying the given predicate.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the sequence are not returned as part of
    /// any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string using a
    /// closure that matches spaces. The first use of `split` returns each word
    /// that was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(maxSplits: 1, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(omittingEmptySubsequences: false, whereSeparator: { $0 == " " }))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - maxSplits: The maximum number of times to split the collection, or
    ///     one less than the number of subsequences to return. If
    ///     `maxSplits + 1` subsequences are returned, the last one is a suffix
    ///     of the original collection containing the remaining elements.
    ///     `maxSplits` must be greater than or equal to zero. The default value
    ///     is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each pair of consecutive elements
    ///     satisfying the `isSeparator` predicate and for each element at the
    ///     start or end of the collection satisfying the `isSeparator`
    ///     predicate. The default value is `true`.
    ///   - isSeparator: A closure that takes an element as an argument and
    ///     returns a Boolean value indicating whether the collection should be
    ///     split at that element.
    /// - Returns: An array of subsequences, split from this collection's
    ///   elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Value) throws -> Bool) rethrows -> [Slice<Dictionary<Key, Value>.Values>]

    /// Returns the first index in which an element of the collection satisfies
    /// the given predicate.
    ///
    /// You can use the predicate to find an element of a type that doesn't
    /// conform to the `Equatable` protocol or to find an element that matches
    /// particular criteria. Here's an example that finds a student name that
    /// begins with the letter "A":
    ///
    ///     let students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     if let i = students.firstIndex(where: { $0.hasPrefix("A") }) {
    ///         print("\(students[i]) starts with 'A'!")
    ///     }
    ///     // Prints "Abena starts with 'A'!"
    ///
    /// - Parameter predicate: A closure that takes an element as its argument
    ///   and returns a Boolean value that indicates whether the passed element
    ///   represents a match.
    /// - Returns: The index of the first element for which `predicate` returns
    ///   `true`. If no elements in the collection satisfy the given predicate,
    ///   returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func firstIndex(where predicate: (Value) throws -> Bool) rethrows -> Dictionary<Key, Value>.Index?

    /// Reorders the elements of the collection such that all the elements
    /// that match the given predicate are after all the elements that don't
    /// match.
    ///
    /// After partitioning a collection, there is a pivot index `p` where
    /// no element before `p` satisfies the `belongsInSecondPartition`
    /// predicate and every element at or after `p` satisfies
    /// `belongsInSecondPartition`.
    ///
    /// In the following example, an array of numbers is partitioned by a
    /// predicate that matches elements greater than 30.
    ///
    ///     var numbers = [30, 40, 20, 30, 30, 60, 10]
    ///     let p = numbers.partition(by: { $0 > 30 })
    ///     // p == 5
    ///     // numbers == [30, 10, 20, 30, 30, 60, 40]
    ///
    /// The `numbers` array is now arranged in two partitions. The first
    /// partition, `numbers[..<p]`, is made up of the elements that
    /// are not greater than 30. The second partition, `numbers[p...]`,
    /// is made up of the elements that *are* greater than 30.
    ///
    ///     let first = numbers[..<p]
    ///     // first == [30, 10, 20, 30, 30]
    ///     let second = numbers[p...]
    ///     // second == [60, 40]
    ///
    /// - Parameter belongsInSecondPartition: A predicate used to partition
    ///   the collection. All elements satisfying this predicate are ordered
    ///   after all elements not satisfying it.
    /// - Returns: The index of the first element in the reordered collection
    ///   that matches `belongsInSecondPartition`. If no elements in the
    ///   collection match `belongsInSecondPartition`, the returned index is
    ///   equal to the collection's `endIndex`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public mutating func partition(by belongsInSecondPartition: (Value) throws -> Bool) rethrows -> Dictionary<Key, Value>.Index

    /// Returns the elements of the sequence, shuffled using the given generator
    /// as a source for randomness.
    ///
    /// You use this method to randomize the elements of a sequence when you are
    /// using a custom random number generator. For example, you can shuffle the
    /// numbers between `0` and `9` by calling the `shuffled(using:)` method on
    /// that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled(using: &myGenerator)
    ///     // shuffledNumbers == [8, 9, 4, 3, 2, 6, 7, 0, 5, 1]
    ///
    /// - Parameter generator: The random number generator to use when shuffling
    ///   the sequence.
    /// - Returns: An array of this sequence's elements in a shuffled order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    /// - Note: The algorithm used to shuffle a sequence may change in a future
    ///   version of Swift. If you're passing a generator that results in the
    ///   same shuffled order each time you run your program, that sequence may
    ///   change when your program is compiled using a different version of
    ///   Swift.
    @inlinable public func shuffled<T>(using generator: inout T) -> [Value] where T : RandomNumberGenerator

    /// Returns the elements of the sequence, shuffled.
    ///
    /// For example, you can shuffle the numbers between `0` and `9` by calling
    /// the `shuffled()` method on that range:
    ///
    ///     let numbers = 0...9
    ///     let shuffledNumbers = numbers.shuffled()
    ///     // shuffledNumbers == [1, 7, 6, 2, 8, 9, 4, 3, 5, 0]
    ///
    /// This method is equivalent to calling `shuffled(using:)`, passing in the
    /// system's default random generator.
    ///
    /// - Returns: A shuffled array of this sequence's elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func shuffled() -> [Value]

    /// The indices that are valid for subscripting the collection, in ascending
    /// order.
    ///
    /// A collection's `indices` property can hold a strong reference to the
    /// collection itself, causing the collection to be non-uniquely referenced.
    /// If you mutate the collection while iterating over its indices, a strong
    /// reference can cause an unexpected copy of the collection. To avoid the
    /// unexpected copy, use the `index(after:)` method starting with
    /// `startIndex` to produce indices instead.
    ///
    ///     var c = MyFancyCollection([10, 20, 30, 40, 50])
    ///     var i = c.startIndex
    ///     while i != c.endIndex {
    ///         c[i] /= 5
    ///         i = c.index(after: i)
    ///     }
    ///     // c == MyFancyCollection([2, 4, 6, 8, 10])
    @inlinable public var indices: DefaultIndices<Dictionary<Key, Value>.Values> { get }

    /// A sequence containing the same elements as this sequence,
    /// but on which some operations, such as `map` and `filter`, are
    /// implemented lazily.
    @inlinable public var lazy: LazySequence<Dictionary<Key, Value>.Values> { get }

    @available(swift, deprecated: 4.1, renamed: "compactMap(_:)", message: "Please use compactMap(_:) for the case where closure returns an optional value")
    public func flatMap<ElementOfResult>(_ transform: (Value) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Call `body(p)`, where `p` is a pointer to the collection's
    /// mutable contiguous storage.  If no such storage exists, it is
    /// first created.  If the collection does not support an internal
    /// representation in a form of mutable contiguous storage, `body` is not
    /// called and `nil` is returned.
    ///
    /// Often, the optimizer can eliminate bounds- and uniqueness-checks
    /// within an algorithm, but when that fails, invoking the
    /// same algorithm on `body`\ 's argument lets you trade safety for
    /// speed.
    @inlinable public mutating func withContiguousMutableStorageIfAvailable<R>(_ body: (inout UnsafeMutableBufferPointer<Value>) throws -> R) rethrows -> R?

    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection. Always use the slice's `startIndex` property
    /// instead of assuming that its indices start at a particular value.
    ///
    /// This example demonstrates getting a slice of an array of strings, finding
    /// the index of one of the strings in the slice, and then using that index
    /// in the original array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2 ..< streets.endIndex]
    ///     print(streetsSlice)
    ///     // Prints "["Channing", "Douglas", "Evarts"]"
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     streets[index!] = "Eustace"
    ///     print(streets[index!])
    ///     // Prints "Eustace"
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript(bounds: Range<Dictionary<Key, Value>.Index>) -> Slice<Dictionary<Key, Value>.Values>

    /// Exchanges the values at the specified indices of the collection.
    ///
    /// Both parameters must be valid indices of the collection that are not
    /// equal to `endIndex`. Calling `swapAt(_:_:)` with the same index as both
    /// `i` and `j` has no effect.
    ///
    /// - Parameters:
    ///   - i: The index of the first value to swap.
    ///   - j: The index of the second value to swap.
    ///
    /// - Complexity: O(1)
    @inlinable public mutating func swapAt(_ i: Dictionary<Key, Value>.Index, _ j: Dictionary<Key, Value>.Index)

    /// Accesses the contiguous subrange of the collection's elements specified
    /// by a range expression.
    ///
    /// The range expression is converted to a concrete subrange relative to this
    /// collection. For example, using a `PartialRangeFrom` range expression
    /// with an array accesses the subrange from the start of the range
    /// expression until the end of the array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2...]
    ///     print(streetsSlice)
    ///     // ["Channing", "Douglas", "Evarts"]
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection uses. This example searches `streetsSlice` for one
    /// of the strings in the slice, and then uses that index in the original
    /// array.
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // "Evarts"
    ///
    /// Always use the slice's `startIndex` property instead of assuming that its
    /// indices start at a particular value. Attempting to access an element by
    /// using an index outside the bounds of the slice's indices may result in a
    /// runtime error, even if that index is valid for the original collection.
    ///
    ///     print(streetsSlice.startIndex)
    ///     // 2
    ///     print(streetsSlice[2])
    ///     // "Channing"
    ///
    ///     print(streetsSlice[0])
    ///     // error: Index out of bounds
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript<R>(r: R) -> Slice<Dictionary<Key, Value>.Values> where R : RangeExpression, Self.Index == R.Bound { get }

    @inlinable public subscript(x: (UnboundedRange_) -> ()) -> Slice<Dictionary<Key, Value>.Values> { get }

    @inlinable public subscript<R>(r: R) -> Slice<Dictionary<Key, Value>.Values> where R : RangeExpression, Self.Index == R.Bound

    @inlinable public subscript(x: (UnboundedRange_) -> ()) -> Slice<Dictionary<Key, Value>.Values>

    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.map { $0.lowercased() }
    ///     // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func map<T>(_ transform: (Value) throws -> T) rethrows -> [T]

    /// Returns an array containing, in order, the elements of the sequence
    /// that satisfy the given predicate.
    ///
    /// In this example, `filter(_:)` is used to include only names shorter than
    /// five characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let shortNames = cast.filter { $0.count < 5 }
    ///     print(shortNames)
    ///     // Prints "["Kim", "Karl"]"
    ///
    /// - Parameter isIncluded: A closure that takes an element of the
    ///   sequence as its argument and returns a Boolean value indicating
    ///   whether the element should be included in the returned array.
    /// - Returns: An array of the elements that `isIncluded` allowed.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func filter(_ isIncluded: (Value) throws -> Bool) rethrows -> [Value]

    /// A value less than or equal to the number of elements in the sequence,
    /// calculated nondestructively.
    ///
    /// The default implementation returns 0. If you provide your own
    /// implementation, make sure to compute the value nondestructively.
    ///
    /// - Complexity: O(1), except if the sequence also conforms to `Collection`.
    ///   In this case, see the documentation of `Collection.underestimatedCount`.
    @inlinable public var underestimatedCount: Int { get }

    /// Calls the given closure on each element in the sequence in the same order
    /// as a `for`-`in` loop.
    ///
    /// The two loops in the following example produce the same output:
    ///
    ///     let numberWords = ["one", "two", "three"]
    ///     for word in numberWords {
    ///         print(word)
    ///     }
    ///     // Prints "one"
    ///     // Prints "two"
    ///     // Prints "three"
    ///
    ///     numberWords.forEach { word in
    ///         print(word)
    ///     }
    ///     // Same as above
    ///
    /// Using the `forEach` method is distinct from a `for`-`in` loop in two
    /// important ways:
    ///
    /// 1. You cannot use a `break` or `continue` statement to exit the current
    ///    call of the `body` closure or skip subsequent calls.
    /// 2. Using the `return` statement in the `body` closure will exit only from
    ///    the current call to `body`, not from any outer scope, and won't skip
    ///    subsequent calls.
    ///
    /// - Parameter body: A closure that takes an element of the sequence as a
    ///   parameter.
    @inlinable public func forEach(_ body: (Value) throws -> Void) rethrows

    /// Returns the first element of the sequence that satisfies the given
    /// predicate.
    ///
    /// The following example uses the `first(where:)` method to find the first
    /// negative number in an array of integers:
    ///
    ///     let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
    ///     if let firstNegative = numbers.first(where: { $0 < 0 }) {
    ///         print("The first negative number is \(firstNegative).")
    ///     }
    ///     // Prints "The first negative number is -2."
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence as
    ///   its argument and returns a Boolean value indicating whether the
    ///   element is a match.
    /// - Returns: The first element of the sequence that satisfies `predicate`,
    ///   or `nil` if there is no element that satisfies `predicate`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func first(where predicate: (Value) throws -> Bool) rethrows -> Value?

    /// Call `body(p)`, where `p` is a pointer to the collection's
    /// contiguous storage.  If no such storage exists, it is
    /// first created.  If the collection does not support an internal
    /// representation in a form of contiguous storage, `body` is not
    /// called and `nil` is returned.
    ///
    /// A `Collection` that provides its own implementation of this method
    /// must also guarantee that an equivalent buffer of its `SubSequence`
    /// can be generated by advancing the pointer by the distance to the
    /// slice's `startIndex`.
    @inlinable public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Value>) throws -> R) rethrows -> R?

    /// Returns a sequence of pairs (*n*, *x*), where *n* represents a
    /// consecutive integer starting at zero and *x* represents an element of
    /// the sequence.
    ///
    /// This example enumerates the characters of the string "Swift" and prints
    /// each character along with its place in the string.
    ///
    ///     for (n, c) in "Swift".enumerated() {
    ///         print("\(n): '\(c)'")
    ///     }
    ///     // Prints "0: 'S'"
    ///     // Prints "1: 'w'"
    ///     // Prints "2: 'i'"
    ///     // Prints "3: 'f'"
    ///     // Prints "4: 't'"
    ///
    /// When you enumerate a collection, the integer part of each pair is a counter
    /// for the enumeration, but is not necessarily the index of the paired value.
    /// These counters can be used as indices only in instances of zero-based,
    /// integer-indexed collections, such as `Array` and `ContiguousArray`. For
    /// other collections the counters may be out of range or of the wrong type
    /// to use as an index. To iterate over the elements of a collection with its
    /// indices, use the `zip(_:_:)` function.
    ///
    /// This example iterates over the indices and elements of a set, building a
    /// list consisting of indices of names with five or fewer letters.
    ///
    ///     let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     var shorterIndices: [Set<String>.Index] = []
    ///     for (i, name) in zip(names.indices, names) {
    ///         if name.count <= 5 {
    ///             shorterIndices.append(i)
    ///         }
    ///     }
    ///
    /// Now that the `shorterIndices` array holds the indices of the shorter
    /// names in the `names` set, you can use those indices to access elements in
    /// the set.
    ///
    ///     for i in shorterIndices {
    ///         print(names[i])
    ///     }
    ///     // Prints "Sofia"
    ///     // Prints "Mateo"
    ///
    /// - Returns: A sequence of pairs enumerating the sequence.
    ///
    /// - Complexity: O(1)
    @inlinable public func enumerated() -> EnumeratedSequence<Dictionary<Key, Value>.Values>

    /// Returns the minimum element in the sequence, using the given predicate as
    /// the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `min(by:)` method on a
    /// dictionary to find the key-value pair with the lowest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let leastHue = hues.min { a, b in a.value < b.value }
    ///     print(leastHue)
    ///     // Prints "Optional(("Coral", 16))"
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true`
    ///   if its first argument should be ordered before its second
    ///   argument; otherwise, `false`.
    /// - Returns: The sequence's minimum element, according to
    ///   `areInIncreasingOrder`. If the sequence has no elements, returns
    ///   `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func min(by areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> Value?

    /// Returns the maximum element in the sequence, using the given predicate
    /// as the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// This example shows how to use the `max(by:)` method on a
    /// dictionary to find the key-value pair with the highest value.
    ///
    ///     let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
    ///     let greatestHue = hues.max { a, b in a.value < b.value }
    ///     print(greatestHue)
    ///     // Prints "Optional(("Heliotrope", 296))"
    ///
    /// - Parameter areInIncreasingOrder:  A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: The sequence's maximum element if the sequence is not empty;
    ///   otherwise, `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func max(by areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> Value?

    /// Returns a Boolean value indicating whether the initial elements of the
    /// sequence are equivalent to the elements in another sequence, using
    /// the given predicate as the equivalence test.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - possiblePrefix: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if the initial elements of the sequence are equivalent
    ///   to the elements of `possiblePrefix`; otherwise, `false`. If
    ///   `possiblePrefix` has no elements, the return value is `true`.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `possiblePrefix`.
    @inlinable public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: (Value, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool where PossiblePrefix : Sequence

    /// Returns a Boolean value indicating whether this sequence and another
    /// sequence contain equivalent elements in the same order, using the given
    /// predicate as the equivalence test.
    ///
    /// At least one of the sequences must be finite.
    ///
    /// The predicate must be a *equivalence relation* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areEquivalent(a, a)` is always `true`. (Reflexivity)
    /// - `areEquivalent(a, b)` implies `areEquivalent(b, a)`. (Symmetry)
    /// - If `areEquivalent(a, b)` and `areEquivalent(b, c)` are both `true`, then
    ///   `areEquivalent(a, c)` is also `true`. (Transitivity)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areEquivalent: A predicate that returns `true` if its two arguments
    ///     are equivalent; otherwise, `false`.
    /// - Returns: `true` if this sequence and `other` contain equivalent items,
    ///   using `areEquivalent` as the equivalence test; otherwise, `false.`
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: (Value, OtherSequence.Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence

    /// Returns a Boolean value indicating whether the sequence precedes another
    /// sequence in a lexicographical (dictionary) ordering, using the given
    /// predicate to compare elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also
    ///   `true`. (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// - Parameters:
    ///   - other: A sequence to compare to this sequence.
    ///   - areInIncreasingOrder:  A predicate that returns `true` if its first
    ///     argument should be ordered before its second argument; otherwise,
    ///     `false`.
    /// - Returns: `true` if this sequence precedes `other` in a dictionary
    ///   ordering as ordered by `areInIncreasingOrder`; otherwise, `false`.
    ///
    /// - Note: This method implements the mathematical notion of lexicographical
    ///   ordering, which has no connection to Unicode.  If you are sorting
    ///   strings to present to the end user, use `String` APIs that perform
    ///   localized comparison instead.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns a Boolean value indicating whether the sequence contains an
    /// element that satisfies the given predicate.
    ///
    /// You can use the predicate to check for an element of a type that
    /// doesn't conform to the `Equatable` protocol, such as the
    /// `HTTPResponse` enumeration in this example.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let lastThreeResponses: [HTTPResponse] = [.ok, .ok, .error(404)]
    ///     let hadError = lastThreeResponses.contains { element in
    ///         if case .error = element {
    ///             return true
    ///         } else {
    ///             return false
    ///         }
    ///     }
    ///     // 'hadError' == true
    ///
    /// Alternatively, a predicate can be satisfied by a range of `Equatable`
    /// elements or a general condition. This example shows how you can check an
    /// array for an expense greater than $100.
    ///
    ///     let expenses = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
    ///     let hasBigPurchase = expenses.contains { $0 > 100 }
    ///     // 'hasBigPurchase' == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element represents a match.
    /// - Returns: `true` if the sequence contains an element that satisfies
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func contains(where predicate: (Value) throws -> Bool) rethrows -> Bool

    /// Returns a Boolean value indicating whether every element of a sequence
    /// satisfies a given predicate.
    ///
    /// The following code uses this method to test whether all the names in an
    /// array have at least five characters:
    ///
    ///     let names = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     let allHaveAtLeastFive = names.allSatisfy({ $0.count >= 5 })
    ///     // allHaveAtLeastFive == true
    ///
    /// - Parameter predicate: A closure that takes an element of the sequence
    ///   as its argument and returns a Boolean value that indicates whether
    ///   the passed element satisfies a condition.
    /// - Returns: `true` if the sequence contains only elements that satisfy
    ///   `predicate`; otherwise, `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func allSatisfy(_ predicate: (Value) throws -> Bool) rethrows -> Bool

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(_:_:)` method to produce a single value from the elements
    /// of an entire sequence. For example, you can use this method on an array
    /// of numbers to find their sum or product.
    ///
    /// The `nextPartialResult` closure is called sequentially with an
    /// accumulating value initialized to `initialResult` and each element of
    /// the sequence. This example shows how to find the sum of an array of
    /// numbers.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///     let numberSum = numbers.reduce(0, { x, y in
    ///         x + y
    ///     })
    ///     // numberSum == 10
    ///
    /// When `numbers.reduce(_:_:)` is called, the following steps occur:
    ///
    /// 1. The `nextPartialResult` closure is called with `initialResult`---`0`
    ///    in this case---and the first element of `numbers`, returning the sum:
    ///    `1`.
    /// 2. The closure is called again repeatedly with the previous call's return
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the last value returned from the
    ///    closure is returned to the caller.
    ///
    /// If the sequence has no elements, `nextPartialResult` is never executed
    /// and `initialResult` is the result of the call to `reduce(_:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Value) throws -> Result) rethrows -> Result

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(into:_:)` method to produce a single value from the
    /// elements of an entire sequence. For example, you can use this method on an
    /// array of integers to filter adjacent equal entries or count frequencies.
    ///
    /// This method is preferred over `reduce(_:_:)` for efficiency when the
    /// result is a copy-on-write type, for example an Array or a Dictionary.
    ///
    /// The `updateAccumulatingResult` closure is called sequentially with a
    /// mutable accumulating value initialized to `initialResult` and each element
    /// of the sequence. This example shows how to build a dictionary of letter
    /// frequencies of a string.
    ///
    ///     let letters = "abracadabra"
    ///     let letterCount = letters.reduce(into: [:]) { counts, letter in
    ///         counts[letter, default: 0] += 1
    ///     }
    ///     // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]
    ///
    /// When `letters.reduce(into:_:)` is called, the following steps occur:
    ///
    /// 1. The `updateAccumulatingResult` closure is called with the initial
    ///    accumulating value---`[:]` in this case---and the first character of
    ///    `letters`, modifying the accumulating value by setting `1` for the key
    ///    `"a"`.
    /// 2. The closure is called again repeatedly with the updated accumulating
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the accumulating value is returned to
    ///    the caller.
    ///
    /// If the sequence has no elements, `updateAccumulatingResult` is never
    /// executed and `initialResult` is the result of the call to
    /// `reduce(into:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element of the sequence.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Value) throws -> ()) rethrows -> Result

    /// Returns an array containing the elements of this sequence in reverse
    /// order.
    ///
    /// The sequence must be finite.
    ///
    /// - Returns: An array containing the elements of this sequence in
    ///   reverse order.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func reversed() -> [Value]

    /// Returns an array containing the concatenated results of calling the
    /// given transformation with each element of this sequence.
    ///
    /// Use this method to receive a single-level collection when your
    /// transformation produces a sequence or collection for each element.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `flatMap` with a transformation that returns an array.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///
    ///     let mapped = numbers.map { Array(repeating: $0, count: $0) }
    ///     // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
    ///
    ///     let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
    ///     // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    ///
    /// In fact, `s.flatMap(transform)`  is equivalent to
    /// `Array(s.map(transform).joined())`.
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns a sequence or collection.
    /// - Returns: The resulting flattened array.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func flatMap<SegmentOfResult>(_ transform: (Value) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence

    /// Returns an array containing the non-`nil` results of calling the given
    /// transformation with each element of this sequence.
    ///
    /// Use this method to receive an array of non-optional values when your
    /// transformation produces an optional value.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `compactMap` with a transformation that returns an optional `Int` value.
    ///
    ///     let possibleNumbers = ["1", "2", "three", "///4///", "5"]
    ///
    ///     let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
    ///     // [1, 2, nil, nil, 5]
    ///
    ///     let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
    ///     // [1, 2, 5]
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns an optional value.
    /// - Returns: An array of the non-`nil` results of calling `transform`
    ///   with each element of the sequence.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
    @inlinable public func compactMap<ElementOfResult>(_ transform: (Value) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

    /// Returns the elements of the sequence, sorted using the given predicate as
    /// the comparison between elements.
    ///
    /// When you want to sort a sequence of elements that don't conform to the
    /// `Comparable` protocol, pass a predicate to this method that returns
    /// `true` when the first element should be ordered before the second. The
    /// elements of the resulting array are ordered according to the given
    /// predicate.
    ///
    /// In the following example, the predicate provides an ordering for an array
    /// of a custom `HTTPResponse` type. The predicate orders errors before
    /// successes and sorts the error responses by their error code.
    ///
    ///     enum HTTPResponse {
    ///         case ok
    ///         case error(Int)
    ///     }
    ///
    ///     let responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]
    ///     let sortedResponses = responses.sorted {
    ///         switch ($0, $1) {
    ///         // Order errors by code
    ///         case let (.error(aCode), .error(bCode)):
    ///             return aCode < bCode
    ///
    ///         // All successes are equivalent, so none is before any other
    ///         case (.ok, .ok): return false
    ///
    ///         // Order errors before successes
    ///         case (.error, .ok): return true
    ///         case (.ok, .error): return false
    ///         }
    ///     }
    ///     print(sortedResponses)
    ///     // Prints "[.error(403), .error(404), .error(500), .ok, .ok]"
    ///
    /// You also use this method to sort elements that conform to the
    /// `Comparable` protocol in descending order. To sort your sequence in
    /// descending order, pass the greater-than operator (`>`) as the
    /// `areInIncreasingOrder` parameter.
    ///
    ///     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     let descendingStudents = students.sorted(by: >)
    ///     print(descendingStudents)
    ///     // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"
    ///
    /// Calling the related `sorted()` method is equivalent to calling this
    /// method and passing the less-than operator (`<`) as the predicate.
    ///
    ///     print(students.sorted())
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///     print(students.sorted(by: <))
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///
    /// The predicate must be a *strict weak ordering* over the elements. That
    /// is, for any elements `a`, `b`, and `c`, the following conditions must
    /// hold:
    ///
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are
    ///   both `true`, then `areInIncreasingOrder(a, c)` is also `true`.
    ///   (Transitive comparability)
    /// - Two elements are *incomparable* if neither is ordered before the other
    ///   according to the predicate. If `a` and `b` are incomparable, and `b`
    ///   and `c` are incomparable, then `a` and `c` are also incomparable.
    ///   (Transitive incomparability)
    ///
    /// The sorting algorithm is not guaranteed to be stable. A stable sort
    /// preserves the relative order of elements for which
    /// `areInIncreasingOrder` does not establish an order.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true` if its
    ///   first argument should be ordered before its second argument;
    ///   otherwise, `false`.
    /// - Returns: A sorted array of the sequence's elements.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    @inlinable public func sorted(by areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Value]
}

/// Supply the default "slicing" `subscript` for `Collection` models
/// that accept the default associated `SubSequence`, `Slice<Self>`.
extension Dictionary.Values {

    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection. Always use the slice's `startIndex` property
    /// instead of assuming that its indices start at a particular value.
    ///
    /// This example demonstrates getting a slice of an array of strings, finding
    /// the index of one of the strings in the slice, and then using that index
    /// in the original array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2 ..< streets.endIndex]
    ///     print(streetsSlice)
    ///     // Prints "["Channing", "Douglas", "Evarts"]"
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // Prints "Evarts"
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public subscript(bounds: Range<Dictionary<Key, Value>.Index>) -> Slice<Dictionary<Key, Value>.Values> { get }
}

/// Default implementation for forward collections.
extension Dictionary.Values {

    /// Returns an index that is the specified distance from the given index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    ///
    ///     let s = "Swift"
    ///     let i = s.index(s.startIndex, offsetBy: 4)
    ///     print(s[i])
    ///     // Prints "t"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    /// - Returns: An index offset by `distance` from the index `i`. If
    ///   `distance` is positive, this is the same value as the result of
    ///   `distance` calls to `index(after:)`. If `distance` is negative, this
    ///   is the same value as the result of `abs(distance)` calls to
    ///   `index(before:)`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Dictionary<Key, Value>.Index, offsetBy distance: Int) -> Dictionary<Key, Value>.Index

    /// Returns an index that is the specified distance from the given index,
    /// unless that distance is beyond a given limiting index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    /// The operation doesn't require going beyond the limiting `s.endIndex`
    /// value, so it succeeds.
    ///
    ///     let s = "Swift"
    ///     if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    ///         print(s[i])
    ///     }
    ///     // Prints "t"
    ///
    /// The next example attempts to retrieve an index six positions from
    /// `s.startIndex` but fails, because that distance is beyond the index
    /// passed as `limit`.
    ///
    ///     let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
    ///     print(j)
    ///     // Prints "nil"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: An index offset by `distance` from the index `i`, unless that
    ///   index would be beyond `limit` in the direction of movement. In that
    ///   case, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func index(_ i: Dictionary<Key, Value>.Index, offsetBy distance: Int, limitedBy limit: Dictionary<Key, Value>.Index) -> Dictionary<Key, Value>.Index?

    /// Offsets the given index by the specified distance.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Dictionary<Key, Value>.Index, offsetBy distance: Int)

    /// Offsets the given index by the specified distance, or so that it equals
    /// the given limiting index.
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: `true` if `i` has been offset by exactly `distance` steps
    ///   without going beyond `limit`; otherwise, `false`. When the return
    ///   value is `false`, the value of `i` is equal to `limit`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    @inlinable public func formIndex(_ i: inout Dictionary<Key, Value>.Index, offsetBy distance: Int, limitedBy limit: Dictionary<Key, Value>.Index) -> Bool

    /// Returns the distance between two indices.
    ///
    /// Unless the collection conforms to the `BidirectionalCollection` protocol,
    /// `start` must be less than or equal to `end`.
    ///
    /// - Parameters:
    ///   - start: A valid index of the collection.
    ///   - end: Another valid index of the collection. If `end` is equal to
    ///     `start`, the result is zero.
    /// - Returns: The distance between `start` and `end`. The result can be
    ///   negative only if the collection conforms to the
    ///   `BidirectionalCollection` protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the
    ///   resulting distance.
    @inlinable public func distance(from start: Dictionary<Key, Value>.Index, to end: Dictionary<Key, Value>.Index) -> Int

    /// Returns a random element of the collection, using the given generator as
    /// a source for randomness.
    ///
    /// Call `randomElement(using:)` to select a random element from an array or
    /// another collection when you are using a custom random number generator.
    /// This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement(using: &myGenerator)!
    ///     // randomName == "Amani"
    ///
    /// - Parameter generator: The random number generator to use when choosing a
    ///   random element.
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    /// - Note: The algorithm used to select a random element may change in a
    ///   future version of Swift. If you're passing a generator that results in
    ///   the same sequence of elements each time you run your program, that
    ///   sequence may change when your program is compiled using a different
    ///   version of Swift.
    @inlinable public func randomElement<T>(using generator: inout T) -> Value? where T : RandomNumberGenerator

    /// Returns a random element of the collection.
    ///
    /// Call `randomElement()` to select a random element from an array or
    /// another collection. This example picks a name at random from an array:
    ///
    ///     let names = ["Zoey", "Chloe", "Amani", "Amaia"]
    ///     let randomName = names.randomElement()!
    ///     // randomName == "Amani"
    ///
    /// This method is equivalent to calling `randomElement(using:)`, passing in
    /// the system's default random generator.
    ///
    /// - Returns: A random element from the collection. If the collection is
    ///   empty, the method returns `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public func randomElement() -> Value?
}

/// Default implementations of core requirements
extension Dictionary.Values {

    /// A Boolean value indicating whether the collection is empty.
    ///
    /// When you need to check whether your collection is empty, use the
    /// `isEmpty` property instead of checking that the `count` property is
    /// equal to zero. For collections that don't conform to
    /// `RandomAccessCollection`, accessing the `count` property iterates
    /// through the elements of the collection.
    ///
    ///     let horseName = "Silver"
    ///     if horseName.isEmpty {
    ///         print("I've been through the desert on a horse with no name.")
    ///     } else {
    ///         print("Hi ho, \(horseName)!")
    ///     }
    ///     // Prints "Hi ho, Silver!")
    ///
    /// - Complexity: O(1)
    @inlinable public var isEmpty: Bool { get }

    /// The first element of the collection.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let firstNumber = numbers.first {
    ///         print(firstNumber)
    ///     }
    ///     // Prints "10"
    @inlinable public var first: Value? { get }

    /// A value less than or equal to the number of elements in the collection.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var underestimatedCount: Int { get }

    /// The number of elements in the collection.
    ///
    /// To check whether a collection is empty, use its `isEmpty` property
    /// instead of comparing `count` to zero. Unless the collection guarantees
    /// random-access performance, calculating `count` can be an O(*n*)
    /// operation.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    @inlinable public var count: Int { get }
}

extension Dictionary.Values where Self.Element : Comparable {

    /// Returns the minimum element in the sequence.
    ///
    /// This example finds the smallest value in an array of height measurements.
    ///
    ///     let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
    ///     let lowestHeight = heights.min()
    ///     print(lowestHeight)
    ///     // Prints "Optional(58.5)"
    ///
    /// - Returns: The sequence's minimum element. If the sequence has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func min() -> Value?

    /// Returns the maximum element in the sequence.
    ///
    /// This example finds the largest value in an array of height measurements.
    ///
    ///     let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
    ///     let greatestHeight = heights.max()
    ///     print(greatestHeight)
    ///     // Prints "Optional(67.5)"
    ///
    /// - Returns: The sequence's maximum element. If the sequence has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @warn_unqualified_access
    @inlinable public func max() -> Value?

    /// Returns a Boolean value indicating whether the sequence precedes another
    /// sequence in a lexicographical (dictionary) ordering, using the
    /// less-than operator (`<`) to compare elements.
    ///
    /// This example uses the `lexicographicallyPrecedes` method to test which
    /// array of integers comes first in a lexicographical ordering.
    ///
    ///     let a = [1, 2, 2, 2]
    ///     let b = [1, 2, 3, 4]
    ///
    ///     print(a.lexicographicallyPrecedes(b))
    ///     // Prints "true"
    ///     print(b.lexicographicallyPrecedes(b))
    ///     // Prints "false"
    ///
    /// - Parameter other: A sequence to compare to this sequence.
    /// - Returns: `true` if this sequence precedes `other` in a dictionary
    ///   ordering; otherwise, `false`.
    ///
    /// - Note: This method implements the mathematical notion of lexicographical
    ///   ordering, which has no connection to Unicode.  If you are sorting
    ///   strings to present to the end user, use `String` APIs that
    ///   perform localized comparison.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns the elements of the sequence, sorted.
    ///
    /// You can sort any sequence of elements that conform to the `Comparable`
    /// protocol by calling this method. Elements are sorted in ascending order.
    ///
    /// Here's an example of sorting a list of students' names. Strings in Swift
    /// conform to the `Comparable` protocol, so the names are sorted in
    /// ascending order according to the less-than operator (`<`).
    ///
    ///     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     let sortedStudents = students.sorted()
    ///     print(sortedStudents)
    ///     // Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
    ///
    /// To sort the elements of your sequence in descending order, pass the
    /// greater-than operator (`>`) to the `sorted(by:)` method.
    ///
    ///     let descendingStudents = students.sorted(by: >)
    ///     print(descendingStudents)
    ///     // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"
    ///
    /// The sorting algorithm is not guaranteed to be stable. A stable sort
    /// preserves the relative order of elements that compare equal.
    ///
    /// - Returns: A sorted array of the sequence's elements.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    @inlinable public func sorted() -> [Value]
}

extension Dictionary.Values where Self.Element : Equatable {

    /// Returns the longest possible subsequences of the collection, in order,
    /// around elements equal to the given element.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the collection are not returned as part
    /// of any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string at each
    /// space character (" "). The first use of `split` returns each word that
    /// was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(separator: " "))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(separator: " ", maxSplits: 1))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(separator: " ", omittingEmptySubsequences: false))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - separator: The element that should be split upon.
    ///   - maxSplits: The maximum number of times to split the collection, or
    ///     one less than the number of subsequences to return. If
    ///     `maxSplits + 1` subsequences are returned, the last one is a suffix
    ///     of the original collection containing the remaining elements.
    ///     `maxSplits` must be greater than or equal to zero. The default value
    ///     is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each consecutive pair of `separator`
    ///     elements in the collection and for each instance of `separator` at
    ///     the start or end of the collection. If `true`, only nonempty
    ///     subsequences are returned. The default value is `true`.
    /// - Returns: An array of subsequences, split from this collection's
    ///   elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func split(separator: Value, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [Slice<Dictionary<Key, Value>.Values>]

    /// Returns the first index where the specified value appears in the
    /// collection.
    ///
    /// After using `firstIndex(of:)` to find the position of a particular element
    /// in a collection, you can use it to access the element by subscripting.
    /// This example shows how you can modify one of the names in an array of
    /// students.
    ///
    ///     var students = ["Ben", "Ivy", "Jordell", "Maxime"]
    ///     if let i = students.firstIndex(of: "Maxime") {
    ///         students[i] = "Max"
    ///     }
    ///     print(students)
    ///     // Prints "["Ben", "Ivy", "Jordell", "Max"]"
    ///
    /// - Parameter element: An element to search for in the collection.
    /// - Returns: The first index where `element` is found. If `element` is not
    ///   found in the collection, returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable public func firstIndex(of element: Value) -> Dictionary<Key, Value>.Index?

    /// Returns the first index where the specified value appears in the
    /// collection.
    @available(swift, deprecated: 5.0, renamed: "firstIndex(of:)")
    @inlinable public func index(of element: Value) -> Dictionary<Key, Value>.Index?

    /// Returns the longest possible subsequences of the sequence, in order,
    /// around elements equal to the given element.
    ///
    /// The resulting array consists of at most `maxSplits + 1` subsequences.
    /// Elements that are used to split the sequence are not returned as part of
    /// any subsequence.
    ///
    /// The following examples show the effects of the `maxSplits` and
    /// `omittingEmptySubsequences` parameters when splitting a string at each
    /// space character (" "). The first use of `split` returns each word that
    /// was originally separated by one or more spaces.
    ///
    ///     let line = "BLANCHE:   I don't want realism. I want magic!"
    ///     print(line.split(separator: " ")
    ///               .map(String.init))
    ///     // Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// The second example passes `1` for the `maxSplits` parameter, so the
    /// original string is split just once, into two new strings.
    ///
    ///     print(line.split(separator: " ", maxSplits: 1)
    ///               .map(String.init))
    ///     // Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"
    ///
    /// The final example passes `false` for the `omittingEmptySubsequences`
    /// parameter, so the returned array contains empty strings where spaces
    /// were repeated.
    ///
    ///     print(line.split(separator: " ", omittingEmptySubsequences: false)
    ///               .map(String.init))
    ///     // Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
    ///
    /// - Parameters:
    ///   - separator: The element that should be split upon.
    ///   - maxSplits: The maximum number of times to split the sequence, or one
    ///     less than the number of subsequences to return. If `maxSplits + 1`
    ///     subsequences are returned, the last one is a suffix of the original
    ///     sequence containing the remaining elements. `maxSplits` must be
    ///     greater than or equal to zero. The default value is `Int.max`.
    ///   - omittingEmptySubsequences: If `false`, an empty subsequence is
    ///     returned in the result for each consecutive pair of `separator`
    ///     elements in the sequence and for each instance of `separator` at the
    ///     start or end of the sequence. If `true`, only nonempty subsequences
    ///     are returned. The default value is `true`.
    /// - Returns: An array of subsequences, split from this sequence's elements.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func split(separator: Value, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [ArraySlice<Value>]

    /// Returns a Boolean value indicating whether the initial elements of the
    /// sequence are the same as the elements in another sequence.
    ///
    /// This example tests whether one countable range begins with the elements
    /// of another countable range.
    ///
    ///     let a = 1...3
    ///     let b = 1...10
    ///
    ///     print(b.starts(with: a))
    ///     // Prints "true"
    ///
    /// Passing a sequence with no elements or an empty collection as
    /// `possiblePrefix` always results in `true`.
    ///
    ///     print(b.starts(with: []))
    ///     // Prints "true"
    ///
    /// - Parameter possiblePrefix: A sequence to compare to this sequence.
    /// - Returns: `true` if the initial elements of the sequence are the same as
    ///   the elements of `possiblePrefix`; otherwise, `false`. If
    ///   `possiblePrefix` has no elements, the return value is `true`.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `possiblePrefix`.
    @inlinable public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool where PossiblePrefix : Sequence, Self.Element == PossiblePrefix.Element

    /// Returns a Boolean value indicating whether this sequence and another
    /// sequence contain the same elements in the same order.
    ///
    /// At least one of the sequences must be finite.
    ///
    /// This example tests whether one countable range shares the same elements
    /// as another countable range and an array.
    ///
    ///     let a = 1...3
    ///     let b = 1...10
    ///
    ///     print(a.elementsEqual(b))
    ///     // Prints "false"
    ///     print(a.elementsEqual([1, 2, 3]))
    ///     // Prints "true"
    ///
    /// - Parameter other: A sequence to compare to this sequence.
    /// - Returns: `true` if this sequence and `other` contain the same elements
    ///   in the same order.
    ///
    /// - Complexity: O(*m*), where *m* is the lesser of the length of the
    ///   sequence and the length of `other`.
    @inlinable public func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element

    /// Returns a Boolean value indicating whether the sequence contains the
    /// given element.
    ///
    /// This example checks to see whether a favorite actor is in an array
    /// storing a movie's cast.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     print(cast.contains("Marlon"))
    ///     // Prints "true"
    ///     print(cast.contains("James"))
    ///     // Prints "false"
    ///
    /// - Parameter element: The element to find in the sequence.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    @inlinable public func contains(_ element: Value) -> Bool
}

extension Dictionary.Values where Self.Element : Sequence {

    /// Returns the elements of this sequence of sequences, concatenated.
    ///
    /// In this example, an array of three ranges is flattened so that the
    /// elements of each range can be iterated in turn.
    ///
    ///     let ranges = [0..<3, 8..<10, 15..<17]
    ///
    ///     // A for-in loop over 'ranges' accesses each range:
    ///     for range in ranges {
    ///       print(range)
    ///     }
    ///     // Prints "0..<3"
    ///     // Prints "8..<10"
    ///     // Prints "15..<17"
    ///
    ///     // Use 'joined()' to access each element of each range:
    ///     for index in ranges.joined() {
    ///         print(index, terminator: " ")
    ///     }
    ///     // Prints: "0 1 2 8 9 15 16"
    ///
    /// - Returns: A flattened view of the elements of this
    ///   sequence of sequences.
    @inlinable public func joined() -> FlattenSequence<Dictionary<Key, Value>.Values>

    /// Returns the concatenated elements of this sequence of sequences,
    /// inserting the given separator between each element.
    ///
    /// This example shows how an array of `[Int]` instances can be joined, using
    /// another `[Int]` instance as the separator:
    ///
    ///     let nestedNumbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    ///     let joined = nestedNumbers.joined(separator: [-1, -2])
    ///     print(Array(joined))
    ///     // Prints "[1, 2, 3, -1, -2, 4, 5, 6, -1, -2, 7, 8, 9]"
    ///
    /// - Parameter separator: A sequence to insert between each of this
    ///   sequence's elements.
    /// - Returns: The joined sequence of elements.
    @inlinable public func joined<Separator>(separator: Separator) -> JoinedSequence<Dictionary<Key, Value>.Values> where Separator : Sequence, Separator.Element == Self.Element.Element
}

extension Dictionary.Values where Self.Element : StringProtocol {

    /// Returns a new string by concatenating the elements of the sequence,
    /// adding the given separator between each element.
    ///
    /// The following example shows how an array of strings can be joined to a
    /// single, comma-separated string:
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let list = cast.joined(separator: ", ")
    ///     print(list)
    ///     // Prints "Vivien, Marlon, Kim, Karl"
    ///
    /// - Parameter separator: A string to insert between each of the elements
    ///   in this sequence. The default separator is an empty string.
    /// - Returns: A single, concatenated string.
    public func joined(separator: String = "") -> String
}

extension Dictionary.Index {

    /// Returns a closed range that contains both of its bounds.
    ///
    /// Use the closed range operator (`...`) to create a closed range of any type
    /// that conforms to the `Comparable` protocol. This example creates a
    /// `ClosedRange<Character>` from "a" up to, and including, "z".
    ///
    ///     let lowercase = "a"..."z"
    ///     print(lowercase.contains("z"))
    ///     // Prints "true"
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    public static func ... (minimum: Dictionary<Key, Value>.Index, maximum: Dictionary<Key, Value>.Index) -> ClosedRange<Dictionary<Key, Value>.Index>

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is greater than that of the second argument.
    ///
    /// This is the default implementation of the greater-than operator (`>`) for
    /// any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func > (lhs: Dictionary<Key, Value>.Index, rhs: Dictionary<Key, Value>.Index) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is less than or equal to that of the second argument.
    ///
    /// This is the default implementation of the less-than-or-equal-to
    /// operator (`<=`) for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func <= (lhs: Dictionary<Key, Value>.Index, rhs: Dictionary<Key, Value>.Index) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is greater than or equal to that of the second argument.
    ///
    /// This is the default implementation of the greater-than-or-equal-to operator
    /// (`>=`) for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    /// - Returns: `true` if `lhs` is greater than or equal to `rhs`; otherwise,
    ///   `false`.
    @inlinable public static func >= (lhs: Dictionary<Key, Value>.Index, rhs: Dictionary<Key, Value>.Index) -> Bool

    public static func != (lhs: Dictionary<Key, Value>.Index, rhs: Dictionary<Key, Value>.Index) -> Bool

    /// Returns a half-open range that contains its lower bound but not its upper
    /// bound.
    ///
    /// Use the half-open range operator (`..<`) to create a range of any type
    /// that conforms to the `Comparable` protocol. This example creates a
    /// `Range<Double>` from zero up to, but not including, 5.0.
    ///
    ///     let lessThanFive = 0.0..<5.0
    ///     print(lessThanFive.contains(3.14))  // Prints "true"
    ///     print(lessThanFive.contains(5.0))   // Prints "false"
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    public static func ..< (minimum: Dictionary<Key, Value>.Index, maximum: Dictionary<Key, Value>.Index) -> Range<Dictionary<Key, Value>.Index>

    /// Returns a partial range up to, but not including, its upper bound.
    ///
    /// Use the prefix half-open range operator (prefix `..<`) to create a
    /// partial range of any type that conforms to the `Comparable` protocol.
    /// This example creates a `PartialRangeUpTo<Double>` instance that includes
    /// any value less than `5.0`.
    ///
    ///     let upToFive = ..<5.0
    ///
    ///     upToFive.contains(3.14)       // true
    ///     upToFive.contains(6.28)       // false
    ///     upToFive.contains(5.0)        // false
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the start of the collection up to, but not
    /// including, the partial range's upper bound.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[..<3])
    ///     // Prints "[10, 20, 30]"
    ///
    /// - Parameter maximum: The upper bound for the range.
    prefix public static func ..< (maximum: Dictionary<Key, Value>.Index) -> PartialRangeUpTo<Dictionary<Key, Value>.Index>

    /// Returns a partial range up to, and including, its upper bound.
    ///
    /// Use the prefix closed range operator (prefix `...`) to create a partial
    /// range of any type that conforms to the `Comparable` protocol. This
    /// example creates a `PartialRangeThrough<Double>` instance that includes
    /// any value less than or equal to `5.0`.
    ///
    ///     let throughFive = ...5.0
    ///
    ///     throughFive.contains(4.0)     // true
    ///     throughFive.contains(5.0)     // true
    ///     throughFive.contains(6.0)     // false
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the start of the collection up to, and
    /// including, the partial range's upper bound.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[...3])
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// - Parameter maximum: The upper bound for the range.
    prefix public static func ... (maximum: Dictionary<Key, Value>.Index) -> PartialRangeThrough<Dictionary<Key, Value>.Index>

    /// Returns a partial range extending upward from a lower bound.
    ///
    /// Use the postfix range operator (postfix `...`) to create a partial range
    /// of any type that conforms to the `Comparable` protocol. This example
    /// creates a `PartialRangeFrom<Double>` instance that includes any value
    /// greater than or equal to `5.0`.
    ///
    ///     let atLeastFive = 5.0...
    ///
    ///     atLeastFive.contains(4.0)     // false
    ///     atLeastFive.contains(5.0)     // true
    ///     atLeastFive.contains(6.0)     // true
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the partial range's lower bound up to the end
    /// of the collection.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[3...])
    ///     // Prints "[40, 50, 60, 70]"
    ///
    /// - Parameter minimum: The lower bound for the range.
    postfix public static func ... (minimum: Dictionary<Key, Value>.Index) -> PartialRangeFrom<Dictionary<Key, Value>.Index>
}

extension Dictionary.Index : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func == (lhs: Dictionary<Key, Value>.Index, rhs: Dictionary<Key, Value>.Index) -> Bool
}

extension Dictionary.Index : Comparable {

    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func < (lhs: Dictionary<Key, Value>.Index, rhs: Dictionary<Key, Value>.Index) -> Bool
}

extension Dictionary.Index : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension Dictionary.Iterator : IteratorProtocol {

    /// Advances to the next element and returns it, or `nil` if no next element
    /// exists.
    ///
    /// Once `nil` has been returned, all subsequent calls return `nil`.
    @inlinable public mutating func next() -> (key: Key, value: Value)?

    /// The type of element traversed by the iterator.
    public typealias Element = (key: Key, value: Value)
}

extension Dictionary.Iterator : CustomReflectable {

    /// A mirror that reflects the iterator.
    public var customMirror: Mirror { get }
}

public typealias DictionaryIndex<Key, Value> = Dictionary<Key, Value>.Index where Key : Hashable

public typealias DictionaryIterator<Key, Value> = Dictionary<Key, Value>.Iterator where Key : Hashable

*/
