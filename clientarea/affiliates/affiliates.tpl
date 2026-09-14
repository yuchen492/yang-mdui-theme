{include file="includes/modal"}
<div class="withdraw" style="display: none;">
	<form>
		<input type="hidden" value="{$Token}" />
		<input type="hidden" name="type" value="1" />
		<div class="form-group row mb-4">
			<label class="col-sm-3 col-form-label text-right">{$Lang.withdrawal_amount}</label>
			<div class="col-sm-8">
				<input type="number" name="num" min="0" class="form-control" placeholder="{$Lang.please_withdrawal_amount}" required />
			</div>
		</div>
	</form>
</div>

<div class="mdui-row mdui-center">
<div class="mdui-col-xs-12 mdui-col-sm-4">

        <div class="mdui-card mdui-m-y-1">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">推介计划介绍</div>
          </div>
          <div class="mdui-card-content">
              <ul>
                <li>通过向您的好友或其他用户发送您的推介链接，新用户通过推介链接注册{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}账户，即可成为您的下属用户。</li>
                {foreach $Affiliates.datarr as $value}
                <li>您的<b class="mdui-text-color-theme-accent">{$value.affiliate_name}</b>收益分成，即{$value.affiliate_des}，您都可以获取 <span class="mdui-text-color-theme-accent">{$value.affiliate_bates}</span> 的返利。</li>
				{/foreach}
                <li>推介计划返利<span class="mdui-text-color-theme-accent">不影响用户的实际消费金额</span>，您还可以考虑以红包的方式奖励您的客户。</li>
                <li>您的返利余额达到<b class="mdui-text-color-theme-accent">{$Affiliates.affiliate_withdraw}{$Affiliates.data.suffix}</b>后即可提现。</li>
              </ul>
          
          </div>
        </div>
        
        {if $CustomDepot.yang_aff_rank_addid}
        <div class="mdui-card mdui-m-y-1">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">神人榜</div>
            <div class="mdui-card-primary-subtitle">排名会根据实际收益动态更新</div>
          </div>
          <div class="mdui-card-content">
          
            
            <iframe scrolling="yes" frameborder="0" style="width:100%;height:550px;" src="{:shd_addon_url('YangAffRank://YangAffRank/index', $vars = [], true)}"></iframe>
            
          
          </div>
        </div>
        {else}
        <!-- 未启用氧化推介排名插件。请装载其他推介计划排名生成插件。 -->
        {/if}


</div>

