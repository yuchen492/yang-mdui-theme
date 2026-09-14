{include file="cart/yang-mdui-re-cart/topbar-categories"}
<link rel="stylesheet" href="/themes/cart/province/assets/fonts/iconfont.css?v={$Ver}">

  <div class="mdui-row-xs-1 mdui-row-sm-2 mdui-row-md-3">
  
      {if $Cart.products}
          {foreach $Cart.products as $list}
          <div class="mdui-col">
            <div class="mdui-card mdui-hoverable mdui-m-y-1">
                <div class="mdui-card-primary">
                    {if !$Userinfo && $CustomDepot.yangmdui_logout_hide_price == "true"}
                    <div class="mdui-card-primary-title" mdui-tooltip="{content: '{$list.name}'}">
                        {$list.name}
                    </div>
                    {elseif $list.stock_control==1 && $list.qty<1}
                    <div class="mdui-card-primary-title mdui-text-color-grey" mdui-tooltip="{content: '{$list.name}（此产品已售罄，请优先选择其他产品）'}">
                        {$list.name}
                    </div>
                    {else}
                    <div class="mdui-card-primary-title" mdui-tooltip="{content: '{$list.name}'}">
                        {$list.name}
                    </div>
                    {/if}
                </div>
                <div class="mdui-card-content">
                    {$list.description}
                    <hr>
                    {if $list.product_price >= 8888}
                    
                    {else}
                        {if !$Userinfo && $CustomDepot.yangmdui_logout_hide_price == "true"}
                            无法获取库存信息，请尝试<a class="mdui-text-color-theme" href="/login">登录</a>。
                                <div class="mdui-progress">
                                    <div class="mdui-progress-indeterminate mdui-color-grey"></div>
                                </div>
                            无法获取报价，请尝试<a class="mdui-text-color-theme" href="/login">登录</a>。
                        {else}
                            {if $list.stock_control==1}
                            <div mdui-tooltip="{content: '此产品（{$list.name}）库存余量由财务端报告，仅供参考。如有疑问请发起工单联系运维人员。'}">
                                此产品库存余量：{if $CustomDepot.yangmdui_stock_showdetails == "true"}{$list.qty}{/if}
                                <div class="mdui-progress">
                                    {if $list.qty<1}
                                        <div class="mdui-progress-determinate mdui-color-red" style="width: 2%;"></div>
                                    {elseif $list.qty<5}
                                        <div class="mdui-progress-determinate mdui-color-orange" style="width: 10%;"></div>
                                    {elseif $list.qty<10}
                                        <div class="mdui-progress-determinate mdui-color-amber" style="width: 30%;"></div>
                                    {elseif $list.qty<15}
                                        <div class="mdui-progress-determinate  mdui-color-blue" style="width: 50%;"></div>
                                    {else}
                                        <div class="mdui-progress-determinate  mdui-color-green" style="width: 70%;"></div>
                                    {/if}
                                </div>
                            </div>
                            {else}
                                此产品库存余量：{if $CustomDepot.yangmdui_stock_showdetails == "true"}充足{/if}
                                <div class="mdui-progress">
                                    <div class="mdui-progress-determinate mdui-color-green" style="width: 90%;"></div>
                                </div>
                            {/if}
                            {$Cart.currency.prefix} {$list.product_price} {$Cart.currency.suffix} / {$list.billingcycle_zh}
                            {if $list.ontrial==1 && $CustomDepot.yangmdui_show_trialprice == "true"}
                            试用：{$Cart.currency.prefix} {$list.ontrial_setup_fee+$list.ontrial_price} / {$list.ontrial_cycle} {$list.ontrial_cycle_type == 'day' ? $Lang.day : $Lang.hour}
                            {else}{if $CustomDepot.yangmdui_show_trialprice_non == "true"}该产品不支持试用{/if}
                            {/if}
                            {if $list.has_bates && $CustomDepot.yangmdui_show_bates == "true"}
                            <br><span class="mdui-text-color-theme"><b>优惠报价：</b>{$Cart.currency.prefix} {$list.sale_price} {$Cart.currency.suffix} / {$list.billingcycle_zh}</span>
                            {/if}
                            {if $CustomDepot.yangmdui_show_productinfo == "true" || ($list.has_bates && $CustomDepot.yangmdui_show_productinfo_batesonly == "true")}
                            <br><span class="mdui-typo-caption">魔方财务 分组ID:{$list.gid} / 产品ID:{$list.id} / {$list.type}</span>
                            {/if}
                        {/if}
                    {/if}
                </div>
                {if $list.product_price < 8888}
                    <div class="mdui-card-actions">
                        {if !$Userinfo && $CustomDepot.yangmdui_logout_hide_price == "true"}
                            <a href="javascript:;" class="mdui-btn" disabled><i class="mdui-icon material-icons">block</i> 无法获取报价</a>
                            <a href="/login" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '登录'}"><i class="mdui-icon material-icons">person_add</i></a>
                        {else}
                            {if $list.stock_control==1 && $list.qty<1} 
                                <a href="javascript:;" class="mdui-btn" disabled><i class="mdui-icon material-icons">block</i> 已售罄</a>
                                <a href="/supporttickets" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '联系补货'}"><i class="mdui-icon material-icons">add_alert</i></a>
                            {else}
                                <a {if strstr($list.description,"no-after-service")}onclick="wmyq_cart_no_after_service('/cart?action=configureproduct&pid={$list.id}{if $Get.site}&site={$Get.site}{/if}')"{else}href="/cart?action=configureproduct&pid={$list.id}{if $Get.site}&site={$Get.site}{/if}"{/if} class="mdui-btn mdui-btn-raised mdui-color-theme"><i class="mdui-icon material-icons">add_circle_outline</i> 进入选配页面</a>
                            {/if}
                        {/if}
                    </div>
                {/if}
            </div>
          </div>
              
          {/foreach}
      {else}
      <div class="mdui-card mdui-m-y-1">
        <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">
                未发现产品
            </div>
        </div>
        <div class="mdui-card-content">
            筛选条件下，未找到适合{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}的产品。产品可能已售罄或不适合您所在的国家或地区。
        </div>
      </div>
      {/if}
    
  </div>


<script>
  $(function () {
    $('.cartitem').on('mouseover', function () {
      $(this).addClass('active')
    })
    $('.cartitem').on('mouseleave', function () {
      $(this).removeClass('active')
    })
  })
  function wmyq_cart_no_after_service (url) {
    mdui.prompt('请手动输入“我已知晓本产品无售后服务”','确认知晓本产品无售后',
      function (value) {
        if(value == '我已知晓本产品无售后服务'){
          location.href = url
        }else{
          mdui.alert('如您需要购买，请手动输入“我已知晓本产品无售后服务”！','提示',function(){
            wmyq_cart_no_after_service (url)
          },{confirmText:'再次输入'})
        }
      },
      function (value) {
      },{confirmText:'确认',cancelText:'取消'}
    )
  }
</script>