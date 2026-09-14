

<style>
	.ordersummary td {
		border:none!important;
		padding: 5px!important;
	}
	.mobile-bottom-total{
		display: none;
		position: fixed;
		width: 100%;
		height: 4rem;
		text-align: right;
		line-height: 4rem;
		padding-right: 1.25rem;
		background: #FFFFFF;
		box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
		z-index: 99999;
		bottom: 0;
		left: 0;
		-webkit-overflow-scrolling: auto;
	}
	.mobile-bottom-total .total {
		font-size: 18px;
		font-weight: 400;
		color: #333333;
		margin-right: 0.5rem;
	}
	.btn.active { 
		z-index: 0 !important; 
	}
</style>

    <div class="mdui-row mdui-p-b-1">
        <div class="mdui-col-xs-12">
            <div class="mdui-card">
            	<div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        实例基础费用
                    </div>
                </div>
                <div class="mdui-table-fluid">
                    <table class="mdui-table mdui-table-hoverable">
                        <thead>
                            <tr>
                                <th>项目</th>
                                <th class="mdui-table-col-numeric">报价</th>
                            </tr>
                        </thead>
                    	<tbody>
                    		<tr>
                    			<td>创建实例的通用费用 <a href="javascript:;" mdui-tooltip="{content: '标准通用费用无论您如何更改其他任何配置项目都要收取。对于套餐规定配置类产品而言，此处显示的费用即套餐费用。'}">(?)</a></td>
                    			<td>{$ConfigureTotal.currency.prefix}{$ConfigureTotal.product_price}</td>
                    		</tr>
                    		<tr>
                    			<td>实例首次开通准备费用 <a href="javascript:;" mdui-tooltip="{content: '即初装费。此费用仅在首次创建实例时收取，续费时无需支付此费用。'}">(?)</a></td>
                    			<td>{$ConfigureTotal.currency.prefix}{$ConfigureTotal.product_setup_fee}</td>
                    		</tr>
                    		<tr>
                    		    <td><b>基础费用合计</b></td>
                    		    <td>{$ConfigureTotal.currency.prefix}{:bcadd($ConfigureTotal.product_setup_fee,$ConfigureTotal.product_price)}<br>(下一个付款周期开始：{$ConfigureTotal.currency.prefix}{$ConfigureTotal.product_price})</td>
                    		</tr>
                    	</tbody>
                	</table>
            	</div>
            </div>
        </div>
    </div>
    
    
    <div class="mdui-row mdui-p-b-1">
        <div class="mdui-col-xs-12">
            <div class="mdui-card">
            	<div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        可配置费用详情
                    </div>
                </div>
                <div class="mdui-table-fluid">
                    <table class="mdui-table mdui-table-hoverable">
                        <thead>
                            <tr>
                                <th>项目</th>
                                <th>已选配置</th>
                                <th class="mdui-table-col-numeric">报价</th>
                            </tr>
                        </thead>
                    	<tbody>
                    		{foreach $ConfigureTotal.child as $configure}
                    		<tr>
                    		    <td>{$configure.option_name}</td>
                    			<td>
                    				{if $configure.option_type == '12'}
                    					{if $configure.icon_flag}
                    						<img class='mr-1' src='/upload/common/country/{$configure.icon_flag}.png' height='15'/>
                    					{/if}
                    				{elseif $configure.option_type == '5'}
                    					{if $configure.icon_os}
                    						<img class='mr-1' src='/upload/common/system/{$configure.icon_os}.svg' height='20'/>
                    					{/if}
                    				{/if}
                    				<span style="word-break: break-all;white-space: normal;">
                    					{if $configure.qty}{$configure.qty}{else/}{$configure.sub_name}{/if}
                    				</span>
                    			</td>
                    			<td>
                    			    {$ConfigureTotal.currency.prefix}{$configure.suboption_price}
                    			</td>
                    		</tr>
                        		{if $configure.suboption_setup_fee > 0}
                        		<tr>
                        		    <td>——</td>
                        			<td>
                        				配置项首次部署费用
                        			</td>
                        			<td>
                        			    {$ConfigureTotal.currency.prefix}{$configure.suboption_setup_fee}
                        			</td>
                        		</tr>
                        		{/if}
                    		{/foreach}
                            <tr>
                    		    <td><b>配置费用合计</b></td>
                    		    <td></td>
                    		    <td>{$ConfigureTotal.currency.prefix}{$ConfigureTotal.total - $ConfigureTotal.product_setup_fee - $ConfigureTotal.product_price|number_format=2}</td>
                    		</tr>
                    	</tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


