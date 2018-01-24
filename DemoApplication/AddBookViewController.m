//
//  AddBookViewController.m
//  DemoApplication
//
//  Created by Su Pro on 1/24/18.
//  Copyright © 2018 NiNS. All rights reserved.
//

#import "AddBookViewController.h"
#import "sqlite3.h"
#import "BookModel.h"

@interface AddBookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputName;
@property (weak, nonatomic) IBOutlet UITextField *inputPublisher;
@property (weak, nonatomic) IBOutlet UITextField *inputPage;


@end

@implementation AddBookViewController {
        NSString *databasePath;
        sqlite3 *bookDB;
}

- (IBAction)onSave:(id)sender {
    [self saveData];
}
- (IBAction)onBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_bookIndex >0) {
        NSLog(@"Get index");
        BookModel *item = [self getInfoByIndex:_bookIndex];
        NSLog(@"%@", item.publisher);
        _inputName.text = item.name;
        _inputPublisher.text = item.publisher;
        _inputPage.text = item.page;
    }
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissKeyboard
{
    [_inputName resignFirstResponder];
    [_inputPublisher resignFirstResponder];
    [_inputPage resignFirstResponder];
}

- (void) saveData {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"book.db"]];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &bookDB) == SQLITE_OK)
            {
                NSString *insertSQL;
                
                if(_bookIndex > 0) {
                    insertSQL = [NSString stringWithFormat: @"UPDATE BOOKS SET NAME =\"%@\", PUBLISHER = \"%@\", PAGE = \"%@\" WHERE ID= %d", _inputName.text, _inputPublisher.text, _inputPage.text, _bookIndex];
                } else {
                    insertSQL = [NSString stringWithFormat: @"INSERT INTO BOOKS (name, publisher, page) VALUES (\"%@\", \"%@\", \"%@\")", _inputName.text, _inputPublisher.text, _inputPage.text];
                }
                
        
                const char *insert_stmt = [insertSQL UTF8String];
        
                sqlite3_prepare_v2(bookDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"Contact added");
                        [self showSuccessDialog];
                    } else {
                        NSLog(@"Contact fail");
                    }
                sqlite3_finalize(statement);
                sqlite3_close(bookDB);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) showSuccessDialog {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"できました！"
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
//                                    [self presentViewController:alert animated:YES completion:nil];
                                }];
    
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BookModel *) getInfoByIndex:(int) index {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"book.db"]];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt  *statement;
    BookModel *model;
    
    if (sqlite3_open(dbpath, &bookDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM BOOKS WHERE ID=%d", index ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(bookDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSString *index = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *publisher = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *page = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                model = [[BookModel alloc] initWithData:[index intValue] name:name publisher:publisher page:page];
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(bookDB);
    }
    return model;
}

@end
