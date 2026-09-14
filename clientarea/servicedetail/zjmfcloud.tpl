
{include file="includes/cancelrequire"}
{include file="includes/pop"}
{include file="yangcuts/product_service_module_button"}
<!--  -->
<div class="container-fluid">
    <div class="mdui-card mdui-tab mdui-tab-scrollable" mdui-tab>
        <a href="#yang-general-info" class="mdui-ripple" data-toggle="tab">实例概览</a>
        {if $Detail.module_chart || $Detail.host_data.show_traffic_usage}
        <a href="#charts" id="charts-tab-act" class="mdui-ripple" data-toggle="tab">监控图表</a>
        {/if}
        <a href="#power-tab" class="mdui-ripple" data-toggle="tab">电源管理</a>
        <a href="#reinstall" class="mdui-ripple" data-toggle="tab">实例重置</a>
        <a href="#vnc-tab" class="mdui-ripple" data-toggle="tab">VNC</a>
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
                    <p><strong>实例状态：</strong>
                    {if $Detail.module_power_status == 1}
                        <i class='mdui-icon material-icons mdui-text-color-green'>play_circle_filled</i> 财务端监控正常
                    {else}
                        <i class='mdui-icon material-icons mdui-text-color-red'>error</i> 财务端监控异常
                    {/if}
                    </p>
                    <p>{if $Detail.host_data.format_nextduedate.msg == '不到期'}当前实例永不到期{else}<strong>当前实例可用时长：</strong>{$Detail.host_data.format_nextduedate.msg}（一直到{$Detail.host_data.nextduedate|date="Y-m-d H:i"}）{/if}</p>
                    {if $Cancel.host_cancel}<p class="mdui-text-color-red">您设置了此实例{$Lang.stop_when_due}释放，请留意已备份资源。</p>{/if}
                    
                </div>
                <script>
                $.ajax({
                    type: "GET",
                    url: '/v1/hosts/{$Detail.host_data.id}/module/status?type=host',
                    success: function(data) {
                        if (powerData = data.data) {
                          if (powerData['status'] == 'on') {
                            $("#instanceStatusDes").html("<i class='mdui-icon material-icons mdui-text-color-green'>play_circle_filled</i> " + powerData['des'])
                            $("#instancePowerDes").html("<i class='mdui-icon material-icons mdui-text-color-green'>play_circle_filled</i> " + powerData['des'])
                          }else {
                            $("#instanceStatusDes").html("<i class='mdui-icon material-icons mdui-text-color-red'>error</i> " + powerData['des'])
                            $("#instancePowerDes").html("<i class='mdui-icon material-icons mdui-text-color-red'>error</i> " + powerData['des'])
                          }
                      } else {
                        $("#instanceStatusDes").html("<i class='mdui-icon material-icons mdui-text-color-red'>error</i> 暂时无法获取")
                        $("#instancePowerDes").html("<i class='mdui-icon material-icons mdui-text-color-red'>error</i> 暂时无法获取")
                      }
                    }
                });
                </script>
                <div class="mdui-card-actions">
                    <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme" mdui-dialog="{target: '#yangLogininfoDialog'}"><i class="mdui-icon material-icons">add_circle_outline</i> 查看默认登录信息</button>
                    {include file="yangcuts/product_logininfo"}
                    <button class="mdui-btn mdui-btn-raised" mdui-tooltip="{content: '修改当前实例备注'}" mdui-dialog="{target: '#yangModifyRemarkDialog'}"><i class="mdui-icon material-icons">create</i> 修改实例备注信息</button>
                    {include file="yangcuts/product_modifyremark"}
                    <button type="button" class="mdui-btn mdui-btn-raised" id="renew"
                      onclick="renew($(this), '{$Think.get.id}')"><i class="mdui-icon material-icons">alarm_add</i> 续费实例</button>
                </div>
            </div>
            
            
            <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        服务器管理
                    </div>
                </div>
                <div class="mdui-card-content">
                    {if $Detail.host_data.dedicatedip}
                      <p><strong>主要独立 IP：</strong>
                      {if $Detail.host_data.assignedips}
                        {foreach $Detail.host_data.assignedips as $ip}
                        <span>【{$ip}】</span>
                        {/foreach}
                        (共 {$Detail.host_data.assignedips|count} 个 IP 地址已绑定到此实例)
                      {else}
                      <span id="yangCopyipTarget">{$Detail.host_data.dedicatedip}</span>
                      <button id="yangCopyip" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '复制IP'}"><i class="mdui-icon material-icons">content_copy</i></button>
                      {/if}
                      </p>
                        <script>
                        yangClipboardip = new ClipboardJS('#yangCopyip', {
                          text: function (trigger) {
                            return $('#yangCopyipTarget').text()
                          },
                          container: document.getElementById('yangCopyip')
                        });
                        yangClipboardip.on('success', function (e) {
                          mdui.snackbar({
                              message: '您已成功复制IP。'
                            });
                        })
                        </script>
                    {/if}
                    <div id="cloud_nat">
                    {if $Detail.dcimcloud.nat_acl || $Detail.host_data.dedicatedip == 0}
                    <p><strong>NAT 远程地址：</strong><span id="nat_aclBox">{$Detail.dcimcloud.nat_acl}{if $CustomDepot.yangmdui_clientnat}正在获取中...{/if}</span></p>
                    {/if}
                    {if $Detail.dcimcloud.nat_web}
                    <p><strong>NAT 建站地址：</strong><span id="nat_webBox">{$Detail.dcimcloud.nat_web}</span></p>
                    {/if}
                    {if $Detail.dcimcloud.nat_acl || $Detail.dcimcloud.nat_web || $Detail.host_data.dedicatedip == 0}
                    <p>(NAT 是一种通过共享 IP 转发数据包实现非公网 IP 实例数据交互的方法，您需要在“NAT 转发”选项卡中设置转发规则，才能从外网访问此实例内部端口上的业务)</p>
                    {/if}
                    </div>
                    <p><strong>系统镜像：</strong>{$Detail.host_data.os}</p>
                    <p><strong>默认用户名：</strong>{$Detail.host_data.username}</p>
                    <p>转到“电源管理”页面进行实例电源管理。</p>
                </div>
            </div>
            
            {include file="yangcuts/product_actions"}
    
            {include file="yangcuts/product_needhelp"}
            
        </div>
        
        <div class="mdui-col-xs-12 mdui-col-sm-4">
        
            <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                <div class="mdui-card-primary">
                    <div id="instanceStatusDes" class="mdui-card-primary-title">
                        获取电源状态中……
                    </div>
                    <div class="mdui-card-primary-subtitle">快速电源操作</div>
                </div>
                <div class="mdui-card-content">
                    <p><a class="mdui-btn mdui-btn-raised mdui-btn-dense mdui-color-light-green" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="on" data-type="default" data-desc="开机"><i class="mdui-icon material-icons">power_settings_new</i> 开机</a>
                    <a class="mdui-btn mdui-btn-raised mdui-btn-dense mdui-color-orange" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="off" data-type="default" data-desc="关机"><i class="mdui-icon material-icons">power</i> 关机</a>
                    <a class="mdui-btn mdui-btn-raised mdui-btn-dense" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="reboot" data-type="default" data-desc="重启"><i class="mdui-icon material-icons">refresh</i> 重启</a></p>
                    <p>硬关机和其他 DCIM 操作请访问“电源管理”选项卡。</p>
                </div>
            </div>
        
            <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        当前用量
                    </div>
                </div>
                <div class="mdui-card-content">
                    <span>
                        CPU使用率：<span id="yang-mdui-cpu-lable">获取中</span>
                        <div class="mdui-progress">
                            <div id="yang-mdui-cpu-progress" class="mdui-progress-indeterminate"></div>
                        </div>
                    </span>
                    <span>
                        内存使用率：<span id="yang-mdui-mem-lable">获取中</span>
                        <div class="mdui-progress">
                            <div id="yang-mdui-mem-progress" class="mdui-progress-indeterminate"></div>
                        </div>
                    </span>
                    {if ($Detail.host_data.domainstatus == 'Active' || ($Detail.host_data.domainstatus == 'Suspended' && $Detail.host_data.suspendreason_type == 'flow')) && $Detail.host_data.bwlimit > 0}
                        <span>
                        月流量：<span id="yang-mdui-flow-lable">获取中</span>
                        <div class="mdui-progress">
                            <div id="yang-mdui-flow-progress" class="mdui-progress-indeterminate"></div>
                        </div>
                    </span>
                    <button type="button" class="mdui-btn mdui-btn-raised" id="orderFlowBtn"
                onclick="orderFlow($(this), '{$Think.get.id}')">订购流量</button>
                    {/if}
                </div>
                    <script>
                    $.ajax({
                        type: "GET",
                        url: '/v1/hosts/{$Detail.host_data.id}/module/charts?type=cpu',
                        success: function(data) {
                            if (cpuData = data.data.list[0]) {
                              cpuDataLength = cpuData.length
                              cpuDataLatest = cpuData[cpuDataLength - 1].value
                              $("#yang-mdui-cpu-progress").css("width",cpuDataLatest + "%")
                              $("#yang-mdui-cpu-lable").html(cpuDataLatest + "%")
                              if (cpuDataLatest > 85) {
                                $("#yang-mdui-cpu-progress").addClass('mdui-color-red')
                              } else if (cpuDataLatest > 65) {
                                $("#yang-mdui-cpu-progress").addClass('mdui-color-orange')
                              } else {
                                $("#yang-mdui-cpu-progress").addClass('mdui-color-green')
                              }
                            } else {
                              $("#yang-mdui-cpu-progress").css("width","0%")
                              $("#yang-mdui-cpu-lable").html("暂无数据，请稍后再试")
                            }
                              $("#yang-mdui-cpu-progress").removeClass('mdui-progress-indeterminate')
                              $("#yang-mdui-cpu-progress").addClass('mdui-progress-determinate')
                            },
                        error: function(data) {
                            $("#yang-mdui-cpu-progress").css("width","0%")
                            $("#yang-mdui-cpu-lable").html("暂无数据，请稍后再试")
                            $("#yang-mdui-cpu-progress").removeClass('mdui-progress-indeterminate')
                            $("#yang-mdui-cpu-progress").addClass('mdui-progress-determinate')
                        }
                        });
                    </script>
                    <script>
                        $.ajax({
                        type: "GET",
                        url: '/v1/hosts/{$Detail.host_data.id}/module/charts?type=memory',
                        success: function(data) {
                            memUnit = data.data.unit
                            memallData = data.data.list[0]
                            memallDataLength = memallData.length
                            memallDataLatest = memallData[memallDataLength - 1].value
                            memnowData = data.data.list[1]
                            memnowDataLength = memnowData.length
                            memnowDataLatest = memnowData[memnowDataLength - 1].value
                            memDisplay = 100 * memnowDataLatest / memallDataLatest
                            $("#yang-mdui-mem-progress").css("width",memDisplay + "%")
                            $("#yang-mdui-mem-lable").html(memnowDataLatest + memUnit + " / " + memallDataLatest + memUnit + " (" + Math.round(memDisplay) + "%)")
                            if (memDisplay > 75) {
                                $("#yang-mdui-mem-progress").addClass('mdui-color-red')
                            } else if (memDisplay > 60) {
                                $("#yang-mdui-mem-progress").addClass('mdui-color-orange')
                            } else {
                                $("#yang-mdui-mem-progress").addClass('mdui-color-green')
                            }
                            $("#yang-mdui-mem-progress").removeClass('mdui-progress-indeterminate')
                            $("#yang-mdui-mem-progress").addClass('mdui-progress-determinate')
                        },
                        error: function(data) {
                            $("#yang-mdui-mem-progress").css("width","0%")
                            $("#yang-mdui-mem-lable").html("暂无数据，请稍后再试")
                            $("#yang-mdui-mem-progress").removeClass('mdui-progress-indeterminate')
                            $("#yang-mdui-mem-progress").addClass('mdui-progress-determinate')
                        }
                        });
                    </script>
                    <script>
                      const obj = {
                        host_id: '{$Think.get.id}'
                      }
                      $.ajax({
                        type: "get",
                        url: '' + '/host/dedicatedserver',
                        data: obj,
                        success: function (data) {
                          const totalFlow = data.data.host_data.bwlimit
                          const usedFlow = data.data.host_data.bwusage.toFixed(1)
                          const remainingFlow = (totalFlow - usedFlow).toFixed(1)
                          let percentUsed = parseInt((usedFlow / totalFlow) * 100) || 0
                            {if ($Detail.host_data.domainstatus == 'Active' || ($Detail.host_data.domainstatus == 'Suspended' && $Detail.host_data.suspendreason_type == 'flow')) && $Detail.host_data.bwlimit > 0}
                            $('#yang-mdui-flow-progress')
                            .css('width', percentUsed + '%')
                            $('#yang-mdui-flow-progress').removeClass('mdui-progress-indeterminate')
                            $('#yang-mdui-flow-progress').addClass('mdui-progress-determinate')
                            $('#yang-mdui-flow-lable').text('已用' + `${usedFlow > 1024 ? ((usedFlow / 1024).toFixed(2) + 'TB') : (usedFlow + 'GB')}` + ' / 总计' + `${totalFlow > 1024 ? ((totalFlow / 1024).toFixed(2) + 'TB') : (totalFlow + 'GB')}` + ' (' + percentUsed + '%)');
                        {/if}
                        }
                      });
                    </script>
            </div>
        
            {include file="yangcuts/product_autorenew"}
        
            {include file="yangcuts/product_billingdetails"}
            
            
        </div>
    </div>

