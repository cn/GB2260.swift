//
//  Division.swift
//  GB2260
//
//  Created by Di Wu on 4/18/16.
//

public struct Division {
  let name: String
  let code: String
  let revision: String
  let province: () -> String?
  let prefecture: () -> String?
}

extension Division: CustomStringConvertible {
  public var description: String {
    return [
      (province() ?? ""),
      (prefecture() ?? ""),
      name
      ].filter({$0 != ""})
       .joinWithSeparator(" ")
  }
}

