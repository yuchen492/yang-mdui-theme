<style>
	@media (min-width: 560px) and (max-width: 930px) {
    .addfunds-payment img{
		height: 16px;
	}
}
</style>

		<div method="post">
            <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">账户当前资产</div>
                </div>
                <div class="mdui-card-content">
                    账户当前余额：<span class="mdui-typo-display-1 mdui-text-color-theme-accent">{$Addfunds.addfunds.credit}</span>{$Addfunds.addfunds.currency.suffix}
                </div>
            </div>
            
            <div class="mdui-card mdui-m-y-1 mdui-hoverable">
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">余额充值</div>
                </div>
                <div class="mdui-card-content">
                    
                    <p>您可以向账户中进行余额充值，一旦充值完成，账户将增加等额的余额。</p>
                    <p>购置新实例时，当账户余额充足，无需额外发起付款，直接使用账户余额完成订单。</p>
                    <p>账户余额还可用于自动续费实例，帮助您节约维护时间成本。</p>
                    
                    <hr>
                    
                    <div class="mdui-textfield">
                        <label class="mdui-textfield-label">充值金额（{$Addfunds.addfunds.currency.suffix}）</label>
                        <input class="mdui-textfield-input" name="amount" type="text" id="addfundsInp"
						   value="{$Addfunds.addfunds.addfunds_minimum}" onblur="addfundsMaxMin()" placeholder="请输入充值金额"/>
                    </div>
                    
                    <div class="mdui-row-xs-3 mdui-row-sm-6 mdui-row-md-12">
                    
                        {if $Addfunds.addfunds.addfunds_maximum >= 5 && $Addfunds.addfunds.addfunds_minimum <= 5}
                            <div class="mdui-col">
                                <button class="mdui-btn mdui-btn-raised mdui-ripple" onclick="$('#addfundsInp').val(5)">5元</button>
                            </div>
                        {/if}
                        {if $Addfunds.addfunds.addfunds_maximum >= 10 && $Addfunds.addfunds.addfunds_minimum <= 10}
                            <div class="mdui-col">
                                <button class="mdui-btn mdui-btn-raised mdui-ripple" onclick="$('#addfundsInp').val(10)">10元</button>
                            </div>
                        {/if}
                        {if $Addfunds.addfunds.addfunds_maximum >= 20 && $Addfunds.addfunds.addfunds_minimum <= 20}
                            <div class="mdui-col">
                                <button class="mdui-btn mdui-btn-raised mdui-ripple" onclick="$('#addfundsInp').val(20)">20元</button>
                            </div>
                        {/if}
                        {if $Addfunds.addfunds.addfunds_maximum >= 50 && $Addfunds.addfunds.addfunds_minimum <= 50}
                            <div class="mdui-col">
                                <button class="mdui-btn mdui-btn-raised mdui-ripple" onclick="$('#addfundsInp').val(50)">50元</button>
                            </div>
                        {/if}
                        {if $Addfunds.addfunds.addfunds_maximum >= 100 && $Addfunds.addfunds.addfunds_minimum <= 100}
                            <div class="mdui-col">
                                <button class="mdui-btn mdui-btn-raised mdui-ripple" onclick="$('#addfundsInp').val(100)">100元</button>
                            </div>
                        {/if}
                        <div class="mdui-col">
                            <button class="mdui-btn mdui-btn-raised mdui-ripple" onclick="$('#addfundsInp').val(parseInt(Math.random() * ({$Addfunds.addfunds.addfunds_maximum} - {$Addfunds.addfunds.addfunds_minimum} + 1) + {$Addfunds.addfunds.addfunds_minimum}))"><i class="mdui-icon material-icons">audiotrack</i> 随机金额</button>
                        </div>
                    
                    </div>
                    
                    <hr>
                    
                    <div class="mdui-row-xs-1 mdui-row-sm-2 mdui-row-md-3">
                    {foreach $Addfunds.addfunds.gateways as $index=>$gateways}
                        <div class="mdui-col">
                            <label class="mdui-radio" data-payment="{$gateways.name}" title="{$gateways.title}">
                                <input type="radio" name="payment" class="hidden" value="{$gateways.name}" {if $index==0}checked{/if} />
                                <i class="mdui-radio-icon"></i>
                                {if $gateways.author_url}
    								<img src="{$gateways.author_url}" /><br>
    							{/if}
    								使用{$gateways.title}
                            </label>
                        </div>
                    {/foreach}
                    </div>
                </div>
                
                <div class="mdui-card-actions">
                    <button type="button"  class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme pay-now-btn" onclick="formSubmitBtn();return false;">充值</button>
				</div>
                
            </div>

		</div>


{include file="includes/paymodal"}
{include file="yangcuts/pay_dialog"}

<script type="text/javascript" src="/themes/clientarea/default/assets/libs/qrcode/jquery.qrcode.min.js?v={$Ver}"></script>
<script src="/themes/clientarea/default/assets/libs/dropzone/min/dropzone.min.js?v={$Ver}"></script>
<script type="text/javascript">

	var intervalBox;
	var max = '{$Addfunds.addfunds.addfunds_maximum}',
			min = '{$Addfunds.addfunds.addfunds_minimum}'
		,_url = '';
</script>
<script src="/themes/clientarea/yang-mdui-re/yangjs/addfunds.js?v={$Ver}"></script>
