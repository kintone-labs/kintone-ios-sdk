# Change Log
## [v0.3.2](https://github.com/kintone/kintone-ios-sdk/tree/v0.3.2)
**Update podspec file**
- Add attribute deprecated to podspec file.

## [v0.3.0](https://github.com/kintone/kintone-ios-sdk/tree/v0.3.0)
**New features / functions**
- Added new functions for Record Module:
  - getAllRecordsByQuery
  - addAllRecords
  - deleteAllRecordsByQuery
  - updateAllRecords
  - upsertRecord
  - upsertRecords
- Added new Record Cursor module

**Updates / Bug fixes**
- Support Proxy login for function "setProxy"
- Refactor User Guide to a more easily readable format

## [v0.2.0](https://github.com/kintone/kintone-ios-sdk/tree/v0.2.0)
**Implemented enhancements:**
- Support Authentication and Basic Authentication when using certificate file

## [v0.1.0](https://github.com/kintone/kintone-ios-sdk/tree/v0.1.0) (2019-01-21)
**Implemented basic features:**
- Support Authentication and Basic Authentication by two way:
    - Password Authentication
    - API Token Authentication
- Support Application REST API
    - Support REST API to manage applications to kintone.
        * Gep App/ Add Preview App
        * Get App Deploy Status/ Deploy App Settings
        * Get/ Add/ Update/ Delete Form Fields
        * Get/ Update Form Layout
        * Get/ Update App Views
        * Get/ Update General Settings
- Support Record REST API
    - Support all REST API to Get/ Add/ Update/ Delete with records from a kintone application.
- Support File REST API
    - Support REST API to upload/ download file to kintone.
- Support Bulk Request REST API
    - Support REST API to send bulk request to kintone.
