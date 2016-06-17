//
//  Revision.swift
//  GB2260
//
//  Created by Di Wu on 4/17/16.
//

/** 
 The revision of GB2206 dataset

 See: https://github.com/cn/GB2260
*/
public enum Revision: String {
  case V201410 = "201410"
  case V201308 = "201308"
  case V201210 = "201210"
  case V201110 = "201110"
  case V201010 = "201010"
  case V200912 = "200912"
  case V200812 = "200812"
  case V200712 = "200712"
  case V200612 = "200612"
  case V200512 = "200512"
  case V200506 = "200506"
  case V200412 = "200412"
  case V200409 = "200409"
  case V200403 = "200403"
  case V200312 = "200312"
  case V200306 = "200306"
  case V200212 = "200212"

  var path: String? {
    return NSBundle(forClass: GB2260.self).pathForResource(rawValue, ofType: "plist", inDirectory: "data")
  }
}
