//
//  ViewController.m
//  DemoApplication
//
//  Created by Su Pro on 1/25/18.
//  Copyright © 2018 NiNS. All rights reserved.
//
#import "define.h"
#import "ViewController.h"
#import "SelectedPopUp.h"
#import "sqlite3.h"
#import "BookModel.h"
#import "AddBookViewController.h"

@interface ViewController ()<ClickDelegate> {
    SelectedPopUp *mPopUp;
    sqlite3 *bookDB;
    NSString *databasePath;
    int currentRow;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self openDB];
//    [self saveData];
//    [self getAllData];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)OnAddClick :(id) sender{
    NSLog(@"Create");
    AddBookViewController* vc = [[AddBookViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void) initView {
    // Add Button
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(30,20, 80, 40 )];
    UIColor *btnColor = [UIColor colorWithRed:0.72 green:0.69 blue:0.67 alpha:1.0];
    [addBtn setTitle:@"追加" forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [addBtn addTarget:self action:@selector(OnAddClick:) forControlEvents:UIControlEventTouchDown];
    addBtn.backgroundColor = btnColor;
    [self.view addSubview:addBtn];
    
    UILabel *lbIndex = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 75, 20)];
    lbIndex.textAlignment = UITextAlignmentLeft;
    lbIndex.text = @"ID";
    [self.view addSubview:lbIndex];
    
    // this adds the label inside cell
    UILabel *lbItemName = [[UILabel alloc]initWithFrame:CGRectMake(75, 80, (SCREEN_WIDTH - 150) /2, 20 )];
    lbItemName.text = @"書籍名";
    lbItemName.textAlignment = UITextAlignmentLeft;
    //    lbItemName.textColor = btnCatalogyUnclicked;
    [self.view addSubview:lbItemName];
    
    // this adds the label inside cell
    UILabel *lbArtist = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150) /2 + 75 , 80, (SCREEN_WIDTH - 70) /2, 20 )];
    lbArtist.text = @"出版社名";
    lbArtist.textAlignment = UITextAlignmentLeft;
    //    lbItemName.textColor = btnCatalogyUnclicked;
    [self.view addSubview:lbArtist];
    
    // this adds the label inside cell
    UILabel *lbQuality = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 75, 80, 75, 20 )];
    lbQuality.text = @"ページ数";
    lbQuality.textAlignment = UITextAlignmentLeft;
    //    lbItemName.textColor = btnCatalogyUnclicked;
    [self.view addSubview:lbQuality];
    
    
    
    //init collection view
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH , SCREEN_HEIGHT - 20 ) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView setShowsHorizontalScrollIndicator:false];
    [_collectionView setShowsVerticalScrollIndicator:false];
    [self.view addSubview:_collectionView];
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [dataList count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Debug#collectionView#cellForItemAtIndexPath#Row: %ld", (long)indexPath.row);
    UICollectionViewCell *cell=(UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath] ;
    
    //clear old data
    for (id subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        } else if ([subview isKindOfClass:[UILabel class]]) {
            [subview removeFromSuperview];
        }
    };
    
    BookModel *item = dataList[indexPath.row ];
    
    float cellHeight = cell.bounds.size.height;
    float cellWidth = cell.bounds.size.width;
    float heigh = cellHeight;
