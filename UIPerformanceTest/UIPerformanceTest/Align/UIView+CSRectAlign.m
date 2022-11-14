//
//  UIView+CSRectAlign.m
//  UIPerformanceTest
//
//  Created by Jared on 2022/11/11.
//

#import "UIView+CSRectAlign.h"

@implementation UIView (CSRectAlign)


struct PixelUnitNode {
    CGFloat currentUnit;
    struct PixelUnitNode *next;
    struct PixelUnitNode *previous;
};

static struct PixelUnitNode *head = NULL;
static struct PixelUnitNode *tail = NULL;

static void initPixelLinkIfNeeded(void) {
    if (head == NULL) {
        CGFloat unit = 1 / [UIScreen mainScreen].scale;
        head = malloc(sizeof(struct PixelUnitNode));
        head->currentUnit = 0;
        head->next = NULL;
        head->previous = NULL;

        struct PixelUnitNode *previousNode = head;
        for (int i = 0; i < [UIScreen mainScreen].scale; i ++) {
            struct PixelUnitNode *node = malloc(sizeof(struct PixelUnitNode));
            node->currentUnit = (i + 1) * unit;
            node->next = NULL;
            previousNode->next = node;
            node->previous = previousNode;
            previousNode = node;
        }
        
        tail = previousNode;
    }
}


CGFloat CGFloatCeilPixel(CGFloat floatValue) {
    initPixelLinkIfNeeded();

    NSInteger intValue = (NSInteger)floatValue;
    CGFloat decValue = floatValue - intValue;
    if (decValue > 0) {
        struct PixelUnitNode *tmpNode = head->next; // 跳过0
        while (tmpNode != NULL) {
            if (decValue < tmpNode->currentUnit) {
                decValue = tmpNode->currentUnit;
                return intValue + decValue;
            }
            tmpNode = tmpNode->next;
        }
    }
    
    return floatValue;
}

CGFloat CGFloatFloorPixel(CGFloat floatValue) {
    initPixelLinkIfNeeded();

    NSInteger intValue = (NSInteger)floatValue;
    CGFloat decValue = floatValue - intValue;
    if (decValue > 0) {
        struct PixelUnitNode *tmpNode = tail;
        while (tmpNode != NULL) {
            if (decValue > tmpNode->currentUnit) {
                decValue = tmpNode->currentUnit;
                return intValue + decValue;
            }
            tmpNode = tmpNode->previous;
        }
    }
    
    return floatValue;
}

CGRect CGRectAlignPixel(CGRect rect) {
    return CGRectMake(CGFloatFloorPixel(rect.origin.x),
                      CGFloatFloorPixel(rect.origin.y),
                      CGFloatCeilPixel(rect.size.width),
                      CGFloatCeilPixel(rect.size.height));
}

CGSize CGSizeCeilPixel(CGSize size) {
    return CGSizeMake(CGFloatCeilPixel(size.width),
                      CGFloatCeilPixel(size.height));
}

CGPoint CGPointFloorPixel(CGPoint origin) {
    return CGPointMake(CGFloatFloorPixel(origin.x),
                       CGFloatFloorPixel(origin.y));
}

- (void)alignFrame {
    self.frame = CGRectAlignPixel(self.frame);
}

- (void)alignSize {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            CGFloatCeilPixel(self.frame.size.width),
                            CGFloatCeilPixel(self.frame.size.height));
}

- (void)alignOrigin {
    self.frame = CGRectMake(CGFloatFloorPixel(self.frame.origin.x),
                            CGFloatFloorPixel(self.frame.origin.y),
                            self.frame.size.width,
                            self.frame.size.height);
}

@end
