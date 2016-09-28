<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function () {

		$.ajax({
			type: 'get',
			contentType: 'application/json',
			url: '${pageContext.request.contextPath}/admin/role/all/list',
			processData: false,
			dataType: 'json',
			async:false,
			success: function(data) {
				//$("#role-select").empty();
				$.each(data, function (index, value) {
					$("#role-select-e").append("<option value='"+value.id+"'>"+value.description+"</option>");
				});
			},
			error: function() {
				alert('Err...');
			}
		});

		$.ajax({
			type: 'get',
			contentType: 'application/json',
			url: '${pageContext.request.contextPath}/admin/org/all/list',
			processData: false,
			dataType: 'json',
			async:false,
			success: function(data) {
				//$("#org-select").empty();
				$.each(data, function (index, value) {
					$("#org-select-e").append("<option value='"+value.id+"'>"+value.name+"</option>");
				});
			},
			error: function() {
				alert('Err...');
			}
		});
	});

	$('#org-select-e').combobox({
		onChange: function() {
			var value = $('#org-select-e').combobox('getValues');
			console.log(value);
			console.log(value.join(','));
			$('#org-select').val(value);
		}
	});

	$('#role-select-e').combobox({
		onChange: function() {
			var value = $('#role-select-e').combobox('getValues');
			console.log(value);
			console.log(value.join(','));

		}
	});

</script>

<form id="admin_user_editForm" method="post">
	<table>
		<tr>
			<th>用户名</th>
			<td><input name="username" class="easyui-validatebox" data-options="required:true" style="width: 100%" /></td>
		</tr>
		<tr>
			<th>所属组织</th>
			<td><select id="org-select-e" data-options="multiple:true,panelHeight:'auto'" class="esayui-combobox"  name="organization" style="width: 100%"></select></td>
		</tr>
		<tr>
			<th>角色列表</th>
			<td><select  id="role-select-e" data-options="multiple:true,panelHeight:'auto'" class="esayui-combobox"  name="roleIds" style="width: 100%"></select></td>
		</tr>
		<tr>
			<th>邮箱</th>
			<td><input name="email" class="easyui-validatebox" style="width: 100%"/></td>
		</tr>
		<tr>
			<th>名字</th>
			<td><input name="nickname" class="easyui-validatebox" style="width: 100%"/></td>
		</tr>
		<tr>
			<th>账户金额</th>
			<td><input name="account" class="easyui-validatebox" style="width: 100%"/></td>
		</tr>
		<tr>
			<th>是否启用</th>
			<td><input name="locked" class="easyui-validatebox" style="width: 100%"/></td>
		</tr>

		<tr align="center">

		</tr>

	</table>
	
</form>
