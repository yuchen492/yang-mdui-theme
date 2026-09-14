<!-- 新人优惠码 -->
    {if $CustomDepot.yangmdui_welcomecard == "true"}
        {if $ClientArea.index.host}
        {else}
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title mdui-text-color-theme-accent">欢迎新用户</div>
          </div>
          <div class="mdui-card-content">
            <div class="mdui-typo-headline">感谢您注册{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}！
            {if $CustomDepot.yangmdui_wcc_displaypro}您已可用一个<span class="mdui-text-color-theme-accent">{$CustomDepot.yangmdui_wcc_prodesc} 优惠码</span>。现在下单立刻享受优惠！{/if}
            </div><br>
            {if $CustomDepot.yangmdui_wcc_displaypro}<div>您的新人优惠码：<span class="mdui-typo-display-1 mdui-text-color-theme-accent">{$CustomDepot.yangmdui_wcc_procontent}</span></div>{/if}
            {if $CustomDepot.yangmdui_wcc_desc}<p>{$CustomDepot.yangmdui_wcc_desc}</p>{/if}
            {if $CustomDepot.yangmdui_wcc_smdesc}<div class="mdui-typo-caption">{$CustomDepot.yangmdui_wcc_smdesc}</div>{/if}
          </div>
          <div class="mdui-card-actions">
            <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme" href="/cart"><i class="mdui-icon material-icons">play_circle_outline</i> 选择并新建一个实例，使用优惠码</a>
            <a class="mdui-btn mdui-btn-raised mdui-ripple" href="/affiliates"><i class="mdui-icon material-icons">attach_money</i> 使用推介计划邀请新用户，他人消费帮您赚零花钱</a>
          </div>
        </div>
        
        <br />
        {/if}
    {/if}