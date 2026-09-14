<!-- 氧MDUI产品内页财务信息 -->
<!-- 智简魔方一直在更新主js，氧MDUI不能直接替换那些js，但是一些方法写的很混乱，因此将内页的ajax获取请求单独写到了这里 -->

<div class="mdui-row" id="finance-tab">
    <div class="mdui-col-xs-12">
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    财务信息
                </div>
            </div>
            <div class="mdui-card-content">
                <p>这里显示的是财务系统自动整理的财务信息，不包括其他渠道应用的财务信息（例如协作云互通）。</p>
                <p>要查看具体的账单流水，并对账单进行复核、开票、退款等操作，请转到<a href="/billing">账单页面</a>。</p>
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
            </div>
            <div class="mdui-card-actions">
                {if $Detail.host_data.billingcycle != 'free' && $Detail.host_data.billingcycle != 'onetime' &&
                ($Detail.host_data.domainstatus == 'Active' || $Detail.host_data.domainstatus == 'Suspended')}
                <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme" id="renew"
                  onclick="renew($(this), '{$Think.get.id}')"><i class="mdui-icon material-icons">alarm_add</i> 续费实例</button>
                {/if}
            </div>
        </div>
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    财务日志
                </div>
            </div>
            <div class="mdui-card-content" id="finance">
                <span id="finance-content"><div class="mdui-spinner mdui-spinner-colorful"></div> 正在载入整理财务信息，请稍后……</span>
            </div>
        </div>
    </div>
</div>
            
<script>
const financeObj = {
    id: '{$Think.get.id}',
    action: 'billing_page'
}
$.ajax({
    type: "get",
    url: '' + '/servicedetail',
    data: financeObj,
    success: function (data) {
      $('#finance').html(data);
      {if $CustomDepot.yangmdui_bootstrap_support == "true"}
      yangmdui_bst();
      {/if}
    }

  });
</script>