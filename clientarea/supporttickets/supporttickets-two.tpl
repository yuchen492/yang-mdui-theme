{include file="includes/summernote" height="250"}
{include file="includes/markdown" height="250"}
<style>
   .was-validated .custom-control-input:valid ~ .custom-control-label::before{
    background-color: #fff;
  }
  .bootstrap-select.is-valid .dropdown-toggle, .was-validated .bootstrap-select select:valid+.dropdown-toggle{
      border: 1px solid #ced4da;
  }
    .biankuang{
    border: 1px solid #ced4da;
  }
  .form-control.is-valid, .was-validated .form-control:valid{
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
</style>
<form method="post" class="needs-validation" novalidate enctype="multipart/form-data">
<div class="mdui-card">
	<div class="mdui-card-content">
    
		    <div class="mdui-textfield">
                <label class="mdui-textfield-label">目标部门</label>
                <select class="mdui-select" id="dptid" name="dptid" onchange="window.location.href='submitticket?step=2&dptid='+$(this).val()">
                {foreach $SubmitTicket.department as $department}
					<option value="{$department.id}" {if $Think.get.dptid==$department.id}selected{/if}>
					    {$department.name}
					</option>
				{/foreach}
				</select>
            </div>
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">关联产品</label>
                <select class="mdui-select" id="hostid" name="hostid">
                {foreach $SubmitTicket.ticketpage.host_list as $key => $host}
				    <option value="{$key}" {if $Think.get.pid==$key}selected{/if}>
				        {$host}
				    </option>
				{/foreach}
				</select>
            </div>
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">优先级</label>
                <select class="mdui-select" id="priority" name="priority">
                {foreach $SubmitTicket.ticketpage.priority as $key => $priority}
					<option value="{$key|strtolower}" {if $key=='Medium' }selected{/if}>
					    {$priority}
					</option>
				{/foreach}
				</select>
            </div>
            {foreach $ticketCustom as $k => $list}
													<div class="form-group">
														<label for="{$list.id}">{$list.fieldname}</label>
														{if $list.fieldtype == 'dropdown'}
															<!-- 下拉 -->
															<select name="customfield[{$list.id}]" class="form-control " {$list.required ? 'required' : ''}>
																{foreach $list.dropdown_option as $key => $val}
																	<option value="{$key}" {if(isset($_fields[$key]))} selected {/if}>{$val}</option>
																{/foreach}
															</select>
														{elseif $list.fieldtype == 'password'}
															<!-- 密码 -->
															<input name="customfield[{$list.id}]" type="password" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if}class="form-control" placeholder="{$Lang.custom_password_box}" {$list.required ? 'required' : ''}/>
														{elseif $list.fieldtype == 'text' || $list.fieldtype == 'link'}
															<!-- 文本框、链接 -->
															<input name="customfield[{$list.id}]" type="text" class="form-control" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if} placeholder="{$list.fieldname}" {$list.required ? 'required' : ''}/>
														{elseif $list.fieldtype == 'tickbox'}
                            
															<!-- 选项框 -->
                               							<div class="custom-control custom-switch mb-3" dir="ltr">
                                                        <input type="checkbox" class="custom-control-input" name="customfield[{$list.id}]" {if(isset($_fields[$list['id']]))} checked {/if} id="customSwitchsizesm" {$list.required ? 'required' : ''}>
                                                        <label class="custom-control-label" for="customSwitchsizesm"></label>
                                                    	</div>
															<!-- <input type="checkbox" class="custom-control-input" name="customfield[{$list.id}]" {if(isset($_fields[$list['id']]))} checked {/if}>{$list.fieldname} -->
														{elseif $list.fieldtype == 'textarea'}
															<!-- 文本域 -->
															<textarea name="customfield[{$list.id}]" cols="30" rows="10" class="form-control" {$list.required ? 'required' : ''}>{if(isset($_fields[$list['id']]))} {$_fields[$list['id']]} {/if}</textarea>
														{/if}
													</div>
												{/foreach}
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">标题</label>
                <input class="mdui-textfield-input" type="text" placeholder="请概括问题" id="title" name="title" value="{$Think.get.title}" required/>
            </div>
		    <div class="mdui-textfield">
                <label class="mdui-textfield-label">内容</label>
                <textarea class="mdui-textfield-input" placeholder="请仔细描述问题，尽量提供详细的问题现象、引发方式和预期正确结果" id="content" name="content" rows="20"></textarea>
            </div>
		    
		    <hr>
		    
		    <div class="mdui-textfield">
                <label class="mdui-textfield-label">工单附件</label>
                工单附件仅支持 png jpg 等图片格式。
            </div>

			
			<div class="mdui-table-fluid">
                <table class="mdui-table mdui-table-hoverable">
                    <thead>
                    <tr>
                        <th>名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="filelist">
                        <tr>
                            <td>插入新附件</td>
                            <td><a class="mdui-btn" id="addFileBtn"><i class="mdui-icon material-icons">add_to_photos</i> 添加附件</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

			<div class="mdui-card-actions">
			    <button type="submit" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme submitBtn">
				<i class="mdui-icon material-icons">cloud_upload</i> 提交工单
    			</button>
                <a href="supporttickets" class="mdui-btn mdui-btn-raised mdui-ripple">取消提交</a>
			</div>
	</div>
</div>
</form>
<script>
  // Example starter JavaScript for disabling form submissions if there are invalid fields
  (function() {
    'use strict';
    window.addEventListener('load', function() {
      // Fetch all the forms we want to apply custom Bootstrap validation styles to
      var forms = document.getElementsByClassName('needs-validation');
      // Loop over them and prevent submission
      console.log(forms);
      var validation = Array.prototype.filter.call(forms, function(form) {
        
        form.addEventListener('submit', function(event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }else{
            // 提交按钮加载中
                // $("form").submit();
                $('.submitBtn').empty()
                $('.submitBtn').prepend(`<div class="mdui-spinner"></div> 正在提交`);
			  	$('.submitBtn').attr('disabled', true);
          }
      
          form.classList.add('was-validated');
        }, false);
      });
    },false);
  })();
  
  </script>
<script>
	$(function () {
		// 添加更多附件
		$('#addFileBtn').on('click', function () {
			var fileHtml = `
					<tr class="filebox">
                            <td><input type="file" class="form-control-file fileWacth" name="attachments[]"></td>
                            <td class="filetd"><a class="mdui-btn deletefileBtn"><i class="mdui-icon material-icons">delete</i> 删除此附件</a></td>
                        </tr>
			`
			$('#filelist').append(fileHtml)
		});

		// 删除附件
		$('#filelist').on('click', '.deletefileBtn', function () {
			$(this).hide().parent('.filetd').parent('.filebox').remove()
		});
		$('#filelist').on('change','.fileWacth',function(){
          if($(this).prop('files').length){
			$(this).next().show()									
		  }
		})										
		
	})
</script>