//
//  SqlDB.swift
//  SQLiteDemo
//
//  Created by IOS Training 2 on 20/07/22.

import Foundation
import SQLite3

class SqlDB {
    
    private let dbPath: String = UserConstant.dbpathConstant
    
    
    private var db: OpaquePointer?
    
    
    static let sharedInstance = SqlDB()
    
    private init() {
        db = openDatabase()
        createDetailsTable()
    }
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        
        print(fileURL, "This is the fileURL")
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        } else {
            print("error opening database")
            return nil
        }
    }
    
    func createDetailsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS details(Id INTEGER PRIMARY KEY, name TEXT, email TEXT, mobile INTEGER);"
    
        var createTableStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(name: String, email: String, mobile: Int64) {
        let insertStatementString = "INSERT INTO details (id, name, email, mobile) VALUES (NULL, ?, ?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_int64(insertStatement, 3, Int64(mobile))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Details] {
        let queryStatementString = "SELECT * FROM details;"
        var queryStatement: OpaquePointer? = nil
        
        var details: [Details] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW { //at last we will get SQLITE_DONE status code
                
                let id = sqlite3_column_int(queryStatement, 0)
                
                let nameFromDB = sqlite3_column_text(queryStatement, 1)!
                let name = String(cString: nameFromDB)
                
                let email = String(cString: sqlite3_column_text(queryStatement, 2)!)
                
                let mobile = sqlite3_column_int64(queryStatement, 3)
                
                details.append(Details(id:Int(id), name: name, email: email, mobile: mobile ))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return details
    }
    
    func update(name:String, mobile:Int64, id: Int) {
        let updateStatementStirng = "UPDATE details set name = '\(name)', mobile = '\(mobile)' WHERE id = '\(id)';"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(updateStatement, 1, Int32(id))
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
               
            } else {
                print("Could not updated row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        
       
        sqlite3_finalize(updateStatement)
    }
    
    func deleteByID(id: Int) {
        let deleteStatementString = "DELETE FROM details WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        
        //release resources to avoid memory leak
        sqlite3_finalize(deleteStatement)
    }
}
