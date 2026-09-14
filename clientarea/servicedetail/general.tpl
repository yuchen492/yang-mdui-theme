
{include file="includes/modal"}
{include file="includes/pop"}
{include file="yangcuts/product_service_module_button"}

<div class="container-fluid">

    <div class="mdui-card mdui-tab mdui-tab-scrollable" mdui-tab>
        <a href="#yang-general-info" class="mdui-ripple" data-toggle="tab">实例概览</a>
        {foreach $Detail.module_client_area as $key=>$item}
            <a href="#module_client_area_{$item.key}" class="mdui-ripple" data-toggle="tab">{$item.name}</a>
        {/foreach}
        {if $Detail.config_options || $Detail.host_data.allow_upgrade_product || $Detail.host_data.allow_upgrade_product}
        <a href="#profile1" class="mdui-ripple" data-toggle="tab">配置参数</a>
        {/if}
        <a href="#finance-tab" class="mdui-ripple" data-toggle="tab">财务信息</a>
        {if $Detail.download_data}
        <a href="#download" class="mdui-ripple" data-toggle="tab">下载</a>
        {/if}
        <a href="#log-tab" class="mdui-ripple" data-toggle="tab">操作日志</a>
        <a href="#delete-tab" class="mdui-ripple" data-toggle="tab">释放实例</a>
    </div>

    <div class="mdui-row" id="yang-general-info">
        <div class="mdui-col-xs-12 mdui-col-sm-8">
        
            <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                <div class="mdui-card-primary">
                    {if $Detail.host_data.remark}
                        <div class="mdui-card-primary-title">{$Detail.host_data.remark}</div>
                        <div class="mdui-card-primary-subtitle">实例信息</div>
                    {else}
                        <div class="mdui-card-primary-title">实例信息</div>
                    {/if}
                </div>
                <div class="mdui-card-content">
                
                    {if $Detail.host_data.suspendreason && $Detail.host_data.domainstatus == 'Suspended'}
                        <p class="mdui-text-color-red">此实例已被暂停，请联系运维团队解决。暂停原因：{$Detail.host_data.suspendreason}</p>
                    {/if}
                    <p><strong>产品名：</strong>{$Detail.host_data.productname}</p>
                    <p><strong>实例 ID：</strong>{$Detail.host_data.id}</p>
                    <p><strong>标识号：</strong>{$Detail.host_data.domain}</p>
                    {if $CustomDepot.yangmdui_hideteststatus !== "true"}
                    <p><strong>实例状态：</strong>
                    {if $Detail.module_power_status == 1}
                        <i class='mdui-icon material-icons mdui-text-color-green'>play_circle_filled</i> 财务端监控正常
                    {else}
                        <i class='mdui-icon material-icons mdui-text-color-red'>error</i> 财务端监控异常
                    {/if} / 
                    <span id="instanceStatusDes">获取客户端状态中……</span>
                    </p>
                    {/if}
                    <p>{if $Detail.host_data.format_nextduedate.msg == '不到期'}当前实例永不到期{else}<strong>当前实例可用时长：</strong>{$Detail.host_data.format_nextduedate.msg}（一直到{$Detail.host_data.nextduedate|date="Y-m-d H:i"}）{/if}</p>
                    {if $Cancel.host_cancel}<p class="mdui-text-color-red">您设置了此实例{$Lang.stop_when_due}释放，请留意已备份资源。</p>{/if}
                </div>
                {if $CustomDepot.yangmdui_hideteststatus !== "true"}
                <script>
                $.ajax({
                    type: "GET",
                    url: '/v1/hosts/{$Detail.host_data.id}/module/status?type=host',
                    success: function(data) {
                        if (powerData = data.data) {
                              if (powerData['status'] == 'on') {
                                $('#instanceStatusDes').html("<i class='mdui-icon material-icons mdui-text-color-green'>play_circle_filled</i> 客户端探测" + powerData['des'])
                              }else {
                                $('#instanceStatusDes').html("<i class='mdui-icon material-icons mdui-text-color-red'>error</i> 客户端探测" + powerData['des'])
                              }
                          } else {
                            $('#instanceStatusDes').html("<i class='mdui-icon material-icons mdui-text-color-red'>error</i> 客户端状态异常")
                          }
                    }
                    });
                </script>
                {/if}
                <div class="mdui-card-actions">
                    <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme" mdui-dialog="{target: '#yangLogininfoDialog'}"><i class="mdui-icon material-icons">add_circle_outline</i> 查看默认登录信息</button>
                    {include file="yangcuts/product_logininfo"}
                    <button class="mdui-btn mdui-btn-raised" mdui-tooltip="{content: '修改当前实例备注'}" mdui-dialog="{target: '#yangModifyRemarkDialog'}"><i class="mdui-icon material-icons">create</i> 修改实例备注信息</button>
                    {include file="yangcuts/product_modifyremark"}
                    <button type="button" class="mdui-btn mdui-btn-raised" id="renew"
                      onclick="renew($(this), '{$Think.get.id}')"><i class="mdui-icon material-icons">alarm_add</i> 续费实例</button>
                </div>
            </div>
            
            
            {include file="yangcuts/product_actions"}
    
            {include file="yangcuts/product_needhelp"}
            
            
        </div>
        
        <div class="mdui-col-xs-12 mdui-col-sm-4">
        
            {include file="yangcuts/product_autorenew"}
        
            {include file="yangcuts/product_billingdetails"}
            
            
        </div>
    </div>

			{include file="yangcuts/product_upgrade_tab"}
			
            {include file="yangcuts/product_finance_tab"}
            
            {include file="yangcuts/product_log_tab"}
            
            {include file="yangcuts/product_delete_tab"}
            
            
            {if $Detail.download_data}
            <div class="mdui-row" id="download">
              {include file="servicedetail/servicedetail-download"}
            </div>
            {/if}
            
            
            
            {include file="yangcuts/product_other_tab"}
            




  <div class="deactivateDia" style="display: none;">
    <form>
      <input type="hidden" value="{$Token}" />
      <input type="hidden" name="id" value="{$Think.get.id}" />
      <div class="form-group row mb-4">
        <label class="col-sm-3 col-form-label text-right">{$Lang.cancellation_time}</label>
        <div class="col-sm-8">
          <select class="form-control" class="second_type" name="type">
            <option value="Immediate">{$Lang.remarks_infors}立即</option>
            <option value="Endofbilling" selected>{$Lang.billing_cycle}</option>
          </select>
        </div>
      </div>
      <div class="form-group row mb-0">
        <label class="col-sm-3 col-form-label text-right">{$Lang.cancelreason}</label>
        <div class="col-sm-8">
          <div class="input-group">
            <select class="form-control" class="second_type" name="reason">
              {foreach $Detail.cancelist as $item}
              <option value="{$item.reason}">{$item.reason}</option>
              {/foreach}
            </select>
          </div>
        </div>
    </form>
  </div>
  
</div>


{include file="includes/cancelrequire"}
<script src="/themes/clientarea/default/assets/libs/clipboard/clipboard.min.js?v={$Ver}"></script>