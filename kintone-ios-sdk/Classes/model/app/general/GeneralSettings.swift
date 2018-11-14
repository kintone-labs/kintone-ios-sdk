// Copyright (c) 2018 Cybozu, Inc.

open class GeneralSettings: NSObject, Codable {
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
    
    open func getName() -> String? {
        return self.name
    }
    open func setName(_ name: String?) {
        self.name = name
    }
    open func getDescription() -> String? {
        return self.generalDescription
    }
    open func setDescription(_ description: String?) {
        self.generalDescription = description
    }
    open func getIcon() -> Icon? {
        return self.icon
    }
    open func setIcon(_ icon: Icon) {
        self.icon = icon
    }
    open func getTheme() -> IconTheme? {
        return self.theme
    }
    open func setTheme(_ theme: IconTheme?) {
        self.theme = theme
    }
}
