//
//  GetGeneralSettings.swift
//  kintone-ios-sdk
//

public class GetGeneralSettingsRequest: NSObject, Codable {
    private var app: Int?
    private var lang: LanguageSetting?
    private var isPreview: Bool?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int?) {
        self.app = app
    }
    public func getLang() -> LanguageSetting? {
        return self.lang
    }
    public func setLang(_ lang: LanguageSetting?) {
        self.lang = lang
    }
    public func getIsPreview() -> Bool? {
        return self.isPreview
    }
    public func setIsPreview(_ isPreview: Bool?) {
        self.isPreview = isPreview
    }
    
    init(_ app: Int?, lang: LanguageSetting? = nil, isPreview: Bool? = nil) {
        self.app = app
        self.lang = lang
        self.isPreview = isPreview
    }
}
