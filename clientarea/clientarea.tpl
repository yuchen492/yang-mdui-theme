<script>var totalActiveHost = 0;</script>
<div class="mdui-row mdui-center">
    
    {include file="yangcuts/new_user_wcc"}
    {include file="yangcuts/new_user_guide"}
<!-- 氧MDUI左栏 开始 -->
<div class="mdui-col-xs-12 mdui-col-sm-8">

    <!-- 最新公告卡片，自动获取最新一条，无需修改 -->
    
        {if $ClientArea.index.news.0}

        <div class="mdui-card mdui-m-b-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title"><i class="mdui-icon material-icons">new_releases</i> {$ClientArea.index.news.0.title}</div>
                <div class="mdui-card-primary-subtitle">最新公告</div>
            </div>
            <div class="mdui-card-content">
            
                {$ClientArea.index.news.0.description}
            
            </div>
            <div class="mdui-card-actions">
                <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme" href="{$Setting.web_url}/newsview?id={$ClientArea.index.news.0.id}">阅读详细</a>
            </div>
        </div>
        
        {/if}


    <!-- 已激活实例卡片 -->

        <div class="mdui-card mdui-m-b-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">已激活实例</div>
                <div class="mdui-card-primary-subtitle" id="totalActiveHostLable">此{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}账户已激活 {$ClientArea.Total} 个实例，共 {$ClientArea.index.host} 个实例</div>
            </div>
            <div class="mdui-card-content">
                {if $ClientArea.Total}
                    {foreach $ClientArea.index.host_nav as $list}
                        <a href="service?groupid={$list.id}&domain_status[]=Active" class="mdui-btn mdui-btn-raised mdui-ripple">
                        <span>
                            {$list.groupname}
                        </span>
                        <span>({$list.count}个实例)</span>
                        </a>
                    {/foreach}
                {else}
                    <div class="mdui-typo-caption-opacity">千里之行，始于足下。</div>
                {/if}
            
            </div>
            <div class="mdui-card-actions">
                <button class="mdui-btn mdui-btn-icon mdui-float-right" mdui-tooltip="{content: '有的产品购买后不显示：可能是自动交付出了问题。一般等待片刻即可，您也可以选择发工单要求得到运维团队的帮助。'}"><i class="mdui-icon material-icons">help</i></button>
            </div>
        </div>
        
        <div class="mdui-card mdui-m-b-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">快速管理</div>
                <div class="mdui-card-primary-subtitle">列出您当前重点实例资源</div>
            </div>
            <div class="mdui-card-content" id="sourceListBox">
                <div class="mdui-spinner mdui-spinner-colorful"></div> 数据很快列出，请稍等……
            </div>
        </div>
        <script>
          $(function () {
            getSourceList()
          })
        
          function getSourceList() {
            $('#sourceListBox').html(`<div class="mdui-spinner mdui-spinner-colorful"></div> 数据正在加载，请稍后……`)
            $.ajax({
              type: "get",
              url: '/clientarea',
              data: {
                action: 'list'
              },
              success: function (data) {
                $('#sourceListBox').html(data)
                {if $CustomDepot.yangmdui_bootstrap_support == "true"}
                yangmdui_bst();
                {/if}
              }
            });
          }
        
        </script>

        

{if $CustomDepot.yangmdui_afftable == "true"}

    <div class="mdui-card mdui-m-b-1 mdui-hoverable">
        <div class="mdui-card-primary">
            <div class="mdui-card-primary-title"><i class="mdui-icon material-icons">monetization_on</i> 推介计划</div>
        </div>
        <div class="mdui-card-content">
            <p>{if $ClientArea.aff_msg.affStatus == "1"}您已激活推介计划。{else}您尚未激活推介计划。{/if}</p>
            <p>通过{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}推介计划，邀请您的好友体验{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}服务，您和您的好友都可以获得收益。收益可以提现到{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}或支付宝或微信。</p>
            {if $CustomDepot.yang_aff_rank_addid}
            
            <p>推介神人榜：</p>
            <iframe scrolling="no" frameborder="0" style="width:100%;height:550px;" src="{:shd_addon_url('YangAffRank://YangAffRank/index', $vars = [], true)}"></iframe>
            {/if}
            
        </div>
        <div class="mdui-card-actions">
            <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-orange-a100" href="/affiliates" mdui-tooltip="{content: '转到推介计划页面，邀请新用户注册并购置产品获得大量返利'}"><i class="mdui-icon material-icons">attach_money</i> 邀新赚钱</a>
        </div>
    </div>

