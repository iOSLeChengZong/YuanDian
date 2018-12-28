//
//  RequestPath.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

//这个类是用来存储请求路径的
#ifndef RequestPath_h
#define RequestPath_h

// http://192.168.101.31:8090 -> http://94.191.42.70

//基类URL
#define kBaseURL @"http://94.191.42.70:8090"
#define kBaseURLTaoBao @"https://acs.m.taobao.com"

//第一次连调数据
#define kFirstTestURL @"/goods/selectGoodsList"


/** 首页 */
//首页头部数据
#define kHomeHederDataURL @"/index/getData"

//首页商品  参数: pageNo 请求的页数  pageSize 每页多少个   state=1 人气推荐   state=2 热销爆款
#define kHomeGoodListDataURL @"/index/selectGoodsList?pageNo=1&pageSize=20&state=1"

//分类  //请求右边的列表使用参数 parentId
#define kCategoryModelURL @"/app/goods/selectGoodsClass"





#endif /* RequestPath_h */
