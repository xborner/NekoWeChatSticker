// * ******************************************************************************
// * Author: xborner
// * Email: xbornerw@gmail.com
// * Last modified: 2021-10-31 01:54
// * Filename: add_WeChat_stickers.Q
// * Version: 1.0.4
// * Description: 批量添加微信表情包
// 环境：微信测试版 3.0.0.22，按系统比例缩放，比例设置为 125%
// 快捷键 Ctrl + Enter 发送消息，将微信窗口设置拉伸到最小
// 基本思路：
// 1. 将表情包命名为 1.gif、2.gif...；
// 2. 点击文件按文件名搜索对应表情包；
// 3. 发送表情--右键表情--点击添加到表情--再次右键表情--点击删除消息--确认
// 4. 重复上述操作
// * *****************************************************************************

// * ****************************设置部分参数****************************
// 表情包的数量
sticker_quantity = 10
// 下面是一些窗口的相对坐标，如果比例有差异需要做相应调整。如比例是 100% 则将值除以 1.25
// 聊天窗口的文件图标
chat_file_x = 472
chat_file_y = 492
// 右键表情
right_click_sticker_x = 725
right_click_sticker_y = 135
// 删除消息后的弹窗，确认是否删除
confirm_deletion_x = 275
confirm_deletion_y = 244
// 获取微信窗口句柄
Hwnd = Plugin.Window.Find("WeChatMainWndForPC", "微信测试版")    

// * *****************************************************************************

// * ****************************主程序******************************************
Call Plugin.Window.Active(Hwnd)

n = 0
suffix = ".gif"
For sticker_quantity
    n = n + 1
    sticker_name = CStr(n) & suffix
    Call click_file()
    Call confirm_sticker(sticker_name)
    Call get_sticker()
Next
// * *****************************************************************************


Sub get_sticker()
    // 流程：发送表情--右键表情--点击添加到表情--再次右键表情--点击删除消息--确认
    // 快捷键发送表情
    KeyDown 17, 1
    KeyPress 13, 1
    KeyUp 17, 1
    // 网络不好可能卡主，那就把时间设置长一点
    Delay 1000

    // 右键表情
    Call Plugin.Bkgnd.MoveTo(Hwnd, right_click_sticker_x, right_click_sticker_y)
    Delay 100
    Call Plugin.Bkgnd.RightClick(Hwnd, right_click_sticker_x, right_click_sticker_y)
    Delay 80

    // 点击添加表情，鼠标点不太准确，改用键盘控制
    //click_save_sticker = Plugin.Window.Find("CMenuWnd", 0)  
    //Call Plugin.Bkgnd.MoveTo(click_save_sticker, 61, 104)
    //Delay 100
    //Call Plugin.Bkgnd.LeftClick(click_save_sticker, 61, 104)
    //Delay 800
    KeyPress "Down", 4
    Delay 80
    KeyPress "Enter", 1
    Delay 80

    // 右键表情
    Call Plugin.Bkgnd.MoveTo(Hwnd, right_click_sticker_x, right_click_sticker_y)
    Delay 100
    Call Plugin.Bkgnd.RightClick(Hwnd, right_click_sticker_x, right_click_sticker_y)
    Delay 200

    // 点击删除
    //click_delete_sticker = Plugin.Window.Find("CMenuWnd", 0)  
    //Call Plugin.Bkgnd.MoveTo(click_delete_sticker, 44, 145)
    //Delay 100
    //Call Plugin.Bkgnd.LeftClick(click_delete_sticker, 44, 145)
    //Delay 500
    // 用键盘按下删除消息
    KeyPress "Up", 2
    Delay 80
    KeyPress "Enter", 1
    Delay 80

    // 点击确认删除
    confirm_delete = Plugin.Window.Find("ConfirmDialog", "微信")  
    Call Plugin.Bkgnd.MoveTo(confirm_delete, confirm_deletion_x, confirm_deletion_y)
    Delay 100
    Call Plugin.Bkgnd.LeftClick(confirm_delete, confirm_deletion_x, confirm_deletion_y)
    Delay 200
End Sub


Sub confirm_sticker(a)
    // 输入表情包名，按 Enter 确认选择
    SayString a
    KeyPress "Enter", 1
    Delay 200
End Sub


Sub click_file()
    // 移动并点击聊天列表中的文件
    Call Plugin.Bkgnd.MoveTo(Hwnd, chat_file_x, chat_file_y)
    Delay 100
    Call Plugin.Bkgnd.LeftClick(Hwnd, chat_file_x, chat_file_y)
    Delay 200
End Sub

