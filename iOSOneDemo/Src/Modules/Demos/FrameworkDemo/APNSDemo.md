#  APNS

##  APNS的工作原理

苹果官方给出的ios推送机制：

![本地图片](./MDImage/apns_overview.jpg)

更详细的工作流程如下图：

![本地图片](./MDImage/apns_workspecific.jpg)

1. App先向iOS系统发起注册push notification服务；
2. iOS向APNS服务器注册设备信息，得到一个DeviceToken，以回调的形式给回App；
3. App再将此DeviceToken与在应用Server里的用户标识发回应用Server的push服务器端；
4. 要发送push消息时，应用Server push服务器向APNS发送消息通知下发Push；
5. APNS下发Push通知消息给iOS，iOS以回调形式通知App；



