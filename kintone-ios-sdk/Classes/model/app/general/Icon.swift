//
//  Icon.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class Icon: NSObject, Codable {
    private var file: IconFile?
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
    
    public func getFile() -> IconFile? {
        return self.file
    }
    public func setFile(_ file: IconFile) {
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
    
    public init(_ file: IconFile, _ key: String, _ iconType: IconType) {
        self.file = file
        self.key = key
        self.iconType = iconType
    }
}
