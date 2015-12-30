//
//  DataTier.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataTier : NSObject

/** The document directory of the current device */
@property (nonatomic, strong) NSString *documentsDirectory;
/** Database filename (i.e. thisIsADB.sql) */
@property (nonatomic, strong) NSString *databaseFilename;
/** Old database filenames */
@property (nonatomic, strong) NSArray *oldDatabaseFilenames;
/** Contains results of given query */
@property (nonatomic, strong) NSMutableArray *arrResults;
/** Column names */
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
/** Number of row affested by query */
@property (nonatomic) int affectedRows;
/** Last RowID inserted from query */
@property (nonatomic) long long lastInsertedRowID;

/** Init with database filename */
-(instancetype)initWithDatabaseFilename:(NSString*)dbFilename;
/** Copies database file into the apps Document Directory */
-(void)copyDatabaseIntoDocumentsDirectory;
/** Executes a given query (i.e. Select, Insert, Delete, Update, etc.) */
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;
/** Wrapper method to execute a select query */
-(NSArray *)loadDataFromDB:(NSString *)query;
/** Wrapper method to execute a query that affects the database state */
-(void)executeQuery:(NSString *)query;

@end