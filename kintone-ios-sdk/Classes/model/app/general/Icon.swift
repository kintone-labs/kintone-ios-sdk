// Copyright (c) 2018 Cybozu, Inc.

public class Icon: NSObject, Codable {
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
    
    public func getFile() -> FileModel? {
        return self.file
    }
    public func setFile(_ file: FileModel) {
        self.file = file
    }
    public func getKey() -> String? {
        return self.key
    }
    public func setKey(_ key: String) {
        self.key = key
    }
    public func getIconType() -> IconType? {
        return self.iconType
    }
    public func setIconType(_ iconType: IconType) {
        self.iconType = iconType
    }
    
    public init(_ key: String, _ iconType: IconType, _ file: FileModel? = nil) {
        self.file = file
        self.key = key
        self.iconType = iconType
    }
}
