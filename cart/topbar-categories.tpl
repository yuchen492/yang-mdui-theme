<link rel="stylesheet" href="/themes/cart/yang-mdui-re-cart/assets/css/topbar.css">
<style>
    @media (max-width: 576px) {
      
      .firstgroup_item,.secondgroup_item{
          min-width:auto!important;
          width:50%;
          padding:0;
      }
    }
    
</style>

{if $CustomDepot.yangmdui_cart_notice}
<div class="mdui-row mdui-m-y-1">
    <div class="mdui-col">
        <div class="mdui-card mdui-hoverable mdui-color-theme-accent">
        
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    <i class="mdui-icon material-icons">notifications</i> {if $CustomDepot.yangmdui_cart_notice_title}{$CustomDepot.yangmdui_cart_notice_title}{else}最新公告{/if}
                </div>
                {if $CustomDepot.yangmdui_cart_notice_subtitle}
                <div class="mdui-card-primary-subtitle">
                    {$CustomDepot.yangmdui_cart_notice_subtitle}
                </div>
                {/if}
            </div>
            <div class="mdui-card-content">
                {$CustomDepot.yangmdui_cart_notice}
            </div>
        </div>
    </div>
</div>
{/if}

<div class="mdui-row mdui-m-y-1">
    <div class="mdui-col">
        <div class="mdui-card mdui-hoverable">
        
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    筛选实例{if !$Userinfo && $CustomDepot.yangmdui_logout_hide_price == "true"}（受限筛选模式）{/if}
                </div>
                <div class="mdui-card-primary-subtitle">
                    筛选并购置适用于{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}的实例产品。
                    {if $Userinfo}
                        <a href="/cart?action=viewcart" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '查看已选产品'}"><i class="mdui-icon material-icons">shopping_cart</i></a>
                    {/if}
                </div>
            </div>
            <div class="mdui-card-content">
                <div class="mdui-typo-title">业务分区</div>
            
                {foreach $Cart.product_groups as $index=>$first} 
                    {if $first.id==$Think.get.fid || (!$Think.get.fid && $index==0)}
                    <a class="mdui-chip mdui-color-theme-accent" href="/cart?fid={$first.id}{if $Get.site}&site={$Get.site}{/if}">
                      <span class="mdui-chip-icon mdui-color-theme">
                        <i class="mdui-icon material-icons">location_on</i>
                      </span>
                      <span class="mdui-chip-title">{$first.name}</span>
                    </a>
                	{assign name="cart_first_id" value="$first.id" /}  
                	{assign name="cart_second" value="$first.second" /}  
                	{else/}
                	<a class="mdui-chip" href="/cart?fid={$first.id}{if $Get.site}&site={$Get.site}{/if}">
                      <span class="mdui-chip-title">{$first.name}</span>
                    </a>
                	{/if}
            	{/foreach}
            
            <hr>
                <div class="mdui-typo-title">可用区或配置套餐</div>
                {if !$Userinfo && $CustomDepot.yangmdui_logout_hide_price == "true"}
                	{foreach $cart_second as $index=>$secondItem}
                	{if $secondItem.id == $Think.get.gid || (!$Think.get.gid && $index==0)}
                	<a class="mdui-chip mdui-color-theme-accent">
                      <span class="mdui-chip-icon mdui-color-theme">
                        <i class="mdui-icon material-icons">location_on</i>
                      </span>
                      <span class="mdui-chip-title">{$secondItem.name}</span>
                    </a>
                	{assign name="cart_gid" value="$secondItem.id" /} 
                	{else/}
                	<div class="mdui-chip">
            	      <span class="mdui-chip-icon">
                        <i class="mdui-icon material-icons">lock_outline</i>
                      </span>
                      <span class="mdui-chip-title mdui-text-color-grey">{$secondItem.name}</span>
                    </div>
                	
                	{/if}
                	{/foreach}<hr>
                	<i class="mdui-icon material-icons">block</i> 部分数据已被隐藏，请先<a class="mdui-text-color-theme" href="/login">登录</a>以获取更多可用区及报价信息。
                {else}
                    {foreach $cart_second as $index=>$secondItem}
                	{if $secondItem.id == $Think.get.gid || (!$Think.get.gid && $index==0)}
                	<a class="mdui-chip mdui-color-theme-accent" href="/cart?fid={$cart_first_id}&gid={$secondItem.id}{if $Get.site}&site={$Get.site}{/if}">
                      <span class="mdui-chip-icon mdui-color-theme">
                        <i class="mdui-icon material-icons">location_on</i>
                      </span>
                      <span class="mdui-chip-title">{$secondItem.name}</span>
                    </a>
                	{assign name="cart_gid" value="$secondItem.id" /} 
                	{else}
                	<a class="mdui-chip" href="/cart?fid={$cart_first_id}&gid={$secondItem.id}{if $Get.site}&site={$Get.site}{/if}">
                      <span class="mdui-chip-title">{$secondItem.name}</span>
                    </a>
                	
                	{/if}
                	{/foreach}
                {/if}
            </div>
        </div>
    </div>
</div>

{foreach $cart_second as $index=>$secondItem}
{if $secondItem.id == $Think.get.gid || (!$Think.get.gid && $index==0)}
    {if $secondItem.headline}
    <div class="mdui-row mdui-m-y-1">
        <div class="mdui-col">
            <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                <div class="mdui-card-content">
                    <span class="mdui-typo-headline">{$secondItem.headline}</span>
                    {if $secondItem.tagline}
                        <a class="mdui-btn mdui-btn-raised mdui-color-theme mdui-float-right" mdui-dialog="{target: '#incloudifyDetailDia'}">了解更多</a>
                    {/if}
                	{assign name="cart_gid" value="$secondItem.id" /} 
                </div>
            </div>
        </div>
    </div>
    
    {/if}
    
    <div class="mdui-dialog" id="incloudifyDetailDia">
      <div class="mdui-dialog-title">产品信息</div>
      <div class="mdui-dialog-content">{$secondItem.tagline}</div>
      <div class="mdui-dialog-actions">
        <button class="mdui-btn mdui-ripple" mdui-dialog-close>我明白了</button>
      </div>
    </div>
{else}
{/if}
{/foreach}

{if $CustomDepot.yangmdui_cart_notice_enable == "true"}
<script>
{if $CustomDepot.yangmdui_cart_notice_allowignore == "true"}
if ("{if $CustomDepot.yangmdui_cart_notice_content}{$CustomDepot.yangmdui_cart_notice_content}{else}yangDefault{/if}" != getCookie('yangMduiCartNotice'))
{
{/if}

    mdui.dialog({
      history: false,
      modal: false,
      title: "{if $CustomDepot.yangmdui_cart_notice_cardtitle}{$CustomDepot.yangmdui_cart_notice_cardtitle}{else}重要提示{/if}",
      content: "{if $CustomDepot.yangmdui_cart_notice_content}{$CustomDepot.yangmdui_cart_notice_content}{else}请合法合规使用本站产品提供互联网业务。{/if}",
      buttons: [
        {if $CustomDepot.yangmdui_cart_notice_allowignore == "true"}
        {
          text: "不再显示",
          onClick: function(inst){
            setCookie("yangMduiCartNotice","{if $CustomDepot.yangmdui_cart_notice_content}{$CustomDepot.yangmdui_cart_notice_content}{else}yangDefault{/if}",60);
          }
        },
        {/if}
        {
          text: "我知道了"
        }
      ]
    });
    
{if $CustomDepot.yangmdui_cart_notice_allowignore == "true"}
}
{/if}
</script>
{/if}