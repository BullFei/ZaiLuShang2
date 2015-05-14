//
//  Header.h
//  Caixin
//
//  Created by gaocaixin on 15/4/24.
//  Copyright (c) 2015年 CX. All rights reserved.
// $(SRCROOT)/ZaiLuShang/Header.h

#pragma mark - 注意--------
/**
 只写自己的模块 修改自己模块以外的东西要先同步一下 修改完立即再同步
 
 提交时要在github解决所有文件里的冲突 改不了的不用更改
 
 类创建 用名字首字母缩写+项目名 防止冲突
 不要修改任何工程设置
 xib先按照 Iphone5 配置
 */

/**
 项目规定宏
 */
// cell到边界的距离
#define INTERVAL_CELL_BORDER 8
// cell到cell的距离
#define INTERVAL_CELL_CELL 6
// cell内部view到cell边界的距离
#define INTERVAL_VIEW_CELL 8
// CELL比例
#define HUANGJINGSHU 0.718



#define BIG_HEAD "ava/"      //  头像图
#define SMALL_HEAD "ava102/" //  小头像图
#define SMALL_IMAGE "b300/"  //  缩略图
#define BIG_IMAGE "f1400/"   //  大图
/**
 基本宏定义
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFImageView.h"
#import "TextSizeTools.h"

// 判读是否是ios7
#define iOS7   ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 自定义log
#ifdef DEBUG
#define CXLog(...) NSLog(__VA_ARGS__)
#else
#define CXLog(...)
#endif
// 属性简写
#define CGW(view)               view.bounds.size.width
#define CGH(view)               view.bounds.size.height
#define CGX(rect)               rect.origin.x
#define CGY(rect)               rect.origin.y
// 屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 导航栏高度
#define HEIGHT_NAV              44
// 状态栏高度
#define HEIGHT_STA              20
// tabbar栏高度
#define HEIGHT_TOOLBAR          49

// RGB颜色
#define CXColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define CXColorP(r,g,b,p) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:p/1]

//字体
#define TextFont_17 [UIFont systemFontOfSize:17]
#define TextFont_15 [UIFont systemFontOfSize:15]



