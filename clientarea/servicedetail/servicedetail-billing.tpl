<div class="mdui-table-fluid">
    <table class="mdui-table">
        <thead>
          <tr>
            <th>流水号</th>
            <th>服务来源</th>
            <th>支付金额</th>
            <th>支付方式</th>
            <th>时间</th>
          </tr>
        </thead>
        <tbody>
        {foreach $HostRecharge as $item}
            <tr>
                <td>{$item.trans_id}</td>
                <td>{$item.type}</td>
                <td>{$Currency.prefix}{$item.amount_in}{$Currency.suffix}</td>
                <td>{$item.gateway}</td>
                <td>{$item.pay_time|date="Y-m-d H:i:s"}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>

<div class="table-footer">
  <div class="table-tools">

  </div>
  <div class="table-pagination">
    <div class="table-pageinfo mr-2">
      <span>{$Lang.common} {$Total} {$Lang.strips}</span>
      <span class="mx-2">
        {$Lang.each_page}
        <select name="" id="limitSel" class="billing-limit" onchange="getGeneralBilling('{$Think.get.id}', '{$Think.get.page}')">
          <option value="10" {if $Limit==10}selected{/if}>10</option>
          <option value="15" {if $Limit==15}selected{/if}>15</option>
          <option value="20" {if $Limit==20}selected{/if}>20</option>
          <option value="50" {if $Limit==50}selected{/if}>50</option>
          <option value="100" {if $Limit==100}selected{/if}>100</option>
        </select>
        {$Lang.strips}
      </span>
    </div>
    <ul class="pagination pagination-sm">
      {$Pages}
    </ul>
  </div>
</div>