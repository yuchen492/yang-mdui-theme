<style>
	.border-hover:hover {
		box-shadow: 0px 0px 0px 1px #007bfc;
	}
</style>

<div class="mdui-card mdui-m-b-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title mdui-text-color-theme"><i class="mdui-icon material-icons">assistant</i> 让 AI 帮助您解决问题</div>
    </div>
    <div class="mdui-card-content">
    
        <p>现在，先进的人工智能语言生成技术已经较为完善。您可以使用 AI 人工智能工具，通过仔细描述问题，快速获取可能的解决方案。</p>
        <p>人工智能工具可以即时、快速、详细地帮助您解决大部分常见问题。并且大部分工具是完全免费的，使用他们可以帮助您节省等待工单回复的时间。</p>
        <p>我们推荐您尝试以下工具：</p>
        <a href="https://chat.deepseek.com/" class="mdui-btn mdui-color-theme" target="_blank"><i class="mdui-icon material-icons">message</i> DeepSeek 深度求索</a>
        <a href="https://yiyan.baidu.com/" class="mdui-btn" target="_blank">文心一言</a>
        <a href="https://tongyi.aliyun.com/qianwen/" class="mdui-btn" target="_blank">通义千问</a>
    
    </div>
</div>

<div class="mdui-card mdui-m-b-1">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">常见问题</div>
    </div>
	<div class="mdui-card-content">
	        
	        <div class="mdui-typo-headline">云服务器</div>
            <div class="mdui-panel" mdui-panel>

                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">服务器 Ping 不通</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>如果您开通的服务器无法 Ping 通（俗称“Ping 全红”），请跟随以下步骤检查。</p>
                        <p>1、如果您的服务器实例刚刚开通，它可能正在进行安装，此时网络配置未完成的情况下，服务器不会被公网访问到，请耐心等待安装完成。通过点击查看 VNC 控制台可以快速了解系统情况，并作出必要操作。</p>
                        <p>2、如果您的实例其他端口正常（或网站访问正常），但无法 Ping 通，请检查安全组是否放行 ICMP 协议，或系统防火墙是否阻止了 ICMP 协议（例如宝塔面板，请进入“安全”选项卡查看）。</p>
                        <p>3、如果服务器无法从公网直接访问，则请进入 VNC 控制台，在服务器内尝试 Ping 外网（例如 Ping 8.8.8.8），如果没有回应，则可能是服务器被空置路由（俗称“被打进入黑洞”），请耐心等待路由空置结束。</p>
                        <p>4、在放行了端口、确认路由未空置的情况下，如果仍然 Ping 不通，请尝试使用第三方工具检查。若出现部分地区不通、其他地区全通的情况，则可能是您所在的地区运营商限制了访问。请尝试更换 IP 地址。</p>
                    </div>
                </div>
                
                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">服务器无法发送邮件</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>大部分服务商（包括我们）的云服务器可能主动阻断 25 端口，这使得您的服务器无法向外发送邮件。</p>
                        <p>请您联系运维团队确认当前可用区是否支持放行 SMTP 端口。</p>
                        <p>如果确认放心，仍然无法发送邮件，请跟随以下步骤检查。</p>
                        <p>1、检查安全组和服务器内防火墙是否放行 25 端口，或必要的邮件服务端口。</p>
                        <p>2、若确认已放行，则尝试发送一封邮件，并记录发送日志。</p>
                        <p>3、请根据发送日志排查程序问题，或联系他人寻求帮助。</p>
                    </div>
                </div>
                
                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">服务器无法安装图形处理应用</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>如果服务器无法安装图形处理应用，可能是因为当前实例没有 GPU 硬件。</p>
                        <p>请您确认服务器实例是否拥有 GPU 硬件，如果没有，请联系运维团队获取帮助。</p>
                        <p>您可尝试在支持 GPU 硬件的可用区实例中，转到“变更参数”进行升配。</p>
                    </div>
                </div>
                
            </div>
            
            <hr>
            
            <div class="mdui-typo-headline">虚拟主机</div>
            <div class="mdui-panel" mdui-panel>

                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">虚拟主机无法登录</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>如果您开通的虚拟主机无法登录，请跟随以下步骤检查。</p>
                        <p>1、如果您曾经修改过虚拟主机的密码，请通过实例管理页面重置您的密码。</p>
                        <p>2、如果无法加载管理控制台，则虚拟主机节点可能离线。请寻求运维人员获取帮助。</p>
                    </div>
                </div>
                
                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">虚拟主机无法连接数据库</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>您的程序可能需要连接数据库。请跟随以下步骤检查。</p>
                        <p>1、请将数据库地址设置为您的节点的数据库地址（通常本机节点设置为 127.0.0.1）。</p>
                        <p>2、请将数据库端口设置为您的节点的数据库端口（通常为 3306）。</p>
                        <p>3、确认您的数据库密码是否正确。一般数据库密码和面板用户密码一致，如果您更改过密码且忘记密码，请通过实例管理面板重置。</p>
                        <p>4、确认您的数据库用户名正确。一般用户名和面板用户名一致。</p>
                        <p>5、若上述流程未能解决问题，请根据程序错误日志排查问题，或联系他人寻求帮助。</p>
                    </div>
                </div>
                
                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">访问站点直接下载文件而不显示内容</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>您可能没有正确设置动态语言，例如 PHP。</p>
                        <p>1、请确认程序是否需要使用动态语言（例如PHP），如果需要，则在虚拟主机管理面板启用动态语言。</p>
                        <p>2、请确认程序所需动态语言版本和您在虚拟主机管理面板设置的版本一致。</p>
                        <p>3、如果设置后仍然无法解决问题，请尝试刷新浏览器缓存（Ctrl + F5）和 CDN 缓存（CloudFlare：区域-缓存-配置-清空所有内容；Kangle：缓存-清空缓存）。</p>
                        <p>4、确认您的程序设置了正确的响应头。</p>
                    </div>
                </div>
                
                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">CDN 回源失败（CDN 502 错误或无限重定向）</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>如果您正在使用 CDN 接入虚拟主机服务，请关闭虚拟主机中的防 CC 等防御模块。</p>
                        <p>您应当让您的 CDN 接管 CC 防御和 WAF 服务，否则虚拟主机节点可能拦截 CDN 节点的请求。</p>
                        <p>EasyPanel：防 CC 设置-关闭。</p>
                    </div>
                </div>
                
                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">客户端直连 SSL/TLS 证书错误（HTTPS 加密错误）</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>如果您启用了 SSL/TLS 证书，请确保您提供的安全证书有效，或客户端信任此证书。</p>
                        <p>请留意“证书内容”和“证书密钥”没有填写颠倒。颠倒填写仍可保存，但响应时客户端会出现错误。</p>
                        <p>虚拟主机适用通用 SSL/TLS 证书，第三方签发请下载“通用证书”或“Nginx 证书”并设置在虚拟主机节点。其中 PEM 文件填写到“证书内容”，KEY 文件填写到“证书密钥”。</p>
                        <p>如果正在使用 CDN 边缘证书服务（不透传虚拟主机安全证书），请联系您的 CDN 服务商解决。</p>
                    </div>
                </div>
                
            </div>
            
            <hr>
            
            <div class="mdui-typo-headline">财务</div>
            <div class="mdui-panel" mdui-panel>

                <div class="mdui-panel-item">
                    <div class="mdui-panel-item-header">
                        <div class="mdui-panel-item-title">优惠码无法使用</div>
                        <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                    </div>
                    <div class="mdui-panel-item-body">
                        <p>如果您需要使用优惠码。</p>
                        <p>1、请将满足优惠要求的产品设置配置，并添加到购物车，然后使用优惠码。</p>
                        <p>2、如果提示产品不适用优惠码，则请仔细阅读优惠码使用限制。</p>
                    </div>
                </div>
                
                
            </div>
            
    </div>
    

