//
//  Division.swift
//  GB2260
//
//  Created by Di Wu on 4/18/16.
//

public struct Division {
  typealias LazyEvaluation = () -> Division?
  public let name: String
  public let code: String
  public let revision: String
  public var province: Division? {
    return getProvince()
  }
  public var prefecture: Division? {
    return getPrefecture()
  }

  let getProvince: () -> Division?
  let getPrefecture: () -> Division?

  init(name: String, code: String, revision: String, getProvince: LazyEvaluation, getPrefecture: LazyEvaluation) {
    self.name = name
    self.code = code
    self.revision = revision
    self.getProvince = getProvince
    self.getPrefecture = getPrefecture
  }
}

extension Division: Equatable { }
public func ==(lhs: Division, rhs: Division) -> Bool {
  return lhs.code == rhs.code
}

extension Division: CustomStringConvertible {
  public var description: String {
    return [
      (province?.name ?? ""),
      (prefecture?.name ?? ""),
      name
      ].filter({$0 != ""})
       .joinWithSeparator(" ")
  }
}

