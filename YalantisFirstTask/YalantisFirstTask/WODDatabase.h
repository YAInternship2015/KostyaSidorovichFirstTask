//
//  WODDatabase.h
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WODDatabase : NSObject

#warning Показывать наружу (в *.h файле) два массива, еще и не readonly - плохая идя. Так любой может их занилить извне. В требованиях к заданию я писал, что нужно создать класс-модель, которая бы хранила в себе картинку и текст. Тогда в этом классе-датасорсе внутри (в *.m) был бы один массив моделей вместо двух. Также, в *.h файле необходимо показать минимальный интерфейс, который нужен вью контроллеру для работы, то есть нуен метод, который бы возвращал общее количество моделей, и метод, который бы возвращал модель по индексу (для ячейки). И все, массив же показывать не стоит 
@property (nonatomic, retain) NSArray *myPicture;
@property (nonatomic, retain) NSArray *pictureName;


@end
