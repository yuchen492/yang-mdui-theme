<!-- 氧MDUI产品内页日志信息 -->
<!-- 吐槽同财务选项卡 -->

<div class="mdui-row" id="log-tab">
    <div class="mdui-col-xs-12">
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    操作日志
                </div>
            </div>
            <div class="mdui-card-content" id="settings1">
                <span id="log-tab-content"><div class="mdui-spinner mdui-spinner-colorful"></div> 正在获取日志信息，请稍后……</span>
            </div>
        </div>
    </div>
</div>

<script>
  const logObj = {
    id: '{$Think.get.id}',
    action: 'log_page'
  }
  $.ajax({
    type: "get",
    url: '' + '/servicedetail',
    data: logObj,
    success: function (data) {
      $('#log-tab-content').replaceWith(data);
      {if $CustomDepot.yangmdui_bootstrap_support == "true"}
      yangmdui_bst();
      {/if}
    }
  });
</script>