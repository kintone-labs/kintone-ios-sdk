//
//  AppTestConstants.swift
//  kintone-ios-sdkTests
//
//  Created by Pham Anh Quoc Phien on 11/23/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation
public class AppTestConstants {
    public static let COMMON_APP_ID = 88
    
    public static let GET_APPS_OFFSET = 5
    public static let GET_APPS_LIMMIT = 5
    
    public static let GET_APPS_BY_CODES_OFFSET = 0
    public static let GET_APPS_BY_CODES_LIMIT = 100
    public static let GET_APPS_BY_CODES_APP_CODES = ["QASD"]
    
    public static let GET_APPS_BY_IDs_APP_IDs = [88]
    public static let GET_APPS_BY_IDs_OFFSET = 0
    public static let GET_APPS_BY_IDs_LIMMIT = 100
    
    public static let GET_APPS_BY_NAME_OFFSET = 0
    public static let GET_APPS_BY_NAME_LIMMIT = 100
    public static let GET_APPS_BY_NAME_APP_NAME = "New App"
    
    public static let GET_APPS_BY_SPACE_IDS_OFFSET = 6
    public static let GET_APPS_BY_SPACE_IDS_LIMMIT = 1
    public static let GET_APPS_BY_SPACE_IDS_SPACE_IDS = [1]
    
    public static let ADD_PREVIEW_APP_APP_NAME = "xxxx"
    public static let ADD_PREVIEW_APP_SPACE_ID = 1
    public static let ADD_PREVIEW_APP_THREAD_ID = 1
    public static let ADD_PREVIEW_APP_REVISION = -1
    
    public static let DEPLOY_APP_SETTINGS_APP_ID = 1
    public static let DEPLOY_APP_SETTINGS_REVISION = -1
    
    public static let GET_APP_DEPLOY_STATUS_APP_IDS = [1, 2]
    public static let GET_APP_DEPLOY_STATUS_APP_STATUS = ["PROCESSING", "SUCCESS", "FAIL", "CANCEL"]
    
    public static let GET_FORM_FIELDS_APP_ID = 1
    
    public static let ADD_FORM_FIELDS_APP_ID = 1
    public static let ADD_FORM_FIELDS_REVISION = -1
    public static let ADD_FORM_FIELDS_FIELDCODE = "Radio_Text_Field"
    
    public static let UPDATE_FORM_FIELDS_APP_ID = 1
    public static let UPDATE_FORM_FIELDS_REVISION = -1
    public static let UPDATE_FORM_FIELDS_FIELDCODE = "Text"
    
    public static let DELETE_FORM_FIELDS_APP_ID = 1
    public static let DELETE_FORM_FIELDS_REVISION = -1
    public static let DELETE_FORM_FIELDS_FIELDCODE = "Delete_Text"
    
    public static let GET_FORM_LAYOUT_APP_ID = 1
    
    public static let UPDATE_FORM_LAYOUT_APP_ID = 1
    
    public static let GET_GENERAL_SETTINGS_APP_ID = 1
    
    public static let UPDATE_GENERAL_SETTINGS_APP_ID = 1
    
    public static let GET_VIEWS_APP_ID = 1
    
    public static let UPDATE_VIEWS_APP_ID = 1
}
