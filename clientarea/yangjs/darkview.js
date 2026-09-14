// 氧MDUI深色模式操作方法
var darkviewStatus = getCookie('yangMduiDark');
if (darkviewStatus){
    if (darkviewStatus == 1) {
        $(document.body).addClass('mdui-theme-layout-dark')
    } 
} else {
    setCookie('darkviewStatus',0,60);
}
function darkviewSwitch() {
    var darkviewStatus = getCookie('yangMduiDark');
    if (darkviewStatus == 1) {
        $(document.body).removeClass('mdui-theme-layout-dark')
        setCookie('yangMduiDark',0,60);
    } else {
        $(document.body).addClass('mdui-theme-layout-dark')
        setCookie('yangMduiDark',1,60);
    }
}