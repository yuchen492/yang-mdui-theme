
<script>
	var _url = '';
	$(function(){
		// 购物车返回按钮
		// $('.backBtn').show();
		
		
		
		$(".checkbox").on('change','.payment-checkbox',function(){
			if($(this).parent().siblings(".checkboxDiv").length!=0){
				if($(this).parent().siblings(".checkboxDiv").hasClass('checkboxSelect')==true) $(this).parent().siblings(".checkboxDiv").removeClass("checkboxSelect")
			}
			if($(this).prop('checked')){
				$(this).parent().addClass("checkboxSelect");
				if($(this).parent().siblings(".checkboxDiv").length!=0){
					$(this).parent().siblings(".checkboxDiv").find('input').prop("checked",false)
				}
				// 移除支付方式选中
				$(".addfunds-payment").removeClass("active").find(".hidden").removeAttr("checked")
			}else{
				$(this).parent().removeClass("checkboxSelect");
			}
		})
		$(".addfunds-payment").click(function(){
			$(this).find(".hidden").attr("checked","checked");
			$(this).addClass('active').parent().siblings('.addfunds').find(".addfunds-payment").removeClass("active").find(".hidden").removeAttr("checked");
			$('input[name="paymt"]').prop('checked', false).parent().removeClass("checkboxSelect");
		})
		// 配置详情展开折叠
		$('.card-body').on('click','.goods_info .title',function(){
			$(this).find('font').toggleClass('zk');
			$(this).siblings('.info').slideToggle();
		})
		$('.card-body').on('click','.all_checkbox',function(_this){

			let arr=$('.son_check')   //所有商品
			//总价
			let price = '0.00'
				,len = 0;
			if(arr.length!=0)
			{
				if(_this.target.checked) {
					for (var i = 0; i < arr.length; i++) {
						arr[i].checked = _this.target.checked
						price = (parseFloat($(arr[i]).data('price').trim()) + parseFloat(price)).toFixed(2);
						len++;
					}
				}else{
					for (var i = 0; i < arr.length; i++) {
						arr[i].checked = _this.target.checked
					}
				}
			}
			$('.len-num').text(len);
			$('.price-num').text(price);
		})
		$('.card-body').on('click','.son_check',function(_this){

			if(!_this.target.checked) $('.all_checkbox')[0].checked=false
			let arr=$('.son_check')   //所有商品
			//			总价
			let price = '0.00'
					,len = 0;
			for (var i = 0; i < arr.length; i++) {
				if(arr[i].checked)
				{
					price = (parseFloat($(arr[i]).data('price').trim()) + parseFloat(price)).toFixed(2);
					len++;
				}
			}

			if((arr.filter((index,item)=> item.checked==true).length) == arr.length) $('.all_checkbox')[0].checked=true

			$('.len-num').text(len);
			$('.price-num').text(price);
		})
		$('.administrationBtn').click(function(){
			$('.administrationBtn').hide()
			$('.completeBtn').show()
			$('.payDiv').hide()
			$('.deleteBtn').show()
		})
		$('.completeBtn').click(function(){
			$('.administrationBtn').show()
			$('.completeBtn').hide()
			$('.payDiv').show()
			$('.deleteBtn').hide()
		})
	//	删除按钮点击时
		$('.deleteBtn > button').click(function() {
			let arr = $('.son_check')   //所有商品
			if(arr.length == 0)
			{
				return;
			}
			var is = [];
			for(var i=0;i<arr.length;i++){
				if(arr[i].checked)
				{
					is.push($(arr[i]).data('val'));
				}
			}
			if(is.length <= 0)
			{
				//提示框
				toastr.error('请选择要删除的商品！')
				return false;
			}
			removeItem('cart?action=viewcart&statuscart=remove', '{$Lang.delete_item}', '您确定要删除这'+ is.length +'种商品吗？', {i: is});
		})
	//	立即结账按钮
	// 	$('.submit-btn').click(function(){
	// 		let arr=$('.son_check:checked');
	// 		if(arr.length <= 0)
	// 		{
	// 			//提示框
	// 			toastr.error('请至少选择一个商品！')
	// 			return false;
	// 		}
	// 	})
	})
