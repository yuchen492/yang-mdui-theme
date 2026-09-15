<!-- MDUI JavaScript -->
    
    <br>
        <div class="mdui-card mdui-hoverable">
          <div class="mdui-card-content mdui-text-center">
            {if $CustomDepot.yangmdui_footermsg}
            {$CustomDepot.yangmdui_footermsg}
            <br>
            {/if}
            {foreach $Nav as $nv}
                {if $nv.tag == "yang.footerlink"}
                    {foreach $nv.child as $nvc}
                        {if $nvc.tag == "yang.text"}
                        <span>{$nvc.name}</span>
                        {else}
                        <span>{if $nvc.fa_icon}<i class="mdui-icon {$nvc.fa_icon}"></i> {elseif $nvc.tag}<i class="mdui-icon material-icons">{$nvc.tag}</i> {/if}<a href="{$nvc.url}">{$nvc.name}</a></span>
                        {/if}
                    {/foreach}
                    <br>
                {/if}
            {/foreach}
            
              {if $CustomDepot.yangmdui_hidecopy == "true"}
              {else}
              <div class="mdui-typo-caption-opacity"><em>氧MDUI主题模板社区版</em> 由<a href="https://blog.yang1120.com/" target="_blank">Someone_Yang</a>和您一同完成。</div>
              {/if}
              
              {if $CustomDepot.yangmdui_enable_hitokoto == "true"}
              <a href="#" id="hitokoto_text" id="hitokoto">获取一言中...</a>
              {/if}
          
          </div>
        </div>
        <br>
    </div>
    
<div class="mdui-fab-wrapper" id="exampleFab" mdui-fab="{trigger: 'hover'}" style="z-index:10001;">
    <a class="mdui-fab mdui-ripple mdui-color-theme-accent" mdui-tooltip="{content: '跳转到顶部', position: 'left'}" href="#yangMduiMainapp">
      <i class="mdui-icon material-icons">keyboard_arrow_up</i>
    </a>
    <div class="mdui-fab-dial">
        <a class="mdui-fab mdui-fab-mini mdui-ripple mdui-color-pink" mdui-tooltip="{content: '工单中心', position: 'left'}" href="/supporttickets">
          <i class="mdui-icon material-icons">help_outline</i>
        </a>
        <a class="mdui-fab mdui-fab-mini mdui-ripple mdui-color-yellow" mdui-tooltip="{content: '账户信息', position: 'left'}" href="/details">
          <i class="mdui-icon material-icons">account_circle</i>
        </a>
        <a class="mdui-fab mdui-fab-mini mdui-ripple mdui-color-green" mdui-tooltip="{content: '账单流水', position: 'left'}" href="/billing">
          <i class="mdui-icon material-icons">attach_money</i>
        </a>
    </div>
</div>
    
  </body>
  <script>
  mdui.mutation();
  {if $CustomDepot.yangmdui_enable_hitokoto == "true"}
  fetch('{if $CustomDepot.yangmdui_hitokoto_serviceurl}{$CustomDepot.yangmdui_hitokoto_serviceurl}{else}https://v1.hitokoto.cn/{/if}')
    .then(response => response.json())
    .then(data => {
      var yangmduihtk = data.hitokoto
      if (data.from) {
        yangmduihtk = yangmduihtk + '——【' + data.from + '】'
      }
      if (data.from_who) {
        yangmduihtk = yangmduihtk + data.from_who
      }
      $('#hitokoto_text').text(yangmduihtk)
      $('#hitokoto_text').attr("href", 'https://hitokoto.cn/?uuid=' + data.uuid);
    })
    .catch($('#hitokoto_text').text('一言是什么呢？'))
    {/if}
</script>

{if $CustomDepot.yangmdui_bodybg}
<style>
	body{
		background:url({$CustomDepot.yangmdui_bodybg}) no-repeat center top;
		background-size:cover;
		background-attachment:fixed;
	}
</style>
{/if}

<script id="yangmdui-local-sidebar">
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
</script>
{if $CustomDepot.yangmdui_enable_darkview == "true"}
<script id="yangmdui-local-darkview">
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
</script>
{/if}

{if $TplName != 'configureproduct' }
    {if $CustomDepot.yangmdui_bootstrap_support == "true"}
    <script id="yangmdui-local-bssupport">
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
</script>
    <script>
    yangmdui_bst()
    </script>
    {/if}
{/if}
</html>