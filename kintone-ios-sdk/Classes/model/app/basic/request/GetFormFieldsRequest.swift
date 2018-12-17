// Copyright (c) 2018 Cybozu, Inc.

open class GetFormFieldsRequest: NSObject, Codable {
    private var app: Int
    private var lang: LanguageSetting?
    
    open func getApp() -> Int {
        return self.app
    }
    open func setApp(app: Int) {
        self.app = app
    }
    open func getLang() -> LanguageSetting? {
        return self.lang
    }
    open func setLang(lang: LanguageSetting) {
        self.lang = lang
    }
    
    public init(_ app: Int, _ lang: LanguageSetting) {
        self.app = app
        self.lang = lang
    }
}
