<style>
	.was-validated .custom-control-input:valid~.custom-control-label::before {
		background-color: #fff;
	}

	.bootstrap-select.is-valid .dropdown-toggle,
	.was-validated .bootstrap-select select:valid+.dropdown-toggle {
		border-color: #ced4da !important;
	}

	.form-control.is-valid,
	.was-validated .form-control:valid {
		display: block;
		width: 100%;
		padding: 0.47rem 0.75rem;
		font-size: 0.8125rem;
		font-weight: 400;
		line-height: 1.5;
		color: #495057;
		background-color: #fff;
		background-clip: padding-box;
		border: 1px solid #ced4da;
		border-radius: 0.25rem;
		background-image: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiP…45NSwyLjI2LDYsMi4xMyw2LDJWMS41QzYsMS4yMiw1Ljc4LDEsNS41LDF6Ii8+Cjwvc3ZnPgo=);
		background-position-y: 50%;
		background-position-x: calc(100% - 11px);
		background-repeat: no-repeat;
		padding-right: 24px;
	}

	.cycle-select-discount {
		position: absolute;
		top: -10px;
		right: 0;
		display: inline-block;
		padding: 0px 5px;
		height: 15px;
		background: #F70302;
		border-radius: 5px 5px 5px 0px;
		color: #ffffff;
		font-size: 12px;
		text-align: center;
		line-height: 15px;
	}

	.error-tip {
		color: #f46a6a;
		margin: 0;
		padding: 0;
		line-height: 36px;
		display: none;
	}

	input::-webkit-input-placeholder {
		color: #cacdd4 !important;
	}

	input:-moz-placeholder {
		color: #cacdd4 !important;
	}

	input::-moz-placeholder {
		color: #cacdd4 !important;
	}

	input:-ms-input-placeholder {
		color: #cacdd4 !important;
	}

	.btn-custom {
		min-width: 72px;
		height: 28px;
		border: #F0F0F0 1px solid;
		border-radius: 4px;
		line-height: 11px;
	}

	.btn-custom-group .active {
		background-color: #2948DF;
		color: #fff;
	}



	.form-check {
		margin-left: 20px;
	}

	.justify-content-start {
		flex-wrap: wrap;
	}

	@media (max-width: 992px) {
		.footer {
			z-index: 1;
			display: none !important;
		}
	}
</style>
{if !$Userinfo && $CustomDepot.yangmdui_logout_hide_price == "true"}

    <div class="mdui-card mdui-p-b-1">
        <div class="mdui-card-primary">
            <div class="mdui-card-primary-title">
                发生错误
            </div>
        </div>
        <div class="mdui-card-content">
            <i class="mdui-icon material-icons">block</i> 您没有权限获取产品配置信息。请先<a class="mdui-text-color-theme-accent" href="/login">登录</a>。
        </div>
        <div class="mdui-card-actions">
            <a href="/login" class="mdui-btn mdui-btn-raised mdui-color-theme">单击此处登录{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}</a>
        </div>
    </div>

{else}

