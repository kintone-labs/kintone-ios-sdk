// Copyright (c) 2018 Cybozu, Inc.

open class Icon: NSObject, Codable {
    private var file: FileModel?
    private var key: String?
    private var iconType: IconType?
    
    public enum IconType: String, Codable {
        case FILE
        case PRESET
    }
    
    enum CodingKeys: String, CodingKey
    {
        case file
        case key
        case iconType = "type"
    }
    
    open func getFile() -> FileModel? {
        return self.file
    }
    open func setFile(_ file: FileModel) {
        self.file = file
    }
    open func getKey() -> String? {
        return self.key
    }
    open func setKey(_ key: String) {
        self.key = key
    }
    open func getIconType() -> IconType? {
        return self.iconType
    }
    open func setIconType(_ iconType: IconType) {
        self.iconType = iconType
    }

    public init(_ key: String, _ iconType: IconType, _ file: FileModel? = nil) {
        self.file = file
        self.key = key
        self.iconType = iconType
    }
}
