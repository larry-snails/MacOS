//
//  ORTestViewController.m
//  mac_sb
//
//  Created by 吕志滨 on 2019/8/2.
//  Copyright © 2019 吕志滨. All rights reserved.
//

#import "ORTestViewController.h"
#import <ORSSerialPort/ORSSerialPort.h>
#import <ORSSerialPort/ORSSerialPortManager.h>
@interface ORTestViewController ()<ORSSerialPortDelegate, NSUserNotificationCenterDelegate>

/**
 端口选择
 */
@property (weak) IBOutlet NSPopUpButton *portSelectItem;
/**
 波特率选择
 */
@property (weak) IBOutlet NSPopUpButton *baudRateSelectITem;
/**
 数据字节位数选择
 */
@property (weak) IBOutlet NSPopUpButton *dataBitSelectItem;

@property (weak) IBOutlet NSPopUpButton *paritySelectItem;

@property (nonatomic, copy) NSString *parityStr;
/**
 输入框发送内容
 */
@property (weak) IBOutlet NSTextField *textField;
/**
 结尾按钮拼接字符串按钮
 */
@property (weak) IBOutlet NSPopUpButton *textAddItem;

/**
 打开按钮
 */
@property (weak) IBOutlet NSButton *openPortButton;

/**
 显示的内容
 */
@property (unsafe_unretained) IBOutlet NSTextView *textView;

/**
 是否需要拼接尾部换行符
 */
@property (nonatomic, assign) BOOL isNeedAppendEndStr;
/**
 尾部需要添加的换行符
 */
@property (nonatomic, copy) NSString *endStr;

@property (nonatomic, strong) ORSSerialPort *port;

@property (nonatomic, strong) ORSSerialPortManager *manager;

@property (nonatomic, strong) NSMutableDictionary *portDict;

//@property (nonatomic, strong) NSTask *shellTask;
@end

@implementation ORTestViewController

//- (NSTask *)shellTask {
//    if (_shellTask == nil) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"HID_ControlApp" ofType:nil];
//        NSTask *shellTask = [[NSTask alloc] init];
//        [shellTask setLaunchPath: path];
//        _shellTask = shellTask;
//    }
//    return _shellTask;
//}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
//        [self runSHApp];
        _portDict = [NSMutableDictionary dictionary];
        _manager = [ORSSerialPortManager sharedSerialPortManager];
        [self addNotification];
    }
    return self;
}

//- (void)runSHApp {
//
//    NSPipe *pipe = [NSPipe pipe];
//    [self.shellTask setStandardOutput:pipe];
//    NSFileHandle *fileHandel = [pipe fileHandleForReading];
//    [self.shellTask launch];
//
//    NSData *data = [fileHandel readDataToEndOfFile];
//    NSString *shStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//    NSLog(@"shstr = %@", shStr);
//    if ([shStr containsString:@"ERROR: No Widget found!"]) {
//        NSLog(@"执行失败");
//    } else {
//        NSLog(@"执行成功");
//    }
//}

- (void)addNotification {
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(portWasConnected:) name:ORSSerialPortsWereConnectedNotification object:nil];
    [center addObserver:self selector:@selector(portWasDisConnected:) name:ORSSerialPortsWereDisconnectedNotification object:nil];
}

/**
 端口连接通知

 @param notification 通知
 */
- (void)portWasConnected:(NSNotification *)notification {
    NSArray *ports = [notification userInfo][ORSConnectedSerialPortsKey];
    for (ORSSerialPort *port in ports) {
        if (![[_portDict allKeys] containsObject:port.name]) {
            _portDict[port.name] = port.path;
            [self.portSelectItem addItemWithTitle:port.name];
        }
    }
    [self postUserNotificationForConnectedPorts:ports];
}

/**
 端口断开连接通知

 @param notification 通知
 */
- (void)portWasDisConnected:(NSNotification *)notification {
    NSArray *ports = [notification userInfo][ORSDisconnectedSerialPortsKey];
    for (ORSSerialPort *port in ports) {
        if ([[_portDict allKeys] containsObject:port.name]) {
            [_portDict removeObjectForKey:port.name];
            [self.portSelectItem removeItemWithTitle:port.name];
        }
    }
    [self postUserNotificationForDisConnectedPorts:ports];
}

- (void)postUserNotificationForConnectedPorts:(NSArray *)ports {
    NSUserNotificationCenter *userCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
    for (ORSSerialPort *port in ports) {
        NSUserNotification *userNotification = [[NSUserNotification alloc] init];
        userNotification.title = @"设备接入";
        userNotification.informativeText = [NSString stringWithFormat:@"设备%@已接入",port.name];
        userNotification.soundName = nil;
        [userCenter deliverNotification:userNotification];
    }
}