</script>
<link type="text/css" href="/themes/cart/default/assets/js/toastr/build/toastr.min.css?v={$Ver}"
	rel="stylesheet" />
<script src="/themes/cart/default/assets/js/toastr/build/toastr.min.js?v={$Ver}"></script>
<script src="/themes/cart/default/assets/js/viewcart.js?v={$Ver}"></script>
<style>
@media (min-width: 560px) and (max-width: 1355px) {
	.addfunds-payment img{
		height: 16px;
	}
}
.modal-body{
  -moz-box-sizing: border-box;  
     -webkit-box-sizing: border-box; 
     -o-box-sizing: border-box; 
     -ms-box-sizing: border-box; 
}
.goods_info{
	width:100%;
	padding: 10px 0px;
}
.goods_info span {
	display: block;
}
.goods_info .title{
	text-indent: 10px;
	color: #409eff;
	cursor: pointer;
}
.goods_info .title font {
	float: left;
	color: #666;
	font-family: cursive;
	font-size: 12px;
	margin-top: 1px;
}
.goods_info .title .zk {
	transform: rotate(90deg);
	margin-top: -4px;
}
.goods_info .info{
	width: 100%;
	color: #333;
	text-indent: 27px;
	line-height: 24px;
}
.custom-controlTwo{
    position: relative;
    z-index: 1;
    display: block;
    min-height: 1.21875rem;
    padding-left: 1.5rem;
    -webkit-print-color-adjust: exact;
}
.completeBtn{
	display:none;
}
.deleteBtn{
	display:none;
}
.mobile-bottom-total{
		display: none;
		position: fixed;
		width: 100%;
    padding-right: 1.25rem;
		background: #FFFFFF;
		box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
		z-index: 99999;
		bottom: 0;
		left: 0;
	}
	.mobile-flex{
		display: flex;
    align-items: center;
    justify-content: space-between;
    padding-left: 1rem;
	}
</style>

<form id="submit-form" method="post" action="cart?action=viewcart&statuscart=checkout">

{if $ErrorMsg}
    <div class="mdui-row mdui-m-y-1">
        <div class="mdui-col">
            <div class="mdui-card mdui-hoverable">
            
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        处理订单时出错
                    </div>
                </div>
                
                <div class="mdui-card-content">
                    <p>处理本次订单时出现错误，无法继续。错误信息：</p>
                    <p>{$ErrorMsg}</p>
                </div>
            </div>
        </div>
    </div>

