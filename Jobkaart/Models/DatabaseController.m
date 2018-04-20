//
//  DatabaseController.m
//  Jobkaart
//
//  Created by Lodewijck Vogelzang on 28-12-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "DatabaseController.h"
#import <sqlite3.h>

NSString *const databaseName = @"JobCards.sql";

@implementation DatabaseController

+ (NSString *)getDatabasePath {
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:databaseName];
    
}

+ (void)checkAndCreateDatabase {
    
    NSString *databasePath = [DatabaseController getDatabasePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL databaseDoesExist = [fileManager fileExistsAtPath:databasePath];
    
    if (databaseDoesExist) {
        return;
    } else {
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    }
    
}

+ (JobCard *)getJobCard {
    
    sqlite3 *database;
    JobCard *jobCard = [[JobCard alloc] initWithId:1];
    
    NSString *databasePath = [DatabaseController getDatabasePath];
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *compiledStatement;
        
        const char *sqlStatement = "SELECT title, focus, frequency, whencol, lototo, department, installation, machine, part, time, sis, numberofjobs FROM jobcard WHERE id = 1;";
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                jobCard.title = ((char *)sqlite3_column_text(compiledStatement, 0)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] : @"";
                jobCard.focus = ((char *)sqlite3_column_text(compiledStatement, 1)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] : @"";
                jobCard.frequency = ((char *)sqlite3_column_text(compiledStatement, 2)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] : @"";
                jobCard.when = ((char *)sqlite3_column_text(compiledStatement, 3)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] : @"";
                jobCard.lototo = sqlite3_column_int(compiledStatement, 4);
                jobCard.department = ((char *)sqlite3_column_text(compiledStatement, 5)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] : @"";
                jobCard.installation = ((char *)sqlite3_column_text(compiledStatement, 6)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] : @"";
                jobCard.machine = ((char *)sqlite3_column_text(compiledStatement, 7)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] : @"";
                jobCard.part = ((char *)sqlite3_column_text(compiledStatement, 8)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] : @"";
                jobCard.time = ((char *)sqlite3_column_text(compiledStatement, 9)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] : @"";
                jobCard.sis = ((char *)sqlite3_column_text(compiledStatement, 10)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] : @"";
                jobCard.numberOfJobs = sqlite3_column_int(compiledStatement, 11);
            }
        } sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
    jobCard.jobs = [[NSMutableArray alloc] init];
    for (int i=0; i<jobCard.numberOfJobs; i++) {
        [jobCard.jobs addObject:[DatabaseController getJob:i+1 ForCard:1]];
    }
    
    return jobCard;
    
}

+ (Job *)getJob:(NSInteger)number ForCard:(NSInteger)id {
    
    sqlite3 *database;
    Job *job = [[Job alloc] init];
    
    NSString *databasePath = [DatabaseController getDatabasePath];
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *compiledStatement;
        
        const char *sqlStatement = (const char*)[[NSString stringWithFormat:@"SELECT what, with, basiccondition, action FROM job WHERE jobcardid = %ld AND jobnumber = %ld;", (long)id, (long)number] UTF8String];
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                job.jobCardid = id;
                job.id = number;
                job.what = ((char *)sqlite3_column_text(compiledStatement, 0)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] : @"";
                job.with = ((char *)sqlite3_column_text(compiledStatement, 1)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] : @"";
                job.basicCondition = ((char *)sqlite3_column_text(compiledStatement, 2)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] : @"";
                job.action = ((char *)sqlite3_column_text(compiledStatement, 3)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] : @"";
            }
        } sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
    return job;
    
}

+ (void)updateJobCard:(JobCard *)jobCard {
    
    sqlite3 *database;
    
    NSString *databasePath = [DatabaseController getDatabasePath];
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = (const char*)[[NSString stringWithFormat:@"UPDATE jobcard SET title = '%@', focus = '%@', frequency = '%@', whencol = '%@', lototo = '%d', department = '%@', installation = '%@', machine = '%@', part = '%@', time = '%@', sis = '%@', numberofjobs = '%ld' WHERE id = %ld;", jobCard.title, jobCard.focus, jobCard.frequency, jobCard.when, jobCard.lototo, jobCard.department, jobCard.installation, jobCard.machine, jobCard.part, jobCard.time, jobCard.sis, (long)jobCard.numberOfJobs, (long)jobCard.id] UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
    for (int i=0; i<jobCard.numberOfJobs; i++) {
        [DatabaseController updateJob:jobCard.jobs[i]];
    }
    
    for (NSInteger i=jobCard.numberOfJobs; i<3; i++) {
        [DatabaseController deleteJob:i+1 FromCard:jobCard.id];
    }
    
}

+ (void)updateJob:(Job *)job {
    
    sqlite3 *database;
    
    NSString *databasePath = [DatabaseController getDatabasePath];
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = (const char*)[[NSString stringWithFormat:@"UPDATE job SET what = '%@', with = '%@', basiccondition = '%@', action = '%@' WHERE jobcardid = '%ld' AND jobnumber = '%ld';", job.what, job.with, job.basicCondition, job.action, (long)job.jobCardid, (long)job.id] UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
}

+ (void)deleteJob:(NSInteger)id FromCard:(NSInteger)cardId {
    
    sqlite3 *database;
    
    NSString *databasePath = [DatabaseController getDatabasePath];
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = (const char*)[[NSString stringWithFormat:@"UPDATE job SET what = '', with = '', basiccondition = '', action = '' WHERE jobcardid = '%ld' AND jobnumber = '%ld';", (long)cardId, (long)id] UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
}

@end

