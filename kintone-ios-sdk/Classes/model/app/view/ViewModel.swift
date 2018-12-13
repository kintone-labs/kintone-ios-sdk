// Copyright (c) 2018 Cybozu, Inc.

open class ViewModel: NSObject, Codable {
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
    
    open func getBuiltinType() -> BuiltinType? {
        return self.builtinType
    }
    
    open func setBuiltinType(_ builtinType: BuiltinType?) {
        self.builtinType = builtinType
    }
    
    open func getDate() -> String? {
        return self.date
    }
    
    open func setDate(_ date: String?) {
        self.date = date
    }
    
    open func getFields() -> [String]? {
        return self.fields
    }
    
    open func setFields(_ fields: [String]?) {
        self.fields = fields
    }
    
    open func getFilterCond() -> String? {
        return self.filterCond
    }
    
    open func setFilterCond(_ filterCond: String?) {
        self.filterCond = filterCond
    }
    
    open func getHtml() -> String? {
        return self.html
    }
    
    open func setHtml(_ html: String?) {
        self.html = html
    }
    
    open func getId() -> Int? {
        return Int(self.id != nil ? self.id! : "")
    }
    
    open func setId(_ id: Int?) {
        self.id = id != nil ? "\(String(describing: id!))" : nil
    }
    
    open func getIndex() -> Int? {
        return Int(self.index != nil ? self.index! : "")
    }
    
    open func setIndex(_ index: Int?) {
        self.index = index != nil ? "\(String(describing: index!))" : nil
    }
    
    open func getName() -> String? {
        return self.name
    }
    
    open func setName(_ name: String?) {
        self.name = name
    }
    
    open func getPager() -> Bool? {
        return self.pager
    }
    
    open func setPager(_ pager: Bool?) {
        self.pager = pager
    }
    
    open func getSort() -> String? {
        return self.sort
    }
    
    open func setSort(_ sort: String?) {
        self.sort = sort
    }
    
    open func getTitle() -> String? {
        return self.title
    }
    
    open func setTitle(_ title: String?) {
        self.title = title
    }
    
    open func getType() -> ViewType? {
        return self.type
    }
    
    open func setType(_ type: ViewType?) {
        self.type = type
    }
}
