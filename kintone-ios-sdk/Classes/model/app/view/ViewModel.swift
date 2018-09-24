//
//  View.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class ViewModel: NSObject, Codable {
    private var builtinType: BuiltinType?
    private var date: String?
    private var fields: [String]?
    private var filterCond: String?
    private var html: String?
    private var id: String?
    private var index: String?
    private var name: String?
    private var pager: Bool?
    private var sort: String?
    private var title: String?
    private var type: ViewType?
    
    public enum ViewType: String, Codable {
        case LIST
        case CALENDAR
        case CUSTOM
    }
    
    public enum BuiltinType: String, Codable {
        case ASSIGNEE
    }
    
    public func getBuiltinType() -> BuiltinType? {
        return self.builtinType
    }
    
    public func setBuiltinType(_ builtinType: BuiltinType?) {
        self.builtinType = builtinType
    }
    
    public func getDate() -> String? {
        return self.date
    }
    
    public func setDate(_ date: String?) {
        self.date = date
    }
    
    public func getFields() -> [String]? {
        return self.fields
    }
    
    public func setFields(_ fields: [String]?) {
        self.fields = fields
    }
    
    public func getFilterCond() -> String? {
        return self.filterCond
    }
    
    public func setFilterCond(_ filterCond: String?) {
        self.filterCond = filterCond
    }
    
    public func getHtml() -> String? {
        return self.html
    }
    
    public func setHtml(_ html: String?) {
        self.html = html
    }
    
    public func getId() -> Int? {
        return Int(self.id!)
    }
    
    public func setId(_ id: Int?) {
        self.id = "\(String(describing: id))"
    }
    
    public func getIndex() -> Int? {
        return Int(self.index!)
    }
    
    public func setIndex(_ index: Int?) {
        self.index = "\(String(describing: index))"
    }
    
    public func getName() -> String? {
        return self.name
    }
    
    public func setName(_ name: String?) {
        self.name = name
    }
    
    public func getPager() -> Bool? {
        return self.pager
    }
    
    public func setPager(_ pager: Bool?) {
        self.pager = pager
    }
    
    public func getSort() -> String? {
        return self.sort
    }
    
    public func setSort(_ sort: String?) {
        self.sort = sort
    }
    
    public func getTitle() -> String? {
        return self.title
    }
    
    public func setTitle(_ title: String?) {
        self.title = title
    }
    
    public func getType() -> ViewType? {
        return self.type
    }
    
    public func setType(_ type: ViewType?) {
        self.type = type
    }
}
