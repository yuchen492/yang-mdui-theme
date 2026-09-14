// 氧MDUI的Bootstrap前端转化
function yangmdui_bst(){
    //按钮
    $(".btn").addClass("mdui-btn");
    $(".btn").removeClass("btn");
    $(".btn-primary").addClass("mdui-btn-raised");
    $(".btn-primary").addClass("mdui-color-theme");
    $(".btn-primary").removeClass("btn-primary");
    //卡片
    $(".card").addClass("mdui-card");
    $(".card").removeClass("card");
    $(".card-body").addClass("mdui-card-content");
    $(".card-body").removeClass("card-body");
    //内置分页
    $(".page-link").addClass("mdui-btn");
    $(".page-link").addClass("mdui-btn-icon");
    $(".page-link").addClass("mdui-btn-dense");
    $(".page-item.active > a").addClass("mdui-color-theme");
    $(".page-item.disabled > a").attr("disabled","true");
    $(".page-item").removeClass("page-item");
    $("select").addClass("mdui-select");
    //表格
    $("table").parent().addClass("mdui-table-fluid");
    $(".mdui-table-fluid").removeClass("table-responsive");
    $(".thead-light").removeClass("thead-light");
    $("table").addClass("mdui-table");
    $(".table").removeClass("table");
    //通用深色支持
    $(".bg-light").removeClass("bg-light");
    $(".text-dark").removeClass("text-dark");
}