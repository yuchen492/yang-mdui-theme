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

<script src="/themes/clientarea/yang-mdui-re/yangjs/sidebar.js"></script>
{if $CustomDepot.yangmdui_enable_darkview == "true"}
<script src="/themes/clientarea/yang-mdui-re/yangjs/darkview.js"></script>
{/if}

{if $TplName != 'configureproduct' }
    {if $CustomDepot.yangmdui_bootstrap_support == "true"}
    <script src="/themes/clientarea/yang-mdui-re/yangjs/bssupport.js"></script>
    <script>
    yangmdui_bst()
    </script>
    {/if}
{/if}
</html>