//
//  Division.swift
//  GB2260
//
//  Created by Di Wu on 4/18/16.
//

public struct Division {
  typealias LazyEvaluation = () -> String?
  public let name: String
  public let code: String
  public let revision: String
  public var province: String? {
    return getProvince()
  }
  public var prefecture: String? {
    return getPrefecture()
  }

  let getProvince: () -> String?
  let getPrefecture: () -> String?

  init(name: String, code: String, revision: String, getProvince: LazyEvaluation, getPrefecture: LazyEvaluation) {
    self.name = name
    self.code = code
    self.revision = revision
    self.getProvince = getProvince
    self.getPrefecture = getPrefecture
  }
}

extension Division: CustomStringConvertible {
  public var description: String {
    return [
      (province ?? ""),
      (prefecture ?? ""),
      name
      ].filter({$0 != ""})
       .joinWithSeparator(" ")
  }
}

