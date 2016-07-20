//
//  Division.swift
//  GB2260
//
//  Created by Di Wu on 4/18/16.
//

public struct Division {
  typealias LazyEvaluation = () -> Division?

  /// The name of this `Division`
  public let name: String
  /// The code of this `Division`
  public let code: String
  /// The GB2206 revision of this `Division`
  public let revision: String
  /// The possible province this `Division` belongs to
  public var province: Division? {
    return getProvince()
  }
  /// The possible prefecture this `Division` belongs to
  public var prefecture: Division? {
    return getPrefecture()
  }

  let getProvince: LazyEvaluation
  let getPrefecture: LazyEvaluation
}

extension Division: Equatable { }

public func ==(lhs: Division, rhs: Division) -> Bool {
  return lhs.code == rhs.code && lhs.revision == rhs.revision
}

extension Division: Comparable { }

public func <(lhs: Division, rhs: Division) -> Bool {
  return lhs.code < rhs.code
}

public func <=(lhs: Division, rhs: Division) -> Bool {
  return lhs.code <= rhs.code
}

public func >=(lhs: Division, rhs: Division) -> Bool {
  return lhs.code >= rhs.code
}

public func >(lhs: Division, rhs: Division) -> Bool {
  return lhs.code > rhs.code
}

extension Division: CustomStringConvertible {
  public var description: String {
    return [
      province?.name ?? "",
      prefecture?.name ?? "",
      name
    ].filter { !$0.isEmpty }.joinWithSeparator(" ")
  }
}

extension Division: CustomDebugStringConvertible {
  public var debugDescription: String {
    return [
      "<GB/T 2260-\(revision)>",
      code,
      description
      ].joinWithSeparator(" ")
  }
}
