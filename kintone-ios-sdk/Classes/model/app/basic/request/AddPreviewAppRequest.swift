// Copyright (c) 2018 Cybozu, Inc.

open class AddPreviewAppRequest: NSObject, Codable {
    private var name: String
    private var space: Int?
    private var thread: Int?
    
    open func getName() -> String {
        return self.name
    }
    open func setName(_ name: String) {
        self.name = name
    }
    open func getSpace() -> Int? {
        return self.space
    }
    open func setSpace(_ space: Int?) {
        self.space = space
    }
    open func getThread() -> Int? {
        return self.thread
    }
    open func setThread(_ thread: Int?) {
        self.thread = thread
    }
    
    public init(name: String, space: Int?, thread: Int?){
        self.name = name
        self.space = space
        self.thread = thread
    }
}