<!-- Tab panes -->
            {if $Detail.module_chart}
            <div class="mdui-row" id="charts">
                <div class="mdui-col-xs-12">
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                图表
                            </div>
                        </div>
                        <div class="mdui-card-content">
                            <div style="min-height: 550px;" class="tab-pane">
                            {include file="includes/chart"}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {/if}

            <div class="mdui-row" id="vnc-tab">
                <div class="mdui-col-xs-12">
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                VNC
                            </div>
                        </div>
                        <div class="mdui-card-content">
                            VNC 可用于直接与主控端沟通，从而操作虚拟机命令行。这在实例失去公网连接等情况非常有用。不过，我们不建议您以 VNC 为日常维护实例的方式，请您配置 SSH 连接来获取更高效的体验。
                        </div>
                        <div class="mdui-card-actions">
                            <button class="mdui-btn mdui-btn-raised mdui-color-theme" onclick="yangmduivnc();"{if $Detail.module_power_status != 1} disabled{/if}>启动 VNC</button>
                            <a class="mdui-btn mdui-btn-raised" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="vnc" data-type="default" data-desc=""{if $Detail.module_power_status != 1} disabled{/if}>从外部启动 VNC</a>
                        </div>
                    </div>
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                VNC 页面
                            </div>
                        </div>
                        <div class="mdui-card-content" id="yang-mdui-vnc-content">
                            {if $Detail.module_power_status == 1}
                                为了您的数据安全，VNC 启动需要进行身份验证。请先点击按钮启动 VNC。
                            {else}
                                当前实例电源状态异常，请开机后启动 VNC。
                            {/if}
                        </div>
                    </div>
                </div>
                <script>
                    function yangmduivnc() {
                        $.ajax({
                          type: "POST",
                          url: '' + '/provision/default',
                          data: {
                            id: '{$Think.get.id}',
                            func: 'vnc'
                          },
                          success: function (data) {
                            $('#yang-mdui-vnc-content').html("<iframe src='" +data['data']['url']+"' width='100%' height='800'></iframe>");
                          }
                        });
                    }
                </script>
            </div>

            <div class="mdui-row" id="reinstall">
                <div class="mdui-col-xs-12">
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                重装系统
                            </div>
                        </div>
                        <div class="mdui-card-content">
                            <p>实例当前安装的系统为 {$Detail.host_data.os}。</p>
                            <p>您可以立即重装系统，但是<b class="mdui-text-color-red">这将抹除您实例系统盘上的所有数据</b>。</p>
                            <p>请确认您已经完成数据备份，并解除挂载数据盘。</p>
                        </div>
                        <div class="mdui-card-actions">
                            <a class="mdui-btn mdui-btn-raised mdui-color-red" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="reinstall" data-type="default" data-desc="重装系统">重装系统</a>
                        </div>
                    </div>
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                重置密码
                            </div>
                        </div>
                        <div class="mdui-card-content">
                            <p>您可为当前 {$Detail.host_data.os} 实例上的 {$Detail.host_data.username} 账户重置密码。</p>
                            <p>这不会删除用户数据。</p>
                        </div>
                        <div class="mdui-card-actions">
                            <a class="mdui-btn mdui-btn-raised mdui-color-theme" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="crack_pass" data-type="default" data-desc="重置密码">重置密码</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="mdui-row" id="power-tab">
                <div class="mdui-col-xs-12">
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                电源管理
                            </div>
                        </div>
                        <div class="mdui-card-content">
                            <p>当前实例电源状态：
                                <span id="instancePowerDes">获取电源状态中……</span>
                            </p>
                            <p>您可以操作此实例的电源状态。</p>
                        </div>
                    </div>
                    
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                DCIM 普通操作
                            </div>
                        </div>
                        <div class="mdui-card-content">
                            <p><a class="mdui-btn mdui-btn-raised mdui-color-light-green" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="on" data-type="default" data-desc="开机"><i class="mdui-icon material-icons">power_settings_new</i> 开机</a> - 向主控发送一则开机请求，节点会立即尝试启动虚拟机。</p>
                            <p><a class="mdui-btn mdui-btn-raised mdui-color-orange" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="off" data-type="default" data-desc="关机"><i class="mdui-icon material-icons">power</i> 关机</a> - 向主控发送一则关机请求，节点会通知系统进行关机，并由您的虚拟机系统自行处理关机流程。</p>
                            <p><a class="mdui-btn mdui-btn-raised" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="reboot" data-type="default" data-desc="重启"><i class="mdui-icon material-icons">refresh</i> 重启</a> - 向主控发送一则重启请求，节点会通知系统进行重启，并由您的虚拟机系统自行处理重启流程。此过程节点不会中断虚拟机硬件流程。</p>
                        </div>
                    </div>
                    
                    <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title">
                                DCIM 电源操作
                            </div>
                        </div>
                        <div class="mdui-card-content">
                            <p><a class="mdui-btn mdui-btn-raised mdui-color-red" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="hard_off" data-type="default" data-desc="硬关机"><i class="mdui-icon material-icons">power</i> 硬关机</a> - 向主控发送一则关机请求，节点立即中断虚拟机硬件流程。<b class="mdui-text-color-red">这可能对实例上的数据造成不可逆损坏。</b></p>
                            <p><a class="mdui-btn mdui-btn-raised mdui-color-red" href="javascript:void(0);" onclick="yang_service_module_button($(this), '{$Detail.host_data.id}', 'dcimcloud')" data-func="hard_reboot" data-type="default" data-desc="硬重启"><i class="mdui-icon material-icons">refresh</i> 硬重启</a> - 向主控发送一则关机请求，节点立即中断虚拟机硬件流程，并尝试以正常方式启动虚拟机。<b class="mdui-text-color-red">这可能对实例上的数据造成不可逆损坏。</b></p>
                            
                            <div class="mdui-panel" mdui-panel>
                                <div class="mdui-panel-item">
                                    <div class="mdui-panel-item-header">
                                        <div class="mdui-panel-item-title">什么情况下使用硬关机？</div>
                                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                                    </div>
                                    <div class="mdui-panel-item-body">
                                        <p><b class="mdui-text-color-red">请确认必要时再使用硬关机操作，因为这可能对实例上的数据造成不可逆损坏。</b></p>
                                        <p>1、虚拟机系统出现错误导致无法正常登录，且需要关机后重新配置系统挂载的。</p>
                                        <p>2、极端程序错误导致占用飙升，无法通过正常关机指令进行关机的。</p>
                                    </div>
                                </div>
                                <div class="mdui-panel-item">
                                    <div class="mdui-panel-item-header">
                                        <div class="mdui-panel-item-title">硬关机损坏数据的概率大吗？</div>
                                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                                    </div>
                                    <div class="mdui-panel-item-body">
                                        <p>由于是虚拟机实例，硬关机是否损坏数据视情况而定。数据损坏一般都是进行文件读写时，未完成读写工作而突然关机导致的。</p>
                                        <p><b class="mdui-text-color-red">不要用您的数据开玩笑。</b></p>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
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



