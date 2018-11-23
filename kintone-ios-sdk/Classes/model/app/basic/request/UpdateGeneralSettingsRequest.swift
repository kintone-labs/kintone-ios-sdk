// Copyright (c) 2018 Cybozu, Inc.

open class UpdateGeneralSettingsRequest: GeneralSettings {
    private var app: String?
    
    private enum CodingKeys: String, CodingKey {
        case app
    }
    
    open func getApp() -> Int? {
        return Int(self.app!)
    }
    open func setApp(_ app: Int?) {
        self.app = "\(String(describing: app!))"
    }
    
    public init(_ generalSettings: GeneralSettings?) {
        super.init()
        self.setName(generalSettings!.getName())
        self.setDescription(generalSettings!.getDescription())
        self.setIcon(generalSettings!.getIcon()!)
        self.setTheme(generalSettings!.getTheme())
        self.setRevision(generalSettings!.getRevision())
    }
    
    public init(_ app: Int?) {
        super.init()
        self.setApp(app)
    }
    
    required public init(from decoder: Decoder) throws {
        super.init()
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(app, forKey: .app)
        try super.encode(to: encoder)
    }
}
