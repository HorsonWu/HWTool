//
//  HorsonIPAddress.h
//  ihuikou
//
//  Created by Horson on 14/11/18.
//  Copyright (c) 2014年 Horson. All rights reserved.
//

#ifndef __ihuikou__HorsonIPAddress__
#define __ihuikou__HorsonIPAddress__

#include <stdio.h>

#define MAXADDRS    32
extern char *if_names[MAXADDRS];
extern char *ip_names[MAXADDRS];
extern char *hw_addrs[MAXADDRS];
extern unsigned long ip_addrs[MAXADDRS];

// Function prototypes

void horsonInitAddresses();
void horsonFreeAddresses();
void horsonGetIPAddresses();
void horsonGetHWAddresses();


#endif /* defined(__ihuikou__HorsonIPAddress__) */
