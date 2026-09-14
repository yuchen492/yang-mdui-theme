
{include file="includes/tablestyle"}

{include file="includes/deleteConfirm"}

<div class="mdui-card mdui-m-y-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">账单概述</div>
    </div>
	<div class="mdui-card-content">
	    <p>账单状态：
            {if $ViewBilling.detail.status == 'Paid'}
            <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 已支付</span>
            {elseif $ViewBilling.detail.status == 'Unpaid'}
            <span class="mdui-text-color-orange"><i class="mdui-icon material-icons">access_alarm</i> 未支付</span>
            {elseif $ViewBilling.detail.status == 'Cancelled'}
            <span class="mdui-text-color-grey"><i class="mdui-icon material-icons">money_off</i> 已取消</span>
            {elseif $ViewBilling.detail.status == 'Refunded'}
            <span class="mdui-text-color-grey"><i class="mdui-icon material-icons">restore</i> 已退款</span>
            {/if}
        </p>
        {if $CustomDepot.yangmdui_billing_payee}<p>收款方：{$CustomDepot.yangmdui_billing_payee}<span class="mdui-typo-caption">（您的账单资金最终由此收款方整理，若存在交易问题，您应该联系此收款方。）</span></p>{/if}
        {if $CustomDepot.yangmdui_billing_payment}<p>交易服务商：{$CustomDepot.yangmdui_billing_payment}<span class="mdui-typo-caption">（您的账单资金由此服务商接收处理，因此若存在退款，可能由此服务商直接退款给您，请留意接收。）</span></p>{/if}
        <p>消费者用户名：{$ViewBilling.detail.username}</p>
        <p>消费者联系电话：{if $ViewBilling.detail.phonenumber == ""}未设置{else}{$ViewBilling.detail.phonenumber}{/if}</p>
        
	    {if $ViewBilling.detail.status == 'Paid'}
	    <span><i class="mdui-icon material-icons mdui-text-color-green">info</i> 此账单状态正常。如果您需要进行退款，此账单可以作为退款申请凭据，并可申请最高<b>{$ViewBilling.currency.prefix}{$Pay.total}{$ViewBilling.currency.suffix}</b>退款金额。</span>
	    {/if}
	    {if $ViewBilling.detail.status == 'Unpaid'}
        <button class="mdui-btn mdui-btn-raised mdui-color-theme mdui-ripple" id="payamount" onclick="javascript: payamount({$Pay.invoiceid});">立即支付</button>
        {/if}
        {if $ViewBilling.detail.status == 'Refunded'}
        <span><i class="mdui-icon material-icons mdui-text-color-orange">info</i> 此账单已经标记为“已退款”，因此不能作为您的退款申请凭据。您可以尝试寻找其他标记为“已支付”的账单来申请退款。</span>
        {/if}
    </div>
</div>

<div class="mdui-card mdui-m-y-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">账单详情</div>
    </div>
	<div class="mdui-table-fluid">
        <table class="mdui-table">
            <thead>
                <tr>
                    <th>账单项目</th>
                    <th>消费类型</th>
                    <th>金额</th>
                </tr>
            </thead>
            <tbody>
                {foreach $ViewBilling.invoice_items as $item}
                <tr>
                    <td>
                    {foreach :explode("\n", $item.description) as $desc}
                      <div>{$desc}</div>
                    {/foreach}
                    </td>
                    <td>{$item.type_zh}</td>
                    <td>{$ViewBilling.currency.prefix}{$item.amount}{$ViewBilling.currency.suffix}</td>
                </tr>
                {/foreach}
                <tr>
                    <td></td>
                    <td><b>合计</b></td>
                    <td><b>{$ViewBilling.currency.prefix}{$Pay.total}{$ViewBilling.currency.suffix}</b></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

{if $ViewBilling.detail.status == 'Paid' || $ViewBilling.detail.status == 'Refunded'}
{if $ViewBilling.accounts}
<div class="mdui-card mdui-m-y-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">交易流水</div>
    </div>
	<div class="mdui-table-fluid">
        <table class="mdui-table">
            <thead>
                <tr>
                    <th>交易流水号</th>
                    <th>金额</th>
                    <th>支付方式</th>
                    <th>交易时间</th>
                </tr>
            </thead>
            <tbody>
                {foreach $ViewBilling.accounts as $var}
                <tr>
                    <td>{if $var.trans_id}{$var.trans_id}{else}<em>账户余额交易<em>{/if}</td>
                    <td>{$ViewBilling.currency.prefix}{$var.amount_in}{$ViewBilling.currency.suffix}</td>
                    <td>{$var.gateway}</td>
                    <td>{$var.pay_time|date="Y-m-d H:i:s"}</td>
                </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
</div>
{/if}
{/if}

{include file="includes/paymodal"}

<script>
  function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
  }

  window.onload = function() {
    //来自购物车页面就自动唤醒支付窗口
    var wakeup = getQueryString("wakeup");
    if (wakeup == 1) {
        $("#payamount").click();
        var payStatus = '{$ViewBilling.detail.status}';
        if(payStatus == 'Paid'){
          setTimeout(function () {
            $('#pay').hide();
            $('.modal-backdrop').hide();
            let invoiceid = '{$Pay.invoiceid}'
            $.post('/check_order', {id:'{$Pay.invoiceid}'},
                function(data){
                    if(data.status==1000){
                        $("#myLargeModalLabel").html("账单 - "+invoiceid);
                        if (data.data){
                            location.href = data.data
                        } else if ('{$ReturnUrl}') {
                            location.href = '{$ReturnUrl}'
                        } else if ('{$ViewBilling.detail.url}') { // 账单有回跳地址 优先处理
                            location.href = '{$ViewBilling.detail.url}'
                        } else if ('{$ViewBilling.invoice_items.0.hid}' == '0') {
                            location.href = 'service?groupid={$ViewBilling.invoice_items.0.groupid}'
                        } else {
                            location.href = 'servicedetail?id={$ViewBilling.invoice_items.0.hid}'
                        }
                    }

                }
            )
          },3000)
      }
    }
  }
</script>
<script src="/themes/clientarea/default/assets/js/billing.js?v={$Ver}"></script>
