//
//  WODDatabase.m
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODDatabase.h"
#import <UIKit/UIKit.h>
#import "WODPlist.h"

NSString * const kWODDataFileContentDidChangeNotification = @"WODDataFileContentDidChangeNotification";
NSString * const kWODTitleUserInfoKey = @"WODTitleUserInfoKey";

@interface WODDatabase ()

@property (nonatomic, strong) WODPlist *wodPlist;
@property (nonatomic, weak) id<WODDataModelDelegate> delegate;

@end

@implementation WODDatabase
- (instancetype)initWithDelegate:(id<WODDataModelDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
#warning  явное дублирование кода в двух инитах. Отличаются ни только строкой self.delegate = delegate; Потому правильно было бы в initWithDelegate: вызвать self = [self init], и оставить в initWithDelegate: только одну строку с присваиванием делегата
        self.wodPlist = [WODPlist new];
        self.itemArray = [NSMutableArray arrayWithArray:[self dataFromPlist]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myTitleDidChanged:)
                                                     name:kWODDataFileContentDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.wodPlist = [WODPlist new];
        self.itemArray = [NSMutableArray arrayWithArray:[self dataFromPlist]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myTitleDidChanged:)
                                                     name:kWODDataFileContentDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (WODModel *)modelAtIndex:(NSInteger)index{
    return [self.itemArray objectAtIndex:index];
}

- (NSArray *)dataFromPlist {
    NSArray *namesValueArray =  [self.wodPlist readValueForKey:@"names"];
    NSArray *imagesValueArray = [self.wodPlist readValueForKey:@"images"];
    NSMutableArray *wModel = [NSMutableArray new];
    
    for (int a = 0; a < namesValueArray.count; a++) {
#warning после alloc] нужен пробел
        [wModel addObject:[[WODModel alloc]initWithString:[imagesValueArray objectAtIndex:a] imageSignature:[namesValueArray objectAtIndex:a]]];
    }
    return wModel;
}

#warning плохое имя для обработчика события по изменения данных
- (void)myTitleDidChanged:(NSNotification *)notification {
    [self.delegate dataWasChanged:self array:[self dataFromPlist]];
}

- (void)saveModelToPlist:(WODModel *)model {
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc]initWithContentsOfFile:self.wodPlist.plistFile];
    NSMutableArray *imgArray = [savedStock valueForKey:@"images"];
    NSMutableArray *titleArray = [savedStock valueForKey:@"names"];
    
    [titleArray addObject:model.picturesSignature];
    [imgArray addObject:[NSString stringWithFormat:@"Пустая картинка.jpeg"]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:imgArray, @"images",
                                                                    titleArray, @"names", nil];
    [dict writeToFile:self.wodPlist.plistFile atomically: YES];
    self.tempStringForNotification = model.picturesSignature;
    
}

-(void)setTempStringForNotification:(NSString *)tempStringForNotification {
    _tempStringForNotification = tempStringForNotification;
    NSNotificationCenter *notificetionCentr = [NSNotificationCenter defaultCenter];
#warning этот словарь Вам в принципе не нужен, никакой полезной информации в нем нет
#warning собственно, свойство tempStringForNotification также не нужно, просто после сохранения модели швыряйте нотификейшн
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"modelDidChanged" forKey:kWODTitleUserInfoKey];
    [notificetionCentr postNotificationName:kWODDataFileContentDidChangeNotification
                      object:nil
                    userInfo:dict];
}

#warning dealloc лучше размещать после инитов
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