<div class="mdui-col-xs-12 mdui-col-sm-8">

        <div class="mdui-card mdui-m-y-1">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">{$Userinfo.user.username} 的推介计划</div>
            <div class="mdui-card-primary-subtitle">推介计划报表</div>
          </div>
          <div class="mdui-card-content">

            <div class="mdui-row-xs-5">
              <div class="mdui-col mdui-text-color-theme-accent">
                <h3 class="mdui-text-color-theme-accent">{$Affiliates.data.sum}</h3><i class="mdui-icon material-icons">monetization_on</i> 返利总金额
              </div>

              <div class="mdui-col">
                <h3>{$Affiliates.data.balance}</h3><i class="mdui-icon material-icons">assistant</i> 未提现金额
              </div>

              <div class="mdui-col">
                <h3>{$Affiliates.data.registcount}</h3><i class="mdui-icon material-icons">group</i> 下属用户数
              </div>
              
              <div class="mdui-col">
                <h3>{$Affiliates.data.visitors}</h3><i class="mdui-icon material-icons">visibility</i> 总曝光数
              </div>
            </div>
            
          </div>
          <div class="mdui-card-actions">
            {if $Affiliates.affiliate_withdraw>$Affiliates.data.balance}
            <button class="mdui-btn mdui-btn-raised" disabled>尚未满足提现要求</button>
            {else}
            <button onClick="getModal('withdraw', '{$Lang.immediate_withdrawal}',undefined,undefined,
                refresh)" class="mdui-btn mdui-btn-raised mdui-color-theme" id="withdrawNow">立即提现</button>
            {/if}
          </div>
        </div>
        

        <div class="mdui-tab mdui-tab-scrollable mdui-card" mdui-tab>
            <a href="#yang-mdui-aff-link" class="mdui-ripple">推介信息</a>
            <a href="#yang-mdui-aff-record" class="mdui-ripple">收益明细</a>
            <a href="#yang-mdui-aff-withdraw" class="mdui-ripple">提现记录</a>
            <a href="#yang-mdui-aff-users" class="mdui-ripple">我的客户</a>
        </div>
        
        <div id="yang-mdui-aff-link">
        
            <div class="mdui-card mdui-m-y-1">
              <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">推介链接</div>
              </div>
              <div class="mdui-card-content">
              
                    <div class="mdui-textfield">
                        <label class="mdui-textfield-label">您的推介链接</label>
                        <input class="mdui-textfield-input" id="referralLink" value="{$Affiliates.data.url}" type="text" readonly/>
                    </div>
    			    <p>用户通过此推介链接访问本站，在他们进行新用户注册时，会自动绑定为您的下属用户。之后，他们的每一笔消费，您都将获得分成。您可在下方报表查看详细信息。</p>
              </div>
              <div class="mdui-card-actions">
              <button class="mdui-btn mdui-btn-raised mdui-color-theme-accent" id="copyBtn" mdui-tooltip="{content: '复制链接'}">
    				<i class="mdui-icon material-icons">content_copy</i> 复制链接
    			</button>
              </div>
            </div>
            
            <div class="mdui-card mdui-m-y-1">
              <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">常用推广教程</div>
              </div>
              <div class="mdui-card-content">
                <ul>
                    <li>【首选】 在B站发布相关推广视频，包括但不限于【购买推荐】【搭建/使用教程】【使用评测】等<br>不仅可获推广提成，还可申请百元奖励。</li>
                    <li>在B站、CSDN、知乎等平台发布有关的安利/教程/评测等文章<br>不仅可获推广提成，还可直接申请奖励。</li>
                    <li>创建自己的社群，利用有价值内容吸引和拉取更多人入群并进行推广。</li>
                    <li>在您的网站内加入推广链接/图片进行推广。</li>
                    <li>进入各大相关群内，通过群名片，根据群规适量发布信息进行推广。</li>
                </ul>
                    
              </div>
            </div>
        
        </div>

        
        <div id="yang-mdui-aff-record" class="mdui-card mdui-m-y-1">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">收益明细</div>
            <div class="mdui-card-primary-subtitle">您的客户消费会记录在此处</div>
          </div>
          <div id="affbuyrecord" class="mdui-card-content">
          </div>
        </div>
        
        <div id="yang-mdui-aff-users" class="mdui-card mdui-m-y-1">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">我的客户</div>
            <div class="mdui-card-primary-subtitle">已经绑定为您的下属客户的用户列表</div>
          </div>
          <div id="useraffilist" class="mdui-card-content">
          </div>
        </div>
        
        <div id="yang-mdui-aff-withdraw" class="mdui-card mdui-m-y-1">
          <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">提现记录</div>
            <div class="mdui-card-primary-subtitle">您的推介计划提现记录</div>
          </div>
          <div id="withdrawrecord" class="mdui-card-content">
          </div>
        </div>
        
        
    
</div>

</div>

<script>
	function refresh() { 
		location.reload();
	}
	$(document).ready(function () {
		$('#copyBtn').on('click', function () {
			$('#referralLink').select()
			document.execCommand("Copy")
			mdui.snackbar({message: '复制成功！粘贴到其他地方分享吧~'});
		});
	});
</script>

<script>
	$(document).ready(function () {
		$.ajax({
			type: "get",
			url: '' + '/affiliates',
			data: {
				action: 'affbuyrecord'
			},
			success: function (data) {
				$(data).appendTo('#affbuyrecord');
				{if $CustomDepot.yangmdui_bootstrap_support == "true"}
                yangmdui_bst();
                {/if}
			}
		});
		$.ajax({
			type: "get",
			url: '' + '/affiliates',
			data: {
				action: 'withdrawrecord'
			},
			success: function (data) {
				$(data).appendTo('#withdrawrecord');
				{if $CustomDepot.yangmdui_bootstrap_support == "true"}
                yangmdui_bst();
                {/if}
			}
		});
		$.ajax({
			type: "get",
			url: '' + '/affiliates',
			data: {
				action: 'useraffilist'
			},
			success: function (data) {
				$(data).appendTo('#useraffilist');
				{if $CustomDepot.yangmdui_bootstrap_support == "true"}
                yangmdui_bst();
                {/if}
			}
		});
	});
</script>