<script>
  // 用量tabs

  let usedChart = null

  let usedStartTime

  let usedEndTime



  $(document).ready(function () {
    //chartOption()

    if ($('#startingTime,#endTime').length > 0) getData()

    window.addEventListener('resize', function () {

      if (usedChart) usedChart.resize()

    })



    $('#usedLi').on('click', function () {

      if (usedChart) {
        setTimeout(function () {

          usedChart.resize()

        }, 0);
      }

    });


    $('#startingTime,#endTime').change(function () {

      usedStartTime = $('#startingTime').val()

      usedEndTime = $('#endTime').val()

      getData()

    });

    // 获取数据

    async function getData() {
      usedChart = echarts.init(document.getElementById('usedChartBox'))

      usedChart.showLoading({

        text: '数据正在加载...',

        color: '#999',

        textStyle: {

          fontSize: 30,

          color: '#444'

        },

        effectOption: {

          backgroundColor: 'rgba(0, 0, 0, 0)'

        }

      })

      const obj = {

        id: '{$Think.get.id}',

        start: usedStartTime,

        end: usedEndTime

      }

      $.ajax({

        type: "get",

        url: '/host/trafficusage',

        data: obj,

        success: function (data) {

          usedChart.hideLoading()

          if (data.status !== 200) return false

          const xAxisData = []

          const seriesData = [];
          const seriesData2 = [];

          (data.data || []).forEach(item => {

            xAxisData.push(item.time)
            seriesData.push(item.in)
            seriesData2.push(item.out)

          })

          usedChart = echarts.init(document.getElementById('usedChartBox'))

          usedChart.setOption({
            backgroundColor: '#fff',
            title: {
              subtext: '',
              left: 'center',
              textAlign: 'left',
              subtextStyle: {
                lineHeight: 250
              }
            },
            tooltip: {
              backgroundColor: '#fff',
              padding: [10, 20, 10, 8],
              textStyle: {
                color: '#000',
                fontSize: 12
              },
              trigger: 'axis',
              axisPointer: {
                type: 'line',
                lineStyle: {
                  color: '#7dcb8f'
                }
              },
              formatter: function (params, ticket, callback) {
                //console.log('bar:', params)
                const res = `
          <div>
              <div>接收流量(GB)：${params[0].value} </div>                
              <div>发送流量(GB)：${params[1].value}</div>
              <div>${params[0].axisValue}</div>
          </div>`
                return res
              },
              extraCssText: 'box-shadow: 0px 4px 13px 1px rgba(1, 24, 167, 0.1);'
            },
            grid: {
              left: '80',
              top: 30,
              x: 70,
              x2: 50,
              y2: 80
            },
            dataZoom: [ // 缩放
              {
                type: 'inside',
                throttle: 50
              }
            ],
            xAxis: {
              offset: 15,
              axisLabel: {
                show: true,
                textStyle: {
                  color: '#999'
                }
              },
              type: 'category',
              // 改变x轴颜色
              axisLine: {
                lineStyle: {
                  type: 'dashed',
                  color: '#ddd',
                  width: 1
                }
              },
              // data: ['2020-08-11 11:30:00', '2020-08-11 11:30:00', '2020-08-11 11:30:00', '2020-08-11 11:30:00', '2020-08-11 11:30:00', '2020-08-11 11:30:00', '2020-08-11 11:30:00', '2020-08-11 11:30:00', '2020-08-11 11:30:00'].map(function (str) {
              //   return str.replace(' ', '\n')
              // })
              data: xAxisData
            },
            yAxis: {
              axisTick: {
                show: false // 轴刻度不显示
              },
              axisLine: {
                show: false
              },
              axisLabel: {
                show: true,
                textStyle: {
                  color: '#999'
                },
                //  formatter: '{value}' + 'GB'
              },
              // 轴网格
              splitLine: {
                show: true,
                lineStyle: {
                  color: '#ddd',
                  type: 'dashed'
                }
              }

            },
            series: [{
                name: '21',
                type: 'bar',
                stack: '接收流量',
                barGap: '-100%',
                //data: [136, 132, 101, 134, 90, 230, 210, 100, 300],
                data: seriesData,
                itemStyle: {
                  barBorderRadius: [5, 5, 0, 0],
                  color: '#737dff'
                }
              },
              {
                name: '2',
                type: 'bar',
                stack: '使用流量',
                // data: [964, 182, 191, 234, 290, 330, 310, 100, 500],
                data: seriesData2,
                itemStyle: {
                  barBorderRadius: [5, 5, 0, 0],
                  color: '#ccc',
                  opacity: 0.3
                }
              }
            ]
          })

          // 如果初始查询没有时间, 则设置默认时间为返回数据的第一个和最后一个时间

          if (!usedStartTime || !usedEndTime) {

            if (data.data.length) {

              usedStartTime = new Date().getFullYear() + '-' + data.data[0].time

              usedEndTime = new Date().getFullYear() + '-' + data.data[data.data.length - 1].time

              $('#startingTime').val(data.data[0].time);

              $('#endTime').val(data.data[data.data.length - 1].time);

            }

          }

        }

      });

    }



    // 分辨率改变, 重绘图表

    function resize() {

      usedChart.resize()

    }



    // 时间选择改变

    function dateChange() {

      const startTimeStamp = new Date(usedStartTime).getTime()

      const endTimeStamp = new Date(usedEndTime).getTime()

      if (usedStartTime && usedEndTime && startTimeStamp < endTimeStamp) {

        getData()

      }

    }
  })
</script>

