// 氧MDUI侧边栏记忆工具
var sidebarStatus = getCookie('yangMduiSidebar');
var yangMduiSidebarInst = new mdui.Drawer('#left-drawer');
if (sidebarStatus){
    if (sidebarStatus == 1) {
        yangMduiSidebarInst.open();
    } else {
        yangMduiSidebarInst.close();
    }
} else {
    setCookie('yangMduiSidebar',0,60);
    yangMduiSidebarInst.close();
}
mdui.$('#left-drawer').on('open.mdui.drawer', function () {
    setCookie('yangMduiSidebar',1,60);
});
mdui.$('#left-drawer').on('close.mdui.drawer', function () {
    setCookie('yangMduiSidebar',0,60);
});