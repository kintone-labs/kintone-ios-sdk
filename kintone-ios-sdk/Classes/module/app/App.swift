//
//  App.swift
//  kintone-ios-sdk
//

public class App: NSObject {
    var connection: Connection?
    var parser = AppParser()
    
    public init(_ connection: Connection?) {
        self.connection = connection;
    }
}

extension App: AppApp {}
extension App: AppCustomization {}
extension App: AppForm {}
extension App: AppGeneral {}
extension App: AppPermission {}
extension App: AppProcessManagement {}
extension App: AppView {}
