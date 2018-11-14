// Copyright (c) 2018 Cybozu, Inc.

open class UpdateGeneralSettingsRequest: GeneralSettings {
    private var app: String?
    private var revision: String?
    
    private enum CodingKeys: String, CodingKey {
        case app
        case revision
    }
    
    open func getApp() -> Int? {
        return Int(self.app!)
    }
    open func setApp(_ app: Int?) {
        self.app = "\(String(describing: app!))"
    }
    open func getRevision() -> Int? {
        return Int(self.revision!)
    }
    open func setRevision(_ revision: Int?) {
        if(revision != nil) {
            self.revision = "\(String(describing: revision!))"
        }
    }
    
    public init(_ generalSettings: GeneralSettings?) {
        super.init()
        self.setName(generalSettings!.getName())
        self.setDescription(generalSettings!.getDescription())
        self.setIcon(generalSettings!.getIcon()!)
        self.setTheme(generalSettings!.getTheme())
    }
    
    public init(_ app: Int?, _ revision: Int? = nil) {
        super.init()
        self.setApp(app)
        self.setRevision(revision)
    }
    
    required public init(from decoder: Decoder) throws {
        super.init()
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(app, forKey: .app)
        if(self.revision != nil){
            try container.encode(revision, forKey: .revision)
        }
        try super.encode(to: encoder)
    }
}