//    NSString *index  = (indexPath.row == 0 ) ? @"Index" : [NSString stringWithFormat:@"%d",item.bookIndex];
//    NSString *name  = (indexPath.row == 0 ) ? @"書籍名" : item.name;
//    NSString *publisher  = (indexPath.row == 0 ) ? @"出版社名" : item.publisher;
//    NSString *page  = (indexPath.row == 0 ) ? @"ページ数名" : item.page;
        UILabel *lbIndex = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, heigh)];
        lbIndex.text = [NSString stringWithFormat:@"%d",item.bookIndex];
        lbIndex.textAlignment = UITextAlignmentLeft;
        //    lbItemName.textColor = btnCatalogyUnclicked;
        [cell.contentView addSubview:lbIndex];
        
        // this adds the label inside cell
        UILabel *lbItemName = [[UILabel alloc]initWithFrame:CGRectMake(75, 0, (cellWidth - 150) /2, heigh )];
        lbItemName.text = item.name;
        lbItemName.textAlignment = UITextAlignmentLeft;
        //    lbItemName.textColor = btnCatalogyUnclicked;
        [cell.contentView addSubview:lbItemName];
        
        // this adds the label inside cell
        UILabel *lbArtist = [[UILabel alloc]initWithFrame:CGRectMake((cellWidth - 150) /2 + 75 , 0, (cellWidth - 70) /2, heigh )];
        lbArtist.text = item.publisher;
        lbArtist.textAlignment = UITextAlignmentLeft;
        //    lbItemName.textColor = btnCatalogyUnclicked;
        [cell.contentView addSubview:lbArtist];
        
        // this adds the label inside cell
        UILabel *lbQuality = [[UILabel alloc]initWithFrame:CGRectMake(cellWidth - 75, 0, 75, heigh )];
        lbQuality.text = item.page;
        lbQuality.textAlignment = UITextAlignmentLeft;
        //    lbItemName.textColor = btnCatalogyUnclicked;
        [cell.contentView addSubview:lbQuality];
    
    UILabel *lbLine = [[UILabel alloc]initWithFrame:CGRectMake(0, cellHeight-2, cellWidth, 2)];
    lbLine.backgroundColor = [UIColor grayColor];
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float heigh = (indexPath.row == 0 ) ? 20 : SCREEN_HEIGHT/6;
    return CGSizeMake(SCREEN_WIDTH, heigh);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Debug#collectionView#didSelectItemAtIndexPath#Row: %ld", (long)indexPath.row);
    BookModel *item = dataList[indexPath.row];
    currentRow  = item.bookIndex;
    mPopUp = [SelectedPopUp new];
    [mPopUp initAlertwithParent:self withDelegate:self];
    [mPopUp show];

}

-(void) okClicked{
    NSLog(@"Hide");
    [mPopUp hide];
//    self.view.backgroundColor = [UIColor clearColor];
}

-(void) OnDelete {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"このイテムを削除したいですか。"
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"はい"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
                                    [self deleteRow];
                                    [self getAllData];
                                    [_collectionView reloadData];
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"いいえ"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void) OnUpdate {
    NSLog(@"Update");
    AddBookViewController* vc = [[AddBookViewController alloc] init];
    vc.bookIndex  = currentRow;
    [self presentViewController:vc animated:YES completion:nil];
}
-(void) OnWriteFeeling {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"この関数はまだできません。"
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"はい"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
                                    
                                    
                                }];
    
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void) openDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"book.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &bookDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS BOOKS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, PUBLISHER TEXT, PAGE TEXT)";
            
            if (sqlite3_exec(bookDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            
            sqlite3_close(bookDB);
            
        } else {
            NSLog(@"Failed to create table");
        }
    }
    
}

-(void) getAllData {
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt  *statement;
    NSMutableArray *allRows = [[NSMutableArray alloc] init];

    
    if (sqlite3_open(dbpath, &bookDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM BOOKS";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(bookDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSString *index = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *publisher = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *page = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                BookModel *model = [[BookModel alloc] initWithData:[index intValue] name:name publisher:publisher page:page];
                [allRows addObject:model];
                
                
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(bookDB);
    }
    dataList = [allRows copy];
    NSLog(@"Data at index: %lu", (unsigned long)[dataList count]);
}

- (void) saveData {
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &bookDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO BOOKS (name, publisher, page) VALUES (\"%@\", \"%@\", \"%@\")", @"aaa", @"bbbb", @"ccc"];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(bookDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Contact added");
           
        } else {
            NSLog(@"Contact fail");
        }
        sqlite3_finalize(statement);
        sqlite3_close(bookDB);
    }
}

-(void) showRemindDialog {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"データがありません。新しい情報を追加したいですか。"
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"はい"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
                                    NSLog(@"Create");
                                    AddBookViewController* vc = [[AddBookViewController alloc] init];
                                    [self presentViewController:vc animated:YES completion:nil];

                                }];
                                
    UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"いいえ"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                                           {
                                                               
                                                               
                                                           }];
                                
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [self getAllData];
    if([dataList count] == 0) {
        [self showRemindDialog];
    } else {
        [_collectionView reloadData];
    }
}

-(void) deleteRow {
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &bookDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"DELETE FROM BOOKS WHERE ID = %d", (currentRow)];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(bookDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Delete complete");
            
        } else {
            NSLog(@"Delete fail");
        }
        sqlite3_finalize(statement);
        sqlite3_close(bookDB);
    }
}

@end
