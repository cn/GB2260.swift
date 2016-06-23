//
//  GB2260.swift
//  GB2260
//
//  Created by Di Wu on 4/17/16.
//

/// An implementation for looking up Chinese administrative divisions(GB/T 2260 codes).
public class GB2260 {
  /// The revision of current loaded GB2260 dataset.
  public let revision: Revision

  private let data: [String: String]

  /**
   Creates an instance that loads given revision GB2260 dataset;
   it may failed to load when the specific revision dataset doesn't exist, and return `nil`.

   - Parameter revision: the specific `GB2260.Revision`
  */
  public init?(revision: Revision = .V201410) {
    self.revision = revision
    guard let path = revision.path,
          let data = (NSDictionary(contentsOfFile: path)?.objectForKey("data") as? [String: String])
    else {
      return nil
    }

    self.data = data
  }

}

private extension String {
  var isProvince: Bool {
    return hasSuffix("0000")
  }

  var isPrefecture: Bool {
    return hasSuffix("00")
  }

  var provinceCode: String {
    return substringToIndex(startIndex.advancedBy(2)) + "0000"
  }

  var prefectureCode: String {
    return substringToIndex(startIndex.advancedBy(4)) + "00"
  }
}

extension GB2260 {
  /**
   A `List` of provinces in `Division` under current loaded GB2260 revision.
  */
  public var provinces: [Division] {
    return data.filter { $0.0.isProvince }
               .flatMap { self[$0.0] }
               .sort(<)
  }

  /**
   Looking up for prefectures under a given province zipcode.

   - Parameter code: a valid GB2260 zipcode.

   - Returns: a list of prefecture cities in `Division` if it has one;
              returns empty list otherwise.
  */
  public func prefectures(of code: String) -> [Division] {
    guard let province = self[code] else {
      return []
    }
    return data.filter {
      $0.0.isPrefecture && self[$0.0]?.province == province
    }.flatMap { self[$0.0] }.sort(<)
  }

  /**
   Looking up for counties under a given prefecture code.

   - Parameter code: a valid GB2260 zipcode.

   - Returns: a list of counties in `Division` if it has one;
              returns empty list otherwise.
  */
  public func counties(of code: String) -> [Division] {
    guard let prefecture = self[code] else { return [] }
    return data.filter {
      !$0.0.isProvince &&
      !$0.0.isPrefecture &&
      self[$0.0]?.prefecture == prefecture
    }.flatMap { self[$0.0] }.sort(<)
  }

}

extension GB2260 {
  func province(of code: String) -> Division.LazyEvaluation {
    return {
      return code.isProvince ? nil : self[code.provinceCode]
    }
  }

  func prefecture(of code: String) -> Division.LazyEvaluation {
    return {
      return code.isPrefecture ? nil : self[code.prefectureCode]
    }
  }

  /// Returns the correspond division of `code` if database has one;
  /// returns `nil` otherwise.
  public func division(of code: String) -> Division? {
    guard let name = data[code] else { return nil }
    return Division(name: name,
                    code: code,
                    revision: revision.rawValue,
                    getProvince: province(of: code),
                    getPrefecture: prefecture(of: code))
  }

  /// Accesses the correspond division of `code` if database has one;
  /// returns `nil` otherwise.
  ///
  /// - SeeAlso: `division(of:)`.
  public subscript(code: String) -> Division? {
    return division(of: code)
  }

}