</div>

<div class="mdui-card mdui-m-b-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">我的问题仍未解决</div>
        <div class="mdui-card-primary-subtitle">发起新工单</div>
    </div>
    <div class="mdui-card-content">
    
        <p>看起来您实在没有办法解决问题了？请选择一个团队向我们发起工单，我们会尽快协助您解决问题。</p>
                        
                        <div class="mdui-row-xs-1 mdui-row-sm-2 mdui-row-md-3">


                            {if $SubmitTicket.department}
                            
                            {foreach $SubmitTicket.department as $department}
                            
                            <div class="mdui-col">
                            
                                <div class="mdui-card mdui-m-a-1 mdui-hoverable">
                                    <div class="mdui-card-primary">
                                        <div class="mdui-card-primary-title">
                                            {$department.name}
                                        </div>
                                    </div>
                                    <div class="mdui-card-content">
                                        {$department.description}
                                    </div>
                                    <div class="mdui-card-actions">
                                        <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme" href="submitticket?step=2&dptid={$department.id}"><i class="mdui-icon material-icons">phone</i> 联系本组</a>
                                    </div>
                                </div>
                            	
                            </div>
                            
                            {/foreach}
                            
                            {else}
                            {include file="error/alert" value="{$Lang.temporary_department}"}
                            {/if}
                            
                        
                        
                            
                        </div>
    
    </div>
</div>