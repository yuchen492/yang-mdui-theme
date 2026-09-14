<!doctype html>
<html lang="zh-cmn-Hans">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no"/>
    <meta name="renderer" content="webkit"/>
    <meta name="force-rendering" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <!-- MDUI CSS -->
    <link rel="stylesheet" href="/themes/clientarea/yang-mdui-re/src/css/mdui.min.css"/>
    
        <link href="/themes/clientarea/default/assets/css/bootstrap.min.css?v={$Ver}" rel="stylesheet" type="text/css" />
        <link href="/themes/clientarea/default/assets/css/icons.min.css?v={$Ver}" rel="stylesheet" type="text/css" />
        <link href="/themes/clientarea/default/assets/css/app.min.css?v={$Ver}" rel="stylesheet" type="text/css" />
        {if($load_css=load_css('custom.css'))}
            <link href="{$load_css}?v={$Ver}" rel="stylesheet" type="text/css" />
        {/if}
        <!-- 自定义全局样式 -->
        <link href="/themes/clientarea/default/assets_custom/css/global.css?v={$Ver}" rel="stylesheet" >
        <link href="/themes/clientarea/default/assets_custom/css/responsive.css?v={$Ver}" rel="stylesheet">
        <!-- 字体图标 -->
        
        
        
         <link href="/themes/clientarea/default/assets_custom/fonts/iconfont.css?v={$Ver}" rel="stylesheet"> 
        
        <!-- JAVASCRIPT -->
        <script src="/themes/clientarea/default/assets/libs/jquery/jquery.min.js?v={$Ver}"></script>
        <script src="/themes/clientarea/default/assets/libs/bootstrap/js/bootstrap.bundle.min.js?v={$Ver}"></script>
        <script src="/themes/clientarea/default/assets/libs/metismenu/metisMenu.min.js?v={$Ver}"></script>
        <script src="/themes/clientarea/default/assets/libs/simplebar/simplebar.min.js?v={$Ver}"></script>
        <script src="/themes/clientarea/default/assets/libs/node-waves/waves.min.js?v={$Ver}"></script>
        <script src="/themes/clientarea/yang-mdui-re/src/js/mdui.min.js"></script>
        
        <!-- <script src="/themes/clientarea/default/assets/libs/error-all/solve-error.js" type="text/javascript"></script> -->
        <!-- 自定义js -->
        <script src="/themes/clientarea/default/assets_custom/js/throttle.js?v={$Ver}"></script>
        
        <link type="text/css" href="/themes/clientarea/default/assets/libs/toastr/build/toastr.min.css?v={$Ver}" rel="stylesheet" />
        <script src="/themes/clientarea/default/assets/libs/toastr/build/toastr.min.js?v={$Ver}"></script>
        
        <script>
	var setting_web_url = ''
  var language={:json_encode($_LANG)};
  </script>
    <script src="/themes/clientarea/yang-mdui-re/yangjs/cookieact.js"></script>
    
    <title>{$Title} - {if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}</title>
    
    {if $CustomDepot.yangmdui_card_radius}
    <style>
    .mdui-card {
      border-radius: {$CustomDepot.yangmdui_card_radius} !important;
    }
    .mdui-dialog {
      border-radius: {$CustomDepot.yangmdui_card_radius} !important;
    }
    </style>
    {/if}
    
    {if $CustomDepot.yangmdui_btn_radius}
    <style>
    .mdui-btn {
      border-radius: {$CustomDepot.yangmdui_btn_radius} !important;
    }
    </style>
    {/if}
    
    {if $CustomDepot.yangmdui_btn_icon_radius}
    <style>
    .mdui-btn-icon {
      border-radius: {$CustomDepot.yangmdui_btn_icon_radius} !important;
    }
    </style>
    {/if}
    
    {if $CustomDepot.yangmdui_color_primary_custom && $CustomDepot.yangmdui_color_primary == "yangmdui"}
    <style>
    .mdui-color-theme {
      background-color: {$CustomDepot.yangmdui_color_primary_custom} !important;
    }
    </style>
    {/if}
    
    {if $CustomDepot.yangmdui_color_accent_custom && $CustomDepot.yangmdui_color_accent == "yangmdui"}
    <style>
    .mdui-color-theme-accent {
      background-color: {$CustomDepot.yangmdui_color_accent_custom} !important;
    }
    </style>
    {/if}
    
      <style>
    .mdui-drawer, #left-drawer {
      background-color: #ffffff !important;
    }
    .mdui-theme-layout-dark .mdui-drawer, 
    .mdui-theme-layout-dark #left-drawer {
      background-color: #424242 !important;
    }
    </style>
  </head>
  <body class="mdui-appbar-with-toolbar mdui-theme-primary-{if $CustomDepot.yangmdui_color_primary}{$CustomDepot.yangmdui_color_primary}{else}indigo{/if} mdui-theme-accent-{if $CustomDepot.yangmdui_color_accent}{$CustomDepot.yangmdui_color_accent}{else}indigo{/if}">
  
  <div class="mdui-drawer mdui-drawer-close {$CustomDepot.yangmdui_drawer_class}" id="left-drawer">
            <ul class="mdui-list mdui-list-dense">
            {if $Userinfo}
                {foreach $Nav as $nv}
                    {if $nv.tag == "yang.sidebar"}
                        {foreach $nv.child as $nvc}
                            {if $nvc.tag == "yang.subtitle"}
                            <li class="mdui-subheader">{$nvc.name}</li>
                            {elseif $nvc.tag == "yang.iconlist"}
                                {foreach $nvc.child as $nvc2}
                                <li class="mdui-list-item mdui-ripple">
                                <i class="mdui-list-item-icon mdui-icon material-icons">{$nvc.url}</i>
                                    <a href="{$nvc2.url}" class="mdui-list-item-content">{$nvc2.name}</a>
                                </li>
                                {/foreach}
                            {else}
                            <li class="mdui-list-item mdui-ripple">
                                {if $nvc.tag}
                                <i class="mdui-list-item-icon mdui-icon material-icons">{$nvc.tag}</i>
                                {else}
                                <i class="mdui-list-item-icon mdui-icon {$nvc.fa_icon}"></i>
                                {/if}
                                <a href="{$nvc.url}" class="mdui-list-item-content">{$nvc.name}</a>
                            </li>
                            {/if}
                        {/foreach}
                    {/if}
                {/foreach}
            {else}
                {if $CustomDepot.yangmdui_custom_logout_sidebar == "true"}
                    {foreach $Nav as $nv}
                        {if $nv.tag == "yang.logoutsidebar"}
                            {foreach $nv.child as $nvc}
                                {if $nvc.tag == "yang.subtitle"}
                                <li class="mdui-subheader">{$nvc.name}</li>
                                {elseif $nvc.tag == "yang.iconlist"}
                                    {foreach $nvc.child as $nvc2}
                                    <li class="mdui-list-item mdui-ripple">
                                    <i class="mdui-list-item-icon mdui-icon material-icons">{$nvc.url}</i>
                                        <a href="{$nvc2.url}" class="mdui-list-item-content">{$nvc2.name}</a>
                                    </li>
                                    {/foreach}
                                {else}
                                <li class="mdui-list-item mdui-ripple">
                                    {if $nvc.tag}
                                    <i class="mdui-list-item-icon mdui-icon material-icons">{$nvc.tag}</i>
                                    {else}
                                    <i class="mdui-list-item-icon mdui-icon {$nvc.fa_icon}"></i>
                                    {/if}
                                    <a href="{$nvc.url}" class="mdui-list-item-content">{$nvc.name}</a>
                                </li>
                                {/if}
                            {/foreach}
                        {/if}
                    {/foreach}
                {else}
                  <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons">person_add</i>
                    <a href="/login" class="mdui-list-item-content">请先登录</a>
                  </li>
                  <li class="mdui-list-item mdui-ripple">
                    <i class="mdui-list-item-icon mdui-icon material-icons"></i>
                    <a href="/register" class="mdui-list-item-content">或点此注册</a>
                  </li>
                {/if}
            {/if}
            </ul>
  </div>
  
  <div class="mdui-appbar mdui-color-theme mdui-appbar-fixed">
      <div class="mdui-toolbar mdui-color-theme">
        <a href="javascript:;" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '展开/隐藏侧边栏',position: 'right'}" mdui-drawer="{target: '#left-drawer'}">
          <i class="mdui-icon material-icons">menu</i>
        </a>
        <a href="javascript:history.back(-1);" class="mdui-btn mdui-btn-icon mdui-hidden-sm-down" mdui-tooltip="{content: '返回上一页'}">
          <i class="mdui-icon material-icons">arrow_back</i>
        </a>
        <a href="{$Setting.web_url}" class="mdui-typo-headline mdui-hidden-sm-down">{if $CustomDepot.yangmdui_teamname}{$CustomDepot.yangmdui_teamname}{else}{$Setting.company_name}{/if}</a>
        <a href="javascript:;" class="mdui-typo-title">{$Title}</a>
        <div class="mdui-toolbar-spacer"></div>
        
        {if $CustomDepot.yangmdui_enable_darkview == "true"}
        <a class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '切换深色模式'}" onclick="darkviewSwitch();">
          <i class="mdui-icon material-icons" id="mainappViewButton">wb_sunny</i>
        {/if}
        
        </a>
        {if $Userinfo}
        <a href="/cart?action=viewcart" class="mdui-btn mdui-btn-icon mdui-hidden-sm-down" mdui-tooltip="{content: '购物车'}">
          <i class="mdui-icon material-icons">shopping_cart</i>
        </a>
        <a href="javascript:;" class="mdui-btn mdui-btn-icon" mdui-menu="{target: '#appbaraccountmenu'}">
          {if $Userinfo.user.qq}
            <img class="mdui-img-circle mdui-img-fluid" src="https://q1.qlogo.cn/g?b=qq&nk={$Userinfo.user.qq}&s=640"/>
            {else}
            <div class="mdui-card-header-avatar mdui-typo-display-1">
                {if preg_match("/^[0-9]*[A-Za-z]+$/is", substr($Userinfo.user.username,0,1))}
                {$Userinfo.user.username|substr=0,1|upper}
                {elseif preg_match("/^[\x7f-\xff]*$/", substr($Userinfo.user.username,0,3))}
                {$Userinfo.user.username|substr=0,3}
                {else}
                {$Userinfo.user.username|substr=0,1|upper}
                {/if}
            </div>
            {/if}
        </a>
        <ul class="mdui-menu" id="appbaraccountmenu">
            <li class="mdui-menu-item" disabled>
                <a href="javascript:;">欢迎您，{$Userinfo.user.username}</a>
            </li>
            <li class="mdui-menu-item">
                <a href="/details">
                    <i class="mdui-menu-item-icon mdui-icon material-icons">account_circle</i>账户信息
                </a>
            </li>
            <li class="mdui-menu-item">
                <a href="/security">
                    <i class="mdui-menu-item-icon mdui-icon material-icons">security</i>安全设置
                </a>
            </li>
            <li class="mdui-menu-item">
                <a href="/supporttickets">
                    <i class="mdui-menu-item-icon mdui-icon material-icons">border_color</i>工单
                </a>
            </li>
            <li class="mdui-menu-item">
                <a href="/billing">
                    <i class="mdui-menu-item-icon mdui-icon material-icons">library_books</i>订单
                </a>
            </li>
            <li class="mdui-divider"></li>
            <li class="mdui-menu-item">
                <a href="/logout">
                    <i class="mdui-menu-item-icon mdui-icon material-icons">exit_to_app</i>登出
                </a>
            </li>
        </ul>
        {else}
        <a href="/login" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '请先登录'}">
          <i class="mdui-icon material-icons">person_add</i>
        </a>
        {/if}
      </div>
  </div>
  
  <style type="text/css">
	body{
		background: #f9fafb no-repeat center center fixed;
                -webkit-background-size: cover;
                -o-background-size: cover;                
                background-size: cover;
	}
	</style>
    <script>
    var mainappView = true;
    function mainappViewSwitch () {
    if (mainappView == true) {
        document.getElementById('yangMduiMainapp').style.visibility = 'hidden';
        document.getElementById('mainappViewButton').innerHTML = 'visibility_off';
        mdui.snackbar({
          message: '心之所向，无中生有。',
          position: 'left-bottom',
          timeout: 6000,
        });
    } else {
        document.getElementById('yangMduiMainapp').style.visibility = '';
        document.getElementById('left-drawer').style.visibility = '';
        document.getElementById('mainappViewButton').innerHTML = 'visibility';
    }
    mainappView = !mainappView;
    }
    </script>


  <div class="mdui-container" id="yangMduiMainapp">
  <br />