//
//  StringExtensions.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation


extension String {
  
  public func replaceFirst(of pattern:String, with replacement:String) -> String {
      if let range = self.range(of: pattern){
      return self.replacingCharacters(in: range, with: replacement)
    }else {return self}
  }
    
    public func replaceLast(of pattern:String, with replacement:String) -> String {
        if let range = self.range(of: pattern, options: .backwards){
        return self.replacingCharacters(in: range, with: replacement)
      }else {return self}
    }
    
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }
    
    
  
  public func replaceAll(of pattern:String,
                         with replacement:String,
                         options: NSRegularExpression.Options = []) -> String{
    do{
      let regex = try NSRegularExpression(pattern: pattern, options: [])
      let range = NSRange(0..<self.utf16.count)
      return regex.stringByReplacingMatches(in: self, options: [],
                                            range: range, withTemplate: replacement)
    }catch{
      NSLog("replaceAll error: \(error)")
      return self
    }
  }
  
}
