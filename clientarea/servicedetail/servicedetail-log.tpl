<div class="mdui-table-fluid">
    <table class="mdui-table">
        <thead>
          <tr>
            <th>事项</th>
            <th>时间</th>
            <th>触发用户</th>
          </tr>
        </thead>
        <tbody>
        {foreach $RecordLog as $item}
            <tr>
                <td>{$item.description}</td>
                <td>{$item.create_time|date="Y-m-d H:i:s"}</td>
                <td>{$item.user}<br>{$item.ipaddr}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>

<div class="table-footer">
  <div class="table-tools">

  </div>
    <div class="table-pagination">
      <div class="table-pagination generallog">
        <div class="table-pageinfo mr-2">
          <span>共{$Total}条日志</span>
          <span class="mx-2">
            每页显示
            <select name="" id="limitSel" class="log-limit" onchange="getGeneralLog('{$Think.get.id}', '{$Think.get.page}')">
              <option value="10" {if $Limit==10}selected{/if}>10 </option>
              <option value="15" {if $Limit==15}selected{/if}>15 </option>
              <option value="20" {if $Limit==20}selected{/if}>20 </option>
              <option value="50" {if $Limit==50}selected{/if}>50 </option>
              <option value="100" {if $Limit==100}selected{/if}>100
              </option>
            </select>条日志</span>
        </div>
        <ul class="pagination pagination-sm">
          {$Pages}
        </ul>
      </div>
    </div>
</div>


<script>

  $(document).on('click', ".generallog a[class*='page-link']", function () {
    var _this = $(this)
    $('#settings1').html('数据正在加载')
    $.ajax({
      url: '{$Setting.web_url}' + '/servicedetail',
      type: 'GET',
      data: logObj,
      success: function (res) {
        $('#settings1').html(res)
        {if $CustomDepot.yangmdui_bootstrap_support == "true"}
        yangmdui_bst();
        {/if}
      }
    })

    return false;
  });
</script>