
#import <UIKit/UIKit.h>

typedef enum {
    XMGTopicTypeAll = 1,
    XMGTopicTypePicture = 10,
    XMGTopicTypeWord = 29,
    XMGTopicTypeVoice = 31,
    XMGTopicTypeVideo = 41
} XMGTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const XMGTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const XMGTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const XMGTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const XMGTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const XMGTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureBreakH;

/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const XMGUserSexMale;
UIKIT_EXTERN NSString * const XMGUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const XMGTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const XMGTabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const XMGSelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const XMGSelectedControllerKey;

/** 标签-间距 */
UIKIT_EXTERN CGFloat const XMGTagMargin;
/** 标签-高度 */
UIKIT_EXTERN CGFloat const XMGTagH;

