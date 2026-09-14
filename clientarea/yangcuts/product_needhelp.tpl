<div class="mdui-card mdui-m-y-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">
            遇到问题？
        </div>
    </div>
    <div class="mdui-card-content">
        <p>您可以前往<a href="/supporttickets" target="_blank">工单中心发起新工单</a>寻求运维成员的帮助。</p>
        <p>您可以查阅<a href="{if $CustomDepot.yangmdui_document_url}{$CustomDepot.yangmdui_document_url}{else}/knowledgebase{/if}" target="_blank">文档中心搜索问题</a>，可能有您遇到的常见问题解决方案。
        {if $CustomDepot.yangmdui_qqgroup_number}
            {if $CustomDepot.yangmdui_qqgroup_url}
                <p>您还可以<a href="{$CustomDepot.yangmdui_qqgroup_url}" target="_blank">点击此处加入官方QQ交流群</a>（群号：{$CustomDepot.yangmdui_qqgroup_number}）与运维成员和其他用户交流问题，探索解决方案。</p>
            {else}
                <p>您还可以加入官方QQ交流群（群号：{$CustomDepot.yangmdui_qqgroup_number}）与运维成员和其他用户交流问题，探索解决方案。</p>
            {/if}
        {/if}
    </div>
</div>