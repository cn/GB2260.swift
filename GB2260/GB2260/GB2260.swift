//
//  GB2260.swift
//  GB2260
//
//  Created by Di Wu on 4/17/16.
//

/// An implementation for looking up Chinese administrative divisions(GB/T 2260 codes).
public class GB2260 {
  /// The revision of this GB2260 dataset.
  public let revision: Revision

  private let data: [String: String]

  /**
   Create an instance of given revision GB2260 dataset.

   - parameter revision: The specific revision

   - returns: The created GB2260 dataset, it returns `nil` when the specific revision dataset is failed to load
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

extension GB2260 {
  func isProvince(code: String) -> Bool {
    return code.hasSuffix("0000")
  }

  func isPrefecture(code: String) -> Bool {
    return code.hasSuffix("00")
  }

  func provinceCode(code: String) -> String {
    return code.substringToIndex(code.startIndex.advancedBy(2)) + "0000"
  }

  func prefectureCode(code: String) -> String {
    return code.substringToIndex(code.startIndex.advancedBy(4)) + "00"
  }
}

extension GB2260 {
  /**
   A read-only property.

   returns: the provinces for this revision in a list of `Division`
  */
  public var provinces: [Division] {
    return self.data.filter({ isProvince($0.0) }).flatMap { self[$0.0] }
  }

  /**
   Looking up for prefectures under a given province code.

   - parameter code: The province code for looking up

   - returns: A list of prefecture level cities in `Division`
  */
  public func prefecturesOf(code code: String) -> [Division] {
    guard let province = self[code] else {
      return []
    }
    return data.filter({
      isPrefecture($0.0) && self[$0.0]!.province == province
    }).flatMap { self[$0.0] }
  }

  /**
   Looking up for counties under a given prefecture code.

   - parameter code: The prefecture code for looking up

   - returns: A list of counties in `Division`
  */
  public func countiesOf(code code: String) -> [Division] {
    guard let prefecture = self[code] else { return [] }
    return data.filter({
      !isProvince($0.0) &&
      !isPrefecture($0.0) &&
      self[$0.0]!.prefecture == prefecture
    }).flatMap { self[$0.0] }
  }

}

extension GB2260 {
  func provinceFor(code code: String) -> Division.LazyEvaluation {
    return {
      if self.isProvince(code) {
        return nil
      } else {
        return self[self.provinceCode(code)]
      }
    }
  }

  func prefectureFor(code code: String) -> Division.LazyEvaluation {
    return {
      if self.isPrefecture(code) {
        return nil
      } else {
        return self[self.prefectureCode(code)]
      }
    }
  }

  public subscript(index: String) -> Division? {
    guard let name = data[index] else { return nil }
    return Division(name: name,
                    code: index,
                    revision: revision.rawValue,
                    getProvince: provinceFor(code: index),
                    getPrefecture: prefectureFor(code: index))
  }
  
}
