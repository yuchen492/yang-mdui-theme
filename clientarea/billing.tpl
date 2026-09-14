{include file="includes/tablestyle"}

{include file="includes/deleteConfirm"}

<div class="mdui-card">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">交易账单</div>
        <a class="mdui-btn" href="/billing">筛选全部</a>
        <a class="mdui-btn" href="/billing?status=Unpaid">筛选未支付</a>
        <a class="mdui-btn" href="/billing?status=Paid">筛选已支付</a>
        
    </div>
    <div class="mdui-card-content">
        <form action="combinebilling">
            <div>
            <button class="mdui-btn mdui-btn-raised mdui-color-blue-a200" disabled id="readBtn" type="submit">{$Lang.consolidated_payment}</button>
            <span id="pay-combine">{$Lang.you_have}{$Count}{$Lang.paid_total}{$Total_money}{$Lang.element}<span>
            </div>
            <div class="mdui-table-fluid">
                <table class="mdui-table mdui-table-hoverable">
                    <thead>
                        <tr>
                            <th>
                                <label class="mdui-checkbox" for="customCheck">
                                    <input type="checkbox" name="headCheckbox" onchange="headCheckboxAll(this)" id="customCheck" >
                                    <i class="mdui-checkbox-icon"></i>
                                </label>
                            </th>
                            <th>#</th>
                            <th>类型</th>
                            <th>金额</th>
                            <th>付款时间</th>
                            <th>支付渠道</th>
                            <th>逾期时间</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach $Billing as $index => $bill}
                        <tr>
                            <td>
                                <label class="mdui-checkbox" for="customCheck{$bill.id}">
                                    <input type="checkbox" class="custom-control-input row-checkbox" onclick="rowCheckbox(this)" id="customCheck{$bill.id}" data-name="ids[{$index}]" name="ids[{$index}]" data-value="{$bill.id}" value="{$bill.id}">
                                    <i class="mdui-checkbox-icon"></i>
                                </label>
                            </td>
                            <td>{$bill.id}</td>
                        	<td>{$bill.type_zh}</td>
                        	<td>{$bill.subtotal}</td>
                        	<td>{if $bill.paid_time}{$bill.paid_time|date="Y-m-d H:i"}{else}-{/if}</td>
                        	<td>{if $bill.payment_zh}{$bill.payment_zh}{else}-{/if}</td>
                        	<td>{if $bill.due_time}{$bill.due_time|date="Y-m-d H:i"}{else}-{/if}</td>
                        	<td>
                            	{if $bill.status == 'Paid'}
                                <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 已支付</span>
                                {elseif $bill.status == 'Unpaid'}
                                <span class="mdui-text-color-orange"><i class="mdui-icon material-icons">access_alarm</i> 未支付</span>
                                {elseif $bill.status == 'Cancelled'}
                                <span class="mdui-text-color-grey"><i class="mdui-icon material-icons">money_off</i> 已取消</span>
                                {elseif $bill.status == 'Refunded'}
                                <span class="mdui-text-color-grey"><i class="mdui-icon material-icons">restore</i> 已退款</span>
                                {/if}
                        	</td>
                        	<td>
                        	    <a href="viewbilling?id={$bill.id}" class="mdui-btn"><i class="mdui-icon material-icons">pageview</i> 查看</a>
                        		{if $bill.status == 'Unpaid'}
                        		<a href="javascript: payamount({$bill.id});" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '支付'}"><i class="mdui-icon material-icons">attach_money</i></a>
                        		<a href="javascript: deleteConfirm('invoices', '{$Lang.delete_bill}', '{$Lang.want_delete_the_bill}', {id: {$bill.id}, token: '{$Token}'});" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '删除此账单'}"><i class="mdui-icon material-icons">delete_forever</i></a>
                        		{/if}
                        	</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>

        	</div>
        </form>
	</div>
	<div class="mdui-card-actions">
	    <ul class="pagination">
	        {$Pages}
	    </ul>
	</div>
</div>

{include file="includes/paymodal"}


<script>
	var _url = '';
	var status = '{$Think.get.status}'
	// 排序
	$('.bg-light .pointer').on('click', function () {
		var sort = '{$Think.get.sort}'
		location.href = 'billing?status={$Think.get.status}&sort=' + (sort == 'desc' ? 'asc' : 'desc') + '&orderby=' + $(this).attr('prop') + '&page={$Think.get.page}&limit={$Think.get.limit}'
	})
	//排序样式
	changeStyle()
	function changeStyle() {
		$('.bg-light th.pointer').children().children().css('color','rgba(0, 0, 0, 0.1)')
	var sort = '{$Think.get.sort}'
	let orderby = '{$Think.get.orderby}'
	let index,
	n
	if(orderby === 'id') {
				n = 0
	} else if(orderby === 'subtotal') {
				n = 1
	} else if(orderby === 'paid_time'){
				n = 2
	} else if(orderby === 'due_time') {
				n = 3
	} else if(orderby === 'status') {
				n = 4
	}
	if (sort === 'desc') {
			index = 1 + 2 * n
	} else if(sort === 'asc'){
			index = 0 + 2 * n
	}
		$('.bg-light th.pointer').children().children().eq(index).css('color','rgba(0, 0, 0, 0.8)')
	}
	// 状态筛选
	$('#statusSel').on('change', function () {
		location.href = "billing?status=" + $('#statusSel').val() + "&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page={$Think.get.page}&limit={$Think.get.limit}"
	});
// 每页数量选择改变
	$('#limitSel').on('change', function () {
		location.href = '/billing?keywords={$Think.get.keywords}&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page=1&limit=' + $('#limitSel').val()

	})
</script>
<script src="/themes/clientarea/default/assets/js/billing.js?v={$Ver}"></script>