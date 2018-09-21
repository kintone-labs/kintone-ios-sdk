//
//  GeneralSettings.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class GeneralSettings: NSObject {
    private var name: String?
    private var generalDescription: String?
    private var icon: Icon?
    private var theme: IconTheme?
    
    public enum IconTheme: String {
        case WHITE
        case RED
        case BLUE
        case GREEN
        case YELLOW
        case BLACK
    }
    
    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String) {
        self.name = name
    }
    public func getDescription() -> String? {
        return self.generalDescription
    }
    public func setDescription(_ description: String) {
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
    public func setTheme(_ theme: IconTheme) {
        self.theme = theme
    }
    
    public init(_ name: String, _ description: String, _ icon: Icon, _ theme: IconTheme) {
        self.name = name
        self.generalDescription = description
        self.icon = icon
        self.theme = theme
    }
}
