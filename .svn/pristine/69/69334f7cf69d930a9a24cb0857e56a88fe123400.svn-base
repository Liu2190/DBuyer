//
//  KQPayPluginDelegate.h
//  KQPayPlugin
//
//  Created by Hunter Li on 13-4-12.
//
//

#import <Foundation/Foundation.h>
typedef enum {
    KQ_PayFaild = 0,
    KQ_PaySucceed
}KQ_PayResult;

@protocol KQPayPluginDelegate <NSObject>

@required
- (void)payResult:(KQ_PayResult)result selfController:(UINavigationController*)controller;

@optional
- (void)bindCardList:(NSMutableArray *)CardList;
- (void)supportBank:(NSMutableDictionary *)suppertBankInfo  supperDebitBank:(NSMutableDictionary *)supperDebitBankInfo;
@end