{/if}
    
    

            <div class="mdui-card mdui-m-b-1 mdui-hoverable">
              <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">公告</div>
                <div class="mdui-card-primary-subtitle">适用于{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}的公告</div>
              </div>
              <div class="mdui-card-content">
              
                  <div class="user-center_notice h100p">
                    <ul class="user-center_notice_ul pl-0">
                      {if $ClientArea.index.news}
                      {foreach $ClientArea.index.news as $list}
                      <li class="user-center_notice_item">
                        <span class="notice_item_time text-black-50">{$list.push_time|date="Y-m-d H:i"}</span>
                        <a href="newsview?id={$list.id}" class="notice_item_title">{$list.title}</a>
                      </li>
                      {/foreach}
                      {else}
                      <tr>
                        <td colspan="2">
                          <div class="no-data">{$Lang.nothing}</div>
                        </td>
                      </tr>
                      {/if}
                    </ul>
                  </div>
              
              </div>
              <div class="mdui-card-actions">
                <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme" href="/news">查看全部</a>
              </div>
            </div>
        </div>
        

      
      
      
<div class="mdui-col-xs-12 mdui-col-sm-4">

        <div class="mdui-card mdui-m-b-1 mdui-hoverable">
          <div class="mdui-card-header">
            {if $Userinfo.user.qq}
            <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk={$Userinfo.user.qq}&s=640"/>
            {else}
            <div class="mdui-card-header-avatar mdui-typo-display-1">
                {if preg_match("/^[0-9]*[A-Za-z]+$/is", substr($Userinfo.user.username,0,1))}
                {$Userinfo.user.username|substr=0,1|upper}
                {elseif preg_match("/^[\x7f-\xff]*$/", substr($Userinfo.user.username,0,3))}
                {$Userinfo.user.username|substr=0,3}
                {else}
                {$Userinfo.user.username|substr=0,1|upper}
                {/if}
            </div>
            {/if}
            
            <div class="mdui-card-header-title">
                {$Userinfo.user.username}
                {if $Userinfo.user.certifi.status!=1}
                    <div class="mdui-chip">
                        <span class="mdui-chip-title">未实名</span>
                    </div>
                {else}
                    <div class="mdui-chip mdui-color-theme-accent">
                        <span class="mdui-chip-title">已实名</span>
                    </div>
                {/if}
            </div>
            <div class="mdui-card-header-subtitle">当前登录账户 ID {$Userinfo.user.id}</div>
          </div>
          <div class="mdui-card-content">
            欢迎访问{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}！<br />
            {if $Userinfo.user.email}<strong>绑定邮箱</strong> {$Userinfo.user.email}<br />{/if}
            {if $Userinfo.user.phonenumber}<strong>联系电话</strong> {$Userinfo.user.phonenumber|substr=0,3}***{$Userinfo.user.phonenumber|substr=7}<br />{/if}
            {if $Userinfo.user.qq}<strong>联系 QQ</strong> {$Userinfo.user.qq}{/if}
            
          </div>
          <div class="mdui-card-actions">
            <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme" href="/details" mdui-tooltip="{content: '在这里可以设置您的账户基础信息'}"><i class="mdui-icon material-icons">settings</i> 账户信息</a>
            <a class="mdui-btn mdui-btn-raised mdui-ripple" href="/security" mdui-tooltip="{content: '在这里更改密码或绑定邮箱，提高账户安全性'}"><i class="mdui-icon material-icons">security</i> 安全设置</a>
            <a class="mdui-btn mdui-btn-raised mdui-ripple" href="/apimanage" mdui-tooltip="{content: '管理当前{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}账户兼容智简魔方的接口服务'}"><i class="mdui-icon material-icons">all_inclusive</i> API</a>
          </div>
        </div>
        

    

        <div class="mdui-card mdui-m-b-1 mdui-hoverable">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title"><i class="mdui-icon material-icons">today</i> 待办事项</div>
          </div>
          <div class="mdui-card-content">
                
                {if $ClientArea.index.order_count > 0}
                <a class="mdui-btn mdui-btn-block mdui-text-left" href="/billing?status=Unpaid" mdui-tooltip="{content: '点击前往处理'}"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 您有 {$ClientArea.index.order_count} 个未支付订单，请及时处理。</a>
                <!--<a class="mdui-btn mdui-btn-icon mdui-btn-raised mdui-ripple mdui-color-theme-accent mdui-color-orange-a100" href="/billing" mdui-tooltip="{content: '前往处理'}"><i class="mdui-icon material-icons">arrow_forward</i></a>-->
                {else}
                <div class="mdui-btn mdui-btn-block mdui-text-left" disabled><i class="mdui-icon material-icons">check_circle</i> 很棒！您已结清所有款项。</div>
                {/if}
                
                {if $ClientArea.index.ticket_count > 0}
                <a class="mdui-btn mdui-btn-block mdui-text-left" href="/supporttickets" mdui-tooltip="{content: '点击前往处理'}"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 您有 {$ClientArea.index.ticket_count} 个待处理工单，请前往工单中心。</a>
                <!--<a class="mdui-btn mdui-btn-icon mdui-btn-raised mdui-ripple mdui-color-theme-accent mdui-color-orange-a100" href="/supporttickets" mdui-tooltip="{content: '前往处理'}"><i class="mdui-icon material-icons">arrow_forward</i></a>-->
                {else}
                <div class="mdui-btn mdui-btn-block mdui-text-left" disabled><i class="mdui-icon material-icons">check_circle</i> 不错，您暂时没有需要处理的工单。</div>
                {/if}
                
                {if $CustomDepot.yangmdui_qqgroup_number}
                    {if $Userinfo.user.qq}
                    <div class="mdui-btn mdui-btn-block mdui-text-left" disabled><i class="mdui-icon material-icons">check_circle</i> QQ 联系方式已留存。</div>
                    {else}
                    <a class="mdui-btn mdui-btn-block mdui-text-left" href="/details" mdui-tooltip="{content: '点击前往处理'}"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 您没有为您的账号关联 QQ ，请前往填写。填写 QQ 联系方式后，我们才会主动通过 QQ 向您发送业务消息。</a>
                    {/if}
                {/if}
          </div>
        </div>
        

        

        <div class="mdui-card mdui-m-b-1 mdui-hoverable">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title"><i class="mdui-icon material-icons">credit_card</i> 账户资产</div>
          </div>
          <div class="mdui-card-content">
            <p><span class="mdui-typo-display-1 mdui-text-color-theme-accent">{$Userinfo.user.credit}</span>元</p> 
            <p>(本月消费 {$ClientArea.index.intotal})<br>
            有效实例数：{$ClientArea.Total} 个实例 (本月开通 {$ClientArea.product_num_day_30} 个)</p>
            <span>
                成本预估：<span id="yangCreditPrediction">请稍后</span>
                <div class="mdui-progress">
                    <div id="yangCreditPredictionProgress" class="mdui-progress-determinate"></div>
                </div>
            </span>
            <script>
                var creditPrediction = 100 * parseFloat("{$ClientArea.index.intotal}")/parseFloat("{$ClientArea.index.client.credit}")
                creditPrediction = 100 - creditPrediction
                if (parseFloat("{$ClientArea.index.intotal}") == 0){
                    $("#yangCreditPrediction").html("暂未产生消费，无需关注成本")
                    $("#yangCreditPredictionProgress").css("width","100%")
                } else {
                    if (parseFloat("{$ClientArea.index.client.credit}") == 0){
                        $("#yangCreditPrediction").html("账户没有余额，建议提前充值")
                    } else {
                        $("#yangCreditPredictionProgress").css("width",creditPrediction + "%")
                        if (creditPrediction > 80) {
                            $("#yangCreditPrediction").html("下月成本保持较好")
                        } else {
                            $("#yangCreditPrediction").html("潜在的续费失败可能，建议提前充值")
                        }
                    }
                }
            </script>
          </div>
          <div class="mdui-card-actions">
            <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme mdui-color-blue-a400" href="/addfunds" mdui-tooltip="{content: '转到充值界面添加余额到账户，以更方便完成产品交付'}"><i class="mdui-icon material-icons">add_circle</i> 充值</a>
            <a class="mdui-btn mdui-btn-raised mdui-ripple" href="/billing" mdui-tooltip="{content: '查看此账户近期订单'}"><i class="mdui-icon material-icons">library_books</i> 消费记录</a>
          </div>
        </div>


        <div class="mdui-card mdui-m-b-1 mdui-hoverable">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title"><i class="mdui-icon material-icons">build</i> 服务支持</div>
          </div>
          <div class="mdui-card-content">
            
          <a class="mdui-btn mdui-btn-block mdui-text-left" href="/supporttickets" target="_blank" mdui-tooltip="{content: '工单是高效的服务方式，提交工单后运维团队会帮助您解决问题'}"><i class="mdui-icon material-icons">border_color</i> 工单中心</a>
          <a class="mdui-btn mdui-btn-block mdui-text-left" href="{if $CustomDepot.yangmdui_document_url}{$CustomDepot.yangmdui_document_url}{else}/knowledgebase{/if}" target="_blank" mdui-tooltip="{content: '通过查阅官网文档，可以快速了解常见问题解答'}"><i class="mdui-icon material-icons">library_books</i> 文档中心</a>
          {if $CustomDepot.yangmdui_qqgroup_url}<a class="mdui-btn mdui-btn-block mdui-text-left" href="{$CustomDepot.yangmdui_qqgroup_url}" target="_blank" mdui-tooltip="{content: '点击可快速加群'}"><i class="mdui-icon material-icons">chat</i> QQ 交流群</a>{/if}
          {if $CustomDepot.yangmdui_qqgroup_number}<div class="mdui-typo-caption-opacity">交流群号：{$CustomDepot.yangmdui_qqgroup_number}</div>{/if}
          
          
          </div>
        </div>

        
        
