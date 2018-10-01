// Copyright (c) 2018 Cybozu, Inc.

public class GeneralSettings: NSObject, Codable {
    private var name: String?
    private var generalDescription: String?
    private var icon: Icon?
    private var theme: IconTheme?
    
    public enum IconTheme: String, Codable {
        case WHITE
        case RED
        case BLUE
        case GREEN
        case YELLOW
        case BLACK
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case name
        case generalDescription = "description"
        case icon
        case theme
    }
    
    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String?) {
        self.name = name
    }
    public func getDescription() -> String? {
        return self.generalDescription
    }
    public func setDescription(_ description: String?) {
        self.generalDescription = description
    }
    public func getIcon() -> Icon? {
        return self.icon
    }
    public func setIcon(_ icon: Icon) {
        self.icon = icon
    }
    public func getTheme() -> IconTheme? {
        return self.theme
    }
    public func setTheme(_ theme: IconTheme?) {
        self.theme = theme
    }
}
