<!-- 氧MDUI产品内页财务信息简述卡片 -->

<div class="mdui-card mdui-m-y-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">财务信息</div>
    </div>
    <div class="mdui-card-content">
        <p>实例状态：
            <span class="badge badge-pill py-1 status-{$Detail.host_data.domainstatus|strtolower} mb-3">{$Detail.host_data.domainstatus_desc}</span>
        </p>
        <p>开通价格：{$Detail.host_data.firstpaymentamount_desc}</p>
        <p>续费价格：{$Detail.host_data.amount_desc}</p>
        <p>开通日期：{$Detail.host_data.regdate|date="Y-m-d H:i"}</p>
        <p>下一付款周期开始：{if $Detail.host_data.format_nextduedate.msg == '不到期'}  {else} {$Detail.host_data.format_nextduedate.msg} {/if}</p>
        <p>财务结算周期：{$Detail.host_data.billingcycle_desc}</p>
        <p>下一结算末期（过期日期）：
            {if $Detail.host_data.billingcycle == 'free' || $Detail.host_data.billingcycle == 'onetime'}
              {if $Detail.host_data.billingcycle_desc == '一次性' || $Detail.host_data.billingcycle_desc == '免费'}
                不存在
              {else}
                {$Detail.host_data.format_nextduedate.msg}
              {/if}
            {else}
            {$Detail.host_data.nextduedate|date="Y-m-d H:i"}
            {/if}
        </p>
        {if $Detail.host_data.billingcycle != 'free' && $Detail.host_data.billingcycle != 'onetime' &&
        ($Detail.host_data.domainstatus == 'Active' || $Detail.host_data.domainstatus == 'Suspended')}
        <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme" id="renew"
          onclick="renew($(this), '{$Think.get.id}')"><i class="mdui-icon material-icons">alarm_add</i> 续费实例</button>
        {/if}
    </div>
</div>