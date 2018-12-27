// Copyright (c) 2018 Cybozu, Inc.

open class GetGeneralSettingsRequest: NSObject, Codable {
    private var app: Int
    private var lang: LanguageSetting?
    private var isPreview: Bool?
    
    open func getApp() -> Int {
        return self.app
    }
    open func setApp(_ app: Int) {
        self.app = app
    }
    open func getLang() -> LanguageSetting? {
        return self.lang
    }
    open func setLang(_ lang: LanguageSetting?) {
        self.lang = lang
    }
    open func getIsPreview() -> Bool? {
        return self.isPreview
    }
    open func setIsPreview(_ isPreview: Bool?) {
        self.isPreview = isPreview
    }
    
    init(_ app: Int, _ lang: LanguageSetting? = nil, _ isPreview: Bool? = nil) {
        self.app = app
        self.lang = lang
        self.isPreview = isPreview
    }
}
