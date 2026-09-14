<script>
	$(function () {
		// 状态筛选
		var parmas = []
		var urlParams = '{:implode(',', $Think.get.domain_status)}';
		var statusSelected = urlParams.split(',')
		if(!statusSelected[0]){
			statusSelected=['Pending','Active','Suspended']
		}
		
		if ($.inArray("Pending",statusSelected) == -1) {
            $("#statusCheckbox").attr("checked","checked")
            $("#statusCheckboxLable").attr("href","service?groupid={$Think.get.groupid}")
        }
        
        $('#statusSel').selectpicker('val', statusSelected)
		$('#statusSel').on('change', function () {

			statusSelected = $('#statusSel').val()
			statusSelected.forEach(item => {
				parmas += '&domain_status[]=' + item
			})

			location.href = 'service?groupid={$Think.get.groupid}' + parmas
		});
		// 关键字搜索
		$('#searchInp').val('{$Think.get.keywords}')

		$('#searchInp').on('keydown', function (e) {
			if (e.keyCode == 13) {
				location.href = 'service?groupid={$Think.get.groupid}&keywords=' + $('#searchInp').val() +
						'&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page={$Think.get.page}&limit={$Think.get.limit}'
			}
		})
		$('#searchIcon').on('click', function () {
			location.href = 'service?groupid={$Think.get.groupid}&keywords=' + $('#searchInp').val() +
					'&sort={$Think.get.sort}&orderby={$Think.get.orderby}&page={$Think.get.page}&limit={$Think.get.limit}'
		});
		// 设置样式

		// 排序
		$('.bg-light th:not(.checkbox)').on('click', function () {
			var sort = '{$Think.get.sort}'
			location.href = 'service?groupid={$Think.get.groupid}&keywords={$Think.get.keywords}&sort=' + (sort ==
					'desc' ? 'asc' : 'desc') + '&orderby=' + $(this).attr('prop') +
					'&page={$Think.get.page}&limit={$Think.get.limit}'
		})
		changeStyle()
		function changeStyle() {
			$('.text-black-50.d-inline-flex.flex-column.justify-content-center.ml-1.offset-3').children().css('color','rgba(0, 0, 0, 0.1)')
			var sort = '{$Think.get.sort}'
			var orderby = '{$Think.get.orderby}'
			let index
			if(orderby === 'domainstatus') {
				if (sort === 'desc') {
					index = 1
				} else if(sort === 'asc') {
					index = 0
				}
			} else if(orderby === 'nextduedate') {
				if (sort === 'desc') {
					index = 3
				} else if(sort === 'asc') {
					index = 2
				}
			}
			$('.text-black-50.d-inline-flex.flex-column.justify-content-center.ml-1.offset-3').children().eq(index).css('color','rgba(0, 0, 0, 0.8)')
		}
	})
</script>
<div class="mdui-row mdui-m-y-1">
    <div class="mdui-col">
        <div class="mdui-card mdui-hoverable" style="overflow: visible;">
            <div class="mdui-card-content">
                                <div class="table-header">
    				<div class="table-filter">
    					<div class="row">
    					    <div class="col">
    					        <a href="service?groupid={$Think.get.groupid}&domain_status[]=Active" class="mdui-switch" id="statusCheckboxLable">
                                    <input type="checkbox" id="statusCheckbox"/>
                                    <i class="mdui-switch-icon"></i>
                                </a> 仅显示已开通产品
    							<select class="selectpicker" id="statusSel" data-style="btn-default" title="{$Lang.please_select_status}" multiple>
    								{foreach $Service.domainstatus as $key => $list}
    									<option value="{$key}">{$Lang['domainstatus_select_'.strtolower($key)]}</option>
    								{/foreach}
    							</select>
    							{if (isset($nav_info.orderFuc) && $nav_info.orderFuc)}
    								<a href="{$nav_info.orderFucUrl}" class="btn btn-sm btn-primary w-xs">{$Lang.ordering_products}</a>
    							{/if}
    						</div>
    					</div>
    				</div>
    				<!-- wyh 20210331 增加产品转移hook模板template_after_service_domainstatus_selected-->
    				{php}$hooks=hook('template_after_service_domainstatus_selected');{/php}
    				{if $hooks}
    					{foreach $hooks as $item}
    						{$item}
    					{/foreach}
    				{/if}
    				<!-- 结束 -->
    				<div class="table-search">
    					<div class="row justify-content-end">
    						<div class="col-sm-6">
    							<div class="search-box">
    								<div class="position-relative">
    									<input type="text" class="form-control" id="searchInp" placeholder="{$Lang.search_by_keyword}">
    									<i class="bx bx-search-alt search-icon" id="searchIcon"></i>
    								</div>
    							</div>
    						</div>
    					</div>
    				</div>
    			</div>
            </div>
        </div>
        <br>
    </div>
</div>