{/if}
    
    <div class="mdui-row mdui-m-y-1">
        <div class="mdui-col">
            <div class="mdui-card mdui-hoverable">
            
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        购物车
                        {if $ShopData.cart_products}
                            （共{:count($ShopData.cart_products)}个实例）
                        {/if}
                    </div>
                    <div class="mdui-card-primary-subtitle">
                        您当前购物车内的实例。
                    </div>
                </div>
                
                {if $ShopData.cart_products}
                <div class="mdui-card-content">
                
                    <div class="mdui-panel" mdui-panel="{accordion: true}">
                        
                        {foreach $ShopData.cart_products as $cart_val=>$cart}
                        <div class="mdui-panel-item">
                            <div class="mdui-panel-item-header">
                                <div class="mdui-panel-item-title mdui-text-color-theme-accent">{$cart.productsname}</div>
                                <div class="mdui-panel-item-summary">
                                    {$cart.conf.host}
                                </div>
                                <div class="mdui-panel-item-summary">
                                    <b>配置费用合计：</b>{$ShopData.currency.prefix}{:bcmul($cart.product_pricing,$cart.qty,2)}
                                </div>
                                <i class="mdui-panel-item-arrow mdui-icon material-icons">keyboard_arrow_down</i>
                            </div>

                            
                            <div class="mdui-panel-item-body">
                            
                                <h2>产品：</h2>
                                <p>{$cart.productsname}</p>
                                
                                <h2>实例标识：</h2>
                                <p>{$cart.conf.host}</p>
                            
                                <h2>保存的配置：</h2>
        						
        						<div class="mdui-table-fluid">
                                    <table class="mdui-table mdui-table-hoverable">
                                        <thead>
                                            <tr>
                                                <th>项目</th>
                                                <th>配置类型</th>
                                                <th>已设置值</th>
                                            </tr>
                                        </thead>
                                    	<tbody>
                                    		{foreach $cart.conf_child as $son_v}
                                    		<tr>
                                    		    <td>
                                    		        {$son_v.name}
                                    		    </td>
                                    			<td>
                                    				实例可配置项
                                    			</td>
                                    			<td>
                                    			    {$son_v.sub_name}
                                    			</td>
                                    		</tr>
                                    		{/foreach}
                                    		{foreach $cart.configoptions as $configoptions_key=>$configoptions_val}
                                    		<tr>
                                    		    <td>
                                    		        {$configoptions_key}
                                    		    </td>
                                    			<td>
                                    				用户定义项
                                    			</td>
                                    			<td>
                                    			    {$configoptions_val.value}
                                    			</td>
                                    		</tr>
                                    		{/foreach}
                                    	</tbody>
                                    </table>
                                </div>
                                
                                <p><b>说明：</b><br>
                                <b>实例可配置项：</b>有明确报价的，财务系统给出的用于配置实例基础设置的选项。<br>
                                <b>用户定义项：</b>财务系统允许用户自定义的内容，可能用于实例个性化配置。</p>
                                
                                <h2>实例报价：</h2>
                                <p>
                                    {$ShopData.currency.prefix}{$cart.product_pricing}<span class="mdui-typo-caption">（单个实例配置报价）</span> x {$cart.qty}<span class="mdui-typo-caption">（实例数量）</span> = <b>{$ShopData.currency.prefix}{:bcmul($cart.product_pricing,$cart.qty,2)}</b><span class="mdui-typo-caption">（实例总价）</span>
        						（涉及的税费已包含在内）
        						</p>
        						
        						{if $cart.type.type  == '1'}
        						    <p><i class="mdui-icon material-icons mdui-text-color-green">check_circle</i> <b>签约折扣价：</b>{$cart.type.bates}折</p>
								{elseif $cart.type.type  == '2'}
									<p><i class="mdui-icon material-icons mdui-text-color-green">check_circle</i> <b>签约折扣价：</b>减免{$ShopData.currency.prefix}{$cart.type.bates})</p>
									{/if}
                                
                                <div class="mdui-panel-item-actions">
                                    {if $cart.allow_qty==1 && $$CustomDepot.yangmdui_cart_stock == "true"}
                                        <div class="mdui-textfield">
                                            <label class="mdui-textfield-label">批量开通</label>
                                            <input class="mdui-textfield-input" type="number" name="qty" class="number" value="{$cart.qty}"/>
                                        </div>
    									<input type="hidden" name="i" value="{$cart_val}">
    									<button type="button" class="mdui-btn mdui-ripple" onclick="cartQtyBtn(this)"><i class="mdui-icon material-icons">archive</i> 输入数量后，单击此处批量应用配置</button>
    								{/if}
                						<a href="cart?action=configureproduct&pid={$cart.productid}&i={$cart_val}" class="mdui-btn" mdui-tooltip="{content: '编辑配置项目'}">
                						    <i class="mdui-icon material-icons">edit</i> 编辑配置项目
                						</a>
                						<a href="javascript:;" onclick="removeItem('cart?action=viewcart&statuscart=remove', '{$Lang.delete_item}', '{$Lang.sure_delete}', {i: {$cart_val}})" class="mdui-btn" mdui-tooltip="{content: '删除此实例'}">
                							<i class="mdui-icon material-icons">delete</i> 删除此实例
                						</a>
                                </div>
                                

                            </div>
                            
                            
                            
                        </div>
                        {/foreach}
    
                        
                    </div>
                    
                </div>
                {else}
                <div class="mdui-card-content">
                    暂无已保存配置的实例。<a href="/cart">去新建一个实例！</a>
                </div>
                {/if}
            </div>
        </div>
    </div>
    

    <div class="mdui-row mdui-m-y-1">
        <div class="mdui-col">
            <div class="mdui-card mdui-hoverable">
            
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        优惠码
                    </div>
                </div>
                
                {if $Userinfo}
                <div class="mdui-card-content">
                    {if $ShopData.promo}
						<i class="mdui-icon material-icons mdui-text-color-green">check_circle</i> <b>此订单使用优惠码：</b>{$ShopData.promo.promo_desc_str}
						<a href="javascript:;" class="mdui-btn" id="removepromo"><i class="mdui-icon material-icons">remove_circle_outline</i> 取消使用优惠码</a>
					{else/}
					<div id="promo">
    					<div class="mdui-textfield mdui-textfield-floating-label">
                            <label class="mdui-textfield-label">优惠码</label>
                            <input class="mdui-textfield-input" name="promo" value="{$promocode}"/>
                            <div class="mdui-textfield-helper">填写有效优惠码，此次结算将享受优惠</div>
                        </div>
                        <button class="mdui-btn mdui-ripple mdui-btn-raised mdui-color-theme" type="button"><i class="mdui-icon material-icons">add</i> 使用优惠码</button>
                    </div>
					{/if}
                </div>
                {else}
                <div class="mdui-card-content">
                    <span><i class="mdui-icon material-icons mdui-text-color-orange">info</i> 您需要先登录才可以使用优惠码。</span>
                </div>
                {/if}
                
            </div>
        </div>
    </div>
    
    <div class="mdui-row mdui-m-y-1">
        <div class="mdui-col">
            <div class="mdui-card mdui-hoverable">
            
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        订单备注
                    </div>
                    <div class="mdui-card-primary-subtitle">
                        备注可被运维成员查看，您可用于备注您的额外需求。
                    </div>
                </div>
                
                <div class="mdui-card-content">
                    <div class="mdui-textfield">
                        <textarea class="mdui-textfield-input" rows="8" placeholder="选填，建议先与运维团队协商一致"></textarea>
                    </div>
                    <span><i class="mdui-icon material-icons mdui-text-color-orange">info</i> 收款方和退款服务，可在“账单”页面查看。</span>
                </div>

            </div>
        </div>
    </div>
    
    {if $Userinfo}
    <div class="mdui-row mdui-m-y-1">
        <div class="mdui-col">
            <div class="mdui-card mdui-hoverable">
            
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        支付方式
                    </div>
                </div>
                
                <div class="mdui-card-content">
                
                    <div class="mdui-typo-headline">当前订单需要支付：{$ShopData.total_desc}</div>
                    
                    {if $Userinfo.user.credit > 0}
                    <label class="mdui-switch">
                        <input class="payment-credit" type="checkbox" name="paymt" data-name="switch" value="credit" id="paymt" {if (isset($ShopData.total_price) && $ShopData.total_price <= $Userinfo.user.credit)} checked {/if}/>
                        <i class="mdui-switch-icon"></i>
                        <i class="mdui-icon material-icons">account_balance_wallet</i> 使用账户余额（当前余额：{$ShopData.currency.prefix}{$Userinfo.user.credit}）
                        {if (isset($ShopData.total_price) && $ShopData.total_price > $Userinfo.user.credit)}<span class="mdui-typo-caption">（不足的金额会发起新的在线充值补齐，优先使用下方选择的渠道）</span>{/if}
                    </label>
                    {else}
                    <label class="mdui-switch">
                        <input type="checkbox" name="paymt" data-name="switch" value="credit" id="paymt" disabled/>
                        <i class="mdui-switch-icon"></i>
                        <i class="mdui-icon material-icons">account_balance_wallet</i> 使用账户余额（账户没有余额，请先充值。）
                    </label>
                    {/if}
                    
					<div class="mdui-row-xs-1 mdui-row-sm-2 mdui-row-md-3">
    					{foreach $ShopData.gateway_list as $list}
    					<div class="mdui-col">
        				    <label class="mdui-radio">
                                <input class="payment-other" type="radio" name="payment" class="hidden" value="{$list.name}" {if $list.name==$ShopData.default_gateway}checked{/if}/>
                                <i class="mdui-radio-icon"></i>
                                    {if $list.author_url}
    								<img src="{$list.author_url}" /><br>
    								{/if}
    								使用{$list.title}
                            </label>
                        </div>
    					{/foreach}
					</div>
					
					<p>
    					<label class="mdui-checkbox">
                            <input type="checkbox" nid="terms" name="terms" value="1" required checked/>
                            <i class="mdui-checkbox-icon"></i>
                            我已阅读并同意<a href="{$Setting.web_tos_url}" target="blank">服务条款</a>
                        </label>
                    </p>

                </div>
                <div class="mdui-card-actions">
                    {if $ShopData.cart_products}
					    <button class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme" type="submit"><i class="mdui-icon material-icons">shopping_cart</i> 立即结算（订单总金额：{$ShopData.total_desc}）</button>
					{else}
					<button class="mdui-btn mdui-btn-raised mdui-color-blue-a400" type="submit" disabled><i class="mdui-icon material-icons">block</i> 购物车中必须有至少一项实例配置后才能结算！</button>
					{/if}
					
					{if count($ShopData.cart_products) > 1}
                        <span><i class="mdui-icon material-icons mdui-text-color-orange">info</i> 您即将结算的实例多于1个！请确认您需要多个实例，而不是错误地添加了多个。</span>
                    {/if}
				</div>
            </div>
        </div>
    </div>
    {else}
    
    <div class="mdui-row mdui-m-y-1">
        <div class="mdui-col">
            <div class="mdui-card mdui-hoverable">
            
                <div class="mdui-card-primary">
                    <div class="mdui-card-primary-title">
                        决定好配置了？
                    </div>
                </div>
                
                <div class="mdui-card-content">
					
					<p>
    					订单总金额：{$ShopData.total_desc}。立即登录账户以结算。
                    </p>

                </div>
                <div class="mdui-card-actions">
					    <a href="/login" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme"><i class="mdui-icon material-icons">person_add</i> 登录账户</a>
				</div>
            </div>
        </div>
    </div>
    
    {/if}

    
    
    