{if isset($Get.i)}
<form id="addCartForm" method="post" class="needs-validation configoption_form" novalidate
	action="?action=configureproduct&pid={$CartConfig.product.id}&pos[]={$Think.get.i}">
	<input type="hidden" name="i" value="{$Think.get.i}" />
	{else/}
	<form id="addCartForm" method="post" class="needs-validation configoption_form" novalidate
		action="?action=configureproduct&pid={$CartConfig.product.id}{if $Get.site}&site={$Get.site}{/if}">
		{/if}
		<div class="mdui-row mdui-p-b-1">
			<div class="mdui-col-xs-12">
    			{if $ErrorMsg}
    			<div class="alert alert-danger">
    				<a href="#" class="close" data-dismiss="alert">
    					&times;
    				</a>
    				<strong>{$ErrorMsg}</strong>
    			</div>
    			{/if}
				<div class="mdui-card">
				    <div class="mdui-card-primary">
                        <div class="mdui-card-primary-title">
                            选配页面：{$CartConfig.product.name}
                        </div>
                    </div>
					<div class="mdui-card-content">
                        您正在浏览{$CartConfig.product.name}的配置选项。<br>
                        您可以在此页面查看所有可用配置项，并按实际业务需求修改配置参数。<br>
                        当您修改配置选项后，新的价格会被计算并在本页面下方列出。当您确认一切正常时，您可以单击“添加到购物车”以保存配置项。<br>
                        保存后，您可以在购物车概览中找到此产品和对应的配置，并与您挑选的其他产品一起下订单。
					</div>
				</div>
			</div>
		</div>
		
		<div class="mdui-row mdui-p-b-1">
			<div class="mdui-col-xs-12">

				<div class="mdui-card">
					<div class="mdui-card-content">



						<input type="hidden" name="pid" value="{$CartConfig.product.id}" />
						<input type="hidden" name="currencyid" value="{$CartConfig.dafault_currencyid}" />
						<input name="qty" type="hidden" value="1" />
						
						{if(isset($addParam.promocode))}
						<input type="hidden" name="promocode" value="{$addParam.promocode}" />
						{/if}
						
						{if(isset($addParam.aff))}
						<input type="hidden" name="aff" value="{$addParam.aff}" />
						{/if}
						
						{if(isset($addParam.sale))}
						<input type="hidden" name="sale" value="{$addParam.sale}" />
						{/if}
						
						<!--产品配置项-->
						{foreach $CartConfig.option as $option}
						
						{if $option.option_type==1}
						
						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
						<div>{$option.notes}</div>
						<select class="mdui-select" id="config{$option.id}" name="configoption[{$option.id}]" mdui-select>
					        {foreach $option.sub as $sub}
					        <option id="sub{$sub.id}" {if $CartConfig.config_options[$option.id]==$sub.id} selected="" {elseif
										$getUrlConfig.config_options[$option.id]==$sub.id && !$CartConfig.config_options} selected="" {/if}
										value="{$sub.id}">{$sub.option_name}</option>
                            {/foreach}
                        </select>
						


						{elseif $option.option_type==20 /}
						
						<div class="lingAge-{$option.id}">
    						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
    						<div>{$option.notes}</div>
    						<div class="mdui-row-xs-1 mdui-row-md-5">
    					        {foreach $option.sub as $sub_key=>$sub_val}
    					        <div class="mdui-col">
    						        <label class="mdui-radio">
                                        <input id="config{$option.id}_{$sub_val.id}" type="radio" data-optionid="{$option.id}"
												data-subid="{$sub_val.id}" name="configoption[{$option.id}]" value="{$sub_val.id}"
											     {if $CartConfig.config_options[$option.id]==$sub_val.id}checked {elseif
												(($option.checkSubId==$sub_val.id) && !$CartConfig.config_options) /} checked {elseif
												$getUrlConfig.config_options[$option.id]==$sub_val.id && !$CartConfig.config_options} checked
												{/if}>
                                        <i class="mdui-radio-icon"></i>
                                        {$sub_val.option_name}
                                    </label>
                                </div>
                                {/foreach}
    						</div>
    					</div>
    					
    					<div class="lingAge-{$option.id}-son">
    					{if (isset($option.son) && $option.son)}
						{foreach $option.son as $son_k1 => $son_v1}
						
    						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$son_v1.option_name}</div>
    						<div>{$son_v1.notes}</div>
    						<div class="mdui-row-xs-1 mdui-row-md-5">
    					        {foreach $son_v1.sub as $sub_key=>$sub_val}
    					        <div class="mdui-col">
    						        <label class="mdui-radio">
                                        <input id="config{$son_v1.id}_{$sub_val.id}" type="radio" data-optionid="{$option.id}"
													data-subid="{$sub_val.id}" name="configoption[{$son_v1.id}]" value="{$sub_val.id}"
													{if $CartConfig.config_options[$son_v1.id]==$sub_val.id}checked=""
													{elseif (($son_v1.checkSubId==$sub_val.id) && !$CartConfig.config_options) /} checked="" {elseif
													$getUrlConfig.config_options[$son_v1.id]==$sub_val.id && !$CartConfig.config_options} checked=""
													{/if}>
                                        <i class="mdui-radio-icon"></i>
                                        {$sub_val.option_name}
                                    </label>
                                </div>
                                {/foreach}
    						</div>
    						
    					{/foreach}
						{/if}
    					</div>

						{elseif $option.option_type==2 /}
						
						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
						<div>{$option.notes}</div>
						<div class="mdui-row-xs-1 mdui-row-md-5">
					        {foreach $option.sub as $sub_key=>$sub_val}
					        <div class="mdui-col">
						        <label class="mdui-radio">
                                    <input id="config{$option.id}_{$sub_val.id}" type="radio" name="configoption[{$option.id}]"
										value="{$sub_val.id}" {if
										$CartConfig.config_options[$option.id]==$sub_val.id}checked="" {elseif $sub_key==0 &&
										!$CartConfig.config_options /} checked="" {elseif
										$getUrlConfig.config_options[$option.id]==$sub_val.id && !$CartConfig.config_options} checked=""
										{/if}>
                                    <i class="mdui-radio-icon"></i>
                                    {$sub_val.option_name}
                                </label>
                            </div>
                            {/foreach}
						</div>
						
						
						{elseif $option.option_type==3 /}
						
						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
						<div>{$option.notes}</div>
						<div class="mdui-row-xs-1 mdui-row-md-5">
					        {foreach $option.sub as $sub_key=>$sub_val}
					        <div class="mdui-col">
						        <label class="mdui-checkbox">
                                    <input id="config{$option.id}_{$sub_val.id}" type="checkbox" name="configoption[{$option.id}]"
										{if $CartConfig.config_options[$option.id]==$sub_val.id} checked=""
										{elseif $getUrlConfig.config_options[$option.id]==$sub_val.id && !$CartConfig.config_options}
										checked="" {/if} value="{$sub_val.id}">
                                    <i class="mdui-checkbox-icon"></i>
                                    {$sub_val.option_name}
                                </label>
                            </div>
                            {/foreach}
						</div>
						
						
						
						{elseif $option.option_type==4 || $option.option_type==7 || $option.option_type==9 ||
						$option.option_type==11 || $option.option_type==14 || $option.option_type==15 || $option.option_type==16 ||
						$option.option_type==17 || $option.option_type==18 || $option.option_type==19 /}
						
						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
						<div>{$option.notes}</div>
						<div class="mdui-row mdui-p-y-2">
                            <div class="mdui-col-sm-8">
                                <input type="range" id="config_range_{$option.id}" min="{$option.qty_minimum}" max="{$option.qty_maximum}"
                                    step="{$option.qty_stage == 0 ? 1 : $option.qty_stage}" {if $CartConfig.config_options[$option.id]}
                                    value="{$CartConfig.config_options[$option.id]}" {elseif $getUrlConfig.config_options[$option.id] &&
                                    !$CartConfig.config_options} value="{$getUrlConfig.config_options[$option.id]}" {else /}
                                    value="{$option.qty_minimum}" {/if} data-sub='{:json_encode($option.sub)}'
                                    class="" onchange="rangeChange(this,{$option.id})" style="width: 100%;">
                            </div>
                            <div class="mdui-col-sm-3">
                                <input id="config{$option.id}" data-type="number" class="mdui-textfield-input" style="width:100%"
                                    name="configoption[{$option.id}]" onchange="numberKeyup(this,{$option.id})" type="text"
                                    min="{$option.qty_minimum}" max="{$option.qty_maximum}"
                                    step="{$option.qty_stage == 0 ? 1 : $option.qty_stage}" {if $CartConfig.config_options[$option.id]}
                                    value="{$CartConfig.config_options[$option.id]}" {elseif $getUrlConfig.config_options[$option.id] &&
                                    !$CartConfig.config_options} value="{$getUrlConfig.config_options[$option.id]}" {else /}
                                    value="{$option.qty_minimum}" {/if}>
                            </div>
                            <div class="mdui-col-sm-1">
                                <span>{$option.unit}</span>
                            </div>
                        </div>
                        
                        
							
							
							{elseif $option.option_type==6 || $option.option_type==8 || $option.option_type==10 ||
							$option.option_type==13 /}
							
							<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
    						<div>{$option.notes}</div>
    						<div class="mdui-row-xs-1 mdui-row-md-5">
    					        {foreach $option.sub as $sub_key=>$sub_val}
    					        <div class="mdui-col">
    						        <label class="mdui-radio">
    						            <input id="config{$option.id}_{$sub_val.id}" type="radio" {if
												$CartConfig.config_options[$option.id]==$sub_val.id}checked="" {elseif $sub_key==0 &&
												!$CartConfig.config_options /} checked="" {elseif
												$getUrlConfig.config_options[$option.id]==$sub_val.id && !$CartConfig.config_options} checked=""
												{/if} name="configoption[{$option.id}]" value="{$sub_val.id}">
                                        <i class="mdui-radio-icon"></i>
                                        {$sub_val.option_name}
                                    </label>
                                </div>
                                {/foreach}
    						</div>
							
							
							{elseif $option.option_type==5 /}
							<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
						    <div>{$option.notes}</div>
						    {if $option.sub.os }
									<select id="config{$option.id}" name="configoption[{$option.id}]"
										class="form-control selectpicker configoption_os selectpicker_refresh" data-style="btn-default">
										{foreach $option.sub.os.child as $sub}
										<option id="sub{$sub.id}" value="{$sub.id}" {if
											$CartConfig.config_options[$option.id]==$sub.id}selected="" {elseif
											$getUrlConfig.config_options[$option.id]==$sub.id && !$CartConfig.config_options} selected=""
											{/if}>
											{$sub.version}
										</option>
										{/foreach}
									</select>
						    {else/}
									<select class="form-control configoption_os_group selectpicker" data-style="btn-default"
										onchange="osGroupChange(this)">
										{foreach $option.sub as $sub_key=>$sub_val}
										{assign name="os_selected" value="" /}
										{foreach $sub_val.child as $child_key=>$child_val}
										{if $child_val.id==$CartConfig.config_options[$option.id]}
										{assign name="os_selected" value="$sub_key" /}
										{/if}
										{/foreach}
										{if strtolower($sub_key)=="windows"}
										{assign name="os_svg" value="1" /}
										{elseif strtolower($sub_key)=="centos"/}
										{assign name="os_svg" value="2" /}
										{elseif strtolower($sub_key)=="ubuntu"/}
										{assign name="os_svg" value="3" /}
										{elseif strtolower($sub_key)=="debian"/}
										{assign name="os_svg" value="4" /}
										{elseif strtolower($sub_key)=="esxi"/}
										{assign name="os_svg" value="5" /}
										{elseif strtolower($sub_key)=="xenserver"/}
										{assign name="os_svg" value="6" /}
										{elseif strtolower($sub_key)=="freebsd"/}
										{assign name="os_svg" value="7" /}
										{elseif strtolower($sub_key)=="fedora"/}
										{assign name="os_svg" value="8" /}
										{else/}
										{assign name="os_svg" value="9" /}
										{/if}
										<option
											data-content="<img class='mr-1' src='/upload/common/system/{$os_svg}.svg' height='20'/>{$sub_key}"
											{if $os_selected}selected="" {elseif $getUrlConfig.config_options[$option.id]==$child_val.id
											&& !$CartConfig.config_options} selected="" {/if} data-os='{:json_encode($sub_val.child)}'
											value="{$sub_key}">
											{$sub_key}</option>
										{/foreach}
									</select>
									<select id="config{$option.id}" name="configoption[{$option.id}]"
										class="form-control selectpicker_refresh configoption_os" {if
										$CartConfig.config_options[$option.id]} data-os-selected="{$CartConfig.config_options[$option.id]}"
										{elseif $getUrlConfig.config_options[$option.id] && !$CartConfig.config_options}
										data-os-selected="{$getUrlConfig.config_options[$option.id]}" {/if} data-style="btn-default">

									</select>
								{/if}


							{elseif $option.option_type==12 /}
							<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">settings</i> {$option.option_name}</div>
						    <div>{$option.notes}</div>

                                    
									{if $option.sub.0.area.0.area_zh}
                                        <select id="config{$option.id}" name="configoption[{$option.id}]"
                                                class="form-control col-md-3 selectpicker" data-style="btn-default">
                                            {foreach $option.sub as $sub_key=>$sub_val}
                                                {foreach $sub_val.area as $area}
                                                    <option id="sub{$area.id}"
                                                            data-content="<img class='mr-1' src='/upload/common/country/{$sub_val.country_code}.png' height='20'/>{$sub_val.option_name}{$area.area_zh}"
                                                            value="{$area.id}"
                                                            {if $CartConfig.config_options[$option.id]==$area.id}
                                                                selected=""
                                                            {elseif $getUrlConfig.config_options[$option.id]==$area.id && !$CartConfig.config_options}
                                                                selected=""
                                                            {/if}
                                                    >
                                                        {$sub_val.option_name}{$area.area_zh}
                                                    </option>
                                                {/foreach}
                                            {/foreach}
                                        </select>
                                    {else}
                                        <div class="btn-group-toggle mt-2 mt-xl-0" data-toggle="buttons">
                                            {foreach $option.sub as $sub_key=>$sub_val}
                                                <label class="btn btn-primary mr-2">
                                                    <input id="config{$option.id}_{$sub_val.area.0.id}" type="radio"
                                                           {if $CartConfig.config_options[$option.id]==$sub_val.area.0.id}
                                                               checked=""
                                                           {elseif $sub_key==0 && !$CartConfig.config_options}
                                                               checked=""
                                                           {elseif $getUrlConfig.config_options[$option.id]==$sub_val.area.0.id && !$CartConfig.config_options}
                                                               checked=""
                                                           {/if}
                                                           name="configoption[{$option.id}]" value="{$sub_val.area.0.id}">
                                                    {if $sub_val.country_code}
                                                        <img class='mr-1' src='/upload/common/country/{$sub_val.country_code}.png' height='20' />
                                                    {/if}
                                                    {$sub_val.option_name?:$Lang.defaults}
                                                </label>
                                            {/foreach}
                                        </div>
                                    {/if}
						
						{/if}

                        <hr>

						{/foreach}
						<!--自定义字段-->
						{foreach $CartConfig.custom_fields as $custom_fields}
						{if $custom_fields.fieldtype=="dropdown"}
						<div class="form-group row">
							<label for="example-search-input" class="col-md-2 col-form-label">{$custom_fields.fieldname}</label>
							<div class="col-md-3">
								<select id="customfield[{$custom_fields.id}]" name="customfield[{$custom_fields.id}]"
									class="form-control selectpicker" data-style="btn-default" {if $custom_fields.required}required{/if}>
									{foreach $custom_fields.dropdown_option as $dropdown_option} <option value="{$dropdown_option}" {if
									$CartConfig.custom_fields_value[$custom_fields.id]==$dropdown_option}selected="" {/if}>
									{$dropdown_option}</option> {/foreach} </select> </div> </div> {elseif
									$custom_fields.fieldtype=="tickbox" /} <div class="form-group row">
									<label for="example-search-input" class="col-md-2 col-form-label">{$custom_fields.fieldname}</label>
									<div class="col-md-10">
										<div class="custom-control custom-checkbox mb-3">
											<input name="customfield[{$custom_fields.id}]" {if
												$CartConfig.custom_fields_value[$custom_fields.id]==1}checked="" {/if} type="checkbox"
												class="custom-control-input" id="customfields{$custom_fields.id}">
											<label class="custom-control-label"
												for="customfields{$custom_fields.id}">{$custom_fields.description}</label>
										</div>
									</div>
							</div>
							{elseif $custom_fields.fieldtype=="textarea" /}
							<div class="form-group row">
								<label for="example-search-input" class="col-md-2 col-form-label">{$custom_fields.fieldname}</label>
								<div class="col-md-3">
									<textarea id="customfield[{$custom_fields.id}]" name="customfield[{$custom_fields.id}]"
										class="form-control getTextareaVal"
										data-object="{$custom_fields.required}||{$custom_fields.regexpr}" rows="2"
										placeholder="{$custom_fields.description}" {if
										$custom_fields.required}required{/if}>{$CartConfig.custom_fields_value[$custom_fields.id]}
										</textarea> </div> </div> {else/} <div class="form-group row">
							<label for="example-search-input" class="col-md-2 col-form-label">{$custom_fields.fieldname}</label>
							<div class="col-md-3">
								<input class="form-control getVal" data-object="{$custom_fields.required}||{$custom_fields.regexpr}" id="customfield[{$custom_fields.id}]" name="customfield[{$custom_fields.id}]"
									value="{$CartConfig.custom_fields_value[$custom_fields.id]}" type="{$custom_fields.fieldtype}"
									placeholder="{$custom_fields.description}" {if $custom_fields.required}required{/if} />
							</div>
						</div>
						{/if}
						{/foreach}
						
						<!-- 计费周期 -->
						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">access_alarm</i> 付费周期</div>
						<div>付费周期同时也是实例购买时长。其中“月”、“季”、“半年”、“年”时长均按下单所在月份的自然月时长、当月及之后共3、6、12个自然月计算。</div>
						<div class="mdui-row-xs-1 mdui-row-md-5">
					        {foreach $CartConfig.product.cycle as $cycle_key=>$cycle}
					        <div class="mdui-col">
						        <label class="mdui-radio">
                                    <input type="radio" name="billingcycle" value="{$cycle.billingcycle}" {if $CartConfig.billingcyle==$cycle.billingcycle}checked{elseif $cycle.is_checked==1 && !$CartConfig.billingcyle && !$addParam.billingcycle /}checked{elseif $addParam.billingcycle==$cycle.billingcycle && !$CartConfig.billingcyle /}checked{/if}>
                                    <i class="mdui-radio-icon"></i>
                                    {$cycle.billingcycle_zh}{if $cycle.cycle_discount}({$cycle.cycle_discount}折优惠){/if}
                                </label>
                            </div>
                            {/foreach}
						</div>
						
						
						<div {if $CartConfig.product.host.show==0} style="display:none" {/if}>
						    <hr>
    						<div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">account_circle</i> 主机名</div>
    						<div>主机名可用于标识实例，在同一可用区中唯一。云服务器在同用户同账户内网中，不同实例可通过主机名快速互联互通。</div>
    						<div class="mdui-textfield">
                                <input class="mdui-textfield-input" type="text" placeholder="Hostname" {if $CartConfig.host}value="{$CartConfig.host}" {else /}value="{$CartConfig.product.host.host}"{/if} disabled/>
                            </div>
                            <input class="mdui-textfield-input" name="host" type="hidden" {if $CartConfig.host}value="{$CartConfig.host}" {else /}value="{$CartConfig.product.host.host}"{/if}/>
                        </div>
                        
                        
                        <div {if $CartConfig.product.password.show==0} style="display:none" {/if}>
                            <hr>
                            <div class="mdui-typo-title mdui-text-color-theme"><i class="mdui-icon material-icons">lock</i> 实例密码</div>
    						<div>在此指定实例初始密码，用于初始化账户。</div>
    						<div class="mdui-row">
    						    <div class="mdui-col-xs-8">
            						<div class="mdui-textfield">
                                        <input id="password" name="password" class="mdui-textfield-input getPassword" type="text" placeholder="Password" {if $CartConfig.password}value="{$CartConfig.password}"{else/}value="{$CartConfig.product.password.password}"{/if}/>
                                    </div>
                                </div>
                                <div class="mdui-col-xs-4">
                                    <a class="mdui-btn" onclick="showPwd()"><i class="mdui-icon material-icons">remove_red_eye</i> 查看密码</a>
                                    <a class="mdui-btn create_random_pass" onclick="randomPwd()"><i class="mdui-icon material-icons">refresh</i> 随机密码</a>
                                </div>
                            </div>
                        </div>



					</div>
				</div>
			</div>
			
		</div>
		
		<div class="configoption_total">
            
		</div>
		<script>
		$(document).on('click', ".configoption_form input[type='radio'],.configoption_form input[type='checkbox'],.configoption_form input[type='radio']", function () {
		    $(".configoption_total").html("<div class='mdui-row mdui-p-b-1'><div class='mdui-col-xs-12'><div class='mdui-card'><div class='mdui-card-content'><div class='mdui-spinner mdui-spinner-colorful'></div> 正在计算价格，请稍后...</div></div></div></div>");
		})
		</script>

	</form>
	<!-- select -->
	<link rel="stylesheet"
		href="/themes/cart/yang-mdui-re-cart/assets/js/bootstrap-select/css/bootstrap-select.min.css?v={$Ver}">
	<script src="/themes/cart/yang-mdui-re-cart/assets/js/bootstrap-select/js/bootstrap-select.min.js?v={$Ver}"></script>
	<!-- slider -->
	<link rel="stylesheet"
		href="/themes/cart/yang-mdui-re-cart/assets/js/ion-rangeslider/css/ion.rangeSlider.min.css?v={$Ver}">
	<script src="/themes/cart/yang-mdui-re-cart/assets/js/ion-rangeslider/js/ion.rangeSlider.min.js?v={$Ver}"></script>
	<script>
		// 密码重置
		var pwdRule = {
			len_num: '{$CartConfig.product.password.rule.len_num}',
			num: '{$CartConfig.product.password.rule.num}',
			upper: '{$CartConfig.product.password.rule.upper}',
			lower: '{$CartConfig.product.password.rule.lower}',
			special: '{$CartConfig.product.password.rule.special}'
		}
		var links = {:json_encode($CartConfig.links)};
		var order_frm_tpl = '{$order_frm_tpl}';
		var tpl_type = '{$tpl_type}';

		$(document).ready(function(){ 
			let dom=$('.dropdown-menu .inner .show')
			for(let item of dom){
				item.style.maxHeight="300px"
			}
		}); 

		$(function(){
			$("#addCartForm").on('blur',".getVal",function(e){
				let arr=e.target.dataset.object.split('||')
				let reg=''
				if(arr[1]!='') reg=new RegExp(arr[1])
				if(arr[0]==1){
					if(e.target.value==''){
						e.target.classList.add("is-invalid");
					}else if(reg!='' && reg.test(e.target.value)==false){
						e.target.classList.add("is-invalid");
					}else{
						e.target.classList.remove("is-invalid");
					}
				}
			})
		})

		$(function(){
			$("#addCartForm").on('blur',".getTextareaVal",function(e){
			
				let arr=e.target.dataset.object.split('||')
				let reg=''
				if(arr[1]!='') reg=new RegExp(arr[1])
				if(arr[0]==1){
					if(e.target.value==''){
						e.target.classList.add("is-invalid");
					}else if(reg!='' && reg.test(e.target.value)==false){
						e.target.classList.add("is-invalid");
					}else{
						e.target.classList.remove("is-invalid");
					}
				}
			})
		})

		function randomPwd () {
			verConfigGPsd()
		}

	// 获取主机密码校验规则
	var passwordRules =  {:json_encode($CartConfig.product.password.rule)};
	var showPassword = {:json_encode($CartConfig.product.password.show)};
	
	$(document).on('blur', '.getPassword', function(){
		verConfigGPsd()
	})

	function verConfigGPsd() {
		setTimeout(function(){
			let result = checkingPwd1($(".getPassword").val(), passwordRules.num, passwordRules.upper, passwordRules.lower, passwordRules.special)
			if(result.flag) {
				$('#password-error-tip').css('display','none');
				$('.getPassword').removeClass("is-invalid");
			}else{
				$("#password-error-tip").html(result.msg);
				$(".getPassword").addClass("is-invalid");
				$('#password-error-tip').css('display','block');
			}
		},10)
	}
	</script>
	<script src="/themes/cart/yang-mdui-re-cart/assets/js/configureproduct.js?v={$Ver}"></script>
	<!-- 滑块禁用区域 -->
	<script>
		$('.configoption_range').each(function(){
			let sub = $(this).data('sub');
			let max = parseFloat($(this).attr('max'));
			let min = parseFloat($(this).attr('min'));
			let inputWidth = parseFloat($(this).width());
			let oneWidth = inputWidth / (max - min)
			let keyArr = [];
			sub.map(item => {
				let itemMin = parseFloat(item.qty_minimum)
				let itemMax = parseFloat(item.qty_maximum)
				keyArr.push(itemMin)
				for(var i = itemMin; i<itemMax; i++) {
					keyArr.push(i)
				}
				keyArr.push(itemMax)
			})
			keyArr = Array.from(new Set(keyArr));
			for(var t = min; t<max; t++) {
				if(keyArr.indexOf(t) == -1) {
					$(this).after('<span class="range_none" title="'+t+'" style="width: '+oneWidth+'px; left: '+oneWidth*(t-min)+'px "></span>')
				}
			}
		})					
	</script>

{/if}

<script>
function rangeChange(input,id) {
    const textInput = document.getElementById('config' + id);
    textInput.value = input.value;
    configoption_ajax();
}

function numberKeyup(input,id) {
    const rangeInput = document.getElementById('config_range_' + id);
    const value = parseFloat(input.value);
    const min = parseFloat(rangeInput.min);
    const max = parseFloat(rangeInput.max);
    const step = parseFloat(rangeInput.step);

    if (!isNaN(value)) {
        if (value < min) {
            input.value = min;
            rangeInput.value = min;
        } else if (value > max) {
            input.value = max;
            rangeInput.value = max;
        } else {
            const remainder = (value - min) % step;
            if (remainder!== 0) {
                input.value = Math.round((value - remainder) / step) * step + min;
            }
            rangeInput.value = input.value;
        }
    } else {
        input.value = rangeInput.min;
        rangeInput.value = rangeInput.min;
    }
    configoption_ajax();
}
</script>