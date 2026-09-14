<!-- 氧MDUI产品内页加载插件选项卡 -->

{foreach $Detail.module_client_area as $key=>$item}

<div class="mdui-row" id="module_client_area_{$item.key}">
    <div class="mdui-col-xs-12">
    
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    {$item.name}
                </div>
            </div>
            <div class="mdui-card-content" id="module_client_area_{$item.key}_content">
                <div class="mdui-spinner mdui-spinner-colorful"></div> 正在获取选项卡信息……<br>
                如果长时间未成功加载，请尝试刷新页面。
            </div>
        </div>

    <script>
      $.ajax({
        url : '/provision/custom/content?id={$Think.get.id}&key={$item.key}&date='+Date.parse(new Date()) 
        ,type : 'get'
        ,success : function(res) {
          $('#module_client_area_{$item.key}_content').html(res);
          {if $CustomDepot.yangmdui_bootstrap_support == "true"}
          yangmdui_bst();
          {/if}
          {if $item.key == "nat_acl" && $CustomDepot.yangmdui_clientnat == "true"}
            target = $("#module_client_area_nat_acl_content > .mdui-table-fluid > table > tbody > tr > td").eq(1)
            targetNat = target.text()
            targetIp = targetNat.split(":")[0]
            $("#nat_aclBox").text(targetNat)
            {if $CustomDepot.yangmdui_clientnat_fetch}
            $.ajax({
                url : '{$CustomDepot.yangmdui_clientnat_fetch}' + targetIp 
                ,type : 'get'
                ,success : function(res) {
                  $("td").html(function(index, html) {
                      return html.replace(targetIp, '(已优选) ' + res);
                    });
                  $("#nat_aclBox").text(target.text())
                }
              })
            {/if}
          {/if}
        }
      })
    </script>
    </div>
</div>

{/foreach}