</form>


<script>
	$(function() {
		if(navigator.userAgent.match(/mobile/i)) {
			$('.mobile-bottom-total').show()
			$('.mobile-hide').remove()
		}else{
			$('.mobile-bottom-total').remove()
		}
	})
</script>
<!-- 删除确认 -->
<div class="modal fade" id="customModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="customTitle">{$Lang.prompt}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="customBody">

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
				<button type="button" class="btn btn-primary" id="customSureBtn">{$Lang.determine}</button>
			</div>
		</div>
	</div>
</div>

<style>
	.list-inline-item .icon {
		width: 2rem;
		height: 2rem;
	}

	.social-list-item {
		border: none;
	}
</style>



<style>

	@media screen and (max-width: 755px) {
		.checkboxDiv {
			width: 100% !important;
		}
		.checkDiv{
			display:block !important;
		}
	}
	.payType {
		cursor: pointer;
	}

	.payType.active,
	.payType:hover {
		border-color: #2948df !important;
	}

	.new-user {
		display: none;
	}

	.fas {
		cursor: pointer;
	}

	.number {
		width: 50px;
	}

	.remarksInput::-webkit-input-placeholder{
		color: #CACACA;
	}
</style>

<script>
	function init_tpl()
	{
		var checkbox = $('.payment-checkbox');
		checkbox.map(function (k, v) {
			if($(v).prop('checked'))
			{
				// 移除支付方式选中
				$(".addfunds-payment").removeClass("active").find(".hidden").removeAttr("checked")
			}
		})
	}
	init_tpl();
</script>