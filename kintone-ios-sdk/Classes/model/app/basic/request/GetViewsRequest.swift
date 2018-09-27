//
//  GetViewsRequest.swift
//  kintone-ios-sdk
//

public class GetViewsRequest: NSObject, Codable {
    private var app: Int?
    private var lang: LanguageSetting?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    public func getLang() -> LanguageSetting? {
        return self.lang
    }
    public func setLang(_ lang: LanguageSetting) {
        self.lang = lang
    }
    
    public init(_ app: Int, _ lang: LanguageSetting) {
        self.app = app
        self.lang = lang
    }
}
