{foreach $Userinfo.customs as $customsfield}
    {if $customsfield.fieldname == "新人引导"}
    {if $customsfield.value == "隐藏"}
    {else}
    <!-- 引导开始 -->
        <div class="mdui-card mdui-p-y-1 mdui-hoverable">
                  <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title"><i class="mdui-icon material-icons">assistant</i> 快速引导</div>
                    <div class="mdui-card-primary-subtitle">使用 2 分钟快速上手。</div>
                  </div>
                  <div class="mdui-card-content">
         
                  
            <div class="mdui-panel mdui-panel-popout" mdui-panel="{accordion: true}">
            
              <div class="mdui-panel-item mdui-panel-item-open">
                <div class="mdui-panel-item-header">
                  <div class="mdui-panel-item-title">欢迎您！</div>
                  <div class="mdui-panel-item-summary">准备开始</div>
                  <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                </div>
                <div class="mdui-panel-item-body">
                
                  <h1>欢迎来到{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}</h1>
                  <p>很高兴在茫茫人海中遇到您！{if $CustomDepot.yangmdui_teamname}{$CustomDepot.yangmdui_teamname}{else}{$Setting.company_name}{/if}为您提供多种多样的云基础业务服务，支持在线交付。</p>
                  <p>您现在所处的位置是{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}用户中心，您有能力在这里管理您在激活的产品。</p>
                  <p>我们争取成为一个值得您信赖的云服务提供者。在这里，我们准备了一篇 2 分钟快速引导，帮助您快速上手。</p>
                  <p>展开下方其他卡片，可以按流程体验到账户设置和白嫖产品、管理入门。</p>
                  
            
                </div>
              </div>
            
              <div class="mdui-panel-item">
                <div class="mdui-panel-item-header">
                  <div class="mdui-panel-item-title">完善账户信息</div>
                  <div class="mdui-panel-item-summary">检查账户安全性</div>
                  <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                </div>
                <div class="mdui-panel-item-body">
                
                  <h1>完善账户信息非常重要</h1>
                  <p>您在{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}的数据可能不会与其他{if $CustomDepot.yangmdui_teamname}{$CustomDepot.yangmdui_teamname}{else}{$Setting.company_name}{/if}用户中心同步。您需要妥善管理您的账户，保证基础的账户安全。</p>
                  <p>当前指南将指引您完善账户信息。</p>
                  
                  <p>
                  {if $Userinfo.user.email}
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 您成功绑定了电子邮箱。您绑定的电邮地址为 {$Userinfo.user.email}。请确保您信任{if $CustomDepot.yangmdui_teamname}{$CustomDepot.yangmdui_teamname}{else}{$Setting.company_name}{/if}来信地址，以接收业务邮件。</span>
                    {else}
                    <span class="mdui-text-color-orange"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 您的电子邮箱绑定有误，将无法第一时间获取业务邮件。</span>
                    <a class="mdui-btn mdui-btn-raised" href="/security" target="_blank" mdui-tooltip="{content: '点击前往绑定'}">前往绑定 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  {/if}
                  </p>
                  
                  <p>
                  {if $Userinfo.user.qq}
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 还不错，您已经填写了 QQ 联系方式。运维团队会优先联系您填写的 QQ {$Userinfo.user.qq}。活动消息您将第一时间获取！</span>
                    {else}
                    <span class="mdui-text-color-orange"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 您没有为您的账号关联 QQ 。通过填写 QQ 账号并加入{if $CustomDepot.yangmdui_teamname}{$CustomDepot.yangmdui_teamname}{else}{$Setting.company_name}{/if}用户群，您可以第一时间了解活动消息和维护新闻，帮助我们更好地为您提供服务。</span>
                    <a class="mdui-btn mdui-btn-raised" href="/details" target="_blank" mdui-tooltip="{content: '点击前往填写'}">前往填写 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  {/if}
                  </p>
                  
                  <p>
                  {if $Userinfo.user.email_remind == 1}
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 您已开启安全邮件推送功能。</span>
                    {else}
                    <span class="mdui-text-color-orange"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 蝴蝶飞舞慢悠悠。您未开启安全邮件推送，您将无法接收登录提醒，这不安全。</span>
                    <a class="mdui-btn mdui-btn-raised" href="/security" target="_blank" mdui-tooltip="{content: '点击前往开启'}">前往开启 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  {/if}
                  </p>
                  
            
                </div>
              </div>
              
              
              <div class="mdui-panel-item">
                <div class="mdui-panel-item-header">
                  <div class="mdui-panel-item-title">实例管理入门</div>
                  <div class="mdui-panel-item-summary">轻松管理您的实例</div>
                  <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                </div>
                <div class="mdui-panel-item-body">
                
                  <h1>简单上手</h1>
                  <p>{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}基础操作和多数云服务商类似，您可以轻而易举地上手管理。</p>
                  <p>本引导将帮助您开通实例，并学习管理。</p>
                  
                  <p>
                  {if $ClientArea.index.host}
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 看起来您已经开通了 {$ClientArea.index.host} 个实例。尽情享受吧！您可以在用户中心下方“管理实例”选择相关产品分组，进入内页详细管理。</span>
                    {else}
                    <span class="mdui-text-color-orange"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 您貌似还没有开通任何实例？没关系，欢迎查看我们的产品！</span>
                    <a class="mdui-btn mdui-btn-raised" href="/cart?fid=2" target="_blank" mdui-tooltip="{content: '点击浏览'}">搜寻产品 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  {/if}
                  </p>
                  
                  <p>
                  {if $Userinfo.user.credit > 0}
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 您已存储 {$Userinfo.user.credit} 元到账户余额，可用于在{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}消费。当然，您也可以随时申请退款！</span>
                    {else}
                    <span class="mdui-text-color-orange"><i class="mdui-icon material-icons mdui-text-color-orange-a400">assignment_late</i> 您可以对您的账户进行充值，用于快速完成在线产品交付。</span>
                    <a class="mdui-btn mdui-btn-raised" href="/addfunds" target="_blank" mdui-tooltip="{content: '访问充值中心'}">打开充值界面 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  {/if}
                  </p>
                  
                  <p>
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 如果您遇到任何产品问题，欢迎发起工单，您或许可以和运维成员畅快交谈！</span>
                    <a class="mdui-btn mdui-btn-raised" href="/supporttickets" target="_blank" mdui-tooltip="{content: '点击打开'}">打开工单中心 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  </p>
                  
                  
            
                </div>
              </div>
              
              
              <div class="mdui-panel-item">
                <div class="mdui-panel-item-header">
                  <div class="mdui-panel-item-title">购置付费产品</div>
                  <div class="mdui-panel-item-summary">发现{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}的价值</div>
                  <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                </div>
                <div class="mdui-panel-item-body">
                
                  <h1>探索魅力</h1>
                  <p>白嫖或是购置付费产品，{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}永远为您提供高性价比业务和高效的服务。</p>
                  <p>我们预料到您可能有以下需求，为您提供可能的解决方案。</p>
                  
                  <p>
                    <div class="mdui-tab" mdui-tab>
                      <a href="#solutions-1" class="mdui-ripple">博客与电商 Web 服务</a>
                      <a href="#solutions-2" class="mdui-ripple">多人游戏</a>
                      <a href="#solutions-3" class="mdui-ripple">标准云应用</a>
                      <a href="#solutions-4" class="mdui-ripple">轻量云托管</a>
                    </div>
                    <div id="solutions-1" class="mdui-p-a-2">
                        {if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}为您提供低成本、低运维需求的虚拟主机产品，便于操作，新手上云也可以快速部署自己的博客、电商等站点。
                        <p><i class="mdui-icon material-icons">check_circle</i> 极速开通，即买即用。</p>
                        <p><i class="mdui-icon material-icons">check_circle</i> 含独立面板，快速操作，无需服务器运维知识。</p>
                        <p><i class="mdui-icon material-icons">check_circle</i> 多地域、多节点，满足不同需求。</p>
                    </div>
                    <div id="solutions-2" class="mdui-p-a-2">
                        {if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}提供了适合多人游戏的容器云产品。相比于云服务器，容器云更轻量、成本更低，管理更加灵活。
                        <p><i class="mdui-icon material-icons">check_circle</i> 支持 MCSM 和翼龙面板。</p>
                        <p><i class="mdui-icon material-icons">check_circle</i> MineCraft 服务器极速配置。</p>
                        <p><i class="mdui-icon material-icons">check_circle</i> 在小圈中有大量占有率。</p>
                    </div>
                    <div id="solutions-3" class="mdui-p-a-2">
                        {if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}提供标准云服务器，多种配置选型，可快速交付、部署，在线管理。
                        <p><i class="mdui-icon material-icons">check_circle</i> 标准云产品。</p>
                        <p><i class="mdui-icon material-icons">check_circle</i> KVM 虚拟化、完全 Root 权限。</p>
                        <p><i class="mdui-icon material-icons">check_circle</i> 支持独立 IP 和高防。</p>
                        <p><i class="mdui-icon material-icons">check_circle</i> 支持 Windows 系统。<small>仅部分可用区支持、部分可用区需额外支付 Windows Server 授权费用。</small></p>
                    </div>
                    <div id="solutions-4" class="mdui-p-a-2">
                        {if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}新增“应用盒”产品，相当于更迷你的云服务器，适合非大量业务需求、长期云端托管的业务。
                        <p><i class="mdui-icon material-icons">check_circle</i> KVM 虚拟化、完全 Root 权限。</p>
                    </div>
                  </p>
                 
                </div>
              </div>
              
              
              <div class="mdui-panel-item">
                <div class="mdui-panel-item-header">
                  <div class="mdui-panel-item-title">增值联动服务</div>
                  <div class="mdui-panel-item-summary">在{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}追逐更多</div>
                  <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                </div>
                <div class="mdui-panel-item-body">
                
                  <h1>不止支出</h1>
                  <p>{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}有较完善的协作云和公益服务生态。您可以额外填写这些信息，完成和其他业务的联动。</p>
                  <p>这些项目不是必需的，但建议您了解。</p>
                  
                  
                  <p>
                  {if $ClientArea.aff_msg.affStatus == 1}
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 您已激活推介计划。可在{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}用户中心访问推介计划。</span>
                    {else}
                    <span><i class="mdui-icon material-icons">check_circle</i> 您可以开启推介计划，邀请新用户注册账号（仅限），领取返利抵扣消费或提现。</span>
                    <a class="mdui-btn mdui-btn-raised" href="/affiliates" target="_blank" mdui-tooltip="{content: '点击推介中心'}">前往激活 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  {/if}
                  </p>
                  
                  <p>
                  {if $Userinfo.user.api_open == 1}
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 您激活{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if} API。您可以使用兼容智简魔方的财务系统对接本控制台。</span>
                    {else}
                    <span><i class="mdui-icon material-icons">check_circle</i> 您可以开启{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if} API ，完成兼容智简魔方财务系统对接。</span>
                    <a class="mdui-btn mdui-btn-raised" href="/apimanage" target="_blank" mdui-tooltip="{content: '点击前往开启'}">前往开启 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  {/if}
                  </p>
                  
            
                </div>
              </div>
              
              
              <div class="mdui-panel-item">
                <div class="mdui-panel-item-header">
                  <div class="mdui-panel-item-title">完成引导</div>
                  <div class="mdui-panel-item-summary">可以选择隐藏此区块</div>
                  <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                </div>
                <div class="mdui-panel-item-body">
                
                  <h1>梦想的旅途继续前行</h1>
                  <p>您或许已经完成了新人指引。</p>
                  <p>{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}全体运维成员在此祝您上云愉快！我们期待着帮助为您梦想添砖加瓦。</p>
                  
                  <p>
                    <span class="mdui-text-color-green"><i class="mdui-icon material-icons">check_circle</i> 转到“个人中心”（“账户信息设置”）可寻找到关闭选项。之后，您也可以在同样位置再次回顾本引导。</span>
                    <a class="mdui-btn mdui-btn-raised" href="/details" target="_blank" mdui-tooltip="{content: '点击打开'}">打开个人中心 <i class="mdui-icon material-icons">arrow_forward</i></a>
                  </p>
                  
            
                </div>
              </div>
                        
            </div>
        
        </div>
        </div>
        
        <br />
<!-- 引导结束 -->
{/if}
{/if}
{/foreach}
