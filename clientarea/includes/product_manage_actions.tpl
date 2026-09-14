<div class="mdui-card-actions">
{if $list.domainstatus == "Active" || $list.domainstatus == "Suspended"}
    <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme" href="servicedetail?id={$list.id}"><i class="mdui-icon material-icons">build</i> 管理实例</a>
    {else}
    <a class="mdui-btn mdui-btn-raised mdui-ripple" disabled><i class="mdui-icon material-icons">build</i> 管理实例</a>
    {/if}
    {if $list.domainstatus == "Pending"}
        <button class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '此实例尚未激活，请确认是否支付完成？一般支付完成后发起开通任务，3分钟之内实例将成功开通。若遇到被攻击等网络不畅或接口出错而导致未正常开通的情况，请发起工单咨询。'}">
              <i class="mdui-icon material-icons">warning</i>
        </button>
    {elseif $list.domainstatus == "Suspended"}
        <button class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '实例已暂停，可能是已过期，或违反用户协议。如果到期，请及时续费以恢复；如果未到期而暂停，请联系运维团队了解原因。'}">
              <i class="mdui-icon material-icons">timer_off</i>
        </button>
    {elseif $list.domainstatus == "Deleted"}
        <button class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '实例已释放，可能是已经过期。如有疑问，请发起工单联系运维。'}">
              <i class="mdui-icon material-icons">delete</i>
        </button>
    {elseif $list.domainstatus == "Cancelled"}
        <button class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '实例开通任务已取消，可能是订单未完成支付。如有疑问，请发起工单联系运维。'}">
              <i class="mdui-icon material-icons">error</i>
        </button>
{/if}
</div>