<div class="mdui-row mdui-p-b-1">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
        	<div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    保存配置
                </div>
            </div>
            <div class="mdui-table-fluid">
                <table class="mdui-table mdui-table-hoverable">
                    <thead>
                        <tr>
                            <th>项目</th>
                            <th class="mdui-table-col-numeric">报价</th>
                        </tr>
                    </thead>
                	<tbody>
                			<tr>
                				<td>标准报价</td>
                				<td>
                                    {$ConfigureTotal.currency.prefix}{$ConfigureTotal.total}
                				</td>
                			</tr>
                		{if $ConfigureTotal.type}
                			<tr>
                				<td>
                					{if $ConfigureTotal.type.type == '1'}
                						<span>——<span class="discount-num"></span>折优惠
                						</span>
                					{elseif $ConfigureTotal.type.type == '2'}
                						<span>——
                							<span class="discount-num">{$ConfigureTotal.currency.prefix}{$ConfigureTotal.type.bates}减免优惠</span>
                						</span>
                					{/if}
                				</td>
                				<td class="mdui-text-color-green">-
                					{$ConfigureTotal.currency.prefix}{:bcsub(bcsub($ConfigureTotal.total,$ConfigureTotal.sale_setupfee_total),$ConfigureTotal.sale_signal_price)}
                				</td>
                			</tr>
                
                		{/if}
                		                		<!-- 有折扣时， 才显示总价 -->
                
                		<tr class="mobile-hide">
                			<td><b>所选实例总价</b> <a href="javascript:;" mdui-tooltip="{content: '计算方式为基础费用与可配置费用之和乘以用户优惠付费比例。'}">(?)</a></td>
                			<td>
                				{if !$ConfigureTotal.type}
                					{$ConfigureTotal.currency.prefix}{:bcadd($ConfigureTotal.signal_price,$ConfigureTotal.signal_setupfee)}
                				{else}
                					{$ConfigureTotal.currency.prefix}{:bcadd($ConfigureTotal.sale_signal_price,$ConfigureTotal.sale_setupfee_total)}
                				{/if}
                			</td>
                		</tr>
                		
                	</tbody>
            	</table>
        	</div>
        	<div class="mdui-card-actions">
				<button type="button" style="cursor: pointer;" class="mdui-btn mdui-btn-raised mdui-color-theme" id="addToCartBtn" mdui-tooltip="{content: '添加当前配置实例到购物车。这不会立即结算。'}"><i class="mdui-icon material-icons">add_shopping_cart</i> 保存配置到购物车</button>
				<div><i class="mdui-icon material-icons mdui-text-color-theme-accent">info</i> 您可以在<a class="mdui-text-color-theme" href="/cart?action=viewcart" target="_blank">购物车结算页面</a>使用优惠码（当此产品在购物车中且满足优惠条件时）</div>
        	</div>
        </div>
    </div>
</div>





	<!-- 移动端底部价格展示 -->
	<div class="mobile-bottom-total">
     	<span class="total">{$Lang.total_price}：	{if !$ConfigureTotal.type}
					{$ConfigureTotal.currency.prefix}{:bcadd($ConfigureTotal.signal_price,$ConfigureTotal.signal_setupfee)}
				{else}
					{$ConfigureTotal.currency.prefix}{:bcadd($ConfigureTotal.sale_signal_price,$ConfigureTotal.sale_setupfee_total)}
				{/if}</span>
			 <button type="button" style="cursor: pointer;" class="btn btn-primary" id="addToCartBtnTwo"><i class="mdi mdi-cart-arrow-right mr-1"></i>{$Lang.add_cart}</button>
		</div>
<script>
	$(function() {
	    mdui.mutation()
		if(navigator.userAgent.match(/mobile/i)) {
			$('.mobile-bottom-total').show()
			$('.mobile-hide').remove()
		}else{
			$('.mobile-bottom-total').remove()
		}
		console.log('2',$(".getPassword"))
		console.log('val', $(".getPassword").val())
		console.log('showPassword2',showPassword)
		// 产品信息
		var products = {:json_encode($ConfigureTotal)};
		// 订单折扣量
		if ('{$ConfigureTotal.type.type}' == '1') {
			if (parseFloat(products.type.bates) % 10 == 0) {
				$('.discount-num').text(parseFloat(parseFloat(products.type.bates) / 10))
			} else {
				$('.discount-num').text(parseFloat(parseFloat(products.type.bates) / 10).toFixed(2))
			}
		}

    if (!!window.ActiveXObject || "ActiveXObject" in window){
      console.log('ie');
      $('#addToCartBtn,#addToCartBtnTwo').click(function () {
		let result = {flag:true}
		if(passwordRules != null && showPassword == 1) {
			result = checkingPwd1($(".getPassword").val(), passwordRules.num, passwordRules.upper, passwordRules.lower, passwordRules.special)
		}
        if(result.flag) {
						$('#addCartForm').submit()
					}
					else {
						toastr.error($('.is-invalid').parents('.form-group').find('.error-tip').html())
					}
				// $('#addCartForm').submit()

		  })
    }else{
			// console.log('不是ie');
      $('#addToCartBtn,#addToCartBtnTwo').click(function () {
		let result = {flag:true}
		if(passwordRules != null && showPassword == 1) {
			result = checkingPwd1($(".getPassword").val(), passwordRules.num, passwordRules.upper, passwordRules.lower, passwordRules.special)
		}
					if(result.flag) {
						$('#addCartForm').submit()
					}
					else {
						toastr.error($('.is-invalid').parents('.form-group').find('.error-tip').html())
					}
					// $('#addCartForm').submit()
       })
      // 加入购物车 提交按钮
		// $(document).on('click', '#addToCartBtn', function () {
		// 	if($(this).data("disabled")) return false;
		// 	var InpCheck = $( "input[name^='customfield']")
		// 	var textareaCheck = $( "textarea[name^='customfield']")
		// 	if (checkListFormVerify([...InpCheck, ...textareaCheck])){
		// 		var position = $(".is-invalid:first").offset();
		// 		scrolltop = position.top-70;
		// 		$("html,body").animate({scrollTop:scrolltop}, 1000);
		// 		return false;
		// 	}
		// 	$(this).prepend('<i class="bx bx-loader bx-spin font-size-16 align-middle mr-2"></i>')
		// 	$(this).data("disabled",true);
    //   // debugger
		// 	$('#addCartForm').submit()
		// })
    }
   
		
	})
</script>

