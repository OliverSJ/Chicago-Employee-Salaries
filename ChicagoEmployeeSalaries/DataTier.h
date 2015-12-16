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

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

-(instancetype)initWithDatabaseFilename:(NSString*)dbFilename;
-(void)copyDatabaseIntoDocumentsDirectory;
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end