</div>
</div>

{if $CustomDepot.yangmdui_clientarea_notice_enable == "true"}
<script>
{if $CustomDepot.yangmdui_clientarea_notice_allowignore == "true"}
if ("{if $CustomDepot.yangmdui_clientarea_notice_content}{$CustomDepot.yangmdui_clientarea_notice_content}{else}yangDefault{/if}" != getCookie('yangMduiClientareaNotice'))
{
{/if}

    mdui.dialog({
      history: false,
      modal: false,
      title: "{if $CustomDepot.yangmdui_clientarea_notice_title}{$CustomDepot.yangmdui_clientarea_notice_title}{else}欢迎回来{/if}",
      content: "{if $CustomDepot.yangmdui_clientarea_notice_content}{$CustomDepot.yangmdui_clientarea_notice_content}{else}欢迎您登录用户中心，您可以现在开始管理您的账户资产和相关实例资源。{/if}",
      buttons: [
        {if $CustomDepot.yangmdui_clientarea_notice_allowignore == "true"}
        {
          text: "不再显示",
          onClick: function(inst){
            setCookie("yangMduiClientareaNotice","{if $CustomDepot.yangmdui_clientarea_notice_content}{$CustomDepot.yangmdui_clientarea_notice_content}{else}yangDefault{/if}",60);
          }
        },
        {/if}
        {
          text: "我知道了"
        }
      ]
    });
    
{if $CustomDepot.yangmdui_clientarea_notice_allowignore == "true"}
}
{/if}
</script>
{/if}