- (void)postUserNotificationForDisConnectedPorts:(NSArray *)ports {
    NSUserNotificationCenter *userCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
    for (ORSSerialPort *port in ports) {
        NSUserNotification *userNotification = [[NSUserNotification alloc] init];
        userNotification.title = @"设备拔出";
        userNotification.informativeText = [NSString stringWithFormat:@"设备%@已拔出",port.name];
        userNotification.soundName = nil;
        [userCenter deliverNotification:userNotification];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void) initData {
    [self.baudRateSelectITem removeAllItems];
    [self.baudRateSelectITem addItemsWithTitles: @[@"300", @"1200", @"2400", @"4800", @"9600", @"14400", @"19200", @"28800", @"38400", @"57600", @"115200", @"230400", @"921600"]];
    [self.baudRateSelectITem selectItemAtIndex:4];

    [self.dataBitSelectItem removeAllItems];
    [self.dataBitSelectItem addItemsWithTitles: @[@"5", @"6", @"7", @"8"]];
    [self.dataBitSelectItem selectItemAtIndex: 3];

    [self.paritySelectItem removeAllItems];
    [self.paritySelectItem addItemsWithTitles: @[@"None", @"Odd", @"Even"]];
    [self.paritySelectItem selectItemAtIndex: 2];

    [self.textAddItem removeAllItems];
    [self.textAddItem addItemsWithTitles: @[@"\\r", @"\\n", @"\\r\\n"]];
    [self.textAddItem selectItemAtIndex: 1];
    self.endStr = @"\n";
    self.isNeedAppendEndStr = YES;

    [self.portSelectItem removeAllItems];
    NSArray *ports = [self.manager availablePorts];
    for (ORSSerialPort *port in ports) {
        if (![[_portDict allKeys] containsObject:port.name]) {
            if (self.port == nil) {
                port.baudRate = @(9600);
                port.delegate = self;
                self.port = port;
            }
            _portDict[port.name] = port.path;
            [self.portSelectItem addItemWithTitle:port.name];
        }
    }
}

- (IBAction)portSelect:(NSPopUpButton *)sender {
    NSString *title = sender.itemTitles[sender.indexOfSelectedItem];
    NSString *path = (NSString *)_portDict[title];
    ORSSerialPort *port = [[ORSSerialPort alloc] initWithPath:path];
    port.baudRate = self.port.baudRate;
    port.numberOfStopBits = self.port.numberOfStopBits;
    port.delegate = self;
    self.port.delegate = nil;
    self.port = port;
    [self.port close];
    self.openPortButton.title = @"Open";
}

- (IBAction)stopBitsSelect:(NSButton *)sender {
    self.port.numberOfStopBits = sender.integerValue;
}

- (IBAction)flowControlSelect:(NSButton *)sender {
    NSString *title = sender.title;
    if ([title isEqualToString:@"DTR"]) {
        self.port.usesDTRDSRFlowControl = sender.integerValue;
    } else if ([title isEqualToString:@"CTS"]) {
        self.port.usesRTSCTSFlowControl = sender.integerValue;
    } else {
        self.port.usesDCDOutputFlowControl = sender.integerValue;
    }
}
- (IBAction)paritySelect:(NSPopUpButton *)sender {
    self.parityStr = sender.title;
    if ([self.parityStr isEqualToString:@"None"]) {
        self.port.parity = ORSSerialPortParityNone;
    } else if ([self.parityStr isEqualToString:@"Odd"]) {
        self.port.parity = ORSSerialPortParityOdd;
    } else {
        self.port.parity = ORSSerialPortParityEven;
    }
}

/**
 发送内容按钮点击事件

 @param sender 按钮
 */
- (IBAction)sendClick:(NSButton *)sender {
    NSString *text = self.textField.stringValue;
    if (text == nil || text.length <= 0) {
        return;
    }

    if (self.isNeedAppendEndStr) {
       text = [text stringByAppendingString: self.endStr];
    }

    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    if ([self.port isOpen]) {
        [self.port sendData: data];
    }
}

/**
 添加尾部换行按钮点击事件

 @param sender 按钮
 */
- (IBAction)textAddClick:(id)sender {
    NSButton *button = (NSButton *)sender;
    self.isNeedAppendEndStr = button.integerValue;
}

/**
 尾部换行类型

 @param sender 按钮
 */
- (IBAction)textEndTypeSelect:(NSPopUpButton *)sender {
    NSDictionary *map = @{@(0): @"\r", @(1):@"\n", @(2):@"\r\n"};
    self.endStr = map[ [NSNumber numberWithInteger:sender.indexOfSelectedItem]];
}

/**
 打开端口按钮

 @param sender 按钮
 */
- (IBAction)openPortClick:(NSButton *)sender {
    [self.port isOpen] ? [self.port close] : [self.port open];
}

#pragma mark - ORSSerialPortDelegate

- (void)serialPortWasRemovedFromSystem:(ORSSerialPort *)serialPort {
    
}

/**
 接收到Data

 @param serialPort 端口
 @param data 数据
 */
- (void)serialPort:(ORSSerialPort *)serialPort didReceiveData:(NSData *)data {
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (result == nil) {
        return;
    }
    if (self.textView.string == nil) {
        self.textView.string = result;
    } else {
        self.textView.string = [self.textView.string stringByAppendingString: result];
    }
}

- (void)serialPort:(ORSSerialPort *)serialPort didReceivePacket:(NSData *)packetData matchingDescriptor:(ORSSerialPacketDescriptor *)descriptor {

}

- (void)serialPort:(ORSSerialPort *)serialPort didReceiveResponse:(NSData *)responseData toRequest:(ORSSerialRequest *)request {

}

/**
 请求超时

 @param serialPort 端口
 @param request 请求
 */
- (void)serialPort:(ORSSerialPort *)serialPort requestDidTimeout:(ORSSerialRequest *)request {

}

- (void)serialPort:(ORSSerialPort *)serialPort didEncounterError:(NSError *)error {
    NSLog(@"Error: %@", error);
}
/**
 端口打开

 @param serialPort 端口
 */
- (void)serialPortWasOpened:(ORSSerialPort *)serialPort {
    [self.openPortButton setTitle:@"Close"];
}

/**
 端口关闭

 @param serialPort 端口
 */
- (void)serialPortWasClosed:(ORSSerialPort *)serialPort {
    [self.openPortButton setTitle:@"Open"];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [center removeDeliveredNotification:notification];
    });
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification {
    return true;
}

@end
